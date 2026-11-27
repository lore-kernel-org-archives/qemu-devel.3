Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF8606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kvvf7abZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InQsnXKw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1y0-00027w-2U; Fri, 27 Nov 2026 14:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xX1xq-000244-LF
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:50:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xX1xn-0005Iq-F4
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 14:50:33 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJRjdx1381751
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 19:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WOYJakWBcTbr5RUGAjzP67NpYmfLfT5D6b/muxzgPU0=; b=kvvf7abZUdNtg7bX
 rVervZw0Uuk5inYYFRmwSgSYsueGF8s2Eu+FVYGS2Hr+vULv4RMWyWY9d7if6zUf
 1xXe+cuLyhHSkBYDq1A88y9CoDdXyN6JlXSDWdC5+zO1zSxAC+TLNqkwBbiWp374
 ZOjgDDbcXMSDWOC3Cle3sUs5cdxLrwuPoQEHUGgiqo9rBd57816D1stbC44oYDO8
 aLMOSUhfCheUMJB6edVZRh7Bi6dLMkkj+GAoxpCWe5kLYjKA83rdMrgRNoYfBysr
 zVTY3QsYaTeezK1SRA0QeJIoARWwKhZplwfUq4ztU+eBTA+io/BptMj5fHDbS0hp
 Cdmn+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1s81ed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 19:50:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3869accaac2so5059730eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 11:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795809029; x=1796413829; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WOYJakWBcTbr5RUGAjzP67NpYmfLfT5D6b/muxzgPU0=;
 b=InQsnXKwHaT9hDMTLwpuAEKigvtNC/3GqeJ2S8SdE/7BO9TTGUce9+c1oyK4enHEo/
 hZlKuHsnJ6RJrwEZIiV8cnkrK55913fs2yDXGuj27ZKPNqeekYhfPPtl5SgktL3iWU4+
 DEvKK+DQbDR9A+MbE9W/YgkxXZrwIRfnaWG6YIpfWK9aSDv8cCIsgyGMO5ufk5DjRugk
 2by2SV8EsjQ793JXg/81L1etMUpsmlsFOtPJYj9FzzdCjWCLQ8+a76rEQgYqJ/KGrLnD
 mP5BSHpa7aUgT7hJgvgucI71hmfxC6WDMWDYm88iJc5MD7xyNeeseGFkCDj3TRBzhZhb
 YdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809029; x=1796413829;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WOYJakWBcTbr5RUGAjzP67NpYmfLfT5D6b/muxzgPU0=;
 b=z7a9hmEs4uoNgmXktn85UUK3DTrNLlgStBcwDlgPnVPxeEHeV4o39E8eCthdBEhIA9
 6JKjgQn/lLe9+GM+BHeSOiAfs/1BwP838rzh0N58Wi8ZpRYeji4Wb5+VBVeJW44N6Y8d
 9kk2a6ENy/C+yOVRBBvIXVz/tTxuC2+Z0OixRvsWebhXLPb4Vh1FiQPSXjJqEqI18WjM
 7Fo3BIIMYM6N2GMs/kw/iaCajvSQkrW4uzqUJ/QW9tRUl0YgRseL+KxtW0PRTPDdmkNP
 Sebj8PkezA/I/5HbvoXfeEiriwvx1Xu1lwgMCPk3OojCT50vSGhtokYD03icuGQEyhKM
 MzAA==
X-Forwarded-Encrypted: i=1;
 AL+hErEyxqeZpyNRZ8qmmn+8YiD2XBBwF7GpKX0ujVVZ2r0TcL5CVg3ikhXcWQ1dSc85vEHRmepGR4tIXXZh@nongnu.org
X-Gm-Message-State: APuU4Z+5YFM66HPcIvzaNklm2O1nATSr/GATb4x2M7ibWNnfoni9+tCC
 oThtJYE6u3oXMUwi3f55JEZOwF3YgYV7dUGMueBal2EVGeJkGGskMEgFBnb2NCTpOlNUYDzoeoH
 s4bGYKp5gDtUgYLHhYtbpPBtmFl5bfiwdR2fABDHYn/ATe4safE1uFL+cwvQAMp1O5Q==
