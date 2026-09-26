Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEA6C98332
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 11:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAQHd-0008O7-QK; Sat, 26 Sep 2026 07:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAQHQ-0008HF-1d
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 07:09:20 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAQHN-0002o7-H4
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 07:09:19 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-3381a6a05c9so1062110eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790420956; x=1791025756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lJKwdQEoHe4APx9lrycp1Fbb71T3Fetg8ApXItJlKJs=;
 b=Uw6XTWKXZlN4E0KYDhNsmvpEMmEhGhKtVvHeCRX/gitimpWKrfzcwHY3jkk6VbCaJb
 22eOceqNt1U+j3bOetkYxg3JAUk62z+hqIcxoRajL6T7P4SgJwiZDq69i9Ur4cSs4IQT
 tbQIDrvVGlVNAZnvyTWOvvOfyJDAn4OQgQgjLQdPFuGzOTdgDxyzvgpt+phtK1EunseA
 qIFcs82oYYw0Xf+cqgugIYuPXLO22fj/RfMIxlOQ/P0EcqKDzLAhHFK0XfSSeTzBYGg7
 nrRFXYVmmZdk3sc2frUs6f7vNac8ogqaK67qqTq6TnObKeqTYQZBhWiDuv72eEEksZ1+
 CRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790420956; x=1791025756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lJKwdQEoHe4APx9lrycp1Fbb71T3Fetg8ApXItJlKJs=;
 b=ovRpWYIZU7IQoqq3pDn94YF4l8UJmrdXDPe5QEZ9cujCDTGcBMSygWJOBDOaHWp1Rk
 EmPJ9dI4bv559lMrgC9wSqE6TyrZJL08j9TFYqFxg2T6WAC2BKd/YGa5SCze0htlanzD
 NvAdRRfrFDJ8VbVVZjRltt/sijst2wZtuXMtyqdvKwV6rGSkSRn2vK/9MZ05uI9xLRD3
 mhEwfA1cAoRrb/YaXv/H3R7Fa2gO+fBaTESUxMeO8i79gW2SC8Xi2N+43R/iVMQckC3c
 hThXafQJNUEGdZQEphwDEQRfTdR9CgFUU9PJmQCUU3Gvf0X5bbeHxPt2IHsRvsVQhDOP
 UUBA==
X-Gm-Message-State: AFuF++mLtDbMGrGxoluwohPpG0XUVrSLSDxiRWzaEDuq/FK1LtbC2pQa
 Fg6tahJTg1K//YoViTYMeF5d6pVnSRQn+OPCPFxWg6qysZSCvj9QhHb0AxyGZppWDAc=
X-Gm-Gg: AYBFou2K2y6AfVWm5RGv36M6T8jtnkU8XA2l+e21dm3SKMqGf1EsILxgNJhSJgyk228
 NY9YCyA4sB/c+HIRb5e1I+x+ice9QJxtBGiYmO6xkyWsHuXVD38lEP5liOxA1RN26TyFj1vaBy6
 bz4vWqTTW6mJdKaDkXTUHGYVHOlk9P48+NrA6H4sEAl9kK+rFJ8LNVuQOJGmdOkNMhIqZUgHe1e
 dEl77HjWfQ2RBp8bW4gOOpdNxSvnmjXu3e0EQUqXmPckS6qNKwQniMZ6kBCdnOxPUPGCLLJi9az
 A5knQUNtsD0awepNh8HZrPxJeoXg3ZDTdWSG2oMAJ4XiOELt/sR2EVdLoUCNewjsSxO9P6s+rc8
 lGL40Xrr2NHiQtgF3nS5PjHmAwVU3KWwPyoCqn2xwv1bDtOrvH9dMeGIC1wfjNSGimJea/17Jo4
 O+n8+shGBTdbhbtvgr9xUuwNQhyABD++fLcaZ+iexaS9fpR7oCWI+EE7g3UYctmEYfyZWfrUtTY
 YYNYueRhLkJm5k72aQzCMVk79MxTtM=
X-Received: by 2002:a05:7022:61f:b0:13f:c741:a4f8 with SMTP id
 a92af1059eb24-146cec4be36mr4055716c88.21.1790420955084; 
 Sat, 26 Sep 2026 04:09:15 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-145a7318afcsm11414045c88.0.2026.09.26.04.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 04:09:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <17746591750@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>, Ani Sinha <anisinha@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 8/9] hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
Date: Sat, 26 Sep 2026 19:08:16 +0800
Message-ID: <20260926110818.1912-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926110818.1912-1-luoyonggang@gmail.com>
References: <20260926110818.1912-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- virt_acpi_setup is the same C symbol used by ARM and RISC-V virt.
  Rename it now so a later combined binary does not need meson -D
  prefixes for LoongArch.
- Rename the file-local virt_is_acpi_enabled to
  loongarch_virt_is_acpi_enabled to match.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 6 +++---
 hw/loongarch/virt.c            | 2 +-
 include/hw/loongarch/virt.h    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 600ef60fc58..b9df9b3a127 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -674,7 +674,7 @@ static const VMStateDescription vmstate_acpi_build = {
     },
 };
 
-static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
+static bool loongarch_virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->acpi == ON_OFF_AUTO_OFF) {
         return false;
@@ -682,7 +682,7 @@ static bool virt_is_acpi_enabled(LoongArchVirtMachineState *lvms)
     return true;
 }
 
-void virt_acpi_setup(LoongArchVirtMachineState *lvms)
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -692,7 +692,7 @@ void virt_acpi_setup(LoongArchVirtMachineState *lvms)
         return;
     }
 
-    if (!virt_is_acpi_enabled(lvms)) {
+    if (!loongarch_virt_is_acpi_enabled(lvms)) {
         ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
         return;
     }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9c5371af9de..19fbf6db0d9 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -242,7 +242,7 @@ static void virt_done(Notifier *notifier, void *data)
     LoongArchVirtMachineState *lvms = container_of(notifier,
                                       LoongArchVirtMachineState, machine_done);
     virt_build_smbios(lvms);
-    virt_acpi_setup(lvms);
+    loongarch_virt_acpi_setup(lvms);
     virt_fdt_setup(lvms);
 }
 
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d39a9bbf5dd..72268466def 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -132,7 +132,7 @@ struct LoongArchVirtMachineState {
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
-void virt_acpi_setup(LoongArchVirtMachineState *lvms);
+void loongarch_virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
 static inline bool virt_has_dmsi(LoongArchVirtMachineState *lvms)
-- 
2.52.0.windows.1


