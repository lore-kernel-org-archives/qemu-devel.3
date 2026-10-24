Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909E606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TALmwkto;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eVMpghOj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKZ9q-0000f0-8s; Sat, 24 Oct 2026 06:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKZ9n-0000er-U7
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:39:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKZ9m-00088A-88
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 06:39:23 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8nvBD1706839
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AhB9sJB7PCz0lfR21k3j1mDh3Rm8r4u48QgS4k/63Ig=; b=TALmwktocYtxmvXD
 mv7HlHAdrMISXFdv9oW1jaZXBnTWn+5dDGhWsfemNWUt86kH32bJ2jn0GFAxilUq
 gs2jy7LXFwkJ6oKRxT23186d4hHmq6uAGLqGMvwKmQsBDG19sH90KcnHt0IF8bOE
 5/mQREDkvn7Z76eIWc+P/T7fDpxvutFKf4WCUiA401Kh7ggs1GHlwHnUXE4ozImM
 cGS8PmaEg/dNvgjzA2nyRFTvr55QJ5htLjYOmnuPTaMaCCsyQ3rjQvPbkv28Km48
 nVeonROYfXp01y4Sn9I4tm+Gq7/cPg3//oJNWyWtji4pimxa53ev2d4vMFHnduTs
 lpnMRw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xgt6g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:39:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2c0e6653so20290185a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 03:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792838359; x=1793443159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AhB9sJB7PCz0lfR21k3j1mDh3Rm8r4u48QgS4k/63Ig=;
 b=eVMpghOjGdip/POYfox/wyF9EBspyh6fmQxDtLpFEgiHp3SqlgM3yFrxpXn2Wqhpcc
 wzghW4a64JYx1p9R60YUd/N1K7o0AAq8UVucQhp2Qh1+9/FoIK+HpsLCmPl7nN6ehUE+
 T2YYeYuH3Xtuj/Mc2GI3as6xk/eWv4HmRnJPRbEiSVbknUeIruGUr/m+Qb1kIVkuBDme
 hHLOsv1FDFzK9L2Q+kYJUgqPfFgQDdaW5Vx0qwyFtymlB4FjAE1kBUd8DXboDJQLUiWI
 /s9XJfNdskkUOm8h4MZ00tsY7mqlhvBM/cc4Mg2xC6Wzufb9dT1YD7QY/yIdgg8BIDhj
 12SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792838359; x=1793443159;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AhB9sJB7PCz0lfR21k3j1mDh3Rm8r4u48QgS4k/63Ig=;
 b=EU4gMnk5rIVqyGhb7GmYhLc3TPONzY38hLbwIrJ0NLuYDVyUfqMXXnKV49Igu/MLM9
 vKvGBpWrfeCDR2ql8R9we16BTRAWeVtsGThzu5sjQah5SUAkKuwE5g7Mlehyu1C26XbM
 6xC50UthmkQdKKSVzfLqxLG2QcF7KkgX5PAK7McRBHHqpFZuIim1NmHz1OwyOXrKeh46
 8I+sTs67liel8zCB5s8+3918ueCVrZWVahpqN9Gpn2bGqra8CPXcLIc9LPlB0eEEcBQm
 P3yE+ZM8hxm1Kw75GZOyYj8226Yb/R5r76ErnbLfRO7XutgCzZiAnWz9uK52ORwkv7Ar
 XmfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEKcu+Ng27z6UHJCjZoVFNsrooQqvscdoRw9piBquIISO4SBDN6yMHoOdvC8xIglgTGWJ2TQE7Ubaw@nongnu.org
X-Gm-Message-State: AFq9FYLEij5FL/Tp0YRYHGc9tUW3DNrVMsXxbez6ZaDaF1z9LHlLJCIM
 X90YpmabHrWF4ECo5Y3dn6+sJNmg/yZCMu6dYxm8/a1ALRMKo15fsjU+92kzOmseCzc6JtWS/Hv
 klkJg55rGJJh1yyHHa1QKcG5OKPdXTuPa/kgaFvrvUH1Xv1BAjZPPEkOKSQ==
X-Gm-Gg: AYBFou1Y0KstIY+rXBuyOI1OT4byX074qg+I3Bg2HRzg04A5UNDCugJVFH4DBUAp/WL
 gZyauHDkU1UHIjD7OujsF80N7Z8m8s0+IlPsQVcaX3F0Didhjxw/X5b5IFb2COd6z9JIr5qmgH5
 fMjNvnthNrg3XZDhT8WaLRDlYh7ny7QiclnpQmfy20bFti64f5X9vIxlL5zpovfK1pwXeh9y3Ge
 02e+u+JiVsCngrLO/Cc/2VlLYjbIrSus4g1tHcCRlXV+cQuN1syAiivVaNIrEqcywNaMOfsB1gk
 g1s1Vx5VDdmKps5DxiB7HmuuYWpcSwC2QwyoxxUzg+dpR77hANEJu4jI4zdrmb4Ln6++C+FpKE+
 LN5qL/sh3A/5CLT6A19/YItiC0Av/OiWkbw==
X-Received: by 2002:a05:620a:178b:b0:93e:9292:1b96 with SMTP id
 af79cd13be357-940ef795e19mr208873585a.3.1792838358670; 
 Sat, 24 Oct 2026 03:39:18 -0700 (PDT)
