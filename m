Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BF5C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlx8-0005ZP-DB; Thu, 27 Jun 2024 06:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx2-0005Mj-O0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:02 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwl-0001fc-7p
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so6421952b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482501; x=1720087301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvMRDH0FQIgQ5mFYlmZC/NLgQuA8hoNsfm8XEnF2ha4=;
 b=ewn1/Yw0Kahqc7FQrdJanSH5CqPh4GT6lN9IcE1vLS/jDcWNU1scF53YEOUbHll59M
 h4LCTxdk9LSi5VLfVZYnoP6EGBSgdWb4212NGEt3ThQ60rhk0Jgl93kdcm2gsIB+eSbU
 KLuYgqx1dNkqC1rzfMoaaHOh3f+LhCseWmnSVhjWlDDhX9KnA9l/fKlbdxlt4zbTwhz7
 U5ELR/NL6KME7y4tQSQWAL4YTljtfG33MhamL6ASWx2Xdegis5jpN6/Sf1WljYrF1Rzk
 VO/98yc80FpR43hYEg4sqw0L93mOWypLbSQAvNg29+Ay7jr5hq28Y12lQUWuzxvLbX2T
 1rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482501; x=1720087301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvMRDH0FQIgQ5mFYlmZC/NLgQuA8hoNsfm8XEnF2ha4=;
 b=T1bWmnWy8Y+is1xv3x8gSxCKjaR3usi3uvHSw7y6hgjYb78ZD+oiB1N0/7P/1Awd6n
 DwyU/TxbpMo8T1PJoWHAjf1EDGTqdJHX4MH+O0PtSaAuPzJVOBgtZ5i7NwH/VVMAva8C
 hqeV1eoHy2uT6El7FwZXGPME1NFP3Z6JVldxq9G9+MzdSb5Y3tEEUs/OiSVYmRV6yWt6
 XrofH8LD6Lndl7rH6+tdiP625jE9FtqF2z91iFaDfACDkNlOLXCPHmamUydBGT3RxXAH
 lMDqbRzbqScvWkGkI6Id82AoAg1EtICahmy5CAmqXILiVWE4LSSn+XXKTfxC4ZAAje5E
 QICg==
X-Gm-Message-State: AOJu0YwBE57bhdeNlRQdvWp5DPlmL/oXztuWT/bzd7JC4CRWy7I3ki7x
 Ch0uX3IFYaMfkHUTyxMM5i27+l8siP5iA73Gg5qmqdM1p3gRv4PasTkWSrK/
X-Google-Smtp-Source: AGHT+IGnARjqFpwr5iB98XKm5Y+AJevAy0S0llDAudCOoxX/IkffRKLqnvxqWAbaEKJ7wiUQZs72Mw==
X-Received: by 2002:a05:6a00:3cd3:b0:704:2696:d08e with SMTP id
 d2e1a72fcca58-70681ee315emr13261496b3a.13.1719482501469; 
 Thu, 27 Jun 2024 03:01:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chao Du <duchao@eswincomputing.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/32] target/riscv/kvm: add software breakpoints support
Date: Thu, 27 Jun 2024 20:00:33 +1000
Message-ID: <20240627100053.150937-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Chao Du <duchao@eswincomputing.com>

This patch implements insert/remove software breakpoint process.

For RISC-V, GDB treats single-step similarly to breakpoint: add a
breakpoint at the next step address, then continue. So this also
works for single-step debugging.

Implement kvm_arch_update_guest_debug(): Set the control flag
when there are active breakpoints. This will help KVM to know
the status in the userspace.

Add some stubs which are necessary for building, and will be
implemented later.

Signed-off-by: Chao Du <duchao@eswincomputing.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606014501.20763-2-duchao@eswincomputing.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 235e2cdaca..748fe5980f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1969,3 +1969,72 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 };
 
 DEFINE_TYPES(riscv_kvm_cpu_type_infos)
+
+static const uint32_t ebreak_insn = 0x00100073;
+static const uint16_t c_ebreak_insn = 0x9002;
+
+int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 0)) {
+        return -EINVAL;
+    }
+
+    if ((bp->saved_insn & 0x3) == 0x3) {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0)
+            || cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak_insn, 4, 1)) {
+            return -EINVAL;
+        }
+    } else {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&c_ebreak_insn, 2, 1)) {
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
+int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
+{
+    uint32_t ebreak;
+    uint16_t c_ebreak;
+
+    if ((bp->saved_insn & 0x3) == 0x3) {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak, 4, 0) ||
+            ebreak != ebreak_insn ||
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
+            return -EINVAL;
+        }
+    } else {
+        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&c_ebreak, 2, 0) ||
+            c_ebreak != c_ebreak_insn ||
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 1)) {
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
+{
+    /* TODO; To be implemented later. */
+    return -EINVAL;
+}
+
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
+{
+    /* TODO; To be implemented later. */
+    return -EINVAL;
+}
+
+void kvm_arch_remove_all_hw_breakpoints(void)
+{
+    /* TODO; To be implemented later. */
+}
+
+void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
+{
+    if (kvm_sw_breakpoints_active(cs)) {
+        dbg->control |= KVM_GUESTDBG_ENABLE;
+    }
+}
-- 
2.45.2


