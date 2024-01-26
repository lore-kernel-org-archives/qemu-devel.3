Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C27C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMIm-00015e-9a; Fri, 26 Jan 2024 08:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIc-0000t2-Po
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:14 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIa-0007dW-Rj
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:14 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so373284a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706275871; x=1706880671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiekAr7rZgYcU2IGkVrfbUPYTKoPVa5QUXzJp79BZr4=;
 b=GozLm+OitaiA0LKWYasEq44fKd4DhSXF11uqW7/dD/ZcSk8qpuCYi1CH3/juq/2Mpi
 MKdoYR5OSfwJYED8eRaZTWY2CFsCHYUMnefxuHF6p6c8fRlZe1Xgzsu4b7ogI6HcTgM5
 3LFdNm5dfHOQrxYaYAVXApwxDaCurH8jA5AP9W2JA19c6fZHO2x4tfBQpZavg2oBWVXq
 58rKfzg/p/CRHM372oVBBvn9gQ/rVwpvkyTB13a35ntrav80PIYzBKS5NTqWkoPu+4Fx
 eQfKYhqqg0cZAIAh3hIjcE1ur58FBPVwFT9TxUAL9peZlbnosH/kdgC2dr+700qSngVA
 xEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706275871; x=1706880671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiekAr7rZgYcU2IGkVrfbUPYTKoPVa5QUXzJp79BZr4=;
 b=Oxo4x1nuD1+SfbVhP91vjzKpTEtOlLSiCrCBEqawM1MmpP7Tm2if+cGIrOQ7KV0D3D
 YXaOaD0KEld6+3N7gUlOMhVf9SyZXntrDixby4hs1yUwrCKzT9ITjPROSr5qzYsQ5vd/
 nbRpy8Vv7h/DSIqoOhPVhR30KkxzDvSfqJEfOcKsWBsRdQgaJPccp68FeB00TcnjM/OG
 XgJm0jnO80rUASKEIfMx1lVtl3ELpGYIQtcHDpzhsTSl1ZVTcty2E2jG5iuzaJjgAopw
 iimg3svUQDTOZWkLTMU1ss9XAVC6MZ/k5gJZzq17Ho1jH2WWj5MrP+kZqyufhCVN7NBv
 lQlQ==
X-Gm-Message-State: AOJu0YzB1/UI3nyXWlcgFJPD0glQRLqbdIHg/2/yIaj9NPRw5oaQWs5X
 fvBcd0dlANDm9XpMrSEMoRbatRQPZmPRhwZBMhPB7q4wpAPmI4RSSDq2VCdVhbzkBF/i8DFl3ow
 y
X-Google-Smtp-Source: AGHT+IGA8SflCD9biBxv5FT4LbxrUj9L2yjkOdahc/csT8XM/1sdud8oSbh46LjSrZK0tGEWW7sOjw==
X-Received: by 2002:a17:906:1d0b:b0:a31:5b30:6f54 with SMTP id
 n11-20020a1709061d0b00b00a315b306f54mr857524ejh.30.1706275871393; 
 Fri, 26 Jan 2024 05:31:11 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a170906111400b00a312e352dacsm624861eja.181.2024.01.26.05.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 05:31:10 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 dbarboza@ventanamicro.com
Subject: [PATCH v2 6/6] target/riscv: Promote svade to a normal extension
Date: Fri, 26 Jan 2024 14:31:08 +0100
Message-ID: <20240126133101.61344-14-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133101.61344-8-ajones@ventanamicro.com>
References: <20240126133101.61344-8-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52e.google.com
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
 target/riscv/cpu.c         | 8 +++-----
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a56c2ff91d6d..4ddde2541233 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1421,6 +1421,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
+    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
@@ -1528,7 +1529,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * and priv_ver like regular extensions.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
     /*
@@ -2175,8 +2175,6 @@ static RISCVCPUProfile RVA22U64 = {
  * Other named features that we already implement: Sstvecd, Sstvala,
  * Sscounterenw
  *
- * Named features that we need to enable: svade
- *
  * The remaining features/extensions comes from RVA22U64.
  */
 static RISCVCPUProfile RVA22S64 = {
@@ -2188,11 +2186,11 @@ static RISCVCPUProfile RVA22S64 = {
     .ext_offsets = {
         /* rva22s64 exts */
         CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svpbmt),
-        CPU_CFG_OFFSET(ext_svinval),
+        CPU_CFG_OFFSET(ext_svinval), CPU_CFG_OFFSET(ext_svade),
 
         /* rva22s64 named features */
         CPU_CFG_OFFSET(ext_sstvecd), CPU_CFG_OFFSET(ext_sstvala),
-        CPU_CFG_OFFSET(ext_sscounterenw), CPU_CFG_OFFSET(ext_svade),
+        CPU_CFG_OFFSET(ext_sscounterenw),
 
         RISCV_PROFILE_EXT_LIST_END
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index bc3c45b11704..b93df1725a79 100644
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


