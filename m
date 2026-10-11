Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E34CA9EBD
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 12:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFsY2-0003wc-9Y; Sun, 11 Oct 2026 08:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3J3_LagoKCrAijQdbUoZXkWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--stanleyjhu.bounces.google.com>)
 id 1xFsY0-0003wH-Fp
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 08:21:00 -0400
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3J3_LagoKCrAijQdbUoZXkWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--stanleyjhu.bounces.google.com>)
 id 1xFsXy-0001RV-Lh
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 08:21:00 -0400
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2e8621795e7so9972145ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791721256; x=1792326056; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8C9xyfV1eTyWVnb5I+6EeNw6DddE1JoqDnWYExpAboQ=;
 b=lalVBL7iHXEDTv8Dyor1wmVqkClbsLhSlYWetK/N8KSliKWaKSgJW70CpjbHQYOHX3
 lVUlIju/+ahZ6Dr7+p0B5XuVRDAWXRPrTen5P6uOxIEensxxOfFzetjdrMKMTtPPXaMc
 PNSoULn6g/Ta8Ab6oKiDR8DmhWnVlLzwf6Y+4laWHXNrhqH5M1o5XC2jyTHTNPUznwdH
 d6fwYCPc+5K1xdzU6lChW47YuBQCdY6awE9Mg4wL7dzrUU0ONSdLjBdttzOXsPdJmkFN
 gvpoy/lHpefHxjcVJGu6OjKZMrIF0r+ORPwF5LL0pSgMZnmGghUv/Um28A30msGAn8HR
 FJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791721256; x=1792326056;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8C9xyfV1eTyWVnb5I+6EeNw6DddE1JoqDnWYExpAboQ=;
 b=LpUBxS3ock5OB6GDR5IfKEBWkI4ca/tUjmpG/aCTkBjvx+7g9WvIXzxcCBdk1H9qR2
 Id4yHJ6NFa9LZVhOnwnGSnmS7s/1kKHtRWUSqhzy7qXhT0zm1Y4Ax6Ndky+OJ1ompvAN
 DAPDaE421rCMsQSmEJxiyvqnulByGGf7PHLRCKoZHpfDjRMPBr9x58k0oRlmdjjKvmAt
 e/+g+m6l3cRIQlyfYJjIadWbGC0oD5x7Y1UVFznSoNzT2eg7aFjaBxpQKNrKse5iH8cw
 Mtnzj0xNkRLUsJeYprfx0rzEmoZJPYD9/Q+fA5Khp5QXdm/vWi9ozviocVsX304FN7IH
 2JYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByr/a1Dn3GYBir1jGfV7iR+JS3pKzQC0a47BDPq2T9Z9tngEQA3nbHonT1UAZu9+DkIPMt09VJaD0JI@nongnu.org
X-Gm-Message-State: AFq9FYIyhe7W8xVtoRBJK95rU0w5EK06xH0R68rVxiUliMYQhJ0TN4dy
 fLhstz/AgAKw0VNaobiTAMU1rX+CN3yk1AwQap8z6YK9jPQLjTo9zI933CKPGaXrV/7K4Ax2n3H
 WnYj/68hVi0uKjngQ8kcVTA==
X-Received: from plbjc17.prod.google.com ([2002:a17:903:25d1:b0:2e5:70bd:8a5a])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec84:b0:2e5:d2db:bf57 with SMTP id
 d9443c01a7336-2e842d03028mr61044335ad.49.1791721255709; 
 Sun, 11 Oct 2026 05:20:55 -0700 (PDT)
Date: Sun, 11 Oct 2026 20:20:53 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261011122053.1250706-1-stanleyjhu@google.com>
Subject: [PATCH] docs/system: Add UFS emulation page
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Bart Van Assche <bvanassche@acm.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::645;
 envelope-from=3J3_LagoKCrAijQdbUoZXkWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x645.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The UFS host controller and logical unit devices have no user
documentation. Their properties and the way the two devices fit
together can only be found by reading hw/ufs/.

