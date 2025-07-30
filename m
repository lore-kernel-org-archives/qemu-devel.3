Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8239C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 13:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh765-0002yS-9S; Wed, 30 Jul 2025 09:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh5oh-0003Aq-O7
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:21:57 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh5of-0004GN-Dw
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:21:55 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae0a0cd709bso186481566b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753878108; x=1754482908; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aPloQKoJKhmykFUH0A159LjCUhMDkiKM4yVqkPp23N8=;
 b=kecEmSPciZsqYxZ5Kh52LvYjlQc8HyDfmfiay5l7JkUm7dHXsYbPw9ezLGLzsDotm3
 37WFBhKNpl2ZM0lT17QK6oPOcB8KLznxnCr3lybgYwXDBmWO08sqBq26+5CrlI1uWvgX
 v/O0kYAsoLCE9b43z/pWrnWCInJ6gcnPqLlRkdj7CVCS8sLVP3leFLFOeAWzltveOksm
 gn/Nbahd8qs7xh29ApV6PC82TsWTOntSNZKGvHCjTOh90dFEHXQ7xSsIX5IZa5zOyg4D
 IS5MYp4XapO8sisDBPPYJVDjF6tGFgARaRa4AXBsDNkFcfkeyynQeoGiG7w+YiGe9NLm
 Y8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753878108; x=1754482908;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aPloQKoJKhmykFUH0A159LjCUhMDkiKM4yVqkPp23N8=;
 b=dqIDa7ND8o9wVWCsJO9+rdDzA/WxFsIv8uT4N7yB2AHWhtTk24WAxwnrq7CG3Jior2
 v+VYVOCvJnR8fwH6M/MkC8QwjMPl92xs67CsYFERORDeSVBGR+pUWW+plNobkK16Ky1P
 6awNYo0hjWmqN+sZf6Ojs7ObrB8ZKVNYbB+/Q26KOqSzrJRSA+mzSHVkurIvjTEWIZ0u
 dUspUoYe66cu3uPUjHix9ABd7EhRgVizZsrJoJPz9V+PrIN+EdaQDg40OHXr/rPuyh0Z
 EXBdyFNwROem8w6hS9BniCPbXMfxKbO6Cwdp1OeudzUA+q/Mo8fYLwnjMEHwF2+GRJ8V
 Htdg==
X-Gm-Message-State: AOJu0YynO9Ktceq3z5X3rJfON38FoIAcdRLcuUE8FhnTh1LA+vzrO1IE
 RBt17JfQCjxAxwbrvH6c26uChA1BILO74BF9WJywMC9fMWRi0mSaoRdoS8QGZX5xO2uOSl7qcj9
 8VfGt
X-Gm-Gg: ASbGncu9RZ4L4awtrx8ZGiRJVIeyjlqU///vyyhYE/Ze9fdovtJFCYjT59BiionkbQP
 dc4G1De2dUxL+LJYaSFwmKNxLqJZt1qTxOjRIYxoFavU3AIQulUqtscuMT1uUsIQgTV6zLsAbrc
 V9ItCxjd4ZRvii7+vd085j8ne38nF6pn/rg02BYuaK3Kv49F+E4M+WNrpFQVX/R7nvFdhlHIF4Y
 ekSDu5sV85GcRNNxy6YVJHa8nsVrNfS9IoUJaWV3RDU/b9sxvzxr7oModPMZLLcGQ7cPwr2/DR9
 5YZdQFoOdczpWyVSGcMRpdmKkrast/F/Jx8wIx4f7oQI53UWQ+1APCKZ7oZWiJatSc44FHoLc80
 /o7wvJgEuscekXcopnbt1sXrlXKuKFIs/M1zB8OxLVON3euW2i26DlnXEAqtTwBmB8MJ37Lq3uk
 3Czw==
