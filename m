Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D741C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHRT-0001B1-Gj; Thu, 02 Jul 2026 09:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHRM-00018r-7N
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:26:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHRG-0004Kf-6U
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:26:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0YTP416450
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KLwjvjSn23afi4ElvE8WX0/4kkhGb1lPPs8hQ/i+BGw=; b=givVQpeoJA57SqBD
 irt4V6O//8mheBtRQ7vy8AXomZmZiYs1+FIbnj3hMwHQewzsPcMwp3DBPV93Xsur
 k4juDU5vNaMIV3c8xCjKQswW3WDbfjkcxhvuD54Bah1ROZkEeqNaaOo+vSOkSrsP
 8OdbVlhw2CxTw5AVIFoJH2kEhD6OvXEcPCip5P0XUBZjh6bDzJDJycGdBiZloref
 LshkYyBMayKfOMhgTOb2SlPfno/Ca9H3pU8knakBFD6zWYFIYT7VJEGDbmYaxJRm
 FrfkVeVBpbSHvNEZ7vLHQFS5foXK5RzyYkiZrtst9USAsAqDsM53zVUHModfuqzc
 ZndoFw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n940xjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:26:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so190060785a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998802; x=1783603602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KLwjvjSn23afi4ElvE8WX0/4kkhGb1lPPs8hQ/i+BGw=;
 b=fXYtzLhDg6Rr+UnrIgFnUf62pYoIK57jCplBM9Cv9mGsl+TNIAxV8DRTvZ1RO4Fr11
 l6H4rRsP16ukkZ//YEyZ0gR1k9XFxJ++WwOvy3TJ98Xat0R0QGCeVlQXtYyB4ZvcyPg9
 5kMf5QzhollSauUB8FkgMrsswVH3YYvf2SUoCKyfPqrhAEE3Ui8bjKrO36Hl+vK+n/o9
 nBD7+w5lXvUJxQMKffYPwq0bmbpoXyeAY7fMR5ZL+ZarX5cn5cHlkMzIhLCIGuYAlzhk
 ozYQoqybUPqYj2XmxjOILRtpLqMemEnr53VnQPrrywBmFGfTHBOEPF9ud219xLfpvoD0
 G7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998802; x=1783603602;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLwjvjSn23afi4ElvE8WX0/4kkhGb1lPPs8hQ/i+BGw=;
 b=YIE4uJi1QccBr61P8dUTUNMCpyZuzD8/jYgDhfwUzTe9qj6M8OqMIOnoOJNM5fBy+4
 FZxk4xAMkI3FYzerflEylQszfwm/2qYhmpzhfwuGBvGbjqseIZxu6wEZtVJew7b7l9qS
 CLafSdg9TbjXNLbNbZ3A/pYn562u0xZg2GLW4WoXMS5CDdNsJZPECY8BZI0YQVnzjIK8
 8gHx2hG19AitzYp0l0LFhbzE07hUXWnPIHOeI5ABaqRbzxjB8Cc5SWYR7sA0gRMCl99k
 wAapHPzG0OSt/NZQ9+SSLA8YmTCh2LM9jiUMkuRCLDWWnn5ajGV7p3S2qNlFM4mo/v2h
 LZaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xOU0E5obN8MMevkfazoLphPsEyyjq6mwfA6Uf6/xWJKET5b30Ge34XSZo8KWwJLaaFOqw4QXiL6au@nongnu.org
X-Gm-Message-State: AOJu0YyMGCq/3PWBFtn0rV/XzDgKSCl2TlZtIWITp3VY1HW28oTTR3kC
 S/1owLGGSXu1sJfhw3nqhnetXHmud2YQjR33Ymf7uunhcne7cClMi+ROK8dQ8I4PVo5x12ZqRCe
 Im2iV3ePY3TuKlBdMqJEW17xoLHRU4ifsHvn92n/STyb/jBI1nUCpQv6k9A==
