Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCDBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 01:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGpC5-0005Wu-Ji; Wed, 05 Nov 2025 20:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vGpC1-0005Wc-1W
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 20:53:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vGpBz-000231-0o
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 20:53:40 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A5KFUlR1726766
 for <qemu-devel@nongnu.org>; Thu, 6 Nov 2025 01:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=75Vnj5nF6T/S8UkfDh5FRd77
 2W3WLJOyW0ybYt/7l/w=; b=iQf7dWXUktOET0NGJ+qoXXqzYKiFD1WB6pS/qsBk
 P3/1VDhVWqRIJ0h1PLAdQ27FTglWLaX+ztgkwR8OwxM9inzsbaI6QvGEYfeeL8ah
 2d0glgsG/UuaVB45wprQpOw4LqxvFpRLYxKCBxC7Ank7NTnPMq5UznwJJS53G4Rd
 LJCNbsqvEIbIOmWqxevFLEBYjTf1egGf22j/nCssY40aAPhAUaG+h9kzPpM7NXBY
 ZysDFelhUhYpcOVyzDF5QeeCPsuGS8SMr2Kb80hLcKJBrv764VhEBPIPi37oEb0Y
 z29/XM2EyybkEZz4csOXrxNqEdsvxdlx38dT11ArNOEc+Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a82mt2x2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 01:53:36 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-5b736eca1c7so840244137.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 17:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762394015; x=1762998815; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=75Vnj5nF6T/S8UkfDh5FRd772W3WLJOyW0ybYt/7l/w=;
 b=cCHS7SnxiXJwtLW3gUJ7V4qtcV9MaQx9Rhr7722efd87PZTemS1ZlGfIiOXbFkdwMt
 BX+/82fO2o1aDSmG33vYPbM3obIOSk0tfRAr4fkieMtOtHMclIQXtu8wsAvgI0gge8HA
 d6sVqM5GKOV++XY0l1CVyMRvYk01Od+5rCoPFALghCtL/CGx0m82fjzJu2C4NIH8AjTI
 dV1PT6FE/dB8gRwEs5M8YHSPvxVeFi3pIbzYpu1AIgloTqPMODFoJ1qAqQiiNAVNgz6J
 IE6vHokAc40fsDIHY5eEF7C5WaPazg8L7dH+hY9nu9ZHxAZjg655TmxbvsfU10NMGoaS
 exjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762394015; x=1762998815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=75Vnj5nF6T/S8UkfDh5FRd772W3WLJOyW0ybYt/7l/w=;
 b=vjDHNETtsUnmIWnvH2cUd1kzEzTeKVYrm332/wDd325Ags+QmlAUZdNHh1Ktme38xI
 VRiep9gyrdmrIWChl4k0rcga/I4X8ZDZvadkdhQ1w1NMJTbkkd5XhTOIPDBVDsIFmrgd
 RexUOrfy3plAdcs+OkDLaJlfkQtn1tmhUgMfwcQd2cfHryq6lKuvvTs8PjpdesW5yHnJ
 Dhh3/c1hongl4NIHPK+bL7zsVjJ73D2e2EZuyv4qkbaTaXutMX610a0rFmgXJAL68ZB+
 Y4/5nUY2U2flVe3X27fZi8f0+qEa8MFwvUauzgAuqNPvELbIbZ/oyAUrRhBp8moX57I7
 RRzA==
X-Gm-Message-State: AOJu0YyudyS1zeBTlhHVYeuIoWoLQeoyKQxVBcK9M2WkP9dLISLFmEza
 a7H9b9Le86rpqS5rmt2NaivjEG5ZzZhC7WBd12jCOvOa0HJjN3MbvX1SXDuiGIWLs7mqqfod/00
 3zo8Go75sCQrCejQSNzljl7ac89nCZHN4QyqSh13MGstvL+bkIU8QDwNBAEjCVP3SLx9rW2RiTN
 LgYEcVtbm95okYmb93tyqn3U28awHdUmTp
X-Gm-Gg: ASbGnct1b/5Dj58QxHiIFSjNTGor8xdL3EYSD4u73EELljo6CH9koiX2O53frH6yUme
 30Y2R8MJU6pVw318WIjzDS4XJXb/YjPB+ZQBUL6Qz4IWSCzsGOso5nGnB+cOW33VagZUBJdwHv4
 la5prr+B4A4RnT58BR4JJQtiJ3zvDGPJTrgGlTLKqa6mRiDBFZIFDf8+QDn2VtWXEWaJ0hutNBI
 ya8tp68+cgd6Q2EoQ==
