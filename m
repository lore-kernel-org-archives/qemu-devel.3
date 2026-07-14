Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D76C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcQW-0006Ag-OE; Tue, 14 Jul 2026 08:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcQU-00069h-Hq; Tue, 14 Jul 2026 08:39:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcQQ-0006fg-QI; Tue, 14 Jul 2026 08:39:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBg2Ze1134850; Tue, 14 Jul 2026 12:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MOivQo
 FMvpMjCntzfmS+N1nTc2o2QsBtk0BGFX8M9x0=; b=gmaweO6BhSNCUVAsVhUbLr
 7tUNQOvRBKa7s1DEAls2JudkTdMD/Gp8LUPNesil4v32FEYT/+TgmLkOL4+ptiMa
 BBL8lg8d+O/FZdwkDI0iWE/I4fP2RhSXi+OSKyGnlSmsB/aheH2Iw0/m+onlEDiA
 EVJGba9hielZQL9g7J5XzMwD400MiNugRs6WZnfmeamFCo+6GfCpFj97kso6Gx5f
 e9QQLlCIOElgJaKwBwTSaA2p/B7rSaaBclrT4f7hDkY+/EaJkouNNay/5Pg2MObG
 Q//ZGmVA23fRMIzNuUBlVv54DRLKOe6yrieRorWfyOr3N7kayDHzl9epWQkbMtNQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a5nbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:39:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECYfW9015812;
 Tue, 14 Jul 2026 12:39:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhapj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:39:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECdiHV41681350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:39:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DAFA20043;
 Tue, 14 Jul 2026 12:39:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B07120040;
 Tue, 14 Jul 2026 12:39:44 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:39:44 +0000 (GMT)
Message-ID: <f64a5bc8-870e-492f-9a89-cbbb4c2e204f@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/51] cpu: Use interval-tree for CPUBreakpoint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-16-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX0A+jEookwtvu
 19rPivASXZY7oOF8QYtEGygQFOjBu5tiBPYsxati6mOrvpzIdm68kef1gh6jvAFI3H1iaNyP+1G
 xFFbJT6p5q6MhjuGV69/QewP04I2fTs=
X-Proofpoint-GUID: FujZ5nWVzLUxKVmMNINiFAOpM903Xz0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX60e2Semf8cFn
 YxhHZcPv3lAEenjfwxHcjAwRazDnJtDqXYNTZvk3cQH/aUwGafJ/Wr3ZXm0CCOB2Ud+C93hoZ5o
 EnCJ000ab81xIFmsY5/uX/3y8zBN49n8EZb7AryiT84oZeDFkmAeQbaZSk2K0a3lxbkERJHdckU
 HWWIskdHRT4AeJnIYW9TX3j9CmiyKpked6ZUYzcJUpbOgs0wL1XkqTdYroQ93NvUrryaGQr3xNq
 ZLmFaxG3adj1MzTZTiLnik9DzsrbcTdEmcNkYqRqHg+d3yO7KLWzwokyqQa1OKSre/7Kge5tmfx
 x0EPM8AnwezySetIQ5AHdJcf8EJuHlZ2apWk3PVQOVp7u+n76BFuhYT9p7RymsT6t8Dt7uhxh4X
 SCdZaQr2xkW9cXcb4X1QMnOWvpHrU6qE0kw8kkTMtaj2u+uE7N5W1oB0RUbFgGyj2CODKty1i46
 YybSOEzmGh6S+kNC1Jg==
X-Proofpoint-ORIG-GUID: Mc5KaoeLK7gu8QNvCwoWzjaloz0XcCnk
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a562e13 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=MUMusLo9K66nBxcDV3wA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 22:53, Richard Henderson wrote:
> Use a balanced binary tree rather than a simple list for breakpoints.
> Using an interval tree makes it easy to probe for all breakpoints on
> a virtual page.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h   |  4 +--
>   include/hw/core/cpu.h       |  3 +-
>   accel/tcg/cpu-exec.c        | 58 +++++++++++++++++++++----------------
>   accel/whpx/whpx-common.c    |  9 +++---
>   cpu-common.c                | 46 +++++++++++++++--------------
>   hw/core/cpu-common.c        |  1 -
>   linux-user/main.c           | 14 ++++++---
>   target/i386/whpx/whpx-all.c | 15 +++++-----
>   8 files changed, 84 insertions(+), 66 deletions(-)

[...]

> @@ -312,33 +312,34 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
>           return false;
>       }
>   
> -    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
> -        /*
> -         * If we have an exact pc match, trigger the breakpoint.
> -         * Otherwise, note matches within the page.
> -         */
> -        if (pc == bp->pc) {
> -            bool match_bp = false;
> -
> -            if (bp->flags & BP_GDB) {
> -                match_bp = true;
> -            } else if (bp->flags & BP_CPU) {
> +    n = interval_tree_iter_first(&cpu->breakpoints, pc, pc);
> +    if (n) {
>   #ifdef CONFIG_USER_ONLY
> -                g_assert_not_reached();
> +        bp = container_of(n, CPUBreakpoint, itree);
> +        assert(bp->flags & BP_GDB);
> +        goto found;
>   #else
> -                const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> -                assert(tcg_ops->debug_check_breakpoint);
> -                match_bp = tcg_ops->debug_check_breakpoint(cpu, bp);
> -#endif
> +        /* Prefer GDB breakpoint over architectural breakpoint. */
> +        do {
> +            bp = container_of(n, CPUBreakpoint, itree);
> +            if (bp->flags & BP_GDB) {
> +                goto found;
>               }
> +            n = interval_tree_iter_next(n, pc, pc);
> +        } while (n);
>   
> -            if (match_bp) {
> -                cpu->exception_index = EXCP_DEBUG;
> -                return true;
> +        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> +        assert(tcg_ops->debug_check_breakpoint);
> +
> +        for (n = interval_tree_iter_first(&cpu->breakpoints, pc, pc); n;
> +             n = interval_tree_iter_next(n, pc, pc)) {
> +            bp = container_of(n, CPUBreakpoint, itree);
> +            if ((bp->flags & BP_CPU) &&
> +                tcg_ops->debug_check_breakpoint(cpu, bp)) {
> +                goto found;
>               }


Walking the tree twice feels slightly inefficient, but the only
alternative I can think of entails calling
tcg_ops->debug_check_breakpoint() for each node, which may be even
worse.

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

