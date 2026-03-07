Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31FFFCB602
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYN-0004x0-Vp; Sat, 07 Mar 2026 10:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYM-0004wq-QY
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:26:54 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYL-00084L-AH
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:26:54 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso84007785e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897211; x=1773502011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMoQ3NbTol8pSbdgghPvXG4r2n1wnaW8ZAPS6V4fUYw=;
 b=pdbPHmCRGVAUAJTVPjwkMSuGN3MDPt02dvfaM7B6ST7kRHV4SRN8TB4mFdD+Otbsao
 CCeybe1ZGdRphdrDHQJbjijjJJ/wA4nn9JJCyO+9PEsexWKyh05uQ6UyP1DAL4r+Ruqg
 WGq2/mJcafBuJkta8hsBB1E/skf2XYBLTec+iIUVQF4j/ZvyBL0RRAY6Q5x0tvRZ1yUs
 7UBY9dYjo9JMOb2vhxGefzVy0ADBHHQSHiXSo3oSj4wOrUam5isognczPkTw/2IAqTyu
 zS3a6L9tmLAL9bXjVwmVQ2mS4oJ+gmpy53s3Db6qEBlttMT/z/VlcWwwMQWoMjzhwD9V
 87og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897211; x=1773502011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IMoQ3NbTol8pSbdgghPvXG4r2n1wnaW8ZAPS6V4fUYw=;
 b=EBD6hByp/IUZ9/WYKtmXYR+RFDkeqCxpDxSQS7SFNT1G9XcHr1TFVDEiTBaR4WfkHY
 hTtXnfSYfaVbOZx/xxzxvAaHAu78dwjiy+EhCufyqtRjfhlx7K6xXlaCK/FIUqTwCp4C
 BZNeIWiEF9q5cRN8lZsgXuEkXnV2RMmtnpjWCPXdvfIzf65Woh8BSjHIN14TtdF7Q+37
 iHCGFcW0cFvtT/Z5UmVifvlWYf1lca8HSZ27GU25deYda0U/KTHK/p9VgsBOVvgRviVX
 P9t2wmREpeiTlaiUDJAFD/FO5YW23OjtbVjiTGjwHNWCDGY810UzmPURXutBZM/9Mtov
 fIdg==
X-Gm-Message-State: AOJu0YxBbbr/WL36pyQfigynX1Bz1/PBZvv57Ymnp+CW5wJuQEYYle7V
 JIr+kKGg6An+YmyVbkQhMfsuFbs52UyQuVqHsBUwfHzBIgx0uBFkQmm6ttflbb8+Z3uWBl14KSp
 ETTIijqM=
X-Gm-Gg: ATEYQzy+3RWCMZH5zj5MLL96LjauIil5c18B93UTY5Qk71S/P2YDxDSID+Gl5UhTTtX
 zhEhV4/+Hd3MlFQLdGFq+2183aKv7K2OVNiAxmXbbEfZEw8rliGs2o+/Yd2QlTlt0TKgAp6HDiP
 ncChJbwhQCkf7KCE7Y9KPDDX6Md1fP/zjFVWwmV1SFrfrzlI+VnJoZ6QrYjOnGv1FWSaL4T2UyF
 bDmLBZImVOwONOOgHWaFdAxbsVtMvm5M3IYzgdBorrLXNiTs8QoNAhqE2cCr+CyVbtYC2h7JwmI
 9f3BlyWdCu1/u6d7xszhUgN4saCa2JBR2cxgmedttGuel630XMu3EU3WHI8TjBJqYwAhxBO+ZAA
 Mb7ITjLRtwKntwE/cKp/zc2QfplUDCCTo7MYZOlKZZ3JuOGDpSTanYp6n3ZaOlVFDp0iBDZRIsg
 y3Ayo38dZ4BsiLtjoFGhjBFJLgJk90Y1Z4o4PopWZZ+64dTmTedodYlPmCrhwMciCeOC2+EVab
X-Received: by 2002:a05:600c:4e89:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-48526951acemr87854005e9.16.1772897211330; 
 Sat, 07 Mar 2026 07:26:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb85b8sm11981944f8f.17.2026.03.07.07.26.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:26:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 02/10] hw/i386/pc: Remove PCMachineClass::pvh_enabled field
Date: Sat,  7 Mar 2026 16:26:26 +0100
Message-ID: <20260307152635.83893-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The PCMachineClass::pvh_enabled boolean was only used by
the pc-q35-3.1 and pc-i440fx-3.1 machines, which got removed.
Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 6 ++----
 hw/i386/x86-common.c | 3 +--
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5623660f5dd..908de5e1eab 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -110,9 +110,6 @@ struct PCMachineClass {
     bool enforce_amd_1tb_hole;
     bool isa_bios_alias;
 
-    /* use PVH to load kernels that support this feature */
-    bool pvh_enabled;
-
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a38634e3577..107f12cbe73 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -597,7 +597,6 @@ void xen_load_linux(PCMachineState *pcms)
 {
     int i;
     FWCfgState *fw_cfg;
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
     assert(MACHINE(pcms)->kernel_filename != NULL);
@@ -607,7 +606,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
+    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
@@ -941,7 +940,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
+        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
@@ -1682,7 +1681,6 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->isa_bios_alias = true;
-    pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index a420112666a..db8d4e855f4 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -704,8 +704,7 @@ void x86_load_linux(X86MachineState *x86ms,
          * saving the PVH entry point used by the x86/HVM direct boot ABI.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (pvh_enabled &&
-            load_elfboot(kernel_filename, kernel_size,
+        if (load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
 
-- 
2.52.0