X-Received: by 2002:a05:6102:3913:b0:5d5:f79b:e93b with SMTP id
 ada2fe7eead31-5dd891eb177mr2312735137.32.1762394015422; 
 Wed, 05 Nov 2025 17:53:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhu0Qud9+p8HbQUYfOnnKaJLBOZCqsYn5jnSCu+boo1qp3Etbf0SNKDoiQD84LZGMooSbPzuaTEQ1QgfCvdlE=
X-Received: by 2002:a05:6102:3913:b0:5d5:f79b:e93b with SMTP id
 ada2fe7eead31-5dd891eb177mr2312724137.32.1762394014914; Wed, 05 Nov 2025
 17:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
 <20251105212554.127017-4-ltaylorsimpson@gmail.com>
In-Reply-To: <20251105212554.127017-4-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 19:53:24 -0600
X-Gm-Features: AWmQ_bkhvIizDYOHHnJX013P5iFNcVD6CHJS4Z_AE2GaF6IfNHbjODuLrSgM3J0
Message-ID: <CAEqNhNbsXjZHwTOSMVSVX1mP0kFogT0PAaWy-qPXPyEXGjHtJg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Hexagon (tests/tcg/hexagon) Add test for USR
 changes in packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="00000000000036a9b50642e355ba"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxNCBTYWx0ZWRfXyQ40zMBCZOk3
 9HiKHND7siYEyRzjx6BOPpuyzA4y5iyN4swXYPqmtFPd4t7Nr5c+RI67NqvdPLHZgaiSu+EpPcU
 6Xsvel1akYk8FA/Tygi+XwzK8ThUVg1BhnVJGW8+4hCmC8/RYkkW8RLeClSwbCaBcOIghNJ17uD
 KUT3BuFJz5mD65D8PnaktsZV9+6X/4WtxrcOpNoxIuD/UL+gQQ4rIcWxSgJhzokwythJz0kEReo
 M8udApe+SsHyuMCfFROeEfhd+Woq0JS/0TK398wR9mR5rBM4FMmEBvu5IHCue7ttG5p4s0cUZsX
 PTx5tdQ5nVlcLYBTiXpOryCMp95KfuuSti4UrlafW/CE1e1fmbXCn2kJDKZtGOt2mv2wi1X20vK
 ms868EnTW1Per098T/H3A/1w6r4/BQ==
X-Proofpoint-GUID: zLVpdthLmIlNVVbWcsrX4iqIQbwXOktp
X-Authority-Analysis: v=2.4 cv=LLtrgZW9 c=1 sm=1 tr=0 ts=690bffa0 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=XjY1MN0gPw5wHsYsS9MA:9 a=QEXdDO2ut3YA:10 a=GHvY5Ttzp4-mifQX6oYA:9
 a=b30wk7Iho03O0O3t:21 a=lqcHg5cX4UMA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: zLVpdthLmIlNVVbWcsrX4iqIQbwXOktp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060014
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000036a9b50642e355ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:26=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmail=
.com>
wrote:

> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



