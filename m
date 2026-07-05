Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137E3C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNTb-0004Tf-5i; Sun, 05 Jul 2026 10:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wgNTT-0004Pp-PN
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:05:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imaginos32@gmail.com>)
 id 1wgNTR-00052U-Ir
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:05:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47640541585so1283317f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783260331; x=1783865131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTgD4XU6nX98udZAcwuur62Dr9OUg4XQkoqc7W/QL9U=;
 b=d7+Q8tIx+rtERiI5qtYM+IzkCu2rBTwwYt7NjObGhgi7tyx8U8+JUAner39p67CMx0
 jXMWmOvp9qjwhqUzIfjXVJr0EmO8HFfPVTvPfTktpk84IH000zVvM/ZAvipSmarqyqnY
 Uu/cZ2aDlIV7pE2kuFO/stTFtTKm9bE/I0rp832kzcByaPCYsblJFAptm3FyP9gBmyaG
 AgqSpcoTI7ANK8A5MVoZl4OcSO4xl7A5icl2oqrUx5qlIc+Kb8rZgH/Kx30x8mObiyEa
 VI1AxxCfz6rDRAgIWjZl3qMxsfYA71dwJqxO68+JUq+Jmls4Ck2BfR41HC8CW0ALY1PH
 zLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783260331; x=1783865131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UTgD4XU6nX98udZAcwuur62Dr9OUg4XQkoqc7W/QL9U=;
 b=aUSqyG9f72JRc/zbbsjv0iiPPLsV0IR9EUwBLwvnNofJuoKUoFG9kdhZ5y2NhkuGk1
 /B5ESMcJ8PPO65sNvfRfW8eylfAhznxvGJS566a11JDXeEPKvnfC2Aobw9XGz8voUFtC
 kqepR7Vd0qpBhb/LcczJ6yT4JjT3M7T6Ok/tEjuw/b+ImgIeViofyKZJdI+KJ633cI2A
 jtNatr27y8G7EzzWL+2xhLYaMgj4Qdl2JGCs3cFvSjwAXal27vQ+mbcoDu4Szh6uyvA4
 dmgw6hhs1Ouz14tnuAjlGLW+ZAkG/WdYkJeBXKFu2EA6ycWEnFhHtL5WfKfTkJkJIsVO
 TDIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+C9DPT67dslUAgB4xaH+2KbCB2KYHVt8LF6RllX/Si6ofHyV6o4Gn4aVP25A63KL/2jylm45fptkes@nongnu.org
X-Gm-Message-State: AOJu0YyVx5XkCRYRgyIYf3BHHckrZcHViqC/5vsDy4Vm/vvSxGWseZZG
 DxLhcWzT2AX01hHXZis0xJuJgJLeX5ZGgMntGz2kZtYPJpr/pJcr10be
X-Gm-Gg: AfdE7ckk4lxV8L63E6A1/FZcs0i5v4X8MJ7dt5MywgzQb9F2/7UDLd3XwN2DZuvuEdA
 72WJWqtSiTHvrItmGvliLcSTlC2fs9q2TPPkEtwvXG6/TIbWigQwykFUrG0TNMMMZUCvHKu4LfI
 OY22ODpHh4rXps9PGgrU2PIv2iiZFPX7D9oFe/cpsl4hkB53ycGZBByshXLqfGCYOtoVZp4wtRI
 KOuwsO813NgqCq7zngTVvuVrBNEz6ZiySd86gBiWQxc/XxtuYD5LdfF4bwrnP/4YgDZyCvAXlxc
 wkWB7x0Zz0GZeXI5cpJZ2XGOZOUgTaKPATJoMvM45OVvjAowIM7j9gILEfpqauhDtoCFGerCkG3
 NnTsl3fy5l4uvutgGNqJ9KCbcUq9hkgIehgMP1T4GsndbLNFblZk2POrBT3V/lYvUBfjMM4HOFQ
 La2TwsoYyTb4VfMmQ/viESB2kpZ0F9tP/PCRPVc4tAkGgWyaEipWtmBS6nqg7SIf1G2aWu
