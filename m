Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6E2CD37B9
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 17:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM8JA-0000OP-P3; Sun, 10 May 2026 13:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wM8J6-0000Lo-O6
 for qemu-devel@nongnu.org; Sun, 10 May 2026 13:51:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wM8J1-0001hx-BL
 for qemu-devel@nongnu.org; Sun, 10 May 2026 13:51:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so34993975e9.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778435465; x=1779040265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CbTgBpTALfPDOCVS8LUTYnbTLmuJhgho732OZlO89k=;
 b=KDkX5EL3q1euOXoscEL684KfgfijDwSPU5cuif6ShsXW2kGoEQCXEiENLGd5Ri4pX+
 HxhY1IWxsUsI9mgwdn3g+5mxVNTsfERkTyzbTAEsA6FNZvFwwfClhrAp1bWpFlCcAYIu
 G6wh5btnOW43SDRFsgThPTCwn9oeoUn8eb2pvCHAJYqDvnfCF/ne0MTeGmn7AoL/ab8q
 ASGq9lfAPzX8QQtLlaFhiQYqzvBxbL54OYh1s81Bfh36Gm2RQoBQlUxC2AU2kPvLVC2f
 eGBJd3IITzSFoD4998giXWulln3hzpfpPuV1Jc5a8R9om/6ueiQyG1WrXYODNyZfV/dT
 4JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778435465; x=1779040265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7CbTgBpTALfPDOCVS8LUTYnbTLmuJhgho732OZlO89k=;
 b=HoVuRx7C9QccW5pApRlbj1qlqEPV9KrlWfcBhhWHsi2yxcM38R0k3gNiaTWLOKl1MC
 RaWZLFrE8LXWdMhDu0swQfVCTpDlgptsh+LvDSnPSP3FAUQrbUXqIiFHvqXgEJQ5nMcy
 1U7OX404577bg4KPF8VfShe4hmrygfHM/1MJ3YLZRnxmHlb2appncwXMaIx5Zc+NFAiT
 Vo2YAp1ztRP2h8lf/Fd3TYSPKQ7m2vQmElRKzulXqRc6ETwdOnQXspFlRmuBzu8dNr4g
 a4yJp1Upxz8H4lxGNwhxPkx0D+Iln2X/xUfIzbLxd7GfEleeOWahmuPfYs+QVqL94xkt
 HD3g==
X-Gm-Message-State: AOJu0Yz8nfhoWBWmrwgkH+opJGnEAXlBHdLssrEuWWuEAcUTMOEDS7NU
 JBhHmmm3n6bRKNrO5Wk1jFiubajumljIwshLcgvv5Av7fn9tDaqsTEQl+XFHfQ==
X-Gm-Gg: Acq92OFoR/0oc0yPUXsIn/LWIKVUasO0kbvxJFZFzsqjhxQ/NlzppCChsdqIyav3S1a
 sgHlL5JePJiUz42hdO5oMZT4mctFry1imefI5GtDu1vilTrUucpsC/UeCp953IhPi6gjzA2bItK
 T3Kezy0PFMGJxO8mOx2RfKzJIrwJpvx0JLg4X+agwC7ekWKQTDoePpBFFHVf9718VouYouyr6Eh
 hTq+xuXwfCFdBE4FkFqd8Vt7OZhwjpqcCgCxakfj2E530ed57AwXfurMJC5FsWBS7fCZgfI8Fx0
 NT0zsvUpUTJ8XlPt4P1iNyra1ss51o3WsSae7q5rCU3slQWpZ5kpBWB5iQ/HAWNJi1xWi8oucV9
 hmxK8mV7yo2TcG+e6Okw/lLSJZIYF28MgNpjjZsk/0kZfS/v57PeiZeuFwYoXbEPhHvAoby+gUA
 GbZG3JW+kseBw0zcjjpT2OCzC3e21rUyI9iEgTtTn8BSel+EZmQcqWvMiPH9JTzDM=
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id
 5b1f17b1804b1-48e676b6393mr116157715e9.24.1778435465249; 
 Sun, 10 May 2026 10:51:05 -0700 (PDT)
