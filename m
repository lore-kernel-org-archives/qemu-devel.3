Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55462CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6BJ-0003BQ-T3; Tue, 23 Jun 2026 14:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6Ay-00038a-Ci
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6Ap-0001sr-5l
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so169551f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782240517; x=1782845317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrdJ3RWeOgTfwNkYSdS1ZQ4vQSDsFGMl1QPSplwlO7c=;
 b=AWtSg5VDbfra2AEi335AKTP/LfoMdTJwmL/QmgU9mWnWfhvOpXhOEagcrYziMQX5Bs
 6Ky1v10wWa6XI9RYBuFzUteW8+54KMWtb1i8RbaFOoKBfhneDEdWrQWsTm0y2inkwyb4
 wC6lRMjExoAR4hRFN9UHDY3AzcIp0G0t/e3uq+VJhf4IwmLAPNPPTa9aifD7feoei05h
 NQDUWT/WOFlOeaAor5L8dF5eNJBK4/IUCXrpyvyshqYHmTZ8CLYqaCOuHuBvE3HE2FBm
 vLm5Hmefl1BZ620QEgHMR4RO06YmEqaYRNDKnwo4Y+g7hI1oiulNGp8zTquXdygYiOkm
 dQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240517; x=1782845317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XrdJ3RWeOgTfwNkYSdS1ZQ4vQSDsFGMl1QPSplwlO7c=;
 b=Nocd/Haci+lREaBsUAhvLhQuR0PNdEzNsr2GcDOV5lezBoG94o69EF/jRG7HAtZE+F
 qw1HG/N6EARuAUB6evsz3cL1LiHOEIE7uhrhcpI56OhkI03TP/e8NnupNAGmPdHEVxcf
 tNa5zUBjvCyDdqzDVSmqQJTUt3qaNSESixYFFD14DNNAgdzRmhQkdeZUd5XPJaUQHfoC
 agGOwCQdz1wfLF6wyq1emCsjuBWFvZOU/skZSST0AhhmLaD+Jy5bz8qxNq8+5MuDTl/H
 PzP4XG6VHxKcSKvBd8XGF9xRU61+VHxc/johtiDDxbUSSmRqIFgDSfYjVWPkayfMU/Jc
 yGBQ==
X-Gm-Message-State: AOJu0YywQa4hVVsvvf1fLvx3NI/ffiQ7Hlgn0RhAgE/O9GzbXTi2S3cb
 ml2bLxt4urcRnmyB+ENfPl0NhdStlOtepJx/H0EogBnGrUhd9se/GuhfRI+cXA==
X-Gm-Gg: AfdE7cm43SySJ1Jx28JWVQ4Ri4dmjIR+BVOcW3kNOBvgwIK51DcbKhknykfku1FKQWr
 l3NQnX9zGzlr0V5UOEbb6MhibJyE+sqXdKPlucYcMcz/7YYkBNYx79y3JmUt65YDofycbplAvyz
 EyihQ61trofsAlgwpoHw90Gfn83FgEt3GbZXpP+cokkEHTZR50i1+c1j3ks2T/pMB6K42XAblhJ
 JUpooF6AItCjVg/m84SH2KiMMsPJTlks6oJMaATLMxdiRTsdnLVHeocL8pxGRr8ICgI0pd9E20D
 H1+1cDl3joGI/A6/wRBTiOD8ybWdNemp6AegfQYIuKez+X02Nffo7FR0dX9YLnyFB4a/Cqvlc0t
 5VcKnb4sCkWZfCdEcO1osuSoyETQWt5sVgHwSbbPpFPDxjtGR/c2H9MHAATtx104gbluRrFGA+5
 gENGz363wsq6bFOkdR/JfBa0G5Qlb+RVK1UeKJEs1bCA+wng==
X-Received: by 2002:a05:6000:41c6:b0:45e:945b:276 with SMTP id
 ffacd0b85a97d-46c0bd7cb49mr59146f8f.20.1782240516495; 
 Tue, 23 Jun 2026 11:48:36 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:75bc:d765:f335:35fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f563dsm34644603f8f.3.2026.06.23.11.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 11:48:35 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org,
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v12 2/5] qcow2: add configurations for zoned format extension
Date: Tue, 23 Jun 2026 20:48:27 +0200
Message-ID: <20260623184830.373232-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623184830.373232-1-faithilikerun@gmail.com>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x429.google.com
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

To configure the zoned format feature on the qcow2 driver, it
requires settings as: the device size, zone model, zone size,
zone capacity, number of conventional zones, limits on zone
resources (max append bytes, max open zones, and max_active_zones).

