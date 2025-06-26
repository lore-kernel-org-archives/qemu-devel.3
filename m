Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCCFC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJv-00064H-5y; Thu, 26 Jun 2025 03:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJt-0005xH-FO
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJr-00022U-6G
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750924009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IErTZzC51n5Uhzt0ReIfXt+k26ISLRH++xMSba06ZjI=;
 b=iSbvGkXj+booGIY2gImmmDjaA5EhQL0ytOVFKYmlju+kCAoQDvrrSbCh76dpDKWygdJgMm
 vtSpweCdcmmlmuvRiFFVFjhW6Myv8flTgmpfFwXmIXtbMYN+veqAd6X9PYgqFUX6mD2krn
 cmVh7W8PJEZCgHtwyGh92FEO8Hs0SJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-2-fBjaM1PUevB3jQYYgVRA-1; Thu,
 26 Jun 2025 03:46:45 -0400
X-MC-Unique: 2-fBjaM1PUevB3jQYYgVRA-1
X-Mimecast-MFC-AGG-ID: 2-fBjaM1PUevB3jQYYgVRA_1750924004
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42D8718DA5CA; Thu, 26 Jun 2025 07:46:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3500D180045B; Thu, 26 Jun 2025 07:46:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/25] docs: add vfio-user documentation
Date: Thu, 26 Jun 2025 09:45:28 +0200
Message-ID: <20250626074529.1384114-25-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

Add some basic documentation on vfio-user usage.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-19-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/device-emulation.rst  |  1 +
 docs/system/devices/vfio-user.rst | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 docs/system/devices/vfio-user.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index a1b0d7997e04f781484a0d48085858f39ee17e35..911381643f1c617dca1021962bc4446dbec73ec1 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -85,6 +85,7 @@ Emulated Devices
    devices/can.rst
    devices/ccid.rst
    devices/cxl.rst
+   devices/vfio-user.rst
    devices/ivshmem.rst
    devices/ivshmem-flat.rst
    devices/keyboard.rst
diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
new file mode 100644
index 0000000000000000000000000000000000000000..b6dcaa5615e5354e80e63925f0a37537ca9e9371
--- /dev/null
+++ b/docs/system/devices/vfio-user.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=========
+vfio-user
+=========
+
+QEMU includes a ``vfio-user`` client. The ``vfio-user`` specification allows for
+implementing (PCI) devices in userspace outside of QEMU; it is similar to
+``vhost-user`` in this respect (see :doc:`vhost-user`), but can emulate arbitrary
+PCI devices, not just ``virtio``. Whereas ``vfio`` is handled by the host
+kernel, ``vfio-user``, while similar in implementation, is handled entirely in
+userspace.
+
+For example, SPDK includes a virtual PCI NVMe controller implementation; by
+setting up a ``vfio-user`` UNIX socket between QEMU and SPDK, a VM can send NVMe
+I/O to the SPDK process.
+
+Presuming a suitable ``vfio-user`` server has opened a socket at
+``/tmp/vfio-user.sock``, a device can be configured with for example:
+
+.. code-block:: console
+
+-device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
+
+See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
+information.
-- 
2.49.0


