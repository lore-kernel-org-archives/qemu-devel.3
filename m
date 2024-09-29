Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BA6CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suuDZ-00052A-Sf; Sun, 29 Sep 2024 09:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suuDY-0004wm-Fl; Sun, 29 Sep 2024 09:44:08 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suuDU-0008Oq-VF; Sun, 29 Sep 2024 09:44:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c46680a71bso4071465a12.2; 
 Sun, 29 Sep 2024 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727617441; x=1728222241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/nq7aDHcl6in+katvosA0KPSp8jF/1/PQ3+r4UGKi4=;
 b=N20Ja8/B/xwS/kFsrjlIy3eZPRbXsqUG60q/bA10skTo4UjB6eSwk34s2ntWlwgx72
 1n/mEmlbwrSILbnhQoRqMO37JfyhNuOYtH8i07amEI8eRgKd8GNBnI3ddZs9EIFOiTJv
 McYKCKT2eL7/dy2yfA+575LtStdc3epx0Oq7uMng9LZKxhxhpQg3zpAAt24o20t81Nde
 MX9QdkAJXoml29oWXSEOKi7lVWrEaIVJL1NpJY89b9TQt440l5iTY1HNqqNZaeJYaW5W
 2wYaeqP7UOvTABUIfkQtYegShnEI5wds4xx8rGWq5b+Gjhf/0tZNmJhuE3cdLkWHplNt
 49qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727617441; x=1728222241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/nq7aDHcl6in+katvosA0KPSp8jF/1/PQ3+r4UGKi4=;
 b=VnqwynOK21WAPEqAEdvgnuwIUZjNtoreYZqbpqptbNHbrKd71JXXlKWwsMw/WHPhZw
 3GU4yV0dk1CUxHvTPnGikKhS1GX9TUat8H98elW+4d17zg69B2SPzXVA0ff+vBtEIhRc
 eYRXr9Xd7Iy+1BAMh1IsS3sJjL08LXLMGi6eJoenXS5AnMUHuqMlceNYl6+wx/Se07kB
 YUVHo0d2btWL+YWmwe5wHmJj+SFGONtWVSJr9tpQYn8prEiRzto36s1WRDfuqgWkTHRl
 9Fp2ivgq7fHgcrLjiPG/yVpLA7nVGTK5Mxkrl/GCS5E/gvbG/aXRP0GID1NaIFZ5oHD0
 hG4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDoKkVZauoIAwlxRRFtGNhP9Zf2Sl6/tQH0TDd768CUcIr7qDtzjkSXO6zbwnOqumtDT/wmWPpv1RO@nongnu.org
X-Gm-Message-State: AOJu0YxiQqVcN6RC7fB8YMd6SN6kHd89dxGCZR5Se32115MeyP+QxWgS
 I4zN/rhmaDIp4QNYbZfL4teXgdu4nBVr3eUROyNxjP3S0YRzDi5IaKaQTDLa
X-Google-Smtp-Source: AGHT+IHOF01dPz/wVAZvZUHX4GEiTzJAcZeIcDTsVpkVrxLaBj0FHqrTTv63cF78Vybw7JHm7bVlsQ==
X-Received: by 2002:a17:907:3f1c:b0:a8a:8d81:97b1 with SMTP id
 a640c23a62f3a-a93c4929876mr832510866b.27.1727617441286; 
 Sun, 29 Sep 2024 06:44:01 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2775934sm377029866b.35.2024.09.29.06.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 06:44:00 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, Eric Blake <eblake@redhat.com>, dmitry.fomichev@wdc.com,
 dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v9 3/4] qcow2: add zoned emulation capability
Date: Sun, 29 Sep 2024 15:43:55 +0200
Message-Id: <20240929134356.562086-4-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929134356.562086-1-faithilikerun@gmail.com>
References: <20240929134356.562086-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x529.google.com
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

By adding zone operations and zoned metadata, the zoned emulation
capability enables full emulation support of zoned device using
a qcow2 file. The zoned device metadata includes zone type,
zoned device state and write pointer of each zone, which is stored
to an array of unsigned integers.

Each zone of a zoned device makes state transitions following
the zone state machine. The zone state machine mainly describes
five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
READ ONLY and OFFLINE states will generally be affected by device
internal events. The operations on zones cause corresponding state
changing.

Zoned devices have limits on zone resources, which put constraints on
write operations on zones. It is managed by active zone queues
following LRU policy.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c        | 850 ++++++++++++++++++++++++++++++++++++++++++-
 block/qcow2.h        |  13 +-
 block/trace-events   |   2 +
 include/qemu/queue.h |   1 +
 include/qemu/range.h |   4 +
 5 files changed, 862 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index f0fd9d79a2..0c995b6d37 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -195,6 +195,293 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
