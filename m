Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BE9C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDD7-0008Q1-Ly; Wed, 14 Feb 2024 06:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDD3-0008NF-VN
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDD2-0006jb-5h
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPFXPFy/mnGFMSxq5GRTraSFwMu/Y3VYl/4w4KYs38Y=;
 b=NsJNnWiOWEd8Cmfv08R0FbFwhbB/371p7NQjfsfdwBvnIWO3DONL+8I/4QybyV7n/6MuHh
 atLNrh+Gy6sGCcHAUGvy0YnptgD1yp1jK22471Z9lbt7x+OGMmgWUnGnHWtawjoqkfTkhM
 l/JrarxfhEOb/8sVvTofOua/sV/vYqA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-q7oERDwdOE65AIFbH8GNGg-1; Wed, 14 Feb 2024 06:13:46 -0500
X-MC-Unique: q7oERDwdOE65AIFbH8GNGg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51151b8de86so5087045e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909224; x=1708514024;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPFXPFy/mnGFMSxq5GRTraSFwMu/Y3VYl/4w4KYs38Y=;
 b=lfVDmd25k0kHlNi/274sNLXGPp8IGfWYJKOgJCSLQPTeFPaqQyLLfeHsfRqmu1llv+
 MGIF2CnvR59onp3i5X3bVKZSN+YChfBvon5EdjlnH7cZCll3ivoQxXqYq/I1GG/G+UKF
 xUsm7zFug2JNJOciuo3eo5AMTRDx2dvkPksGQt99oAP/5CtyMF3oueE63taps5v1ZZDV
 U11K6wgHC4y4SnTFP4hAQkkrd+An/LdybtRQTsGb+w4Vgtx+2qmb22BmbQZCs/mWFvka
 U6FG3CfU/1M4Dauw9Vhs5/QKrokFYm+R9HaDo/jLI5TygUJt3dlEFj9rDNOAD+gZNYO0
 95KA==
X-Gm-Message-State: AOJu0YzAB65KEgvwNFtM+p/wBlW139CADRlrSSWyxbHv1rxkzXn8eaYc
 xpSRqWwC8QvmdOPgo9HvR/ektRZJxpehHBNVtQ437DnkgVKG2aRjqDAgcGjp5O6OqZm6wRQgfkL
 BDca9xa6HVaZ37ZCIu1P6zYg94prFu/kAtUWSjKHC+1jQSz54j4TdWM7J1zcZfN/iyKINjXUjHO
 MVbBkYPrFhxFtzlhRZzpzNmqeJxjEBBQ==
X-Received: by 2002:ac2:4c02:0:b0:511:5314:1762 with SMTP id
 t2-20020ac24c02000000b0051153141762mr1509677lfq.44.1707909223850; 
 Wed, 14 Feb 2024 03:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQwsL9VzwPPQNpQdcQwvWYthUtJDDzJLDJD1r4h5fUxNFVRgCoPTY3ZUFMxjLQphf8oKB0qQ==
X-Received: by 2002:ac2:4c02:0:b0:511:5314:1762 with SMTP id
 t2-20020ac24c02000000b0051153141762mr1509664lfq.44.1707909223438; 
 Wed, 14 Feb 2024 03:13:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVWG68j22UBZyG3Y/MP8+57fE7YZ+QNtYcHKP4qw+AxkSR2QtastNpGVzm/6FYvihicsok3tTl9Djvrqz9/iOZ8MJLERukfez6JnLuSLuxKVsHTKZfYSYkqvRlyvDASixLekff1VRWGsXchUonc
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 en14-20020a056402528e00b0055fef53460bsm4592878edb.0.2024.02.14.03.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:42 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 09/60] docs/system: Add vhost-user-input documentation
Message-ID: <887d5775863b8804bacba6fe1a860ed3ea5cfdd9.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Leo Yan <leo.yan@linaro.org>

This adds basic documentation for vhost-user-input.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Message-Id: <20231120043721.50555-3-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240104210945.1223134-10-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS                              |  1 +
 docs/system/device-emulation.rst         |  1 +
 docs/system/devices/vhost-user-input.rst | 45 ++++++++++++++++++++++++
 docs/system/devices/vhost-user.rst       |  4 ++-
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index aff5342cb4..66c9e81c55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2289,6 +2289,7 @@ L: virtio-fs@lists.linux.dev
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
+F: docs/system/devices/vhost-user-input.rst
 F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index d1f3277cb0..f19777411c 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -94,6 +94,7 @@ Emulated Devices
    devices/virtio-gpu.rst
    devices/virtio-pmem.rst
    devices/virtio-snd.rst
+   devices/vhost-user-input.rst
    devices/vhost-user-rng.rst
    devices/canokey.rst
    devices/usb-u2f.rst
diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devices/vhost-user-input.rst
new file mode 100644
index 0000000000..118eb78101
--- /dev/null
+++ b/docs/system/devices/vhost-user-input.rst
@@ -0,0 +1,45 @@
+.. _vhost_user_input:
+
+QEMU vhost-user-input - Input emulation
+=======================================
+
+This document describes the setup and usage of the Virtio input device.
+The Virtio input device is a paravirtualized device for input events.
+
+Description
+-----------
+
+The vhost-user-input device implementation was designed to work with a daemon
+polling on input devices and passes input events to the guest.
+
+QEMU provides a backend implementation in contrib/vhost-user-input.
+
+Linux kernel support
+--------------------
+
+Virtio input requires a guest Linux kernel built with the
+``CONFIG_VIRTIO_INPUT`` option.
+
+Examples
+--------
+
+The backend daemon should be started first:
+
+::
+
+  host# vhost-user-input --socket-path=input.sock	\
+      --evdev-path=/dev/input/event17
+
+The QEMU invocation needs to create a chardev socket to communicate with the
+backend daemon and access the VirtIO queues with the guest over the
+:ref:`shared memory <shared_memory_object>`.
+
+::
+
+  host# qemu-system								\
+      -chardev socket,path=/tmp/input.sock,id=mouse0				\
+      -device vhost-user-input-pci,chardev=mouse0				\
+      -m 4096 									\
+      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on	\
+      -numa node,memdev=mem							\
+      ...
diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index c6afc4836f..9b2da106ce 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -42,7 +42,7 @@ platform details for what sort of virtio bus to use.
     - See https://github.com/rust-vmm/vhost-device
   * - vhost-user-input
     - Generic input driver
-    - See contrib/vhost-user-input
+    - :ref:`vhost_user_input`
   * - vhost-user-rng
     - Entropy driver
     - :ref:`vhost_user_rng`
@@ -91,6 +91,8 @@ following the :ref:`vhost_user_proto`. There are a number of daemons
 that can be built when enabled by the project although any daemon that
 meets the specification for a given device can be used.
 
+.. _shared_memory_object:
+
 Shared memory object
 ====================
 
-- 
MST


