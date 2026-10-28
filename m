Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841F606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KrnMf/TU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMBLj-0006QR-37; Wed, 28 Oct 2026 17:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xMBLb-0006Ng-KB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:38:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xMBLZ-0001Gx-5D
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:38:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a56e05568aso2394285e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793223491; x=1793828291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lil5KW34Q+cwqbP2bWx/Jfymi1RYWSc3uEddgt9kJTg=;
 b=KrnMf/TUwtLaMLZFFNX2bQf+HXcmfxkV0irBFI/Dc5UlHVOSfkrf4Ft/yVs3Vcklyc
 kmq0vS6CyiXi9vXUHU9AWJHcbmBqpqcnvDYLuv89fxpPl0P3HDOwuBIJlM1VAS407frq
 cS8NrCAEWew3dXYluhcJj9Ckyq8XntT+a40YbPZmMLP7+cVFstypuSigD+74H7BSfbKC
 DAZHnwDi/NOH9Tw3nlKtB1nMxbxOZI0/YmJ9mIrl/Y4S2+kTmOuc7W3dzJFHFaxhTWFh
 PcsXW0B9qzmTV/Z4dDt8qGJKmRXo+tg/PK1mPVaUNQVmx+8Lp4TGbyI1SX6wCgtoT94+
 nMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793223491; x=1793828291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lil5KW34Q+cwqbP2bWx/Jfymi1RYWSc3uEddgt9kJTg=;
 b=T2nGBluC0/gJ4JTDuONJavIp9p5vBrCiaBKcgoTZy7Saq2IIbeO+5rc7/5EQc/wnMX
 fogjWAGncWtpfS7MrtkvzfTUl2FRSt8OPupFwMO3Xz8W/FrbLXxqQDbfHw8yQBITho/e
 cHssBEyww/S25oReau7dmRO7dwuNvucAmqQf5yuH9sdI29VhDA/e4GgHmrYZMmARKHqj
 FuWTkV//hBhfQr2x2QGa5GdGdyf1k0WxLD/QgfT1Nz4f4WjcGP6fvqrowsrwOsuPjG8t
 ri4Ina+34goApQVvQjaPIbdvzwUuHnFlf5GPGP5RvkWc9T5PVuqhy4Twp29jRnfuZDgI
 bwfg==
X-Forwarded-Encrypted: i=1;
 AKwUvByA/z4bQ9q5qrpPbLNI2MdZh6FYpAQRRFWYm/7g/mCkOHc0L4mpBju6lWbxwN8RuwGxYlyUCvu6XXfe@nongnu.org
X-Gm-Message-State: AFq9FYIe9PxckQuTmYmyJePZbbRHbnXxaVzJQunoTdBGJR7qS3dQYAnT
 qw+l85isAzoMm0p2Hmq2JzjqFbc825ADENuNL8UES4xrcBZYubd44yIb
X-Gm-Gg: AYBFou2RzxBoiMjcaqiEN3rMsOYHF4XkNaTvsnRnxywNQ5NXK+r2izIolAvQHK3OHhT
 arVWoCdK5IhORXAcwL30W4D7/R+2eaF/WibhuvILtIhzmH0W51hLWm3W6eIVvKUj3o4DWTgaode
 NHeJE5iUotwjmp59Ol7CiQ+5WnlfN5cDj1mGhuoXN6Zp2rzpkqoV3CeoxWaFSulBSliZE41bcNu
 2dWhFc/DyXBSjh9K0BhYYge8kAACPgUOknJ00WyrslGCPuvZxMAiofCSgq2cPSXnSZSElvSx/E2
 e294H03oFTgSTTjBstwXy5BaaLXrnmj7KvfA4o0k/vO9IRvaf3kD1LT1mGGL8dGYQo/6Wlh72a1
 F+mktH2EUXdqt1+r7W9jPM1/BeXPsPw2wr2Lb0YI4BsAcqqcSQLvMVl+K1t1exbFz8x1EtUyvtg
 cigOFqQQLvN2mngYrcnlgdYnLRoo9uNzgSWWNP2FI8sSKRxv2ODuJDvbY70UCTEZflGb0Y2UqH/
 +T1qlqPqFuAQuBjpDLc7i3+LdCVBvVtB0zKPW9ya1Po37ooCh2hNp/UP3M9wajeFEKe7uIRLc56
 WQjXv0SrT8IQT+jpWs28iGNG1+wZoqb7muDMNMFakXwaoUjVQVtkZSUiogumV066GNcTPpuxa7s
 SfyQzvZbThg==