+#define QCOW2_GET_WP(wp)        ((wp << 5) >> 5)
+
+/*
+ * To emulate a real zoned device, closed, empty and full states are
+ * preserved after a power cycle. The open states are in-memory and will
+ * be lost after closing the device. Read-only and offline states are
+ * device-internal events, which are not considered for simplicity.
+ */
+static inline BlockZoneState qcow2_get_zone_state(BlockDriverState *bs,
+                                                  uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+    uint64_t zone_wp = bs->wps->wp[index];
+    uint64_t zone_start;
+
+    if (QCOW2_ZT_IS_CONV(zone_wp)) {
+        return BLK_ZS_NOT_WP;
+    }
+
+    if (QTAILQ_IN_USE(zone_entry, exp_open_zone_entry)) {
+        return BLK_ZS_EOPEN;
+    }
+    if (QTAILQ_IN_USE(zone_entry, imp_open_zone_entry)) {
+        return BLK_ZS_IOPEN;
+    }
+
+    zone_start = index * bs->bl.zone_size;
+    if (zone_wp == zone_start) {
+        return BLK_ZS_EMPTY;
+    }
+    if (zone_wp >= zone_start + bs->bl.zone_capacity) {
+        return BLK_ZS_FULL;
+    }
+    if (zone_wp > zone_start) {
+        if (!QTAILQ_IN_USE(zone_entry, closed_zone_entry)) {
+            /*
+             * The number of closed zones is not always updated in time when
+             * the device is closed. However, it only matters when doing
+             * zone report. Refresh the count and list of closed zones to
+             * provide correct zone states for zone report.
+             */
+            QTAILQ_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
+            s->nr_zones_closed++;
+        }
+        return BLK_ZS_CLOSED;
+    }
+    return BLK_ZS_NOT_WP;
+}
+
+static void qcow2_rm_exp_open_zone(BDRVQcow2State *s,
+                                   uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_REMOVE(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
+    s->nr_zones_exp_open--;
+}
+
+static void qcow2_rm_imp_open_zone(BDRVQcow2State *s,
+                                   int32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry;
+    if (index < 0) {
+        /* Apply LRU when the index is not specified. */
+        zone_entry = QTAILQ_LAST(&s->imp_open_zones);
+    } else {
+        zone_entry = &s->zone_list_entries[index];
+    }
+
+    QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+    s->nr_zones_imp_open--;
+}
+
+static void qcow2_rm_open_zone(BDRVQcow2State *s,
+                               uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    if (QTAILQ_IN_USE(zone_entry, exp_open_zone_entry)) {
+        qcow2_rm_exp_open_zone(s, index);
+    } else if (QTAILQ_IN_USE(zone_entry, imp_open_zone_entry)) {
+        qcow2_rm_imp_open_zone(s, index);
+    }
+}
+
+static void qcow2_rm_closed_zone(BDRVQcow2State *s,
+                                 uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_REMOVE(&s->closed_zones, zone_entry, closed_zone_entry);
+    s->nr_zones_closed--;
+}
+
+static void qcow2_do_imp_open_zone(BDRVQcow2State *s,
+                                   uint32_t index,
+                                   BlockZoneState zs)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        break;
+    case BLK_ZS_CLOSED:
+        qcow2_rm_closed_zone(s, index);
+        break;
+    case BLK_ZS_IOPEN:
+        /*
+         * The LRU policy: update the zone that is most recently
+         * used to the head of the zone list
+         */
+        if (zone_entry == QTAILQ_FIRST(&s->imp_open_zones)) {
+            return;
+        }
+        QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+        s->nr_zones_imp_open--;
+        break;
+    default:
+        return;
+    }
+
+    QTAILQ_INSERT_HEAD(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+    s->nr_zones_imp_open++;
+}
+
+static void qcow2_do_exp_open_zone(BDRVQcow2State *s,
+                                   uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_INSERT_HEAD(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
+    s->nr_zones_exp_open++;
+}
+
+/*
+ * The list of zones is managed using an LRU policy: the last
+ * zone of the list is always the one that was least recently used
+ * for writing and is chosen as the zone to close to be able to
+ * implicitly open another zone.
+ *
+ * We can only close the open zones. The index is not specified
+ * when it is less than 0.
+ */
+static void qcow2_do_close_zone(BlockDriverState *bs,
+                                int32_t index,
+                                BlockZoneState zs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneListEntry *zone_entry;
+
+    if (index >= 0) {
+        zone_entry = &s->zone_list_entries[index];
+    } else {
+        /* before removal of the last implicitly open zone */
+        zone_entry = QTAILQ_LAST(&s->imp_open_zones);
+    }
+
+    if (zs == BLK_ZS_IOPEN) {
+        qcow2_rm_imp_open_zone(s, index);
+        goto close_zone;
+    }
+
+    if (index >= 0 && zs == BLK_ZS_EOPEN) {
+        qcow2_rm_exp_open_zone(s, index);
+        /*
+         * The zone state changes when the zone is removed from the list of
+         * open zones (explicitly open -> empty). The closed zone list is
+         * refreshed during get_zone_state().
+         */
+        qcow2_get_zone_state(bs, index);
+    }
+    return;
+
+close_zone:
+    QTAILQ_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
+    s->nr_zones_closed++;
+}
+
+/*
+ * Read/Write the new wp value to the dedicated location of the image file.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_rw_wp_at(BlockDriverState *bs, uint64_t *wp,
+                  int32_t index, bool is_write) {
+    BDRVQcow2State *s = bs->opaque;
+    g_autofree uint64_t *temp = NULL;
+    uint64_t wpv = *wp;
+    int ret;
+
+    if (is_write) {
+        ret = bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
+                          + sizeof(uint64_t) * index, sizeof(uint64_t), wp, 0);
+        if (ret < 0) {
+            *wp = wpv;
+            goto exit;
+        }
+    } else {
+        temp = g_new(uint64_t, 1);
+        ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset
+                         + sizeof(uint64_t) * index, sizeof(uint64_t), temp, 0);
+        if (ret < 0) {
+            goto exit;
+        }
+
+        *wp = *temp;
+    }
+
+    trace_qcow2_wp_tracking(index, *wp >> BDRV_SECTOR_BITS);
+    return ret;
+
+exit:
+    error_report("Failed to %s metadata to file", is_write ? "write" : "read");
+    return ret;
+}
+
+static bool qcow2_can_activate_zone(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    /* When the max active zone is zero, there is no limit on active zones */
+    if (!s->zoned_header.max_active_zones) {
+        return true;
+    }
+
+    /* Active zones are zones that are open or closed */
+    return s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_closed
+        < s->zoned_header.max_active_zones;
+}
+
+/*
+ * This function manages open zones under active zones limit. It checks
+ * if a zone can transition to open state while maintaining max open and
+ * active zone limits.
+ */
+static bool qcow2_can_open_zone(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    /* When the max open zone is zero, there is no limit on open zones */
+    if (!s->zoned_header.max_open_zones) {
+        return true;
+    }
+
+    /*
+     * The open zones are zones with the states of explicitly and
+     * implicitly open.
+     */
+    if (s->nr_zones_imp_open + s->nr_zones_exp_open <
+        s->zoned_header.max_open_zones) {
+        return true;
+    }
+
+    /*
+     * Zones are managed one at a time. Thus, the number of implicitly open
+     * zone can never be over the open zone limit. When the active zone limit
+     * is not reached, close only one implicitly open zone.
+     */
+    if (qcow2_can_activate_zone(bs)) {
+        qcow2_do_close_zone(bs, -1, BLK_ZS_IOPEN);
+        trace_qcow2_imp_open_zones(0x23, s->nr_zones_imp_open);
+        return true;
+    }
+    return false;
+}
+
+static inline int coroutine_fn GRAPH_RDLOCK
+qcow2_refresh_zonedmeta(BlockDriverState *bs)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t wps_size = s->zoned_header.zonedmeta_size;
+    g_autofree uint64_t *temp = NULL;
+
+    temp = g_new(uint64_t, s->zoned_header.nr_zones);
+    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
+                     wps_size, temp, 0);
+    if (ret < 0) {
+        error_report("Cannot read metadata");
+        return ret;
+    }
+
+    memcpy(bs->wps->wp, temp, wps_size);
+    return 0;
+}
+
 /*
  * Passing by the zoned device configurations by a zoned_header struct, check
  * if the zone device options are under constraints. Return false when some
@@ -527,7 +814,23 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 be32_to_cpu(zoned_ext.max_active_zones);
             zoned_ext.max_append_bytes =
                 be32_to_cpu(zoned_ext.max_append_bytes);
+            zoned_ext.zonedmeta_offset =
+                be64_to_cpu(zoned_ext.zonedmeta_offset);
+            zoned_ext.zonedmeta_size = be64_to_cpu(zoned_ext.zonedmeta_size);
             s->zoned_header = zoned_ext;
+            bs->wps = g_malloc(sizeof(BlockZoneWps)
+                + s->zoned_header.zonedmeta_size);
+            ret = qcow2_refresh_zonedmeta(bs);
+            if (ret < 0) {
+                return ret;
+            }
+
+            s->zone_list_entries = g_new0(Qcow2ZoneListEntry,
+                                          zoned_ext.nr_zones);
+            QTAILQ_INIT(&s->exp_open_zones);
+            QTAILQ_INIT(&s->imp_open_zones);
+            QTAILQ_INIT(&s->closed_zones);
+            qemu_co_mutex_init(&bs->wps->colock);
 
             /* refuse to open broken images */
             if (zoned_ext.nr_zones != DIV_ROUND_UP(bs->total_sectors *
@@ -2797,21 +3100,119 @@ static coroutine_fn GRAPH_RDLOCK int qcow2_co_pwritev_task_entry(AioTask *task)
                                  t->l2meta);
 }
 
