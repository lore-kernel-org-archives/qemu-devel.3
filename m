Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE55CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6D-0001bY-W8; Thu, 28 Mar 2024 11:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps64-0001TQ-IN
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:21 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5z-00023o-VL
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:17 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c12c73ed8so1455202a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641314; x=1712246114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfLLKG41I2ogYG1kIbKxMmfGPQoeoLD1UnfKcWEnm1Y=;
 b=mvt5cp4szbiwSIAxlAz/tZh/2B2lO9Q85L4uA69QlgVmkp6HuoYfeNLmDtsAmkzIt6
 KHSbmUup4N9x3CR1ksLJiOIhkjdUQb58cPagpEqGR1iLMoBR9sij8qZYw0aZ4RuqOfTh
 9tcAvt2LmFmYu7iI00I9G1j5/oRJxp/OIjPSaqLdC7BDE2r4nFWdvNpT8mo6KiK3wzli
 fnNd5qz1ZGKx/Qp5k2Ed1mSSj4zINffAnk1MEzDdMp+IwwCowqIFYKCkSdET5Pnlhg8C
 ou1pPX0LWgqULPz//NrmW0D+dOcnaq1+gSrKIt58zp7g1XzuNHf/3QgentUjTKTHprAu
 10cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641314; x=1712246114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfLLKG41I2ogYG1kIbKxMmfGPQoeoLD1UnfKcWEnm1Y=;
 b=m5QmfiSkYruv3p0yqgYr/Dl1UTfXgcRbgA7ZIWch3A+aD/VA8oX8dG+LutdS0narWE
 oFrVvv8VJKZUEgt1ctVCZm/XbQiGUFVhp2UOSOtf9mrzewZIkYIcVj4XBgpcAqO3glL8
 vwTeorPnrc/WEIrcgJeOaBqeaOpO9pMi5Kcdrfzp+j3dZhNp2qJMetY8kcZr3Jzmi6vd
 CGKDQu8IH1ktHOtHCga7s81CKsB0CC3vJsDiiMgvK7L9+yd9R2Zcoit3Uw0agQg8glg9
 asUA5Arb4w30ohOS3UzeF6s/1wsG3EgDZSQX/c75JgQO87q4eESHVZk6p2fbOZx2uVrK
 d5xA==
X-Gm-Message-State: AOJu0YzP9KPuPN6/0M7Op+hbEN5Ap95pBaH5Dp+C5zsSr1YHPM6DK9U+
 Dbe3QSXDCzSQ6ERp6EIXehLFwSc7lPflFVdeUqxWMSied7M+8CPekUgRdBs1yAYArQrXIFw0y0d
 N
X-Google-Smtp-Source: AGHT+IHgYPcqLucwrXXanAHQ1HQbxbpMZQm6yL1cnX0JqCYBkEci+AP5aBFgq++VGYS+wx15kRnpQw==
X-Received: by 2002:a50:ccd1:0:b0:56a:e8e4:9aef with SMTP id
 b17-20020a50ccd1000000b0056ae8e49aefmr2604908edj.7.1711641314036; 
 Thu, 28 Mar 2024 08:55:14 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 ig3-20020a056402458300b0056c0a668316sm970627edb.3.2024.03.28.08.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 05/29] hw/i386/pc: Remove
 PCMachineClass::pci_enabled field
Date: Thu, 28 Mar 2024 16:54:13 +0100
Message-ID: <20240328155439.58719-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

All TYPE_PC_PCI_MACHINE-based machines have pci_enabled
set to %true. By checking a TYPE_PC_MACHINE inherits the
TYPE_PC_PCI_MACHINE base class, we don't need this field
anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/pc.c         | 3 +--
 hw/i386/pc_piix.c    | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 1a4a61148a..0b23e5ec7b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -87,7 +87,6 @@ typedef struct PCMachineClass {
     X86MachineClass parent_class;
 
     /* Device configuration: */
-    bool pci_enabled;
     const char *default_south_bridge;
 
     /* Compat options: */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index eafd521489..a16bb1554c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1740,7 +1740,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
@@ -1830,7 +1829,7 @@ static void pc_pci_machine_class_init(ObjectClass *oc, void *data)
 
 bool pc_machine_is_pci_enabled(PCMachineState *pcms)
 {
-    return PC_MACHINE_GET_CLASS(pcms)->pci_enabled;
+    return !!object_dynamic_cast(OBJECT(pcms), TYPE_PC_PCI_MACHINE);
 }
 
 static const TypeInfo pc_machine_types[] = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7ada452f91..776d02db73 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -813,7 +813,6 @@ static void isapc_machine_options(MachineClass *m)
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
     m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
     pcmc->has_acpi_build = false;
     pcmc->smbios_defaults = false;
     pcmc->gigabyte_align = false;
-- 
2.41.0


