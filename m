Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409ACC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1QYI-0001gJ-CQ; Tue, 01 Sep 2026 11:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x1QYG-0001fc-RR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:37:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x1QYE-0003fl-Q9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:37:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48431632951so5500f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788277048; x=1788881848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFja+4rxtVGlb44kHSPmj1H7mIJQACmY1vyI4f8S7Qw=;
 b=oCV/jr5DIc2N23DgT+mXOsRURjNNmFntby3Vj0pSjVgXfhfjTxUu/CS45GPCl8G0xe
 HHPXyxPGE15mYAvtqf/fPOssvYqB5MgVACmCXiDTk9oGxs4fpIc93SzVdapmuT1dOy5Y
 hgm5FrrBKOSkt7CB8eU3jsW36zQqec+FNkpFXp6cT0uQl3szFggM0VXYVxALaewVnzXW
 u+Uaq1HSNI4YkY1y0SVIPkmT8GOeQXjSQjxcukY4OvOFkgJmUZy9vBIxh1DD2SqXlP6y
 l7IYN1yWELUQZUAqufKXoj4LKpgdIs0sVMDrU6Zsazx7DhQgrXPz9ZwdHa+hjyKEptrG
 HVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788277048; x=1788881848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFja+4rxtVGlb44kHSPmj1H7mIJQACmY1vyI4f8S7Qw=;
 b=VJzmVOiOYfRHc4vy/e/xjjH4R70c7V5wOh+6KzKIh2dnmpWRg1B8kli3jNONhYaHNK
 fY/d8wcgVSXFM200qRTGro3lSCxR1XSWMkfcg+5YF+GBbIh8XxX/PA19EyRHC70YUHGo
 0VRwRxJddp/vOgyXiVvlxIdoJpeqBL+3rv3FZ6HVXchsb5RtsU4cjBVflCTeC+Z6WQZS
 Vl/tcTmun2I7OS+5g5gIQzVAw/GVbcjqz3r6cQn07hsuLD72+GaKp4TYubz661WSuyUc
 Vbj/MxwKEitWOQeDjBmJnecwsE/XwHyWf5Wj1dUy2OHg5z8J/0l7o7E58QvizmMo8G6z
 swNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6BFSPjly3PwRMy6hg7036s6ZytDW3z9t4pVhNTertT3bbxNEMyDCam4+55s6oQvHuL6RXKdZrRYcJ@nongnu.org
X-Gm-Message-State: AFuF++mu/VE3+0ztoTD+f+5oxD1cdJDnpfvyEa+YTHUPmjJ+CGs3zILB
 XYwy1esnZj455myFay369TLEuCRqnohNBKsm1OLX8/fuRVouWSTYW2TX
X-Gm-Gg: AYBFou1hE0VBDX7Cio70sc0K4ipmbFdlBa7ptbTvG6qOmIZk3cr+FFx1SJ7gjG46Ehr
 2BzzB76Om2DXaTceseR/6fcNng+/gwbDeAfPHvScDy+we6HNKIpe7AldVon6dI7U0o2iAWwU/tD
 TlBNJw2bc2/KA550BAQL3KcmUGAPmniSsu+mAfau7sFlXo1noNMLUcOqWQUQPaXuVw4tlh2T+P0
 7Y4bPiuyscY0uZ3IW4PWA91RlveUPu3F7ciSPvynNSPJBfQsaVzYmim2jRmZls6XL7fFl0Wlbv5
 zhNjNeNeS1SBXwNq8Q7JLSdaQxtPyTI4GpjbBq797y/q+DUjXd9XL8P5iIyD8YQlOffpPzMDKyg
 0d+cK0iKGtbmSHIEkI83cZwQmDzyEubIZf0ZIn1M3qnu1k4V0LMIO1WfNm02gJyiy++yF982U2f
 fTwbr0B2SF1nOyO5O6mBhkTbJidcQBFMgT0LAnRb/H5BSPME542vBYgaYZlgg2+oW6eCHq
