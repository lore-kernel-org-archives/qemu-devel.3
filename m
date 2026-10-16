Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A0ECCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWP1-0004Bc-BB; Thu, 15 Oct 2026 21:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNE-0001Wv-Ny
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWN8-0004Nw-RA
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e49fbf92aaso35214685ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112671; x=1792717471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRaeg/6G5BW8Es5gFzB+H1ntDxj2EQKPI5DSePUvoyY=;
 b=FKeECKyn54W4vII6zjFfE1oia5mqlOwPfID+zd4dCk86zySycf31g0q4hHiimBK+gP
 4jgBLhlKGuKlRYK9aA+JOcqfOnn+1zpBS3yanBk+jOtHExfVsavwx8E7kZimrOa+jOEm
 0ptweJxcT0IHKX+NiFvxGfEQfaX8kx/V78SkDJbAX45isWddE2vy/4pwp3gQWVEiqYDc
 B7y71NZfS2Qlk6IBVRVkyBv11xdlJo3t1LXeifb7g+h/TgqIiPey71+/RdAyqpxL/1Ka
 qMWiapwu9OCuWOOjrzZDItB2ylDxO9CXRj9y7bnbgLfpjyRFWyE35EplAkhzFwO0JsH0
 KI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112671; x=1792717471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PRaeg/6G5BW8Es5gFzB+H1ntDxj2EQKPI5DSePUvoyY=;
 b=xj2rtinHSgSy7qO0VEqcfwXJdX7qAxtSS4vqbHdzaUo67Q+LeWSCIC3Jde5266YNM/
 FeKPNcND4YcyQytMMJKJO9/eDGg2NDyjCa6ODDroPe9DsViaA5QVERI7RJzGk0xYPiDO
 DEPUMsuv+9+wL34PIMQgE5VefCzWkhRuDlnnaXFlZL59rSGDFnp8Nrpuq5UYQMoVxFH7
 T3VRCY4wBvQu/hUZGIC6hw72Q8TDWtjNmGNjDVY0hs0JeJJb3xs6ryCnRehfv4MJ/Xhd
 Kj0pBou6VgmwGPd+A0vlgTgZGQwMpXJfW2keJfyRlAa081PI29mQ7VTwH7Kr5kZLhkcf
 lJBw==
X-Gm-Message-State: AFq9FYJ4F6Ek1jAhRTC7WZP2CTWa7v2CbH/O4+ssXvd+yvR950Ac9L/L
 T+NMNZG3eXszDeqk5FQAoJt9mA823z4hNSDBVgcm8Zt4i3p5Mf5Zmot6NPhQ8A==
X-Gm-Gg: AYBFou1nFU1t+IwfEEsFHuEYLGM16YgGpdv9GcCp36QQyap5vmIeO6HLY8j6E9XwQsq
 lyUPVBXcFRXwPrDCKIvuUlPW0texTrNfDLd1LU55UMoMGL6mHXOni4yghW2hflpZzr+BcvSwC/v
 mPsm/0Uq6dEv1c1bdXuqZt/MUvRiW0yJqT2swRChdCjBX5FL5rqozV35FS5HVeMmbYa9PCoTAR2
 zHUfH/0DDvhbFVKDXZQ8+izYpPd57O2KHgD1RgVxACz6bKw7xSMU73dEDxqfzCkjthvzktQ8qUI
 RR66ZachPXanl2ZzyZrvuS4FANcCwNIWJL8+wSzId3HW1ovHqhV1olqVxgO0VaY+TpMdaPrNh7j
 uw9LCsNphZ+MYi7Rh46QDp3xXvGwWGS92QrkAS1b8yewDQPuOEc2ap/7J6iQyjkwHE8+EK5LfS+
 EluKdaNWgqQu632kB1yolhnNoQVKQhNrRYiqBZrJdwa4dfRbt4PPk1L+ga6aOjIsllTXh4/oUEz
 RlXIP2/6gO1+ugi
X-Received: by 2002:a17:903:2283:b0:2e8:3d48:4d80 with SMTP id
 d9443c01a7336-2e842ab6dd1mr179754115ad.45.1792112670817; 
 Thu, 15 Oct 2026 18:04:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Icenowy Zheng <uwu@icenowy.me>,
 Alistair Francis <alistair.francis@wdc.com>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Chao Liu <chao.liu@processmission.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
Subject: [PULL v2 36/50] target/riscv: add riscv-server-ref CPU
Date: Fri, 16 Oct 2026 11:02:23 +1000
Message-ID: <20261016010237.1102834-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support and others.

We're going for a profile-based implementation, instead of a regular CPU
that can inherit RVA23, to allow future CPUs to use it internally as a
starting base for their own extension sets.  There's also a new
'rvserver-ref-1.0' flag that can be used to set the extensions in the
command line for other CPUs, which can be used for testing/debugging
purposes.

Note that for all intents and purposes "riscv-server-ref" is a regular
CPU and no, we're not trying to set a precedent of calling the riscv
server platform spec a profile.

[1] defines in rule SEE_020 that we must support at least 11 debug
triggers (4 for insn address, 4 for insn load/store, 1 for icount,
one for int, one for excp).  We're going for the minimum.  If more
triggers are needed users can set any trigger amount (N <= 1024)
with:

-cpu riscv-server-ref,num-triggers=N

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Suggested-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Message-ID: <20260928201107.2049458-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1a28f1369c..61234842e3 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
+#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 658a8162dd..306be10d10 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2437,11 +2437,37 @@ static RISCVCPUProfile RVA23S64 = {
     }
 };
 
+/*
+ * This riscv-server-ref entry isn't a profile per se but its
+ * CPU definition can be modelled as a profile that extends
+ * RVA23, with additional things on top of it, and allowing
+ * future CPUs to derive from it via
+ * ".profile = &RVServerRef1_0;".
+ */
+static RISCVCPUProfile RVServerRef1_0 = {
+    .s_parent = &RVA23S64,
+    .name = "riscv-server-ref-1.0",
+    .satp_mode = VM_1_10_SV48,
+    .priv_spec = PRIV_VERSION_1_13_0,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zkr),
+        CPU_CFG_OFFSET(ext_sdext),
+        CPU_CFG_OFFSET(ext_sdtrig),
+        CPU_CFG_OFFSET(ext_ssaia),
+        CPU_CFG_OFFSET(ext_ssccfg),
+        /* ssstrict is always enabled for PRIV_VER_1_12+ */
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
     &RVA23U64,
     &RVA23S64,
+    &RVServerRef1_0,
     NULL,
 };
 
@@ -3829,6 +3855,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
+        .profile = &RVServerRef1_0,
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .cfg.pmu_mask = MAKE_64BIT_MASK(3, 6),
+        .num_triggers = 11,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.55.0


