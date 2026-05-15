Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C35CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw3X-00027D-F6; Fri, 15 May 2026 13:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw3B-0001wZ-43
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:10:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw36-0002eV-NK
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:10:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FCM3aX3795431
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s9qXxFRHC0vJtaVE7vbTukR4VrKVoAu8hb0fR6+sNyQ=; b=N4cm7K96J6RLtMHt
 51Po3e4TIc3LQOwqMpXlwLyYkAVcn0lYiJq/PdncC7Ik4LZzImqG7OvVZfopM5qm
 Garpo6S4UhN7ufVy7QoVdSKPa1wuKvDeAADjsS4BUZs0fGPRZ50ZDiDmw8HoBVC4
 EUgjbQMkF+29WScxO87daTdt44xcNM/2tR4jkZf0k8rmFsjuYfNWGKWJ0uT9BwZJ
 J4iGY/E11KMKcRR7ERNtD1utr6iqJ6FR7Q2p+hJEBpjN6W1pUBBc7DjhvVZqKNr3
 h3uaBrKMW+3+WR2Vy6Jq5Hq1t4pb5FNM1aOVCRUm8jacvzWTsK4Rh/Qnt2bIRTS6
 f6Wcog==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sv3yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:10:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so36919eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865005; x=1779469805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s9qXxFRHC0vJtaVE7vbTukR4VrKVoAu8hb0fR6+sNyQ=;
 b=agpd5XKHRcItrjQFBlRSHQYh3GWYNL6tshBHfZh/IjXzm3H1tQpkhF+cnAqU7X/SiT
 6goC4IftvMYIuYblFw0DrkevcfUedgiAXGbPUTpXR98VZlr4TTHuZ+lM1q5nTZjrlmrG
 xSUWsznM7uuTCQ9HYzcpCqzCrw2n1lgzQimz5/+pbTB2yV+PYa3F5NhQBG9OFUSkIA0s
 moe2qbfYFMMrxHrMyd9D4FClQ6LZqmC7TZcYQHPKWZWmekdITbnGOtuf+WfgtpmtdSl0
 CWaLMSM/eN5FihvYTwhda9y63J1hsr0Lz3Y8QhQWgniIc8oa8a1FnrSycs5SE5O0iXs9
 TrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865005; x=1779469805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9qXxFRHC0vJtaVE7vbTukR4VrKVoAu8hb0fR6+sNyQ=;
 b=Z+26TevnWXD3DrAa3bGhYwyIT+pKMsPXQAwidLVlOuejxH6bgw8z4Q1U4wMfdznaJP
 ADM9Pgk+umyHWVf3jQGWyhwtNlqfuj/5aoElly/Q9ftbGksCV++x+14lPqt/plTb0HAp
 nbqV3I2bYnMnyu7a6Ay/ooxKkWuCXEXKNa1svVnLtSYzs05oOTObrC2Va8HfPw9TCih7
 i13/d6wnF+Bis10y+gt+bNKKgnjvvb+/Lz7GNoXxT3VCi0qG+2RNvQjanYNBYIWCnVkk
 M8J5Uxt18UrjzqNv3a6JOZ9YHpd0aWLgWB9+wyuNrDmF7Nx4a9EARRZfRx82EqWP7nrH
 hgpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R7wkuvUpM8OmVZrvHANmgCxMquub3ZDvggLkGQh9rJOHP7pGJdK5OwchjOFG4SzGkoQOpiXaRAC7H@nongnu.org
X-Gm-Message-State: AOJu0YyeBYkYKx9EJJn+TDa7vO3VpRidqKQRqCpQQCmFx/1ccbxUVp30
 6Yfokqz+C9TaBBHfHwGPOUjsX5y58G4iKFUbeJN3QcI5Xam9cPlpKbuD7mc+6JBoSnC2DwSxijH
 oZFawYw4AdRqR91H+/AanI3lPGlLB8uDTdzr52ugdcO3/a7SFZekY0rQksQ==
