Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682ACF433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDEtl-0003zm-3s; Thu, 16 Apr 2026 01:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDEtk-0003zL-5S
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:04:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDEth-0004uS-TJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:04:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G225k34053063
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 05:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GMxyiV/PZygiq6wISu+Jmg0+wVPYaJsZNJRUm0FNLOY=; b=AjKWh3Il0hAWIDLw
 An2jjsYtvbDC1RGzj9uembvSYZWOy8SivGmWeo3Ii8PfOE8yEOFQZzfi2tsvt/Xy
 0CKmMIJVd6sIZfNCJFROGEd3B8MvTElHSh/lTsV19grNV0a2mV4XgxQZaGGc+72N
 Qb3i/FAEY1xoiuOPe6dNOmk6p93+r2bDqI2lwEMgGQM3jryWNzviWXDOMmEUTWKv
 RR5ErHTZVs2dN6LNodoDYAPoAHIswErHvhAKFT/c4SeAxkgUVCnGlY9XMDkWycCR
 iEQreg3X8nNQWnSJJ6vDc759hf1MMaShdvnhuOYI6Z3dyIbdA6+RnMIzqLfmagmL
 MRSncw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj7s5ujhh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 05:04:11 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c628ec8d9so4093685c88.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776315851; cv=none;
 d=google.com; s=arc-20240605;
 b=Fib19KFd07eZ/xanUkqVPMQ8KVP+inZ9FPSURqXUlK4X5QXtG0F1n13lohy8fndtzr
 bOEJWnIX/MIdWRcV/6C2Mnm9WI8769RjKCkeYQQuZHhDHCr/1YjM8AKiCWoXIkFwZGYt
 gyjlx/pdC6onKBLARQ2eQ0I5fGEdMmp8l+c/3KUsamC13JZ541DEBp/A+CokywnzLfaQ
 6a9CLqzqX/mF9AEAJqgQaHiOA6chJqIuKwwBY86rXMWGtkq8Wy5iZBEoHXyiws9K+ZSv
 2egnDWk1EkP4w34abkxHloCBv4ZDNZY0vXy6egYyzAWXY5Iwh8Bf2sX7CWhvHc4MKatp
 o5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GMxyiV/PZygiq6wISu+Jmg0+wVPYaJsZNJRUm0FNLOY=;
 fh=bd4NqF8mWkw5BKad7KyyuY5CBD+jIgRsk3tsaCztl6A=;
 b=aSGR5irzOAyBVRVgzSqDmD+PS2e5aT9QHnoLOyjYI4c0GZQsUeJm/etIvk/i/tIz7b
 eLZlAUqAzQvwW6JpAKqe1aBk18qtyl3W3tosajrVvecRY4oazs8KlPwepAVmtz/g6ZFs
 HeI4EZgl7v5g9XoLvTQ3Brl1JrCD8CgV1uKpkNmgrAzFkOmEYx7CCJiKKLPry420fc/T
 +UL7unCC45nixG8FBGQH5Is2cwv+QTlZhmwBQwMFKlkC3nF9D9uAV4c9/yl8zYf8eJ3i
 rvFZepFUgi7gzt03AtxJfz7wFDWg8usrvPy2z+4WtRO0i6aOfdqpfHGes9dksU36OKlk
 Rgpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776315851; x=1776920651; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMxyiV/PZygiq6wISu+Jmg0+wVPYaJsZNJRUm0FNLOY=;
 b=NCjA7K94fWaORDCDdKwkIsi8G/xhtTX24yl1BqXFl9a5q6GNBVtGzi19nHl6r4tRYn
 ctPuiIdEw79iqWH3+75y66rGI99qYYzCy22huChigh7eF0ZJipJo4UV3AkHjD5r2Xnxj
 DMe7AJBkxfTVyD7w8GQffVSF9zGAec02F8rMHA055ppkn5/CGzuYZz4TvO2MXWwHjZwi
 5HwRRaNSOuOYuvWI7LW9MkV8qH6TyU17mmFxadf0K1u+JBtdOjmUMAyGD6x0rCqLX85E
 LFl35P0vwC+pLzR/MLsAVgLiddxV6Oqsx34miQDCK3/tgIEZVCU0HzMEM4s+csak+IbO
 ja0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776315851; x=1776920651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GMxyiV/PZygiq6wISu+Jmg0+wVPYaJsZNJRUm0FNLOY=;
 b=NsI37d2sLi3nrnyjkjsNqaecCbacYM2EyfUhMBkYM32Uu6u30ESrUY6j1MYwyDvELd
 JbgT3wHzExH7EjPHVkuK6DsNsEEDxzuDq4iHNAf0UpQ5nyanNNRF3dAKbaMJRWzkClWM
 5heX/LTlDUQ1EWj/hYzXT3ySrlI+f79JjHXePUmL1MX2z+ypMZcOBmYPiND1VZYEsIDR
 jYuVKWV+iOZKhWrZxgDyI82SDEjd+Y3xAT9FcHWF0TQix7uYf96MHJDYdnXmFINgOjUw
 G5ggQ8loufqlWm/Y17aAQCvhSs0zD67MY98N35pIFDXJJ9be2hzmoVtarZaxAyG4mgD+
 7YSA==