Received: from groves.. ([95.90.240.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e0bf2sm225215565e9.4.2026.05.10.10.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 10:51:04 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 dlemoal@kernel.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v10 2/4] qcow2: add configurations for zoned format extension
Date: Sun, 10 May 2026 19:50:57 +0200
Message-ID: <20260510175059.311814-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510175059.311814-1-faithilikerun@gmail.com>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=faithilikerun@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/file-posix.c               |   2 +-
 block/qcow2.c                    | 264 ++++++++++++++++++++++++++++++-
 block/qcow2.h                    |  32 +++-
 docs/interop/qcow2.rst           | 110 ++++++++++++-
 include/block/block_int-common.h |  15 +-
 qapi/block-core.json             |  70 +++++++-
 6 files changed, 485 insertions(+), 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index e49b13d6ab..14278785b9 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3607,7 +3607,7 @@ raw_co_zone_append(BlockDriverState *bs,
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
-                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
+                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
         return -EINVAL;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 81fd299b4c..b543bcf3e3 100644
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
@@ -2068,6 +2183,15 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
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
@@ -3170,6 +3294,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3215,6 +3344,31 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3589,6 +3743,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     ERRP_GUARD();
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
+    Qcow2ZoneCreateOptions *zone_struct;
+    Qcow2ZoneHostManaged *zone_host_managed;
 
     /*
      * Open the image file and write a minimal qcow2 header.
@@ -3615,6 +3771,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
+    zone_struct = create_options->u.qcow2.zone;
+    zone_host_managed = &create_options->u.qcow2.zone->u.host_managed;
 
     bs = bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
     if (bs == NULL) {
@@ -3828,6 +3986,14 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3885,10 +4051,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3896,11 +4061,62 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3974,6 +4190,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     ret = 0;
+    goto out;
+unlock:
+    bdrv_graph_co_rdunlock();
 out:
     blk_co_unref(blk);
     bdrv_co_unref(bs);
@@ -4052,6 +4271,10 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_CONVENTIONAL_ZONES, "zone.conventional-zones" },
+        { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
+        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
+        { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
         { NULL, NULL },
     };
 
@@ -6265,6 +6488,41 @@ static QemuOptsList qcow2_create_opts = {
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
index 192a45d596..743f2e3e79 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -129,6 +129,9 @@
 
 #define DEFAULT_CLUSTER_SIZE 65536
 
+#define DEFAULT_ZONE_SIZE (256 * MiB)
+#define DEFAULT_MAX_APPEND_BYTES (64 * KiB)
+
 #define QCOW2_OPT_DATA_FILE "data-file"
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
@@ -237,6 +240,27 @@ typedef struct Qcow2CryptoHeaderExtension {
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
@@ -257,17 +281,20 @@ enum {
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
@@ -426,6 +453,9 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    /* States of zoned device */
+    Qcow2ZonedHeaderExtension zoned_header;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.rst b/docs/interop/qcow2.rst
index 5948591107..7bf3a00e77 100644
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
 
@@ -344,6 +364,94 @@ The fields of the bitmaps extension are::
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+Zoned extension
+---------------
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
index 508b081ac1..d771dfb4a1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5268,6 +5268,70 @@
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
+# Since 11.0
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
+#     512-byte aligned and less than the zone capacity
+#     (default 64 KB).
+#
+# Since 11.0
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
+# Since 11.0
+##
+{ 'union': 'Qcow2ZoneCreateOptions',
+  'base': { 'mode': 'Qcow2ZoneModel' },
+  'discriminator': 'mode',
+  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -5310,6 +5374,9 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone: The zone device model modes.  The default is that the
+#     device is not zoned.  (since 11.0)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
@@ -5326,7 +5393,8 @@
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
             '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+            '*compression-type':'Qcow2CompressionType',
+            '*zone':            'Qcow2ZoneCreateOptions' } }
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.43.0