To create a qcow2 image with zoned format feature, use command like
this:
qemu-img create -f qcow2 zbc.qcow2 -o size=768M \
-o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0 \
-o zone.max_append_bytes=4096 -o zone.max_open_zones=6 \
-o zone.max_active_zones=8 -o zone.mode=host-managed

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com> # QAPI schema
---
 block/file-posix.c               |   2 +-
 block/qcow2.c                    | 335 ++++++++++++++++++++++++++++++-
 block/qcow2.h                    |  83 +++++++-
 docs/interop/qcow2.rst           | 120 ++++++++++-
 include/block/block_int-common.h |  15 +-
 qapi/block-core.json             |  91 ++++++++-
 tests/qemu-iotests/082.out       | 126 ++++++++++++
 7 files changed, 763 insertions(+), 9 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3c985da94f..ddb159c58b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3600,7 +3600,7 @@ raw_co_zone_append(BlockDriverState *bs,
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
-                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
+                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
         return -EINVAL;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 19271b10a4..356291aff0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -73,6 +73,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -194,6 +195,98 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+/*
+ * Returns true if zone_opt is valid, false otherwise.  Fields that are
+ * out of range but recoverable by clamping (e.g. max_open_zones above
+ * the number of SWR zones) emit a warning and are adjusted in place;
+ * fields that have no safe clamp cause a hard error via errp.
+ */
+static bool
+qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt, Error **errp)
+{
+    uint32_t sequential_zones;
+
+    assert(zone_opt != NULL);
+
+    if (zone_opt->zoned != QCOW2_Z_NONE && zone_opt->zoned != QCOW2_Z_HM) {
+        error_setg(errp, "Zoned extension header zoned field has unknown "
+                   "value %" PRIu8, zone_opt->zoned);
+        return false;
+    }
+
+    if (zone_opt->zone_size == 0) {
+        warn_report("Zoned extension header zone_size field must not be 0");
+        return false;
+    }
+
+    if (!is_power_of_2(zone_opt->zone_size)) {
+        error_setg(errp, "Zoned extension header zone_size %" PRIu64
+                   "B is not a power of 2", zone_opt->zone_size);
+        return false;
+    }
+
+    if (zone_opt->nr_zones > UINT32_MAX / 8) {
+        error_setg(errp, "Zoned extension header nr_zones %" PRIu32
+                   " exceeds maximum %u",
+                   zone_opt->nr_zones, UINT32_MAX / 8);
+        return false;
+    }
+
+    if (zone_opt->zone_capacity > zone_opt->zone_size) {
+        error_setg(errp, "zone capacity %" PRIu64 "B exceeds zone size "
+                   "%" PRIu64 "B", zone_opt->zone_capacity,
+                   zone_opt->zone_size);
+        return false;
+    }
+
+    if (!QEMU_IS_ALIGNED(zone_opt->max_append_bytes, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "max append bytes %" PRIu32 "B is not aligned "
+                   "to %" PRIu64, zone_opt->max_append_bytes,
+                   (uint64_t)BDRV_SECTOR_SIZE);
+        return false;
+    }
+
+    if (zone_opt->max_append_bytes + BDRV_SECTOR_SIZE >=
+        zone_opt->zone_capacity) {
+        error_setg(errp, "max append bytes %" PRIu32 "B exceeds zone "
+                   "capacity %" PRIu64 "B by more than block size",
+                   zone_opt->max_append_bytes, zone_opt->zone_capacity);
+        return false;
+    }
+
+    if (zone_opt->conventional_zones >= zone_opt->nr_zones) {
+        error_setg(errp, "Conventional_zones %" PRIu32 " exceeds "
+                   "nr_zones %" PRIu32 ".",
+                   zone_opt->conventional_zones, zone_opt->nr_zones);
+        return false;
+    }
+
+    if (zone_opt->max_active_zones > zone_opt->nr_zones) {
+        warn_report("max_active_zones %" PRIu32 " exceeds nr_zones %" PRIu32
+                    ", clamping to nr_zones",
+                    zone_opt->max_active_zones, zone_opt->nr_zones);
+        zone_opt->max_active_zones = zone_opt->nr_zones;
+    }
+
+    sequential_zones = zone_opt->nr_zones - zone_opt->conventional_zones;
+    if (zone_opt->max_open_zones > sequential_zones) {
+        warn_report("max_open_zones %" PRIu32 " exceeds the number of SWR "
+                    "zones, clamping to %" PRIu32,
+                    zone_opt->max_open_zones, sequential_zones);
+        zone_opt->max_open_zones = sequential_zones;
+    }
+    if (zone_opt->max_active_zones != 0 &&
+        zone_opt->max_open_zones > zone_opt->max_active_zones) {
+        warn_report("max_open_zones %" PRIu32 " exceeds max_active_zones "
+                    "%" PRIu32 ", clamping to max_active_zones",
+                    zone_opt->max_open_zones,
+                    zone_opt->max_active_zones);
+        zone_opt->max_open_zones = zone_opt->max_active_zones;
+    }
+
+    return true;
+}
+
 /*
  * read qcow2 extension and fill bs
  * start reading from start_offset
@@ -211,6 +304,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
     uint64_t offset;
     int ret;
     Qcow2BitmapHeaderExt bitmaps_ext;
+    Qcow2ZonedHeaderExtension zoned_ext;
 
     if (need_update_header != NULL) {
         *need_update_header = false;
@@ -432,6 +526,50 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             break;
         }
 
+        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
+        {
+            if (ext.len != sizeof(zoned_ext)) {
+                error_setg(errp, "zoned_ext: unexpected len=%" PRIu32 " "
+                           "(expected %zu)", ext.len, sizeof(zoned_ext));
+                return -EINVAL;
+            }
+            ret = bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "zoned_ext: "
+                                 "Could not read ext header");
+                return ret;
+            }
+
+            zoned_ext.zone_size = be64_to_cpu(zoned_ext.zone_size);
+            zoned_ext.zone_capacity = be64_to_cpu(zoned_ext.zone_capacity);
+            zoned_ext.conventional_zones =
+                be32_to_cpu(zoned_ext.conventional_zones);
+            zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
+            zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
+            zoned_ext.max_active_zones =
+                be32_to_cpu(zoned_ext.max_active_zones);
+            zoned_ext.max_append_bytes =
+                be32_to_cpu(zoned_ext.max_append_bytes);
+            s->zoned_header = zoned_ext;
+
+            /* refuse to open broken images */
+            if (zoned_ext.nr_zones != DIV_ROUND_UP(bs->total_sectors *
+                BDRV_SECTOR_SIZE, zoned_ext.zone_size)) {
+                error_setg(errp, "Zoned extension header nr_zones field "
+                           "is wrong");
+                return -EINVAL;
+            }
+            if (!qcow2_check_zone_options(&zoned_ext, errp)) {
+                return -EINVAL;
+            }
+
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got zoned format extension: "
+                   "offset=%" PRIu64 "\n", offset);
+#endif
+            break;
+        }
+
         default:
             /* unknown magic - save it in case we need to rewrite the header */
             /* If you add a new feature, make sure to also update the fast
@@ -2068,6 +2206,25 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
+
+    switch (s->zoned_header.zoned) {
+    case QCOW2_Z_HM:
+        bs->bl.zoned = BLK_Z_HM;
+        break;
+    case QCOW2_Z_NONE:
+    default:
+        bs->bl.zoned = BLK_Z_NONE;
+        break;
+    }
+
+    bs->bl.nr_zones = s->zoned_header.nr_zones;
+    bs->bl.max_append_sectors = s->zoned_header.max_append_bytes
+        >> BDRV_SECTOR_BITS;
+    bs->bl.max_active_zones = s->zoned_header.max_active_zones;
+    bs->bl.max_open_zones = s->zoned_header.max_open_zones;
+    bs->bl.zone_size = s->zoned_header.zone_size;
+    bs->bl.zone_capacity = s->zoned_header.zone_capacity;
+    bs->bl.write_granularity = BDRV_SECTOR_SIZE;
 }
 
 static int GRAPH_UNLOCKED
@@ -3170,6 +3327,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  = QCOW2_INCOMPAT_EXTL2_BITNR,
                 .name = "extended L2 entries",
             },
+            {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
+                .name = "zoned format",
+            },
             {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
@@ -3215,6 +3377,31 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Zoned devices header extension */
+    if (s->zoned_header.zoned == QCOW2_Z_HM) {
+        Qcow2ZonedHeaderExtension zoned_header = {
+            .zoned              = s->zoned_header.zoned,
+            .zone_size          = cpu_to_be64(s->zoned_header.zone_size),
+            .zone_capacity      = cpu_to_be64(s->zoned_header.zone_capacity),
+            .conventional_zones =
+                cpu_to_be32(s->zoned_header.conventional_zones),
+            .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
+            .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
+            .max_active_zones   =
+                cpu_to_be32(s->zoned_header.max_active_zones),
+            .max_append_bytes =
+                cpu_to_be32(s->zoned_header.max_append_bytes)
+        };
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
+                             &zoned_header, sizeof(zoned_header),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+    }
+
     /* Keep unknown header extensions */
     QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
         ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
