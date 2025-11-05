Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99678CCFA04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 02:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGTQT-00006p-Mg; Tue, 04 Nov 2025 21:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vGTQR-00006e-LJ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 21:39:08 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vGTQP-0002lG-Pc
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 21:39:07 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4KgD8T3086279
 for <qemu-devel@nongnu.org>; Wed, 5 Nov 2025 02:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/ETbt/xaGAwqObNPvgEAeAR8
 5R4jREWFHm1Wg/m+8AY=; b=pWyxYCdAZ+PmP2pWNXYNW50+rYIfxj11c8O9fkYS
 y1VbDrtsP+N6dPBIseLkRTFSm9kFe9kXa2b7uQA6M0qRkd6dBGo/Z4LcPek4hjnb
 B28aKPJyEFYzRp17KR28prtgaBnEfqjK8YixCdwmsR/YePYO+w8B62gIF8opmy0U
 rJ9y2y2XsBmvp6L7s3IRzaTIR9QNpVzXuUnUF7W+cPqlQJgck8W0bl+HE0yKkr4W
 7XnYpJ5QOx2ETRBuo8cC/ybWTiQlpu+IyFUjNGhzCqnKKWOVnquCJfBzEzIrco6x
 ws88bLV18Mdy50+kiVaGI6Y8dDY/OQi/LHxEDDKEndEgoQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a79jjus4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 02:39:02 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5dbef2bbf85so3932865137.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 18:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762310341; x=1762915141; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ETbt/xaGAwqObNPvgEAeAR85R4jREWFHm1Wg/m+8AY=;
 b=OcHCuGs8gM1pTqEKJUgcq8ir2CkNtKwYVmuvIQng2NVuddGYXKr/TOn4Gl9SeVwHfD
 t6BNiC8drwvw3fXgcOTbjO+RzxwIXCG/fz0mKe9ZxpdMW9mvlx2RuosS6UkxIWeE2fVM
 0G9tWT0vCtDjmmerZPXyEk24l1vWMivviIALcRvdFXor0G7YgcjRDZ5gEQgdwXdAZpP4
 AeisnzCRhJWohJXNuQSVhga+zvhO+uSipw7HJrV5MmC28YHWHuXjXaH9biyFKZbHXRey
 vW/DNkTkeDyUmlRjkin/wvpOVRFGMa352ZuYUo5JOBffNjHysyATRN8SsZcsbYAYTgwk
 sf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762310341; x=1762915141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ETbt/xaGAwqObNPvgEAeAR85R4jREWFHm1Wg/m+8AY=;
 b=i+9H6RXAkKpuh20KVTFVzY27QoO0y7xS+xVzyhg0gRueLL/OrCSSlSoXMvY3l6Cz0y
 vlgKraZ+rQVsSxzfQrQgEKIfMl7l+pZEZowAl4ue1WXBIvscivdkf6IYS62wCJPcA/ll
 JQv1LHAW07Fvhko8YoP5uGw1+772+A2dgFYRWKn1HGvxfxFPIZrJ2hMUEyeigU38vhOQ
 oA2wxewnMHVp96JZZ1LjCjcD+ErBMcgzj7lHQs43GAt68xArAFESj6JaM/rZYQ3ZCAJD
 TjHYJouONghDYMITyUySysQXrPAqfFjt2rxahBlHmB0UW9jhMk/uLCAKfTgO+6xNRua2
 OUxg==
X-Gm-Message-State: AOJu0YwX7yMF3D0mqhIaWorUbFme64r8ynKp3/iCp/v/1hXA/HuVtRl2
 uSnD2yVkQfOm6QbszYzB6pmFJko9wgqH9234gvWyjVc0AFP3z7naVKNZBvVuct34jmJ2hoN8+MG
 C4gTFp+bSwYNDYxptiCHtr74SMqdNbiCQHPcf/ZhVG8r6J+Nca722hzboYV50+pKuNey9Mm5zBC
 zjGV5JUSulbz6zcw5CyMJwJ4wjNMWjdKjp
