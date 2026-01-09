Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28073D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RI-00067R-P4; Fri, 09 Jan 2026 01:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QC-00055Q-0F
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:33 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QA-0002u5-BL
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:31 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c5513f598c0so347035a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941789; x=1768546589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjFpuKrI65dY4xPj+2D6qx22ukyO0mIgkNS35Pgtsp8=;
 b=JcePT9hSL630E9fYZC1aKE1ZecixBWJNYZB/NnvkLaPN97NScq24WIBeUL9KdjqnwQ
 gpvZ5l4hYC3GXgwNfjWG+mPVbleCefBIIWraCSa5BgBO35GlG/XCQb64l2x+hNmMv2Dc
 a6RYMZ4dKYzPc3zlowbx2X+bwhb6oh80Y26lnnpQ5YwAEgBB2ErIccesr7We77quef6d
 NZ84BE+9SG4UZIlC+C/1FVqHnj43Nt/qJtIFjC97oTy8E5tBD7tLLGJ79aVsDO7YpOJr
 hWxyrnEZapqc3NIuZy3muO0yJA+PvI+3anT2dIdaNDVkGqyrhtvCHBB0yhodmdUmFpHy
 IaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941789; x=1768546589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HjFpuKrI65dY4xPj+2D6qx22ukyO0mIgkNS35Pgtsp8=;
 b=loqCxkxTrHRz/W5+QSAGznygUSkAJDaK+H0ZbBXlekh9LCUVv39RdcVfJZkFovTTrr
 MRdQGMD5w+v02oJKOPb19IWk5RTTAFUInW1NpNXp3Y+xuM+Vk3gHlPTslpy4dwB2D8fy
 lSEovesYb++ZcBESsd9QgG4OalqLIvXwy4v4ZeeMS3faXj01Yv+yVYeD3NnaHaNz01VX
 qwTfbDEhVrB0H1lUhFCs6KNuzk0HYEkX6FkaRaZ78uz3u8xi/0andUx4w20sHxO7vrz3
 bL8Ng+95zcHoah3S2ATzQ0VBaGH8nJnlknCPwiZLUpNhTvkaBdkcwUgx26oZMLE2HDcM
 njsA==
X-Gm-Message-State: AOJu0YyT8POeAf/eY2SE+CYa4e5pgESIrIdW6eDrXOvhPZv0PSux4hSp
 Jtx2oArImDOnMh/g5mc1z6/btYTr8uI8dSUkYBGNbYnPDFbR1hKKdoli4MzRuA==
X-Gm-Gg: AY/fxX6nhLFaVbEg5Rbp3KwlUy9n0LZB1hgp2aQ2NLiTgEMQcJ1oyYvoXd78+PLBj7m
 LU0jVoKABCLODYK4Ek6fsO5PMgc0q0bPwx59rJfWB1RXIg88FKKBepYbaeKCqZ1mK4n5545+7Uy
 +lSCWMjDR2Mdt66gbRAq0R6tPslV7kiGO5OH0EsuYPM/DdcPU1RMdcKoPAmcZL6OojWwCcDrnbM
 q7F3ps3eA8QSBlIFn9pRD7ZGodmYJ1V9MAzE54f+dYtg60khqCdmNgnTaKK6CkLbbc/oemsgfsW
 7Ew88AtQoCxYFEp4WMh+Yb4ZAxbSyDRxVGr/V8niuxZCWPaMBH6a5ow6sKEalz+X/iy0610t5e4
 CKydgLBtOkPd+GXXnNFk87rRPdBW9+GRyOl3hd4cdWisgHOObyvEnwRKJk1d1+vy7uDYeL8n/Ba
 hbRx9vFKQQn4FRnsA2+QuyS0hMW0GOYdm1lylgX+UARjytFxYZCcFdolXeUIUV4UFCfZFEFgG6Z
 A1nnrJnMgrOUCbMC/k=
X-Google-Smtp-Source: AGHT+IGtin0CvCeaGO4MlVwA4gHLFx1xBEQyIebfHdjRRjeJssYoRWEcuHm3gNVHI1MUARnsD9fCKQ==
X-Received: by 2002:a05:6a20:430f:b0:366:14ac:e20e with SMTP id
 adf61e73a8af0-3898fa81a6bmr8259141637.76.1767941788404; 
 Thu, 08 Jan 2026 22:56:28 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:27 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/34] target/riscv: Add MIPS P8700 CPU
Date: Fri,  9 Jan 2026 16:54:49 +1000
Message-ID: <20260109065459.19987-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108134128.2218102-3-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu_vendorid.h |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..f1ffc66542 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
 
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x127
 
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c2222228d5..3562cbec32 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3303,6 +3303,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode = VM_1_10_SV48,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.marchid = 0x8000000000000201,
+        .cfg.mvendorid = MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.52.0


