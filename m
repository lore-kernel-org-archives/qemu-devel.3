Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EFECD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6R-0002Xx-Fc; Thu, 28 Mar 2024 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6Q-0002RP-I3
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6O-0002GM-VP
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso1750088a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641339; x=1712246139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckSqN94Ak/AVFv4C8DP1wel6lx7UDcBC5ZVn+IWQ+zI=;
 b=qUWjQLo8W+8Iepc3M0ub/a013BFffUS/zAYZt/PbK1FR3GskA+3/XlDJEa2Ahy1J16
 2KchJ4Bug1C/uS/J2dIXrnmm0um6EzmMtU32hJpGsXezEWVDP4JioyMTsN+Quceqt27E
 A0IlTGfIAGsBMu/u+Rq2hQxYk5vhEeTUcmM+gSFJ47FnZThZAkHh7TQbwIwKqS52Z87l
 KEJm5jo7eX0kloZPs9QU5Y39+ZUBfz/D11pk2G7y9zzkx+8quq4F8F3MuRqpDZSmWOZ8
 KWp6bMvnOyUvsFBAYN7YAazF02CwDFGevdwY3vjcvu8nj2gHtTq2lYhPcUuAmVNN+bje
 nTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641339; x=1712246139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckSqN94Ak/AVFv4C8DP1wel6lx7UDcBC5ZVn+IWQ+zI=;
 b=VQnwhSiazY66jk2ccAAndoVg55fkmKM7UIAfNjkAVFXx9i0yMj3SiQ6h100VDBX23W
 L9BnhGqmHRjthPXk+lDcP/QYUbINtwkqk+AKzD7e1uDrDxOuDtfm0YzmmF/p9uvFCj9V
 4BtZdGNd7NltuhB/RxjaM/picDgiYUKWY9XtgISYXyeIpscPiQlRCqUVmFLKQKWLAQae
 iCVz73uBGlhkW1LSCju436FzYwFrcWwcroigZxQ+28rfIFcPUD+hhQN1J9K7rXaIVwaN
 0Gps2lp2F+X6+vhXRfFicC7481LbTuLZq4L9FjgiNAi9zgFdaIhkrcreMrkJ7W+TxpMx
 x7Nw==
X-Gm-Message-State: AOJu0YzXJ7uTfb9ExHbFCH8d77Om1bGvjn3+4Dlgfh2lZTVpTqaZACrK
 E9+7T9HsjVeJmOdLaxmsVUFV+qIYqKfxtFkohT8kOqTZ0Db83kzdpVdear/nkRkkVMzcaEOa4VF
 s
X-Google-Smtp-Source: AGHT+IGwP6p/08zu3mCMRpeAkzfHcigXM/JR3t5dmiNwQCcEIbh+pOnBScYA897DxMkDTYP+GJc42Q==
X-Received: by 2002:a17:906:494f:b0:a47:4fed:514a with SMTP id
 f15-20020a170906494f00b00a474fed514amr1839620ejt.52.1711641339277; 
 Thu, 28 Mar 2024 08:55:39 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 j15-20020a170906254f00b00a473362062fsm894249ejb.220.2024.03.28.08.55.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:38 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 09/29] hw/i386/pc: Pass PCMachineState argument to
 acpi_setup()
Date: Thu, 28 Mar 2024 16:54:17 +0100
Message-ID: <20240328155439.58719-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

acpi_setup() caller knows about the machine state, so pass
it as argument to avoid a qdev_get_machine() call.

We already resolved X86_MACHINE(pcms) as 'x86ms' so use the
latter.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/acpi-build.h | 3 ++-
 hw/i386/acpi-build.c | 5 ++---
 hw/i386/pc.c         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 0dce155c8c..31de5bddbd 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -2,6 +2,7 @@
 #ifndef HW_I386_ACPI_BUILD_H
 #define HW_I386_ACPI_BUILD_H
 #include "hw/acpi/acpi-defs.h"
+#include "hw/i386/pc.h"
 
 extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
@@ -9,7 +10,7 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 #define ACPI_PCIHP_SEJ_BASE 0x8
 #define ACPI_PCIHP_BNMR_BASE 0x10
 
-void acpi_setup(void);
+void acpi_setup(PCMachineState *pcms);
 Object *acpi_get_i386_pci_host(void);
 
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6e8e32e5d2..e702d5e9d2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2749,9 +2749,8 @@ static const VMStateDescription vmstate_acpi_build = {
     },
 };
 
-void acpi_setup(void)
+void acpi_setup(PCMachineState *pcms)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(pcms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
@@ -2771,7 +2770,7 @@ void acpi_setup(void)
         return;
     }
 
-    if (!x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
+    if (!x86_machine_is_acpi_enabled(x86ms)) {
         ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
         return;
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6d87d1d4c2..dfc0247bb6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -601,7 +601,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
-    acpi_setup();
+    acpi_setup(pcms);
     if (x86ms->fw_cfg) {
         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_type);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
-- 
2.41.0