X-Gm-Gg: ASbGnctkxaa1je4bh9rkFAEJtqKAl9FA7vn7pqD2qtXN0CBQIakk1UKwx12qb4hBlNc
 yC6LOBbw7cqtj6gFuM9Tb/LOQ++szgV28lip1rRSoCTMhp0e1bXvbr+Rts5GsITm3VtGOrEN+0D
 gnoyVnLCDKgg2bgrGUFiRTw1qO+8WJepHJCT5jNdmrhqFQ+mqH196Npw8+W3sSneNl0QumxagjM
 W49fMhsrRLo5g21zg==
X-Received: by 2002:a05:6102:3713:b0:5d6:27c7:e6b2 with SMTP id
 ada2fe7eead31-5dd88e88862mr690544137.3.1762310341171; 
 Tue, 04 Nov 2025 18:39:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5gXvzchZB/hAijVUx7anPp54FzX8q0icORl4okqLVn90893epRyBBkSNjeQ5t+8MUE9fZniUezeHNguIWefY=
X-Received: by 2002:a05:6102:3713:b0:5d6:27c7:e6b2 with SMTP id
 ada2fe7eead31-5dd88e88862mr690537137.3.1762310340782; Tue, 04 Nov 2025
 18:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20251104222548.108264-1-ltaylorsimpson@gmail.com>
 <20251104222548.108264-4-ltaylorsimpson@gmail.com>
In-Reply-To: <20251104222548.108264-4-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 20:38:49 -0600
X-Gm-Features: AWmQ_bk4SpjCDQCPndklAuu_q412ueKpq-nsFVP1zePhDENfWZndj7N07fLq1OY
Message-ID: <CAEqNhNa8+uyyh9ObO4TTvherZn4HQvv3GBqXdF4q048PSNqsWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Hexagon (tests/tcg/hexagon) Add test for USR
 changes in packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000d8bb6c0642cfd9df"
X-Proofpoint-GUID: HucTIfTo_Elraflf0zwvVX4a9PHgoGXW
X-Proofpoint-ORIG-GUID: HucTIfTo_Elraflf0zwvVX4a9PHgoGXW
X-Authority-Analysis: v=2.4 cv=TuPrRTXh c=1 sm=1 tr=0 ts=690ab8c6 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=84_yY5o3KLoiLSIGzrQA:9
 a=QEXdDO2ut3YA:10 a=r5dkzwHvhJxZtFKaVSsA:9 a=ztc34KS9XAsYfMoo:21
 a=lqcHg5cX4UMA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNSBTYWx0ZWRfX0SBkGwrYil4H
 H7ZOeIz10wERRE4fhpMG7UAv+oh0lxROgGHxH+rngjgYN9tm9SKiEDLIKqBjVhTG8YNmQ++rnHK
 kII+l+z4WozUVrCBEJS25/OFKJXCCAFA7J0J4rS1anTU6tG/TVf87w1Kf0eFrNtWq3ydxk8Mnte
 O8GtcW5BsVHDMf1QvzBHDCtf+I0Lp44+Urb0Qj7lyIH2RXuIQSjYr1hVE72bX7ALCKwDJFdR+xz
 JiyaTkCg0Tx0tnA2CcpPKiMZFAUQA+U7FJSYHZ/Xtg2lggSYvN8tHA1gbtgeEadptBcuFNJO84m
 N1dZg2krqGVpBOy+CRL0r8hk5JYaPWWlNAeNUMjq9f92ORGzX5NKt0ReX2cUGFnfzTcxdvbOTxs
 uS9I+sekb0Kfu4YPY8ak9m2As3ngWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050015
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000d8bb6c0642cfd9df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:25=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmail=
.com>
wrote:

> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  tests/tcg/hexagon/usr.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c
> index f0b23d312b..8becd8195d 100644
> --- a/tests/tcg/hexagon/usr.c
> +++ b/tests/tcg/hexagon/usr.c
> @@ -608,6 +608,30 @@ TEST_CMP_xx(uint32_t, uint32_t, FUNC, SRC1, SRC2,
> RES, USR_RES)
>  #define TEST_CMP_PP(FUNC, SRC1, SRC2, RES, USR_RES) \
>  TEST_CMP_xx(uint64_t, uint64_t, FUNC, SRC1, SRC2, RES, USR_RES)
>
> +static void test_usr_packets(void)
> +{
> +    uint32_t usr;
> +    /* Test setting USR bits inside and outside packets */
> +    asm(CLEAR_USRBITS \
> +        "r10 =3D satub(%1)              /* Set usr.OVF */\n\t"
> +        "{\n\t"
> +        "    r11 =3D convert_uw2sf(%4)  /* Set usr.FPINPF */\n\t"
> +        "    r10 =3D memw(%5)           /* Force pkt commit */\n\t"
> +        "}\n\t"
> +        "{\n\t"
> +        "    r11 =3D sfadd(%2, %3)      /* Set usr.FPINVF */\n\t"
> +        "    r10 =3D add(r10, #1)       /* Doesn't force pkt commit */\n=
\t"
> +        "}\n\t"
> +        "%0 =3D usr\n\t"
> +        : "=3Dr"(usr)
> +        : "r"(0xfff),
> +          "r"(SF_one), "r"(SF_SNaN),
> +          "r"(0x010020a5),
> +          "m"(err)
> +        : "r2", "r10", "r11", "usr");
>

For the inline asm, how about using the symbolic/named operands instead of
the enumerated ones?  Should be easier to read.

Something like:

    uint32_t usr;
    /* Test setting USR bits inside and outside packets */
    asm(CLEAR_USRBITS
        "r10 =3D satub(%[val])              /* Set usr.OVF */\n\t"
        "{\n\t"
        "    r11 =3D convert_uw2sf(%[fp_input])  /* Set usr.FPINPF */\n\t"
        "    r10 =3D memw(%[err_mem])           /* Force pkt commit */\n\t"
        "}\n\t"
        "{\n\t"
        "    r11 =3D sfadd(%[sf_one], %[sf_snan])  /* Set usr.FPINVF */\n\t=
"
        "    r10 =3D add(r10, #1)                 /* Doesn't force pkt comm=
it
*/\n\t"
        "}\n\t"
        "%[usr_out] =3D usr\n\t"
        : [usr_out] "=3Dr" (usr)
        : [val] "r" (0xfff),
          [sf_one] "r" (SF_one),
          [sf_snan] "r" (SF_SNaN),
          [fp_input] "r" (0x010020a5),
          [err_mem] "m" (err)
        : "r2", "r10", "r11", "usr");




> +    check32(usr & 0x3f, USR_OVF | USR_FPINVF | USR_FPINPF);
> +}
> +
>  int main()
>  {
>      TEST_R_OP_R(satub,       0,         0,         USR_CLEAR);
> @@ -1097,6 +1121,8 @@ int main()
>      TEST_Rp_OP_R(sfinvsqrta, SF_small_neg,  SF_HEX_NaN,       0x00,
> USR_FPINVF);
>      TEST_Rp_OP_R(sfinvsqrta, SF_SNaN,       SF_HEX_NaN,       0x00,
> USR_FPINVF);
>
> +    test_usr_packets();
> +
>      puts(err ? "FAIL" : "PASS");
>      return err;
>  }
> --
> 2.43.0
>
>

--000000000000d8bb6c0642cfd9df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 4, =
2025 at 4:25=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson=
@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Signed-off-by: Taylor Simpson &lt;<a hr=
ef=3D"mailto:ltaylorsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@gma=
il.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/usr.c | 26 ++++++++++++++++++++++++++<br>
=C2=A01 file changed, 26 insertions(+)<br>
<br>
diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c<br>
index f0b23d312b..8becd8195d 100644<br>
--- a/tests/tcg/hexagon/usr.c<br>
+++ b/tests/tcg/hexagon/usr.c<br>
@@ -608,6 +608,30 @@ TEST_CMP_xx(uint32_t, uint32_t, FUNC, SRC1, SRC2, RES,=
 USR_RES)<br>
