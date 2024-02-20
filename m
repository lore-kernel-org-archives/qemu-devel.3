Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAFCC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSRa-0006tz-TN; Tue, 20 Feb 2024 10:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcSRY-0006tS-9J
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcSRT-0003Fl-36
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708444437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7VHk/u26xfnAuj9GaQkaBR2A8p4XnPGC2O3m2W3MMs4=;
 b=F50oKJwncs/fq8oRe7n4ObL4+xuz8hNii1PbbG7pN1ACIiULLTUHZ2y3FzXYDG8Q6TOMEi
 V43m4Xuu6RvaRF8W2moBw1qnMqnygeJh9Le+a8df2CVnaeOrCGlRV514++UHXXDFNjdTRZ
 tfPF4W0emuf3iROkQndqlOP7vyVZYU4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-IYP5tR7RM0iBd8NB0qIfwg-1; Tue, 20 Feb 2024 10:53:55 -0500
X-MC-Unique: IYP5tR7RM0iBd8NB0qIfwg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3e45a18f39so177191166b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708444434; x=1709049234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7VHk/u26xfnAuj9GaQkaBR2A8p4XnPGC2O3m2W3MMs4=;
 b=JoaHPUyeFKWDM2V9v1AyCqVs2d55EeJ3xxB0HSePPZJq3fk34TyeIRuVeySFzzE+6O
 pVINkUQ8x+4VD9sWMzfwMCRq74wkBWUy1ry/F7QbmT9+HcVIWymaBQwVpCcAACmlFuHn
 X+Bqj5wjT09qHWfEUCRtuG2EavL5tL8kW+cxt/M6ZjgizPFE5ByXMWXHA9D5BBLLjDVX
 Zb+a1mCNU+x6PO64dJMLrVePVS5ntj5yIUiXqdGhQrhDwIPn45ldz5gCnhkekjILos8C
 yzQQopSTfhco7XIyIzQ7JW6dk/fSgq50dIvi6xZr/6mubzzac/875VIdNf31ZMAMb8HN
 Bt5w==
X-Gm-Message-State: AOJu0Yy8uBHuVywPDn4nw+2HEZjxrM/Pl0xr4bQpYWS9gMbyD5TBP381
 OpaJyDCDLFXyMk16Lt8yQYfj/g6VGdbxECg2C8yQj6EY0FBxOvJiDmdGH4oKw1GwlVRwj/rAgLL
 yDEze+/AhFzQSbW9pSlK0gdZ4Hi0Y3l1mZvf3BxLTCvT7q0Dkd04Lr0bwQYpARYmIj0KkHv1gE5
 TNcqzJer0aVZwycxaZn5DULNuViaG/7fQWzw8N
X-Received: by 2002:a17:906:4153:b0:a3e:f7ae:49b6 with SMTP id
 l19-20020a170906415300b00a3ef7ae49b6mr1882772ejk.49.1708444434337; 
 Tue, 20 Feb 2024 07:53:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbxaVJ4pxUWz28vDuuQ2NHbJNRjuX+XlJhkrxWUtBzFCG2MWkim5+ktTAAKgL6EOZ0P8ffeA==
X-Received: by 2002:a17:906:4153:b0:a3e:f7ae:49b6 with SMTP id
 l19-20020a170906415300b00a3ef7ae49b6mr1882756ejk.49.1708444433933; 
 Tue, 20 Feb 2024 07:53:53 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 cx2-20020a170907168200b00a3d2157e267sm4103139ejd.11.2024.02.20.07.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 07:53:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] vl, pc: turn -no-fd-bootchk into a machine property
Date: Tue, 20 Feb 2024 16:53:52 +0100
Message-ID: <20240220155352.416710-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a fd-bootchk property to PC machine types, so that -no-fd-bootchk
returns an error if the machine does not support booting from floppies
and checking for boot signatures therein.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h |  2 +-
 hw/i386/pc.c         | 30 +++++++++++++++++++++++++-----
 system/globals.c     |  1 -
 system/vl.c          |  2 +-
 qemu-options.hx      |  2 +-
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 02a0deedd3c..e5382a02e7a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -50,6 +50,7 @@ typedef struct PCMachineState {
     bool hpet_enabled;
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
+    bool fd_bootchk;
     uint64_t max_fw_size;
 
     /* ACPI Memory hotplug IO base address */
@@ -147,7 +148,6 @@ OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 
 /* pc.c */
-extern int fd_bootchk;
 
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 28194014f82..31f4bb25a3e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -399,8 +399,8 @@ static int boot_device2nibble(char boot_device)
     return 0;
 }
 