+/*
+ * If it is an append write request, the offset pointer needs to be updated to
+ * the wp value of that zone after the IO completion. The unique pointer is
+ * passed on to this function to prevent the value being changed in condition of
+ * multiple concurrent writes.
+ */
 static int coroutine_fn GRAPH_RDLOCK
-qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      QEMUIOVector *qiov, size_t qiov_offset,
-                      BdrvRequestFlags flags)
+qcow2_co_pwv_part(BlockDriverState *bs, int64_t *offset_ptr, int64_t bytes,
+                  QEMUIOVector *qiov, size_t qiov_offset, bool is_append,
+                  BdrvRequestFlags flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t host_offset;
+    int64_t offset = *offset_ptr;
     QCowL2Meta *l2meta = NULL;
     AioTaskPool *aio = NULL;
+    int64_t start_offset, start_bytes;
+    BlockZoneState zs;
+    int64_t end_zone, end_offset;
+    uint64_t *wp;
+    int64_t zone_size = bs->bl.zone_size;
+    int64_t zone_capacity = bs->bl.zone_capacity;
+    int index;
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
+    start_offset = offset;
+    start_bytes = bytes;
+    if (bs->bl.zoned == BLK_Z_HM) {
+        index = start_offset / zone_size;
+        wp = &bs->wps->wp[index];
+        if (!QCOW2_ZT_IS_CONV(*wp)) {
+            if (offset != *wp && !is_append) {
+                /* The write offset must be equal to the zone write pointer */
+                error_report("Offset 0x%" PRIx64 " of regular writes must be "
+                             "equal to the zone write pointer 0x%" PRIx64 "",
+                             offset, *wp);
+                return -EINVAL;
+            }
+
+            if (is_append) {
+                /*
+                 * The offset of append write is the write pointer value of
+                 * that zone.
+                 */
+                start_offset = *wp;
+            }
+
+            end_offset = start_offset + start_bytes;
+
+            /* Only allow writes when there are zone resources left */
+            zs = qcow2_get_zone_state(bs, index);
+            if (zs == BLK_ZS_CLOSED || zs == BLK_ZS_EMPTY) {
+                if (!qcow2_can_open_zone(bs)) {
+                    error_report("no more open zones available");
+                    return -EINVAL;
+                }
+            }
+
+            /*
+             * Align up (start_offset, zone_size), the start offset is not
+             * necessarily power of two.
+             */
+            end_zone = index * zone_size + zone_capacity;
+            /* Write cannot exceed the zone capacity. */
+            if (end_offset > end_zone) {
+                error_report("write exceeds zone capacity with end_offset:"
+                             "0x%lx, end_zone: 0x%lx",
+                             end_offset / 512, end_zone / 512);
+                return -EINVAL;
+            }
+
+            /*
+             * Real drives change states before it can write to the zone. If
+             * the write fails, the zone state may have changed.
+             *
+             * The zone state transitions to implicit open when the original
+             * state is empty or closed. When the wp reaches the end, the
+             * open states (explicit open, implicit open) become full.
+             */
+            zs = qcow2_get_zone_state(bs, index);
+            if (!(end_offset & (zone_capacity - 1))) {
+                /* Being aligned to zone capacity implies full state */
+                qcow2_rm_open_zone(s, index);
+                trace_qcow2_imp_open_zones(0x24,
+                                           s->nr_zones_imp_open);
+            } else {
+                qcow2_do_imp_open_zone(s, index, zs);
+                trace_qcow2_imp_open_zones(0x24,
+                                           s->nr_zones_imp_open);
+            }
+
+            /*
+             * The write pointer is update before IO completion, with the
+             * assumption that the write IO will succeed.
+             */
+            qemu_co_mutex_lock(&bs->wps->colock);
+            if (is_append) {
+                *offset_ptr = *wp;
+            }
+            *wp = end_offset;
+            ret = qcow2_rw_wp_at(bs, wp, index, true);
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            if (ret < 0) {
+                error_report("failed to update write pointer");
+                return -EINVAL;
+            }
+        }
+    }
+
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
 
         l2meta = NULL;
@@ -2857,6 +3258,7 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
         qiov_offset += cur_bytes;
         trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
     }