=C2=A0#define TEST_CMP_PP(FUNC, SRC1, SRC2, RES, USR_RES) \<br>
=C2=A0TEST_CMP_xx(uint64_t, uint64_t, FUNC, SRC1, SRC2, RES, USR_RES)<br>
<br>
+static void test_usr_packets(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t usr;<br>
+=C2=A0 =C2=A0 /* Test setting USR bits inside and outside packets */<br>
+=C2=A0 =C2=A0 asm(CLEAR_USRBITS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r10 =3D satub(%1)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set usr.OVF */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r11 =3D convert_uw2sf(%4)=
=C2=A0 /* Set usr.FPINPF */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r10 =3D memw(%5)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Force pkt commit */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r11 =3D sfadd(%2, %3)=C2=
=A0 =C2=A0 =C2=A0 /* Set usr.FPINVF */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r10 =3D add(r10, #1)=C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* Doesn&#39;t force pkt commit */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%0 =3D usr\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;=3Dr&quot;(usr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r&quot;(0xfff),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r&quot;(SF_one), &quot;r&quot;(SF=
_SNaN),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r&quot;(0x010020a5),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;m&quot;(err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r2&quot;, &quot;r10&quot;, &quot;r11&q=
uot;, &quot;usr&quot;);<br></blockquote><div><br></div><div>For the inline =
asm, how about using the symbolic/named operands instead of the enumerated =
ones?=C2=A0 Should be easier to read.</div><div><br></div><div>Something li=
ke:</div><div><br></div><div>=C2=A0 =C2=A0 uint32_t usr;<br>=C2=A0 =C2=A0 /=
* Test setting USR bits inside and outside packets */<br>=C2=A0 =C2=A0 asm(=
CLEAR_USRBITS<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r10 =3D satub(%[val]) =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set usr.OVF */\n\t&quot;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot; =C2=A0 =C2=A0r11 =3D convert_uw2sf(%[fp_input]) =C2=A0/* Set =
usr.FPINPF */\n\t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; =C2=A0 =C2=A0=
r10 =3D memw(%[err_mem]) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Force pkt co=
mmit */\n\t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n\t&quot;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot; =C2=A0 =C2=A0r11 =3D sfadd(%[sf_one], %[sf_snan]) =C2=A0/* Set usr.FP=
INVF */\n\t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; =C2=A0 =C2=A0r10 =
=3D add(r10, #1) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Doesn&#39;t force pkt commit */\n\t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;}\n\t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[usr_out] =3D usr\n\=
t&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [usr_out] &quot;=3Dr&quot; (usr)<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [val] &quot;r&quot; (0xfff),<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [sf_one] &quot;r&quot; (SF_one),<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 [sf_snan] &quot;r&quot; (SF_SNaN),<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 [fp_input] &quot;r&quot; (0x010020a5),<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [err_mem] &quot;m&quot; (err)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 : &quot;r2&quot;, &quot;r10&quot;, &quot;r11&quot;, &quot;usr&qu=
ot;);<br></div><div><br></div><div><br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 check32(usr &amp; 0x3f, USR_OVF | USR_FPINVF | USR_FPINPF);<=
br>
+}<br>
+<br>
=C2=A0int main()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TEST_R_OP_R(satub,=C2=A0 =C2=A0 =C2=A0 =C2=A00,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USR_CLEAR);<=
br>
@@ -1097,6 +1121,8 @@ int main()<br>
=C2=A0 =C2=A0 =C2=A0TEST_Rp_OP_R(sfinvsqrta, SF_small_neg,=C2=A0 SF_HEX_NaN=
,=C2=A0 =C2=A0 =C2=A0 =C2=A00x00, USR_FPINVF);<br>
=C2=A0 =C2=A0 =C2=A0TEST_Rp_OP_R(sfinvsqrta, SF_SNaN,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0SF_HEX_NaN,=C2=A0 =C2=A0 =C2=A0 =C2=A00x00, USR_FPINVF);<br>
<br>
+=C2=A0 =C2=A0 test_usr_packets();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
=C2=A0 =C2=A0 =C2=A0return err;<br>
=C2=A0}<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000d8bb6c0642cfd9df--

