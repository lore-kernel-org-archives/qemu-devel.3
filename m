Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4F2CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI55-00055h-Ib; Mon, 01 Sep 2025 23:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI4u-0004xw-07
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:53:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI4r-0005FE-Oq
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:53:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rk5R020472
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wHvbDTunywXe9CH2hCgIFy8UJevKRFTRY+78Y/FIIwY=; b=fFHinCY9eT+nU0uy
 ikAqtgGnzUOhTWqkah06P8M8Eu5KtyOcmvHgDzRVuVGOsZrRDmjr2L14GYh172Fx
 71a1Px+Y1+MQ1kzWNChuOVrO+kl2bMJD1asV29NN89RAGfsCgxQWN30axs3+iasg
 RgNX2ZXRI6Oa6OUx2V5TRe1Dj8CFBQ4Io5iDLTdS5Xrmc2YAvEmrTqYEfJ+WzUbA
 j4M5lw7vR2iz9jFVQ1QGLG1nZrqPTmCSJ8PcSa9WWud8NqCslL5GcmjPmbUgjhPd
 fpqrQ7/dLx2XUPm7EXeSuN7WcKRVJY0v9rOPYZtZf/O/ob0gJ1aWJ21I+cwPBtW7
 ZXLGuA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxfej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:53:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24aa3cf81a8so26955095ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785179; x=1757389979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wHvbDTunywXe9CH2hCgIFy8UJevKRFTRY+78Y/FIIwY=;
 b=nCac8/YuofOaXevUwAik7ERHR1WtVr2newWu8Dk7fzL909wr3lsmTsiIWQXeygjjWD
 UqicDUg5QWwI9o/220y0N74FyOG5KIijHdpArk8sotcsC6jXpgADp3bEtA9fvoONeXDM
 T5NLyUi57BEnvskmjMF7RlRaOqT1ihUfAxVeoKJPNGL9YgBWBGqP/WYMZozGr0sJIqdM
 UhOoBTnlwm5IjazMl99Q9IcVZsTiR0JCordxHhjt3HxOKV0UHA9Aw3qZEa40Ch7w8WlM
 kNlCrSk3ceIEhLtN8tSsGdZZRRTYBqoFI0pl1USFBPD6dhxFfpNJLEBgLgVwkd68CXMN
 LtSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWChcncBaUqD/cstAOcgHKKC83krk3e05qVlXRI/TUsVDKZfFJ2iRJ7u0rO9LC+xHM1vSHfZwJHFwQr@nongnu.org
X-Gm-Message-State: AOJu0YxgItHvwQcP7/S3GePpWOSPf+DRojP1SAdOClYinOG9Sy8/+/Bn
 qMj0TF3n8Fz7xsJQcTUQPmqOn0EgyS7vnsnAP0brxf9wmFSpXvbWkhsL+zUOBoNkncqW49kisvH
 MxKEVCacbsNLOI90e+Q36dPUC+KVVZe+TYe8zRsbKlzp6IUsHQjemSp42cA==
X-Gm-Gg: ASbGnctbq1yEjf8xBJ25S29BzBwIPiDBRJ43PnxYrUyZX3A4CEuRLiZVfmSFvGUKJt2
 y8Nimql6ZTum8HsSBkDfR364F7Y30jMgVI7F6wZ35b9aHMwKiaozs2VxNZhdY72sc/CBzUZ7Eed
 qL4hPMi71IYhFd2aC/xLdhHx83wS6wZn37yhDk00g07FeerL/AdSu701jDe42vHrdg8NLGMlazN
 ml3Kal/FqsyPErUboOLs+pJyEJn+ZKz+V5Z1lsOE0yWCJQJPI4y2QC8AiDwLhAl5lwAe8cXsmXX
 pabVG5nXOUrBHbtqySt1uPnqAlnOCPWpddgai6Ra1H6lKsR0SDM41wddw2oT8g==
X-Received: by 2002:a17:902:f707:b0:24b:1d30:5b06 with SMTP id
 d9443c01a7336-24b1d3075e4mr1334125ad.15.1756785179425; 
 Mon, 01 Sep 2025 20:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcrCaG8p8630LAikxvzpM0OqddN21ZL0wmi41XrYVq/eLNH4M1Q4bMNhTAnvYnKXbYhUpolA==
X-Received: by 2002:a17:902:f707:b0:24b:1d30:5b06 with SMTP id
 d9443c01a7336-24b1d3075e4mr1333855ad.15.1756785178899; 
 Mon, 01 Sep 2025 20:52:58 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:52:58 -0700 (PDT)
