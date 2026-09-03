Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF23EC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2EOR-0000tc-VC; Thu, 03 Sep 2026 16:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2EOQ-0000sh-SB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:50:42 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x2EOO-0002Ly-GP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:50:42 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so202648a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788468639; x=1789073439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cRiHSGg8aFzQ9im/DzHBYXv1R98054JCriqwRL7CjX0=;
 b=VRc26g+a//5ME7tNODa1m5TYh4eTXeyWYe3v/h3QCFpfpUQ0T3EKC4kyFB3qErVW1C
 Npr4oosnRbCceUxrJWjXU9GR6mCfei8o2F5KRtzWeyomihxK0PUmTXHHJFq1EdZAPJAc
 ABYRCQdd1ydaCJEJKIpdlXFVFQZnHcoPaEnjoYFybUXM9tZS5cZV/pqAR3zZXzg4EP47
 xPBSBFZuWUgRk793QpcHL6x7AK7UrePayEkgaX4sqhBQCifUM0iRxqDL3yCfgB6ugYEm
 X5DPDlhozEO4tFxB80tdVcSPwF9RnGbQxG/sWf4zPIqQhZp8NU5c2dEwX93u96Ayfe1N
 wteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468639; x=1789073439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cRiHSGg8aFzQ9im/DzHBYXv1R98054JCriqwRL7CjX0=;
 b=l19+SlP7tkJOIvMhPpYe1CyWgeUiuRBY/xQ1tZdKUyWxu2quVVxfV9pM3mHimMdRFH
 CocYS5rpIe/guZZ5hAeedaQ6AxlgNQd8dlQUvWCU7mhDFjUIZBowFOhlNGbFzBuj4Sw2
 6TYXdYsMPTosKT1jlXbL9pFlCwnoCEaX2FKvKBI2QxlpX8DcEdAsGGcf9/cwl4TrxUJi
 GjZjUrX+4PcVUyy+3xuybYPKv/VvXOrT2UvEmh7d2M+sH8H9vOqjLsdzz3VicKbPc2zi
 OhD0ZjVPj93MBhWW+5YT3ocH+U9lF34Bzfsp3rYMWDLW3cdpAABlzIF/4vdOZKsgmlVZ
 xUtQ==
X-Gm-Message-State: AFuF++kNcpneYPJBu/RNgTXwPHEfw6DA2ojkOPdNfOCJ94Q6n7Bk6g7m
 mAB3nOKliEGXTG9ENnfsylZL7N5emFHaRblx+wa+lmUi5okrDPR9iUXcZauM9VCA
X-Gm-Gg: AYBFou2ShvxikVA6xfFK8LvOJPJfRA6YAFWdZ8/bfw1zpsr6MK5htwb7uwNxjFzPcTc
 t3zQukTVbA3VQcYde0Jl00AU0nShI4tp1Wc1+zLnPqzcHVZ6wkWvnkrpRlmCzU8Q6/mJL/9Y+Ug
 BVVeNsOY07FEFGeZzSyfvmaKofcIdqVYMjQHEjM5nRJvaEEO9dwaUdFJW/bjogUnN3bidH9L0CR
 ty4qBn+85F6olZj0UOGMtsEwPwteTcett4enwR/abclEQdWQrDKpdmcagYcoWiCqHWxUTh149Ib
 ZnUBwgxWom7dJ0I+JdjboqxDQUB7ky/jyYHqrM1e6QbsDDuc+Nlaj6z3Da0pEI+yn4534FaBqul
 FV0umOo67r3K0XZ3WSToqr2bu5+e/1lGDGp0w4W6xewROOhqjlOc7BmKsjU1pzJvAthlQELelqh
 VyONrSkY3oePI6xrfLh9duK4hzJEZ4nh7X3KZTqgJhdeOPOSAVxR7/aWaU63an63DoPvdox6otn
 M0NrMVL9s86YBPSo/tMpw==
X-Received: by 2002:a17:90b:2c87:b0:398:990e:1587 with SMTP id
 98e67ed59e1d1-39b26191cf2mr1717398a91.9.1788468639056; 
 Thu, 03 Sep 2026 13:50:39 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3339a534152sm1279679eec.10.2026.09.03.13.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 13:50:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/2] qom: pass TargetInfo to is_available
