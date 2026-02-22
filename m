Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7850BC6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuARi-0007xT-JG; Sun, 22 Feb 2026 09:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARd-0007xA-0z
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARb-0006eV-H2
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbcvBNqbzFwjNeD7oZ2DnxvwurhyiDZl0WS2Ou2JOJE=;
 b=P9Mrrg0ANqp0ZigMQ65q3koXenvxLySBF3WHxI/blm4sBVXutHailnnfxbO2lrANC5QGnN
 ZlGGEyp2O5N2FldKzhi2YKC6owr9cUmbtZkzdr9m6jYoBrCPLLanjAK+mEN6e7VwtEVUlO
 iDVxFVkCLNDPrIQlAp6t8MbrKLNbB4E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-lT6AtbM_PxyYXtUVpr2qMg-1; Sun, 22 Feb 2026 09:28:21 -0500
X-MC-Unique: lT6AtbM_PxyYXtUVpr2qMg-1
X-Mimecast-MFC-AGG-ID: lT6AtbM_PxyYXtUVpr2qMg_1771770500
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48079ae1001so6108915e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770500; x=1772375300; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QbcvBNqbzFwjNeD7oZ2DnxvwurhyiDZl0WS2Ou2JOJE=;
 b=KLhH5PtN0BVHkBJgaFxNh9y7xNDJMUvATH+DlwbYeIrd/Erc0Zw6gN5ZSuHQEqQQdL
 M8POpYAfEHNatKLfedmDKbKTx4DvZjKSp0AASRmdPSjACMKoc9dt/f4bgMKX9roYf8pH
 BMXF2lkU1wyGfd+qOFitAFZgUHal9hwOM6+s4wmqhdhnZynJnO1dF3qSAa5KSJAXppN4
 pfBILlx5iWQrlmXK7p0R2OPqpHnbKVs0+VwNIsXI21Qx8mH0WKormKFmg/3L8i+MEfx9
 hQQvq0F879YvoJFZ9StxYkbqijyJQ7v+c43UDImRSzSCCYnMi9wX0brPBX8NBcNLE5QQ
 7KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770500; x=1772375300;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QbcvBNqbzFwjNeD7oZ2DnxvwurhyiDZl0WS2Ou2JOJE=;
 b=WDwi/5a0PCUU9MB1THrw8SUL6+gpaD2hMXIsqftcWy7vTG0gibcHlUul21XYbnYNNh
 j66nLTxUbKQKhMiLiEcM2mfXe3dwGuP1qg47u+hBlSG2fqMGhVgM6JSuvbDmMSwTLF0N
 tJSCkjxgaJTDyToFrK18KNnE/bFVtqfq/dsqo7ZbalXqtQzFSHy0itD0bwk5rXL/79hX
 aPYcQrwQZa8FVP3KokTlFHUIxjXG4aRq350aM6ZsmR7BPdRPURqsa4VVytO9shz4jO1F
 5L5pGxn9iEcDNBZHPv6WfoRC2c0OyGgiMJ7byFYxS/DDEZ1OdFcTXqoO5Qh0q5clBRv3
 2h+g==
X-Gm-Message-State: AOJu0YzJseWut6nz8skBNjDlYLD+VXDfixFi0zge9MqMy6O5nzgRwMOa
 Ez7yeRFeIIA3wRr0TMOlOAFuSbmLQ3h3XQWHHVfYK8CKqC2WtBAUMAxqAg7w/DKCxJIeFnscm/m
 tzr/qaxolZ4eyAJ2+B6xfXBV4luG/OnPJ8ivnk8hCCfPhzEfwBRpqWB0yd2I3mvoipB8xu5ylfI
 eeBlWJRLmTld/cYgR2lz65EXr1kNXQF8pIew==
X-Gm-Gg: AZuq6aJUu/jE60ryrJJHBjHcmktEz5bCgSndLuGSVMr+kqzUd8aaUEd0ehsWj9urBR4
 eFPgTlJOCcnzEP0Skhy34laxCSHDFxFsHhRriBWva6HlFcFwLI/m06SHhsgK0Ie+ewLDys+ploF
 tdZsDFFHeGU29XpeA6SruorlKARAAQkzE0+f3ifZU0m0v3FU0sJ1+FjSoKyQsjVlR4bNvYxtAcu
 t894HjbUAs3abCT5WZE8/cKfEjrR1nH2CvEZpsf4QdtxTZV1JQJ+hyNWdvy/3OlnhIX7BfjWx41
 bljoOTWmz+e8dFDjgN7vWBDcXy8Cbdmi4OodplUiSklx3nMSG2WlOIq4hhcmGbK1vbHSibEAHqG
 Q2rHcCsS3x0/HryPC5ubpg6h/mEHUA7L3rZRfzR7cvNVp7Q==
X-Received: by 2002:a05:6000:2485:b0:435:9cd5:bb2a with SMTP id
 ffacd0b85a97d-4396f15bd9cmr10795069f8f.24.1771770499530; 
 Sun, 22 Feb 2026 06:28:19 -0800 (PST)
