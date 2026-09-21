Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD96AC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Xlx-0006K3-Jh; Mon, 21 Sep 2026 02:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x8Xlu-0006Io-TS
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:45:03 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x8Xlp-0008BO-Qw
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:45:02 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc515bef69dso1677141a12.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789973096; x=1790577896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qv4nmiS0g9OyuiP4Y5jrYYNydF1sz3/49a8t17BEB98=;
 b=gCXYEVsNOYb30DhABD3DfJ8nR6p2t1Dap3+fsmBdFk7I+Id4aTEgBVjorkVUrEyeHc
 S/j05dOogXQEdT7UKcOoShR1Jepq+F6YQMwE0Uxul+LlLRoxqIgw8G7SDRnU1Iq/F3lM
 HD0f8ZBqnbQwQjluHd9YNEyll21cGVEqf+C0eG6DyQT+MBxQps+Fz7lR8CqlKHrLU7oj
 wm4LhOH0euzEI0O+3fzZGKK2frzErcdClHACPQdxztOzkHWu62Fh63i3M2wr3m3HqT/W
 6nYHuVF34/5NY78epCXaUqgeORid6Xqu9i2DZWjUnUVUP1NhyTtY74J3k45EO+TQJAus
 nxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789973096; x=1790577896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qv4nmiS0g9OyuiP4Y5jrYYNydF1sz3/49a8t17BEB98=;
 b=CcQZd+SJuV+nbsCTim3GsANLCyHWQYusoXdwPNpTTu/9qV68b/cSgXou56mDT1nv7r
 trdu3sHPN73OauViONS9xtMtHx+lFpzhNZLxCbj0XBntLwyPqL6NhkbU2S7KL/qcXOzu
 d31NST/H5eZUVXwWAJb6OxqR8zh95jswEHeel0QElE6E5UgdCNVLeYe47f0MWr7rBWZj
 CDcVJWiJr7N+JVgCHLGa9jJjy3rUWY7JrnTy0+p5I6KpLCLUll0vUPaceEMs4UOhaB0w
 BtQTtKUb/kFBr35rHlWn5fkIYvVPPVfB/uTnLoPepvxJ8VpOpkWtRCz8Jb4vVSJ0adkC
 53Wg==
X-Gm-Message-State: AFuF++kNivJ+jHKBKSKdPpaSHgDHi3oceu4Hppg0jGaQ6OMbdfF3knd1
 eg5yeHOBNXdR5KQivJ4zNiKyRDj5UuE93ioVdWT1jsSxdGIrVnFpXYlmbSWBKq4NDg8=
X-Gm-Gg: AYBFou2FvK+3zeNt+0gdz4eE0DeCsc5Co6urHtT7d7hi61H7CHOdWmD0kqNjAddMPPj
 awKHaCMz01cTtlsLec9qszXiBFVf6S5hs+fSgepHTqta0Sl7wqDjJspxgR1olccctfZ+L20WByn
 uvSyDADEkLiFF0oO7YSbhdz/F01aTdfJ+GDisovltP5AF160o89NwPCuSTw1gOfAjQvrj78aTiN
 /VUJcj+JyqTADR+nB+7meISnFhxorQlxCCLCEi9u6zSCXKkPqQ2zC0IBJS76Cw/BjuQk0Ab6qE0
 33/D/xJZ2i+s/iCwYzmmDB3DFea1DoHliZuSFEFlwcR+RnsnOfQAoFbnCYu+18Imm+gSnlFGK88
 pwsv2a/lFggGh5BJ3GOD6IUnCBOrV9pf/ZjAhwjyeS1SyteWjDyrI9C11Hf8u4pb2vSa8hiC6dF
 ncVFIc7LucxgS6H3Q/98BMp5fLc5x2j+V0t/6WZymiLC0usCrcdSKXhTZbJhNIBVPV6z5HThgt6
 SKGklq7GmGJOGtbv8Op3emgIuvtkfIg9XWa
X-Received: by 2002:a17:90b:17cb:b0:39e:464d:ebc3 with SMTP id
 98e67ed59e1d1-39e54bbcd45mr15936819a91.12.1789973094645; 
 Sun, 20 Sep 2026 23:44:54 -0700 (PDT)
Received: from localhost.localdomain ([103.211.230.152])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55a4378sm15924433c88.4.2026.09.20.23.44.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 20 Sep 2026 23:44:54 -0700 (PDT)
From: Huiba Li <lihuiba@gmail.com>
To: qemu-devel@nongnu.org
Cc: Huiba Li <lihuiba@gmail.com>, Huiba Li <huiba.lhb@alibaba-inc.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH] block: Add overlaybd read-only format driver
Date: Mon, 21 Sep 2026 14:44:40 +0800
Message-ID: <20260921064440.67131-1-lihuiba@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=lihuiba@gmail.com; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Overlaybd (overlay block device) is a novel layered
image format based on block-diff representation. It
was originally designed for fast launching of containers,
and it is also feasible for virtual machines.

It features:
(1) small index with variable-length block size;
(2) fast lookup with linearized B+ tree and SIMD; (binary search for now);
(3) O(1) lookup at any number of depth (internal backing chain);
(4) optionally fast decompression with lz4 or zstd;
(5) OCI-compatible layering and manifest.

Signed-off-by: Huiba Li <huiba.lhb@alibaba-inc.com>
---
 MAINTAINERS                            |    7 +
 block/meson.build                      |    5 +-
 block/overlaybd.c                      | 1962 ++++++++++++++++++++++++
 docs/system/qemu-block-drivers.rst.inc |   37 +
 meson.build                            |    9 +
 meson_options.txt                      |    4 +
 qapi/block-core.json                   |   39 +
 scripts/meson-buildoptions.sh          |    6 +
 tests/qemu-iotests/tests/overlaybd     |  795 ++++++++++
 tests/qemu-iotests/tests/overlaybd.out |   10 +
 10 files changed, 2873 insertions(+), 1 deletion(-)
 create mode 100644 block/overlaybd.c
 create mode 100755 tests/qemu-iotests/tests/overlaybd
 create mode 100644 tests/qemu-iotests/tests/overlaybd.out

diff --git a/MAINTAINERS b/MAINTAINERS
index 6be9c5725b..a71264490b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4436,6 +4436,13 @@ L: qemu-block@nongnu.org
 S: Supported
 F: block/dmg.c
 
+overlaybd
+M: Huiba Li <huiba.lhb@alibaba-inc.com>
+L: qemu-block@nongnu.org
+S: Supported
+F: block/overlaybd.c
+F: tests/qemu-iotests/tests/overlaybd*
+
 parallels
 M: Stefan Hajnoczi <stefanha@redhat.com>
 M: Denis V. Lunev <den@openvz.org>
diff --git a/block/meson.build b/block/meson.build
index bc419aebf0..48fdac8b0b 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -39,7 +39,7 @@ block_ss.add(files(
   'throttle.c',
   'throttle-groups.c',
   'write-threshold.c',
-), zstd, zlib)
+), zstd, zlib, lz4)
 
 system_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
 system_ss.add(files('block-ram-registrar.c'))
@@ -69,6 +69,9 @@ endif
 if get_option('bochs').allowed()
   block_ss.add(files('bochs.c'))
 endif
+if get_option('overlaybd').allowed()
+  block_ss.add(files('overlaybd.c'))
+endif
 if get_option('vvfat').allowed()
   block_ss.add(files('vvfat.c'))
 endif
