Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FFCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7r-0006m1-Fa; Thu, 28 Mar 2024 11:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7p-0006ew-W8
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:10 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7o-0002hL-7c
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:09 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so155232066b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641426; x=1712246226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BSXB7GHW5TBQXIjnxuyxFyj9B1iDsM8cHi/htTyRxs=;
 b=bamZfs6ZpZARXoFfvhiYUlk8JTdEt5Hy6MRpnESxzdU/z6Xhk9ZW4tRux1pQNHonKj
 fRHLphy6mkLkdv+0zARX7iIv7teQaq4q0tqKQONQFCWjds3TRl40tHn+kg/N/sydP/9b
 BG5xAcbmxKc+Z9u901CL2g+8GVRWlGeRQEvn/u58yPKjf4W+YI+j77JYYgdMtbK8VdFG
 b7nAMQT0SVI6C+ejaWNoXtOkKnhEmXkgUHEx2ho1UtbK/McWUm0lhbmcV7FLsSvp28FV
 Fq8lyiaSRepRUUzzW3quXa0cZWdhyrly3UxSTYr5qbCS7zUkvnw7S2Mi8S3n1KjyliNI
 hYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641426; x=1712246226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BSXB7GHW5TBQXIjnxuyxFyj9B1iDsM8cHi/htTyRxs=;
 b=DidA3cYSThwSF5F/irkkmopfVCh9sxPVHmGTFl5/7gIdCFm2B4afWxzMsujzcvadPD
 C40OUrNrMXCKSL4QYWbVvQVBsLjHgLEEkb9GAc/XN0lzOD42dV+4nUySSdwvCa9xVu1G
 pbJMmVtgAx6SDNkg9+3d6kayoQL6AT3cfoayUcWGEYcDecW26HPv5bEV9fg/00xWFO7d
 w4tTcZPuY24qaVTQZmcQtNRP29ij+IfFimcYzqvCVRFL930Aj9s0F6w2+dwB7p2vYi3N
 MBllRAnCW5ogTWg9w4WUNdd8Bnc04B+Ofpxwe7qBZGk+TTODJEiw6e3By4Gu7wN/FZP+
 IyFA==
X-Gm-Message-State: AOJu0YzxOQcoBjUgmVdOMo7qw8SSULlVRqBdgnMcF8BkC8FK2GWk9lF/
 sBZlYAzkFNt/taaetqzqxxOgAR2ZH8ScU3GMVQ+O+lE3mJH7w5hpkz77Bi+l6mucBtTrALu+33s
 x
X-Google-Smtp-Source: AGHT+IFF/skKWHNCTMPwJb+B2ckteIOxmThfN9+aMTRN8D0HIEaksr7NEcZ4nuV98VsFYsHsSKmB9w==
X-Received: by 2002:a17:906:b112:b0:a47:1fe8:9825 with SMTP id
 u18-20020a170906b11200b00a471fe89825mr2020350ejy.32.1711641426506; 
 Thu, 28 Mar 2024 08:57:06 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 f8-20020a17090624c800b00a46fbff47a6sm891626ejb.168.2024.03.28.08.57.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:06 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 23/29] hw/i386/fw_cfg: Inline smbios_defaults()
Date: Thu, 28 Mar 2024 16:54:31 +0100
Message-ID: <20240328155439.58719-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

All PCI-based machines have the smbios_defaults field
set to %true. Simplify by using an inlined helper
checking whether the machine is PCI-based or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/fw_cfg.c     | 7 ++++++-
 hw/i386/pc.c         | 1 -
 hw/i386/pc_piix.c    | 1 -
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7da0bc8aa4..6a6a8df005 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -86,7 +86,6 @@ typedef struct PCMachineClass {
     int default_cpu_version;
 
     /* SMBIOS compat: */
-    bool smbios_defaults;
     bool smbios_legacy_mode;
     SmbiosEntryPointType default_smbios_ep_type;
 
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 14a7dfbdc9..f60390ed56 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -49,6 +49,11 @@ const char *fw_cfg_arch_key_name(uint16_t key)
 }
 
 #ifdef CONFIG_SMBIOS
+static bool smbios_defaults(PCMachineState *pcms)
+{
+    return pc_machine_is_pci_enabled(pcms);
+}
+
 void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type)
 {
@@ -61,7 +66,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
 
-    if (pcmc->smbios_defaults) {
+    if (smbios_defaults(pcms)) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc, mc->name);
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b83abee8e9..7a758a2e84 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1754,7 +1754,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    pcmc->smbios_defaults = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e6178f8653..70dc8686f9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -828,7 +828,6 @@ static void isapc_machine_options(MachineClass *m)
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
     m->rom_file_has_mr = false;
-    pcmc->smbios_defaults = false;
     pcmc->smbios_legacy_mode = true;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-- 
2.41.0


