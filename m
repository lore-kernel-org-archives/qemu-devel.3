Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB6606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dheHnJQV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fsmnP9cK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7G4-0008SC-Ay; Wed, 28 Oct 2026 13:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fi-0007Ci-RA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ff-0003oZ-1Y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WIdMTjPc/dwIdJ6XBpfQ72EWqo8P3kDvamGUISCs90I=;
 b=dheHnJQVL1mBZyuwl/GQ7BC5tpB10kREMQzcPkKvtOlWzSsinxEt8GIeX3+ozABxWavpCs
 i1h6EtxtAMl2YTSLwqVsLa13ny1oNZTSIKgbM1rJsvibndL3RDZWHf/buHd5euNWn29Zo7
 BsfIYsM8FYX232y6HowhcNoUWREEDGs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-_7h4HRz8MwutukRHR0St-A-1; Wed, 28 Oct 2026 13:15:48 -0400
X-MC-Unique: _7h4HRz8MwutukRHR0St-A-1
X-Mimecast-MFC-AGG-ID: _7h4HRz8MwutukRHR0St-A_1793207747
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0ef019a4so979255f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207747; x=1793812547; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WIdMTjPc/dwIdJ6XBpfQ72EWqo8P3kDvamGUISCs90I=;
 b=fsmnP9cKaQR/9EI5gB3jyQ0UpTxHS6XEv+pERH7KwpO8tEyg2zOv0KzTNkwd/edFO6
 j7dz+lzV+A0pqSUvHurcyZ2F7n6PD2oNH7bAzv6KkZqDyUmtkJa9UV9nUw6PFvadafLq
 +QgYfNpUgLBfBv7NBLdq0AV8L5uXFPlguMHWmNPDcY419cFMbHCJPff1Lf+uAZYToxOK
 /gyVZOJarShGSWCUSPNSDi2TO3hwOw97vGJI11AjgHfmAzkaoA+JnsE7oVZ/tkB7M0+R
 kVI1SzjhihG3W2fLQcU2WaAcE9onl/F4VpZD3kt96zIOP7gb7ykoZ+BrQZjOsDTo2KeH
 x/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207747; x=1793812547;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WIdMTjPc/dwIdJ6XBpfQ72EWqo8P3kDvamGUISCs90I=;
 b=XPysytnOd69GSiFEYubfALS+KJLM4la/DWQ2cFBhhjpGOdZTcu2/c4TLzD/ZmL1/CV
 w9s/Xj4fDJ9EFcYXpZQK8YrYvvXlhWkTRarDeqKG8xpU/DVJtWzyNfzZv9N33JpZt7vJ
 vjYklGcru/tQwWT7+5GEeD2Ba3KKFy2M1uTmRnxY/Az9KKz19NyiAazJ6oDzZuU0scVu
 X8z21gqA8ePnKOv+toEUhg/fc7fjGOssWlfPML2SndrdvkmWOzi2eThKicLVYQsQjId5
 jiMDZ7Skz1Lv+YPR3sr+t3GsQZUHFCUTjlipKCMlE4he5qngRUzy7a+mNt5p5TtYlnMx
 YTvw==
X-Gm-Message-State: AFq9FYKFSBPXYXye2k7/JgNMKq56LdwgBqyk3lGdaC6xpzVWWgQZ5Htr
 w2CYlQtOZxojAlxxnhjjKXLdw5LCXU9BKKLJAidnaueRRyrMH2mui6+xwHdlc/woB9Vwmf7wgQt
 tg+r+xUam33qEC0OS0QsAAopUJQkg6pKt5wtUiWVaUtK0yN5ilgdS1e5VMABoKu2t8UKrl/UnF/
 K94h9xTrl9PzeraxzPHWvxcOk+wjO6oTfsJg==
X-Gm-Gg: AYBFou3/ooJsksfEzBwUKwmxOBZfircTMA8eqFCKTfFK5WxXMKmkKV9sieg+Be9+YEW
 wpskAeqQ2+PW3GTCi9T6tQzizXlQnEP+w+727VQYlVdrbJjqeDZIZ6JiDqC43kVPQBrhNuxgJVh
 hOtZf7WZMCnYiaKki4Bv7xpcStBIOUeGLJhd9xvdVyNT9LsdXdLcDxd/TJeA0QOl+wOeK7pRWgW
 hDvNPNXqMjHOUFcDMn3gaY1zNeio21yZD4gMp+kb02HYZ7lvwVa2JIvfb0Z3yuyoJPNX4oVMCSv
 qBMwo/ydwRvdHRRv3zyhxfxRJEg2wZpOe0DLuacqG2urQg1gQfmKv8PtXscuN55oTUSq6a9oF6W
 K1tCM7G7OJYoWxJs9frs5ueeLmCgmN1Dzx4Jc2RgZ
X-Received: by 2002:a05:6000:24c5:b0:48d:fbdd:4132 with SMTP id
 ffacd0b85a97d-48e5d2e735fmr7409991f8f.18.1793207746598; 
 Wed, 28 Oct 2026 10:15:46 -0700 (PDT)
X-Received: by 2002:a05:6000:24c5:b0:48d:fbdd:4132 with SMTP id
 ffacd0b85a97d-48e5d2e735fmr7409892f8f.18.1793207745889; 
 Wed, 28 Oct 2026 10:15:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm29491073f8f.34.2026.10.28.10.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:45 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org
Subject: [PULL 40/78] pcie_sriov: register user created virtual function
 before realizing it
Message-ID: <ca7c24b7c8f69c13fef24a31660e1b6ea73686d3.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Paziyski <danielpaziyski@gmail.com>

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
Message-ID: <20260905122924.53813-1-danielpaziyski@gmail.com>
---
 hw/pci/pci.c        | 42 ++++++++++++++++++++++++------------------
 hw/pci/pcie_sriov.c |  6 ------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb..2d2fe02c68 100644
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
@@ -2326,8 +2330,15 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
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
@@ -2338,11 +2349,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
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
MST