X-Received: by 2002:a7b:cd15:0:b0:493:b87c:c87d with SMTP id
 5b1f17b1804b1-493d11d81fdmr46963715e9.11.1783260329523; 
 Sun, 05 Jul 2026 07:05:29 -0700 (PDT)
Received: from user-Legion-Pro-5-16ARX8.. (cable-94-189-254-58.dynamic.sbb.rs.
 [94.189.254.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm16346149f8f.27.2026.07.05.07.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:05:29 -0700 (PDT)
From: imaginos <imaginos32@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, imaginos <imaginos32@gmail.com>
Subject: [PATCH v2] target/riscv: check G-stage write permission for VS-stage
 A/D updates
Date: Sun,  5 Jul 2026 16:02:10 +0200
Message-ID: <20260705140508.17692-1-imaginos32@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <v1-Message-ID>
References: <v1-Message-ID>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=imaginos32@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

During a two-stage (VS-stage + G-stage) page-table walk with hardware
A/D updating enabled (Svadu / menvcfg.ADUE), a store that reaches a
VS-stage leaf PTE whose accessed or dirty bit is clear triggers a
hardware write-back of those bits into the PTE. That write-back is an
implicit store to the PTE's guest-physical address, so it must be
permitted by G-stage.

Fix this by re-running the G-stage translation of the guest PTE's
address with store semantics. get_physical_address() then also checks
that G-stage permits the guest PTE to be written, and raises a
guest-page store fault when it does not.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3426
Signed-off-by: imaginos <imaginos32@gmail.com>
---
 target/riscv/cpu_helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

 v2:
   Reword an incomplete sentence in the code comment.

 Verified against Spike, with this patch QEMU's
 reported values match Spike.

 Spike (reference):        QEMU, before this patch:
    mcause 0x17               mcause 0x17
    mtval  0x80000000         mtval  0x80000000
    mtval2 0x20001004         mtval2 0x20000000
    mtinst 0x3020             mtinst 0x6a704073

 If I've misread any of the A/D-update semantics here, I'd appreciate the
 correction.

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2db07f5dfb..eb34ba19e1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1370,6 +1370,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    hwaddr pte_gpa = 0;
     const hwaddr base_root = base;
     const bool be = mo_endian_env(env) == MO_BE;
     int i;
@@ -1407,6 +1408,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             }
 
             pte_addr = vbase + idx * ptesize;
+            pte_gpa = base + idx * ptesize;
         } else {
             pte_addr = base + idx * ptesize;
         }
@@ -1661,6 +1663,28 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
 
+        /*
+         * The implicit store that writes updated A/D bits back to a VS-stage
+         * (first-stage) PTE must itself be permitted by G-stage. Re-run the
+         * second-stage translation of the PTE's guest-physical address with
+         * store semantics. If G-stage denies write, raise G-stage store fault
+         * against the PTE address.
+         */
+        if (two_stage && first_stage) {
+            int gpa_prot;
+            hwaddr gpa_paddr;
+            int gpa_ret = get_physical_address(env, &gpa_paddr, &gpa_prot,
+                                               pte_gpa, NULL, MMU_DATA_STORE,
+                                               MMUIdx_U, false, true,
+                                               is_debug, false);
+            if (gpa_ret != TRANSLATE_SUCCESS) {
+                if (fault_pte_addr) {
+                    *fault_pte_addr = pte_gpa >> 2;
+                }
+                return TRANSLATE_G_STAGE_FAIL;
+            }
+        }
+
         pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                            sxlen_bytes, MMU_DATA_STORE, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
@@ -2345,6 +2369,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                  * doing VS-stage page table walk.
                  */
                 tinst = (riscv_cpu_xlen(env) == 32) ? 0x00002000 : 0x00003000;
+
+                if (cause == RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT) {
+                    tinst |= 0x20;
+                }
             } else {
                 /*
                  * The "Addr. Offset" field in transformed instruction is
-- 
2.43.0


