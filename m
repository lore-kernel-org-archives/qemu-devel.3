Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359CDCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw6z-00053S-5Y; Fri, 15 May 2026 13:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw6g-00051C-5P
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:13:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw6d-0004v9-QI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:13:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBDRLn3671020
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zaAZsKwyExsTVuYnppXhfWmWphgFoAtj22CtUA+bqnE=; b=Ec/px3RUSLT29JEv
 PHlZuMcxBvEHP121SIDIY+yvfm2gsKbn4kOj2VtJ1xK9HLr1NP8HRs/U5YmH6ebm
 TGCIW3wjcssxS8s7QzWQ3whOnu7xlLe4lFAPnn2MO65619RJAQijeVz7UdC8e874
 kGx2bGtXLqe10oCBXtPrfoHEJ1jMfWnJwS8WuVxQz9PsDrRgRXSWCueCkF3cmMlX
 X6n9Qvh5BFuErX3gEXWVh8VZwPOsEhbWLdlbN9i4u/uKAb0b9rH6F1eyvoPGoX/u
 wVjjK2WuOqLK+eVqXBlmyhRJ7JOTvzL0vr3T2q+WqTdjmzh4nvuCLkwyY/fapwK9
 jEXRmw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s47er-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:13:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bda35eab74so990826eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865226; x=1779470026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zaAZsKwyExsTVuYnppXhfWmWphgFoAtj22CtUA+bqnE=;
 b=OLJsxIBDX6/xgmXbpDlSdqerStPoV0iaSN/YkhLEgbxoKqfKz43tRD1KZh0zBiX+ZL
 XJtgrQ+ghuIak1hAG9M6unG4Bk8Uj+6FanZynC/texW3zqKnKN2Ge1ajjkbNGjk+oKBu
 h9WhYk5iEBszLIlhOUNpNtKl4YtKUeWph27BZ7afeQgCdbEjSl3lkk5yQrJZFhhpvVVD
 CJyK6+HAVWMY2jmkZxnyCqGwchWww1MalwTE5qixQCpFPO2WQVXtrDUtMh7Dmq+1UfF+
 ESoCUnhtLL8wQ1Rjf7MSYZ/bRlhnenmKTyefKQnQ2940MVWeyta0TvsUBevKiUCTpLI9
 pBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865226; x=1779470026;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zaAZsKwyExsTVuYnppXhfWmWphgFoAtj22CtUA+bqnE=;
 b=nqIi740Pg/N+IjXJjVEONF45yDtVYMmyHftWA7PAdGSdiopAIhXvFTKxq6/qOzuTyo
 a9qX9aOHbwkEqMwQ+uTgfiNr0sTVqnban3j7pl47hVn/PD2iTdBWrYD6EWtVXUMe1Rxa
 AIP9R4ZWf+ZSlc4Man++26v1ggDd0Rqqt/hwZexRozCjIAvuDl+NCP92cuI+qsuOHqbf
 W4qNIN20gIUMyMYeEB4JHyaF41PD/yx9ly6TKI+2rwPOBfQOu71Duzmr4WX+irrE0gQA
 ih63Fjy9rxPMjuSyXyYAaajSBdDkIA6EJGFd3UBmmSSa7eOzIP8z8GyKFBjn/XeKWRAb
 6YpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98F5uGf7K6twM8v21CAeYjJzGwYhHIQAY9cfvMa0ISO6cNRG//omkq+C80XZIkKcFvlTffQaFgx8T4@nongnu.org
X-Gm-Message-State: AOJu0YybN3YqKg26jS9zbyEbKUGtxCPdA1MuJ/FGsRJgqBaJOzPOA9BR
 pDqivhHu9XMJx6pOQkZWF3xf5kKd7aGD7q/gdnFx3mtnj5WOxIVfoZQDCdtVR3eQhTe3ce8bge7
 f0pJ76czNNSCUSY3GdTeADcwj1givjILaxblFjRNFimDP8V/XOAKH3PqPtA==
X-Gm-Gg: Acq92OGn7AOOs/Ueyi0jq+Du6gJ6QrmzqmCBPs9M2PEaJc+rNKLiV6Z1JrN4FHj3snz
 36N3ABFg3/Z8jD8CWWmPQBKjD8vIq2QNwsUSxafIxJVdy9bjmJnXurJi/EHW24DMQQ7+BxGrd/x
 5XmuAAtLFmUIRxU//01jywTBwoz1PsqKmu86oMffLf/8Xpn32l/ssxOc3zHse5P+0n8gHHIQNlm
 3ZYKk1qSIhuvpQzAPgCJtT2yapuUwpNMXkVNCn7z6T1mubUThjIJ9kSIcxZ6Yt/uweExp75kWQL
 lcnAyWKvcJQWLuqT98AivXycdvgJagyjKvZI8WYU9CeKNNwrsZRNN6MS9Yk6/L3uMBIWVNiPnHd
 Uxk10w1shaX8eZcm9WxAGuequgCzedLZvo/37s30eeBEV+lYSoOX9Cbvso0jHprXplkngcJIeIv
 6MGau2H3GxUYpFQg==