Message-ID: <9a229f74-d2da-4690-b6bb-a176472426fd@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:38:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/38] target/hexagon: Add new macro definitions for sysemu
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-15-brian.cain@oss.qualcomm.com>
 <029401db8f98$22248020$666d8060$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <029401db8f98$22248020$666d8060$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3hbvmEOMFWK/
 xY/hFPbjHR2lSHnGyhQFg1Jr/QkNfO5PoduB0pbXFmx/1cnyHxThC/4tlctxDtxXOfTmVgKIfHS
 8iyXcYHFxWCe4MSgiPoDgPRDmpn+Ms+WOXhZIws8zHsnbd68NT94C5NRwIobSktJehhO6L6MM6A
 L+gB2NLV+4eImfapjYP7L8590x+bzYcMwF3o1gCeMOV2lKE9RqPGByNdetBtDeIxGyqYhmONFfk
 pvG+ADU2x1VnWHVcHvVrpawVt8YeoYGw+auGXsJmBPX0g35fMA9YpK50Z8X5o/DEp1sGTl2Q9Py
 hT5B2XfURhnmOY9FdE7LzNa3sAFKOAaEvl4o9GMTwtUMNrs/zqh48BNDvfnUZMwFBGfIiRnh+Ch
 ZxpmfUUN
