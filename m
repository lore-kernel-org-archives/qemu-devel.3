Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC907606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YAghQu61;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=enJUb6a8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzl9-0006o1-6l; Fri, 27 Nov 2026 12:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzl7-0006nd-3C
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:29:17 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzl4-0006AH-E6
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:29:16 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARHHDHL2800537
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QJcphU1TvpQdviB5+PG+hxtwISCnhTZYJdnfZWvxZAs=; b=YAghQu61o9tbV4oH
 PsgtpsFJiuaFhcmqVcDQm5hCOitqGEjZlqFOLBe/Z3mqY+eXjLPemJkRDk1qBvpX
 VRXJ3EkujDqNho/ewEIixwoLa5rSILsHO3QsKVzZajpOGtdhEF/dm60BikRbwpll
 uyK5+f0m6EaIH+KULG7ozX6mIQqshxU+JXyTGEUDxze2pgPv07mItHuR9n0JGfTm
 RWL12Kv3YjcAeMFadEztxCaO6MYBGwNWs8zri+aqS9MVJc5gFPnE3Oi7UJu/Rz7u
 hndbF7OSSpeMiquogYU99g7xkz7oxKZWfEXNPTL+N7jrBEW2ZXNXMC4GZ8wZaDkc
 6kGikg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e4ng129-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:29:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-382af5cfc58so6174757eec.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795800551; x=1796405351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QJcphU1TvpQdviB5+PG+hxtwISCnhTZYJdnfZWvxZAs=;
 b=enJUb6a8aLXRiwWIBG9LqJiOajmVji7bYUt/UwfuErNRgdVimCqOZwrNs+nb6QN+yD
 nqKqKpqjWHgQoEktrOb+RGwhgn3XSlptQl0I/WETVjmgy06eEr+NkoxO5FLWwHFqGa7o
 sLFrvFW1e244cEt2vDNAziCM0uq8caFkgP9GZCuZeX7JkNN6i9a1EwOJZotj1q4hP1Km
 Kz3PCwKyVGY7bQ8/FXEdXs/leigIe2Mxvv2ZXZJKvrznBvYbTVmThTD4T8PZmqGGeF3E
 NdOgGPJWdGnHpJjYvzIgvxnmBg8/qZn6Ehp4VSHaAbK93Guta44JGfKaRMYgyK4QJ741
 CcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800551; x=1796405351;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QJcphU1TvpQdviB5+PG+hxtwISCnhTZYJdnfZWvxZAs=;
 b=TYbx830Jb1BMijpQQRaSzJPwLX4WUys3X2vfAKa/w2TK9TCKOAqEHVPTxQsmogVEan
 Gm1mw20DovwvLwffu6ij503L/moj+InounAJlbi5mYDOaKgEAokHkqk3JyRZWZic3Hex
 BU/DQJkzYhUnjJWg9YrpgXFR1I3wMsxjzqCowUZwktdA0FeofDf9bpCE0Mz0uSOhnKBa
 u4hDPbOHpqk2mqokEWk4JRp5Ylr+VYPWVMsxdsXhWGphpjIEN4JWVhOwnCzibvU64kNH
 qkrrPoq1iQRJR3Z66QWeocFCOqZ+snOd4kYhaE0DM3agp9kvPLWadCKSkxPkI4SmYoGu
 9BWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG/caDWXCXYBAk/ByYAq8xH3LDjXReci/j2LyFUm+uYYBU5I7BDsJRsR3yQXAe82I45DSYj00bo/Bnx@nongnu.org
X-Gm-Message-State: APuU4Z/ZJyh2fOFk1/+lkQWL5+vamWHfpuIu2o/nyjxEdZ1DePNwY3MJ
 +T23rW+jVJH8MxNHGUvTChlkAq3HsVFOTNoIDVWKLPI753dQHvdQl8HHjgtp8r+kyI5gwH/U1mj
 AOa4EY2mnff7ndeAtZqZrd13MFNak/t2wON+ghgKUWu+P405Q9Y9QgiT/Og==