@@ -3589,6 +3776,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     ERRP_GUARD();
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
+    Qcow2ZoneCreateOptions *zone_struct;
+    Qcow2ZoneHostManaged *zone_host_managed;
 
     /*
      * Open the image file and write a minimal qcow2 header.
@@ -3615,6 +3804,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
+    zone_struct = qcow2_opts->zone;
+    zone_host_managed = NULL;
 
     bs = bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
     if (bs == NULL) {
@@ -3828,6 +4019,14 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         header->incompatible_features |=
             cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
     }
+    if (zone_struct && zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        /*
+         * The incompatible bit must be set when the zone model is
+         * host-managed
+         */
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_ZONED_FORMAT);
+    }
     if (qcow2_opts->data_file_raw) {
         header->autoclear_features |=
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
@@ -3885,10 +4084,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     bdrv_graph_co_rdlock();
     ret = qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
     if (ret < 0) {
-        bdrv_graph_co_rdunlock();
         error_setg_errno(errp, -ret, "Could not allocate clusters for qcow2 "
                          "header and refcount table");
-        goto out;
+        goto unlock;
 
     } else if (ret != 0) {
         error_report("Huh, first cluster in empty image is already in use?");
@@ -3896,11 +4094,77 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Set the external data file if necessary */
+    BDRVQcow2State *s = blk_bs(blk)->opaque;
     if (data_bs) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (zone_struct && zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        s->zoned_header.zoned = QCOW2_Z_HM;
+        zone_host_managed = &zone_struct->u.host_managed;
+
+        if (zone_host_managed->has_size) {
+            s->zoned_header.zone_size = zone_host_managed->size;
+        } else {
+            s->zoned_header.zone_size = DEFAULT_ZONE_SIZE;
+        }
+
+        if (s->zoned_header.zone_size == 0) {
+            error_setg(errp, "Zoned extension header zone_size field "
+                       "can not be 0");
+            s->zoned_header.zoned = QCOW2_Z_NONE;
+            ret = -EINVAL;
+            goto unlock;
+        }
+        s->zoned_header.nr_zones = DIV_ROUND_UP(qcow2_opts->size,
+                                                s->zoned_header.zone_size);
+
+        if (zone_host_managed->has_capacity) {
+            s->zoned_header.zone_capacity = zone_host_managed->capacity;
+        } else {
+            s->zoned_header.zone_capacity = s->zoned_header.zone_size;
+        }
+
+        if (zone_host_managed->has_conventional_zones) {
+            s->zoned_header.conventional_zones =
+                zone_host_managed->conventional_zones;
+        } else {
+            s->zoned_header.conventional_zones = 0;
+        }
+
+        if (zone_host_managed->has_max_active_zones) {
+            s->zoned_header.max_active_zones =
+                zone_host_managed->max_active_zones;
+        } else {
+            s->zoned_header.max_active_zones = 0;
+        }
+
+        if (zone_host_managed->has_max_open_zones) {
+            s->zoned_header.max_open_zones =
+                zone_host_managed->max_open_zones;
+        } else if (zone_host_managed->has_max_active_zones) {
+            s->zoned_header.max_open_zones =
+                zone_host_managed->max_active_zones;
+        } else {
+            s->zoned_header.max_open_zones = 0;
+        }
+
+        if (zone_host_managed->has_max_append_bytes) {
+            s->zoned_header.max_append_bytes =
+                    zone_host_managed->max_append_bytes;
+        } else {
+            s->zoned_header.max_append_bytes = DEFAULT_ZONE_MAX_APPEND_BYTES;
+        }
+
+        if (!qcow2_check_zone_options(&s->zoned_header, errp)) {
+            s->zoned_header.zoned = QCOW2_Z_NONE;
+            ret = -EINVAL;
+            goto unlock;
+        }
+    } else {
+        s->zoned_header.zoned = QCOW2_Z_NONE;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3974,6 +4238,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     ret = 0;
+    goto out;
+unlock:
+    bdrv_graph_co_rdunlock();
 out:
     blk_co_unref(blk);
     bdrv_co_unref(bs);
@@ -4052,6 +4319,10 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_CONVENTIONAL_ZONES, "zone.conventional-zones" },
+        { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
+        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
+        { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
         { NULL, NULL },
     };
 
@@ -5448,6 +5719,29 @@ qcow2_get_specific_info(BlockDriverState *bs, Error **errp)
             .data_file_raw      = data_file_is_raw(bs),
             .compression_type   = s->compression_type,
         };
+        if (s->zoned_header.zoned == QCOW2_Z_HM) {
+            ImageInfoSpecificQCow2Zoned *z =
+                g_new0(ImageInfoSpecificQCow2Zoned, 1);
+            *z = (ImageInfoSpecificQCow2Zoned){
+                .mode = QCOW2_ZONE_MODEL_HOST_MANAGED,
+                .nr_zones = s->zoned_header.nr_zones,
+                .u.host_managed = {
+                    .has_size = true,
+                    .size = s->zoned_header.zone_size,
+                    .has_capacity = true,
+                    .capacity = s->zoned_header.zone_capacity,
+                    .has_conventional_zones = true,
+                    .conventional_zones = s->zoned_header.conventional_zones,
+                    .has_max_open_zones = true,
+                    .max_open_zones = s->zoned_header.max_open_zones,
+                    .has_max_active_zones = true,
+                    .max_active_zones = s->zoned_header.max_active_zones,
+                    .has_max_append_bytes = true,
+                    .max_append_bytes = s->zoned_header.max_append_bytes,
+                },
+            };
+            spec_info->u.qcow2.data->zone = z;
+        }
     } else {
         /* if this assertion fails, this probably means a new version was
          * added without having it covered here */
@@ -6271,6 +6565,41 @@ static QemuOptsList qcow2_create_opts = {
             .type = QEMU_OPT_BOOL,                                      \
             .help = "Assume the external data file already exists and " \
                     "do not overwrite it"                               \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_MODEL,                               \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "zone model modes, mode choice: host-managed",      \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_SIZE,                                \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone size",                                        \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_CAPACITY,                            \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone capacity",                                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_CONVENTIONAL_ZONES,                       \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "numbers of conventional zones",                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_APPEND_BYTES,                         \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "max append bytes",                                 \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_ACTIVE_ZONES,                         \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max active zones",                                 \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_OPEN_ZONES,                           \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max open zones",                                   \
         },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
diff --git a/block/qcow2.h b/block/qcow2.h
index ce517040c4..2f1a48f4c1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -129,6 +129,12 @@
 
 #define DEFAULT_CLUSTER_SIZE 65536
 
+#define DEFAULT_ZONE_SIZE (256 * MiB)
+#define DEFAULT_ZONE_MAX_APPEND_BYTES (64 * KiB)
+
+#define QCOW2_Z_NONE 0 /* Regular block device */
+#define QCOW2_Z_HM 1 /* Host-managed zoned block device */
+
 #define QCOW2_OPT_DATA_FILE "data-file"
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
@@ -237,6 +243,60 @@ typedef struct Qcow2CryptoHeaderExtension {
     uint64_t length;
 } QEMU_PACKED Qcow2CryptoHeaderExtension;
 
+typedef struct Qcow2ZonedHeaderExtension {
+    /* Zoned device attributes */
+    uint8_t zoned;
+    uint8_t reserved[3];
+    uint32_t nr_zones;
+    uint64_t zone_size;
+    uint64_t zone_capacity;
+    uint32_t conventional_zones;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
+    uint32_t max_append_bytes;
+    uint64_t zonedmeta_offset;
+} QEMU_PACKED Qcow2ZonedHeaderExtension;
+
+typedef struct Qcow2ZoneListEntry {
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
+} Qcow2ZoneListEntry;
+
+/*
+ * Per-zone tracking for write pointer (WP) advance. A submitter
+ * reserves an LBA range, performs the data write outside the zone
+ * lock, then waits until the persisted WP catches up to its end
+ * offset before returning success to the guest. A failure aborts
+ * all higher-LBA peers in the same zone.
+ */
+typedef enum Qcow2WPReqState {
+    /* data write submitted, awaiting completion */
+    QCOW2_WP_REQ_INFLIGHT,
+    /* data write completed, persisted WP not yet advanced past lba + len */
+    QCOW2_WP_REQ_PENDING,
+    /* persisted WP covers this range, submitter may ack success */
+    QCOW2_WP_REQ_RESOLVED,
+    /* data write failed, or a lower-LBA peer in the same zone failed */
+    QCOW2_WP_REQ_ABORTED,
+} Qcow2WPReqState;
+
+typedef struct Qcow2WPReq {
+    uint64_t lba;                       /* start offset of the data write */
+    uint64_t len;                       /* length in bytes */
+    Qcow2WPReqState state;
+    /* submitter waits for the data write to reach a terminal state */
+    CoQueue wait;
+    QTAILQ_ENTRY(Qcow2WPReq) entry;
+} Qcow2WPReq;
+
+typedef struct Qcow2ZoneWPState {
+    /* INFLIGHT reqs */
+    QTAILQ_HEAD(, Qcow2WPReq) in_flight;
+    /* PENDING reqs, sorted by lba */
+    QTAILQ_HEAD(, Qcow2WPReq) completed_pending;
+} Qcow2ZoneWPState;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -257,17 +317,20 @@ enum {
     QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
     QCOW2_INCOMPAT_COMPRESSION_BITNR = 3,
     QCOW2_INCOMPAT_EXTL2_BITNR      = 4,
+    QCOW2_INCOMPAT_ZONED_FORMAT_BITNR = 5,
     QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
     QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
     QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
     QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
     QCOW2_INCOMPAT_EXTL2            = 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
+    QCOW2_INCOMPAT_ZONED_FORMAT     = 1 << QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
 
     QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
                                     | QCOW2_INCOMPAT_CORRUPT
                                     | QCOW2_INCOMPAT_DATA_FILE
                                     | QCOW2_INCOMPAT_COMPRESSION
-                                    | QCOW2_INCOMPAT_EXTL2,
+                                    | QCOW2_INCOMPAT_EXTL2
+                                    | QCOW2_INCOMPAT_ZONED_FORMAT,
 };
 
 /* Compatible feature bits */
@@ -426,6 +489,24 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    /* States of zoned device */
+    Qcow2ZonedHeaderExtension zoned_header;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) exp_open_zones;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) imp_open_zones;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) closed_zones;
+    Qcow2ZoneListEntry *zone_list_entries;
+    uint32_t nr_zones_exp_open;
+    uint32_t nr_zones_imp_open;
+    uint32_t nr_zones_closed;
+
+    /* Per-zone in-memory WP tracking for zoned imgaes. */
+    Qcow2ZoneWPState *zone_wp_state;
+    /*
+     * Cache holding the on-disk zonedmeta cluster(s) for zoned image.
+     * WP advances go through this cache.
+     */
+    Qcow2Cache *wp_cache;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.rst b/docs/interop/qcow2.rst
index 5948591107..08ff7844fa 100644
--- a/docs/interop/qcow2.rst
+++ b/docs/interop/qcow2.rst
@@ -128,7 +128,26 @@ the next fields through ``header_length``.
                                 allows subcluster-based allocation. See the
                                 Extended L2 Entries section for more details.
 
