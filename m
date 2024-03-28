Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B96FCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7y-0007Rb-Dg; Thu, 28 Mar 2024 11:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7x-0007MZ-2h
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:17 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7v-0002iW-3e
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:16 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d6fd3cfaceso15191651fa.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641433; x=1712246233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jd0AyxLTXxReg2ZsCl/5FvAkstq2JBvxx9RU6rO30AU=;
 b=YaFF0AYhEO9xz1ReqBDLs/SzLrEX6uR7FIH2m/OL6ZGlYI5GdQxGPeUMT6tfWs6gej
 hHW2nDMWDpnvFLs8Qn/LIcusd5DxibV+KA4lhjxoWpFmPNv5eq0DgBNqkiAbbVhlFFq5
 OF2JFsiO+GG68sf5JiMmSDzJobveb3TOBdAmt5DXv7u8r6AZ3u59DBLBCM/go8SCGQ1M
 oeQlGbaevzdjmKvIATxdkiv7gvtOFrwVu2fw6HO46fLfYh67PdDCkhkzHzWoZaQ/It6N
 N/67bZNxx/MJ6rI3OYD1o07HDnjYQPyBlrjDJbBwa/TsDSrjOYcOr/0IgbE8EMQKut+v
 4JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641433; x=1712246233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jd0AyxLTXxReg2ZsCl/5FvAkstq2JBvxx9RU6rO30AU=;
 b=xLWLgQK0iGzkt/OBuoVIc8TO1Cwmggnj4U2VjJkDN1nGZ4Y5WJS5TRbLjxXWAxH90D
 q7KX1UXL0LWGCCZU0MpeI7lbx4DAsOLLeyJWgr0AIYCr+9D66m3ZblIsRrMfYu9q1eyN
 ptWU8hFs9Y3jFsv3tmKC4lje2vvSTMYrfKPn5NyIeNo0c58MkPy2bbcrEm59RMlnzVJM
 sC7GDsIM7v/awgEqTwRxOIgz3Ms/e/EUYeXLOYVmcY90h7Aw4zXXB4D5MWulZD0TSuqN
 j0O2byNU5BkX5aAhaYZzvy8ZrRjSRuiOia+jfIwS4gzi5aw2zO7T6eMug6NM+rLtlPF8
 Xxbw==
X-Gm-Message-State: AOJu0YzaPGnqShzTepMluOYUoy3GChIkJwYJ8Ze78mA7/ElVI0FUpCBB
 1FDzwy1T0yAy3fgDDq1seQzTaDcjmRUZhvB6lkOHuwd50oXqD16WwLtvhx4vCU8Z7t6lZRfjCkD
 C
X-Google-Smtp-Source: AGHT+IFp7sCXvlR7d3Mf8BzIjVT/t0rldZPHgrIbP67RUd/bNvgi6xSgjnnhBTrJNCeF2G5tN//CLg==
X-Received: by 2002:a2e:a289:0:b0:2d3:5020:17e5 with SMTP id
 k9-20020a2ea289000000b002d3502017e5mr3152074lja.36.1711641432888; 
 Thu, 28 Mar 2024 08:57:12 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 lh23-20020a170906f8d700b00a46ab5aaffcsm898765ejb.178.2024.03.28.08.57.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:12 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 24/29] hw/i386/fw_cfg: Inline smbios_legacy_mode()
Date: Thu, 28 Mar 2024 16:54:32 +0100
Message-ID: <20240328155439.58719-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

All PCI-based machines have the smbios_legacy_mode
field set to %false. Simplify by using an inlined
helper checking whether the machine is PCI-based or
not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/fw_cfg.c     | 8 ++++++--
 hw/i386/pc_piix.c    | 2 --
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6a6a8df005..6510914803 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -86,7 +86,6 @@ typedef struct PCMachineClass {
     int default_cpu_version;
 
     /* SMBIOS compat: */
-    bool smbios_legacy_mode;
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index f60390ed56..ffa60a4a33 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -54,6 +54,11 @@ static bool smbios_defaults(PCMachineState *pcms)
     return pc_machine_is_pci_enabled(pcms);
 }
 
+static bool smbios_legacy_mode(PCMachineState *pcms)
+{
+    return !pc_machine_is_pci_enabled(pcms);
+}
+
 void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type)
 {
@@ -62,7 +67,6 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     struct smbios_phys_mem_area *mem_array;
     unsigned i, array_count;
     MachineState *ms = MACHINE(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
@@ -74,7 +78,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
-    if (pcmc->smbios_legacy_mode) {
+    if (smbios_legacy_mode(pcms)) {
         smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
                                                 &error_fatal);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 70dc8686f9..4f07476cfa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -823,12 +823,10 @@ DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
     m->rom_file_has_mr = false;
-    pcmc->smbios_legacy_mode = true;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-- 
2.41.0


