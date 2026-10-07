Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E090FCA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8v-0006K9-Fd; Wed, 07 Oct 2026 04:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hI3FagsKChM6t5t6zD4tC1z77z4x.v759x5D-wxEx4676z6D.7Az@flex--namangulati.bounces.google.com>)
 id 1xEI5Z-0001OD-6I
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:13:30 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hI3FagsKChM6t5t6zD4tC1z77z4x.v759x5D-wxEx4676z6D.7Az@flex--namangulati.bounces.google.com>)
 id 1xEI5P-0001T1-Rx
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:13:01 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso3576109a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791342762; x=1791947562; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C0I73QCKyMNmeu8wpKfVAtKeOubS0N3TmdbBuxaYXOo=;
 b=OqwxRfL5LDYsVtePxcFPz83TwM+gKXwTzSlbMEpzDhuSbuCe1w09Cd62DPOiFvtLJe
 7YjByT4009RCd14r9owBO5stU0mj3i39Jr/XzvNcBfkI4yT7vwssH4At7vMTZPpynim0
 5zETNTxvzY54mbjMHNK+2vlRsUVdcNMymEwZ6LgzZJBumnRq6SFF6fA3Oq1eeBmjS0jE
 2/dng4WEUDrO7cUIuyJBi4NksJOUyhUUcxAJ4rzF33svKaJF+ExHObxfrhjDPwKjqwI8
 Tb0Q+1DGop5/S7X5tua+VZC3Vmwvb0i+yuBqM/dwYWfPMLAcxtJ9HZ0BHP+ABDQWVOcp
 BVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791342762; x=1791947562;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C0I73QCKyMNmeu8wpKfVAtKeOubS0N3TmdbBuxaYXOo=;
 b=qMXsY3/X9Zq2I3DkuHvWrL+LOMab2bBhjczDWXtVGcnTzjIxZ9dy3/XsZhY6/CQxGR
 Zr0n2Mir/OyBwo53TLaJzC5ZtT019Fgaofcp5y7HmrcuYHmjfIoRDDKZ2xJh68zwHdeP
 uMDXOjmJaUccirtVQuvMaPPwz2ugT3pPJkklQeHiAsiJ2aE93ds0ZQ8ouQG+fFHZhLnB
 155g0RqhQ9ds95ZBHyzmEAUX2Z++rce2DONYb+QUMamKIspZCxN3dTilXVR9LyF4Q2bt
 e0mLkyjPqIvteGxh2yghUj2rgnySRk0B2Bmz/81KC41lSk00oa7cI/Jj3W+wVaHuMVdC
 JIpg==
X-Gm-Message-State: AFuF++nSHf7UM1yfv87qCyECrsztv3lc2tm/r469LhNtzUBHVmbtWWRQ
 BmJLgzeeR5wBMhErFRQDyRdVyRjmvZPvOy4HAPYcIR6+N5tMvCTDtHciiqbGErSJbUMw549TL4J
 13yoUq73Ju/8k+T2hpsQGF80K/FqNJZ1EMK8trdj1SDdrMPT++OS2suPkCgjBPJqD6cWcZmKSHf
 SY0l7gcQRWhFoM4TTqeFSSi/EQ6GCmuSVkcxMr1pThOU9QsUtQvQUlTTSwLaB2dA==
X-Received: from qtmr24.prod.google.com ([2002:ac8:4258:0:b0:535:1f86:d438])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:11d3:b0:533:26bd:65e1 with SMTP id
 d75a77b69052e-53575545a29mr9893001cf.36.1791331716139; 
 Tue, 06 Oct 2026 17:08:36 -0700 (PDT)
Date: Wed,  7 Oct 2026 00:08:30 +0000
In-Reply-To: <20261007000833.2445641-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261007000833.2445641-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261007000833.2445641-2-namangulati@google.com>
Subject: [PATCH v3 RESEND 1/4] vfio-user: add multi-fd region mmap capability
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3hI3FagsKChM6t5t6zD4tC1z77z4x.v759x5D-wxEx4676z6D.7Az@flex--namangulati.bounces.google.com;
 helo=mail-pg1-x545.google.com
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_MED=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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
2.56.0.rc1.315.gc6ed9934b7-goog


