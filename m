Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309EDC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 07:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSA4B-0004IV-E8; Thu, 19 Jun 2025 03:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uSA48-0004HV-GI
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 03:52:08 -0400
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uSA3z-0006pB-QE
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 03:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1750319499;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=zciqp8bVK5VInCp1F5aACzf5lMBRFJ+pqQcY4DM5PeQ=;
 b=EZ9KepEty4sv1MyqaoS/ZhbUWHDT+nZ8WjAUytlvR6G5MjHY7X/a0DPcG1GnzF/joG8ojJ
 jQ0jpQlus6d2VuoKVOBIZsUpSW/BXbOwaIMxZWOC2Yt3fKv4jDAcH0ohXLx7PSVe3LbmeL
 FiC1S/syYGtLTrUI/WTtGyTVZalIDJabvPGbjyjUNX1LJe3pzQqckxG7B4MVTC6HonIVWD
 JlYJsUZuSohyEVruUpPZRgTkYZU3NMS0yOh0fymkIPkFMQOh1f3w4fIC9Jnf5s/PvUig1A
 nVZR0RHhaXaH1joASfovprHrOTq6btuzOUooTQqJ4+HTr/oce5NNgJ7vgmI/VQ==
Subject: Re: [PATCH v5 1/2] target/riscv: Add BOSC's Xiangshan Kunminghu CPU
User-Agent: Mozilla Thunderbird
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250617074022.17575-1-wangran@bosc.ac.cn>
To: "Ran Wang" <wangran@bosc.ac.cn>, <alistair23@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
References: <20250617074022.17575-1-wangran@bosc.ac.cn>
X-Lms-Return-Path: <lba+26853c189+120796+nongnu.org+liujingqi@lanxincomputing.com>
Cc: <3543977024@qq.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>, "Yu Hu" <819258943@qq.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Date: Thu, 19 Jun 2025 15:51:34 +0800
Message-Id: <91f75c26-84c6-4d55-95c9-4954b3b5f35f@lanxincomputing.com>
Received: from [127.0.0.1] ([218.1.220.125]) by smtp.feishu.cn with ESMTPS;
 Thu, 19 Jun 2025 15:51:36 +0800
Received-SPF: pass client-ip=118.26.132.17;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-17.ptr.blmpb.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, MSGID_FROM_MTA_HEADER=0.001,
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

On 6/17/2025 3:40 PM, Ran Wang wrote:
> From: Huang Borong <3543977024@qq.com>
>
> Add a CPU entry for the Xiangshan Kunminghu CPU, an open-source,
> high-performance RISC-V processor. More details can be found at:
> https://github.com/OpenXiangShan/XiangShan
>
> Note: The ISA extensions supported by the Xiangshan Kunminghu CPU are
> categorized based on four RISC-V specifications: Volume I: Unprivileged
> Architecture, Volume II: Privileged Architecture, AIA, and RVA23. The
> extensions within each category are organized according to the chapter
> order in the specifications.
>
> Signed-off-by: Yu Hu <819258943@qq.com>
> Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
> Signed-off-by: Borong Huang <3543977024@qq.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 64 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1ee05eb393..75f4e43408 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -55,6 +55,7 @@
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>   #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>   #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
> +#define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 758f254c15..c5ddd2e281 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3206,6 +3206,70 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.max_satp_mode = VM_1_10_SV39,
>       ),
>   
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
> +                    .misa_mxl_max = MXL_RV64,
> +                    .misa_ext = RVG | RVC | RVB | RVS | RVU | RVH | RVV,
> +                    .priv_spec = PRIV_VERSION_1_13_0,
> +
> +                    /*
> +                     * The RISC-V Instruction Set Manual: Volume I
> +                     * Unprivileged Architecture
> +                     */
> +                    .cfg.ext_zicntr = true,
> +                    .cfg.ext_zihpm = true,
> +                    .cfg.ext_zihintntl = true,
> +                    .cfg.ext_zihintpause = true,
> +                    .cfg.ext_zimop = true,
> +                    .cfg.ext_zcmop = true,
> +                    .cfg.ext_zicond = true,
> +                    .cfg.ext_zawrs = true,
> +                    .cfg.ext_zacas = true,
> +                    .cfg.ext_zfh = true,
> +                    .cfg.ext_zfa = true,
> +                    .cfg.ext_zcb = true,
> +                    .cfg.ext_zbc = true,
> +                    .cfg.ext_zvfh = true,
> +                    .cfg.ext_zkn = true,
> +                    .cfg.ext_zks = true,
> +                    .cfg.ext_zkt = true,
> +                    .cfg.ext_zvbb = true,
> +                    .cfg.ext_zvkt = true,
> +
> +                    /*
> +                     * The RISC-V Instruction Set Manual: Volume II
> +                     * Privileged Architecture
> +                     */
> +                    .cfg.ext_smstateen = true,
> +                    .cfg.ext_smcsrind = true,
> +                    .cfg.ext_sscsrind = true,
> +                    .cfg.ext_svnapot = true,
> +                    .cfg.ext_svpbmt = true,
> +                    .cfg.ext_svinval = true,
> +                    .cfg.ext_sstc = true,
> +                    .cfg.ext_sscofpmf = true,
> +                    .cfg.ext_ssdbltrp = true,
> +                    .cfg.ext_ssnpm = true,
> +                    .cfg.ext_smnpm = true,
> +                    .cfg.ext_smmpm = true,
> +                    .cfg.ext_sspm = true,
> +                    .cfg.ext_supm = true,
> +
> +                    /* The RISC-V Advanced Interrupt Architecture */
> +                    .cfg.ext_smaia = true,
> +                    .cfg.ext_ssaia = true,
> +
> +                    /* RVA23 Profiles */
> +                    .cfg.ext_zicbom = true,
> +                    .cfg.ext_zicbop = true,
> +                    .cfg.ext_zicboz = true,
> +                    .cfg.ext_svade = true,
> +
> +                    .cfg.mmu = true,
> +                    .cfg.pmp = true,
> +
> +                    .cfg.max_satp_mode = VM_1_10_SV48,
> +                    ),
> +
>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>           .cfg.max_satp_mode = VM_1_10_SV57,

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

