Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B51606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 01:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLWAC-0002lZ-Cl; Mon, 26 Oct 2026 21:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLW9p-0002jw-UQ; Mon, 26 Oct 2026 21:39:24 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLW9n-00048G-CV; Mon, 26 Oct 2026 21:39:21 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jDCp83Z0Wz8Xrrc;
 Tue, 27 Oct 2026 09:39:12 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl2.zte.com.cn with SMTP id 69R1d5Z2035206;
 Tue, 27 Oct 2026 09:39:05 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Tue, 27 Oct 2026 09:39:06 +0800
X-Zmail-TransId: 3e816ae000b9027-4800e
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: alistair.francis@wdc.com
Cc: chao.liu@processmission.com, daniel.barboza@oss.qualcomm.com,
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, wang.yechao255@zte.com.cn,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v2] target/riscv: Remove unused MMU_USER_IDX macro
Date: Tue, 27 Oct 2026 09:37:21 +0800
Message-ID: <20261027013727.677588-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <57ea9e7e3e7c826110e6a1c6b27d80561c1a532f.camel@wdc.com>
References: <57ea9e7e3e7c826110e6a1c6b27d80561c1a532f.camel@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69R1d5Z2035206
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 27 Oct 2026 09:39:12 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE000C0.000/4jDCp83Z0Wz8Xrrc
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On Mon, 2026-10-26 at 11:11 +0800, Wang Yechao wrote:
> > MMU_USER_IDX is not used anywhere in the tree. Its value is also
> > incorrect: it is defined as 3, while the user-mode MMU index is
> > MMUIdx_U(0), as defined in target/riscv/internals.h.
> > 
> > Since the macro is both unused and wrong, remove it rather than
> > fix its value.
> > 
> > Signed-off-by: yechao-w <wang.yechao255@zte.com.cn>
> > Reviewed-by: Daniel Henrique Barboza
> > <daniel.barboza@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Adjust the patch descriptions and rebased on riscv-to-apply.next.
> > - Link to v1:
> > https://lore.kernel.org/qemu-devel/20260107161336108RbvgIEJ1pww_fKZtMreFp@zte.com.cn/
> > 
> >  target/riscv/cpu.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index b65d631994..df7477fc5f 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -180,8 +180,6 @@ extern RISCVCPUImpliedExtsRule
> > *riscv_multi_ext_implied_rules[];
> >  
> >  #define RISCV_IMPLIED_EXTS_RULE_END -1
> >  
> > -#define MMU_USER_IDX 3
> > -
> 
> Fails to build:
> 
> In file included from
> /var/mnt/scratch/alistair/software/qemu/include/accel/tcg/cpu-
> ldst.h:70,
>                  from ../linux-user/qemu.h:5,
>                  from ../linux-user/riscv/cpu_loop.c:22:
> /var/mnt/scratch/alistair/software/qemu/include/accel/tcg/cpu-mmu-
> index.h: In function ‘cpu_mmu_index’:
> /var/mnt/scratch/alistair/software/qemu/include/accel/tcg/cpu-mmu-
> index.h:37:12: error: ‘MMU_USER_IDX’ undeclared (first use in this
> function)
>    37 |     return MMU_USER_IDX;
>       |            ^~~~~~~~~~~~
> /var/mnt/scratch/alistair/software/qemu/include/accel/tcg/cpu-mmu-
> index.h:37:12: note: each undeclared identifier is reported only once
> for each function it appears in
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:170: run-ninja] Error 1
> 
> 
> >  #if !defined(CONFIG_USER_ONLY)
> >  #include "tcg/pmp.h"
> >  #endif

Hi Alistair,

Thanks for the report. You are right, I missed the linux-user build path.

The MMU_USER_IDX macro is indeed referenced by the generic
cpu_mmu_index() in include/accel/tcg/cpu-mmu-index.h when
CONFIG_USER_ONLY is defined. My previous check was scoped to
the system-mode RISC-V files and I failed to catch this.

cpu_mmu_index() needs to stay consistent with
riscv_env_mmu_index(), which returns 0 for user mode.
Keeping MMU_USER_IDX as a valid definition is therefore
required, and its value should match MMUIdx_U(0).

I will send a v3 that keeps the macro definition but fixes its
value to MMUIdx_U(0), which addresses the incorrect value
without breaking the user-mode build.

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d631994..5a896fefe7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -180,7 +180,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define RISCV_IMPLIED_EXTS_RULE_END -1
 
-#define MMU_USER_IDX 3
+#define MMU_USER_IDX MMUIdx_U
 
 #if !defined(CONFIG_USER_ONLY)
 #include "tcg/pmp.h"

Thanks,
Yechao