X-Gm-Message-State: AOJu0Yzwn0u4BGpbzg3OFyWjXsVe6RbfAJO9bslLZyKfcv1hsXIV146K
 7hjwb6DEl6n4AZt3y1a6KaY5MsdNjFl8cz0Qa0JBtpSJ/B0XCdK8qWrcXD858O/U2lH2WZgEDCw
 D7eWeH8ky8hgO9fC0YsS9yKfvzykVJxCmG1if5QRzaddkYm1t3QVz9P5L9OWs3KGWAbbVVIvHkh
 INUe+BYblcDVzwEslDeq8pz8nOtooXqsmt
X-Gm-Gg: AeBDieuznA/ElVfS1SgiYjjMKEPHK9qpmf3xlg76odehLiguFEESTbbViAtLigb6MeM
 8pNuhZY+zz+GfikRycXZXVsCrXF4zUtGv4YhoFvo37WTUbPxEmLETru/LY3XRTxM59HBO4o1HGs
 f5zu7bzVjTdL32Pn4UJRQaUrzOe8ZW8yq/mKSHBPKoKkQNjxOelKLGl/ZDh6HW2sd5cqZq17M3N
 2S3Jrs=
X-Received: by 2002:a05:7022:389:b0:124:9acd:328d with SMTP id
 a92af1059eb24-12c34eedc50mr14026247c88.22.1776315850966; 
 Wed, 15 Apr 2026 22:04:10 -0700 (PDT)
X-Received: by 2002:a05:7022:389:b0:124:9acd:328d with SMTP id
 a92af1059eb24-12c34eedc50mr14026232c88.22.1776315850295; Wed, 15 Apr 2026
 22:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
 <10ebb63b81a7dc4c8e1649788ba3b1c19806c052.1775843299.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <10ebb63b81a7dc4c8e1649788ba3b1c19806c052.1775843299.git.matheus.bernardino@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 00:03:54 -0500
