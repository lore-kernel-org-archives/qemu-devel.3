Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F82DD59D6A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFT-0005UP-LA; Mon, 25 Nov 2024 14:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFM-0005GL-Fg
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:48 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFE-0004tr-TV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:48 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-382376fcc4fso2823649f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564779; x=1733169579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sx/wgUhO2hnEU30pqKphmQJjzDJZvYIKeuvBl/T4ue8=;
 b=GfO+JlXUCiBEocXmlOnYc0MVFNcxFPDU6qd4i8zU3MvRESadkbT5Kjafu+UQlHOPts
 IyLYsHe7pEjc7cTK/e/PfZvIE2sVGhPhQ3eKkV9h8gzsiH+EpoebJLHqParFv1ydpxGf
 ASJo/dAajouef4BFgm/OCABAL0YsPlhm+oiCs3yPnAnN75nonea10J2747WiduFBMFVf
 NnTCsiG0Yb+gcsw+NZhpOd4JUVEIGstipXSlKc+uqaR20KNNrRK69OktIVaAsMBMLlN9
 AL9fJOafVOwV0YaWbtkZhL2prSyGpSnXn/JkP4zpSYqw4B+BJ1g2naQzA+kDrYcuNAme
 YicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564779; x=1733169579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sx/wgUhO2hnEU30pqKphmQJjzDJZvYIKeuvBl/T4ue8=;
 b=aF47AdqTTMd87SU/QkYwBeXBQ2u8k31JKAcoVabAGIQB92hvcSF5K45eKJD+dMrgZY
 V2pjzsQ5ibN3FGySzO8aKEvkwU9spfSVoN6e7zclMJDUOPiGm/iD+s542thJQlNXSSBQ
 zBwDViN/fF9zntLUFFJ6xJqZISb8M0KFZePWiD/JRvKuLe+wBLQv8Tg/fARFS31z/+R2
 0zj6iC7KaUrMqjOAPDtr+6M18LehdUZ47oFivnsCofXGQVRmw3+oosiegxsIdGOQ2HH5
 /2+clA+XT5Cag8ISkbns+CdgiR4o6On2vb7j1FqelU5YaLxnlhAhrgxQGnPZEzQethvr
 DxEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFcU8R2uW1IqTzpoxWCF9oKnOkhB+U5t9aWnXX2TjQTn7ARf+SYtfPaZzK0tWpkTwNphoKJm2S1kIl@nongnu.org
X-Gm-Message-State: AOJu0Yy7uUG/UVA69GnCimxIPYSrGPJiWNUUVg33963v8BLG0FGd2eCX
 4sRRe6mmnTp7iKKjvID0eS9QEGt5LGehSWO0frAK7LnCs7y4IX5Db+z6KXfK9QI=
X-Gm-Gg: ASbGnctWycijkpDyGke7yEaDGt7w0yCgmwsqugj85tKacsNuw1H6miUjq+sgb5fA8qV
 nc+1DsKPZ0XdAilKH6XFaVfg2bUC+L5rADR5UFxcDQfuT+V9mUJrVCt+fPUm3CdB4hCsLF6iDWn
 suhZQ4KHnBfRkoEtpvycB7CL72WJfBROqvkg+MM/HUB7tyTeOLpP/pPPyydyesmZDc3mOPxn1Ky
 nmWK7EPH4W6Ca5B0WhlrJBbNlAzKT7RW1GpLhFxQVIqU7UEr6Mslssmu+5lRvLO763P
X-Google-Smtp-Source: AGHT+IEDhTtNZEirT7xBFMutfVs/saGMV1bfHmtxSxlCg2GretDVGOBISN5KO8jHbhgqfqZOMilyVg==
X-Received: by 2002:a05:6000:18a2:b0:382:496e:8784 with SMTP id
 ffacd0b85a97d-38260b6eb06mr12571026f8f.26.1732564779568; 
 Mon, 25 Nov 2024 11:59:39 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 26/26] hw/arm/virt: Add measurement log for
 confidential boot
Date: Mon, 25 Nov 2024 19:56:25 +0000
Message-ID: <20241125195626.856992-28-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
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

