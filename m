Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D75C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 19:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u18yE-0004zu-AA; Sat, 05 Apr 2025 15:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1u18y2-0004z5-Se
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 15:14:15 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1u18y0-0007Dw-Bb
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 15:14:10 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d6d84923c8so9318595ab.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743880445; x=1744485245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kQdGrrcbZWKpYAgus0JPPTI/OwvFHzzmXF7Yn31LZPs=;
 b=J8v2G86ZUpWjtg6N1tC5v3yiSxhjEvHpHQWovbMW7jn/Hq9iKazG/4rK8MEUuPv9Cr
 dpaF0q61fZ+UTm6MLv+ZejROQRhgM12DxrbMVh9+Qtoolp0VoZxdDgph8rOwA3h2aDCl
 Fpn04C/lHuM+qW+9m2pDlaqkx+SlQuJqQ3rAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743880445; x=1744485245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQdGrrcbZWKpYAgus0JPPTI/OwvFHzzmXF7Yn31LZPs=;
 b=A0RCqhftdKZ3ObtJjG5tSl5YQFXVOfR2ki/0m/ByV+OfxOd82RW3h7v6mohsdJBAo4
 X32JKG6IYUCPcNwNI6GR+n6Fc1iVvaLm+gUdc2imzDfuh1XjtvQwGEojwWZH4zjO2A1R
 X0dwykeGpnU6WZwhT/vtT3nYi1O/qLxNLc2i7EV+UQ+FkflsKah9IFtkpMNTr8kETp0x
 HbMOEUaxPuo/SQ/sJ2OcSDEpLLyRJHGk7LoW5HmRzT7rDOT7htkgnMzFuD8W+x7I2HDd
 +FaPiT8/kAvHj5oLAOycYD0CkMC/F7RZPKXE7M9nc1vWjuoCjqZOAgratFd3sbavPC3z
 uK2A==
X-Gm-Message-State: AOJu0YyvjEeMnrRqP6dIxe+ykNB3xcu6LVrdCCmJVmiJ0VLBChoVsqhv
 hVrFHWRO+v7NfSh/OGf7NfFeBmp+04MVjL5OzO7pW5gif1XA6dubayuYKhZJzeYu53UUFW8Mjh+
 6RA==
X-Gm-Gg: ASbGncut5hL6McG4u1NUgPSmVShrAhLFwYuKLh9uPnrPEX1z0BczAltQZzIauE5exNH
 A23yfO4aWNH8xt6C3sBZku1JQUMmt8yD9zYUdh4uGDTNOQCjxAUxaWXXhiKOtdh90rxx9VW/xeY
 viQ1JCxHr9ObPIfJAoFkMbS5bVpXwH9k1SthLUW0g22R/ihUTgoWnNi5fNKtz4uEZWT1ZMxqGSU
 uGF/TNMtUHEUirpPlwlmn4/arDSnz4tqrxJsS0tCI4CdMYFUnDFSnDwXLIcwbHmOVKLW6LNmzem
 5etpzAUr5IaN7etGwkqHA8S4tlHxTjhhQQF8czaUTl+oijmLUdS1GeRAudi53yBXF1veMxIoY3J
 fuNamtw==
X-Google-Smtp-Source: AGHT+IG1kE/4gUjS0cE7jF+0JBfluXn5iK4tbMX4jU+yA/YkO4Hq4/HislkAEYSgPerDqzjJFj4TwQ==
X-Received: by 2002:a05:6e02:2402:b0:3d6:ca61:5f67 with SMTP id
 e9e14a558f8ab-3d6e576be66mr64977505ab.14.1743880444934; 
 Sat, 05 Apr 2025 12:14:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4b5d40515sm1448176173.120.2025.04.05.12.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 12:14:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3] hw/arm/virt: Allow additions to the generated device tree
Date: Sat,  5 Apr 2025 13:13:50 -0600
Message-ID: <20250405191352.2597585-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=sjg@chromium.org; helo=mail-il1-x12c.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

At present qemu creates a device tree automatically with the 'virt' generic
virtual platform. This is very convenient in most cases but there is not
much control over what is generated.

