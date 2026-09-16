Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D46C982CD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yHL-00037p-6P; Wed, 16 Sep 2026 18:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dxqragsKCrQhUgUhaofUncaiiafY.WigkYgo-XYpYfhihaho.ila@flex--namangulati.bounces.google.com>)
 id 1x6yHE-00036S-Ts
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:52 -0400
Received: from mail-qt1-x846.google.com ([2607:f8b0:4864:20::846])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dxqragsKCrQhUgUhaofUncaiiafY.WigkYgo-XYpYfhihaho.ila@flex--namangulati.bounces.google.com>)
 id 1x6yHC-0006zM-Bs
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:51 -0400
Received: by mail-qt1-x846.google.com with SMTP id
 d75a77b69052e-530f5e827c6so3013331cf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789598327; x=1790203127; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ofTJnNz39s39xGGcF18xN1v2YtrLJYeKv8kRZ+0FYAY=;
 b=QVBsZIklWEIQ3gj8bVF/5GLoShI0trujD+flvtOTsptY7ReaSYwq9j/6tBWUhk2mQB
 5FceJy+O072wlMtuR1NgC8NXgH5D+JLbuMcCIDCYK/IygI7k2tXNjVSjWJ5sAOohhGMO
 XeLzDcGJ3Hnujb5spzLAaYlXJqFNCmfOWd37CI/fpF06nMTtj8kTMrgJEvWTmzfMlcop
 jWFjdefW8GGOdQmRCtVYy8i1WnkcBYWHOlxGOxEwga2F0cHx2Qxo7GFFrYaQnD9TO4BB
 sc6OC0F9tItpCpRJTrCs3fErvzTPvUlAbpR+LSVIAwPxv/VNJjg77EGwZaXA91yK01h3
 3jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789598327; x=1790203127;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ofTJnNz39s39xGGcF18xN1v2YtrLJYeKv8kRZ+0FYAY=;
 b=B9L6789LgDivqRaEyOWk8G32yDY8eCrOMB0oBE1WfUshTIFugL/Qk0Kuf63LewHtKq
 1BbxqoZmoE8oFeJbF4hZ/ahG7h9gciiwKGU02+ORAKq+yl2Pvhi1Sdekkl8eJjdjVIrd
 Z5R8lsUgOANcU8Bzyh0c6JxBttG1WzQ/oUpVkEzeX0D3UAT2M2gMeNy7nOFkcCi7hWH1
 Gj27qrgdNOf0sDbgjnEEo+m8iSm/yI840YlbXs4VVl5aybZqucdVnYDeVo7NNiID0wpa
 RGpNzMH/TecUx2U9nwftCd0Z3Kd64AgimRHzWaMbndp395Ac4zb9K6kcB2VGSLNd4zCt
 N9hg==
X-Gm-Message-State: AFuF++mTcf4S/rNtdpLjqbb8uW5PwI+/ZeA+cpg8IfTslFi771KANxeD
 zNHFkZSHcKJ96TbeqfAhkX0lixgGGKVfAP65UiUQt/ynjhuNOtPgXcoaIkqrXOofOjcrQj2/rym
 HXS1Ay136bch1MQx+8sGX9oF6dIxwj/C8uE6DFIlLs+AoSRFB9LPKQNsFQXko/cB7NOY5ZSzgXK
 jBPDRN2M2Xh0j3/vu4cokZqXFcg068+QFEqa+LeDc8QqHM6vwt9TI0QLwGjWIJmA==
X-Received: from qtbli7-n2.prod.google.com
 ([2002:a05:622a:8447:20b0:532:8d89:9699])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2489:b0:531:11ac:23ce with SMTP id
 d75a77b69052e-5327f17c679mr67973611cf.49.1789598327132; 
 Wed, 16 Sep 2026 15:38:47 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:38:40 +0000
In-Reply-To: <20260916223843.3995552-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260916223843.3995552-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916223843.3995552-2-namangulati@google.com>
Subject: [PATCH v3 1/4] vfio-user: add multi-fd region mmap capability
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::846;
 envelope-from=3dxqragsKCrQhUgUhaofUncaiiafY.WigkYgo-XYpYfhihaho.ila@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x846.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Extend the vfio-user protocol specification to allow servers to pass
multiple file descriptors for different sparse memory areas within a
single device region with capability
VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS.

VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS defines an array of sparse mmap
areas where each area contains:
- offset: Start of the area within the device region (BAR).
- fd_offset: Start of the mapping within the backing file descriptor.
- size: Size of the mappable area.
- fd_index: Zero-based index into the array of file descriptors
  received in the SCM_RIGHTS ancillary data of the
  VFIO_USER_DEVICE_GET_REGION_INFO reply message.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 docs/interop/vfio-user.rst | 71 +++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 1c92f442d2..5744f58e31 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -125,7 +125,10 @@ Sparse Regions
 A region can be memory-mappable in whole or in part. When only a subset of a
 region can be mapped by the client, a ``VFIO_REGION_INFO_CAP_SPARSE_MMAP``
 capability is included in the region info reply. This capability describes
-which portions can be mapped by the client.
+which portions can be mapped by the client. When sparse mmap areas are backed
+by multiple distinct file descriptors, a
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` capability is included in the region
+info reply instead.
 
 .. Note::
    For example, in a virtual NVMe controller, sparse regions can be used so
@@ -859,9 +862,9 @@ Reply
   * ``VFIO_REGION_INFO_FLAG_READ`` allows client read access to the region.
   * ``VFIO_REGION_INFO_FLAG_WRITE`` allows client write access to the region.
   * ``VFIO_REGION_INFO_FLAG_MMAP`` specifies the client can mmap() the region.
-    When this flag is set, the reply will include a file descriptor in its
-    meta-data. On ``AF_UNIX`` sockets, the file descriptors will be passed as
-    ``SCM_RIGHTS`` type ancillary data.
+    When this flag is set, the reply will include one or more file descriptors
+    in its meta-data. On ``AF_UNIX`` sockets, the file descriptors will be passed
+    as ``SCM_RIGHTS`` type ancillary data.
   * ``VFIO_REGION_INFO_FLAG_CAPS`` indicates additional capabilities found in the
     reply.
 
@@ -950,6 +953,66 @@ The VFIO sparse mmap area is defined in ``<linux/vfio.h>`` (``struct
 vfio_region_info_cap_sparse_mmap``).
 
 
+VFIO sparse mmap fds cap header
+"""""""""""""""""""""""""""""""
+
++----------------------+--------------------------------------+
+| Name                 | Value                                |
++======================+======================================+
+| id                   | VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS |
++----------------------+--------------------------------------+
+| version              | 0x1                                  |
++----------------------+--------------------------------------+
+| next                 | <next>                               |
++----------------------+--------------------------------------+
+| sparse mmap fds info | VFIO region info sparse mmap fds     |
++----------------------+--------------------------------------+
+
+This capability is defined when a region supports direct access by the client
+via mmap() where different sparse mmap areas are backed by distinct file
+descriptors in the ``SCM_RIGHTS`` ancillary data array. Capability ID
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` is defined as 16 (0x10) to avoid
+clashing with kernel VFIO capabilities.
+
+VFIO region info cap sparse mmap fds
+""""""""""""""""""""""""""""""""""""
+
++-----------+--------+------+
+| Name      | Offset | Size |
++===========+========+======+
+| nr_areas  | 0      | 4    |
++-----------+--------+------+
+| reserved  | 4      | 4    |
++-----------+--------+------+
+| offset    | 8      | 8    |
++-----------+--------+------+
+| fd_offset | 16     | 8    |
++-----------+--------+------+
+| size      | 24     | 8    |
++-----------+--------+------+
+| fd_index  | 32     | 4    |
++-----------+--------+------+
+| pad       | 36     | 4    |
++-----------+--------+------+
+| ...       |        |      |
++-----------+--------+------+
+
+* *nr_areas* is the number of sparse mmap areas in the region.
+* *offset*, *fd_offset*, *size*, and *fd_index* describe a single area that can be
+  mapped by the client. There will be *nr_areas* tuples of offset, fd_offset, size,
+  fd_index, and pad.
+* *offset* specifies the start of the area within the device region (BAR).
+* *fd_offset* specifies the start of the mapping within the backing file descriptor
+  referenced by *fd_index*.
+* *fd_index* is the zero-based index into the array of file descriptors
+  received in the ``SCM_RIGHTS`` ancillary data of the
+  ``VFIO_USER_DEVICE_GET_REGION_INFO`` reply message.
+
+If all sparse mmap areas are backed by a single file descriptor, the server
+may instead send ``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` and exactly one file
+descriptor in ``SCM_RIGHTS`` for compatibility with older clients.
+
+
 ``VFIO_USER_DEVICE_GET_REGION_IO_FDS``
 --------------------------------------
 
-- 
2.55.0.1082.g2b9226bbc0-goog