>  tests/tcg/hexagon/usr.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c
> index f0b23d312b..ef1787c64c 100644
> --- a/tests/tcg/hexagon/usr.c
> +++ b/tests/tcg/hexagon/usr.c
> @@ -608,6 +608,58 @@ TEST_CMP_xx(uint32_t, uint32_t, FUNC, SRC1, SRC2,
> RES, USR_RES)
>  #define TEST_CMP_PP(FUNC, SRC1, SRC2, RES, USR_RES) \
>  TEST_CMP_xx(uint64_t, uint64_t, FUNC, SRC1, SRC2, RES, USR_RES)
>
> +static void test_usr_packets(void)
> +{
> +    uint32_t usr_out;
> +    /* Test setting USR bits inside and outside packets */
> +    asm(CLEAR_USRBITS \
> +        "r10 =3D satub(%[val_0xfff])                   /* Set usr.OVF
> */\n\t"
> +        "{\n\t"
> +        "    r11 =3D convert_uw2sf(%[val_0x010020a5])  /* Set usr.FPINPF
> */\n\t"
> +        "    r10 =3D memw(%[err])                      /* Force pkt comm=
it
> */\n\t"
> +        "}\n\t"
> +        "{\n\t"
> +        "    r11 =3D sfadd(%[SF_one], %[SF_SNaN])      /* Set usr.FPINVF
> */\n\t"
> +        "    r10 =3D add(r10, #1)                      /* No pkt commit
> */\n\t"
> +        "}\n\t"
> +        "%[usr_out] =3D usr\n\t"
> +        : [usr_out]"=3Dr"(usr_out)
> +        : [val_0xfff]"r"(0xfff),
> +          [SF_one]"r"(SF_one), [SF_SNaN]"r"(SF_SNaN),
> +          [val_0x010020a5]"r"(0x010020a5),
> +          [err]"m"(err)
> +        : "r2", "r10", "r11", "usr");
> +    check32(usr_out & 0x3f, USR_OVF | USR_FPINVF | USR_FPINPF);
> +
> +    /* Test setting several USR bits in the same packet (no pkt commit) =
*/
> +    asm(CLEAR_USRBITS \
> +        "{\n\t"
> +        "    r10 =3D satub(%[val_0xfff])               /* Set usr.OVF
> */\n\t"
> +        "    r12 =3D sfadd(%[SF_one], %[SF_SNaN])      /* Set usr.FPINVF
> */\n\t"
> +        "}\n\t"
> +        "%[usr_out] =3D usr\n\t"
> +        : [usr_out]"=3Dr"(usr_out)
> +        : [val_0xfff]"r"(0xfff),
> +          [SF_one]"r"(SF_one), [SF_SNaN]"r"(SF_SNaN)
> +        : "r2", "r10", "r11", "r12", "usr");
> +    check32(usr_out & 0x3f, USR_OVF | USR_FPINVF);
> +
> +    /* Test setting several USR bits in the same packet (with pkt commit=
)
> */
> +    asm(CLEAR_USRBITS \
> +        "{\n\t"
> +        "    r10 =3D satub(%[val_0xfff])               /* Set usr.OVF
> */\n\t"
> +        "    r11 =3D convert_uw2sf(%[val_0x010020a5])  /* Set usr.FPINPF
> */\n\t"
> +        "    r12 =3D memw(%[err])                      /* Force pkt comm=
it
> */\n\t"
> +        "}\n\t"
> +        "%[usr_out] =3D usr\n\t"
> +        : [usr_out]"=3Dr"(usr_out)
> +        : [val_0xfff]"r"(0xfff),
> +          [val_0x010020a5]"r"(0x010020a5),
> +          [err]"m"(err)
> +        : "r2", "r10", "r11", "r12", "usr");
> +    check32(usr_out & 0x3f, USR_OVF | USR_FPINPF);
> +}
> +
>  int main()
>  {
>      TEST_R_OP_R(satub,       0,         0,         USR_CLEAR);
> @@ -1097,6 +1149,8 @@ int main()
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

--00000000000036a9b50642e355ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 5, =
2025 at 3:26=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson=
@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Signed-off-by: Taylor Simpson &lt;<a hr=
ef=3D"mailto:ltaylorsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@gma=
il.com</a>&gt;<br>
---<br></blockquote><div><br></div><div class=3D"gmail-gs" style=3D"margin:=
0px;min-width:0px;padding:0px 0px 20px;width:auto;font-family:&quot;Google =
Sans&quot;,Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:medium">=
<div class=3D"gmail-"><div id=3D"gmail-:2xw" class=3D"gmail-ii gmail-gt gma=
il-adO" style=3D"direction:ltr;margin:8px 0px 0px;padding:0px;font-size:0.8=
75rem;overflow-x:hidden"><div id=3D"gmail-:2xv" class=3D"gmail-a3s gmail-ai=
L" style=3D"direction:ltr;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-variant-alternates:normal;font-size-adjust:none;font-kerning=
:auto;font-feature-settings:normal;font-stretch:normal;font-size:small;line=
-height:1.5;font-family:Arial,Helvetica,sans-serif;overflow:auto hidden"><d=
iv><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>Review=
ed-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com" target=
=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;</div></div></div></div></di=
v></div></div><div class=3D"gmail-WhmR8e" id=3D"gmail-avWBGd-559" style=3D"=
clear:both"></div></div></div><br class=3D"gmail-Apple-interchange-newline"=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0tests/tcg/hexagon/usr.c | 54 ++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 54 insertions(+)<br>
<br>
diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c<br>
index f0b23d312b..ef1787c64c 100644<br>
--- a/tests/tcg/hexagon/usr.c<br>
+++ b/tests/tcg/hexagon/usr.c<br>
@@ -608,6 +608,58 @@ TEST_CMP_xx(uint32_t, uint32_t, FUNC, SRC1, SRC2, RES,=
 USR_RES)<br>
=C2=A0#define TEST_CMP_PP(FUNC, SRC1, SRC2, RES, USR_RES) \<br>
=C2=A0TEST_CMP_xx(uint64_t, uint64_t, FUNC, SRC1, SRC2, RES, USR_RES)<br>
<br>
+static void test_usr_packets(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t usr_out;<br>
+=C2=A0 =C2=A0 /* Test setting USR bits inside and outside packets */<br>
+=C2=A0 =C2=A0 asm(CLEAR_USRBITS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;r10 =3D satub(%[val_0xfff])=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set usr.OVF */\n=
\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r11 =3D convert_uw2sf(%[va=
l_0x010020a5])=C2=A0 /* Set usr.FPINPF */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r10 =3D memw(%[err])=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* F=
orce pkt commit */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r11 =3D sfadd(%[SF_one], %=
[SF_SNaN])=C2=A0 =C2=A0 =C2=A0 /* Set usr.FPINVF */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r10 =3D add(r10, #1)=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* N=
o pkt commit */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[usr_out] =3D usr\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [usr_out]&quot;=3Dr&quot;(usr_out)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [val_0xfff]&quot;r&quot;(0xfff),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [SF_one]&quot;r&quot;(SF_one), [SF_SNaN=
]&quot;r&quot;(SF_SNaN),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [val_0x010020a5]&quot;r&quot;(0x010020a=
5),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [err]&quot;m&quot;(err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r2&quot;, &quot;r10&quot;, &quot;r11&q=
uot;, &quot;usr&quot;);<br>
+=C2=A0 =C2=A0 check32(usr_out &amp; 0x3f, USR_OVF | USR_FPINVF | USR_FPINP=
F);<br>
+<br>
+=C2=A0 =C2=A0 /* Test setting several USR bits in the same packet (no pkt =
commit) */<br>
+=C2=A0 =C2=A0 asm(CLEAR_USRBITS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r10 =3D satub(%[val_0xfff]=
)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set usr.OVF */\n=
\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r12 =3D sfadd(%[SF_one], %=
[SF_SNaN])=C2=A0 =C2=A0 =C2=A0 /* Set usr.FPINVF */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[usr_out] =3D usr\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [usr_out]&quot;=3Dr&quot;(usr_out)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [val_0xfff]&quot;r&quot;(0xfff),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [SF_one]&quot;r&quot;(SF_one), [SF_SNaN=
]&quot;r&quot;(SF_SNaN)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r2&quot;, &quot;r10&quot;, &quot;r11&q=
uot;, &quot;r12&quot;, &quot;usr&quot;);<br>
+=C2=A0 =C2=A0 check32(usr_out &amp; 0x3f, USR_OVF | USR_FPINVF);<br>
+<br>
+=C2=A0 =C2=A0 /* Test setting several USR bits in the same packet (with pk=
t commit) */<br>
+=C2=A0 =C2=A0 asm(CLEAR_USRBITS \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r10 =3D satub(%[val_0xfff]=
)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set usr.OVF */\n=
\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r11 =3D convert_uw2sf(%[va=
l_0x010020a5])=C2=A0 /* Set usr.FPINPF */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 r12 =3D memw(%[err])=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* F=
orce pkt commit */\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;}\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%[usr_out] =3D usr\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [usr_out]&quot;=3Dr&quot;(usr_out)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : [val_0xfff]&quot;r&quot;(0xfff),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [val_0x010020a5]&quot;r&quot;(0x010020a=
5),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [err]&quot;m&quot;(err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 : &quot;r2&quot;, &quot;r10&quot;, &quot;r11&q=
uot;, &quot;r12&quot;, &quot;usr&quot;);<br>
+=C2=A0 =C2=A0 check32(usr_out &amp; 0x3f, USR_OVF | USR_FPINPF);<br>
+}<br>
+<br>
=C2=A0int main()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TEST_R_OP_R(satub,=C2=A0 =C2=A0 =C2=A0 =C2=A00,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USR_CLEAR);<=
br>
@@ -1097,6 +1149,8 @@ int main()<br>
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

--00000000000036a9b50642e355ba--

