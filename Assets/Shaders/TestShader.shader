Shader "Custom/TestShader"
{
    Properties
    {
        _MainTex1("Main Texture", 2D) = "white" {}
        _MainTex2("Main Texture", 2D) = "white" {}
        _MaskTex("Mask Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert
        #pragma target 3.0

        sampler2D _MainTex1;
        sampler2D _MainTex2;
        sampler2D _MaskTex;

        struct Input
        {
            float2 uv_MainTex1;
            float2 uv_MainTex2;
            float2 uv_MaskTex;
        };

        fixed4 _Color;

        void surf(Input IN, inout SurfaceOutput o)
        {
            // считываем текстуры
            fixed3 masks = tex2D(_MaskTex, IN.uv_MaskTex);

            fixed3 colors = tex2D(_MainTex1, IN.uv_MainTex1) * ((1.0, 1.0, 1.0) - masks);
            colors += tex2D(_MainTex2, IN.uv_MainTex2) * masks;

            o.Albedo = colors;
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