-static void set_boot_dev(MC146818RtcState *s, const char *boot_device,
-                         Error **errp)
+static void set_boot_dev(PCMachineState *pcms, MC146818RtcState *s,
+                         const char *boot_device, Error **errp)
 {
 #define PC_MAX_BOOT_DEVICES 3
     int nbds, bds[3] = { 0, };
@@ -420,12 +420,14 @@ static void set_boot_dev(MC146818RtcState *s, const char *boot_device,
         }
     }
     mc146818rtc_set_cmos_data(s, 0x3d, (bds[1] << 4) | bds[0]);
-    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | (fd_bootchk ? 0x0 : 0x1));
+    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | !pcms->fd_bootchk);
 }
 
 static void pc_boot_set(void *opaque, const char *boot_device, Error **errp)
 {
-    set_boot_dev(opaque, boot_device, errp);
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+
+    set_boot_dev(pcms, opaque, boot_device, errp);
 }
 
 static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
@@ -617,6 +619,9 @@ void pc_cmos_init(PCMachineState *pcms,
     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
 
+    object_property_add_bool(obj, "fd-bootchk", pc_machine_get_fd_bootchk,
+                             pc_machine_set_fd_bootchk);
+
     object_property_add_link(OBJECT(pcms), "rtc_state",
                              TYPE_ISA_DEVICE,
                              (Object **)&x86ms->rtc,
@@ -625,7 +630,7 @@ void pc_cmos_init(PCMachineState *pcms,
     object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
                              &error_abort);
 
-    set_boot_dev(s, MACHINE(pcms)->boot_config.order, &error_fatal);
+    set_boot_dev(pcms, s, MACHINE(pcms)->boot_config.order, &error_fatal);
 
     val = 0;
     val |= 0x02; /* FPU is there */
@@ -1559,6 +1564,20 @@ static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
 }
 
+static bool pc_machine_get_fd_bootchk(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->fd_bootchk;
+}
+
+static void pc_machine_set_fd_bootchk(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->fd_bootchk = value;
+}
+
 static bool pc_machine_get_smbus(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -1747,6 +1766,7 @@ static void pc_machine_initfn(Object *obj)
 #ifdef CONFIG_HPET
     pcms->hpet_enabled = true;
 #endif
+    pcms->fd_bootchk = true;
     pcms->default_bus_bypass_iommu = false;
 
     pc_system_flash_create(pcms);
diff --git a/system/globals.c b/system/globals.c
index b6d4e72530e..5d0046ba105 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -41,7 +41,6 @@ int vga_interface_type = VGA_NONE;
 bool vga_interface_created;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 int win2k_install_hack;
-int fd_bootchk = 1;
 int graphic_rotate;
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
diff --git a/system/vl.c b/system/vl.c
index a82555ae155..4627004304b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2927,7 +2927,7 @@ void qemu_init(int argc, char **argv)
                           optarg, FD_OPTS);
                 break;
             case QEMU_OPTION_no_fd_bootchk:
-                fd_bootchk = 0;
+                qdict_put_str(machine_opts_dict, "fd-bootchk", "off");
                 break;
             case QEMU_OPTION_netdev:
                 default_net = 0;
diff --git a/qemu-options.hx b/qemu-options.hx
index 8547254dbf9..a9e0107b4f0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2650,7 +2650,7 @@ DEF("no-fd-bootchk", 0, QEMU_OPTION_no_fd_bootchk,
 SRST
 ``-no-fd-bootchk``
     Disable boot signature checking for floppy disks in BIOS. May be
-    needed to boot from old floppy disks.
+    needed to boot from old floppy disks.  Synonym of ``-m fd-bootchk=off``.
 ERST
 
 DEF("acpitable", HAS_ARG, QEMU_OPTION_acpitable,
-- 
2.43.0