-                    Bits 5-63:  Reserved (set to 0)
+                    Bit 5:      Zoned extension bit. If this bit is set then
+                                the file is an emulated zoned device. The
+                                zoned extension must be present.
+                                Implementations that do not support zoned
+                                emulation cannot open this file because it
+                                generally only make sense to interpret the
+                                data along with the zone information and
+                                write pointers.
+
+                                It is unsafe when any qcow2 user without
+                                knowing the zoned extension reads or edits
+                                a file with the zoned extension. The write
+                                pointer tracking can be corrupted when a
+                                writer edits a file, like overwriting beyond
+                                the write pointer locations. Or a reader tries
+                                to access a file without knowing write
+                                pointers where the software setup will cause
+                                invalid reads.
+
+                    Bits 6-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -259,6 +278,7 @@ be stored. Each extension has a structure like the following::
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
                         0x44415441 - External data file name string
+                        0x007a6264 - Zoned extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -344,6 +364,104 @@ The fields of the bitmaps extension are::
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+Zoned extension
+---------------
+
+The zoned extension must be present if the incompatible_features bit 5 is set,
+and omitted when it is clear. It contains fields for emulating the zoned
+storage model (https://zonedstorage.io/). Currently only the host-managed zone
+model is supported.
+
+The fields of the zoned extension are::
+
+    Byte       0:  zoned
+                   The byte represents the zoned model of the device. 0 is for
+                   a non-zoned device (all other information in this header
+                   is ignored). 1 is for a host-managed device, which only
+                   allows for sequential writes within each zone. Other
+                   values may be added later, the implementation must refuse
+                   to open a device containing an unknown zone model.
+
+          1 -  3:  Reserved, must be zero.
+
+          4 -  7:  nr_zones
+                   The number of zones. It is the sum of conventional zones
+                   and sequential zones. The maximum value for nr_zones is
+                   (2^32 - 1)/8 = 536870911.
+
+          8 - 15:  zone_size
+                   Total size of each zone, in bytes. The 64-bit field is to
+                   satisfy the virtio-blk zone_size range and emulate a read
+                   zoned device, whose maximum zone size can be as large as
+                   2TB.
+
+                   The value must be power of 2. Linux currently requires
+                   the zone size to be a power of 2 number of LBAs. Qcow2
+                   following this is mainly to allow emulating a real
+                   ZNS drive configuration. It is not relevant to the cluster
+                   size.
+
+         16 - 23:  zone_capacity
+                   The number of writable bytes within the zones. The bytes
+                   between zone capacity and zone size are unusable: reads
+                   will return 0s and writes will fail.
+
+                   A zone capacity is always smaller or equal to the zone
+                   size. It is for emulating a real ZNS drive configuration,
+                   which has the constraint of aligning to some hardware erase
+                   block size.
+
+         24 - 27:  conventional_zones
+                   The number of conventional zones. The conventional zones
+                   allow sequential writes and random writes. While the
+                   sequential zones only allow sequential writes.
+
+         28 - 31:  max_active_zones
+                   The maximum allowed active zones (zones in the implicit
+                   open, explicit open, or closed state). It cannot be larger
+                   than nr_zones.
+
+         32 - 35:  max_open_zones
+                   The maximum allowed open zones (zones in the implicit open
+                   or explicit open state). It cannot be larger than the number
+                   of SWR zones of the device, nor larger than max_active_zones.
+
+                   If the limits of open zones or active zones are equal to
+                   the total number of SWR zones, then it's the same as having
+                   no limits therefore max open zones and max active zones are
+                   set to 0.
+
+         36 - 39:  max_append_bytes
+                   The maximum number of bytes of a zone append request that
+                   can be issued to the device. It must be 512-byte aligned
+                   and less than the zone capacity.
+
+                   A value of 0 means that the zone append requests are not
+                   supported.
+
+         40 - 47:  zonedmeta_offset
+                   The offset of zoned metadata structure in the contained
+                   image, in bytes.
+
+The zonedmeta clusters contain a table of the zone write pointers. Each entry
+is a 64-bit value encoding both the zone type and the zone's write pointer::
+
+    Bit   0 - 58:  Write pointer offset, in bytes, indicates the starting
+                   point of the next write position in that zone.
+                   For conventional zones the value is the zone's starting
+                   offset.
+
+              59:  Zone type. 0 = SWR; 1 = conventional.
+
+         60 - 63:  Reserved, must be zero.
+
+
+Each zone's write pointer in the zonedmeta area is durable on disk only after
+the data it covers is durable. For a write to a SWR zone, the data is written
+back to disk first, then the non-zoned qcow2 L1/L2/refcount metadata is written,
+and finally the write pointers are written. This ordering ensures that after
+a power failure the on-disk write pointer never leads data being written.
+
 Full disk encryption header pointer
 -----------------------------------
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..349876bc65 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,13 @@
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
 #define BLOCK_OPT_KEEP_DATA_FILE    "keep_data_file"
+#define BLOCK_OPT_ZONE_MODEL        "zone.mode"
+#define BLOCK_OPT_ZONE_SIZE         "zone.size"
+#define BLOCK_OPT_ZONE_CAPACITY     "zone.capacity"
+#define BLOCK_OPT_CONVENTIONAL_ZONES    "zone.conventional_zones"
+#define BLOCK_OPT_MAX_APPEND_BYTES      "zone.max_append_bytes"
+#define BLOCK_OPT_MAX_ACTIVE_ZONES      "zone.max_active_zones"
+#define BLOCK_OPT_MAX_OPEN_ZONES        "zone.max_open_zones"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -901,7 +908,13 @@ typedef struct BlockLimits {
     BlockZoneModel zoned;
 
     /* zone size expressed in bytes */
-    uint32_t zone_size;
+    uint64_t zone_size;
+
+    /*
+     * The number of usable logical blocks within the zone, expressed
+     * in bytes. A zone capacity is smaller or equal to the zone size.
+     */
+    uint64_t zone_capacity;
 
     /* total number of zones */
     uint32_t nr_zones;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f87b07850..4542bfc8f5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -93,6 +93,9 @@
 #
 # @compression-type: the image cluster compression method (since 5.1)
 #
+# @zone: zoned configuration; only set when the image was created
+#     with a zoned model (since 11.1)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -106,7 +109,8 @@
       'refcount-bits': 'int',
       '*encrypt': 'ImageInfoSpecificQCow2Encryption',
       '*bitmaps': ['Qcow2BitmapInfo'],
-      'compression-type': 'Qcow2CompressionType'
+      'compression-type': 'Qcow2CompressionType',
+      '*zone': 'ImageInfoSpecificQCow2Zoned'
   } }
 
 ##