X-Received: by 2002:a05:7300:dc8d:b0:2d9:1c9d:fc22 with SMTP id
 5a478bee46e88-3026302f90fmr4810943eec.21.1778865225383; 
 Fri, 15 May 2026 10:13:45 -0700 (PDT)
X-Received: by 2002:a05:7300:dc8d:b0:2d9:1c9d:fc22 with SMTP id
 5a478bee46e88-3026302f90fmr4810909eec.21.1778865224708; 
 Fri, 15 May 2026 10:13:44 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcd0csm7870799eec.24.2026.05.15.10.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:13:44 -0700 (PDT)
Message-ID: <5556b33a-0405-4688-a20b-09e80fb18f07@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:13:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/20] target/arm: Extract common code related to 'max'
 CPU
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 <e11a2547-8d2d-403a-94d2-3ab5e35dff77@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e11a2547-8d2d-403a-94d2-3ab5e35dff77@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfX+YtQPnCGg1E8
 RQZkEGzzTj/fTj22Iw3mzNhGFdFeZQ1w7QuY1CRQWMwQX965uUQeO9ZBAgCCQuPWL40ycD9Qw2i
 GkOsEbXiAEElt4ApPFELgdjAfzj/xAKK4BWr1LdH0MVLhgKVDTvnadBl09mP97RdpGJt1u1MFkX
 aaxHw1xDhCDpyxQPZE/04k4LEVBlLmhtcc3olfftsQD1xpV4erb5dfGE/iJpqTv4bP8rGVAWEWG
 flSQJKMe+XdL/5O+iIDpyXXEfcf/tKZRauNqBToa0VEmK3BdHZnJQOWgj8TGc9q9hJP/bmk7bVC
 qkvy4R+1KD5JXCoBQTN652vmpg6mGHUxLpWF43AStB7+jy0mXnC0ckVY5v/1Er46JWeV5FswD9t
 MnC3sLqxhGQHPknhS91XWc5snyjhnJDmVgVRdEiWbyrF2h8/sXSbpZKNEZ7etZwJC7ofAn3te1D
 cGoLvq7mEf/7rdAUmTQ==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a07544a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=d78jJa_eLNz9I5sOdwwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kSxlORqmsMd7COZ7ta2LU13bvXMp3cm8