X-Proofpoint-GUID: Zh6XE3Xi59ayf8jHff-rS0Zw4vS3D2s4
X-Proofpoint-ORIG-GUID: Zh6XE3Xi59ayf8jHff-rS0Zw4vS3D2s4
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b66a1c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=dp4J7eLCU0QiT_R9C2kA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/7/2025 1:35 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 14/38] target/hexagon: Add new macro definitions for
>> sysemu
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Also: add nop TCG overrides for break,unpause,fetchbo,dczeroa
> dczeroa is modelled by QEMU.  It writes zero's to the cache line.
>
>> break: this hardware breakpoint instruction is used with the in-silicon
>> debugger feature, this is not modeled.
>>
>> unpause: this instruction is used to resume hardware threads that are stalled
>> by pause instructions.  pause is modeled as a nop, or in RR mode as an
>> EXCP_YIELD.  This instruction is safe to ignore.
>>
>> Since cache/prefetch functions are not modeled, dczero and fetchbo are
>> safe to ignore.
> dczero is modelled.
>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_tcg.h    |   9 ++
>>   target/hexagon/macros.h     |  28 ++++-
>>   target/hexagon/sys_macros.h | 238
>> ++++++++++++++++++++++++++++++++++++
>>   target/hexagon/op_helper.c  |   1 +
>>   4 files changed, 272 insertions(+), 4 deletions(-)  create mode 100644
>> target/hexagon/sys_macros.h
>>
>> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h index
>> 8a3b801287..71f8a0e2d0 100644
>> --- a/target/hexagon/gen_tcg.h
>> +++ b/target/hexagon/gen_tcg.h
>> @@ -488,6 +488,7 @@
>>
>>   /* dczeroa clears the 32 byte cache line at the address given */  #define
>> fGEN_TCG_Y2_dczeroa(SHORTCODE) SHORTCODE
>> +#define fGEN_TCG_Y2_dczeroa_nt(SHORTCODE) SHORTCODE
> Is there a Y2_dczeroa_nt instruction?  If not, remove this.
>
>>           ctx->dczero_addr = tcg_temp_new(); \
>>           tcg_gen_mov_tl(ctx->dczero_addr, (REG)); \
>>       } while (0)
>> +#else
>> +#define fDCZEROA(REG) ((void) REG)
> This isn't needed because all the instances of fDCZEROA are inside QEMU_GENERATE.
>
>
>>   #endif
>>
>> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
>> new file mode 100644 index 0000000000..3c4c3c7aa5
>> --- /dev/null
>> +++ b/target/hexagon/sys_macros.h
>> +#define READ_SREG(NUM) arch_get_system_reg(env, NUM)
>> +#define READ_SGP0()    arch_get_system_reg(env, HEX_SREG_SGP0)
>> +#define READ_SGP1()    arch_get_system_reg(env, HEX_SREG_SGP1)
>> +#define READ_SGP10()   ((uint64_t)arch_get_system_reg(env,
>> HEX_SREG_SGP0) | \
>> +    ((uint64_t)arch_get_system_reg(env, HEX_SREG_SGP1) << 32))
>> +
>> +#define WRITE_SREG(NUM, VAL)      log_sreg_write(env, NUM, VAL, slot)
>> +#define WRITE_SGP0(VAL)           log_sreg_write(env, HEX_SREG_SGP0,
>> VAL, slot)
>> +#define WRITE_SGP1(VAL)           log_sreg_write(env, HEX_SREG_SGP1,
>> VAL, slot)
>> +#define WRITE_SGP10(VAL) \
>> +    do { \
>> +        log_sreg_write(env, HEX_SREG_SGP0, (VAL) & 0xFFFFFFFF, slot); \
>> +        log_sreg_write(env, HEX_SREG_SGP1, (VAL) >> 32, slot); \
>> +    } while (0)
>> +
> READ_SREG and WRITE_SREG look like a hangover for the original generator scripts which have been rewritten.  Are they needed?
>
>
>> +#ifdef QEMU_GENERATE
>> +#define GET_SSR_FIELD(RES, FIELD) \
>> +    GET_FIELD(RES, FIELD, hex_t_sreg[HEX_SREG_SSR]) #else
>> +
>> +#define GET_SSR_FIELD(FIELD, REGIN) \
>> +    (uint32_t)GET_FIELD(FIELD, REGIN)
>> +#define GET_SYSCFG_FIELD(FIELD, REGIN) \
>> +    (uint32_t)GET_FIELD(FIELD, REGIN)
>> +#define SET_SYSTEM_FIELD(ENV, REG, FIELD, VAL) \
>> +    do { \
>> +        uint32_t regval = arch_get_system_reg(ENV, REG); \
>> +        fINSERT_BITS(regval, reg_field_info[FIELD].width, \
>> +                     reg_field_info[FIELD].offset, (VAL)); \
>> +        arch_set_system_reg(ENV, REG, regval); \
>> +    } while (0)
>> +#define SET_SSR_FIELD(ENV, FIELD, VAL) \
>> +    SET_SYSTEM_FIELD(ENV, HEX_SREG_SSR, FIELD, VAL) #define
>> +SET_SYSCFG_FIELD(ENV, FIELD, VAL) \
>> +    SET_SYSTEM_FIELD(ENV, HEX_SREG_SYSCFG, FIELD, VAL)
>> +
>> +#define CCR_FIELD_SET(ENV, FIELD) \
>> +    (!!GET_FIELD(FIELD, arch_get_system_reg(ENV, HEX_SREG_CCR)))
>> +
>> +/*
>> + * Direct-to-guest is not implemented yet, continuing would cause
>> +unexpected
>> + * behavior, so we abort.
>> + */
>> +#define ASSERT_DIRECT_TO_GUEST_UNSET(ENV, EXCP) \
>> +    do { \
>> +        switch (EXCP) { \
>> +        case HEX_EVENT_TRAP0: \
>> +            g_assert(!CCR_FIELD_SET(ENV, CCR_GTE)); \
>> +            break; \
>> +        case HEX_EVENT_IMPRECISE: \
>> +        case HEX_EVENT_PRECISE: \
>> +        case HEX_EVENT_FPTRAP: \
>> +            g_assert(!CCR_FIELD_SET(ENV, CCR_GEE)); \
>> +            break; \
>> +        default: \
>> +            if ((EXCP) >= HEX_EVENT_INT0) { \
>> +                g_assert(!CCR_FIELD_SET(ENV, CCR_GIE)); \
>> +            } \
>> +            break; \
>> +        } \
>> +    } while (0)
>> +#endif
>> +
>> +#define fREAD_ELR() (READ_SREG(HEX_SREG_ELR))
>> +
>> +#define fLOAD_PHYS(NUM, SIZE, SIGN, SRC1, SRC2, DST) { \
>> +  const uintptr_t rs = ((unsigned long)(unsigned)(SRC1)) & 0x7ff; \
>> +  const uintptr_t rt = ((unsigned long)(unsigned)(SRC2)) << 11; \
>> +  const uintptr_t addr = rs + rt;         \
>> +  cpu_physical_memory_read(addr, &DST, sizeof(uint32_t)); \ }
>> +
>> +#define fPOW2_HELP_ROUNDUP(VAL) \
>> +    ((VAL) | \
>> +     ((VAL) >> 1) | \
>> +     ((VAL) >> 2) | \
>> +     ((VAL) >> 4) | \
>> +     ((VAL) >> 8) | \
>> +     ((VAL) >> 16))
>> +#define fPOW2_ROUNDUP(VAL) (fPOW2_HELP_ROUNDUP((VAL) - 1) + 1)
>> +
>> +#define fFRAMECHECK(ADDR, EA)  g_assert_not_reached();
> Add a FIXME or comment on why this is not implemented.  Or is it implemented in a subsequent patch in this series?
>
>> +#define fSET_TLB_LOCK()       g_assert_not_reached()
>> +#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
>> +
>> +#define fSET_K0_LOCK()        g_assert_not_reached()
>> +#define fCLEAR_K0_LOCK()      g_assert_not_reached()
> Add a comment that these are implemented in a later patch in the series.


Some but not all of the suggestions above were addressed in v2. The 
remaining ones will be addressed for v3.

>

