Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A03C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 13:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOGOf-00014u-0c; Sun, 08 Jun 2025 09:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uOGOd-00012c-EI
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 09:49:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uOGOa-0007VT-IP
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 09:49:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a522224582so2172811f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749390546; x=1749995346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s40my1tHbhb+uMlIztjyGLXhAk8PPa5g2mHbHrM8dFc=;
 b=QxmzbTuD2gha3elk9ck+1Xq0FqgLNt4AAkslZO+2Zhp72jmCF89bhqEpFdJw2QLNKK
 nzBWg2eRGcNUgSWokNcGK2+Mgoc0xNTE/NtQtBcmNlwEVryruhZvl0FjFvw85cEeJYIO
 UAZujNnhPDOyD4DxivONZbJvCUfrgBH8XSYnG3N9kEHms2eJYLpP968mWbQtr4T1Di71
 pVdNk+r56cz2TCmjE9i8gWnxmn+7uf4vx6iZ794WhLi7/vlbDi3bJuRJYfI06oSyPq7x
 bTQKRiYz8+bvn56qVc+demcpGNQnDCq6tfzGbLFoPB7XPed4KMn165NUDkviGtdVfl0V
 QGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749390546; x=1749995346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s40my1tHbhb+uMlIztjyGLXhAk8PPa5g2mHbHrM8dFc=;
 b=EfxFCxfnCr+p/Kfp7l/58TIA+uToINmeTV1DMl/6DCHc5J1fHfHRGb27H8vPcuZQ9+
 ZdKZ+qGo/zJIi+WmTyBmxk0CTZj9dl73/PO1uhGhhaktZdIY6kxd0QaBeiDN9zpmSuWs
 srEs9xnghg/klkbFB9m8oq/qUTuSNACV2f2Fe3GZEL2SZV+Ghwe1JLutijHqhmhAlMa5
 fqCeP5c01nFJcODQ/Mo+8XxD1P2JxO63QNNUQ+XMdhzUTEfnFp2DjJo7dbdcMvkYD8Wk
 R3x5/swvjC4JPLRn79nmCBpy8h84FXfNVjHdwzuSSiY9qkBUErv8OoEGd1A7414JpBkq
 lXyA==
X-Gm-Message-State: AOJu0Yz1F56c30rifZgXCitFVvnR8zr9PbujK5zbMkLZ4MBHYKyhlQvT
 xQDdSVHsPZ7jsI8+wD1F44vqsfwevcYT0lIEoa6OgqzqBYnDTgrR71k/P7LacAZQG6U=
X-Gm-Gg: ASbGncs8WWCfM664Ue5oZ2KE3UY7eGKwU8a+p9JYXOTZvKLOTAWLG1obPQOHnh5GWIj
 9xqGCRcs7QT8nr5AtcFgbgBtWVYFT0ZLHLHcJABI6bG2mvGYPHw1ZTDcgB5M3OBhT397SN3Bxka
 /vdZlzEY32FiNh38ZzrM9lEv+P1kv7KhGUZutuMgB3VfgRK4KUZ/XzKGZRiVPaXsf5Gud8/UivZ
 /4oNzZvzkCRrfplrI5t7DVss8hvHcxnnjc+4CM2vRzJ1jcgdWn/aiWfX14KEA/VHLmCwuy6CvdJ
 IU4vT42PY66kjeKkqtQ2lXJnRKHizDRlxC7d8XOFQ/Osbtvbk7M/UW8HCT/jW5tO4D1eH45D697
 KjKweSCjfQf7ViECM
X-Google-Smtp-Source: AGHT+IEXeJQAISoNsulURSQhmJ0L0o8HkQ+PmkGLRrsCuxUKOMw/SpZqleIrM3uRbDb9AnNA3lgNLQ==
X-Received: by 2002:a05:6000:40de:b0:3a5:26eb:b4af with SMTP id
 ffacd0b85a97d-3a53189b56fmr7362167f8f.18.1749390545725; 
 Sun, 08 Jun 2025 06:49:05 -0700 (PDT)
Received: from localhost (89-88-247-135.abo.bbox.fr. [89.88.247.135])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3a53229de53sm7188499f8f.8.2025.06.08.06.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Jun 2025 06:49:04 -0700 (PDT)
From: conte.souleymane@gmail.com
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org,
 Souleymane Conte <conte.souleymane@gmail.com>
