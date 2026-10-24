Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C2606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ejL3VBi1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D8ckC0fh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKZPS-0002vG-SK; Sat, 24 Oct 2026 06:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKZPR-0002tR-I0
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:55:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKZPP-0001Ea-3g
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:55:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8obT61166822
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2utEkVxdNzZbnzkZuH2GfpPe6OMR4cuUihWaaiod4xw=; b=ejL3VBi1u2VhUnNE
 MxThGLH5GIiyIxCsaNmPiADhaG77EUc5iiRCAhSrDknKce/41izYv3Buv+knV0YP
 ohk30QlxLrPV1kyFhqSFjtwdtm/yAYDXn0PKXYX/JayhrShSDhZyc3YDR5gl7YAn
 oXGFgI4omQivnIZ8AtJ6kwnmn3v/f84YyJSZRACjTQHf/J5qwZ294Yepth6aqk4P
 y65ahkU4Ujp4RtbD3vPSvFi1Gdl9ly/t5XW9UWCn0vohBe2sxN4fdLDItaih2woZ
 PbccS1SyEsFtvh5jAlNixEnjgh4OOVkZT7Lc+HlQ1MkLJv+Pbhkjqd88zStbABXZ
 BJMh+w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3grjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:55:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f322ef7d3so379152685a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792839327; x=1793444127; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2utEkVxdNzZbnzkZuH2GfpPe6OMR4cuUihWaaiod4xw=;
 b=D8ckC0fhycTlNplfbr0gGDjhYRMw1dpqNx9WDvHa1TvX6N2igEDzu35eADoHshbWCv
 xHGrdi2VkxBSsEoX9F664LNBQzGw9lE8Y9IXT5eBnm+DZVfQhRlZKNUTFych3QIi/9j9
 9ajduisCczPgZfIcT+XD8UTYGusUQNQghSfEgQdaw1cezFdk62ol3qJcFN8NKFmdhOuS
 H3DqEi2ujhmRSVhMscLST3MNtnDl3/os4UBICNssO3e3r0xhnaBz3cQh7fjY7P+MmEqe
 +x4cFOU/GpLkWPFahPFWDdLcbrKH4+lFgRGx0BtoUxzfrhO2sbDp8XD6t7DCM3ei5o9P
 bGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792839327; x=1793444127;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2utEkVxdNzZbnzkZuH2GfpPe6OMR4cuUihWaaiod4xw=;
 b=Iy59MlajNqFacq5tJfEEWxfKLQcbh1A5wH7N1paRENuylpr/IByEtlNr+HZqJwz85X
 RQOqeonqRvpRFlIlYUIjbKqGd8kOX0VwpY+GJuM0m5aDIWNRY3fsAQ9CzkRqVih95EZa
 msMItwv4TRyOpUkv0dwkDU6iSIR1Hv8CvsHX2eYdu2zuyhC3HHTgatRN4CwQvNKqZE2K
 TzKKiMD8+E/kO7CbQprO52fJURKBj9F9pMIm7A9n2rNUaMRjQKhd+h/qLaZ+GlysKBao
 uBt4Zwmi6OoPmxXKcB/lK/5TFVgNd+MsTssz9NRgHHCi5YoVQVDtl5o3cJktj1Y5XnPf
 Cj7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHskUjuMNENf27ndBEV/QsQXTSN29M0oGFL8rlcqpNEwaeodCBCbxtvQpRGHMq5sOYXTT1QUw6jse4@nongnu.org
X-Gm-Message-State: AFq9FYKOdV7V6AvbAsu8fKd/+bCHaLU6euxiNKoD0B/BoBb8KHIETPXR
 Dgu8KMu00CUwPGwqTce+vjsbEq/eaefFKC2Pag6gJOea9Xv7G3dLUOeyvy4KPLs3uVn/RgOMGFo
 RMR/Ckf/PcA+1y0qWsTAlfbp9HiBgr1FZCLMD1tPl0P+0qk7Hzr+9rpjPbg==
