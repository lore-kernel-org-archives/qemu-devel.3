Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DC5CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps8H-00019r-0F; Thu, 28 Mar 2024 11:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps8E-00011d-TP
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps8D-0002mw-A7
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a47385a4379so400471666b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641451; x=1712246251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhT6+kuDArhB7vl7wmlOYwb5F71/kFsimohZE69/WJ4=;
 b=wPfi4xDZ+OZFr0EK/9vhFd4a6Bhqsc0O6HVjX/5tm+KZQFDfb8HqSLFpGWpfcSiTGX
 eoQZQFMUonQ7Kpd6AAtKo4zHR9uJTIu0GpJXDKTmBvyX3+0Nx+qklnGkoQntyIJCEUbj
 1Wdb21INEXISlrRDVMC8Kxr7dvgqV2mr6/Op3SIF0sIs8SLo9Lp01Y92zkoYi7dSd/Li
 ptxzP7KyVmegtwYntW7/o8jvB2JTOt46TZ8A8qfOkGPuxAF/oxd+FwJKdt0M0l28MWpq
 ldmXtv/0QRociJA7vO+gnBaq9l86GD+95aXa6KceEA2CrxsVIh5lIYzNNlhRNhxsPSPc
 zIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641451; x=1712246251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OhT6+kuDArhB7vl7wmlOYwb5F71/kFsimohZE69/WJ4=;
 b=lpNbOPh9/LQB++w3aVUA9aF2wIB9ybXfcj8ItCiPvK/rWY61gPRnan6R/BAPhx6lKJ
 3hq76PAoQIGSXkwJQhbDjEWTozV5HAp51X3AlsFI9I++UTVVbWDWN2o55JhKFF/fvJIw
 8BBYbslXA7Wl8aYwoCv9KiupHdrLQn/b8zYaRWhuor+uyeZcTTfpgt4bEv8A3GFxHxqN
 g+1IeNGQJaRm446PPifLNh7E/Xr+zyUQnzdgbpclvg4FTz2SkObQdwFgXeyIb0ft7xtb
 VobCNZSPWGTHjC7S3Nolk+/bC+mZ0xmMl6UB4i64RcZfSt5OFlxHjAwNOACx/yO5KWGl
 YKbg==
X-Gm-Message-State: AOJu0YzBsZpiKngVj3I9Iy7SGEb4iU4E1bUc2a3KZ2YaTa6XL6YdplNf
 +wRcjRrCxrS389L6jiAjkxv0R/uRx3BLwKiWM6yn1/ojZEAzhN20qOBcQzIwNhBBwRWMOkmy5a4
 u
X-Google-Smtp-Source: AGHT+IE5iPw2wKGziuJIAfhXkqj1URHuVnsVTHRuhgnnHINXGtkc2NpEDzBwrK/9AluQ+8R3bvD5jA==
X-Received: by 2002:a17:906:48d7:b0:a45:ab98:aec with SMTP id
 d23-20020a17090648d700b00a45ab980aecmr2166613ejt.10.1711641451420; 
 Thu, 28 Mar 2024 08:57:31 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 o19-20020a17090637d300b00a46cc48ab07sm894776ejc.221.2024.03.28.08.57.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:31 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 27/29] hw/i386/pc: Call
 fw_cfg_build_smbios_legacy() in pc_machine_done()
Date: Thu, 28 Mar 2024 16:54:35 +0100
Message-ID: <20240328155439.58719-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Keep fw_cfg_build_smbios() for PCI-based machines, call
fw_cfg_build_smbios_legacy() directly from pc_machine_done().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg.c | 10 ----------
 hw/i386/pc.c     | 12 +++++++++++-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index be37e28f46..92e058446f 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -49,11 +49,6 @@ const char *fw_cfg_arch_key_name(uint16_t key)
 }
 
 #ifdef CONFIG_SMBIOS
-static bool smbios_legacy_mode(PCMachineState *pcms)
-{
-    return !pc_machine_is_pci_enabled(pcms);
-}
-
 void fw_cfg_build_smbios_legacy(PCMachineState *pcms, FWCfgState *fw_cfg)
 {
     uint8_t *smbios_tables;
@@ -81,11 +76,6 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
-    if (smbios_legacy_mode(pcms)) {
-        fw_cfg_build_smbios_legacy(pcms, fw_cfg);
-        return;
-    }
-
     /* These values are guest ABI, do not change */
     smbios_set_defaults("QEMU", mc->desc, mc->name);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7a758a2e84..7d06a088cf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -591,6 +591,11 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
     }
 }
 
+static bool smbios_legacy_mode(PCMachineState *pcms)
+{
+    return !pc_machine_is_pci_enabled(pcms);
+}
+
 static
 void pc_machine_done(Notifier *notifier, void *data)
 {
@@ -602,7 +607,12 @@ void pc_machine_done(Notifier *notifier, void *data)
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
     if (x86ms->fw_cfg) {
-        fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_type);
+        if (smbios_legacy_mode(pcms)) {
+            fw_cfg_build_smbios_legacy(pcms, x86ms->fw_cfg);
+        } else {
+            fw_cfg_build_smbios(pcms, x86ms->fw_cfg,
+                                pcms->smbios_entry_point_type);
+        }
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
-- 
2.41.0