Subject: [PATCH] docs/interop: convert text file to restructuredText format
Date: Sun,  8 Jun 2025 13:48:43 +0000
Message-ID: <20250608134843.26530-1-conte.souleymane@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=conte.souleymane@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Souleymane Conte <conte.souleymane@gmail.com>

buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
---
 docs/interop/index.rst    |   1 +
 docs/interop/qed_spec.rst | 219 ++++++++++++++++++++++++++++++++++++++
 docs/interop/qed_spec.txt | 138 ------------------------
 3 files changed, 220 insertions(+), 138 deletions(-)
 create mode 100644 docs/interop/qed_spec.rst
 delete mode 100644 docs/interop/qed_spec.txt

diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 5b9b0653b5..447dcea2e5 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -17,6 +17,7 @@ are useful for making QEMU interoperate with other software.
    nbd
    parallels
    qcow2
+   qed_spec
    prl-xml
    pr-helper
    qmp-spec
diff --git a/docs/interop/qed_spec.rst b/docs/interop/qed_spec.rst
new file mode 100644
index 0000000000..5d9a503c37
--- /dev/null
+++ b/docs/interop/qed_spec.rst
@@ -0,0 +1,219 @@
+===================================
+QED Image File Format Specification
+===================================
+
+The file format looks like this::
+
+ +----------+----------+----------+-----+
+ | cluster0 | cluster1 | cluster2 | ... |
+ +----------+----------+----------+-----+
+
+The first cluster begins with the ``header``. The header contains information
+about where regular clusters start; this allows the header to be extensible and
+store extra information about the image file. A regular cluster may be 
+a ``data cluster``, an ``L2``, or an ``L1 table``. L1 and L2 tables are composed
+of one or more contiguous clusters.
+
+Normally the file size will be a multiple of the cluster size.  If the file size 
+is not a multiple, extra information after the last cluster may not be preserved 
+if data is written. Legitimate extra information should use space between the header
+and the first regular cluster.
+
+All fields are little-endian.
+
+Header
+------
+
+::
+
+  Header {
+     uint32_t magic;               /* QED\0 */
+ 
+     uint32_t cluster_size;        /* in bytes */
+     uint32_t table_size;          /* for L1 and L2 tables, in clusters */
+     uint32_t header_size;         /* in clusters */
+ 
+     uint64_t features;            /* format feature bits */
+     uint64_t compat_features;     /* compat feature bits */
+     uint64_t autoclear_features;  /* self-resetting feature bits */
+
+     uint64_t l1_table_offset;     /* in bytes */
+     uint64_t image_size;          /* total logical image size, in bytes */
+ 
+     /* if (features & QED_F_BACKING_FILE) */
+     uint32_t backing_filename_offset; /* in bytes from start of header */
+     uint32_t backing_filename_size;   /* in bytes */
+  }
+
+Field descriptions:
+~~~~~~~~~~~~~~~~~~~
+
+- ``cluster_size`` must be a power of 2 in range [2^12, 2^26].
+- ``table_size`` must be a power of 2 in range [1, 16].
+- ``header_size`` is the number of clusters used by the header and any additional
+  information stored before regular clusters.
+- ``features``, ``compat_features``, and ``autoclear_features`` are file format
+  extension bitmaps. They work as follows:
+
+  - An image with unknown ``features`` bits enabled must not be opened. File format
+    changes that are not backwards-compatible must use ``features`` bits.
+  - An image with unknown ``compat_features`` bits enabled can be opened safely.
+    The unknown features are simply ignored and represent backwards-compatible
+    changes to the file format.
+  - An image with unknown ``autoclear_features`` bits enable can be opened safely
+    after clearing the unknown bits. This allows for backwards-compatible changes
+    to the file format which degrade gracefully and can be re-enabled again by a
+    new program later.
+- ``l1_table_offset`` is the offset of the first byte of the L1 table in the image 
+  file and must be a multiple of ``cluster_size``.
+- ``image_size`` is the block device size seen by the guest and must be a multiple
+  of 512 bytes.
+- ``backing_filename_offset`` and ``backing_filename_size`` describe a string in
+  (byte offset, byte size) form. It is not NUL-terminated and has no alignment constraints.
+  The string must be stored within the first ``header_size`` clusters. The backing filename
+  may be an absolute path or relative to the image file.
+
+Feature bits:
+~~~~~~~~~~~~~
+
+- ``QED_F_BACKING_FILE = 0x01``. The image uses a backing file.
+- ``QED_F_NEED_CHECK = 0x02``. The image needs a consistency check before use.
+- ``QED_F_BACKING_FORMAT_NO_PROBE = 0x04``. The backing file is a raw disk image
+  and no file format autodetection should be attempted.  This should be used to
+  ensure that raw backing files are never detected as an image format if they happen
+  to contain magic constants.
+
+There are currently no defined ``compat_features`` or ``autoclear_features`` bits.
+
+Fields predicated on a feature bit are only used when that feature is set.
+The fields always take up header space, regardless of whether or not the feature
+bit is set.
+
+Tables
+------
+
+Tables provide the translation from logical offsets in the block device to cluster
+offsets in the file.
+
+::
+
+ #define TABLE_NOFFSETS (table_size * cluster_size / sizeof(uint64_t))
+  
+ Table {
+     uint64_t offsets[TABLE_NOFFSETS];
+ }
+
+The tables are organized as follows::
+
+                    +----------+
+                    | L1 table |
+                    +----------+
+               ,------'  |  '------.
+          +----------+   |    +----------+
+          | L2 table |  ...   | L2 table |
+          +----------+        +----------+
+      ,------'  |  '------.
+ +----------+   |    +----------+
+ |   Data   |  ...   |   Data   |
+ +----------+        +----------+
+
+A table is made up of one or more contiguous clusters.  The ``table_size`` header
+field determines table size for an image file. For example, ``cluster_size=64 KB``
+and ``table_size=4`` results in 256 KB tables.
+
+The logical image size must be less than or equal to the maximum possible size of 
+clusters rooted by the L1 table:
+
+.. code::
+
+ header.image_size <= TABLE_NOFFSETS * TABLE_NOFFSETS * header.cluster_size
+
+L1, L2, and data cluster offsets must be aligned to ``header.cluster_size``.
+The following offsets have special meanings:
+
+L2 table offsets
+~~~~~~~~~~~~~~~~
+
+- 0 - unallocated. The L2 table is not yet allocated.
+
+Data cluster offsets
+~~~~~~~~~~~~~~~~~~~~
+
+- 0 - unallocated.  The data cluster is not yet allocated.
+- 1 - zero. The data cluster contents are all zeroes and no cluster is allocated.
+
+Future format extensions may wish to store per-offset information. The least
+significant 12 bits of an offset are reserved for this purpose and must be set
+to zero. Image files with ``cluster_size`` > 2^12 will have more unused bits 
+which should also be zeroed.
+
+Unallocated L2 tables and data clusters
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Reads to an unallocated area of the image file access the backing file. If there
+is no backing file, then zeroes are produced. The backing file may be smaller
+than the image file and reads of unallocated areas beyond the end of the backing
+file produce zeroes.
+
+Writes to an unallocated area cause a new data clusters to be allocated, and a new
+L2 table if that is also unallocated. The new data cluster is populated with data 
+from the backing file (or zeroes if no backing file) and the data being written.
+
+Zero data clusters
+~~~~~~~~~~~~~~~~~~
+
+Zero data clusters are a space-efficient way of storing zeroed regions of the image.
+
+Reads to a zero data cluster produce zeroes. 
+
+.. note::
+    The difference between an unallocated and a zero data cluster is that zero data
+    clusters stop the reading of contents from the backing file.
+
+Writes to a zero data cluster cause a new data cluster to be allocated.  The new 
+data cluster is populated with zeroes and the data being written.
+
+Logical offset translation
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Logical offsets are translated into cluster offsets as follows::
+
+  table_bits table_bits    cluster_bits
+  <--------> <--------> <--------------->
+ +----------+----------+-----------------+
+ | L1 index | L2 index |     byte offset |
+ +----------+----------+-----------------+
+ 
+       Structure of a logical offset
+
+ offset_mask = ~(cluster_size - 1) # mask for the image file byte offset
+ 
+ def logical_to_cluster_offset(l1_index, l2_index, byte_offset):
+   l2_offset = l1_table[l1_index]
+   l2_table = load_table(l2_offset)
+   cluster_offset = l2_table[l2_index] & offset_mask
+   return cluster_offset + byte_offset
+
+Consistency checking
+~~~~~~~~~~~~~~~~~~~~
+
+This section is informational and included to provide background on the use
+of the ``QED_F_NEED_CHECK features`` bit.
+
+The ``QED_F_NEED_CHECK`` bit is used to mark an image as dirty before starting
+an operation that could leave the image in an inconsistent state if interrupted
+by a crash or power failure.  A dirty image must be checked on open because its
+metadata may not be consistent.
+
+Consistency check includes the following invariants:
+
+- Each cluster is referenced once and only once. It is an inconsistency to have
+  a cluster referenced more than once by L1 or L2 tables. A cluster has been leaked
+  if it has no references.
+- Offsets must be within the image file size and must be ``cluster_size`` aligned.
+- Table offsets must at least ``table_size`` * ``cluster_size`` bytes from the end 
+  of the image file so that there is space for the entire table.
+
+The consistency check process starts by from ``l1_table_offset`` and scans all L2 tables.
+After the check completes with no other errors besides leaks, the ``QED_F_NEED_CHECK``
+bit can be cleared and the image can be accessed.
diff --git a/docs/interop/qed_spec.txt b/docs/interop/qed_spec.txt
deleted file mode 100644
index 7982e058b2..0000000000
--- a/docs/interop/qed_spec.txt
+++ /dev/null
@@ -1,138 +0,0 @@
-=Specification=
-
-The file format looks like this:
-
- +----------+----------+----------+-----+
- | cluster0 | cluster1 | cluster2 | ... |
- +----------+----------+----------+-----+
-
-The first cluster begins with the '''header'''.  The header contains information about where regular clusters start; this allows the header to be extensible and store extra information about the image file.  A regular cluster may be a '''data cluster''', an '''L2''', or an '''L1 table'''.  L1 and L2 tables are composed of one or more contiguous clusters.
-
-Normally the file size will be a multiple of the cluster size.  If the file size is not a multiple, extra information after the last cluster may not be preserved if data is written.  Legitimate extra information should use space between the header and the first regular cluster.
-
-All fields are little-endian.
-
-==Header==
- Header {
-     uint32_t magic;               /* QED\0 */
- 
-     uint32_t cluster_size;        /* in bytes */
-     uint32_t table_size;          /* for L1 and L2 tables, in clusters */
-     uint32_t header_size;         /* in clusters */
- 
-     uint64_t features;            /* format feature bits */
-     uint64_t compat_features;     /* compat feature bits */
-     uint64_t autoclear_features;  /* self-resetting feature bits */
-
-     uint64_t l1_table_offset;     /* in bytes */
-     uint64_t image_size;          /* total logical image size, in bytes */
- 
-     /* if (features & QED_F_BACKING_FILE) */
-     uint32_t backing_filename_offset; /* in bytes from start of header */
-     uint32_t backing_filename_size;   /* in bytes */
- }
-
-Field descriptions:
-* ''cluster_size'' must be a power of 2 in range [2^12, 2^26].
-* ''table_size'' must be a power of 2 in range [1, 16].
-* ''header_size'' is the number of clusters used by the header and any additional information stored before regular clusters.
-* ''features'', ''compat_features'', and ''autoclear_features'' are file format extension bitmaps.  They work as follows:
-** An image with unknown ''features'' bits enabled must not be opened.  File format changes that are not backwards-compatible must use ''features'' bits.
-** An image with unknown ''compat_features'' bits enabled can be opened safely.  The unknown features are simply ignored and represent backwards-compatible changes to the file format.
-** An image with unknown ''autoclear_features'' bits enable can be opened safely after clearing the unknown bits.  This allows for backwards-compatible changes to the file format which degrade gracefully and can be re-enabled again by a new program later.
-* ''l1_table_offset'' is the offset of the first byte of the L1 table in the image file and must be a multiple of ''cluster_size''.
-* ''image_size'' is the block device size seen by the guest and must be a multiple of 512 bytes.
-* ''backing_filename_offset'' and ''backing_filename_size'' describe a string in (byte offset, byte size) form.  It is not NUL-terminated and has no alignment constraints.  The string must be stored within the first ''header_size'' clusters.  The backing filename may be an absolute path or relative to the image file.
-
-Feature bits:
-* QED_F_BACKING_FILE = 0x01.  The image uses a backing file.
-* QED_F_NEED_CHECK = 0x02.  The image needs a consistency check before use.
-* QED_F_BACKING_FORMAT_NO_PROBE = 0x04.  The backing file is a raw disk image and no file format autodetection should be attempted.  This should be used to ensure that raw backing files are never detected as an image format if they happen to contain magic constants.
-
-There are currently no defined ''compat_features'' or ''autoclear_features'' bits.
-
-Fields predicated on a feature bit are only used when that feature is set.  The fields always take up header space, regardless of whether or not the feature bit is set.
-
-==Tables==
-
-Tables provide the translation from logical offsets in the block device to cluster offsets in the file.
-
- #define TABLE_NOFFSETS (table_size * cluster_size / sizeof(uint64_t))
-  
- Table {
-     uint64_t offsets[TABLE_NOFFSETS];
- }
-
-The tables are organized as follows:
-
-                    +----------+
-                    | L1 table |
-                    +----------+
-               ,------'  |  '------.
-          +----------+   |    +----------+
-          | L2 table |  ...   | L2 table |
-          +----------+        +----------+
-      ,------'  |  '------.
- +----------+   |    +----------+
- |   Data   |  ...   |   Data   |
- +----------+        +----------+
-
-A table is made up of one or more contiguous clusters.  The table_size header field determines table size for an image file.  For example, cluster_size=64 KB and table_size=4 results in 256 KB tables.
-
-The logical image size must be less than or equal to the maximum possible size of clusters rooted by the L1 table:
- header.image_size <= TABLE_NOFFSETS * TABLE_NOFFSETS * header.cluster_size
-
-L1, L2, and data cluster offsets must be aligned to header.cluster_size.  The following offsets have special meanings:
-
-===L2 table offsets===
-* 0 - unallocated.  The L2 table is not yet allocated.
-
-===Data cluster offsets===
-* 0 - unallocated.  The data cluster is not yet allocated.
-* 1 - zero.  The data cluster contents are all zeroes and no cluster is allocated.
-
-Future format extensions may wish to store per-offset information.  The least significant 12 bits of an offset are reserved for this purpose and must be set to zero.  Image files with cluster_size > 2^12 will have more unused bits which should also be zeroed.
-
-===Unallocated L2 tables and data clusters===
-Reads to an unallocated area of the image file access the backing file.  If there is no backing file, then zeroes are produced.  The backing file may be smaller than the image file and reads of unallocated areas beyond the end of the backing file produce zeroes.
-
-Writes to an unallocated area cause a new data clusters to be allocated, and a new L2 table if that is also unallocated.  The new data cluster is populated with data from the backing file (or zeroes if no backing file) and the data being written.
-
-===Zero data clusters===
-Zero data clusters are a space-efficient way of storing zeroed regions of the image.
-
-Reads to a zero data cluster produce zeroes.  Note that the difference between an unallocated and a zero data cluster is that zero data clusters stop the reading of contents from the backing file.
-
-Writes to a zero data cluster cause a new data cluster to be allocated.  The new data cluster is populated with zeroes and the data being written.
-
-===Logical offset translation===
-Logical offsets are translated into cluster offsets as follows:
-
-  table_bits table_bits    cluster_bits
-  <--------> <--------> <--------------->
- +----------+----------+-----------------+
- | L1 index | L2 index |     byte offset |
- +----------+----------+-----------------+
- 
-       Structure of a logical offset
-
- offset_mask = ~(cluster_size - 1) # mask for the image file byte offset
- 
- def logical_to_cluster_offset(l1_index, l2_index, byte_offset):
-   l2_offset = l1_table[l1_index]
-   l2_table = load_table(l2_offset)
-   cluster_offset = l2_table[l2_index] & offset_mask
-   return cluster_offset + byte_offset
-
-==Consistency checking==
-
-This section is informational and included to provide background on the use of the QED_F_NEED_CHECK ''features'' bit.
-
-The QED_F_NEED_CHECK bit is used to mark an image as dirty before starting an operation that could leave the image in an inconsistent state if interrupted by a crash or power failure.  A dirty image must be checked on open because its metadata may not be consistent.
-
-Consistency check includes the following invariants:
-# Each cluster is referenced once and only once.  It is an inconsistency to have a cluster referenced more than once by L1 or L2 tables.  A cluster has been leaked if it has no references.
-# Offsets must be within the image file size and must be ''cluster_size'' aligned.
-# Table offsets must at least ''table_size'' * ''cluster_size'' bytes from the end of the image file so that there is space for the entire table.
-
-The consistency check process starts by from ''l1_table_offset'' and scans all L2 tables.  After the check completes with no other errors besides leaks, the QED_F_NEED_CHECK bit can be cleared and the image can be accessed.
-- 
2.49.0


