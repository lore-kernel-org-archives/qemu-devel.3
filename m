Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9082606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SVko7xWv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKNuq-0006eG-Ro; Fri, 23 Oct 2026 18:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3C-LbagsKCpwJ6I6JCQH6PECKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--namangulati.bounces.google.com>)
 id 1xKNup-0006e1-Sq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:11 -0400
Received: from mail-qv1-xf45.google.com ([2607:f8b0:4864:20::f45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3C-LbagsKCpwJ6I6JCQH6PECKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--namangulati.bounces.google.com>)
 id 1xKNun-0002le-V2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:11 -0400
Received: by mail-qv1-xf45.google.com with SMTP id
 6a1803df08f44-917a7fffbe0so30112966d6.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792795148; x=1793399948; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bj9I7NS/Mbo1XKKLr845QtWiXSncejy2rSX4zZ1ZuzE=;
 b=SVko7xWvpeYVJvZrzcDK278dvHIfrtq7jpl3sw9nSkIdO4HU0rcSOj/WB+qvAnmdgt
 acPjRR+/sV6CqQ2F60yRV4sMQkgKn6j+kS+UaPVmdIeb+s++KZGdTvvOymToG6/KQwUm
 xAZ+WPb54C/LwJE0Fy2hxQl+LBKzsArw7z7rkyzqBDKt+23cIb2DrtG/5eBwCbL8rcgV
 XAOFOpU+j3AYlVnS7QpRifVI38hUJltthHMQLpGjk87TD0m2KM54h2wPYXnkhYRc2I3P
 b9ij6eU3qPauYAtx+4ujlnNNPdL8bhd/CzlvL83W1ZFgKyAPm0u/7CMG2LAkBUWpQtfO
 EsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792795148; x=1793399948;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bj9I7NS/Mbo1XKKLr845QtWiXSncejy2rSX4zZ1ZuzE=;
 b=BWffjgclpOf0AnRNtThPMgP5yClDnqeNjvAXJ8GuvArKKv4pXI/BVB8eN43pc3WlsG
 V3o4kNztMKm/3SvdgOZ1IIC8u+IomuFK/aFKZqpb+CQUqlc3pZHB/1AHDSOVkiqwMOcF
 1blBMhtKT0VmBnPaOBkUDxSEuwkDgl4Dh1POpzvR8bWoaFvIBBljNUcUHaiCbzKDzyJ+
 X+DaQrFEXrmvHVmOdb/yl6AJIxOZK9Yozmswi4unpuqci3vrZDdEYPDfZ8nEJGDHNAKA
 UxSw+sKyjRbSDjvA7G1W+xZZbZPDsS6bZGVkBfC48oNflEcuJYVz8KGGoEYhXloDiPuS
 GcxQ==
X-Gm-Message-State: AFq9FYIcxzdZyhwASLn9BuVydhNo+jeait1cCRvY7MucpIUlfR+uw/w+
 bhT3VyGIH7G1pmk4EVETiJynaZL3NVGcvSYRM4tAFdEgvaoASEW7YZvCpIFN0Pp9Nhae3/MGPMe
 e0GRujpOhIM7iaiRxR1BASKfj5wwUn2aNT7YUnhMJimkwX9FeCTIUvjMfHsYVP5ob1ilDwFSjAv
 0WcZTajNXT5gPFKAwLdvXvNX7kDkJxRQnQNTDHshm7sXfeY857TpfX7t4yiW1H3Q==
X-Received: from qvho9.prod.google.com ([2002:ad4:5c89:0:b0:91b:bbc2:a88b])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2b83:b0:91b:d5d7:8c90 with SMTP id
 6a1803df08f44-91c48cdbfd0mr7424726d6.5.1792795147611; 
 Fri, 23 Oct 2026 15:39:07 -0700 (PDT)
Date: Fri, 23 Oct 2026 22:38:59 +0000
In-Reply-To: <20261023223902.1275539-1-namangulati@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023223902.1275539-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023223902.1275539-2-namangulati@google.com>
Subject: [PATCH v6 1/4] vfio-user: add multi-fd region mmap capability
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f45;
 envelope-from=3C-LbagsKCpwJ6I6JCQH6PECKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--namangulati.bounces.google.com;
 helo=mail-qv1-xf45.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the vfio-user protocol specification to allow servers to pass
multiple file descriptors for different sparse memory areas within a
single device region with capability
VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS (0x8001), negotiated via the
"sparse_mmap_fds" capability in VFIO_USER_VERSION.

VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS defines an array of sparse mmap
areas where each area contains:
- offset: Start of the area within the device region (BAR).
- fd_offset: Start of the mapping within the backing file descriptor.
- size: Size of the mappable area.
- fd_index: Zero-based index into the array of file descriptors
  received in the SCM_RIGHTS ancillary data of the
  VFIO_USER_DEVICE_GET_REGION_INFO reply message.

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
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
2.56.0.307.g5fe7bd680c-goog