Add a way to provide a device tree binary file with additional properties
to add before booting. This provides flexibility for situations where
Linux needs some tweak to operate correctly. It also allows configuration
information to be passed to U-Boot, supporting verified boot, for example.

The term 'merge' is used here to avoid confusion with device tree overlays,
which are a particular type of format.

Link: https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html
Link: https://patchwork.ozlabs.org/project/uboot/patch/20250405190711.365419-1-sjg@chromium.org/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Rebase to master

Changes in v2:
- Rebase to master

 docs/system/arm/virt.rst |  13 +++-
 hw/arm/virt.c            | 135 +++++++++++++++++++++++++++++++++++++++
 hw/core/machine.c        |  20 ++++++
 include/hw/boards.h      |   1 +
 qemu-options.hx          |   8 +++
 system/vl.c              |   3 +
 6 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index adf446c0a2..5d34dc90ae 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -235,8 +235,17 @@ Hardware configuration information for bare-metal programming
 The ``virt`` board automatically generates a device tree blob ("dtb")
 which it passes to the guest. This provides information about the
 addresses, interrupt lines and other configuration of the various devices
-in the system. Guest code can rely on and hard-code the following
-addresses:
+in the system.
+
+The optional ``-dtbi`` argument is used to specify a device tree blob to merge
+with this generated device tree, to add any properties required by the guest but
+not included by qemu. Properties are merged after the generated device tree is
+created, so take precedence over generated properties. This can be useful for
+overriding the ``stdout-path`` for Linux, for example, or to add configuration
+information needed by U-Boot. This is intended for simple nodes and properties
+and does not support use of phandles or device tree overlays.
+
+Guest code can rely on and hard-code the following addresses:
 
 - Flash memory starts at address 0x0000_0000
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a..ec7c74637d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -41,6 +41,7 @@
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
+#include <libfdt.h>
 #include "net/net.h"
 #include "system/device_tree.h"
 #include "system/numa.h"
@@ -349,6 +350,135 @@ static void create_fdt(VirtMachineState *vms)
     }
 }
 