X-Gm-Gg: AZFdTZc4EkFh7Eoo5wvokEgM3x0dD26LkiwkEv/p6WMCOdUXIn9roSHaweHyMSTRM3Z
 X3n4onRez0R3h8mca1p9skOOaNKGq6o9WSFKz7QXe8fo4E0FNFhs9vDwplLn/UJbz9EubunemW+
 1T9vRSaA8Ai9xsZ6edsLc/T+CqgGJcBxepTb4fjJZl6OS7osSAzkcwhYcpb9rL3wWJ1hkqRpZvt
 oe4XKTpebsgbdPWsnfTnWbqX4tGVtFrktheCLlhz4WE2xFlQU2c4xZDQnrHq72y0fPrnYqni/W3
 2oM6dgrToGRf2QWrq13V5hOcM2xr1XaZWmnIEpugaZemOs65jKb/3fbrk7O4VnnmOro6cngQaAm
 GcyR7GsUq4tcSB0BkIXUgbURcfMn5iyl713K5PXxjGZazvym8Oe6oplQ/sSjQ+I8INYQHGLu43k
 mqnqr2eYWFgOgdzBWnhmHuZxmB3vD8xBZJPgB3mTfAuNA=
X-Received: by 2002:a05:7301:1a08:b0:386:9f4c:e07f with SMTP id
 5a478bee46e88-3869f4ce1d9mr21342643eec.14.1795800551421; 
 Fri, 27 Nov 2026 09:29:11 -0800 (PST)
X-Received: by 2002:a05:7301:1a08:b0:386:9f4c:e07f with SMTP id
 5a478bee46e88-3869f4ce1d9mr21342626eec.14.1795800550832; 
 Fri, 27 Nov 2026 09:29:10 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385c6830815sm67112656eec.20.2026.11.27.09.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:29:10 -0800 (PST)
Message-ID: <692d2bbf-cc9b-4cf5-ab05-43a2f13d8336@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:29:09 -0800
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261125194855.3154845-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfXwcm5dDQvtbz9
 eDo0kIoF8PvbsW41jg9SaPFyFEyo+d0BH2Erbysbs/arnjq5xARs5wgLgmwSyf+CwaPJYsOcmIh
 XWS/wamUOEKnCFP79EiFaWpQ9dozOxA=
X-Proofpoint-GUID: Dj-ut3dmnWs0Ejn71731XfMj4eghakK9
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6b09bde8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=3qoTfXMEVEJucncAD0wA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Dj-ut3dmnWs0Ejn71731XfMj4eghakK9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX5JM7tx7Hay2e
 WSDrkb8B6Zcr7RTcLfoVM1xvhmiU23dL9T7lYZj980J7pJqOfFAJQeoF+FwKKjOU/v8HdM1/Fbx
 Mm0EwKSr1Xx0+lt6qs8GEF5Ugwr1f92/7lQS2tyvR39O10Yl8U6IWvBFB410rBwcbDI7KVyYWNQ
 CBPXQv4d0wwZS5mxm2b0uUYF6Ti8jN3VSnOMmoR1yTLBP4N8fohVoBSREhNCrHqUaVbTPxzWA1B
 pH2e92J9JRkXVaf0f2sdUMylQEPxyFoEutkuwMTUtp2OojNFPraAChLd963PjV1R/CmGR0/5M4y
 44Lryy2CszaJXKu5U4nnAkViTZ5+MnY/mLBiWjVZbXTy3zdAAVbAKkcCfdjEejGvPyPgT86xgjr
 duEVEvKsqTSk/FAu9H141GPj7cLKZjVtWqe6Zsj8JBd2EqYR8rinog8bj/VxSbva984RLfjJEtg
 EIdqWmjBYDi6cW//hiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270069
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

