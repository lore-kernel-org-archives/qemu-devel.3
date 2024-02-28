Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7EAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEy9-0001T8-Jm; Wed, 28 Feb 2024 03:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEy6-0001SL-Qy
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEy4-0000Rt-5M
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueI10wMn0YbFPSAUc+Z6vQJJhHpFqUppGs+kMeA8Nqg=;
 b=L+j75pYfFP05Nr8P+5NSXsILeW/WsqkfNHq8SVbtTQJ5T66alfSibYbSD2vlUTzxTF8bkU
 PQ+9XZznM5l6ztTf7DEsGx5jDr68kAJuiAwiJiI5BmXcATSxWA9umIMPn28bhldRHPl3vS
 g4hqTYcdGwIz62e8WD0iNSICT/UUdDw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-gfeOS0P1O1KFqSyvxRFZ-g-1; Wed, 28 Feb 2024 03:07:04 -0500
X-MC-Unique: gfeOS0P1O1KFqSyvxRFZ-g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a26f2da3c7bso349012366b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107621; x=1709712421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ueI10wMn0YbFPSAUc+Z6vQJJhHpFqUppGs+kMeA8Nqg=;
 b=WFAuFQw2x5LQILdQt7uPqtwyZvXxUx5AfNVgTmnOWlWRbopVlNPIGqyp1IzQjVQcYR
 G0uydbHUUPRvPzpx1zhcMrZirYCxJ0/ZSTlOVvNT7jiaNBZlIB6jhjZDqpOeK2mo0kgN
 FSkck33Dtwq0sFI8AdJGz5vX84cunZopALm5fJ5Ei5AI1x+FRcv7pjzdn7E1whGfwbLV
 eKXbOSR+J8RFXRUiGGnvEMSw8vGiNuUGVAKHu73h5ibIhkBCVPqVBQShjwdZc8KGnWUG
 ziWeTKZ+nKKMk+pZgIXscpVHMCMWlZ3N1oKVvgIRSHRQC54nRiM7PWr9mmrQAuGQB1Zy
 anrQ==
X-Gm-Message-State: AOJu0Yx0iamNzKz4polttoyF+eajcu779Mc5QEv8o7YN5zzDAYFiE4IG
 LGtSIRaoknpZnHhS8Tf/PF+Tt/6JrIezcsjcSHLgTpr7xMHdBhy9oY49Uat9fsi7FsXJVoH9S5n
 arHizjECdaGXDEssNTesbgaf2/OJvIRBBCHMdf1rWOqVQShTOFKckxQ0k/4dzqYYAyJp21QA/iP
 FOkTBb6naN1t0aYqVMQIF87AXWKMwUqjuDt9As
X-Received: by 2002:a17:907:119b:b0:a38:916e:a4fe with SMTP id
 uz27-20020a170907119b00b00a38916ea4femr8208727ejb.39.1709107621307; 
 Wed, 28 Feb 2024 00:07:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLbLyETl1ElnwzqODti0/JtBmXJ2jwESSsfT6xof9zgG9YRzWDCg36LCzw1BPukl+bb7HvDg==
X-Received: by 2002:a17:907:119b:b0:a38:916e:a4fe with SMTP id
 uz27-20020a170907119b00b00a38916ea4femr8208709ejb.39.1709107620966; 
 Wed, 28 Feb 2024 00:07:00 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 rf20-20020a1709076a1400b00a43e6c2e107sm627973ejc.189.2024.02.28.00.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:06:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/10] vl, pc: turn -no-fd-bootchk into a machine property
Date: Wed, 28 Feb 2024 09:06:37 +0100
Message-ID: <20240228080646.261365-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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
 hw/i386/pc.c         | 31 ++++++++++++++++++++++++++-----
 system/globals.c     |  1 -
 system/vl.c          |  2 +-
 qemu-options.hx      |  2 +-
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e88468131a5..034bef25f58 100644
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
index f8eb684a492..ea3607452af 100644
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
@@ -619,7 +621,7 @@ void pc_cmos_init(PCMachineState *pcms,
     object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
                              &error_abort);
 
-    set_boot_dev(s, MACHINE(pcms)->boot_config.order, &error_fatal);
+    set_boot_dev(pcms, s, MACHINE(pcms)->boot_config.order, &error_fatal);
 
     val = 0;
     val |= 0x02; /* FPU is there */
@@ -1543,6 +1545,20 @@ static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
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
@@ -1731,6 +1747,7 @@ static void pc_machine_initfn(Object *obj)
 #ifdef CONFIG_HPET
     pcms->hpet_enabled = true;
 #endif
+    pcms->fd_bootchk = true;
     pcms->default_bus_bypass_iommu = false;
 
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
@@ -1878,6 +1895,10 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
         NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
         "SMBIOS Entry Point type [32, 64]");
+
+    object_class_property_add_bool(oc, "fd-bootchk",
+        pc_machine_get_fd_bootchk,
+        pc_machine_set_fd_bootchk);
 }
 
 static const TypeInfo pc_machine_info = {
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
index b8469d9965d..98bf0c386b4 100644
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
index 9be1e5817c7..1136642c21d 100644
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
2.43.2


