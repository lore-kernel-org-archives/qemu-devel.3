Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD95CF64A1
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sutYW-0002Yu-S5; Sun, 29 Sep 2024 09:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYV-0002Se-4F; Sun, 29 Sep 2024 09:01:43 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYR-00043B-CZ; Sun, 29 Sep 2024 09:01:42 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso646477766b.1; 
 Sun, 29 Sep 2024 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727614897; x=1728219697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yy2THaii5qPg6y1D/FYztwxVzNAoto7QEe6ZghTIh44=;
 b=RfbdOsNEGIt3jaXY6zDPGAJqFaGUaSwsJoKe+RmQD0wzwM7073zzRM9IYNWyoKmkK6
 nrlgfdNkkVP5Qn5cmtXyChB0T1eSlzWB+6W4o+iw8Q3BwBGPe6VOcsvgpbYRTzyPDwA3
 xtFUULkmm3mpfqFX7KS16eYUtrQ0tbG+AMyAZztASzJcDTTjO1rQeEe80cd5RyAvjp3i
 vsk2pz7eg2DtI1u6WU9z6eTcRSw0XBM4UKTX+VX5ArPcHKtH9Sb04BzMt7EeYGyKA03D
 cQZUAUqYdeZS+mBV/RWdwH7E9o+2bwgSneOHUq/iJYKhToma+iOb7407AO9GtPjsINOB
 7+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727614897; x=1728219697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yy2THaii5qPg6y1D/FYztwxVzNAoto7QEe6ZghTIh44=;
 b=JRjabTWcYNhUF5NLAJ8ytPVgHBo4coGWUueruLSgrMnd5u9ARV8QjBi2Z4s/H787fr
 nCUpdytmQBaN/RVakAV9v5NRMYE5A5LekAID7qjMm28TmQOUVw9c+h4wlY9Wp3wEEq8L
 wI5Kp9zUZ52hPd9L0Txg72sqZdpVUY6d2+zTJlvYt1bLxx1mpxqNgWRbvaXh32KCft71
 lG2gUr0Ys5kjnWxI6WJJabw6Zl6Z9WPxJvw5UtgPm0HmrYtj6kzKSoNc4ZyvSjV6LHXf
 s0a1yrIWqT56NpkgEW6r80BXjYb076XR4ofDCjzchrKNqjdCx6XJwlIWG13osTT9bip2
 1qpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO69cMDLRFLEHlQecu5hif1TqyUIFVv0B8K6SNKGq02hAmDyM/OQQ7eb7Z2g9xovBEDjNC1D78jB4V@nongnu.org
X-Gm-Message-State: AOJu0Yxqe1CuM02dOtaMUtJwJ4nwAr2BH9xxoVTOruD13UwWygLlnvhs
 ahAnP1jTrQY5G3MU/IGvDCcdhA7QauxBl+yAfTP6hZkiS6PNFWcv5JCIlqRz
X-Google-Smtp-Source: AGHT+IHOVOa+zHUcioai7yNykVqiMq8v3OOENFNCX2NIEJt080MT4GHZE8X8hRzvEySAwdZJyFS05w==
X-Received: by 2002:a17:906:4fcb:b0:a8d:2fdb:b449 with SMTP id
 a640c23a62f3a-a93b15f935bmr1419086966b.16.1727614897050; 
 Sun, 29 Sep 2024 06:01:37 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c27776cesm373146966b.40.2024.09.29.06.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 06:01:36 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
