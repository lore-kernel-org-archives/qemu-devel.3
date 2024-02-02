Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503E0C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvN2-0008QQ-4m; Fri, 02 Feb 2024 10:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvN0-0008PW-Oy
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:22 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMz-0004Xj-3D
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:22 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d93f2c3701so13354555ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706887339; x=1707492139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DbEnVS8J5zrAAvxjFOvjXj3Aby0zHgBTzHL04v/6hI=;
 b=bu1HXh/0M0bpccN9i285lZ2Pui8JwXdPLjk/SJSopPJ6mQ+GyMJaV+hA9SbtYV9FdV
 f6RGrQVoIQFG+PesSzPn4yNBqTL71UJaaIVhWHGuxBL6UPelrYDeje/AWVFTiBQgkHkw
 DkgYJoeI/0hzksPqBvRGy9Woo7/310fGZuQKVfB/fGnz6rvPvlKkkTZBwXjiKF7+mSNM
 HUhoaEH8ADs4ZDkEjFUL2xmeCFAkeLH+DGq5rDZJE0IewiOCAtgI6cxarozgm9vEbqdS
 32O91aIpS16wcezaAhuV+5VANsbgmJ3+gHdYtozfF1D/VT8hZWiNJhzKAqCX2e+pSM/q
 f8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706887339; x=1707492139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DbEnVS8J5zrAAvxjFOvjXj3Aby0zHgBTzHL04v/6hI=;
 b=k1dEZHhOw2inGzxnMrE25xU0dwuGDFlhL0U/cakPPX5CAg380tcRkm2WUFBxKp+JHb
 dV89rmkbpkS4JFdbOilqzmQY2B8fCo1JMlkh58XZf0c3qh2muu7le+1L9RlWkRKiJC2H
 9DducKYCpOWbFklFbZDOquicmKDVIgm7a9kb1CZf9575+JplAvltEPW6SGSea4HnUOD0
 4eYqdktew2je3Fd95MJ0mOKGwVvC+2/t4ECLPA42haYIGokkjFWoDEaH0qXiIl/phXWu
 QAU/zK5kjing7/GSgyKz/pz68infxtB50+vAOFEv00hJor/bt1JDVsdbODP2CwS7BUYn
 wMRg==
X-Gm-Message-State: AOJu0YwT1/3uwEMBrBEV1mmfsd9P+pxtv1UeU8f+a0DpKBBkcNPMmi9v
 2U0D5N89XsO6eedkVcgsrWXmVp5jhezqRqRUib5N5hhfgU+paCTNxfEWs4n+CrM1WbFqpFDDBX8
 v
X-Google-Smtp-Source: AGHT+IHT1XsNDgSPfUCCCDiPFwVqOBxjOssyPrbHFUL5Srg8UbHJoglxOPQpP/cqrFzTtPOkNYPPaQ==
X-Received: by 2002:a17:902:d488:b0:1d7:102b:2e60 with SMTP id
 c8-20020a170902d48800b001d7102b2e60mr9660353plg.52.1706887339086; 
 Fri, 02 Feb 2024 07:22:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUzswlhazj650tmffHcSUO3FplQtlkk3cjoVrz7L2N1uUqSGVmFqPHh1cuKEuoANGdVjI0rMUD0uTzxSGH6fOBmkRLhAcge6IrjCO31Cp7Z5CuQBwFzftE1X0R5bR03mF49GxRBYP7kfn2pjDXkcg1tNAmMm2RMvgsjBjyluXSmhMkAAwIi+ivJUdhSsSz1EQakWopl5XIQ3/tlrWmJA6BulkH7KPgAtNqRbJ17mcoCSkYazEFXC9PgJDhtu07ws+QEeau82bMCzy8XYabmrSLcByV1ogJ8CQ==
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902f24300b001d714a1530bsm1734381plc.176.2024.02.02.07.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:22:18 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 6/6] target/riscv: Promote svade to a normal extension
Date: Fri,  2 Feb 2024 12:21:54 -0300
Message-ID: <20240202152154.773253-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152154.773253-1-dbarboza@ventanamicro.com>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

Named features are extensions which don't make sense for users to
control and are therefore not exposed on the command line. However,
svade is an extension which makes sense for users to control, so treat
it like a "normal" extension. The default is false, even for the max
cpu type, since QEMU has always implemented hardware A/D PTE bit
updating, so users must opt into svade (or get it from a CPU type
which enables it by default).

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         | 9 ++-------
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 50ac7845a8..f036b153a1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1422,6 +1422,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
+    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
@@ -1534,7 +1535,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * and priv_ver like regular extensions.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
     /*
@@ -2182,8 +2182,6 @@ static RISCVCPUProfile RVA22U64 = {
  * Other named features that we already implement: Sstvecd, Sstvala,
  * Sscounterenw
  *
- * Named features that we need to enable: svade
- *
  * The remaining features/extensions comes from RVA22U64.
  */
 static RISCVCPUProfile RVA22S64 = {
@@ -2195,10 +2193,7 @@ static RISCVCPUProfile RVA22S64 = {
     .ext_offsets = {
         /* rva22s64 exts */
         CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svpbmt),
-        CPU_CFG_OFFSET(ext_svinval),
-
-        /* rva22s64 named features */
-        CPU_CFG_OFFSET(ext_svade),
+        CPU_CFG_OFFSET(ext_svinval), CPU_CFG_OFFSET(ext_svade),
 
         RISCV_PROFILE_EXT_LIST_END
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 43c32b4a15..9fc64979f1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1314,6 +1314,12 @@ static void riscv_init_max_cpu_extensions(Object *obj)
         isa_ext_update_enabled(cpu, prop->offset, true);
     }
 
+    /*
+     * Some extensions can't be added without backward compatibilty concerns.
+     * Disable those, the user can still opt in to them on the command line.
+     */
+    cpu->cfg.ext_svade = false;
+
     /* set vector version */
     env->vext_ver = VEXT_VERSION_1_00_0;
 
-- 
2.43.0


