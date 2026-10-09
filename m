Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296CBCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFEnG-0000WE-UO; Fri, 09 Oct 2026 13:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LSrJagsKCgQreqerkypexmksskpi.gsquiqy-hiziprsrkry.svk@flex--namangulati.bounces.google.com>)
 id 1xFEn3-0000UV-VW
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:54 -0400
Received: from mail-qt1-x847.google.com ([2607:f8b0:4864:20::847])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LSrJagsKCgQreqerkypexmksskpi.gsquiqy-hiziprsrkry.svk@flex--namangulati.bounces.google.com>)
 id 1xFEn1-0006F9-Vm
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:53 -0400
Received: by mail-qt1-x847.google.com with SMTP id
 d75a77b69052e-532f343a55bso113570111cf.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791568430; x=1792173230; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uJhji8KzI8trzCpun7JOSJlJxfJog9XiC3iPL51zwpg=;
 b=Cjtsv7vEpKEfSWt7X8KWDzPEDqEyGOICL0sJWLcOsrQqnhH4XXcbtAwPcEL96L9opo
 ftkJcOMYqfz4l2hcodUyilRuOKbC86boZuTsgL9xQsM/pqags9qIe6B56b5WwDSeff5W
 nDOGnfkuhXCBCr9MD/LZXwFrCeJJjmHVuCDD1hzwOq7nzEVlb6J88BQunb3JeHtaf7TG
 pF1o2PWg0tJRrQGuYsrrAADrctRbFx6eqXa2N+Dvwy/N0y9IOuuh/3e+GzIrjpwg8tc8
 QEe5dM0z1xlqarHbl5iXxvWRHS71Jpo8uolaKs5XNRjW0XrfMHC7Ij1LARIV2NeAopoI
 5yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791568430; x=1792173230;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uJhji8KzI8trzCpun7JOSJlJxfJog9XiC3iPL51zwpg=;
 b=iPdOEDagO1gkarDtiHO6QaYTEcvIXBzZ6gGeKz/q6oZzmKiU9D7hE7+77mjw3gHpMY
 UVFFXsBDv/IGtL/OBKdIILXrffl6eJFMeih5ST6Rs8TF46HYXT5GDCHBXopC9D6k6qG3
 /kwoas4CBoGB9UQJ4b62pmhpkAFnlkXQCMOyhiqTuGQa9brqyV3YfMSKy0V3mGIez0Z0
 Svxq37eaHUHtYgotbjnEOvwlToCTYWjK9f+B0Isolj6HMugYvyXO3xjkMJ8CS00IqiAe
 JD67xGWKa4TxwvfN6LTBtp522izxHSNaLcojSqgxPcWFcXCcmc5Swhmv9O0CfztUbhzM
 viEA==
X-Gm-Message-State: AFuF++ndXO1vZZJxKJXvg1mL8xcuyi689FsOQNIClogIrMr1Pc9W4dyi
 Bm2m5plJ7cnbg/oyUY+UPa+NNOWf1FGoe1fj31IP2acpsuD7alJU0Bn6kQgY8aTFwgYv9kBuPz5
 KBldMNZ5v10zH724bAmQdOVdayHTwVkmSAcIqk+P7fft2vtsa8mMTXwuwHwanl8Hi5Drr8qaZSz
 nJ2ndr3SSfdwBKxMpA6eb4cBOFSqgPzTTp/u2V99WVDEUz6eklWwQrV8z2y3iBaQ==
X-Received: from qtoh12.prod.google.com ([2002:ac8:46cc:0:b0:532:a6a3:7aae])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:345:b0:535:23ee:eb7f with SMTP id
 d75a77b69052e-5359f460649mr47447291cf.1.1791568429266; 
 Fri, 09 Oct 2026 10:53:49 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:53:11 +0000