Create a measurement log describing operations performed by QEMU to
initialize the guest, and load it into guest memory above the DTB.

Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: New
---
 include/hw/arm/boot.h |  3 +++
 include/hw/arm/virt.h |  1 +
 hw/arm/boot.c         | 47 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c         | 23 +++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 5fcbaa2625..f2518c4e81 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -147,6 +147,9 @@ struct arm_boot_info {
      * Confidential guest boot loads everything into RAM so it can be measured.
      */
     bool confidential;
+    /* measurement log location in guest memory */
+    hwaddr log_start;
+    size_t log_size;
 };
 
 /**
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e5e9f67f52..fe1c464be6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -180,6 +180,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    Object *event_log;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e461137595..1ced008062 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -665,6 +665,24 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
 
     fdt_add_psci_node(fdt);
 
+    /* Add a reserved-memory node for the event log */
+    if (binfo->log_size) {
+        char *nodename;
+
+        qemu_fdt_add_subnode(fdt, "/reserved-memory");
+        qemu_fdt_setprop_cell(fdt, "/reserved-memory", "#address-cells", 0x2);
+        qemu_fdt_setprop_cell(fdt, "/reserved-memory", "#size-cells", 0x2);
+        qemu_fdt_setprop(fdt, "/reserved-memory", "ranges", NULL, 0);
+
+        nodename = g_strdup_printf("/reserved-memory/event-log@%" PRIx64,
+                                   binfo->log_start);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "compatible", "cc-event-log");
+        qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", 2, binfo->log_start,
+                                           2, binfo->log_size);
+        g_free(nodename);
+    }
+
     if (binfo->modify_dtb) {
         binfo->modify_dtb(binfo, fdt);
     }
@@ -943,6 +961,30 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
     return kernel_size;
 }
 
+static void add_event_log(struct arm_boot_info *info)
+{
+    if (!info->log_size) {
+        return;
+    }
+
+    if (!info->dtb_limit) {
+        int dtb_size = 0;
+
+        if (!info->get_dtb(info, &dtb_size) || dtb_size == 0) {
+            error_report("Board does not have a DTB");
+            exit(1);
+        }
+        info->dtb_limit = info->dtb_start + dtb_size;
+    }
+
+    info->log_start = info->dtb_limit;
+    if (info->log_start + info->log_size >
+        info->loader_start + info->ram_size) {
+        error_report("Not enough space for measurement log and DTB");
+        exit(1);
+    }
+}
+
 static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
                                          struct arm_boot_info *info)
 {
@@ -990,6 +1032,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
             }
             info->dtb_start = info->loader_start;
             info->dtb_limit = image_low_addr;
+            add_event_log(info);
         }
     }
     entry = elf_entry;
@@ -1128,6 +1171,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
                 error_report("Not enough space for DTB after kernel/initrd");
                 exit(1);
             }
+            add_event_log(info);
+
             fixupcontext[FIXUP_ARGPTR_LO] = info->dtb_start;
             fixupcontext[FIXUP_ARGPTR_HI] = info->dtb_start >> 32;
         } else {
@@ -1189,6 +1234,8 @@ static void arm_setup_confidential_firmware_boot(ARMCPU *cpu,
         error_report("could not load firmware '%s'", firmware_filename);
         exit(1);
     }
+
+    add_event_log(info);
 }
 
 static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5247f53882..1e0f664af0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1808,6 +1808,11 @@ void virt_machine_done(Notifier *notifier, void *data)
         exit(1);
     }
 
+    if (vms->event_log) {
+        object_property_set_uint(vms->event_log, "load-addr",
+                                 vms->bootinfo.log_start, &error_fatal);
+    }
+
     fw_cfg_add_extra_pci_roots(vms->bus, vms->fw_cfg);
 
     virt_acpi_setup(vms);
@@ -2149,6 +2154,21 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
     }
 }
 
+static void create_measurement_log(VirtMachineState *vms)
+{
+    Error *err = NULL;
+
+    vms->event_log = kvm_arm_rme_get_measurement_log();
+    if (vms->event_log == NULL) {
+        return;
+    }
+    vms->bootinfo.log_size = object_property_get_uint(vms->event_log,
+                                                      "max-size", &err);
+    if (err != NULL) {
+        error_report_err(err);
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -2499,6 +2519,9 @@ static void machvirt_init(MachineState *machine)
                                vms->fw_cfg, OBJECT(vms));
     }
 
+    kvm_arm_rme_set_ipa_size(64 - clz64(vms->highest_gpa));
+    create_measurement_log(vms);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
-- 
2.47.0