diff --git a/block/overlaybd.c b/block/overlaybd.c
new file mode 100644
index 0000000000..9d3b5eb437
--- /dev/null
+++ b/block/overlaybd.c
@@ -0,0 +1,1962 @@
+/*
+ *
+ * Read-only block driver for OverlayBD images
+ *
+ * An OverlayBD image is a stack of layer files. Each layer is an LSMT
+ * blob: a 4096-byte header, a data region,
+ * a sorted index of 16-byte LBA mappings, and a 4096-byte trailer. The
+ * driver merges the per-layer indexes top-down (a top layer's mapping
+ * wins its whole extent; lower layers only fill holes) and serves reads
+ * at 512-byte sector granularity. Holes and zeroed mappings read as
+ * zeros.
+ *
+ * Layers may optionally be wrapped in a single-entry tar and/or
+ * compressed with ZFile (block-wise LZ4 or ZSTD with a jump table).
+ *
+ * The layer stack is given either by an OCI image manifest, whose layer
+ * digests name blobs in a local directory (manifest option, or the file
+ * child for -drive file=... usage), or as an explicit bottom-first
+ * "layers" array.
+ *
+ * See also the reference implementation:
+ * https://github.com/containerd/overlaybd
+ *
+ * Specifications for the on-disk formats:
+ *   LSMT layer blob format (header, data, index, trailer)
+ *     https://github.com/containerd/overlaybd/blob/main/src/overlaybd/lsmt/format_spec.md
+ *   ZFile block compression format (jump table, LZ4/ZSTD)
+ *     https://github.com/containerd/overlaybd/blob/main/src/overlaybd/zfile/format_spec.md
+ *
+ * The layer blobs are named by an OCI image manifest; the remaining OCI
+ * specifications are listed where the manifest is parsed:
+ *   https://github.com/opencontainers/image-spec/blob/main/manifest.md
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "block/block-io.h"
+#include "block/block_int.h"
+#include "block/qdict.h"
+#include "qemu/module.h"
+#include "qemu/bswap.h"
+#include "qemu/crc32c.h"
+#include "qemu/cutils.h"
+#include "qemu/memalign.h"
+#include "qobject/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+
+#ifdef CONFIG_LZ4
+#include <lz4.h>
+#endif
+#ifdef CONFIG_ZSTD
+#include <zstd.h>
+#endif
+
+/*
+ *
+ * On-disk format definitions below mirror the reference implementation
+ * (containerd/overlaybd: lsmt/file.cpp HeaderTrailer, lsmt/index.h,
+ * zfile/zfile.cpp HeaderTrailer, zfile/compressor.h CompressOptions)
+ * field for field; per-struct citations mark the source of each layout.
+ * Metadata is little-endian on disk and is read through explicit
+ * little-endian accessors, which also sidesteps the signedness of
+ * ldl_le_p() for the 32-bit fields.
+ */
+
+static const char lsmt_magic0[8] = "LSMT\0\1\2";
+static const uint8_t lsmt_magic1[16] = {
+    0x65, 0x7e, 0x63, 0xd2, 0x94, 0x44, 0x08, 0x4c,
+    0xa2, 0xd2, 0xc8, 0xec, 0x4f, 0xcf, 0xae, 0x8a
+};
+static const char zfile_magic0[8] = "ZFile\0\1";
+static const uint8_t zfile_magic1[16] = "tuji.yyf@Alibaba";
+
+/* LSMT::HeaderTrailer::SPACE, lsmt/file.cpp */
+#define LSMT_HT_SPACE             4096
+/* LSMT::MAX_LSMT_RO_INDEX_SIZE, lsmt/index.h */
+#define LSMT_MAX_RO_INDEX_ENTRIES 1000000LL
+/* LSMT::MAX_LSMT_INDEX_SIZE, lsmt/index.h: cap on the merged index */
+#define LSMT_MAX_MERGED_ENTRIES   128000000LL
+/* LSMT::MAX_STACK_LAYERS, lsmt/file.h */
+#define LSMT_MAX_LAYERS           255
+/* LSMT::Segment::INVALID_OFFSET, lsmt/index.h */
+#define LSMT_INVALID_OFFSET       (((uint64_t)1 << 50) - 1)
+#define LSMT_MOFFSET_BEGIN        (LSMT_HT_SPACE / BDRV_SECTOR_SIZE)
+
+/* LSMT::HeaderTrailer::FLAG_SHIFT_*, lsmt/file.cpp */
+#define LSMT_FLAG_HEADER    (1u << 0)
+#define LSMT_FLAG_DATA_FILE (1u << 1)
+#define LSMT_FLAG_SEALED    (1u << 2)
+
+/*
+ * LSMT::HeaderTrailer, lsmt/file.cpp: a packed struct with byte-aligned
+ * fields only (no bitfields), identical to the upstream definition less
+ * the C++ methods, and covering the whole LSMT_HT_SPACE block that is
+ * read and written.  Upstream stops at user_tag (sizeof == 390) and
+ * keeps the tail outside the type, reading the block into a raw buffer
+ * and casting it; format_spec.md:32 documents that tail as a header
+ * field, so it is declared here instead.
+ */
+typedef struct QEMU_PACKED OverlaybdLSMTHeader {
+    uint64_t magic0;
+    uint8_t magic1[16];
+    uint32_t size;           /* 390: the fields above, tail excluded */
+    uint32_t flags;
+    uint64_t index_offset;
+    uint64_t index_size;     /* # of 16-byte index entries */
+    uint64_t virtual_size;   /* bytes */
+    uint8_t uuid[37];        /* UUID::String */
+    uint8_t parent_uuid[37]; /* UUID::String */
+    uint16_t reserved;
+    uint8_t version;
+    uint8_t sub_version;
+    uint8_t user_tag[256];   /* TAG_SIZE */
+    uint8_t reserved_space[3706];
+} OverlaybdLSMTHeader;
+
+QEMU_BUILD_BUG_ON(sizeof(OverlaybdLSMTHeader) != LSMT_HT_SPACE);
+
+/* ZFile::HeaderTrailer::SPACE, zfile/zfile.cpp */
+#define ZFILE_HT_SPACE       512
+/*
+ * ZFile::MAX_READ_SIZE, zfile/zfile.h: upstream uses this one constant
+ * both as the block size cap and as the size of BlockReader's
+ * compressed-data read window.  Only the block size cap is needed here --
+ * the read window is sized to the request.
+ */
+#define ZFILE_MAX_BLOCK_SIZE 65536
+/*
+ * qemu-side hardening: a jump table entry is image-controlled, so cap the
+ * compressed size of one block to bound the read window.  Upstream has no
+ * span cap; it ERANGEs when a block overflows its 64 KiB window instead.
+ */
+#define ZFILE_MAX_SPAN       (1u << 20)
+/* ZFile::CompressOptions::LZ4 / ZSTD, zfile/compressor.h */
+#define ZFILE_ALGO_LZ4       1
+#define ZFILE_ALGO_ZSTD      2
+
+/* ZFile::HeaderTrailer::FLAG_SHIFT_*, zfile/zfile.cpp */
+#define ZFILE_FLAG_HEADER           (1ULL << 0)
+#define ZFILE_FLAG_DATA_FILE        (1ULL << 1)
+#define ZFILE_FLAG_SEALED           (1ULL << 2)
+#define ZFILE_FLAG_HEADER_OVERWRITE (1ULL << 3)
+#define ZFILE_FLAG_DIGEST           (1ULL << 4)
+#define ZFILE_FLAG_INDEX_COMPRESSED (1ULL << 5)
+
+/* ZFile::CompressOptions, zfile/compressor.h: sizeof == 24 */
+typedef struct QEMU_PACKED OverlaybdCompressOptions {
+    uint32_t block_size;
+    uint8_t algo;
+    uint8_t level;
+    uint8_t use_dict;
+    uint8_t __padding_0;
+    uint32_t reserved;
+    uint32_t dict_size;
+    uint8_t verify;
+    uint8_t __padding_1[7];
+} OverlaybdCompressOptions;
+
+/*
+ * ZFile::HeaderTrailer, zfile/zfile.cpp, embedding ZFile::CompressOptions
+ * at offset 72: upstream is not packed, but every member is naturally
+ * aligned at these offsets, so a packed C struct has the identical
+ * layout.  As with the LSMT header, the ZFILE_HT_SPACE tail that
+ * upstream keeps outside the type is declared here, per
+ * format_spec.md:39 (offset 89 ~ 511, of which opt.__padding_1 already
+ * covers 89 ~ 95).
+ */
+typedef struct QEMU_PACKED OverlaybdZFileHeader {
+    uint64_t magic0;
+    uint8_t magic1[16];
+    uint32_t size;           /* 96: the fields above, tail excluded */
+    uint32_t digest;         /* CRC32C of bytes 28..511, digest zeroed */
+    uint64_t flags;
+    uint64_t index_offset;
+    uint64_t index_size;     /* # of u32 jump-table entries (blocks) */
+    uint64_t original_file_size;
+    uint32_t index_crc;
+    uint32_t reserved_0;
+    OverlaybdCompressOptions opt;
+    uint8_t reserved_space[416];
+} OverlaybdZFileHeader;
+
+QEMU_BUILD_BUG_ON(sizeof(OverlaybdCompressOptions) != 24);
+QEMU_BUILD_BUG_ON(sizeof(OverlaybdZFileHeader) != ZFILE_HT_SPACE);
+
+/* ZFile::MAX_ZFILE_INDEX_SIZE, zfile/zfile.cpp */
+#define ZFILE_MAX_INDEX_ENTRIES 1000000000LL
+
+/* crc32c_salt()'s seed, zfile/zfile.cpp: per-block CRCs are salted */
+#define ZFILE_CRC_SALT          100007
+
+/*
+ * ZFile::JumpTable, zfile/zfile.cpp: within-group offsets are uint16_t,
+ * so one group spans at most UINT16_MAX + 1 bytes of compressed data.
+ */
+#define ZFILE_JUMP_GROUP_BYTES  (UINT16_MAX + 1u)
+
+#define ZFILE_INDEX_CHUNK_BYTES (1 << 20) /* ZFile::load_jump_table delta */
+#define ZFILE_INDEX_MAX_COROUTINES 32
+
+/*
+ * In-memory 16-byte index entry. The field assignment mirrors the
+ * on-disk SegmentMapping (lo = lba:50 | length:14, hi = moffset:55 |
+ * zeroed:1 | tag:8, the tag slot holding the serving layer at runtime,
+ * like the reference implementation), but this struct deliberately does
+ * NOT map the disk image: bitfields are forbidden in packed or
+ * exact-layout structures (docs/devel/style.rst), so on-disk bytes are
+ * decoded by overlaybd_decode_entry() with explicit little-endian loads
+ * and the bit order below is compiler-managed, never exposed.
+ */
+typedef struct OverlaybdSegment {
+    uint64_t lba:50;
+    uint64_t length:14;
+    uint64_t moffset:55;
+    uint64_t zeroed:1;
+    uint64_t layer:8;
+} OverlaybdSegment;
+
+QEMU_BUILD_BUG_ON(sizeof(OverlaybdSegment) != 16);
+
+typedef struct OverlaybdZfile {
+    uint64_t index_offset;       /* jump table offset, ZFile-relative bytes */
+    uint64_t index_size;
+    uint64_t original_file_size;
+    uint32_t block_size;
+    uint8_t algo;
+    bool verify;
+    /*
+     * ZFile::JumpTable, zfile/zfile.cpp: block @i starts at
+     * partial_offset[i >> group_shift] + deltas[i], except at a group
+     * boundary where the delta is zero.
+     */
+    uint64_t *partial_offset;
+    uint16_t *deltas;
+    unsigned group_shift;
+} OverlaybdZfile;
+
+typedef struct OverlaybdLayer {
+    BdrvChild *child;
+    bool is_zfile;
+    uint64_t base_offset; /* tar prefix length in the child, bytes */
+    uint64_t view_size;
+    OverlaybdZfile zf;
+    /* LSMT metadata, in ZFile-virtual space for compressed layers */
+    uint64_t index_offset;
+    OverlaybdSegment *index;
+    size_t index_count;
+    uint64_t virtual_size;
+} OverlaybdLayer;
+
+typedef struct BDRVOverlaybdState {
+    OverlaybdLayer *layers; /* top-first: layers[0] is the topmost layer */
+    int nb_layers;
+    OverlaybdSegment *merged;
+    size_t merged_cap;
+    size_t merged_count;
+    uint64_t virtual_size;
+} BDRVOverlaybdState;
+
+/*
+ * Load one on-disk 16-byte index entry (two little-endian u64:
+ * lo = lba:50 | length:14, hi = moffset:55 | zeroed:1 | tag:8) into the
+ * host-side entry. The on-disk tag is discarded; the merge assigns
+ * layers.
+ */
+static void overlaybd_decode_entry(const uint8_t *p, OverlaybdSegment *out)
+{
+    uint64_t lo = ldq_le_p(p);
+    uint64_t hi = ldq_le_p(p + 8);
+
+    out->lba = lo & (((uint64_t)1 << 50) - 1);
+    out->length = (lo >> 50) & ((1u << 14) - 1);
+    out->moffset = hi & (((uint64_t)1 << 55) - 1);
+    out->zeroed = (hi >> 55) & 1;
+    out->layer = 0;
+}
+
+static bool overlaybd_has_magic(const void *ht, const void *magic0,
+                                const void *magic1)
+{
+    return memcmp(ht, magic0, 8) == 0 &&
+           memcmp((const uint8_t *)ht + 8, magic1, 16) == 0;
+}
+
+static bool overlaybd_is_lsmt_header(const uint8_t *buf)
+{
+    return overlaybd_has_magic(buf, lsmt_magic0, lsmt_magic1);
+}
+
+static bool overlaybd_is_zfile_header(const uint8_t *buf)
+{
+    return overlaybd_has_magic(buf, zfile_magic0, zfile_magic1);
+}
+
+static bool overlaybd_is_tar_header(const uint8_t *hdr)
+{
+    return memcmp(hdr + 257, "ustar", 5) == 0 &&
+           (hdr[156] == '0' || hdr[156] == '\0' || hdr[156] == 'x');
+}
+
+static bool overlaybd_verify_lsmt_block(const OverlaybdLSMTHeader *ht,
+                                        bool is_trailer)
+{
+    uint32_t flags;
+
+    if (!overlaybd_has_magic(ht, lsmt_magic0, lsmt_magic1)) {
+        return false;
+    }
+    flags = le32_to_cpu(ht->flags);
+    if (is_trailer) {
+        return !(flags & LSMT_FLAG_HEADER) &&
+                (flags & LSMT_FLAG_DATA_FILE) &&
+                (flags & LSMT_FLAG_SEALED);
+    }
+    return flags & LSMT_FLAG_HEADER;
+}
+
+/*
+ * Upstream's crc32::crc32c_extend() is the raw CRC-32C recurrence with no
+ * post-conditioning, while qemu's crc32c() inverts once on return, so XOR
+ * the result to recover upstream's value for any seed. A wrong convention
+ * here fails silently against real images: nothing but the digest mismatches.
+ */
+static uint32_t overlaybd_crc32c(uint32_t seed, const void *buf, size_t len)
+{
+    return crc32c(seed, buf, len) ^ 0xffffffff;
+}
+
+static bool overlaybd_zfile_verify_digest(OverlaybdZFileHeader *blk)
+{
+    uint32_t crc, saved = le32_to_cpu(blk->digest);
+
+    blk->digest = 0;
+    crc = overlaybd_crc32c(0, blk, sizeof(*blk));
+    blk->digest = cpu_to_le32(saved);
+    return crc == saved;
+}
+
+static bool overlaybd_zfile_verify_block(OverlaybdZFileHeader *blk,
+                                         bool is_trailer)
+{
+    uint64_t flags;
+
+    if (!overlaybd_has_magic(blk, zfile_magic0, zfile_magic1)) {
+        return false;
+    }
+    flags = le64_to_cpu(blk->flags);
+    if (is_trailer) {
+        if ((flags & ZFILE_FLAG_HEADER) || !(flags & ZFILE_FLAG_DATA_FILE) ||
+            !(flags & ZFILE_FLAG_SEALED)) {
+            return false;
+        }
+    } else {
+        if (!(flags & ZFILE_FLAG_HEADER)) {
+            return false;
+        }
+    }
+    if (flags & ZFILE_FLAG_DIGEST && !overlaybd_zfile_verify_digest(blk)) {
+        return false;
+    }
+    return true;
+}
+
+/*
+ * Locate a header/trailer block of @ht_space bytes near the end of the
+ * layer and return its offset, relative to the child, or -errno.  The
+ * block found is also copied to @ht_out, which must hold @ht_space bytes:
+ * it has already been read and validated here, so re-reading it at the
+ * returned offset would be a second I/O for the same bytes.
+ *
+ * The end of the layer is not the end of the child: a tar wrapper pads
+ * its entry to a blocking factor, so the scan must stop at
+ * base_offset + view_size. That end is still not exact for a bare layer,
+ * whose view_size is just bdrv_getlength() rounded up to 512 bytes, so
+ * scan the last @ht_space + 511 bytes for the magic (the same approach
+ * as dmg_find_koly_offset()), taking the match closest to the end.
+ */
+static int64_t GRAPH_RDLOCK
+overlaybd_scan_trailer(OverlaybdLayer *l, size_t ht_space, bool is_zfile,
+                       void *ht_out)
+{
+    int64_t end = l->base_offset + l->view_size;
+    int64_t window, off, found = -ENOENT;
+    uint8_t *buf;
+    int ret;
+
+    window = (int64_t)ht_space + 511;
+    off = end > window ? end - window : 0;
+    window = end - off;
+
+    buf = g_malloc(window);
+    ret = bdrv_pread(l->child, off, window, buf, 0);
+    if (ret < 0) {
+        g_free(buf);
+        return ret;
+    }
+    for (int64_t i = (int64_t)window - ht_space; i >= 0; i--) {
+        bool ok;
+
+        /* copy the whole block: the ZFile digest covers all 512 bytes */
+        if (is_zfile) {
+            OverlaybdZFileHeader blk;
+
+            memcpy(&blk, buf + i, sizeof(blk));
+            ok = overlaybd_zfile_verify_block(&blk, true);
+        } else {
+            OverlaybdLSMTHeader blk;
+
+            memcpy(&blk, buf + i, sizeof(blk));
+            ok = overlaybd_verify_lsmt_block(&blk, true);
+        }
+        if (ok) {
+            memcpy(ht_out, buf + i, ht_space);
+            found = off + i;
+            break;
+        }
+    }
+    g_free(buf);
+    return found;
+}
+
+/*
+ * ZFile::JumpTable::build(), zfile/zfile.cpp: turn the on-disk u32
+ * block lengths into one absolute offset per group plus uint16_t
+ * within-group prefix sums. @offset_begin is where block 0 lives,
+ * relative to the ZFile.
+ */
+static int overlaybd_zfile_build_table(OverlaybdZfile *zf,
+                                       const uint32_t *table,
+                                       uint64_t offset_begin, Error **errp)
+{
+    uint64_t group_size = ZFILE_JUMP_GROUP_BYTES / zf->block_size;
+    uint64_t min_span = zf->verify ? 4 : 0;
+    uint64_t raw_offset = offset_begin;
+    uint32_t span;
+
+    zf->group_shift = ctz64(group_size);
+    /*
+     * g_try_new, not g_new: both sizes come from the image, and a hostile
+     * header can ask for gigabytes (at block_size 65536, group_size is 1
+     * and partial_offset costs 8 bytes per entry).
+     */
+    zf->partial_offset = g_try_new(uint64_t, zf->index_size / group_size + 1);
+    zf->deltas = g_try_new(uint16_t, zf->index_size + 1);
+    if (!zf->partial_offset || !zf->deltas) {
+        return -ENOMEM;
+    }
+    zf->partial_offset[0] = raw_offset;
+    zf->deltas[0] = 0;
+
+    for (uint64_t i = 1; i <= zf->index_size; i++) {
+        span = ldl_le_p((const uint8_t *)&table[i - 1]);
+
+        if (span <= min_span || span > ZFILE_MAX_SPAN) {
+            error_setg(errp, "invalid ZFile block size in jump table");
+            return -EINVAL;
+        }
+        raw_offset += span;
+        if (i % group_size == 0) {
+            zf->partial_offset[i / group_size] = raw_offset;
+            zf->deltas[i] = 0;
+            continue;
+        }
+        if ((uint64_t)zf->deltas[i - 1] + span >= UINT16_MAX) {
+            error_setg(errp, "ZFile compressed blocks in one jump table "
+                             "group exceed %d bytes", UINT16_MAX);
+            return -ERANGE;
+        }
+        zf->deltas[i] = zf->deltas[i - 1] + span;
+    }
+    return 0;
+}
+
+/* ZFile::JumpTable::operator[], zfile/zfile.cpp */
+static uint64_t overlaybd_zfile_block_off(const OverlaybdZfile *zf,
+                                          uint64_t idx)
+{
+    uint64_t part = zf->partial_offset[idx >> zf->group_shift];
+
+    if (idx & ((1ULL << zf->group_shift) - 1)) {
+        return part + zf->deltas[idx];
+    }
+    return part;
+}
+
+typedef struct OverlaybdZfileLoad {
+    BdrvChild *child;
+    int64_t offset;   /* table start, relative to the child */
+    uint8_t *table;
+    uint64_t bytes;   /* table size */
+    uint64_t next;    /* first byte no coroutine has claimed yet */
+    int nb_done;
+    int ret;
+} OverlaybdZfileLoad;
+
+/*
+ * The caller holds the graph rdlock across the whole open, so these
+ * coroutines take no further lock. They share the one cursor in @load:
+ * claiming a chunk reads load->next then advances it with no yield between,
+ * and coroutines in one AioContext never run concurrently, so the chunks are
+ * partitioned with no locking. Inputs are copied to locals here; only next,
+ * ret and nb_done stay shared (a private next would spin on chunk 0 forever).
+ */
+static void coroutine_fn GRAPH_RDLOCK
+overlaybd_zfile_load_co(void *opaque)
+{
+    OverlaybdZfileLoad *load = opaque;
+    BdrvChild *child = load->child;
+    int64_t offset = load->offset;
+    uint8_t *table = load->table;
+    uint64_t bytes = load->bytes;
+
+    while (load->next < bytes) {
+        uint64_t off = load->next;
+        uint64_t len = MIN(bytes - off, (uint64_t)ZFILE_INDEX_CHUNK_BYTES);
+        int ret;
+
+        load->next = off + len;
+
+        ret = bdrv_co_pread(child, offset + off, len, table + off, 0);
+        if (ret < 0) {
+            if (load->ret == 0) {
+                load->ret = ret;
+            }
+            break;
+        }
+    }
+    load->nb_done++;
+}
+
+static int GRAPH_RDLOCK
+overlaybd_zfile_load_table(OverlaybdLayer *l, uint32_t *table, Error **errp)
+{
+    OverlaybdZfile *zf = &l->zf;
+    uint64_t bytes = zf->index_size * sizeof(uint32_t);
+    int ret;
+
+    if (bytes <= ZFILE_INDEX_CHUNK_BYTES) {
+        ret = bdrv_pread(l->child, l->base_offset + zf->index_offset,
+                         bytes, table, 0);
+    } else {
+        OverlaybdZfileLoad load = {
+            .child = l->child,
+            .offset = l->base_offset + zf->index_offset,
+            .table = (uint8_t *)table,
+            .bytes = bytes,
+        };
+        int nb_chunks = DIV_ROUND_UP(bytes, ZFILE_INDEX_CHUNK_BYTES);
+        int nb_cos = MIN(nb_chunks, ZFILE_INDEX_MAX_COROUTINES);
+
+        for (int i = 0; i < nb_cos; i++) {
+            qemu_coroutine_enter(qemu_coroutine_create(overlaybd_zfile_load_co,
+                                                       &load));
+        }
+        BDRV_POLL_WHILE(l->child->bs, load.nb_done < nb_cos);
+        ret = load.ret;
+    }
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not read ZFile jump table");
+    }
+    return ret;
+}
+
+static int GRAPH_RDLOCK
+overlaybd_zfile_open(OverlaybdLayer *l, Error **errp)
+{
+    BdrvChild *child = l->child;
+    OverlaybdZfile *zf = &l->zf;
+    OverlaybdZFileHeader ht;
+    uint64_t flags, index_offset, index_size, original_file_size;
+    uint32_t *table = NULL;
+    uint32_t block_size;
+    uint8_t algo, verify;
+    int64_t child_size, zfile_end;
+    uint64_t end_reserve;
+    int ret;
+
+    child_size = bdrv_getlength(child->bs);
+    if (child_size < 0) {
+        error_setg_errno(errp, -child_size, "could not get layer file size");
+        return child_size;
+    }
+    child_size -= l->base_offset;
+    if (child_size < 2 * ZFILE_HT_SPACE) {
+        error_setg(errp, "layer file too small to be a ZFile");
+        return -EINVAL;
+    }
+
+    ret = bdrv_pread(child, l->base_offset, sizeof(ht), &ht, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not read ZFile header");
+        return ret;
+    }
+    if (!overlaybd_zfile_verify_block(&ht, false)) {
+        error_setg(errp, "invalid ZFile header");
+        return -EINVAL;
+    }
+
+    flags = le64_to_cpu(ht.flags);
+    /*
+     * The layer's own end, not the child's: a tar wrapper pads its entry.
+     * bdrv_getlength() also rounds up, so when there is a trailer the
+     * scanned trailer position gives the exact end instead.
+     */
+    zfile_end = l->view_size;
+    end_reserve = 0;
+    if (!(flags & ZFILE_FLAG_HEADER_OVERWRITE)) {
+        /*
+         * Without HEADER_OVERWRITE the trailer carries the final metadata,
+         * so the header is dead once its flags have been read and the
+         * trailer is read into the same block -- as upstream does.
+         */
+        int64_t trl_off = overlaybd_scan_trailer(l, ZFILE_HT_SPACE, true,
+                                                 &ht);
+
+        if (trl_off < 0) {
+            error_setg(errp, "invalid ZFile trailer");
+            return -EINVAL;
+        }
+        flags = le64_to_cpu(ht.flags);
+        zfile_end = trl_off + ZFILE_HT_SPACE - (int64_t)l->base_offset;
+        end_reserve = ZFILE_HT_SPACE;
+    }
+
+    if (flags & ZFILE_FLAG_INDEX_COMPRESSED) {
+        error_setg(errp, "compressed ZFile jump table is not supported");
+        return -ENOTSUP;
+    }
+
+    index_offset = le64_to_cpu(ht.index_offset);
+    index_size = le64_to_cpu(ht.index_size);
+    original_file_size = le64_to_cpu(ht.original_file_size);
+    block_size = le32_to_cpu(ht.opt.block_size);
+    algo = ht.opt.algo;
+    verify = ht.opt.verify;
+
+    if (ht.opt.use_dict != 0) {
+        error_setg(errp, "ZFile with dictionary is not supported");
+        return -ENOTSUP;
+    }
+    if (block_size == 0 || block_size > ZFILE_MAX_BLOCK_SIZE ||
+        !is_power_of_2(block_size)) {
+        error_setg(errp, "invalid ZFile block size %" PRIu32, block_size);
+        return -EINVAL;
+    }
+    if (algo != ZFILE_ALGO_LZ4 && algo != ZFILE_ALGO_ZSTD) {
+        error_setg(errp, "unknown ZFile compression algorithm %" PRIu8, algo);
+        return -EINVAL;
+    }
+#ifndef CONFIG_LZ4
+    if (algo == ZFILE_ALGO_LZ4) {
+        error_setg(errp, "LZ4-compressed layer, but qemu was compiled "
+                         "without lz4 support");
+        return -ENOTSUP;
+    }
+#endif
+#ifndef CONFIG_ZSTD
+    if (algo == ZFILE_ALGO_ZSTD) {
+        error_setg(errp, "ZSTD-compressed layer, but qemu was compiled "
+                         "without zstd support");
+        return -ENOTSUP;
+    }
+#endif
+
+    if (index_size > ZFILE_MAX_INDEX_ENTRIES) {
+        error_setg(errp, "ZFile index size %" PRIu64 " exceeds maximum "
+                         "%lld", index_size, ZFILE_MAX_INDEX_ENTRIES);
+        return -EINVAL;
+    }
+    /*
+     * order the checks so each subtraction is guarded by the previous
+     * condition (no unsigned wraparound on adversarial values)
+     */
+    if (index_offset < ZFILE_HT_SPACE ||
+        index_offset > (uint64_t)zfile_end - end_reserve ||
+        index_size * 4 > (uint64_t)zfile_end - end_reserve - index_offset) {
+        error_setg(errp, "invalid ZFile jump table location");
+        return -EINVAL;
+    }
+    if ((index_size - 1) * block_size >= original_file_size ||
+        original_file_size > index_size * block_size) {
+        error_setg(errp, "ZFile block count does not match content size");
+        return -EINVAL;
+    }
+
+    zf->index_offset = index_offset;
+    zf->index_size = index_size;
+    zf->original_file_size = original_file_size;
+    zf->block_size = block_size;
+    zf->algo = algo;
+    zf->verify = verify;
+
+    table = qemu_try_blockalign(l->child->bs,
+                                index_size * sizeof(uint32_t));
+    if (!table) {
+        return -ENOMEM;
+    }
+    ret = overlaybd_zfile_load_table(l, table, errp);
+    if (ret < 0) {
+        goto out;
+    }
+    /*
+     * like the reference implementation, the jump table CRC is only
+     * checked when the digest flag is set (it is garbage otherwise)
+     */
+    if ((flags & ZFILE_FLAG_DIGEST) && le32_to_cpu(ht.index_crc) !=
+        overlaybd_crc32c(0, table, index_size * sizeof(uint32_t))) {
+        error_setg(errp, "ZFile jump table CRC mismatch");
+        ret = -EIO;
+        goto out;
+    }
+
+    ret = overlaybd_zfile_build_table(zf, table,
+                                      ZFILE_HT_SPACE +
+                                      le32_to_cpu(ht.opt.dict_size), errp);
+    if (ret < 0) {
+        goto out;
+    }
+    if (overlaybd_zfile_block_off(zf, zf->index_size) > zf->index_offset) {
+        error_setg(errp, "ZFile data region overlaps the jump table");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    l->view_size = zf->original_file_size;
+    ret = 0;
+out:
+    qemu_vfree(table);
+    return ret;
+}
+
+/*
+ * Forward-only cursor into a QEMUIOVector. Seeding it and committing each
+ * block's bytes are the same advance, so they share one. The blocks of a
+ * request are written contiguously in increasing order, so a full pass costs
+ * O(niov) rather than the O(niov * nblocks) of qemu_iovec_subvec_niov(),
+ * which rescans from iov[0] -- expensive for the one-iovec-per-guest-page
+ * qiov that virtio-blk normally hands us.
+ */
+typedef struct OverlaybdQiovCursor {
+    struct iovec *iov;
+    struct iovec *end;
+    uint8_t *cur;
+    size_t left;
+} OverlaybdQiovCursor;
+
+static void overlaybd_qiov_cursor_advance(OverlaybdQiovCursor *c, size_t n)
+{
+    while (c->cur && n >= c->left) {
+        n -= c->left;
+        if (++c->iov >= c->end) {
+            c->cur = NULL;
+            c->left = 0;
+            return;
+        }
+        c->cur = (uint8_t *)c->iov->iov_base;
+        c->left = c->iov->iov_len;
+    }
+    if (c->cur) {
+        c->cur += n;
+        c->left -= n;
+    }
+}
+
+/*
+ * Point @c at byte 0 of @qiov.  @qiov is NULL on the buf path, which
+ * leaves the cursor exhausted, so every test of it fails closed.
+ */
+static void overlaybd_qiov_cursor_init(OverlaybdQiovCursor *c,
+                                       QEMUIOVector *qiov)
+{
+    c->iov = qiov ? qiov->iov : NULL;
+    c->end = qiov ? qiov->iov + qiov->niov : NULL;
+    c->cur = c->iov < c->end ? (uint8_t *)c->iov->iov_base : NULL;
+    c->left = c->cur ? c->iov->iov_len : 0;
+}
+
+/*
+ * All I/O goes through bdrv_pread() (a mixed wrapper), so this is
+ * callable from both GS and coroutine contexts.
+ */
+static int coroutine_mixed_fn GRAPH_RDLOCK
+overlaybd_zfile_read(OverlaybdLayer *l, uint64_t off, uint64_t bytes,
+                     void *buf, QEMUIOVector *qiov, size_t qiov_off)
+{
+    OverlaybdZfile *zf = &l->zf;
+    uint32_t bsz = zf->block_size;
+    uint64_t first, last, base, need;
+    uint8_t *cbuf = NULL;
+    uint8_t *scratch = NULL;
+    OverlaybdQiovCursor c;
+    int ret;
+
+    assert(off + bytes <= zf->original_file_size);
+
+    /*
+     * also keeps "off + bytes - 1" below from wrapping when both are 0,
+     * which a caller reading an empty index can legitimately ask for
+     */
+    if (bytes == 0) {
+        return 0;
+    }
+
+    first = off / bsz;
+    last = (off + bytes - 1) / bsz;
+    /*
+     * One read covers the compressed bytes of every block the request spans,
+     * so the loop below never refills. A hostile jump table can still make
+     * @need many times larger than @bytes, hence qemu_try_blockalign() rather
+     * than the aborting qemu_blockalign(); aligning to the child's
+     * opt_mem_alignment lets an already-aligned request reach the protocol
+     * driver without being bounced.
+     */
+    base = overlaybd_zfile_block_off(zf, first);
+    need = overlaybd_zfile_block_off(zf, last + 1) - base;
+
+    /*
+     * One allocation for both: the compressed window, then the one-block
+     * decompression scratch behind it. bdrv_pread() writes only the first
+     * @need bytes so the two never overlap, and only the window goes to the
+     * block layer, so only its start needs the alignment.
+     */
+    cbuf = qemu_try_blockalign(l->child->bs, need + bsz);
+    if (!cbuf) {
+        return -ENOMEM;
+    }
+    scratch = cbuf + need;
+
+    ret = bdrv_pread(l->child, l->base_offset + base, need, cbuf, 0);
+    if (ret < 0) {
+        goto out;
+    }
+
+    overlaybd_qiov_cursor_init(&c, qiov);
+    overlaybd_qiov_cursor_advance(&c, qiov_off);
+
+    for (uint64_t bi = first; bi <= last; bi++) {
+        uint64_t bstart = bi * (uint64_t)bsz;
+        uint64_t expected = MIN((uint64_t)bsz,
+                                zf->original_file_size - bstart);
+        uint64_t cp_begin = bstart > off ? 0 : off - bstart;
+        uint64_t cp_len = MIN(expected, off + bytes - bstart) - cp_begin;
+        uint64_t dst_off = bstart + cp_begin - off;
+        uint64_t off_blk = overlaybd_zfile_block_off(zf, bi);
+        uint64_t span = overlaybd_zfile_block_off(zf, bi + 1) - off_blk;
+        uint64_t clen = span - (zf->verify ? 4 : 0);
+        const uint8_t *cdata;
+        uint8_t *dst = NULL, *dec;
+
+        cdata = cbuf + (off_blk - base);
+
+        /*
+         * BlockReader::crc32_code(), zfile/zfile.cpp: the salted CRC trails
+         * the compressed data and covers exactly those bytes.  Upstream
+         * retries three times before failing, which cannot help against a
+         * read-only child.
+         */
+        if (zf->verify) {
+            uint32_t want = ldl_le_p(cdata + clen);
+
+            if (want != overlaybd_crc32c(ZFILE_CRC_SALT, cdata, clen)) {
+                ret = -EIO;
+                goto out;
+            }
+        }
+
+        if (cp_begin == 0 && cp_len == expected) {
+            if (buf) {
+                dst = (uint8_t *)buf + dst_off;
+            } else if (c.cur && cp_len <= c.left) {
+                dst = c.cur;
+            }
+        }
+        dec = dst ? dst : scratch;
+
+        ret = -EIO;
+#ifdef CONFIG_LZ4
+        if (zf->algo == ZFILE_ALGO_LZ4) {
+            int r = LZ4_decompress_safe((const char *)cdata, (char *)dec,
+                                        clen, expected);
+
+            if (r >= 0 && (uint64_t)r == expected) {
+                ret = 0;
+            }
+        }
+#endif
+#ifdef CONFIG_ZSTD
+        if (zf->algo == ZFILE_ALGO_ZSTD) {
+            size_t r = ZSTD_decompress(dec, expected, cdata, clen);
+
+            if (!ZSTD_isError(r) && r == expected) {
+                ret = 0;
+            }
+        }
+#endif
+        if (ret < 0) {
+            goto out;
+        }
+        if (!dst) {
+            if (buf) {
+                memcpy((uint8_t *)buf + dst_off, scratch + cp_begin, cp_len);
+            } else {
+                qemu_iovec_from_buf(qiov, qiov_off + dst_off,
+                                    scratch + cp_begin, cp_len);
+            }
+        }
+
+        overlaybd_qiov_cursor_advance(&c, cp_len);
+    }
+
+    ret = 0;
+out:
+    qemu_vfree(cbuf);
+    return ret;
+}
+
+static int GRAPH_RDLOCK
+overlaybd_pread_view(OverlaybdLayer *l, uint64_t off, int64_t bytes, void *buf)
+{
+    if (l->is_zfile) {
+        return overlaybd_zfile_read(l, off, bytes, buf, NULL, 0);
+    }
+    return bdrv_pread(l->child, l->base_offset + off, bytes, buf, 0);
+}
+
+/*
+ * Load and validate the LSMT header/trailer/index of a layer. All
+ * metadata comes from the trailer; the header is only a format sniff
+ * (real images may have garbage header fields).
+ */
+static int GRAPH_RDLOCK
+overlaybd_lsmt_open(OverlaybdLayer *l, Error **errp)
+{
+    OverlaybdLSMTHeader ht;
+    OverlaybdSegment *index = NULL;
+    uint8_t *raw = NULL;
+    uint64_t index_offset, index_size, virtual_size, moffset_end;
+    uint64_t index_bound;
+    uint64_t prev_end = 0;
+    size_t count = 0;
+    int ret;
+
+    if (l->view_size < 2 * LSMT_HT_SPACE) {
+        error_setg(errp, "layer too small to be an LSMT image");
+        return -EINVAL;
+    }
+
+    ret = overlaybd_pread_view(l, 0, LSMT_HT_SPACE, &ht);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not read LSMT header");
+        return ret;
+    }
+    if (!overlaybd_verify_lsmt_block(&ht, false)) {
+        error_setg(errp, "invalid LSMT header");
+        return -EINVAL;
+    }
+
+    /*
+     * The header is only a format sniff, so reading the trailer into the
+     * same block is safe.  index_bound is where the index must end: the
+     * trailer start, which for a bare layer is not view_size - SPACE
+     * because bdrv_getlength() over-reports (tar padding, rounding).
+     */
+    if (l->is_zfile) {
+        /* in the ZFile virtual space the content size is exact */
+        ret = overlaybd_pread_view(l, l->view_size - LSMT_HT_SPACE,
+                                   LSMT_HT_SPACE, &ht);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "could not read LSMT trailer");
+            return ret;
+        }
+        index_bound = l->view_size - LSMT_HT_SPACE;
+    } else {
+        int64_t trl_off = overlaybd_scan_trailer(l, LSMT_HT_SPACE, false,
+                                                 &ht);
+
+        if (trl_off < 0) {
+            error_setg(errp, "invalid LSMT trailer (not a sealed data "
+                             "layer?)");
+            return trl_off < -ENOENT ? trl_off : -EINVAL;
+        }
+        index_bound = (uint64_t)(trl_off - (int64_t)l->base_offset);
+    }
+    if (!overlaybd_verify_lsmt_block(&ht, true)) {
+        error_setg(errp, "invalid LSMT trailer (not a sealed data layer?)");
+        return -EINVAL;
+    }
+
+    index_offset = le64_to_cpu(ht.index_offset);
+    index_size = le64_to_cpu(ht.index_size);
+    virtual_size = le64_to_cpu(ht.virtual_size);
+
+    if (index_size > LSMT_MAX_RO_INDEX_ENTRIES) {
+        error_setg(errp, "LSMT index of %" PRIu64 " entries exceeds maximum "
+                         "%" PRId64, index_size, LSMT_MAX_RO_INDEX_ENTRIES);
+        return -EINVAL;
+    }
+    if (index_offset < LSMT_HT_SPACE ||
+        index_offset > index_bound ||
+        index_size * 16 > index_bound - index_offset) {
+        error_setg(errp, "invalid LSMT index location");
+        return -EINVAL;
+    }
+
+    /*
+     * both sizes come from the image, so the allocating variants that
+     * abort on OOM are not acceptable here; out: frees either pointer
+     */
+    index = g_try_new(OverlaybdSegment, index_size);
+    raw = qemu_try_blockalign(l->child->bs, index_size * 16);
+    if (!index || !raw) {
+        ret = -ENOMEM;
+        goto out;
+    }
+    ret = overlaybd_pread_view(l, index_offset, index_size * 16, raw);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not read LSMT index");
+        goto out;
+    }
+
+    moffset_end = index_offset / BDRV_SECTOR_SIZE;
+    for (uint64_t i = 0; i < index_size; i++) {
+        OverlaybdSegment seg, *out;
+
+        overlaybd_decode_entry(raw + i * 16, &seg);
+        if (seg.lba == LSMT_INVALID_OFFSET || seg.length == 0) {
+            continue;
+        }
+        if (count > 0 && seg.lba < prev_end) {
+            error_setg(errp, "LSMT index is disordered or overlapping");
+            ret = -EINVAL;
+            goto out;
+        }
+        if (seg.zeroed) {
+            if (seg.moffset < LSMT_MOFFSET_BEGIN ||
+                seg.moffset > moffset_end) {
+                error_setg(errp, "LSMT zeroed entry moffset out of range");
+                ret = -EINVAL;
+                goto out;
+            }
+        } else {
+            if (seg.moffset < LSMT_MOFFSET_BEGIN ||
+                seg.moffset >= moffset_end ||
+                seg.moffset + seg.length > moffset_end) {
+                error_setg(errp, "LSMT entry moffset out of range");
+                ret = -EINVAL;
+                goto out;
+            }
+        }
+        out = &index[count++];
+        *out = seg;
+        prev_end = seg.lba + seg.length;
+    }
+
+    l->index_offset = index_offset;
+    l->index = index;
+    index = NULL;
+    l->index_count = count;
+    l->virtual_size = virtual_size;
+    ret = 0;
+out:
+    qemu_vfree(raw);
+    g_free(index);
+    return ret;
+}
+
+static int GRAPH_RDLOCK
+overlaybd_detect_tar(OverlaybdLayer *l, int64_t child_size, Error **errp)
+{
+    uint8_t hdr[512];
+    uint64_t hoff = 0;
+    int ret;
+
+    l->base_offset = 0;
+    l->view_size = child_size;
+
+    if (child_size < 1024) {
+        return 0;
+    }
+    ret = bdrv_pread(l->child, 0, sizeof(hdr), hdr, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not read layer file header");
+        return ret;
+    }
+    if (memcmp(hdr + 257, "ustar", 5) != 0) {
+        return 0;
+    }
+    if (!overlaybd_is_tar_header(hdr)) {
+        error_setg(errp, "unsupported tar layer layout");
+        return -EINVAL;
+    }
+    if (hdr[156] == 'x') {
+        /*
+         * pax extended header: its size field gives the length of the
+         * attribute block that precedes the real ustar header
+         */
+        char size[13];
+        unsigned long long pax_size;
+
+        memcpy(size, hdr + 124, 12);
+        size[12] = 0;
+        if (qemu_strtou64(size, NULL, 8, &pax_size) < 0) {
+            pax_size = 0;
+        }
+        hoff = ZFILE_HT_SPACE +
+               DIV_ROUND_UP(pax_size, ZFILE_HT_SPACE) * ZFILE_HT_SPACE;
+        if (hoff + 2 * ZFILE_HT_SPACE > (uint64_t)child_size) {
+            error_setg(errp, "tar layer too small");
+            return -EINVAL;
+        }
+        ret = bdrv_pread(l->child, hoff, sizeof(hdr), hdr, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "could not read tar file header");
+            return ret;
+        }
+        if (memcmp(hdr + 257, "ustar", 5) != 0 ||
+            (hdr[156] != '0' && hdr[156] != '\0')) {
+            error_setg(errp, "unsupported tar layer layout");
+            return -EINVAL;
+        }
+    }
+
+    l->base_offset = hoff + ZFILE_HT_SPACE;
+    l->view_size = child_size - l->base_offset;
+    if (hdr[124] < 0x80) {
+        /*
+         * prefer the tar entry size: it is authoritative when the tar
+         * entry is padded
+         */
+        char size[13];
+        unsigned long long tar_size;
+
+        memcpy(size, hdr + 124, 12);
+        size[12] = 0;
+        if (!qemu_strtou64(size, NULL, 8, &tar_size) &&
+            tar_size > 0 && tar_size <= l->view_size) {
+            l->view_size = tar_size;
+        }
+    }
+    return 0;
+}
+
+static int GRAPH_RDLOCK
+overlaybd_open_layer(OverlaybdLayer *l, Error **errp)
+{
+    uint8_t buf[512];
+    int64_t child_size;
+    int ret;
+
+    child_size = bdrv_getlength(l->child->bs);
+    if (child_size < 0) {
+        error_setg_errno(errp, -child_size, "could not get layer file size");
+        return child_size;
+    }
+
+    ret = overlaybd_detect_tar(l, child_size, errp);
+    if (ret < 0) {
+        return ret;
+    }
+    if (l->view_size < 2 * ZFILE_HT_SPACE) {
+        error_setg(errp, "layer file too small");
+        return -EINVAL;
+    }
+
+    ret = bdrv_pread(l->child, l->base_offset, sizeof(buf), buf, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not read layer file header");
+        return ret;
+    }
+    if (overlaybd_is_zfile_header(buf) &&
+        (ldq_le_p(buf + 32) & ZFILE_FLAG_HEADER)) {
+        l->is_zfile = true;
+        ret = overlaybd_zfile_open(l, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return overlaybd_lsmt_open(l, errp);
+}
+
+/*
+ * First index whose entry covers or follows @sector: entries are sorted
+ * and non-overlapping, so entry ends are monotonically increasing.
+ * This matches the reference implementation's lower_bound(), which
+ * searches by entry end so that an entry covering @sector is found.
+ */
+static size_t overlaybd_find_segment(const OverlaybdSegment *a, size_t n,
+                                     uint64_t sector)
+{
+    size_t lo = 0, hi = n;
+
+    while (lo < hi) {
+        size_t mid = (lo + hi) / 2;
+
+        if (a[mid].lba + a[mid].length <= sector) {
+            lo = mid + 1;
+        } else {
+            hi = mid;
+        }
+    }
+    return lo;
+}
+
+/*
+ * Merge the per-layer indexes into s->merged: layers[0] is the topmost
+ * layer; a layer's mapping wins its whole extent, lower layers fill the
+ * holes. Entries pushed for [begin, end) are edge-trimmed to that range.
+ */
+static bool overlaybd_merge_level(BDRVOverlaybdState *s, int level,
+                                  uint64_t begin, uint64_t end, size_t *count)
+{
+    OverlaybdLayer *l;
+    size_t i, size0 = *count;
+    uint64_t begin0 = begin;
+
+    if (level >= s->nb_layers || begin >= end) {
+        return true;
+    }
+    l = &s->layers[level];
+    for (i = overlaybd_find_segment(l->index, l->index_count, begin);
+         i < l->index_count && l->index[i].lba < end; i++) {
+        OverlaybdSegment *e = &l->index[i];
+
+        if (e->lba > begin &&
+            !overlaybd_merge_level(s, level + 1, begin, e->lba, count)) {
+            return false;
+        }
+        if (*count == s->merged_cap) {
+            /*
+             * One input entry can be emitted several times when it is
+             * split by ranges covered (or zeroed) at upper layers, so the
+             * output can exceed the sum of the input indexes -- hence the
+             * cap, which upstream enforces at the same point.  Grow into a
+             * temporary so that a failed realloc leaves s->merged valid
+             * for overlaybd_close() to free.
+             */
+            size_t cap = s->merged_cap ? s->merged_cap * 2 : 64;
+            OverlaybdSegment *grown;
+
+            if (cap > LSMT_MAX_MERGED_ENTRIES) {
+                return false;
+            }
+            grown = g_try_renew(OverlaybdSegment, s->merged, cap);
+            if (!grown) {
+                return false;
+            }
+            s->merged = grown;
+            s->merged_cap = cap;
+        }
+        s->merged[*count] = *e;
+        s->merged[*count].layer = level;
+        (*count)++;
+        begin = e->lba + e->length;
+    }
+    if (begin < end &&
+        !overlaybd_merge_level(s, level + 1, begin, end, count)) {
+        return false;
+    }
+    if (*count > size0) {
+        OverlaybdSegment *first = &s->merged[size0];
+        OverlaybdSegment *last = &s->merged[*count - 1];
+
+        if (first->lba < begin0) {
+            uint64_t delta = begin0 - first->lba;
+
+            first->length -= delta;
+            first->lba = begin0;
+            if (!first->zeroed) {
+                first->moffset += delta;
+            }
+        }
+        if (last->lba + last->length > end) {
+            last->length = end - last->lba;
+        }
+    }
+    return true;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+overlaybd_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                    QEMUIOVector *qiov, BdrvRequestFlags flags)
+{
+    BDRVOverlaybdState *s = bs->opaque;
+    uint64_t cur = offset >> BDRV_SECTOR_BITS;
+    uint64_t end = cur + (bytes >> BDRV_SECTOR_BITS);
+    size_t done = 0;
+    int ret = 0;
+
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+
+    while (cur < end) {
+        OverlaybdSegment *e;
+        OverlaybdLayer *l;
+        uint64_t run, run_end;
+        size_t idx = overlaybd_find_segment(s->merged, s->merged_count, cur);
+
+        if (idx == s->merged_count || s->merged[idx].lba >= end) {
+            qemu_iovec_memset(qiov, done, 0, (end - cur) * BDRV_SECTOR_SIZE);
+            break;
+        }
+        e = &s->merged[idx];
+        if (e->lba > cur) {
+            run = (e->lba - cur) * BDRV_SECTOR_SIZE;
+            qemu_iovec_memset(qiov, done, 0, run);
+            done += run;
+            cur = e->lba;
+        }
+        run_end = MIN(end, e->lba + e->length);
+        run = (run_end - cur) * BDRV_SECTOR_SIZE;
+        if (e->zeroed) {
+            qemu_iovec_memset(qiov, done, 0, run);
+        } else {
+            int64_t off = (e->moffset + (cur - e->lba)) * BDRV_SECTOR_SIZE;
+
+            l = &s->layers[e->layer];
+            if (l->is_zfile) {
+                ret = overlaybd_zfile_read(l, off, run, NULL, qiov, done);
+            } else {
+                ret = bdrv_co_preadv_part(l->child, l->base_offset + off, run,
+                                          qiov, done, 0);
+            }
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        done += run;
+        cur = run_end;
+    }
+    return ret;
+}
+
+static void overlaybd_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    bs->bl.request_alignment = BDRV_SECTOR_SIZE;
+}
+
+static int overlaybd_probe(const uint8_t *buf, int buf_size,
+                           const char *filename)
+{
+    if (buf_size < 24) {
+        return 0;
+    }
+    /*
+     * Only a bare LSMT or ZFile magic is distinctive enough to claim a file.
+     * A tar-wrapped layer shows just its entry header here, the payload
+     * starting past the 512-byte probe window, and tar is far too generic a
+     * container to claim on that evidence -- every unrelated archive would
+     * then fail to open instead of being read as raw. So a tar-wrapped layer
+     * must be named explicitly (-f overlaybd, file.driver=,
+     * layers.<n>.driver= or a manifest), all of which bypass probing.
+     */
+    if (overlaybd_is_lsmt_header(buf) || overlaybd_is_zfile_header(buf)) {
+        return 100;
+    }
+    return 0;
+}
+
+static void overlaybd_close(BlockDriverState *bs)
+{
+    BDRVOverlaybdState *s = bs->opaque;
+    int i;
+
+    bdrv_graph_wrlock_drained();
+    for (i = 0; i < s->nb_layers; i++) {
+        if (s->layers[i].child) {
+            bdrv_unref_child(bs, s->layers[i].child);
+            s->layers[i].child = NULL;
+        }
+    }
+    bdrv_graph_wrunlock();
+
+    for (i = 0; i < s->nb_layers; i++) {
+        g_free(s->layers[i].zf.partial_offset);
+        g_free(s->layers[i].zf.deltas);
+        g_free(s->layers[i].index);
+    }
+    g_free(s->layers);
+    s->layers = NULL;
+    s->nb_layers = 0;
+    g_free(s->merged);
+    s->merged = NULL;
+    s->merged_count = 0;
+}
+
+/*
+ * Manifest handling: the layer stack comes either from an OCI image manifest
+ * (manifest option, or the file child content) or from an explicit
+ * bottom-first "layers" array. Of a manifest only "schemaVersion" (must be 2)
+ * and "layers" (non-empty, bottom-first) are read, and of each layer
+ * descriptor only "digest"; everything else -- the top-level "mediaType",
+ * "annotations", "subject" and the whole "config" descriptor -- is ignored,
+ * so the image config blob is never fetched.
+ *
+ * Blobs are named after the root they live under: ROOT/<alg>/<hex> for an OCI
+ * image layout's blobs/ or an explicit blob-path, or ROOT/<hex> when ROOT is
+ * itself an <alg> directory, i.e. the manifest is a sibling of the layers it
+ * names (an OCI layout read from inside blobs/sha256/, or a containerd
+ * content store).
+ *
+ * Specifications:
+ *   image manifest (schemaVersion, layers)
+ *     https://github.com/opencontainers/image-spec/blob/main/manifest.md
+ *   descriptor "digest" grammar, narrowed by overlaybd_parse_digest()
+ *     https://github.com/opencontainers/image-spec/blob/main/descriptor.md
+ *   the blobs/<alg>/<hex> directory layout
+ *     https://github.com/opencontainers/image-spec/blob/main/image-layout.md
+ */
+
+typedef enum {
+    OBD_BLOB_DIR,
+    OBD_BLOB_SIBLING,
+} OverlaybdBlobKind;
+
+typedef struct OverlaybdBlobRoot {
+    char *path;
+    OverlaybdBlobKind kind;
+    GPtrArray *blobs;
+} OverlaybdBlobRoot;
+
+#define OCI_DIGEST_ALG_MAX 32
+#define OCI_DIGEST_HEX_MAX 128
+/* an OCI image manifest is a few kilobytes; anything larger is not one */
+#define OCI_MANIFEST_MAX_SIZE (1u << 20)
+
+static char *overlaybd_blob_path(const OverlaybdBlobRoot *root,
+                                 const char *alg, const char *hex)
+{
+    switch (root->kind) {
+    case OBD_BLOB_SIBLING:
+        return g_strdup_printf("%s/%s", root->path, hex);
+    case OBD_BLOB_DIR:
+        return g_strdup_printf("%s/%s/%s", root->path, alg, hex);
+    }
+    g_assert_not_reached();
+}
+
+/*
+ * Validate a digest and split it into algorithm and hex parts. Both are used
+ * verbatim as path components, so anything outside the OCI grammar -- in
+ * particular "." and "/" -- is rejected. The grammar also allows separators
+ * in the algorithm and uppercase hex; both are excluded on purpose, since
+ * every tool in practice emits a lowercase "sha256" and narrowing the set
+ * costs nothing.
+ */
+static int overlaybd_parse_digest(const char *digest, char **alg, char **hex,
+                                  Error **errp)
+{
+    static const char alg_chars[] = "abcdefghijklmnopqrstuvwxyz0123456789";
+    static const char hex_chars[] = "0123456789abcdef";
+    const char *colon = strchr(digest, ':');
+    size_t alen, hlen;
+
+    if (!colon || strchr(colon + 1, ':')) {
+        goto invalid;
+    }
+    alen = colon - digest;
+    hlen = strlen(colon + 1);
+    if (alen < 1 || alen > OCI_DIGEST_ALG_MAX ||
+        hlen < 1 || hlen > OCI_DIGEST_HEX_MAX ||
+        strspn(digest, alg_chars) != alen ||
+        strspn(colon + 1, hex_chars) != hlen) {
+        goto invalid;
+    }
+
+    *alg = g_strndup(digest, alen);
+    *hex = g_strdup(colon + 1);
+    return 0;
+
+invalid:
+    error_setg(errp, "invalid layer digest '%s'", digest);
+    return -EINVAL;
+}
+
+static int overlaybd_reject_url(const char *what, const char *ref,
+                                Error **errp)
+{
+    if (path_has_protocol(ref)) {
+        error_setg(errp, "%s '%s' is a URL; only local files are supported",
+                   what, ref);
+        return -ENOTSUP;
+    }
+    return 0;
+}
+
+/*
+ * Put an explicit file child reference under @key, so that the blob is
+ * opened without format probing. A bare string reference would instead be
+ * looked up as a node name.
+ */
+static void overlaybd_put_child(QDict *options, const char *key,
+                                const char *value)
+{
+    /* two variables: reassigning a g_autofree one leaks the old value */
+    g_autofree char *drv_key = g_strdup_printf("%s.driver", key);
+    g_autofree char *ref = g_strdup_printf("%s.filename", key);
+
+    qdict_put_str(options, drv_key, "file");
+    qdict_put_str(options, ref, value);
+}
+
+static int overlaybd_blob_root_from_option(const char *blob_path,
+                                           OverlaybdBlobRoot *root,
+                                           Error **errp)
+{
+    char *end;
+    int ret;
+
+    ret = overlaybd_reject_url("blob-path", blob_path, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    root->path = g_strdup(blob_path);
+    end = root->path + strlen(root->path);
+    while (end > root->path && end[-1] == '/') {
+        *--end = '\0';
+    }
+    if (!*root->path) {
+        error_setg(errp, "blob-path is empty");
+        g_free(root->path);
+        root->path = NULL;
+        return -EINVAL;
+    }
+    root->kind = OBD_BLOB_DIR;
+    return 0;
+}
+
+static int overlaybd_derive_blob_root(const char *manifest, const char *alg,
+                                      OverlaybdBlobRoot *root, Error **errp)
+{
+    g_autofree char *dir = NULL;
+    g_autofree char *base = NULL;
+    g_autofree char *alg_dir = NULL;
+
+    root->path = NULL;
+
+    dir = g_path_get_dirname(manifest);
+    base = g_path_get_basename(dir);
+    if (strcmp(base, alg) == 0) {
+        root->path = g_strdup(dir);
+        root->kind = OBD_BLOB_SIBLING;
+        return 0;
+    }
+
+    /*
+     * Otherwise the blobs are grouped by algorithm in a directory beside
+     * the manifest, either directly or under the blobs/ of an OCI image
+     * layout. The root is that directory's parent, since a directory root
+     * composes ROOT/<alg>/<hex>.
+     */
+    alg_dir = g_build_filename(dir, alg, NULL);
+    if (g_file_test(alg_dir, G_FILE_TEST_IS_DIR)) {
+        root->path = g_strdup(dir);
+    } else {
+        root->path = g_build_filename(dir, "blobs", NULL);
+        if (!g_file_test(root->path, G_FILE_TEST_IS_DIR)) {
+            error_setg(errp, "could not find the blobs of manifest '%s': no "
+                       "%s/ or blobs/ directory beside it; give blob-path",
+                       manifest, alg);
+            g_free(root->path);
+            root->path = NULL;
+            return -ENOENT;
+        }
+    }
+    root->kind = OBD_BLOB_DIR;
+    return 0;
+}
+
+static int overlaybd_parse_manifest(const char *content, QDict **manifest_out,
+                                    Error **errp)
+{
+    QDict *manifest;
+    QObject *obj;
+    int64_t version;
+
+    obj = qobject_from_json(content, errp);
+    if (!obj) {
+        return -EINVAL;
+    }
+    manifest = qobject_to(QDict, obj);
+    if (!manifest) {
+        error_setg(errp, "overlaybd manifest root is not a JSON object");
+        qobject_unref(obj);
+        return -EINVAL;
+    }
+
+    version = qdict_get_try_int(manifest, "schemaVersion", 0);
+    if (version != 2) {
+        error_setg(errp, "unsupported OCI schemaVersion %" PRId64 ", "
+                   "expected 2", version);
+        qobject_unref(obj);
+        return -ENOTSUP;
+    }
+    if (!qobject_to(QList, qdict_get(manifest, "layers"))) {
+        error_setg(errp, "overlaybd manifest has no \"layers\" array");
+        qobject_unref(obj);
+        return -EINVAL;
+    }
+    *manifest_out = manifest;
+    return 0;
+}
+
+static int overlaybd_paths_from_manifest(QDict *manifest, const char *location,
+                                         OverlaybdBlobRoot *root, Error **errp)
+{
+    QList *layers = qobject_to(QList, qdict_get(manifest, "layers"));
+    const QListEntry *entry;
+    int i = 0, ret;
+
+    for (entry = qlist_first(layers); entry; entry = qlist_next(entry)) {
+        QDict *desc = qobject_to(QDict, entry->value);
+        const char *digest = desc ? qdict_get_try_str(desc, "digest") : NULL;
+        g_autofree char *alg = NULL;
+        g_autofree char *hex = NULL;
+
+        if (!digest) {
+            error_setg(errp, "layers[%d] has no digest", i);
+            return -EINVAL;
+        }
+        ret = overlaybd_parse_digest(digest, &alg, &hex, errp);
+        if (ret < 0) {
+            return ret;
+        }
+        if (i == 0 && !root->path) {
+            ret = overlaybd_derive_blob_root(location, alg, root, errp);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+        g_ptr_array_add(root->blobs, overlaybd_blob_path(root, alg, hex));
+        i++;
+    }
+    if (i == 0) {
+        error_setg(errp, "overlaybd manifest has no layers");
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int overlaybd_layers_from_options(QDict *options, int nb_layers,
+                                         Error **errp)
+{
+    int i;
+
+    for (i = 0; i < nb_layers; i++) {
+        char key[32];
+        const char *val;
+        int n, ret;
+
+        n = snprintf(key, sizeof(key), "layers.%d", i);
+        assert(n < (int)sizeof(key));
+
+        val = qdict_get_try_str(options, key);
+        if (val) {
+            g_autofree char *path = g_strdup(val);
+
+            ret = overlaybd_reject_url("layer", path, errp);
+            if (ret < 0) {
+                return ret;
+            }
+            qdict_del(options, key);
+            overlaybd_put_child(options, key, path);
+        }
+    }
+    return 0;
+}
+
+static int overlaybd_open_layers(BlockDriverState *bs, QDict *options,
+                                 const OverlaybdBlobRoot *root, int nb_layers,
+                                 BdrvChild *file_layer, Error **errp)
+{
+    BDRVOverlaybdState *s = bs->opaque;
+    int ret;
+    int i;
+
+    if (nb_layers > LSMT_MAX_LAYERS) {
+        error_setg(errp, "too many overlaybd layers (%d, maximum %d)",
+                   nb_layers, LSMT_MAX_LAYERS);
+        return -EINVAL;
+    }
+
+    s->layers = g_new0(OverlaybdLayer, nb_layers);
+    s->nb_layers = nb_layers;
+
+    if (file_layer) {
+        s->layers[0].child = file_layer;
+    } else {
+        for (i = 0; i < nb_layers; i++) {
+            BdrvChild *child;
+            char key[32];
+            int n;
+
+            if (root) {
+                n = snprintf(key, sizeof(key), "layer.%d", i);
+                assert(n < (int)sizeof(key));
+                overlaybd_put_child(options, key, root->blobs->pdata[i]);
+            } else {
+                n = snprintf(key, sizeof(key), "layers.%d", i);
+                assert(n < (int)sizeof(key));
+            }
+
+            child = bdrv_open_child(NULL, options, key, bs, &child_of_bds,
+                                    BDRV_CHILD_DATA | BDRV_CHILD_METADATA,
+                                    false, errp);
+            if (!child) {
+                ret = -EINVAL;
+                goto fail;
+            }
+            /*
+             * fill top-first: the last path (bottom-first) is the top
+             * layer
+             */
+            s->layers[nb_layers - 1 - i].child = child;
+        }
+    }
+
+    bdrv_graph_rdlock_main_loop();
+    for (i = 0; i < nb_layers; i++) {
+        ret = overlaybd_open_layer(&s->layers[i], errp);
+        if (ret < 0) {
+            goto unlock_fail;
+        }
+    }
+
+    s->merged_cap = 64;
+    s->merged = g_new(OverlaybdSegment, s->merged_cap);
+    if (!overlaybd_merge_level(s, 0, 0, UINT64_MAX, &s->merged_count)) {
+        error_setg(errp, "failed to merge overlaybd layer indexes");
+        ret = -EINVAL;
+        goto unlock_fail;
+    }
+
+    s->virtual_size = 0;
+    for (i = 0; i < nb_layers; i++) {
+        if (s->layers[i].virtual_size != 0) {
+            s->virtual_size = s->layers[i].virtual_size;
+            break;
+        }
+    }
+    if (s->virtual_size == 0) {
+        error_setg(errp, "overlaybd image has zero virtual size");
+        ret = -EINVAL;
+        goto unlock_fail;
+    }
+    /* DIV_ROUND_UP() below would wrap around to a zero-length image */
+    if (s->virtual_size > UINT64_MAX - (BDRV_SECTOR_SIZE - 1)) {
+        error_setg(errp, "overlaybd image virtual size %" PRIu64 " is too "
+                   "large", s->virtual_size);
+        ret = -EINVAL;
+        goto unlock_fail;
+    }
+
+    bs->total_sectors = DIV_ROUND_UP(s->virtual_size, BDRV_SECTOR_SIZE);
+    bdrv_graph_rdunlock_main_loop();
+    return 0;
+
+unlock_fail:
+    bdrv_graph_rdunlock_main_loop();
+fail:
+    return ret;
+}
+
+static int overlaybd_open(BlockDriverState *bs, QDict *options, int flags,
+                          Error **errp)
+{
+    g_autofree char *manifest_opt = NULL;
+    g_autofree char *blob_path = NULL;
+    OverlaybdBlobRoot root = { 0 };
+    const OverlaybdBlobRoot *blobs = NULL;
+    QDict *manifest = NULL;
+    const char *location = NULL;
+    char *content = NULL;
+    BdrvChild *file_layer = NULL;
+    bool use_file_child;
+    int nb_layers = 0;
+    int ret;
+
+    GLOBAL_STATE_CODE();
+
+    bdrv_graph_rdlock_main_loop();
+    ret = bdrv_apply_auto_read_only(bs, NULL, errp);
+    bdrv_graph_rdunlock_main_loop();
+    if (ret < 0) {
+        return ret;
+    }
+
+    qdict_flatten(options);
+
+    /* copy before deleting: qdict_get_try_str() borrows from the entry */
+    manifest_opt = g_strdup(qdict_get_try_str(options, "manifest"));
+    blob_path = g_strdup(qdict_get_try_str(options, "blob-path"));
+    qdict_del(options, "manifest");
+    qdict_del(options, "blob-path");
+    use_file_child = qdict_haskey(options, "file");
+    nb_layers = qdict_array_entries(options, "layers.");
+    if (nb_layers < 0) {
+        error_setg(errp, "option layers is not a valid array");
+        return -EINVAL;
+    }
+    if ((manifest_opt != NULL) + use_file_child + (nb_layers > 0) > 1) {
+        error_setg(errp, "only one of manifest, file or layers may be given");
+        return -EINVAL;
+    }
+    if (!manifest_opt && !use_file_child && nb_layers == 0) {
+        error_setg(errp, "either manifest, file or layers is required");
+        return -EINVAL;
+    }
+    if (blob_path && !manifest_opt && !use_file_child) {
+        error_setg(errp, "blob-path requires a manifest");
+        return -EINVAL;
+    }
+
+    if (manifest_opt) {
+        gsize len;
+
+        ret = overlaybd_reject_url("manifest", manifest_opt, errp);
+        if (ret < 0) {
+            return ret;
+        }
+        if (!g_file_get_contents(manifest_opt, &content, &len, NULL)) {
+            error_setg(errp, "could not read overlaybd manifest '%s'",
+                       manifest_opt);
+            return -ENOENT;
+        }
+        location = manifest_opt;
+    } else if (use_file_child) {
+        uint8_t sniff[512];
+        const uint8_t *p, *end;
+        int64_t len;
+
+        ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
+        if (ret < 0) {
+            return ret;
+        }
+        /*
+         * The file child is either an OCI image manifest or a single layer,
+         * possibly inside a tar and/or ZFile shell. No layer magic starts
+         * with '{', so a JSON document is a manifest and anything else is a
+         * layer; overlaybd_open_layer() peels the shells and requires an
+         * LSMT core.
+         */
+        bdrv_graph_rdlock_main_loop();
+        len = bdrv_getlength(bs->file->bs);
+        if (len < 0) {
+            bdrv_graph_rdunlock_main_loop();
+            error_setg_errno(errp, -len, "could not get the file child size");
+            ret = len;
+            goto out;
+        }
+        memset(sniff, 0, sizeof(sniff));
+        ret = bdrv_pread(bs->file, 0, MIN((uint64_t)len, sizeof(sniff)),
+                         sniff, 0);
+        if (ret < 0) {
+            bdrv_graph_rdunlock_main_loop();
+            error_setg_errno(errp, -ret, "could not read the file child");
+            goto out;
+        }
+        location = bs->file->bs->filename;
+        end = sniff + MIN((uint64_t)len, sizeof(sniff));
+        for (p = sniff; p < end && g_ascii_isspace(*p); p++) {
+        }
+        if (p == end || *p != '{') {
+            file_layer = bs->file;
+            nb_layers = 1;
+            bdrv_graph_rdunlock_main_loop();
+        } else {
+            /*
+             * @len comes from the child rather than from overlaybd, so it
+             * cannot be handed to g_malloc() unchecked; a real manifest is
+             * a few kilobytes.
+             */
+            if (len > OCI_MANIFEST_MAX_SIZE) {
+                bdrv_graph_rdunlock_main_loop();
+                error_setg(errp, "file child starts like a JSON manifest but "
+                           "is %" PRId64 " bytes, above the %u byte limit",
+                           len, OCI_MANIFEST_MAX_SIZE);
+                ret = -EINVAL;
+                goto out;
+            }
+            content = g_malloc(len + 1);
+            ret = bdrv_pread(bs->file, 0, len, content, 0);
+            if (ret >= 0) {
+                content[len] = 0;
+                ret = 0;
+            } else {
+                error_setg_errno(errp, -ret,
+                                 "could not read overlaybd manifest");
+            }
+            bdrv_graph_rdunlock_main_loop();
+            if (ret < 0) {
+                goto out;
+            }
+        }
+    }
+
+    if (!file_layer) {
+        if (content) {
+            ret = overlaybd_parse_manifest(content, &manifest, errp);
+            if (ret < 0) {
+                goto out;
+            }
+            root.blobs = g_ptr_array_new_with_free_func(g_free);
+            if (blob_path) {
+                ret = overlaybd_blob_root_from_option(blob_path, &root, errp);
+                if (ret < 0) {
+                    goto out;
+                }
+            }
+            ret = overlaybd_paths_from_manifest(manifest, location, &root,
+                                                errp);
+            if (ret < 0) {
+                goto out;
+            }
+            nb_layers = root.blobs->len;
+            blobs = &root;
+        } else {
+            ret = overlaybd_layers_from_options(options, nb_layers, errp);
+            if (ret < 0) {
+                goto out;
+            }
+        }
+    }
+
+    ret = overlaybd_open_layers(bs, options, blobs, nb_layers, file_layer,
+                                errp);
+
+out:
+    g_free(root.path);
+    if (root.blobs) {
+        g_ptr_array_free(root.blobs, TRUE);
+    }
+    qobject_unref(manifest);
+    g_free(content);
+    if (ret < 0) {
+        overlaybd_close(bs);
+    }
+    return ret;
+}
+
+static BlockDriver bdrv_overlaybd = {
+    .format_name         = "overlaybd",
+    .instance_size       = sizeof(BDRVOverlaybdState),
+    .bdrv_probe          = overlaybd_probe,
+    .bdrv_open           = overlaybd_open,
+    .bdrv_child_perm     = bdrv_default_perms,
+    .bdrv_refresh_limits = overlaybd_refresh_limits,
+    .bdrv_co_preadv      = overlaybd_co_preadv,
+    .bdrv_close          = overlaybd_close,
+    .is_format           = true,
+};
+
+static void bdrv_overlaybd_init(void)
+{
+    bdrv_register(&bdrv_overlaybd);
+}
+
+block_init(bdrv_overlaybd_init);
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 675daa72f9..2569f42e52 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -391,6 +391,43 @@ More disk image file formats are supported in a read-only mode.
 
   Apple disk image.
 
+.. program:: image-formats
+.. option:: overlaybd
+
+  Overlaybd image, the layered format used by containerd's overlaybd
+  snapshotter.  Each layer holds over-written data blocks, optionally
+  compressed block-wise with LZ4 or ZSTD and optionally wrapped in a
+  single-file tar.  Only sealed layers can be read; compressed layers
+  need QEMU built with lz4 / zstd support respectively.  See
+  https://github.com/containerd/overlaybd for the format specification.
+
+  The layer stack is given by exactly one of:
+
+  - ``manifest=<path>``: an OCI image manifest whose ``layers`` array
+    (bottom-first, of each entry only ``digest`` is used) names the layer
+    blobs, plus an optional ``blob-path=<root>`` saying where they are.
+    The root defaults to the blobs beside the manifest, which covers an
+    OCI image layout and a containerd content store.
+
+  - ``layers.<n>.driver=file,layers.<n>.filename=<path>``: an explicit
+    bottom-first list, the first element the base layer and the last the
+    top layer.
+
+  - a ``file`` child holding a manifest or a single sealed layer, as
+    ``-drive file=<path>`` provides.  A manifest must be named with
+    ``format=overlaybd``, since probing cannot recognise JSON.
+
+  A bare layer is detected by probing; a tar-wrapped one is not, as
+  probing sees only the tar entry header, so it must be named explicitly
+  via ``-f overlaybd``, a ``file`` child, ``layers.<n>`` or a manifest.
+  Tar-wrapped layers are usually shipped gzip-compressed and must be
+  unpacked first, since the driver reads an uncompressed tar.
+
+  For example::
+
+    qemu-img info --image-opts driver=overlaybd,manifest=manifest.json,\
+    blob-path=/var/lib/containerd/io.containerd.content.v1.content/blobs
+
 .. program:: image-formats
 .. option:: parallels
 
diff --git a/meson.build b/meson.build
index cfac634cf1..d7468db2a7 100644
--- a/meson.build
+++ b/meson.build
@@ -1391,6 +1391,12 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+lz4 = not_found
+if not get_option('lz4').auto() or have_block
+  lz4 = dependency('liblz4', version: '>=1.8.0',
+                   required: get_option('lz4'),
+                   method: 'pkg-config')
+endif
 qpl = not_found
 if not get_option('qpl').auto() or have_system
   qpl = dependency('qpl', version: '>=1.5.0',
@@ -2542,6 +2548,7 @@ config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm3.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_LZ4', lz4.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
 config_host_data.set('CONFIG_QATZIP', qatzip.found())
@@ -4856,6 +4863,7 @@ if have_block
   summary_info += {'bochs support':     get_option('bochs').allowed()}
   summary_info += {'cloop support':     get_option('cloop').allowed()}
   summary_info += {'dmg support':       get_option('dmg').allowed()}
+  summary_info += {'overlaybd support': get_option('overlaybd').allowed()}
   summary_info += {'qcow v1 support':   get_option('qcow1').allowed()}
   summary_info += {'vdi support':       get_option('vdi').allowed()}
   summary_info += {'vhdx support':      get_option('vhdx').allowed()}
@@ -4989,6 +4997,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'lz4 support':       lz4}
 summary_info += {'Query Processing Library support': qpl}
 summary_info += {'UADK Library support': uadk}
 summary_info += {'qatzip support':    qatzip}
diff --git a/meson_options.txt b/meson_options.txt
index 6c2de6296f..a1b2ca6e56 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -270,6 +270,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
+option('lz4', type : 'feature', value : 'auto',
+       description: 'lz4 compression support')
 option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
 option('uadk', type : 'feature', value : 'auto',
@@ -339,6 +341,8 @@ option('cloop', type: 'feature', value: 'auto',
        description: 'cloop image format support')
 option('dmg', type: 'feature', value: 'auto',
        description: 'dmg image format support')
+option('overlaybd', type: 'feature', value: 'auto',
+       description: 'overlaybd image format support')
 option('qcow1', type: 'feature', value: 'auto',
        description: 'qcow1 image format support')
 option('vdi', type: 'feature', value: 'auto',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index aed2888147..18a3fe8a95 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3390,6 +3390,7 @@
             'iscsi',
             'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme',
             { 'name': 'nvme-io_uring', 'if': 'CONFIG_BLKIO' },
+            'overlaybd',
             'parallels', 'preallocate', 'qcow', 'qcow2', 'qed', 'quorum',
             'raw', 'rbd',
             { 'name': 'replication', 'if': 'CONFIG_REPLICATION' },
@@ -4182,6 +4183,43 @@
   'data': { 'path': 'str' },
   'if': 'CONFIG_BLKIO' }
 
+##
+# @BlockdevOptionsOverlaybd:
+#
+# Driver specific block device options for overlaybd (read-only).
+#
+# @manifest: an OCI image manifest naming the layer stack.  Its
+#     "layers" array is read bottom-first and only the "digest" of
+#     each entry is used; the image config blob is never fetched.
+#
+# @blob-path: directory the layer digests are resolved against.
+#     Optional, and derived from @manifest when absent.  Blobs are
+#     looked up as BLOB-PATH/<alg>/<hex>, i.e. the blobs/ of an OCI
+#     image layout.  A derived root is the blobs/ directory beside
+#     the manifest, except when the manifest is itself a blob, as in
+#     an OCI image layout addressed by digest or a containerd content
+#     store, in which case the layers are its siblings,
+#     BLOB-PATH/<hex>.
+#
+# @layers: explicit layer list, bottom-first: the first element is the
+#     base layer, the last element is the top layer (the same order as
+#     the "layers" array of an OCI image manifest)
+#
+# @file: the image to open, which may be either an OCI image manifest
+#     or a bare sealed layer file, i.e. a single-layer image
+#
+# Exactly one of @manifest, @layers and @file must be given, and
+# @blob-path only with a manifest.  Every reference is a local file;
+# a URL is rejected.
+#
+# Since: 11.2
+##
+{ 'struct': 'BlockdevOptionsOverlaybd',
+  'data': { '*manifest': 'str',
+            '*blob-path': 'str',
+            '*layers': [ 'BlockdevRef' ],
+            '*file': 'BlockdevRef' } }
+
 ##
 # @BlockdevOptionsVirtioBlkVfioPci:
 #
@@ -4905,6 +4943,7 @@
       'nvme':       'BlockdevOptionsNVMe',
       'nvme-io_uring': { 'type': 'BlockdevOptionsNvmeIoUring',
                          'if': 'CONFIG_BLKIO' },
+      'overlaybd':  'BlockdevOptionsOverlaybd',
       'parallels':  'BlockdevOptionsGenericFormat',
       'preallocate':'BlockdevOptionsPreallocate',
       'qcow2':      'BlockdevOptionsQcow2',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 08c9fbb62c..a7bfcce254 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -153,6 +153,7 @@ meson_options_help() {
   printf "%s\n" '  libvduse        build VDUSE Library'
   printf "%s\n" '  linux-aio       Linux AIO support'
   printf "%s\n" '  linux-io-uring  Linux io_uring support'
+  printf "%s\n" '  lz4             lz4 compression support'
   printf "%s\n" '  lzfse           lzfse support for DMG images'
   printf "%s\n" '  lzo             lzo compression support'
   printf "%s\n" '  malloc-trim     enable libc malloc_trim() for memory optimization'
@@ -168,6 +169,7 @@ meson_options_help() {
   printf "%s\n" '  nvmm            NVMM acceleration support'
   printf "%s\n" '  opengl          OpenGL support'
   printf "%s\n" '  oss             OSS sound support'
+  printf "%s\n" '  overlaybd       overlaybd image format support'
   printf "%s\n" '  pa              PulseAudio sound support'
   printf "%s\n" '  parallels       parallels image format support'
   printf "%s\n" '  passt           passt network backend support'
@@ -404,6 +406,8 @@ _meson_option_parse() {
     --disable-linux-io-uring) printf "%s" -Dlinux_io_uring=disabled ;;
     --localedir=*) quote_sh "-Dlocaledir=$2" ;;
     --localstatedir=*) quote_sh "-Dlocalstatedir=$2" ;;
+    --enable-lz4) printf "%s" -Dlz4=enabled ;;
+    --disable-lz4) printf "%s" -Dlz4=disabled ;;
     --enable-lzfse) printf "%s" -Dlzfse=enabled ;;
     --disable-lzfse) printf "%s" -Dlzfse=disabled ;;
     --enable-lzo) printf "%s" -Dlzo=enabled ;;
@@ -438,6 +442,8 @@ _meson_option_parse() {
     --disable-opengl) printf "%s" -Dopengl=disabled ;;
     --enable-oss) printf "%s" -Doss=enabled ;;
     --disable-oss) printf "%s" -Doss=disabled ;;