In-Reply-To: <20261009175314.1823347-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261009175314.1823347-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009175314.1823347-2-namangulati@google.com>
Subject: [PATCH v4 1/4] vfio-user: add multi-fd region mmap capability
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::847;
 envelope-from=3LSrJagsKCgQreqerkypexmksskpi.gsquiqy-hiziprsrkry.svk@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x847.google.com
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
VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS (0x8001), negotiated via the
"sparse_mmap_fds"
capability in VFIO_USER_VERSION.

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
 docs/interop/vfio-user.rst | 86 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 1c92f442d2..b49781a755 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -125,7 +125,13 @@ Sparse Regions
 A region can be memory-mappable in whole or in part. When only a subset of a
 region can be mapped by the client, a ``VFIO_REGION_INFO_CAP_SPARSE_MMAP``
 capability is included in the region info reply. This capability describes
-which portions can be mapped by the client.
+which portions can be mapped by the client. When sparse mmap areas are backed
+by multiple distinct file descriptors, a
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` capability is included in the region
+info reply instead. ``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` and
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` cannot both be specified for the same
+region; however, different regions of a device may independently use either
+capability.
 
 .. Note::
    For example, in a virtual NVMe controller, sparse regions can be used so
@@ -536,6 +542,10 @@ Capabilities:
 | write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
 |                    |         | are supported if the value is ``true``.       |
 +--------------------+---------+-----------------------------------------------+
+| sparse_mmap_fds    | boolean | ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS``      |
+|                    |         | capability is supported if the value is       |
+|                    |         | ``true``.                                     |
++--------------------+---------+-----------------------------------------------+
 
 The ``twin_socket`` capability object holds these name/value pairs:
 
@@ -859,9 +869,11 @@ Reply
   * ``VFIO_REGION_INFO_FLAG_READ`` allows client read access to the region.
   * ``VFIO_REGION_INFO_FLAG_WRITE`` allows client write access to the region.
   * ``VFIO_REGION_INFO_FLAG_MMAP`` specifies the client can mmap() the region.
-    When this flag is set, the reply will include a file descriptor in its
-    meta-data. On ``AF_UNIX`` sockets, the file descriptors will be passed as
-    ``SCM_RIGHTS`` type ancillary data.
+    When this flag is set, the reply will include one or more file descriptors
+    in its meta-data (up to the number of sparse mmap areas when
+    ``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` is present, or a single file
+    descriptor otherwise). On ``AF_UNIX`` sockets, the file descriptors will be
+    passed as ``SCM_RIGHTS`` type ancillary data.
   * ``VFIO_REGION_INFO_FLAG_CAPS`` indicates additional capabilities found in the
     reply.
 
@@ -950,6 +962,72 @@ The VFIO sparse mmap area is defined in ``<linux/vfio.h>`` (``struct
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
+descriptors in the ``SCM_RIGHTS`` ancillary data array. The server may only
+include this capability if the client advertised ``sparse_mmap_fds`` as
+``true`` in ``VFIO_USER_VERSION``. Capability ID
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS`` is defined as ``0x8001`` to avoid
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
+  fd_index, and pad. Sparse mmap areas must not overlap.
+* *offset* specifies the start of the area within the device region (BAR).
+* *fd_offset* specifies the start of the mapping within the backing file descriptor
+  referenced by *fd_index*.
+* *size* specifies the size of the area. Zero-sized areas (*size* equal to 0)
+  are not permitted, and *offset* + *size* must not exceed the region *size*.
+* *fd_index* is the zero-based index into the array of file descriptors
+  received in the ``SCM_RIGHTS`` ancillary data of the
+  ``VFIO_USER_DEVICE_GET_REGION_INFO`` reply message. The number of file
+  descriptors sent in ``SCM_RIGHTS`` must be at least 1 and must not exceed
+  *nr_areas*.
+
+If all sparse mmap areas are backed by a single file descriptor, the server
+may instead send ``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` and exactly one file
+descriptor in ``SCM_RIGHTS`` for compatibility with older clients.
+
+
 ``VFIO_USER_DEVICE_GET_REGION_IO_FDS``
 --------------------------------------
 
-- 
2.56.0.385.gd3acb90ef8-goog