X-Gm-Gg: AfdE7ck3c1l1DwyRVsE5ToI8mgGKqPBvlvqCEIZDMVDfsxw+fhNtrN0K3Q62JY0Km5p
 iHjG9F/dABIq9QyhigfwaFdz7PYPJwvAXIKob47jFPSK096V87ZGXPbOMi+zKzeVM1bSpHvx8sW
 wX/vXG+AzNMFJgzpM5iLzgiuVxel+dSGXAFHEnO5PHOgGVa2uxTn/mFw42Ad0tXcYKij4JJ5rXB
 /VlXOpvlYvVgp1AC+Ew4nSYhSpTLK+em5YhXd1IKbigMA4p4ReEgMSgK68d7zd0WJOBDbsrX3dE
 71AGzfaEHlqDXLGdIl+Zo0kxMqqUx7mEa2Fz1PRp1MYarpa/Z7Sax8YNadIFCZtKAEeOXPQNL6g
 aQPIc17YYYyFXiK1w/hSDiLb2IDtT0T2gz+MVEQqzPOTQ
X-Received: by 2002:a05:620a:2629:b0:92b:67e6:8ad0 with SMTP id
 af79cd13be357-92e7b48649amr670406685a.74.1782998801544; 
 Thu, 02 Jul 2026 06:26:41 -0700 (PDT)
X-Received: by 2002:a05:620a:2629:b0:92b:67e6:8ad0 with SMTP id
 af79cd13be357-92e7b48649amr670396985a.74.1782998800546; 
 Thu, 02 Jul 2026 06:26:40 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e8001262dsm227034685a.12.2026.07.02.06.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:26:39 -0700 (PDT)
Message-ID: <f01bb2e5-2de4-4aa8-8ceb-485300ba8cf3@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:26:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpu: Define BreakpointFlags type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-19-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-19-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfXz1fBRuf4uSeR
 AeUSAtxIxKqRaRI0b+aJIjN5VHU+GqxgrM37iLi0eijmlpOYutlTgoypVf8W3iHX4HK1ZWgiBqu
 J/IaA+GdXJ4ReSJNUb47qPyzUnF+or5ClkabQRim8Ac7/pVoWujTR2rjnR4MRDPUaTVIIhP4SVL
 2mMNeIOmPjWyGyI6m1dYLaLqu3FfO4TTKBbFKdB+z+4Ht+wK59tjIhfaVi5aBlQYl/So7x/uZpK
 noilPrrY2Q6AJma82vW1kX4D4PbcBwpXMH5xK9YDIRA646dSfkNSPYqgB4v2E9gFqntxPwY5p3E
 SS5JgnhYnzS1Nz5t7qsQhFdIQQzHvV8dppji0kA4Ssc91I82zKQiDYbB+7XsiPW5R0kWH4yEyY9
 gB05gPVy68L1wM3W2NzaE+eq9M5ZdWwIIAggRC5h2kA+Rw0LUICB/KBkAhH5f4yBNIuOGG5GMUy
 IzV1Cj4ZdlX2QYWTzyA==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a466713 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=LE4M2sf_YbyXujmNdkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: S1zMdnCiQWibd0KX9As7AR8eMoND1kC8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX5HqTvj6bBE27
 AevGEAkFlmdLBXeqbI+lxtlVXJatljs1x1Vyo3E8ACXJw+LzUO8rEjoIrmNcEQop1ERXJ3R3jV5
 4gQgMm6R5df9aIsrTeQfNBE34hYwCe4=
X-Proofpoint-GUID: S1zMdnCiQWibd0KX9As7AR8eMoND1kC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello fine sir,

This patch fails to apply to master due to a riscv conflict down there:

On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Use the BreakpointFlags typedef to better follow when
> we deal with breakpoint flags (BP_*).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h |  6 ++++--
>   include/exec/breakpoint.h   |  3 ++-
>   include/exec/watchpoint.h   |  8 +++++---
>   include/hw/core/cpu.h       | 11 ++++++-----
>   accel/tcg/cputlb.c          | 12 +++++++-----
>   accel/tcg/tcg-accel-ops.c   | 10 +++++-----
>   accel/tcg/user-exec-stub.c  | 11 ++++++-----
>   accel/tcg/watchpoint.c      |  9 +++++----
>   cpu-common.c                |  8 ++++----
>   system/watchpoint.c         |  8 ++++----
>   target/arm/tcg/debug.c      |  4 ++--
>   target/arm/tcg/mte_helper.c |  3 ++-
>   target/ppc/cpu.c            |  2 +-
>   target/ppc/kvm.c            |  5 +++--
>   target/riscv/cpu_helper.c   |  2 +-
>   target/riscv/debug.c        | 12 +++++-------
>   target/s390x/tcg/debug.c    |  3 ++-
>   target/xtensa/dbg_helper.c  |  2 +-
>   18 files changed, 65 insertions(+), 54 deletions(-)
> 
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index 710da12b828..f64d94b2b50 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -298,7 +298,8 @@ struct TCGCPUOps {
>    * specified by @flags.  Exit via exception with a hit.
>    */
>   void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
> -                          MemTxAttrs attrs, int flags, uintptr_t ra);
> +                          MemTxAttrs attrs, BreakpointFlags flags,
> +                          uintptr_t ra);
>   
>   /**
>    * cpu_watchpoint_address_matches:
> @@ -309,7 +310,8 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>    * Return the watchpoint flags that apply to [addr, addr+len).
>    * If no watchpoint is registered for the range, the result is 0.
>    */
> -int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
> +BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
> +                                               vaddr addr, vaddr len);
>   
>   /*
>    * Common pointer_wrap implementations.
> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
> index cc6fedd09fe..0c3cc0c8ff3 100644
> --- a/include/exec/breakpoint.h
> +++ b/include/exec/breakpoint.h
> @@ -12,6 +12,7 @@
>   #include "exec/vaddr.h"
>   #include "exec/memattrs.h"
>   
> +typedef int BreakpointFlags;
>   /* Breakpoint/watchpoint flags */
>   #define BP_MEM_READ           0x01
>   #define BP_MEM_WRITE          0x02
> @@ -28,7 +29,7 @@
>   
>   typedef struct CPUBreakpoint {
>       vaddr pc;
> -    int flags; /* BP_* */
> +    BreakpointFlags flags;
>       QTAILQ_ENTRY(CPUBreakpoint) entry;
>   } CPUBreakpoint;
>   
> diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
> index c4d069425ba..ba148eff3d1 100644
> --- a/include/exec/watchpoint.h
> +++ b/include/exec/watchpoint.h
> @@ -8,11 +8,13 @@
>   #ifndef EXEC_WATCHPOINT_H
>   #define EXEC_WATCHPOINT_H
>   
> +#include "exec/breakpoint.h"
> +
>   int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                          int flags, CPUWatchpoint **watchpoint);
> +                          BreakpointFlags flags, CPUWatchpoint **watchpoint);
>   int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> -                          vaddr len, int flags);
> +                          vaddr len, BreakpointFlags flags);
>   void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
> -void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> +void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags);
>   
>   #endif /* EXEC_WATCHPOINT_H */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b1df615792a..bea8e509a19 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1138,20 +1138,21 @@ void qemu_init_vcpu(CPUState *cpu);
>    */
>   void cpu_single_step(CPUState *cpu, int enabled);
>   
> -int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
> +int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
>                             CPUBreakpoint **breakpoint);
> -int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
> +int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags);
>   void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
> -void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
> +void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags flags);
>   
>   /* Return true if PC matches an installed breakpoint.  */
> -static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
> +static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc,
> +                                       BreakpointFlags flags)
>   {
>       CPUBreakpoint *bp;
>   
>       if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
>           QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
> -            if (bp->pc == pc && (bp->flags & mask)) {
> +            if (bp->pc == pc && (bp->flags & flags)) {
>                   return true;
>               }
>           }
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 7f7c208ba12..e2911e3aac6 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1033,7 +1033,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       CPUTLBEntry *te, tn;
>       hwaddr iotlb, xlat, sz, paddr_page;
>       vaddr addr_page;
> -    int asidx, wp_flags, prot;
> +    int asidx, prot;
> +    BreakpointFlags wp_flags;
>       bool is_ram, is_romd;
>   
>       assert_cpu_is_self(cpu);
> @@ -1499,8 +1500,8 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
>       if (unlikely(flags & (TLB_NOTDIRTY | TLB_WATCHPOINT))) {
>           /* Handle watchpoints.  */
>           if (flags & TLB_WATCHPOINT) {
> -            int wp_access = (access_type == MMU_DATA_STORE
> -                             ? BP_MEM_WRITE : BP_MEM_READ);
> +            BreakpointFlags wp_access = (access_type == MMU_DATA_STORE
> +                                        ? BP_MEM_WRITE : BP_MEM_READ);
>               cpu_check_watchpoint(env_cpu(env), addr, size,
>                                    full->attrs, wp_access, retaddr);
>           }
> @@ -1702,7 +1703,8 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
>   
>       /* On watchpoint hit, this will longjmp out.  */
>       if (flags & TLB_WATCHPOINT) {
> -        int wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE : BP_MEM_READ;
> +        BreakpointFlags wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE
> +                                                           : BP_MEM_READ;
>           cpu_check_watchpoint(cpu, addr, size, full->attrs, wp, ra);
>           flags &= ~TLB_WATCHPOINT;
>       }
> @@ -1885,7 +1887,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       }
>   
>       if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> -        int wp_flags = 0;
> +        BreakpointFlags wp_flags = 0;
>   
>           if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
>               wp_flags |= BP_MEM_WRITE;
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 927af6c1db0..26d34c72d9a 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -110,20 +110,20 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
>   }
>   
>   /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
> -static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
> +static inline BreakpointFlags xlat_gdb_type(CPUState *cpu, int gdbtype)
>   {
> -    static const int xlat[] = {
> +    static const BreakpointFlags xlat[] = {
>           [GDB_WATCHPOINT_WRITE]  = BP_GDB | BP_MEM_WRITE,
>           [GDB_WATCHPOINT_READ]   = BP_GDB | BP_MEM_READ,
>           [GDB_WATCHPOINT_ACCESS] = BP_GDB | BP_MEM_ACCESS,
>       };
>   
> -    int cputype = xlat[gdbtype];
> +    BreakpointFlags cpuflags = xlat[gdbtype];
>   
>       if (cpu->cc->gdb_stop_before_watchpoint) {
> -        cputype |= BP_STOP_BEFORE_ACCESS;
> +        cpuflags |= BP_STOP_BEFORE_ACCESS;
>       }
> -    return cputype;
> +    return cpuflags;
>   }
>   
>   static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
> diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
> index 28286e11a60..7b6c25c4738 100644
> --- a/accel/tcg/user-exec-stub.c
> +++ b/accel/tcg/user-exec-stub.c
> @@ -22,13 +22,13 @@ void cpu_exec_reset_hold(CPUState *cpu)
>   }
>   
>   int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                          int flags, CPUWatchpoint **watchpoint)
> +                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
>   {
>       return -ENOSYS;
>   }
>   
>   int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> -                          vaddr len, int flags)
> +                          vaddr len, BreakpointFlags flags)
>   {
>       return -ENOSYS;
>   }
> @@ -37,17 +37,18 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
>   {
>   }
>   
> -void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> +void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags)
>   {
>   }
>   
> -int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
> +BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
> +                                               vaddr addr, vaddr len)
>   {
>       return 0;
>   }
>   
>   void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
> -                          MemTxAttrs atr, int fl, uintptr_t ra)
> +                          MemTxAttrs atr, BreakpointFlags flags, uintptr_t ra)
>   {
>   }
>   
> diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
> index c75ed278459..5ea66e9763a 100644
> --- a/accel/tcg/watchpoint.c
> +++ b/accel/tcg/watchpoint.c
> @@ -52,10 +52,11 @@ static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
>   }
>   
>   /* Return flags for watchpoints that match addr + prot.  */
> -int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
> +BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
> +                                               vaddr addr, vaddr len)
>   {
>       CPUWatchpoint *wp;
> -    int ret = 0;
> +    BreakpointFlags ret = 0;
>   
>       QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
>           if (watchpoint_address_matches(wp, addr, len)) {
> @@ -67,7 +68,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
>   
>   /* Generate a debug exception if a watchpoint has been hit.  */
>   void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
> -                          MemTxAttrs attrs, int flags, uintptr_t ra)
> +                          MemTxAttrs attrs, BreakpointFlags flags, uintptr_t ra)
>   {
>       CPUWatchpoint *wp;
>   
> @@ -91,7 +92,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>   
>       assert((flags & ~BP_MEM_ACCESS) == 0);
>       QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
> -        int hit_flags = wp->flags & flags;
> +        BreakpointFlags hit_flags = wp->flags & flags;
>   
>           if (hit_flags && watchpoint_address_matches(wp, addr, len)) {
>               if (replay_running_debug()) {
> diff --git a/cpu-common.c b/cpu-common.c
> index 988d057d844..5afae9c1899 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -389,7 +389,7 @@ void process_queued_cpu_work(CPUState *cpu)
>   }
>   
>   /* Add a breakpoint.  */
> -int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
> +int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
>                             CPUBreakpoint **breakpoint)
>   {
>       CPUBreakpoint *bp;
> @@ -419,7 +419,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
>   }
>   
>   /* Remove a specific breakpoint.  */
> -int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
> +int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags)
>   {
>       CPUBreakpoint *bp;
>   
> @@ -446,12 +446,12 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
>   }
>   
>   /* Remove all matching breakpoints. */
> -void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
> +void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags flags)
>   {
>       CPUBreakpoint *bp, *next;
>   
>       QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
> -        if (bp->flags & mask) {
> +        if (bp->flags & flags) {
>               cpu_breakpoint_remove_by_ref(cpu, bp);
>           }
>       }
> diff --git a/system/watchpoint.c b/system/watchpoint.c
> index 21d0bb36cae..f96aa24210f 100644
> --- a/system/watchpoint.c
> +++ b/system/watchpoint.c
> @@ -26,7 +26,7 @@
>   
>   /* Add a watchpoint.  */
>   int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                          int flags, CPUWatchpoint **watchpoint)
> +                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
>   {
>       CPUWatchpoint *wp;
>       vaddr in_page;
> @@ -65,7 +65,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>   
>   /* Remove a specific watchpoint.  */
>   int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
> -                          int flags)
> +                          BreakpointFlags flags)
>   {
>       CPUWatchpoint *wp;
>   
> @@ -90,12 +90,12 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
>   }
>   
>   /* Remove all matching watchpoints.  */
> -void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> +void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags)
>   {
>       CPUWatchpoint *wp, *next;
>   
>       QTAILQ_FOREACH_SAFE(wp, &cpu->watchpoints, entry, next) {
> -        if (wp->flags & mask) {
> +        if (wp->flags & flags) {
>               cpu_watchpoint_remove_by_ref(cpu, wp);
>           }
>       }
> diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
> index 07a52643e71..11043ecd589 100644
> --- a/target/arm/tcg/debug.c
> +++ b/target/arm/tcg/debug.c
> @@ -550,7 +550,7 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
>       vaddr wvr = env->cp15.dbgwvr[n];
>       uint64_t wcr = env->cp15.dbgwcr[n];
>       int mask;
> -    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> +    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
>   
>       if (env->cpu_watchpoint[n]) {
>           cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[n]);
> @@ -656,7 +656,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
>       uint64_t bcr = env->cp15.dbgbcr[n];
>       vaddr addr;
>       int bt;
> -    int flags = BP_CPU;
> +    BreakpointFlags flags = BP_CPU;
>   
>       if (env->cpu_breakpoint[n]) {
>           cpu_breakpoint_remove_by_ref(CPU(cpu), env->cpu_breakpoint[n]);
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index dca4ef5a942..17f920b3f35 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -190,7 +190,8 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>   
>       /* Any debug exception has priority over a tag check exception. */
>       if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
> -        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
> +        BreakpointFlags wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ
> +                                                         : BP_MEM_WRITE;
>           assert(ra != 0);
>           cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
>       }
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index 41edb18643d..913920d55b8 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -145,7 +145,7 @@ void ppc_update_daw(CPUPPCState *env, int rid)
>       bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
>       bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
>       vaddr len;
> -    int flags;
> +    BreakpointFlags flags;
>   
>       if (env->dawr_watchpoint[rid]) {
>           cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b94c2997a07..2a3711fb1df 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1429,7 +1429,7 @@ static int find_hw_breakpoint(target_ulong addr, int type)
>       return -1;
>   }
>   
> -static int find_hw_watchpoint(target_ulong addr, int *flag)
> +static int find_hw_watchpoint(target_ulong addr, BreakpointFlags *flag)
>   {
>       int n;
>   
> @@ -1575,7 +1575,6 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>   {
>       int handle = DEBUG_RETURN_GUEST;
>       int n;
> -    int flag = 0;
>   
>       if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
>           if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
> @@ -1585,6 +1584,8 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>               }
>           } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
>                                           KVMPPC_DEBUG_WATCH_WRITE)) {
> +            BreakpointFlags flag = 0;
> +
>               n = find_hw_watchpoint(arch_info->address,  &flag);
>               if (n >= 0) {
>                   handle = DEBUG_RETURN_GDB;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 59edcdd3704..8b9d4bc1f4d 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1992,7 +1992,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       } else if (probe) {
>           return false;
>       } else {
> -        int wp_access = 0;
> +        BreakpointFlags wp_access = 0;
>   
>           if (access_type == MMU_DATA_LOAD) {
>               wp_access |= BP_MEM_READ;
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 30d39ee5cd0..3046cc896a8 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -479,7 +479,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
>       target_ulong addr = env->tdata2[index];
>       bool enabled = type2_breakpoint_enabled(ctrl);
>       CPUState *cs = env_cpu(env);
> -    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> +    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
>       uint32_t size, def_size;
>   
>       if (!enabled) {
> @@ -604,7 +604,7 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
>       target_ulong addr = env->tdata2[index];
>       bool enabled = type6_breakpoint_enabled(ctrl);
>       CPUState *cs = env_cpu(env);
> -    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> +    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
>       uint32_t size;
>   
>       if (!enabled) {
> @@ -992,12 +992,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>       CPURISCVState *env = &cpu->env;
>       target_ulong ctrl;
>       target_ulong addr;
> -    int trigger_type;
> -    int flags;
> -    int i;
>   
> -    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
> -        trigger_type = get_trigger_type(env, i);
> +    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
> +        int trigger_type = get_trigger_type(env, i);
> +        BreakpointFlags flags;

Here ^ the reason is we're not using RV_MAX_TRIGGERS anymore but env->num_triggers.


Patch LGTM otherwise.  For the RISC-V bits:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   
>           if (!trigger_common_match(env, trigger_type, i)) {
>               continue;
> diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
> index 99140b1ac9a..d10e9ed8922 100644
> --- a/target/s390x/tcg/debug.c
> +++ b/target/s390x/tcg/debug.c
> @@ -14,7 +14,8 @@
>   
>   void s390_cpu_recompute_watchpoints(CPUState *cs)
>   {
> -    const int wp_flags = BP_CPU | BP_MEM_WRITE | BP_STOP_BEFORE_ACCESS;
> +    const BreakpointFlags wp_flags = BP_CPU | BP_MEM_WRITE
> +                                     | BP_STOP_BEFORE_ACCESS;
>       CPUS390XState *env = cpu_env(cs);
>   
>       /* We are called when the watchpoints have changed. First
> diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
> index 3b91f7c38ac..990012f60e6 100644
> --- a/target/xtensa/dbg_helper.c
> +++ b/target/xtensa/dbg_helper.c
> @@ -85,7 +85,7 @@ static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
>           uint32_t dbreakc)
>   {
>       CPUState *cs = env_cpu(env);
> -    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> +    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
>       uint32_t mask = dbreakc | ~DBREAKC_MASK;
>   
>       if (env->cpu_watchpoint[i]) {