X-Received: by 2002:a05:6000:288a:b0:48d:f9c1:2ad4 with SMTP id
 ffacd0b85a97d-48e5d460118mr9046165f8f.4.1793223491257; 
 Wed, 28 Oct 2026 14:38:11 -0700 (PDT)
Received: from AtiePC ([2a0c:5a87:5006:4800:78cf:63bd:d449:f7bc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3932sm31798983f8f.18.2026.10.28.14.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 14:38:10 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2] pcie_sriov: register user created virtual function before
 realizing it
Date: Wed, 28 Oct 2026 22:38:00 +0100
Message-ID: <20261028213800.236067-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There are two ways of creating virtual functions: by using the sriov-pf device
parameter (this way, creating a user created VF and binding it to a PF), or
by using a device specific parameter, where the device manually creates a given
amount of VFs.

When a PCI device is realized, the device specific realize function is called
first, and then the pcie_sriov_register_device function is called, which checks
whether the device that has been created is a user created VF, and if it is the
case and the device allows this kind of VFs, it inserts it into a hashmap, with
the key being the ID of the PF, and the items being arrays of VFs.

User created VFs are instantiated independently, and later, when the PF calls
pcie_sriov_pf_init_from_user_created_vfs, it discovers its VFs from the hashmap
mentioned previously, and sets up in their PCIDevice.ex.sriov_pf structure
the pointer to the PF. This means that, during realization, VFs have no access
to the PF.

Device created VFs are instantiated during or after PF realization using the
pcie_sriov_pf_init function, which sets up for the VFs the pointer to the PF
before their realization, so when they're realized, they can access the PF
with no issues.

The problem here is that pcie_sriov_register_device is called after the
realization, and not before. This means that when a user created VF is created
for a device which does not support user created VFs, but supports device
created VFs, the realize function will notice that a VF is being created, and
may try to access the PF, causing a null pointer dereference fault.

Fix this by placing the user created VF check and registering, done by
pcie_sriov_register_device before realization. This way, incorrectly created
user created VFs will be noticed, and device creation will be aborted.

Additionally, create a new function pcie_sriov_check_after_realize, which
will be called after device realization, and its purpose is to check that
the VF or PF is in a consistent state. Currently, it checks that, if the device
is a PF, then it has initialized its list of VFs (this check was formerly done
by pcie_sriov_register_device), and in the case where the device is a VF,
it checks that the device is still a PCI Express device (some devices, e.g.
virtio-pci, clear this status during realization if the device is not in a
PCIe bus, or is located at the root complex).

Moreover, move the unregistering of a device's acpi-index and the removal
of a VF from its PF list from pci_qdev_unrealize to do_pci_unregister_device.
We do the former so that the acpi-index is unclaimed on user created VF
creation error, and the latter to not have extra code on the device specific
realization error path. We also gain from this that the acpi-index of a
device whose creation has errored will always be released, unlike until now,
where it is left stale if only do_pci_unregister_device were called instead
of pci_qdev_unrealize.

When instantiating a user created VF for a NVME controller (which is not
allowed):

Command line:

    qemu-system-x86_64 -device nvme-subsys,id=subsys0 \
    -device nvme,id=vctrl0,sriov-pf=ctrl0,subsys=subsys0 \
    -device nvme,id=ctrl0,subsys=subsys0,serial=s

ASAN splat:

../hw/nvme/ctrl.c:9613:28: runtime error: member access within null pointer of type 'struct NvmeCtrl'
AddressSanitizer:DEADLYSIGNAL
=================================================================
==91050==ERROR: AddressSanitizer: SEGV on unknown address 0x000000001cf0 (pc 0x7f79a8573dcd bp 0x7ffd622c1bc0 sp 0x7ffd622c1b68 T0)
==91050==The signal is caused by a READ memory access.
    #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd)
    #1 0x5644c6c0266e in nvme_realize ../hw/nvme/ctrl.c:9613
    #2 0x5644c6c67213 in pci_qdev_realize ../hw/pci/pci.c:2316
    #3 0x5644c7a2cfc1 in device_set_realized ../hw/core/qdev.c:514
    #4 0x5644c7a4f767 in property_set_bool ../qom/object.c:2484
    #5 0x5644c7a48d0b in object_property_set ../qom/object.c:1548
    #6 0x5644c7a568a5 in object_property_set_qobject ../qom/qom-qobject.c:28
    #7 0x5644c7a49385 in object_property_set_bool ../qom/object.c:1618
    #8 0x5644c7a2aeb0 in qdev_realize ../hw/core/qdev.c:277
    #9 0x5644c735f29f in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
    #10 0x5644c735f3ab in qdev_device_add ../system/qdev-monitor.c:758
    #11 0x5644c72b1901 in device_init_func ../system/vl.c:1217
    #12 0x5644c829d4a3 in qemu_opts_foreach ../util/qemu-option.c:1148
    #13 0x5644c72bc33e in qemu_create_cli_devices ../system/vl.c:2762
    #14 0x5644c72bcaa1 in qmp_x_exit_preconfig ../system/vl.c:2822
    #15 0x5644c72c3241 in qemu_init ../system/vl.c:3862
    #16 0x5644c801abf8 in main ../system/main.c:71

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---

Changes since v1 (https://lore.kernel.org/qemu-devel/20260905122924.53813-1-danielpaziyski@gmail.com/):
- Clean up ASAN splat, no need to be so verbose.
- The return value of do_pci_register_device is checked, instead of being
  assigned to pci_dev, this way avoiding dereferencing it when it is null
  when cleaning up the acpi-index on device registration error.
- Create pcie_sriov_check_after_realize, for the reasons explained in the commit
  description.

 hw/pci/pci.c                | 43 ++++++++++++++++++++++---------------
 hw/pci/pcie_sriov.c         | 25 +++++++++++++++------
 include/hw/pci/pcie_sriov.h |  2 ++
 3 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb..e85b34d06d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1227,6 +1227,19 @@ static void pci_config_free(PCIDevice *pci_dev)
     g_free(pci_dev->used);
 }
 
+static void pci_unregister_acpi_index(PCIDevice *pci_dev)
+{
+    if (pci_dev->acpi_index) {
+        GSequence *used_indexes = pci_acpi_index_list();
+
+        g_sequence_remove(g_sequence_lookup(used_indexes,
+                          GINT_TO_POINTER(pci_dev->acpi_index),
+                          g_cmp_uint32, NULL));
+
+        pci_dev->acpi_index = 0;
+    }
+}
+
 static void do_pci_unregister_device(PCIDevice *pci_dev)
 {
     pci_get_bus(pci_dev)->devices[pci_dev->devfn] = NULL;
@@ -1240,6 +1253,9 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
                                     &pci_dev->bus_master_enable_region);
     }
     address_space_destroy(&pci_dev->bus_master_as);
