Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD54BCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGps2-0001eJ-CM; Tue, 13 Oct 2026 23:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprz-0001Sy-KK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:35 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprx-0001lA-Ki
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:35 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3a80d1c98f5so344520a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949292; x=1792554092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yihw9/tmy2HOrE2zuiqAqJjvlQRGGP5lmkaoPyRqowA=;
 b=AZzlRsG7PvQ5mN+E1YRaIS11wTKk+nXbWAKzNtQ6ArYrPfDKCwcu5S2EyPlxETgcvC
 vLqyhtTHAYZBs/tGbcPMzhiDm2/s2DA8T3SmbZJcMef0Cr54bpc9g/PZksu/+wwGu8P/
 lUgCcXdf5xif9qZNeTzqBg+oWhDiiyu2OiLSMb2B+lYEh8WOO610fRJbdx2YSZcu6OXz
 RDvH2PXwPHnq49fJ6j1NPNkur2tcJi4V6LUMnQlZgQTuxz/MzzGsUxvbvMLwdc3WRtWf
 sZbyTcM1LN/tHLxaS06KNzxZm3YoRoWzuqN91Z8wgEByJUAin6b9gMftwzOuM2CSI176
 hxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949292; x=1792554092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yihw9/tmy2HOrE2zuiqAqJjvlQRGGP5lmkaoPyRqowA=;
 b=HkYBRZSEP1M/yK4USlWpkCNhCbjAwa51AUrBrnpglsDgTKq2w6x6UxCMsNGAcpZ5SI
 2F1f/9OZVEcmtWLTgg1D3itCDBfF0C4X7dKokNiWW1/HIWSKB7CqLqhQTLxtdLSr8s0p
 PavdS8G14VGSyGRFSaOC9BEn2Dg03Wdc3lysPnQwDkxdm3562yVjZObo+osyj8l4xTd1
 Dlm70bDSxr3fpZIESX9ElxFaM8z3yTItIU7S/1qCEnkVinm8vr8qCBV0I/q7FVnHiqlk
 7ZxwiT5g7rDhh/k/+hto95Ge0QU7IS2znII4MyOOyPwpEcae8n9j+Yictd41yQRD0JNv
 lrew==
X-Gm-Message-State: AFq9FYKpq2ZIQCtQiKXI2FAfPX4JIMqJcskzpq7XiTtsE/PgX/g7P6P/
 sDIYrVFHEbS0jCFMyyQv3px8t0O3RL6Irhm4THFYqUA5VXzg0cdWBMfgbE4Zag==
X-Gm-Gg: AYBFou3SS0N+6hl6ozBKKAD5ix2Q15KO/5kwe/JuuYttlLXr2xUsCXMcOB5G6aEKZDL
 WtbdXQTD5XDzmws+KDbRWo0y2Cokb56mPYJG1ZFIbK1kwX7kw/ZcU8gMmVNffHoMzQ9oHUdIeZ5
 hb28N9WRe96Dh3UWI8dzatspjRTG2mclYVd4Q3UWFkJl17uy4zantlC2Y5QiGUiQZIaF5Ea4X8w
 sY6npHaH90kp3gnqQBZ9H3mHt0GjhNS9PEpIrz3FcHK2h22thQOwDCSJab1/gYHERLoLLNrhplN
 oacpTNGONxsYpWc9m91DwnPoCgb4fxOGZV4R9AfTt1UsgAI3uDKllMkRhb5JyDQ786E4m5nrHc5
 sifLnqqdSp1FJDS/fzLo3YD5Sz6MC9bB3UEn8D/LsISqxuo7Y0fG1FFdcHkYuFlkvN+WN4+SBUd
 J2KN0yQNSeWaox2Xh1fX2wqrsufMpNV/bVD0rkxlu0AW/YK7XiQoxXvokACRzpvJYJQ6pf+qFgN
 UJWmNHpJtum1xvM
X-Received: by 2002:a17:90a:e7ca:b0:3a4:6f38:f2a2 with SMTP id
 98e67ed59e1d1-3ab3a953814mr11281133a91.25.1791949292142; 
 Tue, 13 Oct 2026 20:41:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:31 -0700 (PDT)
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
Subject: [PULL 41/52] target/riscv: add riscv-server-ref CPU
Date: Wed, 14 Oct 2026 13:38:56 +1000
Message-ID: <20261014033907.3332383-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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
index 1c9b400f71..5e7a7f782d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2438,11 +2438,37 @@ static RISCVCPUProfile RVA23S64 = {
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
 
@@ -3830,6 +3856,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