+
     ret = 0;
 
     qemu_co_mutex_lock(&s->lock);
@@ -2875,11 +3277,32 @@ fail_nometa:
         g_free(aio);
     }
 
+    if (ret < 0 && bs->bl.zoned == BLK_Z_HM) {
+        /* update the wp when write IO failed */
+        qemu_co_mutex_lock(&bs->wps->colock);
+        index = start_offset / zone_size;
+        wp = &bs->wps->wp[index];
+        if (!QCOW2_ZT_IS_CONV(*wp)) {
+            ret = qcow2_rw_wp_at(bs, wp, index, false);
+        }
+        qemu_co_mutex_unlock(&bs->wps->colock);
+    }
+
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
 
     return ret;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                      QEMUIOVector *qiov, size_t qiov_offset,
+                      BdrvRequestFlags flags)
+{
+    return qcow2_co_pwv_part(bs, &offset, bytes, qiov, qiov_offset, false,
+                             flags);
+}
+
+
 static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -2915,6 +3338,25 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
     return result;
 }
 
+static void qcow2_do_close_all_zone(BDRVQcow2State *s)
+{
+    Qcow2ZoneListEntry *zone_entry, *next;
+
+    QTAILQ_FOREACH_SAFE(zone_entry, &s->imp_open_zones, imp_open_zone_entry,
+                        next) {
+        QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
+        s->nr_zones_imp_open--;
+    }
+
+    QTAILQ_FOREACH_SAFE(zone_entry, &s->exp_open_zones, exp_open_zone_entry,
+                        next) {
+        QTAILQ_REMOVE(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
+        s->nr_zones_exp_open--;
+    }
+
+    assert(s->nr_zones_imp_open + s->nr_zones_exp_open == 0);
+}
+
 static void coroutine_mixed_fn GRAPH_RDLOCK
 qcow2_do_close(BlockDriverState *bs, bool close_data_file)
 {
@@ -2954,6 +3396,8 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
 
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
+    qcow2_do_close_all_zone(s);
+    g_free(bs->wps);
 }
 
 static void GRAPH_UNLOCKED qcow2_close(BlockDriverState *bs)
@@ -3268,7 +3712,10 @@ int qcow2_update_header(BlockDriverState *bs)
             .max_active_zones   =
                 cpu_to_be32(s->zoned_header.max_active_zones),
             .max_append_bytes =
-                cpu_to_be32(s->zoned_header.max_append_bytes)
+                cpu_to_be32(s->zoned_header.max_append_bytes),
+            .zonedmeta_offset   =
+                cpu_to_be64(s->zoned_header.zonedmeta_offset),
+            .zonedmeta_size     = cpu_to_be64(s->zoned_header.zonedmeta_size),
         };
         ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
                              &zoned_header, sizeof(zoned_header),
