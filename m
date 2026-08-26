Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31206C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5ky-0002jb-0U; Wed, 26 Aug 2026 01:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3AXOOagsKCnwsfrfslzqfynlttlqj.htrvjrz-ij0jqstslsz.twl@flex--namangulati.bounces.google.com>)
 id 1wz5ks-0002iS-Cl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:00:54 -0400
Received: from mail-qk1-x747.google.com ([2607:f8b0:4864:20::747])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3AXOOagsKCnwsfrfslzqfynlttlqj.htrvjrz-ij0jqstslsz.twl@flex--namangulati.bounces.google.com>)
 id 1wz5kq-0003sX-75
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:00:53 -0400
Received: by mail-qk1-x747.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so51049985a.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 22:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787720450; x=1788325250; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jJZqG8fc901hWJs08nmGGzzLEXEJU/5Q9OPlRQKLan4=;
 b=jSisrcfrsrlrR4Nuvgnyxvlrp5aa5IDocT1MYafR0OLbtiBWLUjHBXhWyoVCgjejLE
 akLoZqYzR0ChlKltWsvVTUSLhlGuYyum1LuElBXpX1Tv0Gl8QFvB+vgvbAWS+FJeIhCu
 NKuEwPC4d69yQfp04deQJ7AMMheWEotOFTFyxWlZ7hHsAVobsGxOQ21t++OsTG2cUvrE
 mTewHAmls+8AbA9fCDUjU9ePFBoMMvM3moubhRA4p35KQEdIWRp0rDIoK9R18RbEPERW
 bDS+nrbyyT9C1iAwM4T8rfKfSOaFa6WUS9QxdDGI/9GcbTHu3WsnLyDPav1aCANf9A+s
 QBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787720450; x=1788325250;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jJZqG8fc901hWJs08nmGGzzLEXEJU/5Q9OPlRQKLan4=;
 b=eHK+uWgeJ08DQCW1Sxnwhx6cJF634O61yXaKZyHLBmc1LEtrtIX1eIj7q+FyUk4/Lb
 PQDlODShS7HRuUdaS74/bgzLJ6QWAXPOig4ye0izEB9ueZHeSxfNHamBf0yKsaAVkR95
 ihWtDjj5bF6Hy4Mg5LTA1EyjtGQYBQSwXQ0MBqKqilzhLGPaGP0nDh1QCXZer86u5luQ
 CTDX4Y88DKrIqlMn9gwvqNJRIkebpU0uQcqhtUjm+jWaEfaLvIOZ+2mtCUCl4bYglyiU
 J7wQtM327tjW8LhE3FjnqHpQsr4P9Zu20qBIaBd+u3AwYzl+tVW35oMyod+Pp804S3zr
 csbQ==
X-Gm-Message-State: AFuF++mEfqTXXYMy/bNX6dJ1+b1ZcvO476aPZuLAknI2soDxTVGPOxlV
 kNdxivc0zBGHFeYMXjiDnq/hCTJ33LDYB0C+Rp7yUrj1GyTukJpK1WywolMgnKJX4ApQyQzSF7P
 jBksn/Fc6yIr2GZ+PRy2OjntyATfLIJoVS9SDMRxAFnu1u8jH+YzRIBypdDW+TdEUBaI1CEzCCw
 nHh8Xts9JG+IDfBgvRZf5Ei5KQa62Ogn/Ot9bNGn+iemyJA1FYusI+zv4X9a/wIQ==
X-Received: from qknwg19.prod.google.com
 ([2002:a05:620a:5693:b0:936:db3c:c8b0])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:480a:b0:915:9e84:85d1 with SMTP id
 af79cd13be357-937803e5042mr352226485a.23.1787720449833; 
 Tue, 25 Aug 2026 22:00:49 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:00:37 +0000
In-Reply-To: <20260826050039.2068138-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260826050039.2068138-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826050039.2068138-2-namangulati@google.com>
Subject: [PATCH v2 1/3] vfio-user: add multi-fd region mmap capability
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::747;
 envelope-from=3AXOOagsKCnwsfrfslzqfynlttlqj.htrvjrz-ij0jqstslsz.twl@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x747.google.com
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
2.55.0.860.g4b6b3295ed-goog


