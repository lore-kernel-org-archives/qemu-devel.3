Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA4BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9l-0006fO-GN; Fri, 08 Mar 2024 06:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9e-0006f7-2r
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:47 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9c-0001YN-El
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:45 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1723265a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896363; x=1710501163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70LaACHuPy0nmyeYlSDuWjPnnxsGUPrekddZa3Ix8Gw=;
 b=XwamuOktu4GDJMHbO4U4hwO43ufVJZxMB3+rQrEJoHiPcggW3dCahXpPgQNz8/IY7j
 OZQ/tWbEYW9y9oruIS7niBQBl23+A+j/QlCIKiRHCJiA5JilHwrTopk7cda3rxhO8yzZ
 vhlX2bq2pfJ3L/DbCQtUhQktg39KOKUkO/zzM89vwNNxWdnCIFbf0ivH/Ec68EERpZ4i
 omAOGAxxwuPynTtfck8mGtRf0Q3CUdczK+2jq57XDjKX5p4jibZUc0BMurzVjvYWH5hV
 PwvPLLbIqYrFsmbFjjlHbchOGT0R5yEUY/o2GqMQu0L6RHwNGU1Cq3D7l80xTETi3PH8
 WZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896363; x=1710501163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70LaACHuPy0nmyeYlSDuWjPnnxsGUPrekddZa3Ix8Gw=;
 b=kuGfKK6/AUKMz6xxy7W29FcJpNcYl8oY5I8bq/p5VhLfgNC4X/88G3gXY6WXMaLmaz
 ojkH4L96gb2NTIlMJ/a2R9vfKE8o6WtMjNRnoEp22yKS4Y9eFn3yYfpLDqxjnxX39ZUD
 iCbk18C1dHkrmmwHstGDCebLJdl27MUrLKcsnikTJWZz/tRZMhcfcLQEt8fZDoibFmSS
 Lp31XXq+j5ZGLKcYQA9yyHwRaj2QBJnPSJRIR4K6QuWAuQJH0xLTpGdOo4TDeO4g9q9s
 l3U9bEQz9RN+rbjM6HSOkSOTApHSf31f0ppGUHf5FFufg/vrheMAD8h8KdzizwYmBO+X
 9SnQ==
X-Gm-Message-State: AOJu0YxgiypqsAVVA+XXVp/jQiVCCLcJu3hZzxIhw4DZG2GimFdESdeG
 GmjFF/dsiHUBUNTZP4ODlx6mJca/NObCMV9VeVRYvXfqFPDHkqHahLuQ3bvu8mvS1w==
X-Google-Smtp-Source: AGHT+IEyjfVbp6nNtZifcjkLhwfBJ3bp0Z/vNSo7CFfk0Y0UzP8HCzzOXKdGV8XqKQ/RfHXYitYosw==
X-Received: by 2002:a17:902:e552:b0:1dc:ce6e:bf06 with SMTP id
 n18-20020a170902e55200b001dcce6ebf06mr14032620plf.0.1709896362685; 
 Fri, 08 Mar 2024 03:12:42 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/34] target/riscv: Promote svade to a normal extension
Date: Fri,  8 Mar 2024 21:11:30 +1000
Message-ID: <20240308111152.2856137-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240215223955.969568-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 9 ++-------
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e9cf950d6b..71bdedc9bb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1474,6 +1474,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
+    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
@@ -1589,7 +1590,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * and priv_ver like regular extensions.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
     /*
@@ -2237,8 +2237,6 @@ static RISCVCPUProfile RVA22U64 = {
  * Other named features that we already implement: Sstvecd, Sstvala,
  * Sscounterenw
  *
- * Named features that we need to enable: svade
- *
  * The remaining features/extensions comes from RVA22U64.
  */
 static RISCVCPUProfile RVA22S64 = {
@@ -2250,10 +2248,7 @@ static RISCVCPUProfile RVA22S64 = {
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
index ccfb7b2dd3..ab6db817db 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1282,6 +1282,12 @@ static void riscv_init_max_cpu_extensions(Object *obj)
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
2.44.0