X-Gm-Gg: AYBFou1yJs48IwuqTROq2pRuSrhEsqGVnos07ZRhlvocMc47nCsUp+MiOZ245vzn/Ie
 exoDMJsVyM6+3vRrptg+Lzy5VSIX8fpmGgbC1S4hB+7vITdpooO5sxzVMJa6nIrC/ZPSqOxOWCh
 ryo90DN9eGJU3yoZu1b09CsdQFreCE/hzWQB1Bx1ovqHNuG5Z0ZEDrDw2MHuryx6eC/pBaCLszV
 aXXOHF3eyL/vOcib4d8N28il92Y7AfLb671/aKl3BCFgoVu2QL2zRlv+3ogoqfaz7my+YfA0BiW
 +whQXOJhbU6kWOZLVRz7X1O6Kyh8HN6/9xneX2lS9RZWx4gVmXSsjvcVdidYw9iq5tgRjRMfu5F
 /xN+dEN1WOkr1XvCgiR0ul4gmbQSMiFL77w==
X-Received: by 2002:a05:620a:3703:b0:93c:c2c2:40eb with SMTP id
 af79cd13be357-940ef9adc1amr206850085a.66.1792839327259; 
 Sat, 24 Oct 2026 03:55:27 -0700 (PDT)
X-Received: by 2002:a05:620a:3703:b0:93c:c2c2:40eb with SMTP id
 af79cd13be357-940ef9adc1amr206848585a.66.1792839326742; 
 Sat, 24 Oct 2026 03:55:26 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecde7c3sm3901530f8f.51.2026.10.24.03.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 03:55:25 -0700 (PDT)
Message-ID: <f0176186-b227-4554-be16-f772647530c0@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 12:55:24 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] hw/tricore: add System Control Unit (SCU) device
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Saravanan Sekar <saravanan@linumiz.com>,
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>,
 Christoph Seitz <christoph.seitz@infineon.com>,
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>,
 David Brenken <david.brenken@efs-auto.de>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
 <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-6-c722e4ca5661@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-6-c722e4ca5661@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cctDHsoTW0wQ2PCnKVzYNIFqRphZw_DU
X-Proofpoint-ORIG-GUID: cctDHsoTW0wQ2PCnKVzYNIFqRphZw_DU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MyBTYWx0ZWRfXwOIKSjaNfKXA
 CaRPFn3lQVpXDMNVtHcyL1QwU+3r3A3/kxCa+3imteQ9gyQtsQaj4v9D7oZ6uPs76ZMswG5ONOC
 iCmHCWCfEFNIYxoo6fEA296YimIZ90s=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc8ea0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bUQKSiCPAAAA:8 a=vU9dKmh3AAAA:8 a=9V0ZjuSQ12dOMUnJhEsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=-fHZXUhsFbuwFN3fwQAr:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MyBTYWx0ZWRfX8Hu9bhV8xCPt
 vCT0PqmTyAENThKCvQSdkBcmtli/ylX9VX+vSDY3L4UqrzzgmiN/nL1SKbbjEnHB5Bpq0Qns7pl
 AFmyR2Wr3Hzwa5AFvtNhV6UkppcYJ2HOLIVJg+XitipbT6WMLKcHCLqZGNA9bs0Pxn6OKZ+QwBC
 +FmhE/j/K1zRKqQybnAcnFxObp7yPhE8FFEn83wQjA5WOzZ5Hwt2d1UhHuXhfGOg/q/FUn0+rLb
 N4vCQD5EMvrY0ZvRyWmL4EQDtuSVpIQeF1hBrTXM7kMF+rrWPi3UTe9fPJG3Rxt7JlVUJJHEmo/
 ZE/RyQ90Asly+1EEOyXdPf4dpnzobBBr7izXxnGlcKv4Ph3lNC9Xx1Hjlr5XNocW5TDwBEDELqA
 wyV3l7iAspCZzR0ejR9OHw9dNigFHbOXMojUhlG/Np2dR3qdTnIY79QI3q9IYdq5F2Deo12QPBZ
 cMD5toShmdmWTddA0dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240043
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 22:12, Parthiban Nallathambi wrote:
> Stub the PLL, oscillator and clock control registers that
> firmware reads during boot.  PLL always reports locked so
> startup code does not time out.
> 
> Originally-by: David Brenken <david.brenken@efs-auto.de>
> Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   hw/tricore/Kconfig               |   3 +
>   hw/tricore/meson.build           |   1 +
>   hw/tricore/tricore_scu.c         | 295 +++++++++++++++++++++++++++++++++++++++
>   include/hw/tricore/tricore_scu.h |  45 ++++++
>   4 files changed, 344 insertions(+)