@@ -3677,7 +4124,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     int version;
     int refcount_order;
     uint64_t *refcount_table;
-    int ret;
+    uint64_t zoned_meta_size, zoned_clusterlen;
+    int ret, offset, i;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
@@ -4024,6 +4472,41 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             ret = -EINVAL;
             goto unlock;
         }
+
+        uint32_t nrz = s->zoned_header.nr_zones;
+        zoned_meta_size =  sizeof(uint64_t) * nrz;
+        g_autofree uint64_t *meta = NULL;
+        meta = g_new0(uint64_t, nrz);
+
+        for (i = 0; i < s->zoned_header.conventional_zones; ++i) {
+            meta[i] = i * s->zoned_header.zone_size;
+            meta[i] |= 1ULL << 59;
+        }
+
+        for (; i < nrz; ++i) {
+            meta[i] = i * s->zoned_header.zone_size;
+        }
+
+        offset = qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
+        if (offset < 0) {
+            ret = offset;
+            error_setg_errno(errp, -ret, "Could not allocate clusters "
+                                         "for zoned metadata size");
+            goto unlock;
+        }
+        s->zoned_header.zonedmeta_offset = offset;
+        s->zoned_header.zonedmeta_size = zoned_meta_size;
+
+        zoned_clusterlen = size_to_clusters(s, zoned_meta_size)
+                * s->cluster_size;
+        assert(qcow2_pre_write_overlap_check(bs, 0, offset,
+                                             zoned_clusterlen, false) == 0);
+        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Could not write zoned metadata "
+                                         "to disk");
+            goto unlock;
+        }
     } else {
         s->zoned_header.zoned = BLK_Z_NONE;
     }