X-Gm-Gg: Acq92OENYFbGL8yZTTkLKxLK5PNRMd/OYmSmyY9CxaVphPE8+PQ9K5YcRpAsT3CvLz0
 A5S9S4hzPtHpTjN2Hkixara2Nu71Wi53ZWiizmFjGQxxP8cmisscWDTeGjOiRuj7A1sIUDWgQS1
 zjvaO8p0QPdYMAN+RR/z6VqEvdw08RuaTloWjvB98GLAoidvp7dzMvpEKrl3FAe25MvuJ5pa4n+
 egIlpQCCuOQYGKfxUJjOO+Vc5FTCB4cKFnHA76Hd/RIIGVVQAjORgWS/v532vBWnfRWOxH+TDGt
 0PnmRCc3xnTjDcUanIQo4BHL+M+olS0BOqSL2wC8Wh226VqSf4sID8ZM8wNcwaQXpgsB5gLIwR4
 lTAw56D3nr6QNOCW29pfALCnXMXdqDS36JBYTR7b+X4h/7DjQgQhC7FaAt80bJAUylZVwg31Hf7
 LrPkFbzndNPn5znQ==
X-Received: by 2002:a05:7300:dc03:b0:2ee:be86:7b90 with SMTP id
 5a478bee46e88-303986b1538mr2329784eec.29.1778865005166; 
 Fri, 15 May 2026 10:10:05 -0700 (PDT)
X-Received: by 2002:a05:7300:dc03:b0:2ee:be86:7b90 with SMTP id
 5a478bee46e88-303986b1538mr2329761eec.29.1778865004551; 
 Fri, 15 May 2026 10:10:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978ad18asm7531719eec.26.2026.05.15.10.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:10:04 -0700 (PDT)
Message-ID: <e11a2547-8d2d-403a-94d2-3ab5e35dff77@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:10:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/20] target/arm: Extract common code related to 'max'
 CPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfX70M+zaf41f/4
 +blx5hCKKFEa5u+uHikZRNsfrAxUXsVqAY8khm5fZ+ldkpEiZgGRvnpRwfWNdYWmkC5Mu3ug8FK
 M/N8VqIoMolvHbXp9ak+JOfeQXQE9l6//xOR1WnyNSmQRYNeBvr0HCctz/gAGkKor3wql8RUJLB
 fLsb08AH0f+uyLY0uoN0i2CFGWhVQREUzYaBJdnmlw6SsU5OUomyUgSzUC+VEdEDtrlDqDhC8PR
 HIVY5DSPVnsPCVCdkqM1M89iSBpwLn/2rZ6MLMMdAEwkt5Er5cnphmLtVW3mXZfVG95C7ELB5iH
 /94XzA9buzvsP6IU7q5hOvbYcXnNw6RdLvISupq7Q7MkmrhkOJ65h/USBNzSMCPcWamkILMrXzL
 sb+LMKGaT2/HjTWgEJOE/CooN6DxXef2mru4Id6bPFs8YgehTICV5se0rw+ImtaK0mjyWwp0vmU
 AsCIdZefg0dcQoow1OA==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a07536e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bcbY33BGdfAjHCA2VuMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: L3dwXuO9rbclCvcDF4fTq-HyrYkzmT3u
