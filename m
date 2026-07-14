Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846F1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcmM-0000Ez-8h; Tue, 14 Jul 2026 09:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcmJ-00009p-Qj; Tue, 14 Jul 2026 09:02:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcmI-0001yU-5F; Tue, 14 Jul 2026 09:02:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBg06W1134148; Tue, 14 Jul 2026 13:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/tin1f
 X52d7BxsrTopsCer7L+hEsTKsqW7Y/fKBOz7I=; b=tVv7a8qYCiujJr3ppmD7/L
 /bYyJVDzAn/aSHZuNQOS3WsBo4ngBuFKflBXeT4PSDUrpmkjL0FzBrr9U286nWII
 vqV5onTjtEjVZ2bCxNn43V7Ulod6WmFzHxESDeWvrodUa8UT56YDRwi3xdcYz3hL
 f1ykwRqSAxIbdlAki0LeaTKduCVObxEumN+gNIYAvh5Im8cGsfnSVVcdxE3hqQsv
 /yOQ8svgFumdT8Sq80G9JgHtn9Did4g3r/Nsoo0NS6H6ywqU/n0IuACs0BaM7Adp
 P2MZDoHRwvkYN+VDCiD+xc6EiVWTtq4T3PFhn/wGrZCV+7TIp6cXVzo5kEPic7fA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a5rgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 13:02:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECni3L025707;
 Tue, 14 Jul 2026 13:02:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw301x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 13:02:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ED2JmC29885040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 13:02:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17E3720065;
 Tue, 14 Jul 2026 13:02:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD15B2004B;
 Tue, 14 Jul 2026 13:02:18 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 13:02:18 +0000 (GMT)
Message-ID: <9aed7950-405a-4414-a951-9d044a8c9d53@linux.ibm.com>
Date: Tue, 14 Jul 2026 15:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/51] cpu: Use interval-tree for CPUWatchpoint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-19-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX0XNE8SmurRCJ
 3QFyS0U46N7t+miLJAFgrDY3b1r8PHslIl+zTjMT/Jxrg+AMZWvWhxtL4Y3948W4Z9xpuWqAI9x
 70lbEcxLscRABBDwgUt+H4Om7Hw0ecc=
X-Proofpoint-GUID: KREEPiNY63YaSviS2yueRz62dmf5Vijf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfXzuvKULw4EPhi
 6P0Hb+friZ04lHVpzUaJ9oQoIRvepP+AlKBCiJ0ZJV1Ybjqfh8onKr4rCBU3x0SieRvYECZu0yD
 iKn6Ye94+8SJ/cNCgF3MkwGejd6euREYKuLi4i7BQsOrJbYiQtWMfMrKHwuPDwRzzWuRvFej0Wc
 +hrGUbs5tJ0ECRCjaarrcYtorH428MjnT1+xS/PaowMGXDW+LazSlf6jURVhslzhDWVwQwSHsj1
 zmBz2E9QyRL5y5WQeqQ+wNMpf4cc11gYj1FdMJDaGStk4g+FsmVXcENuVnUJH2/6jHdomAG/SQ+
 W0Ia3EexvznZTQNIt/lyIP2pTfSpUpI7tNpKYs75mGkhEDBHNFHtHFxJJoQiTaBwEwc/HR6lczZ
 T4LidrHyGsOfTRZYvEfbiQyxA+Qh3AdwdkhVnN36QueqTep83NK1hh+jOllw+6zwr7aracm8sqj
 8TataSOp5DP/k/y4oCg==
X-Proofpoint-ORIG-GUID: jTjJjX8zOH834q8n59K2Jb9hsedM7J4g
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a56335e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=goQtPkRG2nAvUlR5sPYA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140132
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
> Use a balanced binary tree rather than a simple list for watchpoints.
> Using an interval tree makes it easy to probe for any overlapping address.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h |   7 +-
>   include/hw/core/cpu.h     |   3 +-
>   accel/tcg/cpu-exec.c      |   8 +-
>   accel/tcg/watchpoint.c    | 155 +++++++++++++++++++++-----------------
>   hw/core/cpu-common.c      |   1 -
>   system/watchpoint.c       |  43 ++++++-----
>   target/arm/hyp_gdbstub.c  |   3 +-
>   7 files changed, 119 insertions(+), 101 deletions(-)
> 
> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
> index bb7cbc626d..e0826a1a2d 100644
> --- a/include/exec/breakpoint.h
> +++ b/include/exec/breakpoint.h
> @@ -9,7 +9,6 @@
>   #define EXEC_BREAKPOINT_H
>   
>   #include "qemu/interval-tree.h"
> -#include "qemu/queue.h"
>   #include "exec/vaddr.h"
>   #include "exec/memattrs.h"
>   
> @@ -36,13 +35,11 @@ struct CPUBreakpoint {
>   };
>   
>   struct CPUWatchpoint {
> -    vaddr vaddr;
> -    vaddr len;
> +    IntervalTreeNode itree;
>       vaddr hitaddr;
>       MemTxAttrs hitattrs;
> -    int flags; /* BP_* */
> +    BreakpointFlags flags;

Should this go into 1/51?

>       unsigned id;
> -    QTAILQ_ENTRY(CPUWatchpoint) entry;
>   };
>   
>   int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b8a1419860..7e19ea418d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -525,8 +525,7 @@ struct CPUState {
>   
>       /* ice debug support */
>       IntervalTreeRoot breakpoints;
> -
> -    QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
> +    IntervalTreeRoot watchpoints;
>       CPUWatchpoint *watchpoint_hit;
>   
>       void *opaque;
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 2762cf6705..ab299387e3 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -682,10 +682,12 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>   static inline void cpu_handle_debug_exception(CPUState *cpu)
>   {
>       const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> -    CPUWatchpoint *wp;
> +    IntervalTreeNode *n;
>   
> -    if (!cpu->watchpoint_hit) {

Isn't it reasonable to continue checking for this, or can it never be
NULL if we come here?

[...]

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