@@ -4366,6 +4849,359 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return ret;
 }
 
+static int coroutine_fn
+qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
+                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t zone_size = s->zoned_header.zone_size;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t size = bs->bl.nr_zones * zone_size;
+    unsigned int nrz;
+    int i = 0;
+    int si;
+
+    if (offset >= capacity) {
+        error_report("offset %" PRId64 " is equal to or greater than the "
+                     "device capacity %" PRId64 "", offset, capacity);
+        return -EINVAL;
+    }
+
+    nrz = ((*nr_zones) < bs->bl.nr_zones) ? (*nr_zones) : bs->bl.nr_zones;
+    si = offset / zone_size; /* Zone size cannot be 0 for zoned device */
+    qemu_co_mutex_lock(&bs->wps->colock);
+    for (; i < nrz; ++i) {
+        if (i + si >= bs->bl.nr_zones) {
+            break;
+        }
+
+        zones[i].start = (si + i) * zone_size;
+
+        /* The last zone can be smaller than the zone size */
+        if ((si + i + 1) == bs->bl.nr_zones && size > capacity) {
+            uint32_t l = zone_size - (size - capacity);
+            zones[i].length = l;
+            zones[i].cap = l;
+        } else {
+            zones[i].length = zone_size;
+            zones[i].cap = zone_size;
+        }
+
+        uint64_t wp = bs->wps->wp[si + i];
+        if (QCOW2_ZT_IS_CONV(wp)) {
+            zones[i].type = BLK_ZT_CONV;
+            zones[i].state = BLK_ZS_NOT_WP;
+            /* Clear masking bits */
+            wp = QCOW2_GET_WP(wp);
+        } else {
+            zones[i].type = BLK_ZT_SWR;
+            zones[i].state = qcow2_get_zone_state(bs, si + i);
+        }
+        zones[i].wp = wp;
+    }
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    *nr_zones = i;
+    return 0;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_open_zone(BlockDriverState *bs, uint32_t index) {
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+    trace_qcow2_imp_open_zones(BLK_ZO_OPEN, s->nr_zones_imp_open);
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        if (!qcow2_can_activate_zone(bs)) {
+            ret = -EBUSY;
+            goto unlock;
+        }
+        break;
+    case BLK_ZS_IOPEN:
+        qcow2_rm_imp_open_zone(s, index);
+        break;
+    case BLK_ZS_EOPEN:
+        return 0;
+    case BLK_ZS_CLOSED:
+        if (!qcow2_can_open_zone(bs)) {
+            ret = -EINVAL;
+            goto unlock;
+        }
+        qcow2_rm_closed_zone(s, index);
+        break;
+    case BLK_ZS_FULL:
+        break;
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+
+    qcow2_do_exp_open_zone(s, index);
+    ret = 0;
+
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int qcow2_close_zone(BlockDriverState *bs, uint32_t index)
+{
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        break;
+    case BLK_ZS_IOPEN:
+        break;
+    case BLK_ZS_EOPEN:
+        break;
+    case BLK_ZS_CLOSED:
+        /* Closing a closed zone is not an error */
+        ret = 0;
+        goto unlock;
+    case BLK_ZS_FULL:
+        break;
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+    qcow2_do_close_zone(bs, index, zs);
+    ret = 0;
+
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_finish_zone(BlockDriverState *bs, uint32_t index) {
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        if (!qcow2_can_activate_zone(bs)) {
+            ret = -EBUSY;
+            goto unlock;
+        }
+        break;
+    case BLK_ZS_IOPEN:
+        qcow2_rm_imp_open_zone(s, index);
+        trace_qcow2_imp_open_zones(BLK_ZO_FINISH, s->nr_zones_imp_open);
+        break;
+    case BLK_ZS_EOPEN:
+        qcow2_rm_exp_open_zone(s, index);
+        break;
+    case BLK_ZS_CLOSED:
+        if (!qcow2_can_open_zone(bs)) {
+            ret = -EINVAL;
+            goto unlock;
+        }
+        qcow2_rm_closed_zone(s, index);
+        break;
+    case BLK_ZS_FULL:
+        ret = 0;
+        goto unlock;
+    default:
+        ret = -EINVAL;
+        goto unlock;
+    }
+
+    *wp = ((uint64_t)index + 1) * s->zoned_header.zone_size;
+    ret = qcow2_rw_wp_at(bs, wp, index, true);
+
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
+                            int64_t len) {
+    BDRVQcow2State *s = bs->opaque;
+    int nrz = bs->bl.nr_zones;
+    int zone_size = bs->bl.zone_size;
+    int n, ret = 0;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+    if (len == bs->total_sectors << BDRV_SECTOR_BITS) {
+        n = nrz;
+        index = 0;
+    } else {
+        n = len / zone_size;
+    }
+
+    for (int i = 0; i < n; ++i) {
+        uint64_t *wp_i = (uint64_t *)(wp + i);
+        uint64_t wpi_v = *wp_i;
+        if (QCOW2_ZT_IS_CONV(wpi_v)) {
+            continue;
+        }
+
+        BlockZoneState zs = qcow2_get_zone_state(bs, index + i);
+        switch (zs) {
+        case BLK_ZS_EMPTY:
+            break;
+        case BLK_ZS_IOPEN:
+            qcow2_rm_imp_open_zone(s, index + i);
+            trace_qcow2_imp_open_zones(BLK_ZO_RESET, s->nr_zones_imp_open);
+            break;
+        case BLK_ZS_EOPEN:
+            qcow2_rm_exp_open_zone(s, index + i);
+            break;
+        case BLK_ZS_CLOSED:
+            qcow2_rm_closed_zone(s, index + i);
+            break;
+        case BLK_ZS_FULL:
+            break;
+        default:
+            ret = -EINVAL;
+            goto unlock;
+        }
+
+        if (zs == BLK_ZS_EMPTY) {
+            continue;
+        }
+
+        *wp_i = ((uint64_t)index + i) * zone_size;
+        ret = qcow2_rw_wp_at(bs, wp_i, index + i, true);
+        if (ret < 0) {
+            goto unlock;
+        }
+        /* clear data */
+        ret = qcow2_co_pwrite_zeroes(bs, *wp_i, zone_size, 0);
+        if (ret < 0) {
+            error_report("Failed to reset zone at 0x%" PRIx64 "", *wp_i);
+        }
+    }
+
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
+                                           int64_t offset, int64_t len)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret = 0;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t zone_size = s->zoned_header.zone_size;
+    int64_t zone_size_mask = zone_size - 1;
+    uint32_t index = offset / zone_size;
+    BlockZoneWps *wps = bs->wps;
+
+    if (offset >= capacity) {
+        error_report("offset %" PRId64 " is equal to or greater than the"
+                     "device capacity %" PRId64 "", offset, capacity);
+        return -EINVAL;
+    }
+
+    if (offset & zone_size_mask) {
+        error_report("sector offset %" PRId64 " is not aligned to zone size"
+                     " %" PRId64 "", offset / 512, zone_size / 512);
+        return -EINVAL;
+    }
+
+    if (((offset + len) < capacity && len & zone_size_mask) ||
+        offset + len > capacity) {
+        error_report("number of sectors %" PRId64 " is not aligned to zone"
+                     " size %" PRId64 "", len / 512, zone_size / 512);
+        return -EINVAL;
+    }
+
+    qemu_co_mutex_lock(&wps->colock);
+    uint64_t wpv = wps->wp[index];
+    if (QCOW2_ZT_IS_CONV(wpv) && len != capacity) {
+        error_report("zone mgmt operations are not allowed for "
+                     "conventional zones");
+        ret = -EIO;
+        goto unlock;
+    }
+    qemu_co_mutex_unlock(&wps->colock);
+
+    switch (op) {
+    case BLK_ZO_OPEN:
+        ret = qcow2_open_zone(bs, index);
+        break;
+    case BLK_ZO_CLOSE:
+        ret = qcow2_close_zone(bs, index);
+        break;
+    case BLK_ZO_FINISH:
+        ret = qcow2_finish_zone(bs, index);
+        break;
+    case BLK_ZO_RESET:
+        ret = qcow2_reset_zone(bs, index, len);
+        break;
+    default:
+        error_report("Unsupported zone op: 0x%x", op);
+        ret = -ENOTSUP;
+        break;
+    }
+    return ret;
+
+unlock:
+    qemu_co_mutex_unlock(&wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector *qiov,
+                     BdrvRequestFlags flags)
+{
+    assert(flags == 0);
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t zone_size_mask = bs->bl.zone_size - 1;
+    int64_t iov_len = 0;
+    int64_t len = 0;
+
+    if (*offset >= capacity) {
+        error_report("*offset %" PRId64 " is equal to or greater than the"
+                     "device capacity %" PRId64 "", *offset, capacity);
+        return -EINVAL;
+    }
+
+    /* offset + len should not pass the end of that zone starting from offset */
+    if (*offset & zone_size_mask) {
+        error_report("sector offset %" PRId64 " is not aligned to zone size "
+                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
+        return -EINVAL;
+    }
+
+    int64_t wg = bs->bl.write_granularity;
+    int64_t wg_mask = wg - 1;
+    for (int i = 0; i < qiov->niov; i++) {
+        iov_len = qiov->iov[i].iov_len;
+        if (iov_len & wg_mask) {
+            error_report("len of IOVector[%d] 0x%" PRIx64 " is not aligned to "
+                         "block size 0x%" PRIx64 "", i, iov_len, wg);
+            return -EINVAL;
+        }
+    }
+    len = qiov->size;
+
+    if ((len >> BDRV_SECTOR_BITS) > bs->bl.max_append_sectors) {
+        error_report("len 0x%" PRIx64 " in sectors is greater than "
+                     "max_append_sectors 0x%" PRIx32 "",
+                     len >> BDRV_SECTOR_BITS, bs->bl.max_append_sectors);
+        return -EINVAL;
+    }
+
+    return qcow2_co_pwv_part(bs, offset, len, qiov, 0, true, 0);
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_copy_range_from(BlockDriverState *bs,
                          BdrvChild *src, int64_t src_offset,
@@ -6426,6 +7262,10 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_pwritev_compressed_part    = qcow2_co_pwritev_compressed_part,
     .bdrv_make_empty                    = qcow2_make_empty,
 
+    .bdrv_co_zone_report    = qcow2_co_zone_report,
+    .bdrv_co_zone_mgmt    = qcow2_co_zone_mgmt,
+    .bdrv_co_zone_append    = qcow2_co_zone_append,
+
     .bdrv_snapshot_create               = qcow2_snapshot_create,
     .bdrv_snapshot_goto                 = qcow2_snapshot_goto,
     .bdrv_snapshot_delete               = qcow2_snapshot_delete,
diff --git a/block/qcow2.h b/block/qcow2.h
index cc9bff0473..412461a1b1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -255,9 +255,9 @@ typedef struct Qcow2ZonedHeaderExtension {
 } QEMU_PACKED Qcow2ZonedHeaderExtension;
 
 typedef struct Qcow2ZoneListEntry {
-    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
-    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
-    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
+    QTAILQ_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
 } Qcow2ZoneListEntry;
 
 typedef struct Qcow2UnknownHeaderExtension {
@@ -452,6 +452,13 @@ typedef struct BDRVQcow2State {
 
     /* States of zoned device */
     Qcow2ZonedHeaderExtension zoned_header;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) exp_open_zones;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) imp_open_zones;
+    QTAILQ_HEAD(, Qcow2ZoneListEntry) closed_zones;
+    Qcow2ZoneListEntry *zone_list_entries;
+    uint32_t nr_zones_exp_open;
+    uint32_t nr_zones_imp_open;
+    uint32_t nr_zones_closed;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/block/trace-events b/block/trace-events
index 8e789e1f12..e35222e079 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -82,6 +82,8 @@ qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_pwrite_zeroes(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset 0x%" PRIx64 " nb_clusters %d"
+qcow2_wp_tracking(int index, uint64_t wp) "wps[%d]: 0x%" PRIx64
+qcow2_imp_open_zones(uint8_t op, int nrz) "nr_imp_open_zones after op 0x%x: %d"
 
 # qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index e029e7bf66..3f0a48740e 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -179,6 +179,7 @@ struct {                                                                \
 #define QLIST_EMPTY(head)                ((head)->lh_first == NULL)
 #define QLIST_FIRST(head)                ((head)->lh_first)
 #define QLIST_NEXT(elm, field)           ((elm)->field.le_next)
+#define QLIST_LAST(head, field)          (*(head)->lh_first->field.le_prev)
 
 
 /*
diff --git a/include/qemu/range.h b/include/qemu/range.h
index d446ad885d..d39ba68407 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -213,6 +213,10 @@ static inline int range_covers_byte(uint64_t offset, uint64_t len,
 static inline bool ranges_overlap(uint64_t first1, uint64_t len1,
                                   uint64_t first2, uint64_t len2)
 {
+    if (first1 + len1 == 0 || first2 + len2 == 0) {
+        return false;
+    }
+
     uint64_t last1 = range_get_last(first1, len1);
     uint64_t last2 = range_get_last(first2, len2);
 
-- 
2.34.1