X-Gm-Gg: AZFdTZcSLY9SWDj9JGZ5nLMl8CWZX0MFugJmoe8Dh7OLqKGLCdPkKSWp6LsFYaeNhhV
 0sNWvorrAhGxSN3M7uE4A6tMVV7iGozVS9jstxL1ZUynAyuu9mCh+y64fgwv74akwjtdj6Jr7kv
 hYmEE8Vk1pMa/RMxXJ06WWYHGDRbQZSet6gWjj+KwHDkCumPfP8eYXXRcjNZC+giXIBOecOLlvh
 5LN5GSwB/2bKi5gs/LeQte66sh7xlroBYJ6qI15KMyzMl5+MixCk/TN7/l3Ss+hkqEJR72G+md1
 bJ4RqZ81qHGJQsPjoPwJFwKtK/qaxfwG1oR4Vxn1dYI03dNO1ZELhRMKrkTv3y6gzE9hwe2pcDu
 4benmNbBO2bd6Sw109sEhNN9QYT9sEF6dAcWCnjabirdbdW2RcTAVmB5/WD5tuHkhd6TpCMI2tC
 HBBuBqsWpJmFPbf9SjVQGfFxrz4x8wr3j5bp64TT7S4Rw=
X-Received: by 2002:a05:693c:811c:b0:386:ddd5:14e2 with SMTP id
 5a478bee46e88-386ddd52196mr5998919eec.0.1795809028643; 
 Fri, 27 Nov 2026 11:50:28 -0800 (PST)
X-Received: by 2002:a05:693c:811c:b0:386:ddd5:14e2 with SMTP id
 5a478bee46e88-386ddd52196mr5998897eec.0.1795809028017; 
 Fri, 27 Nov 2026 11:50:28 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm80193883eec.14.2026.11.27.11.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 11:50:27 -0800 (PST)
Message-ID: <a2a314d7-6313-40db-a38f-c7185b982fc5@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:50:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 4/5] target/hexagon: support ELF core dumps
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <20261125194855.3154845-5-brian.cain@oss.qualcomm.com>
 <692d2bbf-cc9b-4cf5-ab05-43a2f13d8336@oss.qualcomm.com>
 <d24abd48-66cf-45c0-a49b-ed98a85b88ed@oss.qualcomm.com>
 <6ad21845-51da-4853-b617-44208d545898@oss.qualcomm.com>
 <b2e835fc-7084-4e80-b840-c8172b64b354@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b2e835fc-7084-4e80-b840-c8172b64b354@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FYOiV5+6 c=1 sm=1 tr=0 ts=6b09df05 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ypBTFDDTJPA0o81_Rk8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: BENWKb0i__ZfLCmg9AGYG0J2ULZGEPB-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX6S6V8cFpIf6U
 OMOw5E28YaqIKiDOfdH9dQF7AB02xOP1tgZqXAW+QSBrmmj1KVUUGvIVIaOgAzcU+wS9Sz+uoZV
 F0TzhLoIoeTxDFg6HFFA374P5zZvELqx31ei3auIZd9IVIJzfuSFMRdi4EXNLSu3vgCc/wCIDcn
 OQ5phefpaeEBbU0dqwO1P2Ue75HnKWvMYMmJkQvfaVxToYWWyulNhhR5ladSsldZGK24c9bxLOt
 aXytWvBGJ3TFXKcVzukGf0FTG7uLW3B9c5408CI1qe66DnRRFw++qbhAmHVaBZQ02dtMo+xIJig
 0sj8jvkwLk8CKIxwmyABVAoxVvliy1rVHqKpUcGUbKpzas1E89JszOYIM9R+z0tdq6q/4pUZ6j0
 EVBguxSfGlQGKAVCV08qWYOWBbImD8RgsgvwtAYld1q45HQlw+csXA7fcTsMwrAlxGYbH5VPBjK
 yMdVFW3GS6Xf2Lj7z1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX2HYwPcAVQq+T
 n/BeobWVK0U+kKEaoJk2CNJ7ebZg/+zLZwjF7egvwqBT7yaPYTcjyHxKUX95dHSlfLyMbz6xvkz
 Qqw1POeH8GFCf5M7YUEB2beg1Axw2LA=