X-Proofpoint-ORIG-GUID: L3dwXuO9rbclCvcDF4fTq-HyrYkzmT3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/cpu-max.c   | 106 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/tcg/cpu32.c |  96 -------------------------------------
>  target/arm/meson.build |   1 +
>  3 files changed, 107 insertions(+), 96 deletions(-)
>  create mode 100644 target/arm/cpu-max.c
> 
> diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
> new file mode 100644
> index 00000000000..9fd48ce46e2
> --- /dev/null
> +++ b/target/arm/cpu-max.c
> @@ -0,0 +1,106 @@
> +/*
> + * QEMU ARM 'max' CPU
> + *
> + * Copyright (c) 2018 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "target/arm/internals.h"
> +
> +/* Share AArch32 -cpu max features with AArch64. */
> +void aa32_max_features(ARMCPU *cpu)
> +{
> +    uint32_t t;
> +    ARMISARegisters *isar = &cpu->isar;
> +
> +    /* Add additional features supported by QEMU */
> +    t = GET_IDREG(isar, ID_ISAR5);
> +    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
> +    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
> +    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
> +    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
> +    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
> +    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
> +    SET_IDREG(isar, ID_ISAR5, t);
> +
> +    t = GET_IDREG(isar, ID_ISAR6);
> +    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
> +    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
> +    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
> +    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
> +    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
> +    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
> +    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
> +    SET_IDREG(isar, ID_ISAR6, t);
> +
> +    t = cpu->isar.mvfr1;
> +    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
> +    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
> +    cpu->isar.mvfr1 = t;
> +
> +    t = cpu->isar.mvfr2;
> +    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
> +    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
> +    cpu->isar.mvfr2 = t;
> +
> +    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
> +
> +    t = GET_IDREG(isar, ID_MMFR4);
> +    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
> +    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
> +    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
> +    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
> +    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
> +    SET_IDREG(isar, ID_MMFR4, t);
> +
> +    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
> +
> +    t = GET_IDREG(isar, ID_PFR0);
> +    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
> +    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
> +    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
> +    SET_IDREG(isar, ID_PFR0, t);
> +
> +    t = GET_IDREG(isar, ID_PFR2);
> +    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
> +    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
> +    SET_IDREG(isar, ID_PFR2, t);
> +
> +    t = GET_IDREG(isar, ID_DFR0);
> +    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
> +    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
> +    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
> +    SET_IDREG(isar, ID_DFR0, t);
> +
> +    /* Debug ID registers. */
> +
> +    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
> +    t = 0x00008000;
> +    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
> +    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
> +    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
> +    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
> +    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
> +    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
> +    cpu->isar.dbgdidr = t;
> +
> +    t = 0;
> +    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
> +    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
> +    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
> +    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
> +    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
> +    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
> +    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
> +    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
> +    cpu->isar.dbgdevid = t;
> +
> +    /* Bits[31:4] are RES0. */
> +    t = 0;
> +    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
> +    cpu->isar.dbgdevid1 = t;
> +
> +    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
> +}
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 73d21c6cf7d..919ed8a6cf8 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -18,102 +18,6 @@
>  #include "cpregs.h"
>  
>  
> -/* Share AArch32 -cpu max features with AArch64. */
> -void aa32_max_features(ARMCPU *cpu)
> -{
> -    uint32_t t;
> -    ARMISARegisters *isar = &cpu->isar;
> -
> -    /* Add additional features supported by QEMU */
> -    t = GET_IDREG(isar, ID_ISAR5);
> -    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
> -    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
> -    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
> -    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
> -    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
> -    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
> -    SET_IDREG(isar, ID_ISAR5, t);
> -
> -    t = GET_IDREG(isar, ID_ISAR6);
> -    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
> -    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
> -    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
> -    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
> -    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
> -    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
> -    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
> -    SET_IDREG(isar, ID_ISAR6, t);
> -
> -    t = cpu->isar.mvfr1;
> -    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
> -    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
> -    cpu->isar.mvfr1 = t;
> -
> -    t = cpu->isar.mvfr2;
> -    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
> -    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
> -    cpu->isar.mvfr2 = t;
> -
> -    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
> -
> -    t = GET_IDREG(isar, ID_MMFR4);
> -    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
> -    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
> -    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
> -    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
> -    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
> -    SET_IDREG(isar, ID_MMFR4, t);
> -
> -    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
> -
> -    t = GET_IDREG(isar, ID_PFR0);
> -    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
> -    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
> -    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
> -    SET_IDREG(isar, ID_PFR0, t);
> -
> -    t = GET_IDREG(isar, ID_PFR2);
> -    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
> -    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
> -    SET_IDREG(isar, ID_PFR2, t);
> -
> -    t = GET_IDREG(isar, ID_DFR0);
> -    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
> -    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
> -    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
> -    SET_IDREG(isar, ID_DFR0, t);
> -
> -    /* Debug ID registers. */
> -
> -    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
> -    t = 0x00008000;
> -    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
> -    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
> -    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
> -    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
> -    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
> -    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
> -    cpu->isar.dbgdidr = t;
> -
> -    t = 0;
> -    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
> -    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
> -    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
> -    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
> -    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
> -    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
> -    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
> -    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
> -    cpu->isar.dbgdevid = t;
> -
> -    /* Bits[31:4] are RES0. */
> -    t = 0;
> -    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
> -    cpu->isar.dbgdevid1 = t;
> -
> -    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
> -}
> -
>  /* CPU models. These are not needed for the AArch64 linux-user build. */
>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
>  
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 5376be2e3bc..3e02941d0d5 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -9,6 +9,7 @@ arm_user_ss = ss.source_set()
>  arm_common_system_ss.add(files('gdbstub.c'))
>  arm_user_ss.add(files('gdbstub.c'))
>  
> +arm_ss.add(files('cpu-max.c'))
>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>    'cpu64.c',
>  ))

Some bikeshedding: maybe name this cpu32-max.c for consistency?
No strong opinion though, just a feeling.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