X-Proofpoint-ORIG-GUID: kSxlORqmsMd7COZ7ta2LU13bvXMp3cm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150175
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/15/2026 10:10 AM, Pierrick Bouvier wrote:
> On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>  target/arm/cpu-max.c   | 106 +++++++++++++++++++++++++++++++++++++++++
>>  target/arm/tcg/cpu32.c |  96 -------------------------------------
>>  target/arm/meson.build |   1 +
>>  3 files changed, 107 insertions(+), 96 deletions(-)
>>  create mode 100644 target/arm/cpu-max.c
>>
>> diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
>> new file mode 100644
>> index 00000000000..9fd48ce46e2
>> --- /dev/null
>> +++ b/target/arm/cpu-max.c
>> @@ -0,0 +1,106 @@
>> +/*
>> + * QEMU ARM 'max' CPU
>> + *
>> + * Copyright (c) 2018 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "target/arm/internals.h"
>> +
>> +/* Share AArch32 -cpu max features with AArch64. */
>> +void aa32_max_features(ARMCPU *cpu)
>> +{
>> +    uint32_t t;
>> +    ARMISARegisters *isar = &cpu->isar;
>> +
>> +    /* Add additional features supported by QEMU */
>> +    t = GET_IDREG(isar, ID_ISAR5);
>> +    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
>> +    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
>> +    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
>> +    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
>> +    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
>> +    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
>> +    SET_IDREG(isar, ID_ISAR5, t);
>> +
>> +    t = GET_IDREG(isar, ID_ISAR6);
>> +    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
>> +    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
>> +    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
>> +    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
>> +    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
>> +    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
>> +    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
>> +    SET_IDREG(isar, ID_ISAR6, t);
>> +
>> +    t = cpu->isar.mvfr1;
>> +    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
>> +    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
>> +    cpu->isar.mvfr1 = t;
>> +
>> +    t = cpu->isar.mvfr2;
>> +    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
>> +    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
>> +    cpu->isar.mvfr2 = t;
>> +
>> +    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
>> +
>> +    t = GET_IDREG(isar, ID_MMFR4);
>> +    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
>> +    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
>> +    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
>> +    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
>> +    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
>> +    SET_IDREG(isar, ID_MMFR4, t);
>> +
>> +    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
>> +
>> +    t = GET_IDREG(isar, ID_PFR0);
>> +    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
>> +    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
>> +    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
>> +    SET_IDREG(isar, ID_PFR0, t);
>> +
>> +    t = GET_IDREG(isar, ID_PFR2);
>> +    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
>> +    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
>> +    SET_IDREG(isar, ID_PFR2, t);
>> +
>> +    t = GET_IDREG(isar, ID_DFR0);
>> +    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
>> +    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
>> +    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
>> +    SET_IDREG(isar, ID_DFR0, t);
>> +
>> +    /* Debug ID registers. */
>> +
>> +    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
>> +    t = 0x00008000;
>> +    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
>> +    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
>> +    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
>> +    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
>> +    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
>> +    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
>> +    cpu->isar.dbgdidr = t;
>> +
>> +    t = 0;
>> +    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
>> +    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
>> +    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
>> +    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
>> +    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
>> +    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
>> +    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
>> +    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
>> +    cpu->isar.dbgdevid = t;
>> +
>> +    /* Bits[31:4] are RES0. */
>> +    t = 0;
>> +    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
>> +    cpu->isar.dbgdevid1 = t;
>> +
>> +    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
>> +}
>> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
>> index 73d21c6cf7d..919ed8a6cf8 100644
>> --- a/target/arm/tcg/cpu32.c
>> +++ b/target/arm/tcg/cpu32.c
>> @@ -18,102 +18,6 @@
>>  #include "cpregs.h"
>>  
>>  
>> -/* Share AArch32 -cpu max features with AArch64. */
>> -void aa32_max_features(ARMCPU *cpu)
>> -{
>> -    uint32_t t;
>> -    ARMISARegisters *isar = &cpu->isar;
>> -
>> -    /* Add additional features supported by QEMU */
>> -    t = GET_IDREG(isar, ID_ISAR5);
>> -    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
>> -    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
>> -    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
>> -    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
>> -    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
>> -    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
>> -    SET_IDREG(isar, ID_ISAR5, t);
>> -
>> -    t = GET_IDREG(isar, ID_ISAR6);
>> -    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
>> -    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
>> -    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
>> -    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
>> -    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
>> -    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
>> -    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
>> -    SET_IDREG(isar, ID_ISAR6, t);
>> -
>> -    t = cpu->isar.mvfr1;
>> -    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
>> -    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
>> -    cpu->isar.mvfr1 = t;
>> -
>> -    t = cpu->isar.mvfr2;
>> -    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
>> -    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
>> -    cpu->isar.mvfr2 = t;
>> -
>> -    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
>> -
>> -    t = GET_IDREG(isar, ID_MMFR4);
>> -    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
>> -    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
>> -    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
>> -    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
>> -    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
>> -    SET_IDREG(isar, ID_MMFR4, t);
>> -
>> -    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
>> -
>> -    t = GET_IDREG(isar, ID_PFR0);
>> -    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
>> -    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
>> -    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
>> -    SET_IDREG(isar, ID_PFR0, t);
>> -
>> -    t = GET_IDREG(isar, ID_PFR2);
>> -    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
>> -    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
>> -    SET_IDREG(isar, ID_PFR2, t);
>> -
>> -    t = GET_IDREG(isar, ID_DFR0);
>> -    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
>> -    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
>> -    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
>> -    SET_IDREG(isar, ID_DFR0, t);
>> -
>> -    /* Debug ID registers. */
>> -
>> -    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
>> -    t = 0x00008000;
>> -    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
>> -    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
>> -    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
>> -    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
>> -    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
>> -    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
>> -    cpu->isar.dbgdidr = t;
>> -
>> -    t = 0;
>> -    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
>> -    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
>> -    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
>> -    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
>> -    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
>> -    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
>> -    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
>> -    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
>> -    cpu->isar.dbgdevid = t;
>> -
>> -    /* Bits[31:4] are RES0. */
>> -    t = 0;
>> -    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
>> -    cpu->isar.dbgdevid1 = t;
>> -
>> -    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
>> -}
>> -
>>  /* CPU models. These are not needed for the AArch64 linux-user build. */
>>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
>>  
>> diff --git a/target/arm/meson.build b/target/arm/meson.build
>> index 5376be2e3bc..3e02941d0d5 100644
>> --- a/target/arm/meson.build
>> +++ b/target/arm/meson.build
>> @@ -9,6 +9,7 @@ arm_user_ss = ss.source_set()
>>  arm_common_system_ss.add(files('gdbstub.c'))
>>  arm_user_ss.add(files('gdbstub.c'))
>>  
>> +arm_ss.add(files('cpu-max.c'))
>>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>>    'cpu64.c',
>>  ))
> 
> Some bikeshedding: maybe name this cpu32-max.c for consistency?
> No strong opinion though, just a feeling.
>

Seeing patch 16/17, forget my remark above.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Regards,
> Pierrick


