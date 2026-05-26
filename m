Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05285CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpbL-0008Cf-TO; Tue, 26 May 2026 07:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpbJ-00080H-V2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:34 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpbH-0008ST-5y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:33 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1334825de43so9061688c88.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779793530; x=1780398330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ng6il8Dv8YLZsJqBSssWRpk/SVL27WDge2w/ptSriME=;
 b=DoPM4CUkEanAiT1MfBZQbZ1MYcZRgEppIdXttO/i6+kk3D88a08Nhk/lcJCFxTafjj
 19h70klOBtBbw/qAwxCYseNTHzSPuudVSknj7k2Qf1IjMedlWpkKd/rl8VwIWfw0rLnh
 ejEvCEn/Bp056B4MG6uZWyRJcp+zoqIuP3GsKHSDcO+rSXIBdVxBeSniRrQfd+rZ2JaU
 y9kHFMnnPSzuQ6mi6/HtTrFakRmMTDjQjrZ1Drz0TMnh+v6/+hM7cdsCtqk8LADI6kf9
 4bNq8COnEIadO3NezWIMQbURYHxalNf9tKNnPV4b1mbK68L2sMWlksM7JLu3+IC8djNr
 9CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793530; x=1780398330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ng6il8Dv8YLZsJqBSssWRpk/SVL27WDge2w/ptSriME=;
 b=lAfz4ckCi1sKrNjqAdfDjk/GYbRIK+JPKI1Fl8WYXcOfeXyRXfUPHYv8x75Li+FrOs
 GkPAX1Y1QO7le3anxDOe3HXYR9jwCtuSwUTb5X6UcXt3ghbrBN42B8gO99dhheUuUoSq
 FShvj1pygAMTiVdW5ntifXagBozM/cPv43FaMlMEL3EaHTqWDeU7WTDH2crzOEVPxZbc
 NS8WPAIpDXj2aN8Snv4ppIC1XZJQEFkcziXUro0/xkZ6nXKl4/Zd1sRFP/S7UR+57/8T
 vz6DOWpDGmBy4X78qVccXAB2GM4U0u8jyhk0pCYAIHr3mTiRqpwPpmqviMuYmY0LaVFC
 TGWg==
X-Gm-Message-State: AOJu0YyHCXIkL6G1YU/raFohDE1iWvHy6ujzNSUVfEwySEfwwH3AzslY
 BkRqD3AIeNJ6KbPU1O1d7qK7sUqTNrCB8RWb+lR/5AXlDgGqKEYKoS9L99sACeYQDde1YA==
X-Gm-Gg: Acq92OFrcbrXCZoURkgDS/y2/uvRnlOl2DnrjyKG0m1pgccd+9/F8pvqMrB1pOsiEmD
 tGsCPFCtIOJmCr6mS0z6bq/AsQ0B6dgAsVRam2omIaNHSLRzCpNygYhOefOEdWjUAs2+S2GU83Z
 QfkeWYLdwOW7DqX2EhBFtqhajlo6Sjz4teGI28LJcJGxF0RgIUF59RgtOOlO77P2AePr/ldw+O8
 x12+7kSw4uaVKBNm+R9ejf1KtuQRCHDnUajUZCp5fUIcYcKubM9uW8MX8o+mA+ERLcNZ0m4/22t
 TP4dPvuxC6tJ4Ve3PmP7LBEL8BEO0t9eg8RUd7CjpAnfuLCAdHiObC78t78H+fIM3lhuwZOPFuV
 kzqJhyL3atcftQlAMQCE2ynjrOKsnSaG6wCK14tXEpmIincHkY4QwzoFKhYa9REjMlbBmKsWhuH
 eSG0gq++ksAPznXs7ugLIFl/7NyXW8tMiebU2gsPMkPx3pes/EWSdeu3uNBdL3TTs0QdUfwKSZL
 cXy8supNwI=
X-Received: by 2002:a05:7022:983:b0:130:7246:10aa with SMTP id
 a92af1059eb24-1365f703a38mr6131150c88.12.1779793529337; 
 Tue, 26 May 2026 04:05:29 -0700 (PDT)
Received: from openkylin.. (ec2-3-101-81-203.us-west-1.compute.amazonaws.com.
 [3.101.81.203]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm9250276c88.2.2026.05.26.04.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:05:26 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH v2 5/5] target/riscv: Build TCG-only code only with TCG
Date: Tue, 26 May 2026 19:04:50 +0800
Message-ID: <40b4ddf2925bf82413b06020325bac73f78bd42c.1779792111.git.fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779792111.git.fritchleybohrer@gmail.com>
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu_helper.c |  6 ++++++
 target/riscv/csr.c        | 11 +++++++++--
 target/riscv/meson.build  |  9 ++++++---
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 752752d520..e53a5d567d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -29,8 +29,10 @@
 #include "exec/target_page.h"
 #include "system/memory.h"
 #include "instmap.h"
+#ifdef CONFIG_TCG
 #include "tcg/tcg-op.h"
 #include "accel/tcg/cpu-ops.h"
+#endif
 #include "trace.h"
 #include "semihosting/common-semi.h"
 #include "exec/icount.h"
@@ -1714,6 +1716,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     return TRANSLATE_SUCCESS;
 }
 
+#ifdef CONFIG_TCG
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type, bool pmp_violation,
                                 bool first_stage, bool two_stage,
@@ -1756,6 +1759,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_lookup = two_stage;
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
+#endif
 
 hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
@@ -1780,6 +1784,7 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
+#ifdef CONFIG_TCG
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
@@ -2004,6 +2009,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     return true;
 }
+#endif
 
 static target_ulong riscv_transformed_insn(CPURISCVState *env,
                                            target_ulong insn,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f455..df5dff2c11 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2135,15 +2135,22 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
 
 static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
 {
+    /* Outside of a running cpu, env contains the next pc. */
+    if (ra == 0) {
+        return env->pc;
+    }
+#ifdef CONFIG_TCG
     uint64_t data[INSN_START_WORDS];
 
-    /* Outside of a running cpu, env contains the next pc. */
-    if (ra == 0 || !cpu_unwind_state_data(env_cpu(env), ra, data)) {
+    if (!cpu_unwind_state_data(env_cpu(env), ra, data)) {
         return env->pc;
     }
 
     /* Within unwind data, [0] is pc and [1] is the opcode. */
     return data[0] + insn_len(data[1]);
+#else
+    qemu_build_not_reached();
+#endif
 }
 
 static RISCVException write_misa(CPURISCVState *env, int csrno,
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 79f36abd63..c2b2f61ad9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -9,7 +9,7 @@ gen = [
 ]
 
 riscv_ss = ss.source_set()
-riscv_ss.add(gen)
+riscv_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
 riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		     if_true: files('common-semi-target.c'))
@@ -18,11 +18,14 @@ riscv_ss.add(files(
   'cpu.c',
   'cpu_helper.c',
   'csr.c',
-  'fpu_helper.c',
   'gdbstub.c',
+  'vector_internals.c',
+))
+
+riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'fpu_helper.c',
   'op_helper.c',
   'vector_helper.c',
-  'vector_internals.c',
   'bitmanip_helper.c',
   'translate.c',
   'm128_helper.c',
-- 
2.43.0


