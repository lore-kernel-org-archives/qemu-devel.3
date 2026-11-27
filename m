Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S6pYvjro;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B9M/qtY3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzol-0008Ij-EG; Fri, 27 Nov 2026 12:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWzoi-0008IZ-SS
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:33:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWzof-0001uk-NV
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:33:00 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFpGll2925216
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ZbML0h6E+xyPY4f24VvnqQJbBleZAVvWsJKlY+wwwc=; b=S6pYvjrob0PRcHvR
 yiUFofKZOL7zLvYVvo8haPxtptuTwYAarqiCiL9H8rSP7ImRQu+dy8TyBeItudr3
 MHX/8wZpVYovFeV11dv5mn7nmuGOk1N67pilpYSKirp3mFwGfoatgPSFdb8tUqLh
 qqxfE/5EL93sbIhsqpLfmVJp44kkKvLHytPD7d9R2j5qKhae/mqJSHtLNF915FUv
 PuT/MprX/f4ZX1la6xjpwbmqIAu+c7GPdoYv+BJNSBbMKqZ3d+eQk6DuI6HkuOXw
 +UELN0kplkqEnJdZZjURyVzqcaJC38XFgq2TUFwC4isN/TtQOiXkPAN7+uzkvSfk
 T3jGwg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhjnae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:32:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3854627c1c8so10878843eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795800775; x=1796405575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0ZbML0h6E+xyPY4f24VvnqQJbBleZAVvWsJKlY+wwwc=;
 b=B9M/qtY3I+qmEh47eApRDXeFomSU1FPVbKRBgZUQ2VHzaJD5tvoFKVSRMIsEkANfpw
 O2Uo5nO2GQW/Kg9biOVLnQ4sA3Ph8PCS7JGp89XXsf97YaoHNdaLVf05f0F8Uyc7LukY
 byUP5VRyT4+3zZ/LNXObCo5IsnR3RYQyITCnV63/YPhXpX/l42KuTUOi0gqEBzJ6scjZ
 LURIHZTgDW4JpBKnrLTr0Mw9ZZD5VjUPgK7DEaC9oh8YQPGmhoWiMOIvIG2RL9/YlHDC
 6S5qdArx992Yx8gJyFrzf8bmt0IM2ZNlwLp93zq3OgnSMVSf4G+vfLswO+laySNBWIM+
 nQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800775; x=1796405575;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ZbML0h6E+xyPY4f24VvnqQJbBleZAVvWsJKlY+wwwc=;
 b=fHhWhhOlXo308KmbPaATpGTuZGvNtTaqLHM4BLE6UPxPbifChaaSdHo0iXQoT6udcg
 44rFnWEKbTqUsfLqldkBJNtFMIJ0O5AeCdIoMlbwtuJ6rYy/C9HxvqvJQROfJ9DUTnQO
 PNR87rPZrIMBY5EyTFydbI775wX9npOV5Ytnk1ciWqmXOqifpNSOk1MLZpru6ORL/Y6G
 3Sr3/QcpL9hqA/yRXQbmPZWD9A3UgCIiwmEvq/nlCel8QDxPLZzkPR8lpZxTDfXmAhGt
 nIgFCgsXV9AElfqsOKZjwUxBy/o/pFiIYfHQ1IOu2G6bcHTONkMthZ3oy4yuF2ADiYIp
 eMrg==
X-Forwarded-Encrypted: i=1;
 AL+hErE976ux1xeHUSf0OqY3Gh5Rh69m09nSinZRVvO8BMPs6Y+yiLoPdhb7/fXGl9BBKZ6L4Dk8wuuCJAJ9@nongnu.org
X-Gm-Message-State: APuU4Z9M5UTNPgVlekQJS27eeEi0nJkclyMsb8VmUBPTa/lUpLiLVMhW
 HQW1lwejMHL9XS2tnB+SSLzK6tDJYVx+Cu7LUZCGP5sBnQgImWJ3YP0/p+ShpEzdNS5t3nsdpe1
 VNM3Om3eBkUvCVPDgyDV8SmJOQrl3mh1k0lXK2g3k9pHdr+ag2HkKb8JKbg==