On 11/25/2026 11:48 AM, Brian Cain wrote:
> Write core files for Hexagon.  For each hw thread, write a note w/
> user_regs_struct layout from linux kernel.
> 
> In system mode the cause register is filled from SSR, badva from the system
> register, and pr_pid is the CPU index.
> 
> dump-guest-memory with paging requested relies on the CPU's
> get_memory_mapping and get_paging_enabled callbacks.  Implement
> get_paging_enabled.
> 
> Build the mappings from the valid TLB entries: for each CPU, consider global
> entries and those matching the CPU's current ASID.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_tlb.h |  10 +++
>  linux-user/hexagon/target_elf.h  |   7 ++
>  target/hexagon/core-dump.h       |  73 ++++++++++++++++++++
>  target/hexagon/internal.h        |   8 +++
>  hw/hexagon/hexagon_tlb.c         |  17 +++++
>  linux-user/hexagon/elfload.c     |   4 ++
>  target/hexagon/arch_dump.c       | 112 +++++++++++++++++++++++++++++++
>  target/hexagon/cpu.c             |  13 ++++
>  target/hexagon/meson.build       |   1 +
>  9 files changed, 245 insertions(+)
>  create mode 100644 target/hexagon/core-dump.h
>  create mode 100644 target/hexagon/arch_dump.c
> 
> diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
> index 355ba3888c0..938b80fbb2b 100644
> --- a/include/hw/hexagon/hexagon_tlb.h
> +++ b/include/hw/hexagon/hexagon_tlb.h
> @@ -26,6 +26,16 @@ struct HexagonTLBState {
>      QemuMutex lock;
>  };
>  
> +typedef struct HexagonTLBMapping {
> +    uint64_t va;        /* Start of the page, aligned to @size */
> +    uint64_t pa;        /* Start of the physical page */
> +    uint64_t size;      /* Page size in bytes */
> +    uint32_t asid;      /* Valid only when !@global */
> +    bool global;        /* Entry matches in every ASID */
> +} HexagonTLBMapping;
> +
> +bool hexagon_tlb_decode_entry(uint64_t entry, HexagonTLBMapping *mapping);
> +
>  uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index);
>  uint64_t hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index,
>                             uint64_t value);
> diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
> index b1eb5ea5037..daaec521a76 100644
> --- a/linux-user/hexagon/target_elf.h
> +++ b/linux-user/hexagon/target_elf.h
> @@ -23,6 +23,13 @@
>  
>  #define HAVE_ELF_HWCAP          1
>  
> +#include "target/hexagon/core-dump.h"
> +
> +#define HAVE_ELF_CORE_DUMP      1
> +#define elf_core_eflags(info)   ((info)->elf_flags)
> +
> +typedef HexagonUserRegs target_elf_gregset_t;
> +
>  enum {
>      HWCAP_HEXAGON_ISA_MASK          = 0x7F,
>      HWCAP_HEXAGON_ISA_V2            = 1,
> diff --git a/target/hexagon/core-dump.h b/target/hexagon/core-dump.h
> new file mode 100644
> index 00000000000..a14b495d04d
> --- /dev/null
> +++ b/target/hexagon/core-dump.h
> @@ -0,0 +1,73 @@
> +/*
> + * Hexagon Linux ELF core register layout.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_CORE_DUMP_H
> +#define HEXAGON_CORE_DUMP_H
> +
> +#include "cpu.h"
> +#include "qemu/bswap.h"
> +
> +/* Linux arch/hexagon/include/uapi/asm/user.h: struct user_regs_struct. */
> +typedef struct target_elf_gregset_t {
> +    uint32_t gpr[32];
> +    uint32_t sa0;
> +    uint32_t lc0;
> +    uint32_t sa1;
> +    uint32_t lc1;
> +    uint32_t m0;
> +    uint32_t m1;
> +    uint32_t usr;
> +    uint32_t p3_0;
> +    uint32_t gp;
> +    uint32_t ugp;
> +    uint32_t pc;
> +    uint32_t cause;
> +    uint32_t badva;
> +    uint32_t cs0;
> +    uint32_t cs1;
> +    uint32_t pad;
> +} HexagonUserRegs;
> +
> +QEMU_BUILD_BUG_ON(sizeof(HexagonUserRegs) != 48 * sizeof(uint32_t));
> +
> +static inline void hexagon_core_copy_regs(HexagonUserRegs *regs,
> +                                          const CPUHexagonState *env)
> +{
> +    uint32_t preds = 0;
> +
> +    for (int i = 0; i < ARRAY_SIZE(regs->gpr); i++) {
> +        regs->gpr[i] = cpu_to_le32(env->gpr[i]);
> +    }
> +    for (int i = 0; i < NUM_PREGS; i++) {
> +        preds |= (env->pred[i] & 0xff) << (i * 8);
> +    }
> +    regs->sa0 = cpu_to_le32(env->gpr[HEX_REG_SA0]);
> +    regs->lc0 = cpu_to_le32(env->gpr[HEX_REG_LC0]);
> +    regs->sa1 = cpu_to_le32(env->gpr[HEX_REG_SA1]);
> +    regs->lc1 = cpu_to_le32(env->gpr[HEX_REG_LC1]);
> +    regs->m0 = cpu_to_le32(env->gpr[HEX_REG_M0]);
> +    regs->m1 = cpu_to_le32(env->gpr[HEX_REG_M1]);
> +    regs->usr = cpu_to_le32(env->gpr[HEX_REG_USR]);
> +    regs->p3_0 = cpu_to_le32(preds);
> +    regs->gp = cpu_to_le32(env->gpr[HEX_REG_GP]);
> +    regs->ugp = cpu_to_le32(env->gpr[HEX_REG_UGP]);
> +    regs->pc = cpu_to_le32(env->gpr[HEX_REG_PC]);
> +#ifdef CONFIG_USER_ONLY
> +    regs->cause = cpu_to_le32(env->cause_code);
> +    regs->badva = 0;
> +#else
> +    regs->cause = cpu_to_le32(extract32(env->t_sreg[HEX_SREG_SSR],
> +                                      reg_field_info[SSR_CAUSE].offset,
> +                                      reg_field_info[SSR_CAUSE].width));
> +    regs->badva = cpu_to_le32(env->t_sreg[HEX_SREG_BADVA]);
> +#endif
> +    regs->cs0 = cpu_to_le32(env->gpr[HEX_REG_CS0]);
> +    regs->cs1 = cpu_to_le32(env->gpr[HEX_REG_CS1]);
> +    regs->pad = 0;
> +}
> +
> +#endif /* HEXAGON_CORE_DUMP_H */
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 6def331a83a..1a5ff3daca2 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -60,6 +60,14 @@ void G_NORETURN do_raise_exception(CPUHexagonState *env,
>  
>  #ifndef CONFIG_USER_ONLY
>  extern const VMStateDescription vmstate_hexagon_cpu;
> +int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> +                                 int cpuid, DumpState *s);
> +void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
> +                           const GuestPhysBlockList *guest_phys_blocks);
> +size_t hexagon_get_note_size(const CPUState *cs, int class, int machine,
> +                             int nr_cpus);
> +bool hexagon_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
> +                                    Error **errp);
>  #endif
>  
>  #endif
> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
> index 07406cea35e..53b835cdd2b 100644
> --- a/hw/hexagon/hexagon_tlb.c
> +++ b/hw/hexagon/hexagon_tlb.c
> @@ -302,6 +302,23 @@ static bool hex_tlb_is_match(uint64_t entry1, uint64_t entry2,
>  
>  /* Public API */
>  
> +bool hexagon_tlb_decode_entry(uint64_t entry, HexagonTLBMapping *mapping)
> +{
> +    uint64_t size;
> +
> +    if (!GET_PTE_V(entry)) {
> +        return false;
> +    }
> +
> +    size = hex_tlb_page_size_bytes(entry);
> +    mapping->size = size;
> +    mapping->va = ROUND_DOWN(hex_tlb_virt_addr(entry), size);
> +    mapping->pa = hex_tlb_phys_addr(entry);
> +    mapping->global = GET_PTE_G(entry);
> +    mapping->asid = GET_PTE_ASID(entry);
> +    return true;
> +}
> +
>  uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index)
>  {
>      g_assert(index < tlb->num_entries);
> diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
> index db0bf299cc0..dac8260b302 100644
> --- a/linux-user/hexagon/elfload.c
> +++ b/linux-user/hexagon/elfload.c
> @@ -6,6 +6,10 @@
>  #include "target_elf.h"
>  #include "target/hexagon/cpu.h"
>  
> +void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUHexagonState *env)
> +{
> +    hexagon_core_copy_regs(regs, env);
> +}
>  
>  abi_ulong get_elf_hwcap(CPUState *cs)
>  {
> diff --git a/target/hexagon/arch_dump.c b/target/hexagon/arch_dump.c
> new file mode 100644
> index 00000000000..1e90bf7285f
> --- /dev/null
> +++ b/target/hexagon/arch_dump.c
> @@ -0,0 +1,112 @@
> +/*
> + * Hexagon system guest ELF core dumps.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "elf.h"
> +#include "qapi/error.h"
> +#include "qemu/range.h"
> +#include "system/dump.h"
> +#include "system/memory_mapping.h"
> +#include "hw/hexagon/hexagon_tlb.h"
> +#include "internal.h"
> +#include "macros.h"
> +#include "sys_macros.h"
> +#include "core-dump.h"
> +
> +/* Linux include/linux/elfcore.h: struct elf_prstatus for the 32-bit ABI. */
> +typedef struct HexagonElfPrstatus {
> +    uint8_t pad1[24];
> +    uint32_t pr_pid;
> +    uint8_t pad2[44];
> +    HexagonUserRegs pr_reg;
> +    uint32_t pr_fpvalid;
> +} QEMU_PACKED HexagonElfPrstatus;
> +
> +QEMU_BUILD_BUG_ON(offsetof(HexagonElfPrstatus, pr_reg) != 72);
> +QEMU_BUILD_BUG_ON(sizeof(HexagonElfPrstatus) != 268);
> +
> +typedef struct HexagonElfNote {
> +    Elf32_Nhdr header;
> +    char name[8]; /* "CORE" including NUL, padded to a 4-byte boundary. */
> +    HexagonElfPrstatus prstatus;
> +} QEMU_PACKED HexagonElfNote;
> +
> +int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> +                                 int cpuid, DumpState *s)
> +{
> +    HexagonElfNote note = { 0 };
> +    HexagonUserRegs regs;
> +
> +    note.header.n_namesz = cpu_to_dump32(s, sizeof("CORE"));
> +    note.header.n_descsz = cpu_to_dump32(s, sizeof(note.prstatus));
> +    note.header.n_type = cpu_to_dump32(s, NT_PRSTATUS);
> +    memcpy(note.name, "CORE", sizeof("CORE"));
> +    note.prstatus.pr_pid = cpu_to_dump32(s, cpuid);
> +    hexagon_core_copy_regs(&regs, cpu_env(cs));
> +    memcpy(&note.prstatus.pr_reg, &regs, sizeof(regs));
> +
> +    return f(&note, sizeof(note), s);
> +}
> +
> +void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
> +                           const GuestPhysBlockList *guest_phys_blocks)
> +{
> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
> +
> +    info->d_machine = EM_HEXAGON;
> +    info->d_class = ELFCLASS32;
> +    info->d_endian = ELFDATA2LSB;
> +    /* The values of HexagonVersion match the EF_HEXAGON_MACH_* flags. */
> +    info->d_flags = cpu->cfg.hex_def->hex_version;
> +}
> +
> +size_t hexagon_get_note_size(const CPUState *cs, int class, int machine,
> +                             int nr_cpus)
> +{
> +    return sizeof(HexagonElfNote) * nr_cpus;
> +}
> +
> +static bool hexagon_mapping_overlaps(const MemoryMappingList *list,
> +                                     const HexagonTLBMapping *m)
> +{
> +    const MemoryMapping *other;
> +
> +    QTAILQ_FOREACH(other, &list->head, next) {
> +        if (ranges_overlap(other->virt_addr, other->length, m->va, m->size)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +bool hexagon_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
> +                                    Error **errp)
> +{
> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
> +    uint32_t asid = GET_SSR_FIELD(SSR_ASID,
> +                                  cpu_env(cs)->t_sreg[HEX_SREG_SSR]);
> +    uint32_t num_entries;
> +
> +    if (!cpu->tlb) {
> +        error_setg(errp, "Hexagon CPU has no TLB");
> +        return false;
> +    }
> +

In this case, shouldn't we assume it's an identity mapping?

> +    num_entries = hexagon_tlb_get_num_entries(cpu->tlb);
> +    for (uint32_t i = 0; i < num_entries; i++) {
> +        HexagonTLBMapping m;
> +
> +        if (!hexagon_tlb_decode_entry(hexagon_tlb_read(cpu->tlb, i), &m) ||
> +            (!m.global && m.asid != asid) ||
> +            hexagon_mapping_overlaps(list, &m)) {
> +            continue;
> +        }
> +        memory_mapping_list_add_merge_sorted(list, m.pa, m.va, m.size);
> +    }
> +    return true;
> +}
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 3575b31d196..5f7f22fa2ea 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -870,9 +870,22 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
>  
>  #include "hw/core/sysemu-cpu-ops.h"
>  
> +static bool hexagon_cpu_get_paging_enabled(const CPUState *cs)
> +{
> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
> +
> +    return GET_SYSCFG_FIELD(SYSCFG_MMUEN,
> +        hexagon_globalreg_read_syscfg_unlocked(cpu->globalregs));
> +}
> +
>  static const struct SysemuCPUOps hexagon_sysemu_ops = {
>      .has_work = hexagon_cpu_has_work,
> +    .get_memory_mapping = hexagon_cpu_get_memory_mapping,
> +    .get_paging_enabled = hexagon_cpu_get_paging_enabled,
>      .translate_for_debug = hexagon_cpu_translate_for_debug,
> +    .write_elf32_note = hexagon_cpu_write_elf32_note,
> +    .get_dump_info = hexagon_get_dump_info,
> +    .get_note_size = hexagon_get_note_size,
>  };
>  
>  static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index db65edcba54..b9b2a2d9740 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -314,6 +314,7 @@ hexagon_ss.add(files(
>  ))
>  
>  hexagon_softmmu_ss.add(files(
> +    'arch_dump.c',
>      'cpu_helper.c',
>      'hex_mmu.c',
>      'hex_interrupts.c',

For the rest, it looks good to me.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