+
+    pcie_sriov_unregister_device(pci_dev);
+    pci_unregister_acpi_index(pci_dev);
 }
 
 /* Extract PCIReqIDCache into BDF format */
@@ -1491,7 +1507,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
-    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1501,17 +1516,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
     do_pci_unregister_device(pci_dev);
 
     pci_dev->msi_trigger = NULL;
-
-    /*
-     * clean up acpi-index so it could reused by another device
-     */
-    if (pci_dev->acpi_index) {
-        GSequence *used_indexes = pci_acpi_index_list();
-
-        g_sequence_remove(g_sequence_lookup(used_indexes,
-                          GINT_TO_POINTER(pci_dev->acpi_index),
-                          g_cmp_uint32, NULL));
-    }
 }
 
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
@@ -2323,11 +2327,16 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
     }
 
-    pci_dev = do_pci_register_device(pci_dev,
-                                     object_get_typename(OBJECT(qdev)),
-                                     pci_dev->devfn, errp);
-    if (pci_dev == NULL)
+    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
+                                pci_dev->devfn, errp)) {
+        pci_unregister_acpi_index(pci_dev);
         return;
+    }
+
+    if (!pcie_sriov_register_device(pci_dev, errp)) {
+        do_pci_unregister_device(pci_dev);
+        return;
+    }
 
     if (pc->realize) {
         pc->realize(pci_dev, &local_err);
@@ -2338,7 +2347,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
-    if (!pcie_sriov_register_device(pci_dev, errp)) {
+    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
         pci_qdev_unrealize(DEVICE(pci_dev));
         return;
     }
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c41ac95bee..23a2a43af7 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -357,12 +357,6 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
 
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
 {
-    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
-        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
-        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
-        return false;
-    }
-
     if (dev->sriov_pf) {
         PCIDevice *pci_pf;
         GPtrArray *pf;
@@ -398,6 +392,25 @@ bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
     return true;
 }
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp)
+{
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
+    if (dev->sriov_pf) {
+        /* some devices might clear their PCIe capability during realization */
+        if (!pci_is_express(dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV VF");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 void pcie_sriov_unregister_device(PCIDevice *dev)
 {
     if (dev->sriov_pf && pfs) {
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index b0ea6a62c7..00fe8c4ada 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
 void pcie_sriov_unregister_device(PCIDevice *dev);
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp);
+
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
-- 
2.56.0


