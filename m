Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA829CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7a-00050d-5G; Thu, 28 Mar 2024 11:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7F-0004Yw-QL
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:37 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7D-0002Tc-NN
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:33 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a46a7208eedso167670066b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641389; x=1712246189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yelmGOzPahdn50NTFTioUrFj9NGQyALSAi158EJljHU=;
 b=krvbD78ORnBdXZmJ3OmYQFXUSF7dNlymbl08eDUGLTjroCPPWdUAqYsv540u7Dd9hy
 S3zp5u2sAbn1rK6MxiEwGyfbx/4MLf1rPGKoO2QHs8VfTmNE1G33Q54DH5pcr08ViTX1
 NLrXAL3xlvddf0otKio5moqPtjXJ6eO+Pf8D9oee4cBZHRwvhkwSL2KGvLl1o3o8V+jr
 OrN/Nd4vnB62IMuGE+IlE/jNX1mhHSVOlz0f2wfmZc8OHSQUZt4sbOQgiCj0VwtuyOWu
 1xyUM3QgMO8ccL7saSfLVKdaIubAtgfBs7q4nC0U4Y0vmTDwL6itkG7gfjDPPHJ4LDsZ
 xmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641389; x=1712246189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yelmGOzPahdn50NTFTioUrFj9NGQyALSAi158EJljHU=;
 b=PDs3kENHk62nCRY+EWjBqGWtIgiR5QTqUd8lm1kx0s1kOFr0K/qVE3g7Jq8NPinEDq
 Mb5t3UlUR+L12W+xMcMy2J5PZlOhOwZKHS1rz+0ycxdrYShO4XpUxOWRk+PbYFwroA00
 yxIOeV+wFlhCaU5U7o0Qy3roueZ6qTvaK+3CPzNtdS0J1+QyI2v3Gr0BnaFS7OctJV+u
 YOoeo54OcEOS8oIOsi4aqncE5XiuD0PVSBhJ6UWiLqPG8YOou8b8PJmabMS6pK9BHYZC
 9eY0s6/dmu1HhH3n7DQyJrYObxMlDbxQkp+0DW/5N9cFAhl04oxBD68y3R9maqzRAEC1
 myPA==
X-Gm-Message-State: AOJu0YwKCyFoU0y7miYmWZVlxS0dlhMuWtd8yWGf4oPbH5HOM6+Lf/Z2
 TU26R+5VDJOJqD1qjEKlUw1V8fH7f+YEACY2Y59OePphVQxTq8ay9gMNya8I2/3aJewv+crRbEJ
 i
X-Google-Smtp-Source: AGHT+IGcQH5U/UKgHXGMsAIRXVS3RWDUx0CNeskq1nCdFHfYMz7G0o34lBWrByXcqIlMAc9p2yI9yQ==
X-Received: by 2002:a17:906:e24e:b0:a4d:fc83:70e1 with SMTP id
 gq14-20020a170906e24e00b00a4dfc8370e1mr2038052ejb.56.1711641389600; 
 Thu, 28 Mar 2024 08:56:29 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170906170c00b00a47464a6ee4sm907178eje.173.2024.03.28.08.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:29 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 17/29] hw/i386/pc: Inline gigabyte_align()
Date: Thu, 28 Mar 2024 16:54:25 +0100
Message-ID: <20240328155439.58719-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

All PCI-based machines have the gigabyte_align field
set to %true. Simplify by using an inlined helper
checking whether the machine is PCI-based or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  9 ---------
 hw/i386/pc.c         |  1 -
 hw/i386/pc_piix.c    | 16 +++++++++++++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2db2aa03d3..758dd5f29b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -76,14 +76,6 @@ typedef struct PcPciMachineState {
 
 /**
  * PCMachineClass:
- *
- * Compat fields:
- *
- * @gigabyte_align: Make sure that guest addresses aligned at
- *                  1Gbyte boundaries get mapped to host
- *                  addresses aligned at 1Gbyte boundaries. This
- *                  way we can use 1GByte pages in the host.
- *
  */
 typedef struct PCMachineClass {
     X86MachineClass parent_class;
@@ -99,7 +91,6 @@ typedef struct PCMachineClass {
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
-    bool gigabyte_align;
     bool has_reserved_memory;
     bool broken_reserved_end;
     bool enforce_amd_1tb_hole;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index dd44df0470..093a7c35f7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1752,7 +1752,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     pcmc->smbios_defaults = true;
-    pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->pvh_enabled = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2043a7022a..0bc14da768 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -99,6 +99,17 @@ static void piix_intx_routing_notifier_xen(PCIDevice *dev)
     }
 }
 
+/*
+ * gigabyte_align: Make sure that guest addresses aligned at
+ *                 1Gbyte boundaries get mapped to host
+ *                 addresses aligned at 1Gbyte boundaries.
+ *                 This way we can use 1GByte pages in the host.
+ */
+static bool gigabyte_align(PCMachineState *pcms)
+{
+    return pc_machine_is_pci_enabled(pcms);
+}
+
 /* PC hardware initialisation */
 static void pc_init1(MachineState *machine, const char *pci_type)
 {
@@ -130,7 +141,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
      *  - Then, to gigabyte align the memory, we move the split to 3G
      *    (lowmem = 0xc0000000).  But only in case we have to split in
      *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    lowmem.  And for new machine types (gigabyte_align() = true)
      *    only, for live migration compatibility reasons.
      *
      *  - Next the max-ram-below-4g option was added, which allowed to
@@ -160,7 +171,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
         lowmem = pcms->max_ram_below_4g;
         if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
+            if (gigabyte_align(pcms)) {
                 if (lowmem > 0xc0000000) {
                     lowmem = 0xc0000000;
                 }
@@ -818,7 +829,6 @@ static void isapc_machine_options(MachineClass *m)
     m->option_rom_has_mr = true;
     m->rom_file_has_mr = false;
     pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
     pcmc->smbios_legacy_mode = true;
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
-- 
2.41.0


