Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0183C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbHD-0003rZ-Vz; Tue, 18 Jun 2024 12:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbH4-0003gV-6q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:37 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbH0-0006mH-Ra
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:01:33 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6f253a06caso672301366b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726489; x=1719331289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKwfCk465sr7WgOHafBJgyo22SuG659wATLOZz6Tx48=;
 b=oEJUch4Dc/caW6XAjaleA1rEpatNBqm53C76Iw0TZQSduwVuzdyc6m6+FbwdzZ+lef
 Yw0qxKXpK1ePsD0olMUoTvKNBw9AA6GEVccXGC3G6LqwqhukLfDGda6gPTW8n99L8wUj
 pDAoQeLaaXja8jlLKf1XrGUB66poVhJrZp2S6bUspJhbGZPWIMYCbjwtYLN6GWrApZ5+
 zlYN/Nk6+LNHnavDFRsYJmk+upuqF+Rw6LUdpEkA5dVtz9Ux3Z9OtXnC2UuJtgnrnYIW
 Z05o6y6HB0mKc3X5n5Fi9+/sM9ExnwJNdvd5O+jDECJyGS1uSXfYIGVLQUdV/vxhGufO
 ue4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726489; x=1719331289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKwfCk465sr7WgOHafBJgyo22SuG659wATLOZz6Tx48=;
 b=mPOQNP59bPVEA6iicOWp7VrDf2cCdrQmz6LYzdqcekz12foPm1cZz16XXI1kvDz9ts
 9I+rarTKICvJf8RhvFHqAJxdc+eEnFc1gzY9wpL71j2bPZp1XoSit7I1mf4ZWJ/JDoDQ
 NWjkKEfo0jFnVOFjavUa0BFAUOb58V5Y4y9FzxsxHhVBEwXjHbXPKPY+S3ZJLLheqSJY
 WXYhNCsX4hlfdpD8fCAcY5XNAtjuJiMMY4XPf7auIWDBA/5TdD3qJWLFPTNj92OoIdg2
 O6FE8elQdnXm4H1EN107l40qCYrm1aKYGhPyDgmk8huFmbFxsaY7GRghGQtmuP52vgff
 2eyg==
X-Gm-Message-State: AOJu0Yw0c3z8k9glS9Ab1J4lH7hMLrLGhGfv9IkHlgAYDQYsz+uhRWjo
 ef5FWOztiot7qFMJeZpGPq+FzRaADV1hwcZW3y+i8ml+lswSIHBRyQcRsuhEFLqQFqdk4gFqEY1
 T
X-Google-Smtp-Source: AGHT+IGQQiYMDvRO71dvEcFEJctaLix1l9htSjRP2+coMaY+M/7vaQi9rR7exoCUmatmhjG38T3VTg==
X-Received: by 2002:a17:906:fb8f:b0:a6f:49bc:e858 with SMTP id
 a640c23a62f3a-a6f60dc5110mr1012212966b.53.1718726489107; 
 Tue, 18 Jun 2024 09:01:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f57552633sm625781966b.191.2024.06.18.09.01.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:01:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 08/76] hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
Date: Tue, 18 Jun 2024 17:59:30 +0200
Message-ID: <20240618160039.36108-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The pc-i440fx-2.1 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-9-philmd@linaro.org>
---
 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    |  7 -------
 hw/i386/pc_piix.c               | 23 -----------------------
 5 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e12eab1f72..e332eb46e9 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -212,7 +212,7 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
+``pc-i440fx-2.2`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f84bfaf2b6..347e04e50e 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -948,7 +948,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
+``pc-0.10`` up to ``pc-i440fx-2.1`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 434e531160..0d730318fe 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -314,9 +314,6 @@ extern const size_t pc_compat_2_3_len;
 extern GlobalProperty pc_compat_2_2[];
 extern const size_t pc_compat_2_2_len;
 
-extern GlobalProperty pc_compat_2_1[];
-extern const size_t pc_compat_2_1_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d0f2628d46..b0b8ecd64d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -313,13 +313,6 @@ GlobalProperty pc_compat_2_2[] = {
 };
 const size_t pc_compat_2_2_len = G_N_ELEMENTS(pc_compat_2_2);
 
-GlobalProperty pc_compat_2_1[] = {
-    PC_CPU_MODEL_IDS("2.1.0")
-    { "coreduo" "-" TYPE_X86_CPU, "vmx", "on" },
-    { "core2duo" "-" TYPE_X86_CPU, "vmx", "on" },
-};
-const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a750a0e6ab..e0b421dd51 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -66,7 +66,6 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
-#include "kvm/kvm-cpu.h"
 #include "target/i386/cpu.h"
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
@@ -435,12 +434,6 @@ static void pc_compat_2_2_fn(MachineState *machine)
     pc_compat_2_3_fn(machine);
 }
 
-static void pc_compat_2_1_fn(MachineState *machine)
-{
-    pc_compat_2_2_fn(machine);
-    x86_cpu_change_kvm_default("svm", NULL);
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -866,22 +859,6 @@ static void pc_i440fx_2_2_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
                       pc_i440fx_2_2_machine_options);
 
-static void pc_i440fx_2_1_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_2_2_machine_options(m);
-    m->hw_version = "2.1.0";
-    m->default_display = NULL;
-    compat_props_add(m->compat_props, hw_compat_2_1, hw_compat_2_1_len);
-    compat_props_add(m->compat_props, pc_compat_2_1, pc_compat_2_1_len);
-    pcmc->smbios_uuid_encoded = false;
-    pcmc->enforce_aligned_dimm = false;
-}
-
-DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
-                      pc_i440fx_2_1_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