X-Google-Smtp-Source: AGHT+IEpDzybs2xOOOtpEMQ+RYQUvTWdfUUhnse6AvP7EyeaJGOlFPW8cScrD8Se5bTZ0ZgqRJN2RQ==
X-Received: by 2002:a17:907:970b:b0:ae8:8d00:76c3 with SMTP id
 a640c23a62f3a-af8fd3af905mr355385466b.29.1753878108265; 
 Wed, 30 Jul 2025 05:21:48 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441708.home.otenet.gr. [79.129.182.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635b0836csm718395866b.139.2025.07.30.05.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 05:21:47 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 30 Jul 2025 15:21:41 +0300
Subject: [PATCH] hw/arm: add static NVDIMMs in device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFQOimgC/x3MTQqAIBBA4avErBPsz6irRITmVLPQYgwJwrsnL
 b/Fey8EZMIAY/ECY6RAp8+oygLWQ/sdBdlsqGXdyb6RwkdLzi2anWqXSHyLoal0r1pjUK6Qu4t
 xo+d/TnNKH8EdQJBjAAAA
X-Change-ID: 20250730-nvdimm_arm64_virt-931a764bbe0c
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4894;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=uqr4bPUxgx3ulK3GB21Yqggoxduhk6FHW7F6lItjBDU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9pZzVaQ2owTnIzRTJrZDZwRXEwMkNxVFBZVXNkClZtS1ZWaEUxenBHNnBJaTJD
 TjJKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUlvT1dRQUt
 DUkIzS2Nkd2YzNEowSXovRUFDVUpKQ0FrVmNNS3lrbktiSzhvSkJNR1E4bmpLRnorRjVRdmozVA
 puSkpHcERTSE1ZWFNnRytwSFpYMWpIUWZWREh4TXV5UjduQjM4Z0IxbnVGZmNVdkdBYmNYbVEwT
 EhGdzZaREJQCkhNOE04Y3NkaFhaMkVIZURYekN6Sll1Q1Z5QkVQK1d4MkVSRSttUzZmNWs5Q1Fy
 M3NIdEJTUzFoUHB2SWZrSGcKQWp4M1ZCbVJmTjU5ZWU0aCt2UExzZ3pZUE9pNmljLzR2Ky9PUkN
 6Z1UweFYrdEhjaTVHQjVEazVPbldwRTk5MApYTDdFYU45cGExOUVtT2JuYjltWnUxaEZqRUxyam
 ExRU1YSEFXS3U2eWlhL3FPV2RNZ3poYktVT2RYb2l2V0NjCkNyUkpGMGRkVkl4cnJ1dUM1R2tkQ
 202U1MydEZxM05Nd2tiWE5CVTRuQVNPN0szNlk2WTRQZlZma3dub3JNaUkKNjJML0crak85RWNw
 aGtHMlVOREJ3S29ZQXRiU2pvMk1EY1ZUbnBCblFZU3hzS29ZSkF4b1g0Zy8yQzRMNmNmTApkbEZ
 4a212MzJTaGt0TGNUajA1WlhNUzBldWlHYWI0VlJTYTFnSXRIMFdXeWFMRElVK25kWWtzRncyTU
 FBZEluCnE5bW1xNDc1SDBHcDBmTit5eGFTQVRjc01pQ0ZHNlRCditFbHA0MUN0ZXZvYUtWOEU4b
 kFwVGJ5bnozeHZ2L2cKWW9WdGh1NVZsVGlGNTZZY1VFbDUzekxwc1dWWkU1RWtYQkt3WEhTVXZ2
 YkpEL29DVzViSDJ1R1I0aHZhMWVQdwp4T3N1Z3p0RUxBL21aQWdkdFpwK2NvdTJWM0dkQUFRN3J
 CdVVJWVhuTWpBZEtXTmlRSW5nekx0aFQ2QTJjc0FrCnJIRGFWdz09Cj02b2VrCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
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

NVDIMM is used for fast rootfs with EROFS, for example by kata
containers. To allow booting with static NVDIMM memory, add them to the
device tree in arm virt machine.

This allows users to boot directly with nvdimm memory devices without
having to rely on ACPI and hotplug.

Verified to work with command invocation:

./qemu-system-aarch64 \
  -M virt,nvdimm=on \
  -cpu cortex-a57 \
  -m 4G,slots=2,maxmem=8G \
  -object memory-backend-file,id=mem1,share=on,mem-path=/tmp/nvdimm,size=4G,readonly=off \
  -device nvdimm,id=nvdimm1,memdev=mem1,unarmed=off \
  -drive file=./debian-12-nocloud-arm64-commited.qcow2,format=qcow2 \
  -kernel ./vmlinuz-6.1.0-13-arm64 \
  -append "root=/dev/vda1 console=ttyAMA0,115200 acpi=off"
  -initrd ./initrd.img-6.1.0-13-arm64 \
  -nographic \
  -serial mon:stdio

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/boot.c | 39 +++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c |  8 +++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d391cd01bb1b92ff213e69b84e5a69413b36c4f8..a0c1bcdf946ca98bb5da63f1a518018eb578dd81 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "system/reset.h"
 #include "hw/loader.h"
+#include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "system/device_tree.h"
 #include "qemu/config-file.h"
@@ -515,6 +516,26 @@ static void fdt_add_psci_node(void *fdt, ARMCPU *armcpu)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
+static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t scells,
+                             int64_t mem_base, int64_t size, int64_t node)
+{
+    int ret;
+
+    g_autofree char *nodename = g_strdup_printf("/pmem@%" PRIx64, mem_base);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
+    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells,
+                                       mem_base, scells, size);
+    /* only set the NUMA ID if it is specified */
+    if (!ret && node >= 0) {
+        ret = qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
+                                    node);
+    }
+
+    return ret;
+}
+
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms,
                  ARMCPU *cpu)
@@ -525,6 +546,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     unsigned int i;
     hwaddr mem_base, mem_len;
     char **node_path;
+    g_autofree MemoryDeviceInfoList *md_list = NULL;
     Error *err = NULL;
 
     if (binfo->dtb_filename) {
@@ -628,6 +650,23 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
+    md_list = qmp_memory_device_list();
+    for (MemoryDeviceInfoList *m = md_list; m != NULL; m = m->next) {
+        MemoryDeviceInfo *mi = m->value;
+
+        if (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            PCDIMMDeviceInfo *di = mi->u.nvdimm.data;
+
+            rc = fdt_add_pmem_node(fdt, acells, scells,
+                                   di->addr, di->size, di->node);
+            if (rc < 0) {
+                fprintf(stderr, "couldn't add NVDIMM /pmem@%"PRIx64" node\n",
+                        di->addr);
+                goto fail;
+            }
+        }
+    }
+
     rc = fdt_path_offset(fdt, "/chosen");
     if (rc < 0) {
         qemu_fdt_add_subnode(fdt, "/chosen");
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f5fb38da84235c32dc2d13a5c61889c..910f5bb5f66ee217a9140f9128804a5b9f69b5b6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2917,7 +2917,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (!vms->acpi_dev) {
+    if (!vms->acpi_dev && !(is_nvdimm && !dev->hotplugged)) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi-ged device");
         return;
@@ -2949,8 +2949,10 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(ms->nvdimms_state);
     }
 
-    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
-                         dev, &error_abort);
+    if (vms->acpi_dev) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
+                             dev, &error_abort);
+    }
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,

---
base-commit: 9b80226ece693197af8a981b424391b68b5bc38e
change-id: 20250730-nvdimm_arm64_virt-931a764bbe0c

--
γαῖα πυρί μιχθήτω