X-Gm-Features: AQROBzCaX9-dgH8tjv5TdglDwm2RW-fb5co4qiF92cGeUB3pUJ-kpBPu0L3iuNc
Message-ID: <CAEqNhNYjj2mQEgYxO29gCGsLpEMBe_KX_EQ4vQLCHESC12F=ng@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] tests/hexagon: add tests for HVX bfloat
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=A7Zc+aWG c=1 sm=1 tr=0 ts=69e06dcb cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=0CYC0tZU_fdN2IhTNm0A:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: I0KiWie-yCRB_b5gVKgpBHPK4BJasKQ3
X-Proofpoint-GUID: I0KiWie-yCRB_b5gVKgpBHPK4BJasKQ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA0NSBTYWx0ZWRfXxotxTnfod32P
 qytyo0PiJHZFCQI0ET2eRMydJhV6Y8Px4s1sFlblXNs9Eg1iLPRjo3SEQV9hDehqTLMoMaeOQC6
 BTKT+PoQ2VHL7WrWYmxIT53JKyOdmXnyKcAOLX7n352B6CKsYjcoUidMuB3bG4KKVmRkU/M+mC7
 2n7GP9AWGftiZEdLpkkfSsc4JBhx8WCvsYcWcvq3icMt1U25ujKER4Vm9qqEoSgy+dwIF7tKQrl
 XZgq1PMppiQKfI3jcAw28SwjF/duw1BnEpvc+HcXabrbardZ/iTJx5NA/1tgBsfqCyzXnWaNU7J
 N28qEh3cplcqFHgCSrDy+Zi7DNWVL2oah+PFepRoZbusSzDKm1sD8urYFHuiKP/aMwuH+7BD7zH
 c9X2x5aytN2GfXRlJ7UrxtTSySuIb9lNVu/lBfg7R1r/Q7/kUp4sOGKabMCr1JEe897/HonfZ96
 Nzri0sfwZf3dLPb6AbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160045
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 10, 2026 at 12:56=E2=80=AFPM Matheus Tavares Bernardino
<matheus.bernardino@oss.qualcomm.com> wrote:
>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcom=
m.com>
> ---
>  tests/tcg/hexagon/hex_test.h   | 13 +++++++++
>  tests/tcg/hexagon/hvx_misc.h   | 30 ++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx.c     | 41 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx_cmp.c | 51 ++++++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx_cvt.c | 31 +++++++++++++++++++++
>  5 files changed, 166 insertions(+)
>
> diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
> index 79d30ec61c..f86e6e1a69 100644
> --- a/tests/tcg/hexagon/hex_test.h
> +++ b/tests/tcg/hexagon/hex_test.h
> @@ -126,6 +126,19 @@ const uint16_t HF_small_neg =3D 0x8010;
>  const uint16_t HF_any =3D 0x3c00;
>  const uint16_t HF_neg_two =3D 0xc000;
>
> +const uint16_t BF_INF           =3D 0x7f80;
> +const uint16_t BF_INF_neg       =3D 0xff80;
> +const uint16_t BF_QNaN          =3D 0x7fc0;
> +const uint16_t BF_SNaN          =3D 0x7f81;
> +const uint16_t BF_QNaN_neg      =3D 0xffc0;
> +const uint16_t BF_SNaN_neg      =3D 0xff81;
> +const uint16_t BF_HEX_NaN       =3D 0x7fff;
> +const uint16_t BF_zero          =3D 0x0000;
> +const uint16_t BF_zero_neg      =3D 0x8000;
> +const uint16_t BF_one           =3D 0x3f80;
> +const uint16_t BF_two           =3D 0x4000;
> +const uint16_t BF_four          =3D 0x4080;
> +
>  const uint32_t SF_INF =3D              0x7f800000;
>  const uint32_t SF_INF_neg =3D          0xff800000;
>  const uint32_t SF_QNaN =3D             0x7fc00000;
> diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
> index 43de20da6a..c21ea975c1 100644
> --- a/tests/tcg/hexagon/hvx_misc.h
> +++ b/tests/tcg/hexagon/hvx_misc.h
> @@ -41,6 +41,7 @@ typedef union {
>      uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
>      uint16_t hf[MAX_VEC_SIZE_BYTES / 2]; /* convenience alias */
>      int16_t   h[MAX_VEC_SIZE_BYTES / 2];
> +    uint16_t  bf[MAX_VEC_SIZE_BYTES / 2];
>      uint8_t  ub[MAX_VEC_SIZE_BYTES / 1];
>      int8_t    b[MAX_VEC_SIZE_BYTES / 1];
>  } MMVector;
> @@ -73,6 +74,7 @@ CHECK_OUTPUT_FUNC(uh, 2)
>  CHECK_OUTPUT_FUNC(hf, 2)
>  CHECK_OUTPUT_FUNC(ub,  1)
>  CHECK_OUTPUT_FUNC(b,  1)
> +CHECK_OUTPUT_FUNC(bf,  2)
>
>  static inline void init_buffers(void)
>  {
> @@ -97,6 +99,12 @@ static const uint32_t FP_VALUES[] =3D {
>  };
>  #define FP_VALUES_MAX ARRAY_SIZE(FP_VALUES)
>
> +static const uint16_t BF_VALUES[] =3D {
> +    BF_INF, BF_INF_neg, BF_QNaN, BF_SNaN, BF_QNaN_neg, BF_SNaN_neg,
> +    BF_HEX_NaN, BF_zero, BF_zero_neg, BF_one, BF_two, BF_four,
> +};
> +#define BF_VALUES_MAX ARRAY_SIZE(BF_VALUES)
> +
>  static inline void init_buffers_fp(void)
>  {
>      _Static_assert(BUFSIZE * (MAX_VEC_SIZE_BYTES / 4) >
> @@ -116,6 +124,25 @@ static inline void init_buffers_fp(void)
>      }
>  }
>
> +static inline void init_buffers_bf(void)
> +{
> +    _Static_assert(BUFSIZE * (MAX_VEC_SIZE_BYTES / 2) >
> +                   BF_VALUES_MAX * BF_VALUES_MAX,
> +                   "test arrays can't fit all BF_VALUES combinations");
> +    int counter1 =3D 0, counter2 =3D 0;
> +    for (int i =3D 0; i < BUFSIZE; i++) {
> +        for (int j =3D 0; j < MAX_VEC_SIZE_BYTES / 2; j++) {
> +            buffer0[i].bf[j] =3D BF_VALUES[counter1];
> +            buffer1[i].bf[j] =3D BF_VALUES[counter2];
> +            counter2++;
> +            if (counter2 =3D=3D BF_VALUES_MAX) {
> +                counter2 =3D 0;
> +                counter1 =3D (counter1 + 1) % BF_VALUES_MAX;
> +            }
> +        }
> +    }
> +}
> +
>  #define VEC_OP1(ASM, EL, IN, OUT) \
>      asm("v2 =3D vmem(%0 + #0)\n\t" \
>          "v2" #EL " =3D " #ASM "(v2" #EL ")\n\t" \
> @@ -212,10 +239,13 @@ static inline void test_##NAME(bool invert) \
>
>  #define float_sf(x) ({ typeof(x) _x =3D (x); *((float *)&(_x)); })
>  #define float_hf(x) ({ typeof(x) _x =3D (x); *((_Float16 *) &(_x)); })
> +#define float_bf(x) ({ uint32_t _u =3D ((uint32_t)(x)) << 16; *((float *=
)&(_u)); })
>  #define raw_sf(x) ({ typeof(x) _x =3D (x); *((uint32_t *)&(_x)); })
>  #define raw_hf(x) ({ typeof(x) _x =3D (x); *((uint16_t *)&(_x)); })
> +#define raw_bf(x) ({ typeof(x) _x =3D (x); (uint16_t)(*((uint32_t *)&(_x=
)) >> 16); })
>  #define float_hf_to_sf(x) ((float)x)
>  #define bytes_hf 2
>  #define bytes_sf 4
> +#define bytes_bf 2
>
>  #endif
> diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
> index dee0781bd7..4543a0aa8c 100644
> --- a/tests/tcg/hexagon/fp_hvx.c
> +++ b/tests/tcg/hexagon/fp_hvx.c
> @@ -29,6 +29,7 @@ int err;
>  #define CHECK_NAN(A, DEF_NAN) (isnan(A) ? DEF_NAN : (A))
>  #define NAN_SF float_sf(0x7FFFFFFF)
>  #define NAN_HF float_hf(0x7FFF)
> +#define NAN_BF float_hf(0x7FFF)
>
>  /***********************************************************************=
*******
>   * Binary operations
> @@ -91,11 +92,43 @@ DEF_TEST_OP_2(vmpy, MULT_HF, hf, hf);
>  #define MAX_HF(X, Y) MAX(X, Y, NAN_HF)
>  #define MIN_SF(X, Y) MIN(X, Y, NAN_SF)
>  #define MAX_SF(X, Y) MAX(X, Y, NAN_SF)
> +#define MIN_BF(X, Y) MIN(X, Y, NAN_BF)
> +#define MAX_BF(X, Y) MAX(X, Y, NAN_BF)
>
>  DEF_TEST_OP_2(vfmin, MIN_SF, sf, sf);
>  DEF_TEST_OP_2(vfmax, MAX_SF, sf, sf);
>  DEF_TEST_OP_2(vfmin, MIN_HF, hf, hf);
>  DEF_TEST_OP_2(vfmax, MAX_HF, hf, hf);
> +DEF_TEST_OP_2(vmin, MIN_BF, bf, bf);
> +DEF_TEST_OP_2(vmax, MAX_BF, bf, bf);
> +
> +#define DEF_TEST_OP_2_INTERLEAVED(vop, op, type_res, type_arg) \
> +    static void test_##vop##_##type_res##_##type_arg(void) \
> +    { \
> +        memset(expect, 0xff, sizeof(expect)); \
> +        memset(output, 0xff, sizeof(output)); \
> +        for (int i =3D 0; i < BUFSIZE / 2; i++) { \
> +            HVX_VectorPair *hvx_output =3D (HVX_VectorPair *)&output[2 *=
 i]; \
> +            HVX_Vector hvx_buffer0 =3D *(HVX_Vector *)&buffer0[i]; \
> +            HVX_Vector hvx_buffer1 =3D *(HVX_Vector *)&buffer1[i]; \
> +            *hvx_output =3D \
> +                Q6_W##type_res##_##vop##_V##type_arg##V##type_arg(hvx_bu=
ffer0, \
> +                                                                  hvx_bu=
ffer1); \
> +            for (int j =3D 0; j < MAX_VEC_SIZE_BYTES / bytes_##type_res;=
 j++) { \
> +                expect[2 * i].type_res[j] =3D \
> +                    raw_##type_res(op(float_##type_arg(buffer0[i].type_a=
rg[2 * j]), \
> +                                      float_##type_arg(buffer1[i].type_a=
rg[2 * j]))); \
> +                expect[2 * i + 1].type_res[j] =3D \
> +                    raw_##type_res(op(float_##type_arg(buffer0[i].type_a=
rg[2 * j + 1]), \
> +                                    float_##type_arg(buffer1[i].type_arg=
[2 * j + 1]))); \
> +            } \
> +        } \
> +        check_output_##type_res(__LINE__, BUFSIZE); \
> +    }
> +
> +DEF_TEST_OP_2_INTERLEAVED(vadd, SUM_SF, sf, bf);
> +DEF_TEST_OP_2_INTERLEAVED(vsub, SUB_SF, sf, bf);
> +DEF_TEST_OP_2_INTERLEAVED(vmpy, MULT_SF, sf, bf);
>
>  /***********************************************************************=
*******
>   * Other tests
> @@ -180,6 +213,14 @@ int main(void)
>      test_vfmax_sf_sf();
>      test_vfmax_hf_hf();
>
> +    /* bfloat */
> +    init_buffers_bf();
> +    test_vmin_bf_bf();
> +    test_vmax_bf_bf();
> +    test_vadd_sf_bf();
> +    test_vsub_sf_bf();
> +    test_vmpy_sf_bf();
> +
>      puts(err ? "FAIL" : "PASS");
>      return err ? 1 : 0;
>  }
> diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c b/tests/tcg/hexagon/fp_hvx_cm=
p.c
> index b1352c786a..22c18bc299 100644
> --- a/tests/tcg/hexagon/fp_hvx_cmp.c
> +++ b/tests/tcg/hexagon/fp_hvx_cmp.c
> @@ -22,9 +22,11 @@ int err;
>
>  #define MAX_TESTS_hf (MAX_VEC_SIZE_BYTES / 2)
>  #define MAX_TESTS_sf (MAX_VEC_SIZE_BYTES / 4)
> +#define MAX_TESTS_bf (MAX_VEC_SIZE_BYTES / 2)
>
>  #define TRUE_MASK_sf 0xffffffff
>  #define TRUE_MASK_hf 0xffff
> +#define TRUE_MASK_bf 0xffff
>
>  static const char *comparisons[MAX_TESTS_sf][2];
>  static HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0];
> @@ -160,6 +162,54 @@ static void test_cmp_hf(void)
>      CHECK(hf, 2);
>  }
>
> +static void test_cmp_bf(void)
> +{
> +    /*
> +     * General ordering for bf:
> +     * QNaN > SNaN > +Inf > numbers > -Inf > SNaN_neg > QNaN_neg
> +     */
> +
> +    /* Test equality */
> +    PREP_TEST();
> +    ADD_TEST_CMP(bf, 0,       0,       false);
> +    ADD_TEST_CMP(bf, BF_SNaN, BF_SNaN, false);
> +    CHECK(bf, 2);
> +
> +    /* Common numbers */
> +    PREP_TEST();
> +    TEST_CMP_GT(bf, raw_hf((_Float16)2.2),  raw_hf((_Float16)2.1));
> +    TEST_CMP_GT(bf, raw_hf((_Float16)0),    raw_hf((_Float16)-2.2));
> +    CHECK(bf, 2);

For comparing bfloats I think the test is clearer and more robust if
you use bfloat-encoded inputs here instead of the half
precision/float16 ones.  "BF_two" / "BF_one" e.g.

> +
> +    /* Infinity vs Infinity/NaN */
> +    PREP_TEST();
> +    TEST_CMP_GT(bf, BF_QNaN,      BF_INF);
> +    TEST_CMP_GT(bf, BF_SNaN,      BF_INF);
> +    TEST_CMP_GT(bf, BF_INF,       BF_INF_neg);
> +    TEST_CMP_GT(bf, BF_INF,       BF_SNaN_neg);
> +    TEST_CMP_GT(bf, BF_INF,       BF_QNaN_neg);
> +    TEST_CMP_GT(bf, BF_INF_neg,   BF_SNaN_neg);
> +    TEST_CMP_GT(bf, BF_INF_neg,   BF_QNaN_neg);
> +    TEST_CMP_GT(bf, BF_SNaN,      BF_INF_neg);
> +    TEST_CMP_GT(bf, BF_QNaN,      BF_INF_neg);
> +    CHECK(bf, 2);
> +
> +    /* NaN vs NaN */
> +    PREP_TEST();
> +    TEST_CMP_GT(bf, BF_QNaN,      BF_SNaN);
> +    TEST_CMP_GT(bf, BF_SNaN,      BF_SNaN_neg);
> +    TEST_CMP_GT(bf, BF_SNaN_neg,  BF_QNaN_neg);
> +    CHECK(bf, 2);
> +
> +    /* NaN vs non-NaN */
> +    PREP_TEST();
> +    TEST_CMP_GT(bf, BF_QNaN,      BF_one);
> +    TEST_CMP_GT(bf, BF_SNaN,      BF_one);
> +    TEST_CMP_GT(bf, BF_one,       BF_QNaN_neg);
> +    TEST_CMP_GT(bf, BF_one,       BF_SNaN_neg);
> +    CHECK(bf, 2);
> +}
> +
>  static void check_byte_pred(HVX_VectorPred pred, int byte_idx, uint8_t e=
xp_mask,
>                              int line)
>  {
> @@ -217,6 +267,7 @@ int main(void)
>
>      test_cmp_sf();
>      test_cmp_hf();
> +    test_cmp_bf();
>      test_cmp_variants();
>
>      puts(err ? "FAIL" : "PASS");
> diff --git a/tests/tcg/hexagon/fp_hvx_cvt.c b/tests/tcg/hexagon/fp_hvx_cv=
t.c
> index 71c3f0fd4f..bd8d39d6b6 100644
> --- a/tests/tcg/hexagon/fp_hvx_cvt.c
> +++ b/tests/tcg/hexagon/fp_hvx_cvt.c
> @@ -19,6 +19,8 @@ int err;
>  #include "hvx_misc.h"
>  #include "hex_test.h"
>
> +#define NAN_BF 0x7FFF
> +
>  #define TEST_EXP(TO, FROM, VAL, EXP) do { \
>      ((MMVector *)&buffer)->FROM[index] =3D VAL; \
>      expect[0].TO[index] =3D EXP; \
> @@ -172,6 +174,34 @@ DEF_TEST_VCONV(sf, w, { \
>      TEST_EXP(sf, w, 16777219, raw_sf((float)16777220)); /* rounds UP */ =
\
>  })
>
> +#define TEST_EXP_BF(VAL, EXP) do { \
> +    ((MMVector *)&buffers[1])->sf[index] =3D VAL; \
> +    ((MMVector *)&buffers[0])->sf[index] =3D VAL; \
> +    expect[0].bf[2 * index] =3D EXP; \
> +    expect[0].bf[2 * index + 1] =3D EXP; \
> +    index++; \
> +} while (0)
> +
> +static void test_vconv_bf_sf(void)
> +{
> +    HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0];
> +    HVX_Vector buffers[2];
> +    int index =3D 0;
> +    memset(&buffers, 0, sizeof(buffers));
> +    memset(expect, 0, sizeof(expect));
> +
> +    TEST_EXP_BF(SF_QNaN, NAN_BF);
> +    TEST_EXP_BF(SF_SNaN, NAN_BF);
> +    TEST_EXP_BF(SF_QNaN_neg, NAN_BF);
> +    TEST_EXP_BF(SF_INF, BF_INF);
> +    TEST_EXP_BF(SF_INF_neg, BF_INF_neg);
> +    TEST_EXP_BF(SF_one, BF_one);
> +    TEST_EXP_BF(SF_zero_neg, BF_zero_neg);
> +
> +    *hvx_output =3D Q6_Vbf_vcvt_VsfVsf(buffers[0], buffers[1]);
> +    check_output_hf(__LINE__, 1);
> +}
> +
>  int main(void)
>  {
>      test_vcvt_uh_hf();
> @@ -182,6 +212,7 @@ int main(void)
>      test_vconv_sf_w();
>      test_vconv_h_hf();
>      test_vconv_hf_h();
> +    test_vconv_bf_sf();
>
>      puts(err ? "FAIL" : "PASS");
>      return err ? 1 : 0;
> --
> 2.37.2
>