+    --enable-overlaybd) printf "%s" -Doverlaybd=enabled ;;
+    --disable-overlaybd) printf "%s" -Doverlaybd=disabled ;;
     --enable-pa) printf "%s" -Dpa=enabled ;;
     --disable-pa) printf "%s" -Dpa=disabled ;;
     --enable-parallels) printf "%s" -Dparallels=enabled ;;
diff --git a/tests/qemu-iotests/tests/overlaybd b/tests/qemu-iotests/tests/overlaybd
new file mode 100755
index 0000000000..7ce102426f
--- /dev/null
+++ b/tests/qemu-iotests/tests/overlaybd
@@ -0,0 +1,795 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Test the read-only overlaybd block driver
+#
+# Builds a 3-layer stack (plain sealed LSMT base, LZ4 zfile middle layer
+# with a zeroed range, ZSTD zfile top layer inside a tar wrapper with
+# dirty header fields) plus a standalone LZ4 zfile of 16-byte blocks
+# whose jump table exceeds 1 MiB, with pure-Python encoders -- LZ4
+# literal-only and match-based blocks and ZSTD Raw_Blocks are valid
+# without any compression library -- and verifies byte-exact reads
+# through all interface forms plus the error paths.
+#
+# Copyright (c) 2026 Huiba Li <huiba.lhb@alibaba-inc.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import hashlib
+import json
+import os
+import shutil
+import struct
+
+import iotests
+from iotests import file_path, log, qemu_img
+
+BLOCK = 4096
+NBLOCKS = 256  # 1 MiB virtual image
+SECTORS_PER_BLOCK = BLOCK // 512
+
+LSMT_MAGIC0 = b'LSMT\x00\x01\x02\x00'
+LSMT_MAGIC1 = bytes([
+    0x65, 0x7e, 0x63, 0xd2, 0x94, 0x44, 0x08, 0x4c,
+    0xa2, 0xd2, 0xc8, 0xec, 0x4f, 0xcf, 0xae, 0x8a
+])
+ZFILE_MAGIC0 = b'ZFile\x00\x01\x00'
+ZFILE_MAGIC1 = b'tuji.yyf@Alibaba'
+
+
+def _crc32c_table() -> list:
+    table = []
+    for i in range(256):
+        c = i
+        for _ in range(8):
+            c = (0x82f63b78 ^ (c >> 1)) if (c & 1) else (c >> 1)
+        table.append(c)
+    return table
+
+
+CRC32C_TABLE = _crc32c_table()
+
+# zfile.cpp's NOI_WELL_KNOWN_PRIME: per-block CRCs are computed with this
+# seed rather than 0
+CRC32C_SALT = 100007
+
+
+def crc32c(data: bytes, crc: int = 0) -> int:
+    """Raw CRC-32C accumulation -- no init inversion and no final xor.
+
+    This is overlaybd's crc32::crc32c_extend(), which is NOT the standard
+    init-0xFFFFFFFF/xorout-0xFFFFFFFF CRC-32C. The two disagree on every
+    input, and a fixture that used the standard form would agree with a
+    driver that made the same mistake, so both would look correct while
+    rejecting every real image.
+    """
+    table = CRC32C_TABLE
+    for b in data:
+        crc = table[(crc ^ b) & 0xff] ^ (crc >> 8)
+    return crc
+
+
+def lz4_block_literals(data: bytes) -> bytes:
+    out = bytearray()
+    n = len(data)
+    if n < 15:
+        out.append(n << 4)
+    else:
+        out.append(15 << 4)
+        rest = n - 15
+        while rest >= 255:
+            out.append(255)
+            rest -= 255
+        out.append(rest)
+    out += data
+    return bytes(out)
+
+
+def lz4_block_zeros(n: int) -> bytes:
+    """LZ4 block decoding to @n zero bytes.
+
+    One literal, one offset-1 match, then the five trailing literals the
+    format requires; a block that ends in a match is rejected by
+    LZ4_decompress_safe, so this only works for n >= 12.
+    """
+    match = n - 6
+    assert match >= 4
+    out = bytearray()
+    ml = match - 4
+    nib = min(ml, 15)
+    out.append((1 << 4) | nib)
+    out.append(0)
+    out += struct.pack('<H', 1)
+    ml -= nib
+    if nib == 15:
+        while ml >= 255:
+            out.append(255)
+            ml -= 255
+        out.append(ml)
+    out.append(5 << 4)
+    out += bytes(5)
+    return bytes(out)
+
+
+def zstd_frame_raw(data: bytes) -> bytes:
+    out = bytearray(b'\x28\xb5\x2f\xfd\xe0')
+    out += struct.pack('<Q', len(data))
+    off = 0
+    while True:
+        chunk = data[off:off + 128 * 1024]
+        last = 1 if off + len(chunk) >= len(data) else 0
+        out += struct.pack('<I', (len(chunk) << 3) | last)[:3]
+        out += chunk
+        off += len(chunk)
+        if last:
+            break
+    return bytes(out)
+
+
+def fill_base(b: int) -> bytes:
+    return bytes((b * 7 + 13 + i) & 0xff for i in range(BLOCK))
+
+
+def fill_mid(b: int) -> bytes:
+    return bytes((b * 11 + 29 + i * 3) & 0xff for i in range(BLOCK))
+
+
+def fill_top(b: int) -> bytes:
+    return bytes((b * 5 + 101 + i * 7) & 0xff for i in range(BLOCK))
+
+
+def lsmt_header(flags: int, index_off: int, index_size: int,
+                virtual_size: int) -> bytes:
+    ht = bytearray(4096)
+    ht[0:8] = LSMT_MAGIC0
+    ht[8:24] = LSMT_MAGIC1
+    struct.pack_into('<I', ht, 24, 390)
+    struct.pack_into('<I', ht, 28, flags)
+    struct.pack_into('<Q', ht, 32, index_off)
+    struct.pack_into('<Q', ht, 40, index_size)
+    struct.pack_into('<Q', ht, 48, virtual_size)
+    return bytes(ht)
+
+
+def build_lsmt(spec: dict, pattern) -> bytes:
+    """spec maps 4K block index -> 1 (data) or 2 (zeroed); missing = hole."""
+    out = bytearray(4096)
+    data = bytearray()
+    slot_of = {}
+    for b in sorted(k for k, v in spec.items() if v == 1):
+        slot_of[b] = (4096 >> 9) + len(data) // BLOCK * SECTORS_PER_BLOCK
+        data += pattern(b)
+    index_off = 4096 + len(data)
+
+    index = bytearray()
+    keys = sorted(spec.keys())
+    i = 0
+    while i < len(keys):
+        j = i
+        while j + 1 < len(keys) and keys[j + 1] == keys[j] + 1 \
+                and spec[keys[j + 1]] == spec[keys[i]]:
+            j += 1
+        first, count = keys[i], keys[j] - keys[i] + 1
+        assert count * SECTORS_PER_BLOCK <= (1 << 14) - 1
+        lba = first * SECTORS_PER_BLOCK
+        length = count * SECTORS_PER_BLOCK
+        if spec[keys[i]] == 2:
+            moffset, zeroed = 8, 1
+        else:
+            moffset, zeroed = slot_of[first], 0
+        lo = lba | (length << 50)
+        hi = moffset | (zeroed << 55)
+        index += struct.pack('<QQ', lo, hi)
+        i = j + 1
+
+    out += data
+    out += index
+
+    for flags in (2 | 4, 1 | 2):  # trailer first, then header
+        ht = lsmt_header(flags, index_off, len(index) // 16, NBLOCKS * BLOCK)
+        if flags & 1:  # header goes over the placeholder
+            out[0:4096] = ht
+        else:
+            out += ht
+    return bytes(out)
+
+
+def wrap_zfile(content: bytes, algo: int, garbage: bool = False,
+               block: int = BLOCK, overwrite: bool = False,
+               bad_block_crc: bool = False) -> bytes:
+    """Wrap into a ZFile blob: algo 1 = LZ4, 2 = ZSTD. With garbage, the
+    digest flag is clear and the digest/crc fields carry junk, like real
+    baselayer files. With overwrite, the header carries the final metadata
+    and the trailer is left out -- upstream's HEADER_OVERWRITE shape, which
+    is what zfile_compress produces when it rewrites the header in place.
+
+    With bad_block_crc the first block's trailing CRC is wrong while its
+    compressed bytes stay valid, so only the driver's per-block checksum
+    can notice; corrupting the compressed stream instead would be caught
+    by the decompressor and would prove nothing about the checksum.
+
+    All-zero blocks use the compact match encoding: the reference jump
+    table stores in-group offsets as uint16, so the compressed blocks of
+    a group must together stay under 64 KiB, which literal-only encoding
+    cannot manage at a small block size."""
+    zero_chunk = bytes(block)
+    zero_c = lz4_block_zeros(block) if algo == 1 else None
+    body = bytearray()
+    jump = bytearray()
+    for off in range(0, len(content), block):
+        chunk = content[off:off + block]
+        if algo == 1:
+            if chunk == zero_chunk:
+                cdata = zero_c
+            else:
+                cdata = lz4_block_literals(chunk)
+        else:
+            cdata = zstd_frame_raw(chunk)
+        body += cdata
+        crc = crc32c(cdata, CRC32C_SALT)
+        if bad_block_crc and off == 0:
+            crc ^= 0xffffffff
+        body += struct.pack('<I', crc)
+        jump += struct.pack('<I', len(cdata) + 4)
+
+    out = bytearray()
+    index_off = 512 + len(body)
+    for is_header in (True, False):
+        if overwrite and not is_header:
+            break  # the header already carries the final metadata
+        ht = bytearray(512)
+        ht[0:8] = ZFILE_MAGIC0
+        ht[8:24] = ZFILE_MAGIC1
+        struct.pack_into('<I', ht, 24, 96)
+        flags = (1 if is_header else 0) | 2 | 4 | (1 << 4)
+        if overwrite:
+            flags |= 1 << 3
+        struct.pack_into('<Q', ht, 32, flags)
+        struct.pack_into('<Q', ht, 40, index_off)
+        struct.pack_into('<Q', ht, 48, len(content) // block
+                         + (1 if len(content) % block else 0))
+        struct.pack_into('<Q', ht, 56, len(content))
+        struct.pack_into('<I', ht, 64, crc32c(bytes(jump)))
+        struct.pack_into('<I', ht, 72, block)
+        ht[76] = algo
+        ht[88] = 1
+        if garbage:
+            struct.pack_into('<Q', ht, 32,
+                             (1 if is_header else 0) | 2 | 4)
+            struct.pack_into('<I', ht, 28,
+                             0xfeedface if is_header else 0xdeadbeef)
+            struct.pack_into('<I', ht, 64, 0xdeadbeef)
+            ht[300:304] = b'\x01\x02\x03\x04'
+        else:
+            struct.pack_into('<I', ht, 28, crc32c(bytes(ht)))
+        out += ht
+        if is_header:
+            out += body
+            out += jump
+    return bytes(out)
+
+
+# tar's default blocking factor: 20 x 512-byte records
+TAR_BLOCKING = 10240
+
+
+def wrap_tar(content: bytes) -> bytes:
+    """Tar wrapper with the padding a real archiver writes, so that the
+    archive ends well past the layer and the driver has to locate the
+    layer trailer from the entry size rather than from the file size."""
+    hdr = bytearray(512)
+    hdr[0:9] = b'layer.bin'
+    hdr[156] = ord('0')
+    # slice assignment lengths must match exactly, or the bytearray
+    # silently shrinks: 11 octal digits into the 12-byte size field
+    # (the 12th byte stays NUL), 6 digits into the 8-byte checksum
+    hdr[124:135] = b'%011o' % len(content)
+    hdr[257:263] = b'ustar\x00'
+    hdr[263:265] = b'00'
+    hdr[148:156] = b' ' * 8
+    hdr[148:154] = b'%06o' % (sum(hdr) & 0o777777)
+    out = bytes(hdr) + content
+    out += bytes(-len(out) % 512)
+    out += bytes(1024)
+    out += bytes(-len(out) % TAR_BLOCKING)
+    return out
+
+
+# A ZFile of 16-byte blocks needs a jump table above 1 MiB (the point
+# where the driver switches to parallel loading) once the content passes
+# 4 MiB. 16 is the smallest block size whose all-zero LZ4 block still
+# fits the uint16 in-group deltas, so the data region is that big.
+BIG_BLOCK = 16
+BIG_DATA = 4259840
+BIG_VIRT_SECTORS = 24
+
+
+def fill_big(tag: int) -> bytes:
+    return bytes((tag * 31 + i * 5 + 7) & 0xff for i in range(4096))
+
+
+def build_big_lsmt() -> tuple:
+    """LSMT blob with two mapped 4K blocks, at the start and at the far
+    end of an otherwise zero data region, plus the expected image.
+
+    The two blocks are 4 MiB apart, so reading them back exercises jump
+    table lookups in two different groups.
+    """
+    index_off = 4096 + BIG_DATA
+    far_moff = (index_off - 4096) // 512
+    index = struct.pack('<QQ', 8 << 50, 8)
+    index += struct.pack('<QQ', 8 | (8 << 50), far_moff)
+
+    blob = bytearray(4096)
+    blob += fill_big(1)
+    blob += bytes(BIG_DATA - 2 * 4096)
+    blob += fill_big(2)
+    blob += index
+    assert len(blob) == index_off + len(index)
+
+    for flags in (2 | 4, 1 | 2):
+        ht = lsmt_header(flags, index_off, len(index) // 16,
+                         BIG_VIRT_SECTORS * 512)
+        if flags & 1:
+            blob[0:4096] = ht
+        else:
+            blob += ht
+
+    expected = fill_big(1) + fill_big(2) + bytes(4096)
+    return bytes(blob), expected
+
+
+def corrupt_jump_table(src: str, dst: str, span: int) -> None:
+    """Copy a ZFile with every jump table entry rewritten to @span, fixing
+    up the index CRC and both header/trailer digests so that only the
+    entry values differ."""
+    with open(src, 'rb') as f:
+        img = bytearray(f.read())
+
+    index_off = struct.unpack_from('<Q', img, 40)[0]
+    index_size = struct.unpack_from('<Q', img, 48)[0]
+    for i in range(index_size):
+        struct.pack_into('<I', img, index_off + i * 4, span)
+
+    crc = crc32c(bytes(img[index_off:index_off + index_size * 4]))
+    for ht_off in (0, len(img) - 512):
+        ht = img[ht_off:ht_off + 512]
+        struct.pack_into('<I', ht, 28, 0)
+        struct.pack_into('<I', ht, 64, crc)
+        struct.pack_into('<I', ht, 28, crc32c(bytes(ht)))
+        img[ht_off:ht_off + 512] = ht
+
+    with open(dst, 'wb') as f:
+        f.write(img)
+
+
+mid_img = file_path('mid_lz4.zfile')
+top_img = file_path('top_zstd.tar')
+top_plain_img = file_path('top_plain.lsmt')
+oci_dir = file_path('oci.d')
+oci_blobs = os.path.join(oci_dir, 'blobs')
+oci_exported = os.path.join(oci_dir, 'manifest.json')
+alg_dir = file_path('algdir.d')
+alg_manifest = os.path.join(alg_dir, 'manifest.json')
+probe_img = file_path('probe.zfile')
+converted = file_path('converted.raw')
+garbage_img = file_path('garbage.bin')
+garbage_zfile = file_path('garbage.zfile')
+big_img = file_path('big_index.zfile')
+small_img = file_path('small_lz4.zfile')
+overwrite_img = file_path('overwrite_lz4.zfile')
+huge_img = file_path('huge_vsize.lsmt')
+overrun_img = file_path('overrun_index.lsmt')
+corrupt_img = file_path('corrupt_index.zfile')
+badcrc_img = file_path('bad_block_crc.zfile')
+junk_tar = file_path('junk.tar')
+badver_json = file_path('bad_schema_version.json')
+nolayers_json = file_path('no_layers.json')
+traverse_json = file_path('digest_traversal.json')
+missing_json = file_path('missing_blob.json')
+
+TOP_BLOCKS = {b: 1 for b in list(range(0, 51)) + list(range(150, 201))}
+MID_BLOCKS = {b: 1 for b in range(60, 161)}
+MID_BLOCKS.update({b: 2 for b in range(210, 221)})
+
+
+def expected_block(b: int) -> bytes:
+    if b in TOP_BLOCKS:
+        return fill_top(b)
+    if b in MID_BLOCKS:
+        return fill_mid(b) if MID_BLOCKS[b] == 1 else bytes(BLOCK)
+    return fill_base(b)
+
+
+def expected_image() -> bytes:
+    return b''.join(expected_block(b) for b in range(NBLOCKS))
+
+
+def top_only_image() -> bytes:
+    return b''.join(fill_top(b) if b in TOP_BLOCKS else bytes(BLOCK)
+                    for b in range(NBLOCKS))
+
+
+OCI_MANIFEST_MEDIA_TYPE = 'application/vnd.oci.image.manifest.v1+json'
+OCI_LAYER_MEDIA_TYPE = 'application/vnd.oci.image.layer.v1.tar'
+OCI_EMPTY_MEDIA_TYPE = 'application/vnd.oci.empty.v1+json'
+
+
+def write_blob(data: bytes) -> str:
+    digest = 'sha256:' + hashlib.sha256(data).hexdigest()
+    alg, hexsum = digest.split(':', 1)
+    d = os.path.join(oci_blobs, alg)
+    os.makedirs(d, exist_ok=True)
+    with open(os.path.join(d, hexsum), 'wb') as f:
+        f.write(data)
+    return digest
+
+
+def digest_path(digest: str) -> str:
+    alg, hexsum = digest.split(':', 1)
+    return os.path.join(oci_blobs, alg, hexsum)
+
+
+def build_oci_manifest(layers: list) -> tuple:
+    """Write @layers (bottom-first) as blobs plus a manifest listing them.
+    Returns the manifest blob's path and the layer blob paths.
+
+    The image config blob is written as well, since the driver has to
+    ignore it, but index.json is left out: the tests name the manifest
+    directly instead of resolving it through the index."""
+    cfg = b'{}'
+    digests = [write_blob(data) for data in layers]
+    manifest = json.dumps({
+        'schemaVersion': 2,
+        'mediaType': OCI_MANIFEST_MEDIA_TYPE,
+        'config': {'mediaType': OCI_EMPTY_MEDIA_TYPE,
+                   'digest': write_blob(cfg), 'size': len(cfg)},
+        'layers': [{'mediaType': OCI_LAYER_MEDIA_TYPE,
+                    'digest': d, 'size': len(data)}
+                   for d, data in zip(digests, layers)],
+        'annotations': {'org.opencontainers.image.ref.name': 'latest'},
+    }).encode()
+    return digest_path(write_blob(manifest)), [digest_path(d) for d in digests]
+
+
+def mutated_manifest(src: str, dst: str, mutate) -> str:
+    with open(src) as f:
+        m = json.load(f)
+    mutate(m)
+    with open(dst, 'w') as f:
+        json.dump(m, f)
+    return dst
+
+
+def huge_virtual_size(src: str, dst: str) -> None:
+    """Copy an LSMT with virtual_size set to the value that makes the
+    driver's sectors conversion wrap around to a zero-length image. An
+    LSMT header carries no digest, so both copies can be patched raw."""
+    with open(src, 'rb') as f:
+        img = bytearray(f.read())
+    for off in (48, len(img) - 4096 + 48):
+        struct.pack_into('<Q', img, off, (1 << 64) - 1)
+    with open(dst, 'wb') as f:
+        f.write(img)
+
+
+def overrun_lsmt_index(src: str, dst: str, pad: int = 256) -> None:
+    """Copy a bare LSMT with @pad bytes of trailing junk after its trailer,
+    whose trailer then declares index entries reaching into that junk.
+
+    The padding is what makes the case reachable: the driver's view of the
+    layer ends at the child's length, so a bound taken at view_size - 4096
+    accepts the overrun, while the trailer position the backward scan
+    actually found is @pad bytes earlier. @pad must stay under 512 or the
+    scan window no longer reaches the trailer. An LSMT header carries no
+    digest, so the copy can be patched raw."""
+    assert pad < 512 and pad % 16 == 0
+    with open(src, 'rb') as f:
+        img = bytearray(f.read())
+    for off in (40, len(img) - 4096 + 40):
+        n = struct.unpack_from('<Q', img, off)[0]
+        struct.pack_into('<Q', img, off, n + pad // 16)
+    img += bytes(pad)
+    with open(dst, 'wb') as f:
+        f.write(img)
+
+
+def make_fixtures() -> tuple:
+    base = build_lsmt({b: 1 for b in range(NBLOCKS)}, fill_base)
+    mid = wrap_zfile(build_lsmt(MID_BLOCKS, fill_mid), algo=1)
+    top = wrap_tar(wrap_zfile(build_lsmt(TOP_BLOCKS, fill_top),
+                              algo=2, garbage=True))
+
+    with open(mid_img, 'wb') as f:
+        f.write(mid)
+    with open(top_img, 'wb') as f:
+        f.write(top)
+    with open(top_plain_img, 'wb') as f:
+        f.write(build_lsmt(TOP_BLOCKS, fill_top))
+    with open(garbage_img, 'wb') as f:
+        f.write(os.urandom(32 * 1024))
+    with open(garbage_zfile, 'wb') as f:
+        f.write(wrap_zfile(os.urandom(64 * 1024), algo=1))
+    with open(junk_tar, 'wb') as f:
+        f.write(wrap_tar(os.urandom(64 * 1024)))
+    with open(small_img, 'wb') as f:
+        f.write(wrap_zfile(build_lsmt({0: 1}, fill_base), algo=1))
+    with open(overwrite_img, 'wb') as f:
+        f.write(wrap_zfile(build_lsmt(TOP_BLOCKS, fill_top), algo=1,
+                           overwrite=True))
+    huge_virtual_size(top_plain_img, huge_img)
+    overrun_lsmt_index(top_plain_img, overrun_img)
+
+    os.mkdir(oci_dir)
+    manifest, blobs = build_oci_manifest([base, mid, top])
+    shutil.copyfile(manifest, oci_exported)
+
+    os.mkdir(alg_dir)
+    os.mkdir(os.path.join(alg_dir, 'sha256'))
+    for blob in blobs:
+        shutil.copyfile(blob, os.path.join(alg_dir, 'sha256',
+                                           os.path.basename(blob)))
+    shutil.copyfile(manifest, alg_manifest)
+
+    big_blob, big_expected = build_big_lsmt()
+    with open(big_img, 'wb') as f:
+        f.write(wrap_zfile(big_blob, algo=1, block=BIG_BLOCK))
+    return big_expected, manifest, blobs
+
+
+def codec_supported(algo: int) -> bool:
+    """
+    True unless the driver says this codec was not compiled in.
+
+    Keyed on the driver's own message, not on the exit status: a probe
+    that only checked the status would also report "not compiled in"
+    when the read path is merely broken, turning a real failure into a
+    silent not-run.
+    """
+    name = {1: 'lz4', 2: 'zstd'}[algo]
+    with open(probe_img, 'wb') as f:
+        f.write(wrap_zfile(build_lsmt({0: 1}, fill_base), algo=algo))
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,layers.0.driver=file,'
+                   f'layers.0.filename={probe_img}', check=False)
+    return f'without {name} support' not in res.stdout
+
+
+def convert(opts: str, out: str):
+    return qemu_img('convert', '--image-opts', '-O', 'raw', opts, out,
+                    check=False)
+
+
+for algo in (1, 2):
+    if not codec_supported(algo):
+        iotests.notrun(f'zfile algo {algo} not compiled in')
+
+
+def read_converted(path: str) -> bytes:
+    with open(path, 'rb') as f:
+        return f.read()
+
+
+def probed_format(path: str) -> str:
+    res = qemu_img('info', path, check=False)
+    for line in res.stdout.splitlines():
+        if line.startswith('file format:'):
+            return line.split(':', 1)[1].strip()
+    return ''
+
+
+def expect(cond: bool, msg: str) -> None:
+    if not cond:
+        raise AssertionError(msg)
+
+
+def test_overlaybd() -> None:
+    big_expected, manifest, blobs = make_fixtures()
+    # the manifest is itself a blob in blobs/sha256/, so the blob root is
+    # derived from its own path -- the OCI image layout and containerd
+    # content store shapes
+    cfg = f'driver=overlaybd,manifest={manifest}'
+
+    res = qemu_img('info', '--image-opts', cfg)
+    expect('virtual size: 1 MiB' in res.stdout, 'unexpected info output')
+
+    ret = convert(cfg, converted)
+    expect(ret.returncode == 0, ret.stderr or 'convert failed')
+    expect(read_converted(converted) == expected_image(),
+           'manifest mode: content mismatch')
+    log('manifest mode: byte-exact')
+
+    for name, opts in (
+            ('explicit blob-path',
+             f'driver=overlaybd,manifest={manifest},blob-path={oci_blobs}'),
+            ('exported manifest',
+             f'driver=overlaybd,manifest={oci_exported},'
+             f'blob-path={oci_blobs}'),
+            ('exported manifest, derived blob-path',
+             f'driver=overlaybd,manifest={oci_exported}'),
+            ('manifest beside an <alg> directory',
+             f'driver=overlaybd,manifest={alg_manifest}')):
+        ret = convert(opts, converted)
+        expect(ret.returncode == 0, ret.stderr or f'{name}: convert failed')
+        expect(read_converted(converted) == expected_image(),
+               f'{name}: content mismatch')
+    log('blob-path forms: byte-exact')
+
+    layers = (f'driver=overlaybd,'
+              f'layers.0.driver=file,layers.0.filename={blobs[0]},'
+              f'layers.1.driver=file,layers.1.filename={blobs[1]},'
+              f'layers.2.driver=file,layers.2.filename={blobs[2]}')
+    ret = convert(layers, converted)
+    expect(ret.returncode == 0, ret.stderr or 'convert failed')
+    expect(read_converted(converted) == expected_image(),
+           'layers mode: content mismatch')
+    log('layers mode: byte-exact')
+
+    single = f'driver=overlaybd,layers.0.driver=file,' \
+             f'layers.0.filename={top_plain_img}'
+    ret = convert(single, converted)
+    expect(ret.returncode == 0, ret.stderr or 'convert failed')
+    expect(read_converted(converted) == top_only_image(),
+           'single layer: content mismatch')
+    log('single plain layer: byte-exact')
+
+    single = f'driver=overlaybd,layers.0.driver=file,' \
+             f'layers.0.filename={overwrite_img}'
+    ret = convert(single, converted)
+    expect(ret.returncode == 0, ret.stderr or 'convert failed')
+    expect(read_converted(converted) == top_only_image(),
+           'overwrite header: content mismatch')
+    log('header-overwrite zfile: byte-exact')
+
+    # the file child given as a dict reference carries the manifest
+    # (a bare string "file" would be a node-name reference, which is
+    # why -drive file=... passes the filename as a parameter); the blob
+    # root has to be derived from the child's own filename
+    ret = convert(f'driver=overlaybd,file.driver=file,'
+                  f'file.filename={manifest}', converted)
+    expect(ret.returncode == 0, ret.stderr or 'convert failed')
+    expect(read_converted(converted) == expected_image(),
+           'file-manifest mode: content mismatch')
+    log('file child as manifest: byte-exact')
+
+    ret = convert(f'driver=overlaybd,file.driver=file,'
+                  f'file.filename={top_img}', converted)
+    expect(ret.returncode == 0, ret.stderr or 'convert failed')
+    expect(read_converted(converted) == top_only_image(),
+           'file layer mode: content mismatch')
+    log('file child as tar layer: byte-exact')
+
+    # probing sees only the first 512 bytes: a bare LSMT and a bare ZFile
+    # match on their magic, but a tar shell shows nothing there except a
+    # generic entry header, so tars are deliberately not claimed -- every
+    # unrelated tar would then fail to open, and probing has no fallback
+    expect(probed_format(top_plain_img) == 'overlaybd', 'LSMT not probed')
+    expect(probed_format(mid_img) == 'overlaybd', 'ZFile not probed')
+    expect(probed_format(top_img) == 'raw', 'tar layer claimed by probing')
+    expect(probed_format(garbage_img) == 'raw', 'garbage not probed as raw')
+    log('format probing verified')
+
+    big = f'driver=overlaybd,layers.0.driver=file,' \
+          f'layers.0.filename={big_img}'
+    res = qemu_img('info', '--image-opts', big)
+    expect('virtual size: 12 KiB' in res.stdout, 'unexpected info output')
+    ret = convert(big, converted)
+    expect(ret.returncode == 0, ret.stderr or 'convert failed')
+    expect(read_converted(converted) == big_expected,
+           'big jump table: content mismatch')
+    log('1 MiB jump table: byte-exact')
+
+    # error paths (qemu_img() merges stdout and stderr)
+    res = qemu_img('info', '--image-opts', 'driver=overlaybd', check=False)
+    expect('either manifest, file or layers is required' in res.stdout,
+           'missing options: wrong error')
+    res = qemu_img('info', '--image-opts',
+                   'driver=overlaybd,manifest=/nonexistent.json', check=False)
+    expect('could not read overlaybd manifest' in res.stdout,
+           'missing manifest: wrong error')
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,manifest={manifest},'
+                   f'layers.0.driver=file,'
+                   f'layers.0.filename={mid_img}', check=False)
+    expect('only one of manifest, file or layers may be given' in res.stdout,
+           'conflicting options: wrong error')
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,blob-path={oci_blobs},'
+                   f'layers.0.driver=file,'
+                   f'layers.0.filename={mid_img}', check=False)
+    expect('blob-path requires a manifest' in res.stdout,
+           'blob-path without manifest: wrong error')
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,manifest={manifest},blob-path=/',
+                   check=False)
+    expect('blob-path is empty' in res.stdout,
+           'empty blob-path: wrong error')
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,layers.0.driver=file,'
+                   f'layers.0.filename={garbage_img}', check=False)
+    expect('invalid LSMT header' in res.stdout,
+           'garbage layer: wrong error')
+    res = qemu_img('info', '-f', 'overlaybd', junk_tar, check=False)
+    expect('invalid LSMT header' in res.stdout,
+           'tar of garbage: wrong error')
+    # probing cannot see past a shell: it claims this on the ZFile magic,
+    # so the payload is only verified once the ZFile is open
+    res = qemu_img('info', garbage_zfile, check=False)
+    expect('invalid LSMT header' in res.stdout,
+           'ZFile of garbage: wrong error')
+
+    mutated_manifest(manifest, badver_json,
+                     lambda m: m.update(schemaVersion=1))
+    mutated_manifest(manifest, nolayers_json, lambda m: m.pop('layers'))
+    mutated_manifest(manifest, traverse_json,
+                     lambda m: m['layers'][0].update(
+                         digest='sha256:../../../../../../../etc/passwd'))
+    mutated_manifest(manifest, missing_json,
+                     lambda m: m['layers'][0].update(
+                         digest='sha256:' + '0' * 64))
+    for name, path, want in (
+            ('schemaVersion', badver_json, 'unsupported OCI schemaVersion'),
+            ('no layers', nolayers_json, 'has no "layers" array'),
+            ('digest traversal', traverse_json, 'invalid layer digest')):
+        res = qemu_img('info', '--image-opts',
+                       f'driver=overlaybd,manifest={path},'
+                       f'blob-path={oci_blobs}', check=False)
+        expect(want in res.stdout, f'{name}: wrong error: {res.stdout}')
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,manifest={missing_json},'
+                   f'blob-path={oci_blobs}', check=False)
+    expect(f'{oci_blobs}/sha256/' + '0' * 64 in res.stdout,
+           f'missing blob: wrong error: {res.stdout}')
+
+    for name, opts in (
+            ('manifest URL',
+             'driver=overlaybd,manifest=http://127.0.0.1:1/manifest.json'),
+            ('blob-path URL',
+             f'driver=overlaybd,manifest={manifest},'
+             'blob-path=http://127.0.0.1:1/blobs'),
+            ('layer URL',
+             'driver=overlaybd,layers.0=http://127.0.0.1:1/blobs/sha256/0')):
+        res = qemu_img('info', '--image-opts', opts, check=False)
+        expect('only local files are supported' in res.stdout,
+               f'{name}: wrong error: {res.stdout[-200:]}')
+
+    # 30000-byte blocks: the running in-group offset no longer fits u16
+    corrupt_jump_table(small_img, corrupt_img, 30000)
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,layers.0.driver=file,'
+                   f'layers.0.filename={corrupt_img}', check=False)
+    expect('jump table group exceed' in res.stdout,
+           'oversized jump table group: wrong error')
+    # A valid compressed block whose trailing CRC is wrong. Opening the LSMT
+    # layer reads its header, which is ZFile block 0, so only the driver's
+    # per-block checksum can turn this into an error; without it the block
+    # decodes fine and the corruption is never noticed.
+    with open(badcrc_img, 'wb') as f:
+        f.write(wrap_zfile(build_lsmt({0: 1}, fill_base), algo=1,
+                           bad_block_crc=True))
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,layers.0.driver=file,'
+                   f'layers.0.filename={badcrc_img}', check=False)
+    expect(res.returncode != 0 and 'Input/output error' in res.stdout,
+           f'corrupt block CRC: rc={res.returncode} {res.stdout[-200:]}')
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,layers.0.driver=file,'
+                   f'layers.0.filename={huge_img}', check=False)
+    expect('virtual size 18446744073709551615 is too large' in res.stdout,
+           f'huge virtual size: wrong error: {res.stdout}')
+    res = qemu_img('info', '--image-opts',
+                   f'driver=overlaybd,layers.0.driver=file,'
+                   f'layers.0.filename={overrun_img}', check=False)
+    expect('invalid LSMT index location' in res.stdout,
+           f'overrunning LSMT index: wrong error: {res.stdout[-200:]}')
+    log('error paths verified')
+
+    # file_path() only removes plain files, so the layout directories go
+    # explicitly (as tests/vvfat does)
+    shutil.rmtree(oci_dir)
+    shutil.rmtree(alg_dir)
+
+
+if __name__ == '__main__':
+    iotests.script_main(test_overlaybd, supported_fmts=['raw'],
+                        supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/overlaybd.out b/tests/qemu-iotests/tests/overlaybd.out
new file mode 100644
index 0000000000..be1352fbce
--- /dev/null
+++ b/tests/qemu-iotests/tests/overlaybd.out
@@ -0,0 +1,10 @@
+manifest mode: byte-exact
+blob-path forms: byte-exact
+layers mode: byte-exact
+single plain layer: byte-exact
+header-overwrite zfile: byte-exact
+file child as manifest: byte-exact
+file child as tar layer: byte-exact
+format probing verified
+1 MiB jump table: byte-exact
+error paths verified
-- 
2.54.0 (Apple Git-157)


