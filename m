Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C31BC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtw4i-0004T7-QO; Tue, 11 Aug 2026 19:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wbJ7agsKCnAbOaObUiZOhWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--namangulati.bounces.google.com>)
 id 1wtw4e-0004RS-Ab
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:40:00 -0400
Received: from mail-qk1-x745.google.com ([2607:f8b0:4864:20::745])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wbJ7agsKCnAbOaObUiZOhWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--namangulati.bounces.google.com>)
 id 1wtw4b-00089M-8v
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:40:00 -0400
Received: by mail-qk1-x745.google.com with SMTP id
 af79cd13be357-934956beec8so90517085a.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786491586; x=1787096386; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ccKPU2BAjELGM/MWXQjgcWGJFuMdQ51Hoatxp1Nt9uM=;
 b=Io5lt9Oqvi7jcv5DkupRcLoJdMB1q2gmoz/b0qbxbPo974JNN9a0RxWmsP2qKlrgJG
 XLYktVZgguIwFIY9Plt40QVMYckwqYFAUYDGit2Ux5veHcYceWnFPOeuykqbV7s5DnGE
 KDWacKBOviMJ6cWAXHDBzxuyg1yV1oPyYLwn6mdMY3JTtIkRWr8XeB6iho1+GwoXYYLH
 EZ0YZJ80w5Lj6s7YZSx0AVW3say7lsjXqo1lWlxI0K48gHGYEnQAza7nq5FTGWWnZPWI
 a993VZQjs/tXMXZ+m03JLLcD3/22cRdK/yqvu++Q8iA90aC2ICPxKepbpfer8ec2Ke+Y
 ANUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786491586; x=1787096386;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ccKPU2BAjELGM/MWXQjgcWGJFuMdQ51Hoatxp1Nt9uM=;
 b=Do1M5WJHYVLkQo/mqFdQ+9p914BwxkKfN5FT53cONmvFPzE7LKXS+YQ5Buv5exewrz
 yulqOStRhPOcalii9/lYLoUIGLzHwPfvDPQdgf1IEC4zYjEnUjtSy0b0swFoC+pJVkih
 uojaxNuSrVWEn2n33fQFaGjVdCP8obXH/EyCzDsrqkycl/xYjS2nUhLz/A2NoNf0JWR2
 YdlDYnsvCZBBBryJ8/m6hBMGS8r8oHKclInwVS2GG2/RZZaqbXl/dxDbanJy3+JX3s8D
 OPw4D5A8mOHRkskaojCC6zcHpv1SSfCH76NMv/6MfjyIaw2Dp5N29CJqFOavfjMpti14
 QfYQ==
X-Gm-Message-State: AOJu0YxzNrFSRWtmGwaUYoUzQFfsfu5KS6II9VEZiJywW2dY6vgx2Zsw
 jM156r0JLLTZfRKRvzcSAPbmA4OPn8a5aZL17sz7kvXb5ClgVEbtsDcwt1kXmiplUPYtrx6+4U9
 L1d/TnUJKmKWj4PBEDvuHNnePB5qGsRCTeaGDXrPWeaniQvh4+wYhbAKBQgWpplxnXOva9mRkPj
 fDY8G8t/LT0n3d67OpiPwVknhCA0PKMo4TxJ1+zKprYC33jlFdwabFjavrIQ9iwA==
X-Received: from qknqw9.prod.google.com ([2002:a05:620a:8b09:b0:930:f7e0:e8b4])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a707:b0:936:8c1e:b531 with SMTP id
 af79cd13be357-936b3a30c58mr108855285a.10.1786491585389; 
 Tue, 11 Aug 2026 16:39:45 -0700 (PDT)
Date: Tue, 11 Aug 2026 23:39:28 +0000
In-Reply-To: <20260811233930.401797-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260811233930.401797-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811233930.401797-2-namangulati@google.com>
Subject: [RFC PATCH 1/3] vfio-user: add multi-fd region mmap capability
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::745;
 envelope-from=3wbJ7agsKCnAbOaObUiZOhWUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x745.google.com
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
2.55.0.679.g6767b8d81c-goog


