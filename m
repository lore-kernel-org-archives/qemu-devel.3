Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A459DCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6Y-0002yP-Cl; Thu, 28 Mar 2024 11:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6W-0002wX-RF
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6V-0002H1-8I
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:48 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56c2b4850d2so1407111a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641345; x=1712246145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtUfcj3aTDn2mvaMR/QsDVngwC1CAz/OBQXAMI7WNPQ=;
 b=FRsHW38GuPBKsFou3iXDlS5O3B5KwEUBWDQYdStUG6bXGjWeFjzBwpaPSyrJ7p6TLE
 SLywyxjdnH/nBL1ii00peLLRjQLBljD1F/+cf/+GjZp3QsVtM5Wpe1MvnXUSVfrBxsSr
 kIaMSsNXBnuV3O0Ay1nER6CEecDHcn/IEtNTIknLlBVJ4C8b/ZvYKeM6RMSevtOe0Umz
 qJ9iqqmwUoKbBkuSHAEOKAkjvdLZxNrS9dRfo01BMYisxQcuVCYaPD/HTDoQGcrKtp0I
 qTuZpfBvzeqbWev8BMZCI+aJ16LpDFLndOBCr65I1AflXpNQ8awlcAxEGx39ihUC7w15
 kcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641345; x=1712246145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtUfcj3aTDn2mvaMR/QsDVngwC1CAz/OBQXAMI7WNPQ=;
 b=poE5GnXyJWP4gtDZVc6ohAo8hmOYMxWMQW7TjOeRWLnfWnd2PDUyzWtofLB6pDDHME
 6siD3WkHBLsoEQF3FZfAwLqFjtwGajnb4UTb1MROKykh5KdOzv6OcWuMn9arN2Vs64ep
 M9VZ7RliOEJHQA7/RLIsRlXVo3bYrL4UW+eGDcwUnquNAaf7rCNFrl8gDorYGwKaTy/L
 mm+P8wD1meAFzryAndC8EQyyRSzSo7RoFP934hDymEBkSOM4CbN310xiQO8YSUvJWI4Q
 if9e2C8m0qpb3/aLI9Kka9X/y2yrohDYCA6lRs+DkWmTv9QYqkVn4HfiyJP3ATOt8mKJ
 bjyw==
X-Gm-Message-State: AOJu0YwkufLJkq5ht31T6MgcxloZHMJaA59v5zYuovMbhcR9+GqOKd6Y
 VewONXSoGXJcFDIrG7yGXTRoOiQyzUfOleKQiF7s69A6VesajCP2ZQlsxRblRSCerryaz1txroH
 l
X-Google-Smtp-Source: AGHT+IE4H2j7DvpBr0ZgGTO3mYeCN1DwhGLVSa7xknb/dNXvpG290SVF6AQSzPcOp/lNCIhUZoP8Cw==
X-Received: by 2002:a17:906:4697:b0:a4e:ebd:254a with SMTP id
 a23-20020a170906469700b00a4e0ebd254amr2129554ejr.9.1711641345640; 
 Thu, 28 Mar 2024 08:55:45 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 r18-20020a170906c29200b00a4e2a1146f8sm298044ejz.48.2024.03.28.08.55.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:45 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 10/29] hw/i386/pc: Remove
 PCMachineClass::has_acpi_build field
Date: Thu, 28 Mar 2024 16:54:18 +0100
Message-ID: <20240328155439.58719-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

PCMachineClass::has_acpi_build is always %true for PCI
based machines. Remove it, setting the 'acpi_build_enabled'
field once in pc_pci_machine_initfn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 6 +++---
 hw/i386/pc_piix.c    | 1 -
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a97493d29d..dd5ee448ef 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -95,9 +95,6 @@ typedef struct PCMachineClass {
     /* Default CPU model version.  See x86_cpu_set_default_version(). */
     int default_cpu_version;
 
-    /* ACPI compat: */
-    bool has_acpi_build;
-
     /* SMBIOS compat: */
     bool smbios_defaults;
     bool smbios_legacy_mode;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index dfc0247bb6..f0dc04e2fc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1664,8 +1664,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
     pcms->south_bridge = pcmc->default_south_bridge;
 
-    /* acpi build is enabled by default if machine supports it */
-    pcms->acpi_build_enabled = pcmc->has_acpi_build;
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->i8042_enabled = true;
@@ -1688,6 +1686,9 @@ static void pc_machine_initfn(Object *obj)
 static void pc_pci_machine_initfn(Object *obj)
 {
     PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->acpi_build_enabled = true;
 
     cxl_machine_init(obj, &ppms->cxl_devices_state);
 
@@ -1745,7 +1746,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    pcmc->has_acpi_build = true;
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c42dd46e59..7aa2598e10 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -816,7 +816,6 @@ static void isapc_machine_options(MachineClass *m)
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
     m->rom_file_has_mr = false;
-    pcmc->has_acpi_build = false;
     pcmc->smbios_defaults = false;
     pcmc->gigabyte_align = false;
     pcmc->smbios_legacy_mode = true;
-- 
2.41.0