X-Received: by 2002:a5d:5e8d:0:b0:484:3317:a1b with SMTP id
 ffacd0b85a97d-48433170bc0mr19223815f8f.5.1788277047924; 
 Tue, 01 Sep 2026 08:37:27 -0700 (PDT)
Received: from AtiePC ([79.116.50.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d78444sm6378553f8f.25.2026.09.01.08.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 08:37:27 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: mst@redhat.com
Cc: danielpaziyski@gmail.com, kbusch@kernel.org, its@irrelevant.dk,
 qemu-stable@nongnu.org, foss@defmacro.it, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 3/3] pcie_sriov: register user created virtual function before
 realizing it
Date: Tue,  1 Sep 2026 17:37:21 +0200
Message-ID: <20260901153721.10292-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901094419-mutt-send-email-mst@kernel.org>
References: <20260901094419-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix this by placing the user created VF check and registering before the
realization. This way, incorrectly created user created VFs will be noticed,
and device creation will be aborted.

Additionally, remove from the pcie_sriov_register_device function the top
check. It seems that this check is done to error out if the PF failed for some
reason to initialize its list of user created VFs. However, in such situations,
the pcie_sriov_pf_init_from_user_created_vfs function will error during
realization, and it will be caught before the check is done at all. Moreover,
since now pcie_sriov_register_device is called before realization, the check
will always fail for PFs with user created VFs, because the list will be
populated during realization.

The rest of the function though, correctly errors out if a user created VF
is created for an unsupported device type, if a VF is created for a non-PCIe
device, or if the PF is already instantiated, with now the advantage being
that the check is done before the VF instantiation.

Moreover, move the unregistering of a device's acpi-index and the removal
of a VF from its PF list from pci_qdev_unrealize to do_pci_unregister_device.
We do the former so that the acpi-index is unclaimed on user created VF
creation error, and the latter to not have extra code on the device specific
realization error path.

When instantiating a user created VF for a NVME controller:

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
    #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
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
    #17 0x7f79a8427780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #18 0x7f79a84278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #19 0x5644c5f0a1f4 in _start (BuildId: 8483f952216d9e345c3744300d0aefa38feb50d7)

==91050==Register values:
rax = 0x00007e49988640f0  rbx = 0x00007e49988640f0  rcx = 0x00000fc9b3104828  rdx = 0x0000000000000058
rdi = 0x00007e49988640f0  rsi = 0x0000000000001cf0  rbp = 0x00007ffd622c1bc0  rsp = 0x00007ffd622c1b68
 r8 = 0x00000fc9b3104829   r9 = 0x00000fc9b3104828  r10 = 0x00000fc9b310481e  r11 = 0x00000fc9b310481e
r12 = 0x0000000000001cf0  r13 = 0x00000f6f32e78578  r14 = 0x00000000ffffffff  r15 = 0x00007ffd622c1c10
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
==91050==ABORTING

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
Before I make a v2, I send the patch over here to show you what I had in mind.

 hw/pci/pci.c        | 42 ++++++++++++++++++++++++------------------
 hw/pci/pcie_sriov.c |  6 ------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e8e8a3b767..58fe913b85 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1221,6 +1221,19 @@ static void pci_config_free(PCIDevice *pci_dev)
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
@@ -1234,6 +1247,9 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
                                     &pci_dev->bus_master_enable_region);
     }
     address_space_destroy(&pci_dev->bus_master_as);
+
+    pcie_sriov_unregister_device(pci_dev);
+    pci_unregister_acpi_index(pci_dev);
 }
 
 /* Extract PCIReqIDCache into BDF format */
@@ -1485,7 +1501,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
-    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1495,17 +1510,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
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
@@ -2316,8 +2320,15 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     pci_dev = do_pci_register_device(pci_dev,
                                      object_get_typename(OBJECT(qdev)),
                                      pci_dev->devfn, errp);
-    if (pci_dev == NULL)
+    if (pci_dev == NULL) {
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
@@ -2328,11 +2339,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
-    if (!pcie_sriov_register_device(pci_dev, errp)) {
-        pci_qdev_unrealize(DEVICE(pci_dev));
-        return;
-    }
-
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c41ac95bee..69930c7b8c 100644
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
-- 
2.55.0


