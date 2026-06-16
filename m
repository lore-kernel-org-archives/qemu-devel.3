Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF354CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgs-00078q-CU; Tue, 16 Jun 2026 06:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgq-0006v1-Ae
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:40 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgo-0003DG-Ky
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:39 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c85b2139015so1408343a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604397; x=1782209197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPNd6SRZTVpSELxV3dLcc+YGY5aEYk44oCfhXn4GB7c=;
 b=IQH7y4HmM79cYbTZkEfyKIK1usfCOROgDZhs5whSV/JiaHfjeU88VMLNuLhXlCrWJ0
 NXmLNoSm5lvBHkxnu+PT08X0lB9kU2DT5YeI+DU+RA6GCvS9pfzfvkljkH4f3nL1Blqx
 +6YQmRX/Ca/qkkyTo3uVxUo/shWJztZGhSph+jJ1c31UbyYbu5yw9avlbkeMjuYWQWAP
 SmXUN+qgBpYb/rh3e1Vi+rJ3um28M8Kd30ua0tcfuivexXf4NkqoyMD52OAUWoQ2F/kG
 3WsJge9r1K2yad3+2Lk5N8FcRJaovbKnETCVewx9iN1nG5LH8Zxfvj7cDHJIe+mvzFnH
 KOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604397; x=1782209197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IPNd6SRZTVpSELxV3dLcc+YGY5aEYk44oCfhXn4GB7c=;
 b=RHjmokx0pcO0bWzxHm1V9hUAJ9tvZWYPayD3g20S31ktjRAFu9dCy9se5FSKolwN+9
 3Ay++an3WpWPC5LaKllMvVtazQhmUJONwzylwvjx9Zg63+EJo1xZLT+GHAfPyoRo4147
 IwJwdn7XpXoTPmoEg/YPGWgm3f4l/1ctC9+NgvmZakkzRe/fyT1ONcmm7vt5fTu6r7GU
 aFunbCRGQQlTU/mC/M9S1IXMqdTX772+1yWHBaOJMf/yVNSu41aZN5O8bwJAH9saaaJc
 6nh/FKcTnN//fecY/TEz6p2PQN4bOTbktBtlWhSDWljnE3GhX96voRLWZjvET1vaj4bj
 zkhQ==
X-Gm-Message-State: AOJu0YzaWyE+frhSkY5vBJGdcznxTt/o48JgPWmjEbZELBsbNEh0ssY2
 iqDsnUK90jrQ0JVqIqt06ubVq4WzgxYyDGzEyzvFcZc5oqS5Mxfr657QY1AdZoiB
X-Gm-Gg: Acq92OEmqHk9IJov37TLrrV06kYc5f/+GIj+e4eVeEgd1vNz+DtYqY9FzOWG5Zglzyt
 5hpwc+S7qNBztZjU1us+eFiH3RxW+1PEk6U5DTUtGyTfAGwJ3MFQ8AU5Rv5xv8yyhwKRz3i4MCq
 J8mgkWEZVfHcZ65R+NfxG9KkX5anE6uhbjngR/3l7N/X2K65fdnhEqD7FPK0ixdfVuLdM2CJcSP
 yrYqc/OGchQHa4FV7fT02zN4AJcHIFzlvYuBX5rT+34fLNqBmS79uYDJt4tGcI4ePSuKWGjhI4q
 5MxSAS8nPjU2YMI6MiNoHGKRXZJG6h4ofOSgTO4yqJp2O+XiQzLLMPCSUxmfhaipGnXYS88+71g
 lvPipDodfuaImomLsCP3EgSAfGgRd7wZ9XUlSHAVReIByuO9e3UzSinkseoR6tchqte/dtJnTz4
 YilGxv2cf4tkKyavaHS6QVMTkYN6ZwOBfo/WQWnsiv
X-Received: by 2002:a05:6a20:2443:b0:3b4:813d:dc1 with SMTP id
 adf61e73a8af0-3b7e49c16eemr3372376637.31.1781604397219; 
 Tue, 16 Jun 2026 03:06:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/83] target/riscv: Fix size of priv_ver and vext_ver
Date: Tue, 16 Jun 2026 20:04:21 +1000
Message-ID: <20260616100527.1939565-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Anton Johansson <anjo@rev.ng>

Fix these fields to 32 bits, also update corresponding priv_ver field
in DisasContext as well as function arguments. 32 bits was chosen
since it's large enough to fit all stored values and int/int32_t is
used in RISCVCPUDef and a few functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-8-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 6 +++---
 target/riscv/machine.c   | 4 ++--
 target/riscv/translate.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 50f9ce1f86..5336344cba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -240,8 +240,8 @@ struct CPUArchState {
 
     uint64_t guest_phys_fault_addr;
 
-    target_ulong priv_ver;
-    target_ulong vext_ver;
+    uint32_t priv_ver;
+    uint32_t vext_ver;
 
     /* RISCVMXL, but uint32_t for vmstate migration */
     uint32_t misa_mxl;      /* current mxl */
@@ -846,7 +846,7 @@ bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)
 }
 
 static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
-                                              target_long priv_ver,
+                                              uint32_t priv_ver,
                                               uint32_t misa_ext)
 {
     /* In priv spec version 1.12 or newer, C always implies Zca */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index a4d337c27a..b6a85ccd3e 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -459,8 +459,8 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT8(env.frm, RISCVCPU),
         VMSTATE_UINT64(env.badaddr, RISCVCPU),
         VMSTATE_UINT64(env.guest_phys_fault_addr, RISCVCPU),
-        VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
-        VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
+        VMSTATE_UINT32(env.priv_ver, RISCVCPU),
+        VMSTATE_UINT32(env.vext_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
         VMSTATE_UNUSED(4),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1ea7faea4c..18a1e0ae99 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -59,7 +59,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     target_ulong cur_insn_len;
     target_ulong pc_save;
-    target_ulong priv_ver;
+    uint32_t priv_ver;
     RISCVMXL misa_mxl_max;
     RISCVMXL xl;
     RISCVMXL address_xl;
-- 
2.54.0