X-Received: by 2002:a05:6000:2485:b0:435:9cd5:bb2a with SMTP id
 ffacd0b85a97d-4396f15bd9cmr10795011f8f.24.1771770498845; 
 Sun, 22 Feb 2026 06:28:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4cc81sm11791946f8f.26.2026.02.22.06.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:18 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/33] tests/vhost-user-bridge: Move to
 contrib/vhost-user-bridge/
Message-ID: <42d2c1cc9e89b77f1287ed433c655bc9e98bdc41.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

After the introduction of vhost-user-bridge and libvhost-user, we
formed the convention of placing vhost-user daemons in eponymous subdirs
of contrib/. Follow this convention.

Create a contrib/vhost-user-bridge/ directory and move vhost-user-bridge
into it. Extract its build target definition from tests/meson.build into
the new directory, and include its subdir in the root-level meson.build.

Add a section about it in the "vhost-user daemons in contrib" document.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260129133049.119829-2-yodel.eldar@yodel.dev>
---
 contrib/vhost-user-bridge/meson.build         |  4 ++
 .../vhost-user-bridge}/vhost-user-bridge.c    |  0
 .../devices/virtio/vhost-user-contrib.rst     | 39 +++++++++++++++++++
 meson.build                                   |  1 +
 tests/meson.build                             |  6 ---
 5 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 contrib/vhost-user-bridge/meson.build
 rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (100%)

diff --git a/contrib/vhost-user-bridge/meson.build b/contrib/vhost-user-bridge/meson.build
new file mode 100644
index 0000000000..aa58c1df20
--- /dev/null
+++ b/contrib/vhost-user-bridge/meson.build
@@ -0,0 +1,4 @@
+if have_tools and have_vhost_user and host_os == 'linux'
+  executable('vhost-user-bridge', files('vhost-user-bridge.c'),
+             dependencies: [qemuutil, vhost_user], install: false)
+endif
diff --git a/tests/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-user-bridge.c
similarity index 100%
rename from tests/vhost-user-bridge.c
rename to contrib/vhost-user-bridge/vhost-user-bridge.c
diff --git a/docs/system/devices/virtio/vhost-user-contrib.rst b/docs/system/devices/virtio/vhost-user-contrib.rst
index 48d04d2ade..660d29a700 100644
--- a/docs/system/devices/virtio/vhost-user-contrib.rst
+++ b/docs/system/devices/virtio/vhost-user-contrib.rst
@@ -85,3 +85,42 @@ vhost-user-scsi - SCSI controller
 
 The vhost-user-scsi daemon can proxy iSCSI devices onto a virtualized
 SCSI controller.
+
+.. _vhost_user_bridge:
+
+vhost-user-bridge - Network bridge
+==================================
+
+The vhost-user-bridge daemon serves as a development tool for testing real
+internet traffic by providing a networking backend, i.e. server, for the
+vhost-user protocol.
+
+Example
+-------
+For a single QEMU instance that both runs the user-mode net stack (slirp) and
+serves as a vhost-user protocol frontend, i.e. client, simultaneously:
+
+First, start vhost-user-bridge:
+
+::
+
+  $ vhost-user-bridge -u /tmp/vubr.sock \
+                      -l 127.0.0.1:4444 \
+                      -r 127.0.0.1:5555
+
+Then, invoke QEMU:
+
+::
+
+  $ qemu-system-x86_64 \
+        -m 4G \
+        -object memory-backend-memfd,id=mem0,size=4G,share=on,prealloc=on \
+        -numa node,memdev=mem0 \
+        -chardev socket,id=char0,path=/tmp/vubr.sock \
+        -netdev vhost-user,id=vhost0,chardev=char0,vhostforce=on \
+        -device virtio-net-pci,netdev=vhost0 \
+        -netdev socket,id=udp0,udp=localhost:4444,localaddr=localhost:5555 \
+        -netdev user,id=user0 \
+        -netdev hubport,id=hub0,hubid=0,netdev=udp0 \
+        -netdev hubport,id=hub1,hubid=0,netdev=user0 \
+        ...
diff --git a/meson.build b/meson.build
index 4af32c3e1f..620b2ad903 100644
--- a/meson.build
+++ b/meson.build
@@ -4504,6 +4504,7 @@ if have_tools
 
   if have_vhost_user
     subdir('contrib/vhost-user-blk')
+    subdir('contrib/vhost-user-bridge')
     subdir('contrib/vhost-user-gpu')
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
diff --git a/tests/meson.build b/tests/meson.build
index cbe7916241..87861b2857 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -70,12 +70,6 @@ test_deps = {
   'test-qht-par': qht_bench,
 }
 
-if have_tools and have_vhost_user and host_os == 'linux'
-  executable('vhost-user-bridge',
-             sources: files('vhost-user-bridge.c'),
-             dependencies: [qemuutil, vhost_user])
-endif
-
 subdir('decode')
 
 if 'CONFIG_TCG' in config_all_accel
-- 
MST