Add docs/system/devices/ufs.rst with an example command line, the
device properties, and current limitations, and list it under the UFS
entry in MAINTAINERS.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 MAINTAINERS                      |  1 +
 docs/system/device-emulation.rst |  1 +
 docs/system/devices/ufs.rst      | 88 ++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 docs/system/devices/ufs.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1b..c7f65a5a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2758,6 +2758,7 @@ S: Supported
 F: hw/ufs/*
 F: include/block/ufs.h
 F: tests/qtest/ufs-test.c
+F: docs/system/devices/ufs.rst
 
 megasas
 L: qemu-block@nongnu.org
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 40054bb7d..a7d247a27 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -96,6 +96,7 @@ Emulated Devices
    devices/net.rst
    devices/nvme.rst
    devices/scsi/index.rst
+   devices/ufs.rst
    devices/usb-u2f.rst
    devices/usb.rst
    devices/vfio-user.rst
diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
new file mode 100644
index 000000000..d3482e929
--- /dev/null
+++ b/docs/system/devices/ufs.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=============
+UFS Emulation
+=============
+
+QEMU emulates a Universal Flash Storage (UFS) host controller and the
+logical units behind it. The host controller follows the UFSHCI
+register interface and reports UFS version 4.1 to the guest.
+
+Two devices are involved:
+
+``ufs``
+  The host controller on the PCI bus. A ``sysbus-ufs`` variant exists
+  for boards that place the controller on the system bus; it cannot be
+  created with ``-device``.
+
+``ufs-lu``
+  A logical unit attached to a host controller through ``bus=``. Each
+  logical unit is backed by a block device.
+
+The well-known logical units (REPORT LUNS, UFS Device, Boot and RPMB)
+are created by the host controller and need no configuration.
+
+Adding a UFS Device
+===================
+
+The following adds a host controller with MCQ enabled and one logical
+unit backed by ``ufs.img``:
+
+.. code-block:: console
+
+    -drive file=ufs.img,if=none,id=lu0,format=raw \
+    -device ufs,id=ufs0,serial=0001,mcq=on \
+    -device ufs-lu,drive=lu0,bus=ufs0,lun=0
+
+Add more ``ufs-lu`` devices with different ``lun`` values to create
+more logical units. On top of the architecture defconfig, a Linux
+guest needs ``CONFIG_SCSI_UFSHCD``, ``CONFIG_SCSI_UFSHCD_PCI`` and
+``CONFIG_BLK_DEV_SD``; each logical unit then appears as a SCSI disk.
+
+Host Controller Properties
+==========================
+
+``serial``
+  Serial number string. It is accepted but not reported to the guest
+  yet; the serial number string descriptor reads back empty.
+
+``nutrs`` (default 32, maximum 32)
+  Number of UTP transfer request slots.
+
+``nutmrs`` (default 8, maximum 8)
+  Number of UTP task management request slots advertised to the guest.
+  Task management requests are not processed yet (see Limitations).
+
+``mcq`` (default off)
+  Advertise Multi-Circular Queue (MCQ) support. When off, the guest
+  uses the single doorbell transfer request list.
+
+``mcq-maxq`` (default 2, maximum 31)
+  Number of MCQ submission and completion queue pairs.
+
+``wb-max-size``, ``wb-min-size`` (default 0x400 and 0x100)
+  Maximum and minimum WriteBooster buffer size, in allocation units.
+  ``wb-min-size`` must not exceed ``wb-max-size``.
+
+Logical Unit Properties
+=======================
+
+``drive``
+  Backing block device.
+
+``lun`` (default 0)
+  Logical unit number, 0 to 31. A host controller accepts up to 32
+  logical units.
+
+Limitations
+===========
+
+* UniPro and M-PHY are not modelled. Only the UIC commands needed for
+  link startup, DME attribute access and hibernation are handled; DME
+  reads return fixed values, and DME writes, power mode changes and
+  hibernation do not change any link state.
+* UTP task management requests are not processed, so a guest that
+  tries to abort a command or reset a logical unit gets no completion.
+* The Boot and RPMB well-known logical units only answer basic SCSI
+  commands such as INQUIRY; boot and RPMB data access are not emulated.
+* The device cannot be migrated.
-- 
2.56.0.385.gd3acb90ef8-goog


