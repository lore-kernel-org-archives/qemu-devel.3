Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9D8C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrb0W-0007rO-8n; Wed, 05 Aug 2026 08:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb05-0007nj-Jf
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb03-0006ee-1b
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954c08a7c8so1165485e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785933933; x=1786538733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=emGWraFb85q648++qsD+2jIhcU3Su9wTeLY94uHqiv4=;
 b=EiTJaco3rugtpFTBo52DL4TpwD8t6W8YLfMhzSe3kidBeJeelQATrbIW6pVaFg8eHH
 y/HgWS7tf16RHP8KNB0m7K4sFUHqsnYOEWRu6LjqXF2yui/mIe0mE5Kl9DY/naGnbBim
 n/jw9AOYwWtjkvCE35OFu597F4Ed0rv8omG1wllG3eahq13OW4UNUzm3lapZ9TEJbVdm
 bs2RMzjQHkCNG+5eU4X1oIm7WAism9xEuDbs860hpNsm6zQOBWVyG6r6fQ9TzAxcNUA1
 8Y4/S6Mv+11UNKUJyNeBEITGepVBVwJYZVGLZ5vkpLMMrsig9lf0GyeLmV4PmuEpDMTY
 0TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785933933; x=1786538733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=emGWraFb85q648++qsD+2jIhcU3Su9wTeLY94uHqiv4=;
 b=DBJu+VaxzVTFCBSiJ9iD0nYqY322GeGeCjqM8DWJSTNbt1jud73niEvRQWm5Yweujz
 qvs53m6tIri/3N9oyKohiEgLzhdSPgkg6ShgeBW3jdxJIkuSjEhsznl9spkcV6nwNyOf
 ayxPvj/uXxQYo3zsAmT6QLKUU/7XYWwUrvOfmmrQyhEvfqfKcRlXxRchD1C9nJUwYAWL
 Yzfki7nMK6FD4JC+fREI3pc0AYq88EVjIhScCkgir4vxZmrRZTJCneMbM1mT8YqXPWmY
 hXG/9pMpMesrPqnkpxPEpF/gVFoVUxgL+FobORA3wMlXlEhetda7dkW6kHTKN+bZ7zVq
 bMNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSVw7L7ws+9wt0rTNa6k1C/wlAmJ+TZxIQK8EVxiqD50iMRnBxd53ck0E7qyO7heWbX5BuNeg7Gm3s@nongnu.org
X-Gm-Message-State: AOJu0YzSXEv37+72kGmSUJMi9AZIr0lhk1ZwB/DarQimugtucsDn3B2g
 vX0oaS5pgiMngYmUzUrhhL60FlHaIgccfh3m/tZfViVAMXMnT7/miieK
X-Gm-Gg: AR+sD12lv7U9CZPKSagVwMjL8aPdKLGKAXbAW+CwOxQs2jOK1RB4hfaxeauxWv3OYPI
 f+e4xv+OBMy02De495a9mSfmW6wg6IKkjxFzTVpjZ4e84uXClFgi7Mo2h26y4vPXb/ODgZvatDH
 oyCNw7GD1GxxkE3bxJ3n0TdtL7SGL5br1ljUFnGEVMMfKuidlD6HVHcLAyZif1kneU4JR0RYVMY
 rT+k08nYiPKQaZLeH5YP2Yeo93oWJKmSi0Jyl6Qot9rj1Lg+9ORdAqldTcUc71wPYfKXU4nIEe+
 pYw1TG6xl64fGFeAJWN/kBoXvQgpn9dxRwy1Dm92+iSWO2YQWNlJ4cWXW8PxG64IIZrtLsgDMqh
 UdaUgZWsgXPijYUWvz9SksoNoTG5awf1revNOw3QwuShfkBYgjPII0dV0AF+YDgkPlkgEOikPJV
 upuIToh/nyOg0PkiTg4qebQjyzRVDnzwOrIdbK+K9F9du/ucJ1rRmgVJWaIok=
X-Received: by 2002:a05:600c:c8c:b0:495:7561:a9cc with SMTP id
 5b1f17b1804b1-4994e7d5c76mr38522495e9.4.1785933933280; 
 Wed, 05 Aug 2026 05:45:33 -0700 (PDT)
Received: from AtiePC ([79.116.13.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a100e14sm166453775e9.14.2026.08.05.05.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 05:45:32 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 3/3] pcie_sriov: register user created virtual function before
 realizing it
Date: Wed,  5 Aug 2026 14:45:18 +0200
Message-ID: <20260805124519.30054-4-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805124519.30054-1-danielpaziyski@gmail.com>
References: <20260805124519.30054-1-danielpaziyski@gmail.com>
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
 hw/pci/pci.c        | 11 ++++++-----
 hw/pci/pcie_sriov.c |  6 ------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..a5b4482bb6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2312,20 +2312,21 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     if (pci_dev == NULL)
         return;
 
+    if (!pcie_sriov_register_device(pci_dev, errp)) {
+        do_pci_unregister_device(pci_dev);
+        return;
+    }
+
     if (pc->realize) {
         pc->realize(pci_dev, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
+            pcie_sriov_unregister_device(pci_dev);
             do_pci_unregister_device(pci_dev);
             return;
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