X-Gm-Gg: AZFdTZejceE1yT+22RO2eboF3u7N1CY+iJsQxDKVrZhxx14vNq1oU15tPi1wDPtnChW
 dbJQVmFLsv9N4LE1TD9w5qn7pJmOFTcB5o2cATJL/qMyBlE7XTLCz5MuTseB6THsBtuIsFGwfDX
 uG4uuAphc8LOhan1xyKxX9TuQpYPxT69fvjcEm1AyHNZwUGM3/KxmdkKMWnBVWdhYzV0kfn1Fsq
 FgadkInbOUp4NvELi1448UfTVB3nlBEhzn5mdUSoKZ9lnUN2BAVzgpan6NvZiIwsEJRxUyIY2FN
 8D46OleRzLd/kP7Z008VpaDxKIf4+yY1gaQ9fuLahMO3EszUXFVfVPD8d7cbvEq79i+J3RciNF0
 mbQTblsWOGmJXAexlDLPDr11m1uiTSnn8T8BsU2liB2zwDDxzkNCvo3l+Lnf9bRUde+7+3Wpz9p
 zITxAOJWIAxWhuTjv8Vc2OM5aOQl0W/zUKG2dHdjCovpSP6Q4iAjqn
X-Received: by 2002:a05:7300:1909:b0:383:f646:9feb with SMTP id
 5a478bee46e88-3856c4b8304mr36840519eec.2.1795800774777; 
 Fri, 27 Nov 2026 09:32:54 -0800 (PST)
X-Received: by 2002:a05:7300:1909:b0:383:f646:9feb with SMTP id
 5a478bee46e88-3856c4b8304mr36840464eec.2.1795800774070; 
 Fri, 27 Nov 2026 09:32:54 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm62264131eec.25.2026.11.27.09.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:32:53 -0800 (PST)
Message-ID: <d24abd48-66cf-45c0-a49b-ed98a85b88ed@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:32:52 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 4/5] target/hexagon: support ELF core dumps
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <20261125194855.3154845-5-brian.cain@oss.qualcomm.com>
 <692d2bbf-cc9b-4cf5-ab05-43a2f13d8336@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <692d2bbf-cc9b-4cf5-ab05-43a2f13d8336@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfXxGh3sXQAs6ER
 RV+CkGgxE3fvfJ7qp4oiO5IReRyuzp1YQ67BNzVa07tNmgM3TfE6KuAxZgdLrbIfDxLFLpM5tGf
 jNMjApMt4XUDICaLm1QCYNCPKZqIdvY=
X-Proofpoint-ORIG-GUID: 6IkzRQ0CXSaGKPrd5FyT3RFBhbjfce76
X-Proofpoint-GUID: 6IkzRQ0CXSaGKPrd5FyT3RFBhbjfce76
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09bec7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Z3ZK5giyIQ1q5ym7mT4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX1ycjxA/12WYF
 CFx1Ay3X1uS+e4rGY3EUMAkjnX9AEnBVttWPDLcRJWOsIbHxBbc1xwoFhOucFh6FD3vsEXZ3zmw
 TKRY6/gljAnk/RJF/e4TxToh1FDsm3GdQvHME5cvb4Z08WYiH5tGmPGjIm58D/VuJ/IMwmpf8uh
 KD42TLAVdfV6YueVti/xlC32SqWT3B7O91hMrqBb7x8BRxVF9izBCUP/GVpjacTrBF/NPJdt8Rp
 X89JPdbqCrJpxBuQXwv1aw1BwtHwUBQhhhfQS4mZAssfqvCaAcARYOUlng//ShoR5QkL2Nl5iyL
 v6b5UXZ2qBLY470DTvDsmzLWgWE0njgA20qy897gtG2ldlnfLvktPg7w2mMREzx/ph0r8/KDKQY
 Qx+0hnyUrf96wr4PfNS7xVmDoPE7I7Wmq+I6Xq4R5ZEbK7BK92q1nN8nCMdKH1gMAzNyC8Czcfg
 WYZp1Og4uFqoncbGjJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/27/2026 11:29 AM, Pierrick Bouvier wrote:
> On 11/25/2026 11:48 AM, Brian Cain wrote:
>> Write core files for Hexagon.  For each hw thread, write a note w/
>> user_regs_struct layout from linux kernel.
>>
>> In system mode the cause register is filled from SSR, badva from the system
>> register, and pr_pid is the CPU index.
>>
>> dump-guest-memory with paging requested relies on the CPU's
>> get_memory_mapping and get_paging_enabled callbacks.  Implement
>> get_paging_enabled.
>>
>> Build the mappings from the valid TLB entries: for each CPU, consider global
>> entries and those matching the CPU's current ASID.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   include/hw/hexagon/hexagon_tlb.h |  10 +++
>>   linux-user/hexagon/target_elf.h  |   7 ++
>>   target/hexagon/core-dump.h       |  73 ++++++++++++++++++++
>>   target/hexagon/internal.h        |   8 +++
>>   hw/hexagon/hexagon_tlb.c         |  17 +++++
>>   linux-user/hexagon/elfload.c     |   4 ++
>>   target/hexagon/arch_dump.c       | 112 +++++++++++++++++++++++++++++++
>>   target/hexagon/cpu.c             |  13 ++++
>>   target/hexagon/meson.build       |   1 +
>>   9 files changed, 245 insertions(+)
>>   create mode 100644 target/hexagon/core-dump.h
>>   create mode 100644 target/hexagon/arch_dump.c
>>
>> diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
>> index 355ba3888c0..938b80fbb2b 100644
>> --- a/include/hw/hexagon/hexagon_tlb.h
>> +++ b/include/hw/hexagon/hexagon_tlb.h
>> @@ -26,6 +26,16 @@ struct HexagonTLBState {
>>       QemuMutex lock;
>>   };
>>   
>> +typedef struct HexagonTLBMapping {
>> +    uint64_t va;        /* Start of the page, aligned to @size */
>> +    uint64_t pa;        /* Start of the physical page */
>> +    uint64_t size;      /* Page size in bytes */
>> +    uint32_t asid;      /* Valid only when !@global */
>> +    bool global;        /* Entry matches in every ASID */
>> +} HexagonTLBMapping;
>> +
>> +bool hexagon_tlb_decode_entry(uint64_t entry, HexagonTLBMapping *mapping);
>> +
>>   uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index);
>>   uint64_t hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index,
>>                              uint64_t value);
>> diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
>> index b1eb5ea5037..daaec521a76 100644
>> --- a/linux-user/hexagon/target_elf.h
>> +++ b/linux-user/hexagon/target_elf.h
>> @@ -23,6 +23,13 @@
>>   
>>   #define HAVE_ELF_HWCAP          1
>>   
>> +#include "target/hexagon/core-dump.h"
>> +
>> +#define HAVE_ELF_CORE_DUMP      1
>> +#define elf_core_eflags(info)   ((info)->elf_flags)
>> +
>> +typedef HexagonUserRegs target_elf_gregset_t;
>> +
>>   enum {
>>       HWCAP_HEXAGON_ISA_MASK          = 0x7F,
>>       HWCAP_HEXAGON_ISA_V2            = 1,
>> diff --git a/target/hexagon/core-dump.h b/target/hexagon/core-dump.h
>> new file mode 100644
>> index 00000000000..a14b495d04d
>> --- /dev/null
>> +++ b/target/hexagon/core-dump.h
>> @@ -0,0 +1,73 @@
>> +/*
>> + * Hexagon Linux ELF core register layout.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HEXAGON_CORE_DUMP_H
>> +#define HEXAGON_CORE_DUMP_H
>> +
>> +#include "cpu.h"
>> +#include "qemu/bswap.h"
>> +
>> +/* Linux arch/hexagon/include/uapi/asm/user.h: struct user_regs_struct. */
>> +typedef struct target_elf_gregset_t {
>> +    uint32_t gpr[32];
>> +    uint32_t sa0;
>> +    uint32_t lc0;
>> +    uint32_t sa1;
>> +    uint32_t lc1;
>> +    uint32_t m0;
>> +    uint32_t m1;
>> +    uint32_t usr;
>> +    uint32_t p3_0;
>> +    uint32_t gp;
>> +    uint32_t ugp;
>> +    uint32_t pc;
>> +    uint32_t cause;
>> +    uint32_t badva;
>> +    uint32_t cs0;
>> +    uint32_t cs1;
>> +    uint32_t pad;
>> +} HexagonUserRegs;
>> +
>> +QEMU_BUILD_BUG_ON(sizeof(HexagonUserRegs) != 48 * sizeof(uint32_t));
>> +
>> +static inline void hexagon_core_copy_regs(HexagonUserRegs *regs,
>> +                                          const CPUHexagonState *env)
>> +{
>> +    uint32_t preds = 0;
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(regs->gpr); i++) {
>> +        regs->gpr[i] = cpu_to_le32(env->gpr[i]);
>> +    }
>> +    for (int i = 0; i < NUM_PREGS; i++) {
>> +        preds |= (env->pred[i] & 0xff) << (i * 8);
>> +    }
>> +    regs->sa0 = cpu_to_le32(env->gpr[HEX_REG_SA0]);
>> +    regs->lc0 = cpu_to_le32(env->gpr[HEX_REG_LC0]);
>> +    regs->sa1 = cpu_to_le32(env->gpr[HEX_REG_SA1]);
>> +    regs->lc1 = cpu_to_le32(env->gpr[HEX_REG_LC1]);
>> +    regs->m0 = cpu_to_le32(env->gpr[HEX_REG_M0]);
>> +    regs->m1 = cpu_to_le32(env->gpr[HEX_REG_M1]);
>> +    regs->usr = cpu_to_le32(env->gpr[HEX_REG_USR]);
>> +    regs->p3_0 = cpu_to_le32(preds);
>> +    regs->gp = cpu_to_le32(env->gpr[HEX_REG_GP]);
>> +    regs->ugp = cpu_to_le32(env->gpr[HEX_REG_UGP]);
>> +    regs->pc = cpu_to_le32(env->gpr[HEX_REG_PC]);
>> +#ifdef CONFIG_USER_ONLY
>> +    regs->cause = cpu_to_le32(env->cause_code);
>> +    regs->badva = 0;
>> +#else
>> +    regs->cause = cpu_to_le32(extract32(env->t_sreg[HEX_SREG_SSR],
>> +                                      reg_field_info[SSR_CAUSE].offset,
>> +                                      reg_field_info[SSR_CAUSE].width));
>> +    regs->badva = cpu_to_le32(env->t_sreg[HEX_SREG_BADVA]);
>> +#endif
>> +    regs->cs0 = cpu_to_le32(env->gpr[HEX_REG_CS0]);
>> +    regs->cs1 = cpu_to_le32(env->gpr[HEX_REG_CS1]);
>> +    regs->pad = 0;
>> +}
>> +
>> +#endif /* HEXAGON_CORE_DUMP_H */
>> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
>> index 6def331a83a..1a5ff3daca2 100644
>> --- a/target/hexagon/internal.h
>> +++ b/target/hexagon/internal.h
>> @@ -60,6 +60,14 @@ void G_NORETURN do_raise_exception(CPUHexagonState *env,
>>   
>>   #ifndef CONFIG_USER_ONLY
>>   extern const VMStateDescription vmstate_hexagon_cpu;
>> +int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>> +                                 int cpuid, DumpState *s);
>> +void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>> +                           const GuestPhysBlockList *guest_phys_blocks);
>> +size_t hexagon_get_note_size(const CPUState *cs, int class, int machine,
>> +                             int nr_cpus);
>> +bool hexagon_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
>> +                                    Error **errp);
>>   #endif
>>   
>>   #endif
>> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
>> index 07406cea35e..53b835cdd2b 100644
>> --- a/hw/hexagon/hexagon_tlb.c
>> +++ b/hw/hexagon/hexagon_tlb.c
>> @@ -302,6 +302,23 @@ static bool hex_tlb_is_match(uint64_t entry1, uint64_t entry2,
>>   
>>   /* Public API */
>>   
>> +bool hexagon_tlb_decode_entry(uint64_t entry, HexagonTLBMapping *mapping)
>> +{
>> +    uint64_t size;
>> +
>> +    if (!GET_PTE_V(entry)) {
>> +        return false;
>> +    }
>> +
>> +    size = hex_tlb_page_size_bytes(entry);
>> +    mapping->size = size;
>> +    mapping->va = ROUND_DOWN(hex_tlb_virt_addr(entry), size);
>> +    mapping->pa = hex_tlb_phys_addr(entry);
>> +    mapping->global = GET_PTE_G(entry);
>> +    mapping->asid = GET_PTE_ASID(entry);
>> +    return true;
>> +}
>> +
>>   uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index)
>>   {
>>       g_assert(index < tlb->num_entries);
>> diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
>> index db0bf299cc0..dac8260b302 100644
>> --- a/linux-user/hexagon/elfload.c
>> +++ b/linux-user/hexagon/elfload.c
>> @@ -6,6 +6,10 @@
>>   #include "target_elf.h"
>>   #include "target/hexagon/cpu.h"
>>   
>> +void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUHexagonState *env)
>> +{
>> +    hexagon_core_copy_regs(regs, env);
>> +}
>>   
>>   abi_ulong get_elf_hwcap(CPUState *cs)
>>   {
>> diff --git a/target/hexagon/arch_dump.c b/target/hexagon/arch_dump.c
>> new file mode 100644
>> index 00000000000..1e90bf7285f
>> --- /dev/null
>> +++ b/target/hexagon/arch_dump.c
>> @@ -0,0 +1,112 @@
>> +/*
>> + * Hexagon system guest ELF core dumps.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "elf.h"
>> +#include "qapi/error.h"
>> +#include "qemu/range.h"
>> +#include "system/dump.h"
>> +#include "system/memory_mapping.h"
>> +#include "hw/hexagon/hexagon_tlb.h"
>> +#include "internal.h"
>> +#include "macros.h"
>> +#include "sys_macros.h"
>> +#include "core-dump.h"
>> +
>> +/* Linux include/linux/elfcore.h: struct elf_prstatus for the 32-bit ABI. */
>> +typedef struct HexagonElfPrstatus {
>> +    uint8_t pad1[24];
>> +    uint32_t pr_pid;
>> +    uint8_t pad2[44];
>> +    HexagonUserRegs pr_reg;
>> +    uint32_t pr_fpvalid;
>> +} QEMU_PACKED HexagonElfPrstatus;
>> +
>> +QEMU_BUILD_BUG_ON(offsetof(HexagonElfPrstatus, pr_reg) != 72);
>> +QEMU_BUILD_BUG_ON(sizeof(HexagonElfPrstatus) != 268);
>> +
>> +typedef struct HexagonElfNote {
>> +    Elf32_Nhdr header;
>> +    char name[8]; /* "CORE" including NUL, padded to a 4-byte boundary. */
>> +    HexagonElfPrstatus prstatus;
>> +} QEMU_PACKED HexagonElfNote;
>> +
>> +int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>> +                                 int cpuid, DumpState *s)
>> +{
>> +    HexagonElfNote note = { 0 };
>> +    HexagonUserRegs regs;
>> +
>> +    note.header.n_namesz = cpu_to_dump32(s, sizeof("CORE"));
>> +    note.header.n_descsz = cpu_to_dump32(s, sizeof(note.prstatus));
>> +    note.header.n_type = cpu_to_dump32(s, NT_PRSTATUS);
>> +    memcpy(note.name, "CORE", sizeof("CORE"));
>> +    note.prstatus.pr_pid = cpu_to_dump32(s, cpuid);
>> +    hexagon_core_copy_regs(&regs, cpu_env(cs));
>> +    memcpy(&note.prstatus.pr_reg, &regs, sizeof(regs));
>> +
>> +    return f(&note, sizeof(note), s);
>> +}
>> +
>> +void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>> +                           const GuestPhysBlockList *guest_phys_blocks)
>> +{
>> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
>> +
>> +    info->d_machine = EM_HEXAGON;
>> +    info->d_class = ELFCLASS32;
>> +    info->d_endian = ELFDATA2LSB;
>> +    /* The values of HexagonVersion match the EF_HEXAGON_MACH_* flags. */
>> +    info->d_flags = cpu->cfg.hex_def->hex_version;
>> +}
>> +
>> +size_t hexagon_get_note_size(const CPUState *cs, int class, int machine,
>> +                             int nr_cpus)
>> +{
>> +    return sizeof(HexagonElfNote) * nr_cpus;
>> +}
>> +
>> +static bool hexagon_mapping_overlaps(const MemoryMappingList *list,
>> +                                     const HexagonTLBMapping *m)
>> +{
>> +    const MemoryMapping *other;
>> +
>> +    QTAILQ_FOREACH(other, &list->head, next) {
>> +        if (ranges_overlap(other->virt_addr, other->length, m->va, m->size)) {
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +bool hexagon_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
>> +                                    Error **errp)
>> +{
>> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
>> +    uint32_t asid = GET_SSR_FIELD(SSR_ASID,
>> +                                  cpu_env(cs)->t_sreg[HEX_SREG_SSR]);
>> +    uint32_t num_entries;
>> +
>> +    if (!cpu->tlb) {
>> +        error_setg(errp, "Hexagon CPU has no TLB");
>> +        return false;
>> +    }
>> +
> In this case, shouldn't we assume it's an identity mapping?

Hmm - the behavior is not defined, there's no such hardware device.

I could change it to an assertion instead if that makes more sense?

>
>> +    num_entries = hexagon_tlb_get_num_entries(cpu->tlb);
>> +    for (uint32_t i = 0; i < num_entries; i++) {
>> +        HexagonTLBMapping m;
>> +
>> +        if (!hexagon_tlb_decode_entry(hexagon_tlb_read(cpu->tlb, i), &m) ||
>> +            (!m.global && m.asid != asid) ||
>> +            hexagon_mapping_overlaps(list, &m)) {
>> +            continue;
>> +        }
>> +        memory_mapping_list_add_merge_sorted(list, m.pa, m.va, m.size);
>> +    }
>> +    return true;
>> +}
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 3575b31d196..5f7f22fa2ea 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -870,9 +870,22 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
>>   
>>   #include "hw/core/sysemu-cpu-ops.h"
>>   
>> +static bool hexagon_cpu_get_paging_enabled(const CPUState *cs)
>> +{
>> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
>> +
>> +    return GET_SYSCFG_FIELD(SYSCFG_MMUEN,
>> +        hexagon_globalreg_read_syscfg_unlocked(cpu->globalregs));
>> +}
>> +
>>   static const struct SysemuCPUOps hexagon_sysemu_ops = {
>>       .has_work = hexagon_cpu_has_work,
>> +    .get_memory_mapping = hexagon_cpu_get_memory_mapping,
>> +    .get_paging_enabled = hexagon_cpu_get_paging_enabled,
>>       .translate_for_debug = hexagon_cpu_translate_for_debug,
>> +    .write_elf32_note = hexagon_cpu_write_elf32_note,
>> +    .get_dump_info = hexagon_get_dump_info,
>> +    .get_note_size = hexagon_get_note_size,
>>   };
>>   
>>   static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
>> index db65edcba54..b9b2a2d9740 100644
>> --- a/target/hexagon/meson.build
>> +++ b/target/hexagon/meson.build
>> @@ -314,6 +314,7 @@ hexagon_ss.add(files(
>>   ))
>>   
>>   hexagon_softmmu_ss.add(files(
>> +    'arch_dump.c',
>>       'cpu_helper.c',
>>       'hex_mmu.c',
>>       'hex_interrupts.c',
> For the rest, it looks good to me.
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> Regards,
> Pierrick