X-Received: by 2002:a05:620a:178b:b0:93e:9292:1b96 with SMTP id
 af79cd13be357-940ef795e19mr208872085a.3.1792838358230; 
 Sat, 24 Oct 2026 03:39:18 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbc718sm39037475e9.2.2026.10.24.03.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 03:39:17 -0700 (PDT)
Message-ID: <ef5d6289-547a-4ffc-9535-262fc83ce18c@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 12:39:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] target/tricore: replace legacy DPM/CPM CSFRs with
 CPXE/DPRE/DPWE
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Saravanan Sekar <saravanan@linumiz.com>,
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>,
 Christoph Seitz <christoph.seitz@infineon.com>,
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
 <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-1-c722e4ca5661@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-1-c722e4ca5661@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GAaZAJ2DXJtNmhPNc30ajOXe_eCm1JSl
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adc8ad7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=vU9dKmh3AAAA:8 a=1v0M58cU-lMBX2enPGIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MiBTYWx0ZWRfX15oXOaYLi6s5
 ECeSabsyTyeCz2A7CaxAfABwXE0uQCVMmBYfWU/dpRzKjIWBDcbLJQrLelx5Len3p9fmJne8zm2
 L7XG2qqb6HEowNzyrzfdu1iElLmlRaY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MiBTYWx0ZWRfX8CHvupEfwuUY
 LckOJOYFqTNzpkusrXlcs4A34JN/NDNXeS1oeRFoNPs2se7f6VkLxGJKL9abr9YcRok+mXvEPOw
 3+W/mMP5GuOd+3jOnPWbmpqgSniLgSQi7EvtZI+DTjrf1xX56VKUlAgMWQW+0SXAgCsljOb/AUq
 AnkTCM+1fR4W/x83lGGFc79veaOidL8xEJyZV9jtRMSZoFfi4I8Sbe9SddUC9eNJ5HdGF8IsGu7
 9X6EsELWtjgoiNIx0h3+HXdRTNQ4s1TJ91WPghHenjzUCCrRWwG+XeO9YB0dwOKKEGMsEqbvfUu
 fdcVngAjEBlj/ttFDJDVhetIF/ZoBVT/0Ikr/CCXLIGCcoiLpr3gImsSHO8dVePZdfIfAABq/Dw
 uFqGiuCmTnkiMapRDFeI6uZBldvPV2+3GscPSvdTnLdYBhJk+jK9N6v9pJWi2lcE3132HoT/TK0
 pulY9BETSgN8tqnPlEQ==
X-Proofpoint-ORIG-GUID: GAaZAJ2DXJtNmhPNc30ajOXe_eCm1JSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 22:11, Parthiban Nallathambi wrote:
> The DPM0-3 and CPM0-3 entries had wrong addresses and were never
> used.  Replace with the correct per-protection-set enable bitmask
> registers (CPXE, DPRE, DPWE) per the TriCore architecture manual.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   target/tricore/csfr.h.inc | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/target/tricore/csfr.h.inc b/target/tricore/csfr.h.inc
> index cdfaf1d662..24d8310947 100644
> --- a/target/tricore/csfr.h.inc
> +++ b/target/tricore/csfr.h.inc
> @@ -83,14 +83,18 @@ A(0xDC10, CPR3_2L, TRICORE_FEATURE_13)
>   A(0xDC14, CPR3_2U, TRICORE_FEATURE_13)
>   A(0xDC18, CPR3_3L, TRICORE_FEATURE_13)
>   A(0xDC1C, CPR3_3U, TRICORE_FEATURE_13)
> -A(0xE000, DPM0, TRICORE_FEATURE_13)
> -A(0xE080, DPM1, TRICORE_FEATURE_13)
> -A(0xE100, DPM2, TRICORE_FEATURE_13)
> -A(0xE180, DPM3, TRICORE_FEATURE_13)
> -A(0xE200, CPM0, TRICORE_FEATURE_13)
> -A(0xE280, CPM1, TRICORE_FEATURE_13)
> -A(0xE300, CPM2, TRICORE_FEATURE_13)
> -A(0xE380, CPM3, TRICORE_FEATURE_13)

That would break TC1.3 DPM/CPM registers.

> +A(0xE000, CPXE_0, TRICORE_FEATURE_13)
> +A(0xE004, CPXE_1, TRICORE_FEATURE_13)
> +A(0xE008, CPXE_2, TRICORE_FEATURE_13)
> +A(0xE00C, CPXE_3, TRICORE_FEATURE_13)
> +A(0xE010, DPRE_0, TRICORE_FEATURE_13)
> +A(0xE014, DPRE_1, TRICORE_FEATURE_13)
> +A(0xE018, DPRE_2, TRICORE_FEATURE_13)
> +A(0xE01C, DPRE_3, TRICORE_FEATURE_13)
> +A(0xE020, DPWE_0, TRICORE_FEATURE_13)
> +A(0xE024, DPWE_1, TRICORE_FEATURE_13)
> +A(0xE028, DPWE_2, TRICORE_FEATURE_13)
> +A(0xE02C, DPWE_3, TRICORE_FEATURE_13)

So these are for TC1.6 CPXE/DPRE/DPWE. Is there a typo
to gate for TRICORE_FEATURE_16?

I see there are TC1.6.2 and TC1.8 manuals but haven't checked them.

>   /* memory management registers */
>   A(0x8000, MMU_CON, TRICORE_FEATURE_13)
>   A(0x8004, MMU_ASI, TRICORE_FEATURE_13)
> 