X-Google-Original-From: Sam Li <jia.li@ionos.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 dlemoal@kernel.org, qemu-block@nongnu.org, hare@suse.de,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v8 2/4] qcow2: add configurations for zoned format extension
Date: Sun, 29 Sep 2024 15:01:31 +0200
Message-Id: <20240929130133.535568-3-jia.li@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929130133.535568-1-jia.li@ionos.com>
References: <20240929130133.535568-1-jia.li@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sam Li <faithilikerun@gmail.com>

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
---
 block/qcow2.c                    | 264 ++++++++++++++++++++++++++++++-
 block/qcow2.h                    |  32 +++-
 docs/interop/qcow2.txt           | 107 ++++++++++++-
 include/block/block_int-common.h |  15 +-
 qapi/block-core.json             |  69 +++++++-
 5 files changed, 480 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 803ca73a2f..f0fd9d79a2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -73,6 +73,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -194,6 +195,74 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+/*
+ * Passing by the zoned device configurations by a zoned_header struct, check
+ * if the zone device options are under constraints. Return false when some
+ * option is invalid
+ */
+static inline bool
+qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt, Error **errp)
+{
+    if (zone_opt) {
+        uint32_t sequential_zones;
+
+        if (zone_opt->zone_size == 0) {
+            error_setg(errp, "Zoned extension header zone_size field "
+                       "can not be 0");
+            return false;
+        }
+
+        if (zone_opt->zone_capacity > zone_opt->zone_size) {
+            error_setg(errp, "zone capacity %" PRIu64 "B exceeds zone size "
+                       "%" PRIu64 "B", zone_opt->zone_capacity,
+                       zone_opt->zone_size);
+            return false;
+        }
+
+        if (zone_opt->max_append_bytes + BDRV_SECTOR_SIZE >=
+            zone_opt->zone_capacity) {
+            error_setg(errp, "max append bytes %" PRIu64 "B exceeds zone "
+                       "capacity %" PRIu32 "B by more than block size",
+                       zone_opt->zone_capacity,
+                       zone_opt->max_append_bytes);
+            return false;
+        }
+
+        if (zone_opt->conventional_zones >= zone_opt->nr_zones) {
+            error_setg(errp, "Conventional_zones %" PRIu32 " exceeds "
+                       "nr_zones %" PRIu32 ".",
+                       zone_opt->conventional_zones, zone_opt->nr_zones);
+            return false;
+        }
+
+        if (zone_opt->max_active_zones > zone_opt->nr_zones) {
+            error_setg(errp, "Max_active_zones %" PRIu32 " exceeds "
+                       "nr_zones %" PRIu32 ". Set it to nr_zones.",
+                       zone_opt->max_active_zones, zone_opt->nr_zones);
+            zone_opt->max_active_zones = zone_opt->nr_zones;
+        }
+
+        sequential_zones = zone_opt->nr_zones - zone_opt->conventional_zones;
+        if (zone_opt->max_open_zones > sequential_zones) {
+            error_setg(errp, "Max_open_zones field can not be larger than"
+                       "the number of SWR zones. Set it to number of SWR"
+                       "zones %" PRIu32 ".", sequential_zones);
+            zone_opt->max_open_zones = sequential_zones;
+        }
+        if (zone_opt->max_open_zones > zone_opt->max_active_zones) {
+            error_setg(errp, "Max_open_zones %" PRIu32 " exceeds "
+                       "max_active_zones %" PRIu32 ". Set it to "
+                       "max_active_zones.",
+                       zone_opt->max_open_zones,
+                       zone_opt->max_active_zones);
+            zone_opt->max_open_zones = zone_opt->max_active_zones;
+        }
+
+        return true;
+    }
+    return false;
+}
+
 /*
  * read qcow2 extension and fill bs
  * start reading from start_offset
@@ -211,6 +280,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
     uint64_t offset;
     int ret;
     Qcow2BitmapHeaderExt bitmaps_ext;
+    Qcow2ZonedHeaderExtension zoned_ext;
 
     if (need_update_header != NULL) {
         *need_update_header = false;
@@ -432,6 +502,51 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             break;
         }
 
+        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
+        {
+            if (ext.len < sizeof(zoned_ext)) {
+                /* Missing fields */
+                error_setg(errp, "zoned_ext: len=%" PRIu32 " too small "
+                           "(<%zu)", ext.len, sizeof(zoned_ext));
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
+                   "offset=%" PRIu32 "\n", offset);
+#endif
+            break;
+        }
+
         default:
             /* unknown magic - save it in case we need to rewrite the header */
             /* If you add a new feature, make sure to also update the fast
@@ -1982,6 +2097,15 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
+    bs->bl.zoned = s->zoned_header.zoned;
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
@@ -3081,6 +3205,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3126,6 +3255,31 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Zoned devices header extension */
+    if (s->zoned_header.zoned == BLK_Z_HM) {
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
@@ -3500,6 +3654,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     ERRP_GUARD();
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
+    Qcow2ZoneCreateOptions *zone_struct;
+    Qcow2ZoneHostManaged *zone_host_managed;
 
     /*
      * Open the image file and write a minimal qcow2 header.
@@ -3526,6 +3682,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
+    zone_struct = create_options->u.qcow2.zone;
+    zone_host_managed = &create_options->u.qcow2.zone->u.host_managed;
 
     bs = bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
     if (bs == NULL) {
@@ -3739,6 +3897,14 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3796,10 +3962,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3807,11 +3972,62 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Set the external data file if necessary */
+    BDRVQcow2State *s = blk_bs(blk)->opaque;
     if (data_bs) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (zone_struct && zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        s->zoned_header.zoned = BLK_Z_HM;
+
+        if (!zone_host_managed->has_size) {
+            s->zoned_header.zone_size = DEFAULT_ZONE_SIZE;
+        } else {
+            s->zoned_header.zone_size = zone_host_managed->size;
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
+        }
+
+        if (zone_host_managed->has_max_active_zones) {
+            s->zoned_header.max_active_zones =
+                zone_host_managed->max_active_zones;
+
+            if (zone_host_managed->has_max_open_zones) {
+                s->zoned_header.max_open_zones =
+                    zone_host_managed->max_open_zones;
+            } else {
+                s->zoned_header.max_open_zones =
+                    zone_host_managed->max_active_zones;
+            }
+        }
+
+        if (zone_host_managed->has_max_append_bytes) {
+            s->zoned_header.max_append_bytes =
+                    zone_host_managed->max_append_bytes;
+        } else {
+            s->zoned_header.max_append_bytes = DEFAULT_MAX_APPEND_BYTES;
+        }
+
+        if (!qcow2_check_zone_options(&s->zoned_header, errp)) {
+            s->zoned_header.zoned = BLK_Z_NONE;
+            ret = -EINVAL;
+            goto unlock;
+        }
+    } else {
+        s->zoned_header.zoned = BLK_Z_NONE;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3885,6 +4101,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     ret = 0;
+    goto out;
+unlock:
+    bdrv_graph_co_rdunlock();
 out:
     blk_co_unref(blk);
     bdrv_co_unref(bs);
@@ -3945,6 +4164,10 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_CONVENTIONAL_ZONES, "zone.conventional-zones" },
+        { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
+        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
+        { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
         { NULL, NULL },
     };
 
@@ -6113,6 +6336,41 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Compression method used for image cluster "        \
                     "compression",                                      \
             .def_value_str = "zlib"                                     \
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
index a9e3481c6e..cc9bff0473 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -128,6 +128,9 @@
 
 #define DEFAULT_CLUSTER_SIZE 65536
 
+#define DEFAULT_ZONE_SIZE (256 * MiB)
+#define DEFAULT_MAX_APPEND_BYTES (64 * KiB)
+
 #define QCOW2_OPT_DATA_FILE "data-file"
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
@@ -236,6 +239,27 @@ typedef struct Qcow2CryptoHeaderExtension {
     uint64_t length;
 } QEMU_PACKED Qcow2CryptoHeaderExtension;
 
+typedef struct Qcow2ZonedHeaderExtension {
+    /* Zoned device attributes */
+    uint8_t zoned;
+    uint8_t reserved[3];
+    uint64_t zone_size;
+    uint64_t zone_capacity;
+    uint32_t conventional_zones;
+    uint32_t nr_zones;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
+    uint32_t max_append_bytes;
+    uint64_t zonedmeta_size;
+    uint64_t zonedmeta_offset;
+} QEMU_PACKED Qcow2ZonedHeaderExtension;
+
+typedef struct Qcow2ZoneListEntry {
+    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
+    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
+    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
+} Qcow2ZoneListEntry;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -256,17 +280,20 @@ enum {
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
@@ -422,6 +449,9 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    /* States of zoned device */
+    Qcow2ZonedHeaderExtension zoned_header;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 2c4618375a..18834a9a7c 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -125,7 +125,26 @@ the next fields through header_length.
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
@@ -249,6 +268,7 @@ be stored. Each extension has a structure like the following:
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
                         0x44415441 - External data file name string
+                        0x007a6264 - Zoned extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -331,6 +351,91 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+== Zoned extension ==
+
+The zoned extension must be present if the incompatible bit is set, and
+omitted when the incompatible bit is clear. It contains fields for
+emulating the zoned storage model (https://zonedstorage.io/). When the
+zone model mode is not host-managed, it is regarded as incompatible
+and reports an error to users.
+
+The write pointers for each zone are stored in an area called zonedmeta
+clusters. It is 8 bytes per zone. The offset and size of the zonedmeta
+are kept in the zoned extension header.
+
+The fields of the zoned extension are:
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
+          4 -  11: zone_size
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
+          12 - 19: zone_capacity
+                   The number of writable bytes within the zones. The bytes
+                   between zone capacity and zone size are unusable: reads
+                   will return 0s and writes will fail.
+
+                   A zone capacity is always smaller or equal to the zone
+                   size. It is for emulating a real ZNS drive configuration,
+                   which has the constraint of aligning to some hardware erase
+                   block size.
+
+         20 - 23:  conventional_zones
+                   The number of conventional zones. The conventional zones
+                   allow sequential writes and random writes. While the
+                   sequential zones only allow sequential writes.
+
+         24 - 27:  nr_zones
+                   The number of zones. It is the sum of conventional zones
+                   and sequential zones. The maximum value for nr_zones is
+                   (2^32 - 1)/8 = 536870911.
+
+         28 - 31:  max_active_zones
+                   The number of the zones that can be in the implicit open,
+                   explicit open or closed state. The max active zones cannot
+                   be larger than the max open zones.
+
+         32 - 35:  max_open_zones
+                   The maximal number of open (implicitly open or explicitly
+                   open) zones. It cannot be larger than the number of SWR
+                   zones of the device.
+
+                   If the limits of open zones or active zones are equal to
+                   the total number of SWR zones, then it's the same as having
+                   no limits therefore max open zones and max active zones are
+                   set to 0.
+
+         36 - 39:  max_append_bytes
+                   The number of bytes of a zone append request that can be
+                   issued to the device. It must be 512-byte aligned and less
+                   than the zone capacity.
+
+         40 - 47:  zonedmeta_size
+                   The size of zoned metadata in bytes. It contains no more
+                   than 4GB. The zoned metadata structure is the write
+                   pointers for each zone whose size is the number of zones
+                   multiplied by the zone size.
+
+         48 - 55:  zonedmeta_offset
+                   The offset of zoned metadata structure in the contained
+                   image, in bytes.
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a50..e1001ad9a3 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,13 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_ZONE_MODEL        "zone.mode"
+#define BLOCK_OPT_ZONE_SIZE         "zone.size"
+#define BLOCK_OPT_ZONE_CAPACITY     "zone.capacity"
+#define BLOCK_OPT_CONVENTIONAL_ZONES    "zone.conventional_zones"
+#define BLOCK_OPT_MAX_APPEND_BYTES      "zone.max_append_bytes"
+#define BLOCK_OPT_MAX_ACTIVE_ZONES      "zone.max_active_zones"
+#define BLOCK_OPT_MAX_OPEN_ZONES        "zone.max_open_zones"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -881,7 +888,13 @@ typedef struct BlockLimits {
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
index 9f6dd59298..43500da1bb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5073,6 +5073,69 @@
 { 'enum': 'Qcow2CompressionType',
   'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
+##
+# @Qcow2ZoneModel:
+#
+# Zoned device model used in qcow2 image file
+#
+# @host-managed: The host-managed model only allows sequential write over the
+#     device zones.
+#
+# Since 8.2
+##
+{ 'enum': 'Qcow2ZoneModel',
+  'data': [ 'host-managed'] }
+
+##
+# @Qcow2ZoneHostManaged:
+#
+# The host-managed zone model.  It only allows sequential writes.
+#
+# @size: Total number of bytes within zones (default 256 MB).
+#
+# @capacity: The number of usable logical blocks within zones
+#     in bytes.  A zone capacity is always smaller or equal to the
+#     zone size (default to zone size).
+#
+# @conventional-zones: The number of conventional zones of the
+#     zoned device (default 0).
+#
+# @max-open-zones: The maximal number of open zones.  It is less than
+#     or equal to the number of sequential write required zones of
+#     the device (default 0).
+#
+# @max-active-zones: The maximal number of zones in the implicit
+#     open, explicit open or closed state.  It is less than or equal
+#     to the max open zones (default 0).
+#
+# @max-append-bytes: The maximal number of bytes of a zone
+#     append request that can be issued to the device.  It must be
+#     512-byte aligned and less than the zone capacity (default 64 KB).
+#
+# Since 8.2
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
+# The zone device model for the qcow2 image.
+#
+# @mode: The zone device model modes.
+#
+# Since 8.2
+##
+{ 'union': 'Qcow2ZoneCreateOptions',
+  'base': { 'mode': 'Qcow2ZoneModel' },
+  'discriminator': 'mode',
+  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -5115,6 +5178,9 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone: The zone device model modes.  The default is that the device is
+# not zoned.  (since 8.2)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
@@ -5131,7 +5197,8 @@
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
             '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+            '*compression-type':'Qcow2CompressionType',
+            '*zone':            'Qcow2ZoneCreateOptions' } }
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.34.1


