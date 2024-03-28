Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D947CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps8A-0000fO-Mg; Thu, 28 Mar 2024 11:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps89-0000TB-3U
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:29 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps87-0002l0-8d
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:28 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a466fc8fcccso150255666b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641445; x=1712246245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JGjTd1WToEahvAfY8NVbIAQ8SXrGvIMBj7UnII/d+c=;
 b=tlzTTWfdU3qU6qSN81Ar6w+u/pQDI1vqH0ikHLsAxcPhGNj8J9NQRlEDHc2ERjal7l
 R5QBfGLIxZcSitdvJFhhR0KOnDNdZB8ROLzT3/vmjk/vkGmV5wiFdXbS7Br6pQ4FWvFJ
 Qc+z90m5v3Uv+n8Hn2yn6e9C/P8+sKBvxhgQZMsH14JROgo0vfs46hWsJVxAL7+Np2hk
 cKwQ8W89d7F4+CpYEXTSjvz1kXPa+aUTl07NpwcgeSfctCLIIemxG/uY/jUYb2MuIjSf
 GasRWq+t0YcOJw+Vu962XS1v+iWnpwnTy/8fBMWLXe6OykCPxqioVhVwYpHRnI0xameS
 TKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641445; x=1712246245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JGjTd1WToEahvAfY8NVbIAQ8SXrGvIMBj7UnII/d+c=;
 b=RF+OvI4rZsnGl6Y8EYB1bQG+DHdKcNwr6uFtMTT4tHVfsbs5yp1Jxdxn718qL3O4xl
 kp33VfvNYJTlMlp32dAkaGx/piWdxJ24pP1HGcw5ThokzPVMQqotDr+8JEDx1tuAC+OW
 uIf33bFBwaIbx5xrmqYl6F3K8oGUnqy/dy3P+t5sl97Hi+WRD0HMtav16fQMF8rvubjK
 eS7YvZJfT3Ziwp/H8LQ91tIGDe1gitTGIrgp7eRl8pc6kScSmVIsx1b887x6vNLIc3OI
 pDTuMzMwjGVnVlxH4fSXMXMoX5rjBQnoFpMxEvSN+ILWI8RBiX+XQg281iMop58LgVhK
 9eRw==
X-Gm-Message-State: AOJu0Ywn59rLMmfPA0yP93jqMdA8aTyZYbB2tkuk0Lz4J2pwu5Vq/8rP
 schrc3k4hOrV5xFCfre+rGX3i3f9CGsp9QHXnXUmFtJMivDuhHxZO24iTlTQmckdgOfwl0iTpEG
 9
X-Google-Smtp-Source: AGHT+IEke0w2rGaQ9eaNpJe9RsSUrMNnkosA5ZqUCdCrrEsx8n7A8+12nHMQifWFPzkMKHDz/PJUtg==
X-Received: by 2002:a17:907:7d89:b0:a47:5265:9aac with SMTP id
 oz9-20020a1709077d8900b00a4752659aacmr2577836ejc.55.1711641445324; 
 Thu, 28 Mar 2024 08:57:25 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 k13-20020a1709067acd00b00a47df55cf5esm914850ejo.13.2024.03.28.08.57.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:24 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 26/29] hw/i386/fw_cfg: Factor
 fw_cfg_build_smbios_legacy() out
Date: Thu, 28 Mar 2024 16:54:34 +0100
Message-ID: <20240328155439.58719-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Factor fw_cfg_build_smbios_legacy() out of
fw_cfg_build_smbios().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/fw_cfg.h             |  1 +
 hw/i386/fw_cfg-smbios-stub.c |  4 ++++
 hw/i386/fw_cfg.c             | 33 ++++++++++++++++++++++-----------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 7a426119f8..25ce86ec1b 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -24,6 +24,7 @@
 FWCfgState *fw_cfg_arch_create(MachineState *ms,
                                uint16_t boot_cpus,
                                uint16_t apic_id_limit);
+void fw_cfg_build_smbios_legacy(PCMachineState *pcms, FWCfgState *fw_cfg);
 void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
diff --git a/hw/i386/fw_cfg-smbios-stub.c b/hw/i386/fw_cfg-smbios-stub.c
index 37dbfdee7c..da00ffc9ae 100644
--- a/hw/i386/fw_cfg-smbios-stub.c
+++ b/hw/i386/fw_cfg-smbios-stub.c
@@ -13,3 +13,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type)
 {
 }
+
+void fw_cfg_build_smbios_legacy(PCMachineState *pcms, FWCfgState *fw_cfg)
+{
+}
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index df05fe060c..be37e28f46 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -54,6 +54,22 @@ static bool smbios_legacy_mode(PCMachineState *pcms)
     return !pc_machine_is_pci_enabled(pcms);
 }
 
+void fw_cfg_build_smbios_legacy(PCMachineState *pcms, FWCfgState *fw_cfg)
+{
+    uint8_t *smbios_tables;
+    size_t smbios_tables_len;
+    MachineState *ms = MACHINE(pcms);
+    X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
+
+    /* tell smbios about cpuid version and features */
+    smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
+
+    smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
+                                            &error_fatal);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
+                     smbios_tables, smbios_tables_len);
+}
+
 void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type)
 {
@@ -65,22 +81,17 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
-    if (!smbios_legacy_mode(pcms)) {
-        /* These values are guest ABI, do not change */
-        smbios_set_defaults("QEMU", mc->desc, mc->name);
+    if (smbios_legacy_mode(pcms)) {
+        fw_cfg_build_smbios_legacy(pcms, fw_cfg);
+        return;
     }
 
+    /* These values are guest ABI, do not change */
+    smbios_set_defaults("QEMU", mc->desc, mc->name);
+
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
-    if (smbios_legacy_mode(pcms)) {
-        smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
-                                                &error_fatal);
-        fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
-                         smbios_tables, smbios_tables_len);
-        return;
-    }
-
     /* build the array of physical mem area from e820 table */
     mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());
     for (i = 0, array_count = 0; i < e820_get_num_entries(); i++) {
-- 
2.41.0