> +/* Register offsets */
> +enum {
> +    A_OSCCON        = 0x10,
> +    A_PLLSTAT       = 0x14,
> +    A_PLLCON0       = 0x18,
> +    A_PLLCON1       = 0x1C,
> +    A_PLLCON2       = 0x20,
> +    A_PLLERAYSTAT   = 0x24,
> +    A_CCUCON0       = 0x30,
> +    A_CCUCON1       = 0x34,
> +    A_CCUCON2       = 0x40,
> +    A_CCUCON3       = 0x44,
> +    A_CCUCON4       = 0x48,
> +    A_CCUCON5       = 0x4C,
> +    A_WDTSCON0      = 0xF0,
> +    A_WDTCPU0CON0   = 0x100,
> +    A_CHIPID        = 0x140,
> +};
> +
> +/* OSCCON bit positions (iLLD IfxScu_bf.h) */
> +#define MASK_OSCCON_PLLLV               0x00000002  /* bit 1 */
> +#define MASK_OSCCON_PLLHV               0x00000100  /* bit 8 */
> +
> +/* PLLCON0 fields */
> +#define MASK_PLLCON0_SETFINDIS          0x00000010
> +#define MASK_PLLCON0_CLRFINDIS          0x00000020
> +
> +/* PLLSTAT fields */
> +#define MASK_PLLSTAT_VCOLOCK            0x00000004
> +#define MASK_PLLSTAT_FINDIS             0x00000008
> +
> +/* CCUCON fields */
> +#define MASK_CCUCON0_UP                 0x40000000
> +#define MASK_CCUCON1_UP                 0x40000000
> +#define MASK_CCUCON5_UP                 0x40000000
> +
> +/* Reset values */
> +#define RESET_TRICORE_OSCCON            0x00000112
> +#define RESET_TRICORE_PLLSTAT           0x00000038
> +#define RESET_TRICORE_PLLCON0           0x0001C600
> +#define RESET_TRICORE_PLLCON1           0x0002020F
> +#define RESET_TRICORE_PLLCON2           0x00000000
> +#define RESET_TRICORE_PLLERAYSTAT       0x00000038
> +#define RESET_TRICORE_PLLERAYCON0       0x00012E00
> +#define RESET_TRICORE_PLLERAYCON1       0x000F020F
> +#define RESET_TRICORE_CCUCON0           0x01120148
> +#define RESET_TRICORE_CCUCON1           0x00002211
> +#define RESET_TRICORE_CCUCON2           0x00000002
> +#define RESET_TRICORE_CCUCON3           0x00000000
> +#define RESET_TRICORE_CCUCON4           0x00000000
> +#define RESET_TRICORE_CCUCON5           0x00000041
> +#define RESET_TRICORE_FDR               0x00000000
> +#define RESET_TRICORE_EXTCON            0x00000000
> +#define RESET_TRICORE_WDTSCON0          0xFFFC000E
> +#define RESET_TRICORE_WDTSCON1          0x00000000
> +#define RESET_TRICORE_WDTCPU0CON0      0xFFFC000E
> +
> +static void tricore_scu_update_ccucon(TriCoreSCUState *s)
> +{
> +    if ((s->ccucon[0] & MASK_CCUCON0_UP) ||
> +        (s->ccucon[1] & MASK_CCUCON1_UP) ||
> +        (s->ccucon[5] & MASK_CCUCON5_UP)) {
> +        s->ccucon[0] &= ~(MASK_CCUCON0_UP | (1U << 31));
> +        s->ccucon[1] &= ~(MASK_CCUCON1_UP | (1U << 31));
> +        s->ccucon[5] &= ~(MASK_CCUCON5_UP | (1U << 31));
> +    }
> +}
> +
> +static uint32_t tricore_scu_reg_read(TriCoreSCUState *s, hwaddr offset)
> +{
> +    switch (offset) {
> +    case A_OSCCON:
> +        return s->osccon;
> +    case A_PLLSTAT:
> +        /*
> +         * Report PLL as always locked: VCOLOCK=1, K1RDY=1, K2RDY=1.
> +         * Firmware polls these bits during clock initialisation.
> +         */
> +        return 0x00000077;

Why not return s->pllstat?

> +    case A_PLLCON0:
> +        return s->pllcon[0];
> +    case A_PLLCON1:
> +        return s->pllcon[1];
> +    case A_PLLCON2:
> +        return s->pllcon[2];
> +    case A_PLLERAYSTAT:
> +        return 0x00000077;

Ditto s->plleraystat.

> +    case A_CCUCON0:
> +        return s->ccucon[0];
> +    case A_CCUCON1:
> +        return s->ccucon[1];
> +    case A_CCUCON2:
> +        return s->ccucon[2];
> +    case A_CCUCON3:
> +        return s->ccucon[3];
> +    case A_CCUCON4:
> +        return s->ccucon[4];
> +    case A_CCUCON5:
> +        return s->ccucon[5];
> +    case A_WDTSCON0:
> +        return s->wdtscon1;

wdtscon0?

What about A_WDTSCON1?

> +    case A_WDTCPU0CON0:
> +        return s->wdtcpu0con0;
> +    case A_CHIPID:
> +        return 0x47477172 | (1U << 31);

IIUC this file aim to model a generic SCU so we shouldn't hide a
hardcoded chip ID, better expose it as configurable property
(DEFINE_PROP_UINT32, set it in tc39xb_soc_realize).
> +    default:
> +        if (offset < SCU_REG_SIZE) {
> +            return s->regs[offset / 4];
> +        }
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "tricore_scu: read at bad offset 0x%" HWADDR_PRIx "\n",
> +                      offset);
> +        return 0;
> +    }
> +}
> +
> +static uint64_t tricore_scu_read(void *opaque, hwaddr offset,
> +                                 unsigned size)
> +{
> +    TriCoreSCUState *s = TRICORE_SCU(opaque);
> +
> +    return extract32(tricore_scu_reg_read(s, offset & ~3),
> +                     (offset & 3) * 8, size * 8);
> +}
> +
> +static void tricore_scu_write(void *opaque, hwaddr offset,
> +                              uint64_t value, unsigned size)
> +{
> +    TriCoreSCUState *s = TRICORE_SCU(opaque);
> +
> +    /* 8/16-bit writes: merge into the current 32-bit register value */
> +    if (size < 4) {
> +        value = deposit32(tricore_scu_reg_read(s, offset & ~3),
> +                          (offset & 3) * 8, size * 8, value);
> +        offset &= ~3;
> +    }
> +
> +    switch (offset) {
> +    case A_OSCCON:
> +        s->osccon = (uint32_t)value;
> +        /*
> +         * Real silicon raises PLLHV and PLLLV once the external
> +         * oscillator is stable.  Mark stable immediately.
> +         */
> +        s->osccon |= MASK_OSCCON_PLLHV | MASK_OSCCON_PLLLV;
> +        break;
> +    case A_PLLCON0:
> +        s->pllcon[0] = (uint32_t)value;
> +        if (s->pllcon[0] & MASK_PLLCON0_SETFINDIS) {
> +            s->pllstat |= MASK_PLLSTAT_FINDIS;
> +        }
> +        if (s->pllcon[0] & MASK_PLLCON0_CLRFINDIS) {
> +            s->pllstat &= ~MASK_PLLSTAT_FINDIS;
> +        }
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_PLLCON1:
> +        s->pllcon[1] = (uint32_t)value;
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_PLLCON2:
> +        s->pllcon[2] = (uint32_t)value;
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_CCUCON0:
> +        s->ccucon[0] = (uint32_t)value;
> +        tricore_scu_update_ccucon(s);
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_CCUCON1:
> +        s->ccucon[1] = (uint32_t)value;
> +        tricore_scu_update_ccucon(s);
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_CCUCON2:
> +        s->ccucon[2] = (uint32_t)value & ~(1U << 31);
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_CCUCON3:
> +        s->ccucon[3] = (uint32_t)value & ~(1U << 31);
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_CCUCON4:
> +        s->ccucon[4] = (uint32_t)value & ~(1U << 31);
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_CCUCON5:
> +        s->ccucon[5] = (uint32_t)value;
> +        tricore_scu_update_ccucon(s);
> +        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
> +        break;
> +    case A_WDTSCON0:
> +        s->wdtscon1 = (uint32_t)value;

Ditto A_WDTSCON1 / wdtscon0.

> +        break;
> +    case A_WDTCPU0CON0:
> +        s->wdtcpu0con0 = (uint32_t)value;
> +        break;
> +    default:

Watch out, A_PLLSTAT is read-only.

> +        if (offset < SCU_REG_SIZE) {
> +            s->regs[offset / 4] = (uint32_t)value & ~(1U << 31);

Why clear bit 31? At least we need a comment to explain.

> +            return;
> +        }
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "tricore_scu: write at bad offset 0x%"
> +                      HWADDR_PRIx "\n", offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps tricore_scu_ops = {
> +    .read = tricore_scu_read,
> +    .write = tricore_scu_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void tricore_scu_reset_hold(Object *obj, ResetType type)
> +{
> +    TriCoreSCUState *s = TRICORE_SCU(obj);
> +
> +    s->ccucon[0] = RESET_TRICORE_CCUCON0;
> +    s->ccucon[1] = RESET_TRICORE_CCUCON1;
> +    s->ccucon[2] = RESET_TRICORE_CCUCON2;
> +    s->ccucon[3] = RESET_TRICORE_CCUCON3;
> +    s->ccucon[4] = RESET_TRICORE_CCUCON4;
> +    s->ccucon[5] = RESET_TRICORE_CCUCON5;
> +    s->fdr = RESET_TRICORE_FDR;

Not used AFAICT.

> +    s->extcon = RESET_TRICORE_EXTCON;

Ditto unused (thus no need to model?).

> +    s->osccon = RESET_TRICORE_OSCCON | MASK_OSCCON_PLLHV | MASK_OSCCON_PLLLV;
> +
> +    s->pllcon[0] = RESET_TRICORE_PLLCON0;
> +    s->pllcon[1] = RESET_TRICORE_PLLCON1;
> +    s->pllcon[2] = RESET_TRICORE_PLLCON2;
> +    s->plleraycon[0] = RESET_TRICORE_PLLERAYCON0;
> +    s->plleraycon[1] = RESET_TRICORE_PLLERAYCON1;

Unused.

> +    s->plleraystat = RESET_TRICORE_PLLERAYSTAT;
> +    s->pllstat = RESET_TRICORE_PLLSTAT | MASK_PLLSTAT_VCOLOCK;
> +
> +    s->wdtcpu0con0 = RESET_TRICORE_WDTCPU0CON0;
> +    s->wdtscon0 = RESET_TRICORE_WDTSCON0;
> +    s->wdtscon1 = RESET_TRICORE_WDTSCON1;

Should we reset s->regs[] array?

> +}
> +
> +static void tricore_scu_init(Object *obj)
> +{
> +    TriCoreSCUState *s = TRICORE_SCU(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &tricore_scu_ops, s,
> +                          TYPE_TRICORE_SCU, SCU_REG_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static void tricore_scu_class_init(ObjectClass *klass, const void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold = tricore_scu_reset_hold;

Better if regs[] is migrable in VMSTATE.

> +}
> +
> +static const TypeInfo tricore_scu_info = {
> +    .name = TYPE_TRICORE_SCU,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(TriCoreSCUState),
> +    .instance_init = tricore_scu_init,
> +    .class_init = tricore_scu_class_init,
> +};
> +
> +static void tricore_scu_register_types(void)
> +{
> +    type_register_static(&tricore_scu_info);
> +}