X-Proofpoint-ORIG-GUID: BENWKb0i__ZfLCmg9AGYG0J2ULZGEPB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/27/2026 11:38 AM, Brian Cain wrote:
> 
> On 11/27/2026 11:35 AM, Pierrick Bouvier wrote:
>> On 11/27/2026 9:32 AM, Brian Cain wrote:
>>> On 11/27/2026 11:29 AM, Pierrick Bouvier wrote:
>>>> On 11/25/2026 11:48 AM, Brian Cain wrote:
>>>>> Write core files for Hexagon.  For each hw thread, write a note w/
>>>>> user_regs_struct layout from linux kernel.
>>>>>
>>>>> In system mode the cause register is filled from SSR, badva from the
>>>>> system
>>>>> register, and pr_pid is the CPU index.
>>>>>
>>>>> dump-guest-memory with paging requested relies on the CPU's
>>>>> get_memory_mapping and get_paging_enabled callbacks.  Implement
>>>>> get_paging_enabled.
>>>>>
>>>>> Build the mappings from the valid TLB entries: for each CPU, consider
>>>>> global
>>>>> entries and those matching the CPU's current ASID.
>>>>>
>>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>>> ---
>>>>>    include/hw/hexagon/hexagon_tlb.h |  10 +++
>>>>>    linux-user/hexagon/target_elf.h  |   7 ++
>>>>>    target/hexagon/core-dump.h       |  73 ++++++++++++++++++++
>>>>>    target/hexagon/internal.h        |   8 +++
>>>>>    hw/hexagon/hexagon_tlb.c         |  17 +++++
>>>>>    linux-user/hexagon/elfload.c     |   4 ++
>>>>>    target/hexagon/arch_dump.c       | 112 +++++++++++++++++++++++++
>>>>> ++++++
>>>>>    target/hexagon/cpu.c             |  13 ++++
>>>>>    target/hexagon/meson.build       |   1 +
>>>>>    9 files changed, 245 insertions(+)
>>>>>    create mode 100644 target/hexagon/core-dump.h
>>>>>    create mode 100644 target/hexagon/arch_dump.c
>>>>>
>>>>> diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/
>>>>> hexagon_tlb.h
>>>>> index 355ba3888c0..938b80fbb2b 100644
>>>>> --- a/include/hw/hexagon/hexagon_tlb.h
>>>>> +++ b/include/hw/hexagon/hexagon_tlb.h
>>>>> @@ -26,6 +26,16 @@ struct HexagonTLBState {
>>>>>        QemuMutex lock;
>>>>>    };
>>>>>    +typedef struct HexagonTLBMapping {
>>>>> +    uint64_t va;        /* Start of the page, aligned to @size */
>>>>> +    uint64_t pa;        /* Start of the physical page */
>>>>> +    uint64_t size;      /* Page size in bytes */
>>>>> +    uint32_t asid;      /* Valid only when !@global */
>>>>> +    bool global;        /* Entry matches in every ASID */
>>>>> +} HexagonTLBMapping;
>>>>> +
>>>>> +bool hexagon_tlb_decode_entry(uint64_t entry, HexagonTLBMapping
>>>>> *mapping);
>>>>> +
>>>>>    uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index);
>>>>>    uint64_t hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index,
>>>>>                               uint64_t value);
>>>>> diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/
>>>>> target_elf.h
>>>>> index b1eb5ea5037..daaec521a76 100644
>>>>> --- a/linux-user/hexagon/target_elf.h
>>>>> +++ b/linux-user/hexagon/target_elf.h
>>>>> @@ -23,6 +23,13 @@
>>>>>      #define HAVE_ELF_HWCAP          1
>>>>>    +#include "target/hexagon/core-dump.h"
>>>>> +
>>>>> +#define HAVE_ELF_CORE_DUMP      1
>>>>> +#define elf_core_eflags(info)   ((info)->elf_flags)
>>>>> +
>>>>> +typedef HexagonUserRegs target_elf_gregset_t;
>>>>> +
>>>>>    enum {
>>>>>        HWCAP_HEXAGON_ISA_MASK          = 0x7F,
>>>>>        HWCAP_HEXAGON_ISA_V2            = 1,
>>>>> diff --git a/target/hexagon/core-dump.h b/target/hexagon/core-dump.h
>>>>> new file mode 100644
>>>>> index 00000000000..a14b495d04d
>>>>> --- /dev/null
>>>>> +++ b/target/hexagon/core-dump.h
>>>>> @@ -0,0 +1,73 @@
>>>>> +/*
>>>>> + * Hexagon Linux ELF core register layout.
>>>>> + *
>>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>> +
>>>>> +#ifndef HEXAGON_CORE_DUMP_H
>>>>> +#define HEXAGON_CORE_DUMP_H
>>>>> +
>>>>> +#include "cpu.h"
>>>>> +#include "qemu/bswap.h"
>>>>> +
>>>>> +/* Linux arch/hexagon/include/uapi/asm/user.h: struct
>>>>> user_regs_struct. */
>>>>> +typedef struct target_elf_gregset_t {
>>>>> +    uint32_t gpr[32];
>>>>> +    uint32_t sa0;
>>>>> +    uint32_t lc0;
>>>>> +    uint32_t sa1;
>>>>> +    uint32_t lc1;
>>>>> +    uint32_t m0;
>>>>> +    uint32_t m1;
>>>>> +    uint32_t usr;
>>>>> +    uint32_t p3_0;
>>>>> +    uint32_t gp;
>>>>> +    uint32_t ugp;
>>>>> +    uint32_t pc;
>>>>> +    uint32_t cause;
>>>>> +    uint32_t badva;
>>>>> +    uint32_t cs0;
>>>>> +    uint32_t cs1;
>>>>> +    uint32_t pad;
>>>>> +} HexagonUserRegs;
>>>>> +
>>>>> +QEMU_BUILD_BUG_ON(sizeof(HexagonUserRegs) != 48 * sizeof(uint32_t));
>>>>> +
>>>>> +static inline void hexagon_core_copy_regs(HexagonUserRegs *regs,
>>>>> +                                          const CPUHexagonState *env)
>>>>> +{
>>>>> +    uint32_t preds = 0;
>>>>> +
>>>>> +    for (int i = 0; i < ARRAY_SIZE(regs->gpr); i++) {
>>>>> +        regs->gpr[i] = cpu_to_le32(env->gpr[i]);
>>>>> +    }
>>>>> +    for (int i = 0; i < NUM_PREGS; i++) {
>>>>> +        preds |= (env->pred[i] & 0xff) << (i * 8);
>>>>> +    }
>>>>> +    regs->sa0 = cpu_to_le32(env->gpr[HEX_REG_SA0]);
>>>>> +    regs->lc0 = cpu_to_le32(env->gpr[HEX_REG_LC0]);
>>>>> +    regs->sa1 = cpu_to_le32(env->gpr[HEX_REG_SA1]);
>>>>> +    regs->lc1 = cpu_to_le32(env->gpr[HEX_REG_LC1]);
>>>>> +    regs->m0 = cpu_to_le32(env->gpr[HEX_REG_M0]);
>>>>> +    regs->m1 = cpu_to_le32(env->gpr[HEX_REG_M1]);
>>>>> +    regs->usr = cpu_to_le32(env->gpr[HEX_REG_USR]);
>>>>> +    regs->p3_0 = cpu_to_le32(preds);
>>>>> +    regs->gp = cpu_to_le32(env->gpr[HEX_REG_GP]);
>>>>> +    regs->ugp = cpu_to_le32(env->gpr[HEX_REG_UGP]);
>>>>> +    regs->pc = cpu_to_le32(env->gpr[HEX_REG_PC]);
>>>>> +#ifdef CONFIG_USER_ONLY
>>>>> +    regs->cause = cpu_to_le32(env->cause_code);
>>>>> +    regs->badva = 0;
>>>>> +#else
>>>>> +    regs->cause = cpu_to_le32(extract32(env->t_sreg[HEX_SREG_SSR],
>>>>> +                                     
>>>>> reg_field_info[SSR_CAUSE].offset,
>>>>> +
>>>>> reg_field_info[SSR_CAUSE].width));
>>>>> +    regs->badva = cpu_to_le32(env->t_sreg[HEX_SREG_BADVA]);
>>>>> +#endif
>>>>> +    regs->cs0 = cpu_to_le32(env->gpr[HEX_REG_CS0]);
>>>>> +    regs->cs1 = cpu_to_le32(env->gpr[HEX_REG_CS1]);
>>>>> +    regs->pad = 0;
>>>>> +}
>>>>> +
>>>>> +#endif /* HEXAGON_CORE_DUMP_H */
>>>>> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
>>>>> index 6def331a83a..1a5ff3daca2 100644
>>>>> --- a/target/hexagon/internal.h
>>>>> +++ b/target/hexagon/internal.h
>>>>> @@ -60,6 +60,14 @@ void G_NORETURN do_raise_exception(CPUHexagonState
>>>>> *env,
>>>>>      #ifndef CONFIG_USER_ONLY
>>>>>    extern const VMStateDescription vmstate_hexagon_cpu;
>>>>> +int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState
>>>>> *cs,
>>>>> +                                 int cpuid, DumpState *s);
>>>>> +void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>>>>> +                           const GuestPhysBlockList
>>>>> *guest_phys_blocks);
>>>>> +size_t hexagon_get_note_size(const CPUState *cs, int class, int
>>>>> machine,
>>>>> +                             int nr_cpus);
>>>>> +bool hexagon_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList
>>>>> *list,
>>>>> +                                    Error **errp);
>>>>>    #endif
>>>>>      #endif
>>>>> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
>>>>> index 07406cea35e..53b835cdd2b 100644
>>>>> --- a/hw/hexagon/hexagon_tlb.c
>>>>> +++ b/hw/hexagon/hexagon_tlb.c
>>>>> @@ -302,6 +302,23 @@ static bool hex_tlb_is_match(uint64_t entry1,
>>>>> uint64_t entry2,
>>>>>      /* Public API */
>>>>>    +bool hexagon_tlb_decode_entry(uint64_t entry, HexagonTLBMapping
>>>>> *mapping)
>>>>> +{
>>>>> +    uint64_t size;
>>>>> +
>>>>> +    if (!GET_PTE_V(entry)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    size = hex_tlb_page_size_bytes(entry);
>>>>> +    mapping->size = size;
>>>>> +    mapping->va = ROUND_DOWN(hex_tlb_virt_addr(entry), size);
>>>>> +    mapping->pa = hex_tlb_phys_addr(entry);
>>>>> +    mapping->global = GET_PTE_G(entry);
>>>>> +    mapping->asid = GET_PTE_ASID(entry);
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>    uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index)
>>>>>    {
>>>>>        g_assert(index < tlb->num_entries);
>>>>> diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/
>>>>> elfload.c
>>>>> index db0bf299cc0..dac8260b302 100644
>>>>> --- a/linux-user/hexagon/elfload.c
>>>>> +++ b/linux-user/hexagon/elfload.c
>>>>> @@ -6,6 +6,10 @@
>>>>>    #include "target_elf.h"
>>>>>    #include "target/hexagon/cpu.h"
>>>>>    +void elf_core_copy_regs(target_elf_gregset_t *regs, const
>>>>> CPUHexagonState *env)
>>>>> +{
>>>>> +    hexagon_core_copy_regs(regs, env);
>>>>> +}
>>>>>      abi_ulong get_elf_hwcap(CPUState *cs)
>>>>>    {
>>>>> diff --git a/target/hexagon/arch_dump.c b/target/hexagon/arch_dump.c
>>>>> new file mode 100644
>>>>> index 00000000000..1e90bf7285f
>>>>> --- /dev/null
>>>>> +++ b/target/hexagon/arch_dump.c
>>>>> @@ -0,0 +1,112 @@
>>>>> +/*
>>>>> + * Hexagon system guest ELF core dumps.
>>>>> + *
>>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +#include "cpu.h"
>>>>> +#include "elf.h"
>>>>> +#include "qapi/error.h"
>>>>> +#include "qemu/range.h"
>>>>> +#include "system/dump.h"
>>>>> +#include "system/memory_mapping.h"
>>>>> +#include "hw/hexagon/hexagon_tlb.h"
>>>>> +#include "internal.h"
>>>>> +#include "macros.h"
>>>>> +#include "sys_macros.h"
>>>>> +#include "core-dump.h"
>>>>> +
>>>>> +/* Linux include/linux/elfcore.h: struct elf_prstatus for the 32-bit
>>>>> ABI. */
>>>>> +typedef struct HexagonElfPrstatus {
>>>>> +    uint8_t pad1[24];
>>>>> +    uint32_t pr_pid;
>>>>> +    uint8_t pad2[44];
>>>>> +    HexagonUserRegs pr_reg;
>>>>> +    uint32_t pr_fpvalid;
>>>>> +} QEMU_PACKED HexagonElfPrstatus;
>>>>> +
>>>>> +QEMU_BUILD_BUG_ON(offsetof(HexagonElfPrstatus, pr_reg) != 72);
>>>>> +QEMU_BUILD_BUG_ON(sizeof(HexagonElfPrstatus) != 268);
>>>>> +
>>>>> +typedef struct HexagonElfNote {
>>>>> +    Elf32_Nhdr header;
>>>>> +    char name[8]; /* "CORE" including NUL, padded to a 4-byte
>>>>> boundary. */
>>>>> +    HexagonElfPrstatus prstatus;
>>>>> +} QEMU_PACKED HexagonElfNote;
>>>>> +
>>>>> +int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState
>>>>> *cs,
>>>>> +                                 int cpuid, DumpState *s)
>>>>> +{
>>>>> +    HexagonElfNote note = { 0 };
>>>>> +    HexagonUserRegs regs;
>>>>> +
>>>>> +    note.header.n_namesz = cpu_to_dump32(s, sizeof("CORE"));
>>>>> +    note.header.n_descsz = cpu_to_dump32(s, sizeof(note.prstatus));
>>>>> +    note.header.n_type = cpu_to_dump32(s, NT_PRSTATUS);
>>>>> +    memcpy(note.name, "CORE", sizeof("CORE"));
>>>>> +    note.prstatus.pr_pid = cpu_to_dump32(s, cpuid);
>>>>> +    hexagon_core_copy_regs(&regs, cpu_env(cs));
>>>>> +    memcpy(&note.prstatus.pr_reg, &regs, sizeof(regs));
>>>>> +
>>>>> +    return f(&note, sizeof(note), s);
>>>>> +}
>>>>> +
>>>>> +void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>>>>> +                           const GuestPhysBlockList
>>>>> *guest_phys_blocks)
>>>>> +{
>>>>> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
>>>>> +
>>>>> +    info->d_machine = EM_HEXAGON;
>>>>> +    info->d_class = ELFCLASS32;
>>>>> +    info->d_endian = ELFDATA2LSB;
>>>>> +    /* The values of HexagonVersion match the EF_HEXAGON_MACH_*
>>>>> flags. */
>>>>> +    info->d_flags = cpu->cfg.hex_def->hex_version;
>>>>> +}
>>>>> +
>>>>> +size_t hexagon_get_note_size(const CPUState *cs, int class, int
>>>>> machine,
>>>>> +                             int nr_cpus)
>>>>> +{
>>>>> +    return sizeof(HexagonElfNote) * nr_cpus;
>>>>> +}
>>>>> +
>>>>> +static bool hexagon_mapping_overlaps(const MemoryMappingList *list,
>>>>> +                                     const HexagonTLBMapping *m)
>>>>> +{
>>>>> +    const MemoryMapping *other;
>>>>> +
>>>>> +    QTAILQ_FOREACH(other, &list->head, next) {
>>>>> +        if (ranges_overlap(other->virt_addr, other->length, m->va,
>>>>> m->size)) {
>>>>> +            return true;
>>>>> +        }
>>>>> +    }
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>> +bool hexagon_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList
>>>>> *list,
>>>>> +                                    Error **errp)
>>>>> +{
>>>>> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
>>>>> +    uint32_t asid = GET_SSR_FIELD(SSR_ASID,
>>>>> +                                  cpu_env(cs)->t_sreg[HEX_SREG_SSR]);
>>>>> +    uint32_t num_entries;
>>>>> +
>>>>> +    if (!cpu->tlb) {
>>>>> +        error_setg(errp, "Hexagon CPU has no TLB");
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>> In this case, shouldn't we assume it's an identity mapping?
>>> Hmm - the behavior is not defined, there's no such hardware device.
>>>
>>> I could change it to an assertion instead if that makes more sense?
>>>
>> Double checking, in system mode, we always have a tlb, it's enforced at
>> realize_step for the cpu.
> 
> Yeah - good point, so maybe an assertion makes more sense here. I'll
> make this change.
> 
>> I am a bit puzzled this compiles since this field is not even defined in
>> user-mode builds.
> 
> target/hexagon/arch_dump.c is only built in sysemu.
>

Ok. I have been confused by the multiple files in current patch,
arch_dump is limited to the kind of info we would have in system mode
only. Sounds good.

With the assert on cpu->tlb:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 Regards,
Pierrick