@@ -5221,6 +5225,85 @@
 { 'enum': 'Qcow2CompressionType',
   'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
+##
+# @Qcow2ZoneModel:
+#
+# Zoned device model used in qcow2 image file
+#
+# @host-managed: The host-managed model only allows sequential write
+#     over the device zones.
+#
+# Since: 11.1
+##
+{ 'enum': 'Qcow2ZoneModel',
+  'data': [ 'host-managed'] }
+
+##
+# @Qcow2ZoneHostManaged:
+#
+# The host-managed zone model.  It only allows sequential writes.
+#
+# @size: Total number of bytes within zones (default: 256 MB).
+#
+# @capacity: The usable space within each zone, in bytes.  Always
+#     smaller than or equal to @size (default: same as @size).
+#
+# @conventional-zones: The number of conventional zones of the
+#     zoned device (default: 0).
+#
+# @max-open-zones: The maximal number of open zones.  Must be less
+#     than or equal to the number of non-conventional zones (i.e.
+#     ``size / zone.size - @conventional-zones``), and less than or
+#     equal to @max-active-zones (default: 0, meaning no limit).
+#
+# @max-active-zones: The maximal number of zones in the implicit
+#     open, explicit open or closed state.  It is less than or equal
+#     to the number of zones (default: 0, meaning no limit).
+#
+# @max-append-bytes: The maximal size in bytes of a zone-append
+#     request that can be issued to the device.  Must be a multiple
+#     of 512, and less than @capacity (default: 64 KB).
+#
+# Since: 11.1
+##
+{ 'struct': 'Qcow2ZoneHostManaged',
+  'data': { '*size':          'size',
+            '*capacity':      'size',
+            '*conventional-zones': 'uint32',
+            '*max-open-zones':     'uint32',
+            '*max-active-zones':   'uint32',
+            '*max-append-bytes':   'size' } }
+
+##
+# @Qcow2ZoneCreateOptions:
+#
+# Creation options for zoned qcow2 images.
+#
+# @mode: The zone model used by the image.
+#
+# Since: 11.1
+##
+{ 'union': 'Qcow2ZoneCreateOptions',
+  'base': { 'mode': 'Qcow2ZoneModel' },
+  'discriminator': 'mode',
+  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
+
+##
+# @ImageInfoSpecificQCow2Zoned:
+#
+# @mode: The zone model used by the image.
+#
+# @nr-zones: total number of zones in the image, derived at create
+#     time from the size and the zone size.
+#
+# Since: 11.1
+##
+{ 'union': 'ImageInfoSpecificQCow2Zoned',
+  'base': { 'mode':     'Qcow2ZoneModel',
+            'nr-zones': 'uint32' },
+  'discriminator': 'mode',
+  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -5263,6 +5346,9 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone: Options for zoned images.  If absent, the device is not
+#     zoned.  (since 11.1)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
@@ -5279,7 +5365,8 @@
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
             '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+            '*compression-type':'Qcow2CompressionType',
+            '*zone':            'Qcow2ZoneCreateOptions' } }
 
 ##
 # @BlockdevCreateOptionsQed:
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index e0463815c6..d1c8bb2532 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -72,6 +72,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o ? TEST_DIR/t.qcow2 128M
 Supported options:
@@ -99,6 +106,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 128M
 Supported options:
@@ -126,6 +140,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 128M
 Supported options:
@@ -153,6 +174,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 128M
 Supported options:
@@ -180,6 +208,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 128M
 Supported options:
@@ -207,6 +242,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 128M
 Supported options:
@@ -234,6 +276,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 128M
 Supported options:
@@ -261,6 +310,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: create -f qcow2 -u -o backing_file=TEST_DIR/t.qcow2,,help -F qcow2 TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=134217728 backing_file=TEST_DIR/t.qcow2,,help backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
@@ -301,6 +357,13 @@ Supported qcow2 options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 The protocol level may support further options.
 Specify the target filename to include those options.
@@ -391,6 +454,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -418,6 +488,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -445,6 +522,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -472,6 +556,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -499,6 +590,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -526,6 +624,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -553,6 +658,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 Supported options:
@@ -580,6 +692,13 @@ Supported options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 Testing: convert -O qcow2 -o backing_fmt=qcow2,backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory
@@ -620,6 +739,13 @@ Supported qcow2 options:
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
   refcount_bits=<num>    - Width of a reference count entry in bits
   size=<size>            - Virtual disk size
+  zone.capacity=<size>   - zone capacity
+  zone.conventional_zones=<num> - numbers of conventional zones
+  zone.max_active_zones=<num> - max active zones
+  zone.max_append_bytes=<size> - max append bytes
+  zone.max_open_zones=<num> - max open zones
+  zone.mode=<str>        - zone model modes, mode choice: host-managed
+  zone.size=<size>       - zone size
 
 The protocol level may support further options.
 Specify the target filename to include those options.
-- 
2.53.0


