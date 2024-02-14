Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1610CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDD4-0008Nk-M2; Wed, 14 Feb 2024 06:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCz-0008K1-AD
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCw-0006ih-7h
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QCQCVR6jtXXAjpCojfp7A6N/bol4CbLlxWu9xFsRU4=;
 b=BuTkjKCAEP5qB0I2C/GOO+iY6WsYRi59sQgaKZlPLwokns6+IcV6X0DWEN575sDrzKPPIQ
 63J/adWbQJYtH7AuH9SRbbAGIxGJCf5/cBOo7J8uHIMRc/3md5voBTHtRCPU4zYw4GDdNu
 DhQA6Rzma57e/pAIs2n5iI/9GgOeyVA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355--h3i6bQXP5-1Cv83oHOtyw-1; Wed, 14 Feb 2024 06:13:39 -0500
X-MC-Unique: -h3i6bQXP5-1Cv83oHOtyw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51197d1fcc2so1641518e87.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909218; x=1708514018;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5QCQCVR6jtXXAjpCojfp7A6N/bol4CbLlxWu9xFsRU4=;
 b=seb+8rNcGDcYWw5qXHxwBp3ANDNrpsf2lJ9ttUJs5GFl6bFcs+nFvhUHcSmL8lFZ3z
 yZCyXih9qgpFcpABR2I8WuX5Ge7NHkw+jH2pT73sHhi7j7cj51XEItChy//ZZpjmiGGg
 P+0v31WO73WPbYiIXlE2zs5WmOV+F8RQUCNpfZlIDOFPbxcWDg+zdCc5fW4j8nR3ULff
 uao2Jcu23leC4o94YtM0pkrN1q3qr9vDxbefAnSIB9EtAltdxLax5n9SohjHWpwJ7XHc
 jNPGceCcTE1huwW31nILmg5cMAsldTQ+NEdCaXlLDNRkNk9TOKpgr107C3nbsHz2PgLu
 qPag==
X-Gm-Message-State: AOJu0Yx+YlNMlDxFy74p8JSD2NrCXFqbHA8wt9hkpG5gc6WfJKrGuZgi
 d1b6ihq9VhAC8L3iSlGmquLNGNjIwIPU/V7m8X7PmwX+yt1YUS3zdkiinK4i/OnP7OLjgfeuS0M
 bhsXoAErfaCQOjepyVRKsJj1YBm9qc9qlEUAQu/IyrUdtX0NAfa0JbUm1J7twvJsPlrq4HYcAsM
 swTG5iH1iqydtkQR6PsmteMmD11EifRQ==
X-Received: by 2002:ac2:5f8a:0:b0:511:490e:b8fd with SMTP id
 r10-20020ac25f8a000000b00511490eb8fdmr1544597lfe.45.1707909218069; 
 Wed, 14 Feb 2024 03:13:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ6rqCEgjfsz8sWfs9Jz8ED5pDc0lQhQSywflvRZevy6HrAvfr7fWEOfC3rCvquH0azYgf1w==
X-Received: by 2002:ac2:5f8a:0:b0:511:490e:b8fd with SMTP id
 r10-20020ac25f8a000000b00511490eb8fdmr1544578lfe.45.1707909217691; 
 Wed, 14 Feb 2024 03:13:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVYlb7bwPA6uMGeGkuP/7gMQIYRWVuhYk2bkkMZe7m1/YaZgX7QvPMTcg8JIKF3Bq0oLe7EmMEeA8DTA0hJxwtl/0DX4CmitOeJIMXgq4rBuXp4c6qU3BkZNFxNE0OQZErjKg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 vv3-20020a170907a68300b00a3d42c54e48sm518625ejc.153.2024.02.14.03.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:37 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PULL 07/60] docs/system: add a basic enumeration of vhost-user
 devices
Message-ID: <e7fe912276c0b5859404327b6ab9ce332a2a887b.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

Make it clear the vhost-user-device is intended for expert use only.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240104210945.1223134-8-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/system/devices/vhost-user-rng.rst |  2 +
 docs/system/devices/vhost-user.rst     | 70 +++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/vhost-user-rng.rst b/docs/system/devices/vhost-user-rng.rst
index a145d4105c..ead1405326 100644
--- a/docs/system/devices/vhost-user-rng.rst
+++ b/docs/system/devices/vhost-user-rng.rst
@@ -1,3 +1,5 @@
+.. _vhost_user_rng:
+
 QEMU vhost-user-rng - RNG emulation
 ===================================
 
diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index a80e95a48a..c6afc4836f 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -8,13 +8,81 @@ outside of QEMU itself. To do this there are a number of things
 required.
 
 vhost-user device
-===================
+=================
 
 These are simple stub devices that ensure the VirtIO device is visible
 to the guest. The code is mostly boilerplate although each device has
 a ``chardev`` option which specifies the ID of the ``--chardev``
 device that connects via a socket to the vhost-user *daemon*.
 
+Each device will have an virtio-mmio and virtio-pci variant. See your
+platform details for what sort of virtio bus to use.
+
+.. list-table:: vhost-user devices
+  :widths: 20 20 60
+  :header-rows: 1
+
+  * - Device
+    - Type
+    - Notes
+  * - vhost-user-blk
+    - Block storage
+    - See contrib/vhost-user-blk
+  * - vhost-user-fs
+    - File based storage driver
+    - See https://gitlab.com/virtio-fs/virtiofsd
+  * - vhost-user-gpio
+    - Proxy gpio pins to host
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-gpu
+    - GPU driver
+    - See contrib/vhost-user-gpu
+  * - vhost-user-i2c
+    - Proxy i2c devices to host
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-input
+    - Generic input driver
+    - See contrib/vhost-user-input
+  * - vhost-user-rng
+    - Entropy driver
+    - :ref:`vhost_user_rng`
+  * - vhost-user-scmi
+    - System Control and Management Interface
+    - See https://github.com/rust-vmm/vhost-device
+  * - vhost-user-snd
+    - Audio device
+    - See https://github.com/rust-vmm/vhost-device/staging
+  * - vhost-user-scsi
+    - SCSI based storage
+    - See contrib/vhost-user-scsi
+  * - vhost-user-vsock
+    - Socket based communication
+    - See https://github.com/rust-vmm/vhost-device
+
+The referenced *daemons* are not exhaustive, any conforming backend
+implementing the device and using the vhost-user protocol should work.
+
+vhost-user-device
+^^^^^^^^^^^^^^^^^
+
+The vhost-user-device is a generic development device intended for
+expert use while developing new backends. The user needs to specify
+all the required parameters including:
+
+  - Device ``virtio-id``
+  - The ``num_vqs`` it needs and their ``vq_size``
+  - The ``config_size`` if needed
+
+.. note::
+  To prevent user confusion you cannot currently instantiate
+  vhost-user-device without first patching out::
+
+    /* Reason: stop inexperienced users confusing themselves */
+    dc->user_creatable = false;
+
+  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
+  rebuilding.
+
 vhost-user daemon
 =================
 
-- 
MST