Date: Fri,  4 Sep 2026 04:50:17 +0800
Message-ID: <20260903205018.975-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260903205018.975-1-luoyonggang@gmail.com>
References: <20260903205018.975-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

- Change TypeInfo.is_available to take const TargetInfo *.
- Pass target_info() from type_register_internal().
- Add target_is_riscv64() and target_is_aarch64() so TypeInfo can use
  them as is_available callbacks without wrappers.
- Keep target_riscv64() and target_aarch64() as wrappers around the
  current TargetInfo.
- Point existing ARM machine is_available callbacks at
  target_is_aarch64().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/aspeed_ast27x0-fc.c  |  2 +-
 hw/arm/aspeed_ast27x0_evb.c |  4 ++--
 hw/arm/raspi.c              |  4 ++--
 hw/arm/raspi4b.c            |  2 +-
 include/qemu/target-info.h  | 18 ++++++++++++++++++
 include/qom/object.h        |  8 +++++---
 qom/object.c                |  2 +-
 target-info.c               | 14 ++++++++++++--
 8 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 73362b60d2a..8a7c6a116ac 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -234,7 +234,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     },
 };
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 460c9ff0d2e..02a8cff1d9d 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -75,13 +75,13 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-        .is_available  = target_aarch64,
+        .is_available  = target_is_aarch64,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
-        .is_available  = target_aarch64,
+        .is_available  = target_is_aarch64,
     }
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fadbacb2534..22b06c6ca22 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -403,12 +403,12 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 7d3eed96304..b47081200e1 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -125,7 +125,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
-    .is_available   = target_aarch64,
+    .is_available   = target_is_aarch64,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index b23e5bc5865..5d8cd3439a3 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,8 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+typedef struct TargetInfo TargetInfo;
+
 /**
  * target_name:
  *
@@ -56,6 +58,14 @@ bool target_base_arm(void);
  */
 bool target_arm(void);
 
+/**
+ * target_is_aarch64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is Aarch64.
+ */
+bool target_is_aarch64(const TargetInfo *ti);
+
 /**
  * target_aarch64:
  *
@@ -91,6 +101,14 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_is_riscv64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is riscv64.
+ */
+bool target_is_riscv64(const TargetInfo *ti);
+
 /**
  * target_riscv64:
  *
diff --git a/include/qom/object.h b/include/qom/object.h
index 49956388098..08d47c632a0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -487,8 +487,10 @@ struct Object
  * @class_data: Data to pass to the @class_init,
  *   @class_base_init. This can be useful when building dynamic
  *   classes.
- * @is_available: callback invoked at registration time, to dynamically check if
- *   this type should be available or not.
+ * @is_available: Optional callback. After target_info_select(), QOM
+ *   calls it at registration with target_info() and skips the type if
+ *   it returns false. Callers may also invoke it with a chosen
+ *   TargetInfo.
  * @interfaces: The list of interfaces associated with this type.  This
  *   should point to a static array that's terminated with a zero filled
  *   element.
@@ -511,7 +513,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
-    bool (*is_available)(void);
+    bool (*is_available)(const TargetInfo *ti);
     const InterfaceInfo *interfaces;
 };
 
diff --git a/qom/object.c b/qom/object.c
index c5a1bd74a38..5d959743169 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -176,7 +176,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
-    if (info->is_available && !info->is_available()) {
+    if (info->is_available && !info->is_available(target_info())) {
         return NULL;
     }
 
diff --git a/target-info.c b/target-info.c
index 012b384036d..84effb50ca9 100644
--- a/target-info.c
+++ b/target-info.c
@@ -58,9 +58,14 @@ bool target_arm(void)
     return target_arch() == SYS_EMU_TARGET_ARM;
 }
 
+bool target_is_aarch64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_AARCH64;
+}
+
 bool target_aarch64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_AARCH64;
+    return target_is_aarch64(target_info());
 }
 
 bool target_base_ppc(void)
@@ -89,7 +94,12 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_is_riscv64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_RISCV64;
+}
+
 bool target_riscv64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_RISCV64;
+    return target_is_riscv64(target_info());
 }
-- 
2.52.0.windows.1