+
+/*
+ * From U-Boot v2021.07 (under BSD-2-Clause license)
+ *
+ * This does not use the qemu_fdt interface because that requires node names.
+ * Here we are using offsets.
+ *
+ * overlay_apply_node - Merges a node into the base device tree
+ * @fdt: Base Device Tree blob
+ * @target: Node offset in the base device tree to apply the fragment to
+ * @fdto: Device tree overlay blob
+ * @node: Node offset in the overlay holding the changes to merge
+ *
+ * overlay_apply_node() merges a node into a target base device tree
+ * node pointed.
+ *
+ * This is part of the final step in the device tree overlay
+ * application process, when all the phandles have been adjusted and
+ * resolved and you just have to merge overlay into the base device
+ * tree.
+ *
+ * returns:
+ *      0 on success
+ *      Negative error code on failure
+ */
+static int overlay_apply_node(void *fdt, int target, void *fdto, int node)
+{
+    int property;
+    int subnode;
+
+    fdt_for_each_property_offset(property, fdto, node) {
+        const char *name;
+        const void *prop;
+        int prop_len;
+        int ret;
+
+        prop = fdt_getprop_by_offset(fdto, property, &name, &prop_len);
+        if (prop_len == -FDT_ERR_NOTFOUND) {
+            return -FDT_ERR_INTERNAL;
+        }
+        if (prop_len < 0) {
+            return prop_len;
+        }
+
+        ret = fdt_setprop(fdt, target, name, prop, prop_len);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    fdt_for_each_subnode(subnode, fdto, node) {
+        const char *name = fdt_get_name(fdto, subnode, NULL);
+        int nnode;
+        int ret;
+
+        nnode = fdt_add_subnode(fdt, target, name);
+        if (nnode == -FDT_ERR_EXISTS) {
+            nnode = fdt_subnode_offset(fdt, target, name);
+            if (nnode == -FDT_ERR_NOTFOUND) {
+                return -FDT_ERR_INTERNAL;
+            }
+        }
+
+        if (nnode < 0) {
+            return nnode;
+        }
+
+        ret = overlay_apply_node(fdt, nnode, fdto, subnode);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+/* Merge nodes and properties into fdt from fdto */
+static int merge_fdt(void *fdt, void *fdto)
+{
+    int err;
+
+    err = overlay_apply_node(fdt, 0, fdto, 0);
+    if (err) {
+        fprintf(stderr, "Device tree error %s\n", fdt_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+/* Finish creating the device tree, merging in the -dtbi file if needed */
+static int complete_fdt(VirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+
+    if (ms->dtbi) {
+        char *filename;
+        void *fdt;
+        int size;
+        int ret;
+
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ms->dtbi);
+        if (!filename) {
+            fprintf(stderr, "Couldn't open dtbi file %s\n", ms->dtbi);
+            goto fail;
+        }
+
+        fdt = load_device_tree(filename, &size);
+        if (!fdt) {
+            fprintf(stderr, "Couldn't open dtbi file %s\n", filename);
+            g_free(filename);
+            goto fail;
+        }
+
+        ret = merge_fdt(ms->fdt, fdt);
+        g_free(fdt);
+        if (ret) {
+            fprintf(stderr, "Failed to merge in dtbi file %s\n", filename);
+            g_free(filename);
+            goto fail;
+        }
+        g_free(filename);
+    }
+    return 0;
+
+fail:
+    return -1;
+}
+
 static void fdt_add_timer_nodes(const VirtMachineState *vms)
 {
     /* On real hardware these interrupts are level-triggered.
@@ -2438,6 +2568,11 @@ static void machvirt_init(MachineState *machine)
 
     create_platform_bus(vms);
 
+    if (complete_fdt(vms)) {
+        error_report("mach-virt: Failed to complete device tree");
+        exit(1);
+    }
+
     if (machine->nvdimms_state->is_enabled) {
         const struct AcpiGenericAddress arm_virt_nvdimm_acpi_dsmio = {
             .space_id = AML_AS_SYSTEM_MEMORY,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f52a4f2273..d714c5e99c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -375,6 +375,21 @@ static void machine_set_dtb(Object *obj, const char *value, Error **errp)
     ms->dtb = g_strdup(value);
 }
 
+static char *machine_get_dtbi(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->dtbi);
+}
+
+static void machine_set_dtbi(Object *obj, const char *value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->dtbi);
+    ms->dtbi = g_strdup(value);
+}
+
 static char *machine_get_dumpdtb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1143,6 +1158,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "dtb",
         "Linux kernel device tree file");
 
+    object_class_property_add_str(oc, "dtbi",
+        machine_get_dtbi, machine_set_dtbi);
+    object_class_property_set_description(oc, "dtbi",
+        "Linux kernel device tree file to merge with the generated device tree");
+
     object_class_property_add_str(oc, "dumpdtb",
         machine_get_dumpdtb, machine_set_dumpdtb);
     object_class_property_set_description(oc, "dumpdtb",
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f22b2e7fc7..dabc51581d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -400,6 +400,7 @@ struct MachineState {
 
     void *fdt;
     char *dtb;
+    char *dtbi;  /* filename of device tree to merge with the generated one */
     char *dumpdtb;
     int phandle_start;
     char *dt_compatible;
diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..be45f877ec 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4294,6 +4294,14 @@ the guest image is:
 
 ERST
 
+DEF("dtbi", HAS_ARG, QEMU_OPTION_dtbi, \
+    "-dtbi   file    merge 'file' with generated device tree\n", QEMU_ARCH_ARM)
+SRST
+``-dtbi file``
+    Merge a device tree binary (dtb) file into the generated device tree and
+    pass the result to the kernel on boot.
+ERST
+
 DEFHEADING()
 
 DEFHEADING(Debug/Expert options:)
diff --git a/system/vl.c b/system/vl.c
index ec93988a03..75d76951be 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3018,6 +3018,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_dtb:
                 qdict_put_str(machine_opts_dict, "dtb", optarg);
                 break;
+            case QEMU_OPTION_dtbi:
+                qdict_put_str(machine_opts_dict, "dtbi", optarg);
+                break;
             case QEMU_OPTION_cdrom:
                 drive_add(IF_DEFAULT, 2, optarg, CDROM_OPTS);
                 break;
-- 
2.43.0


