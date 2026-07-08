Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31F8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whaZM-0008Me-9m; Wed, 08 Jul 2026 18:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZL-0008M7-LM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZG-0004HG-PO
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:39 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso666477a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783548993; x=1784153793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/q3R32EwpDpapU5qLyKPSVNTj/fyPBi6s6GAbIOHidc=;
 b=E4uqCpyLMWR/1BbSNC9peHZjsyo6qSSfXbnXrHLFzbbJEY0MMmvumg4N57nMe+x394
 f2sBD+xiLXZsDTrvCoTpjjgKvoMdibAyhwUePWkpDoGs4zqP2qG4TECv7QWcGjwTZLLB
 PmXGwzLwSC5Da22iJpHTZyLwXzKsN9AvXDA5Pv8qC4oQiDYFTV/k0NHTACGDvXJnmRal
 +8PUUbVd60w1ltMXrgQUcH+jUhClsWwBS3jlU8OgI3TOcnP4Kgklkw5A1RTlqWei57m4
 C1eYqniRk+7RyevPOMooJL14bJ8/KONSTn0OTmegq/JECo/iE6J6KqiqA7esYMIq6SWT
 Ni+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783548993; x=1784153793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/q3R32EwpDpapU5qLyKPSVNTj/fyPBi6s6GAbIOHidc=;
 b=jYKzolwB0TUSIgboN7GPOshPXh1jdnsCULNOfmdM6PirRHajEMUl8wZV89MCXV4rBw
 UGlpFPRGOgO2EAnk9ARIAGi7ofbZfGK2itR4jk/e10zYRzTow+t3fbrHjuOJ/oDae6yB
 wMr9udw/cVjEM8twW2bR+RmXT5Uftp5AvPetjeXdnv/fJCQK1/cnsMkU+lQgDn4K8qzL
 xj2BWGP7EqvUlbK8tvgL9BgggG4C9avgd2Df9dlWHI2mFQy2ipH9Siop5WQkGL2LiL0h
 Ms9RKziQIZedryhmEIB6FflDgBuN9t9oH+wCP4cqWbAfnFgUZMEcSpaMoUwGGZHYWzwp
 WUJA==
X-Gm-Message-State: AOJu0YzVrycfOb9CGeQa2u+s5cOUCvTujkwEZQjDgNCWA94dQyRs09/5
 VDQAm8L1CFz5OThOXUL6Cm2zjZ4uVXBw6myPlYiHH4b68+/VWmZgJu4sye951fOxIF0=
X-Gm-Gg: AfdE7clLgBaWklU1Oi8iz09aUJz8BwVmwkS/VvT1d5JqwzKsIby8m9hpvdDW7HV73xe
 aIiPzHVXsorGaTLP2jLFIQ6tPo70lCnSLjDj/lEfo94AxwnytL7l3TMQKMsa5marJerKvO+UxV/
 UyXMQ9ah0aIwBRTxvhivXX6nuOY30XXHwvI78xYI+k9canXA6Sc9uKuPGAJ5HBbFYqE3U0ibADU
 VWqUpRDUOKvmn6AXC67qAn9sCYxynwfJcqPlwWBWeVgEnnp8/ZUb6oB572fsaXuooyYfRpxFqsp
 GhgRlIyTnUQkcH5efMkny//O9dw17OqnqGeNXFlulFTYVa1UDGo39x1Etm/3YRZkh4xQERdoVRz
 RkNPf2jX/wCZ0Sw6NtTTAxObov4yrVYNV2qEhuGDvdVWRUrRUqyziEcxY8VeBy8OTXTbAlNd9Th
 /wntz7etpYLjzRd6FH/f1CjRpQNfF8bGu3Dw5lZCZHREmLLDywX/sM4GV8
X-Received: by 2002:a05:6402:2787:b0:698:3b7c:3b2e with SMTP id
 4fb4d7f45d1cf-69c032a536bmr57794a12.16.1783548992886; 
 Wed, 08 Jul 2026 15:16:32 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:2200:181c:eef9:4c12])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d786e7sm9059237a12.16.2026.07.08.15.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:16:32 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v14 5/6] qcow2: add zoned emulation capability
Date: Thu,  9 Jul 2026 00:16:14 +0200
Message-ID: <20260708221615.346155-6-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708221615.346155-1-faithilikerun@gmail.com>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x535.google.com
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

By adding zone operations and zoned metadata, the zoned emulation
capability enables full emulation support of zoned device using
a qcow2 file. The zoned device metadata includes zone type,
zoned device state and write pointer (WP) of each zone, which is
stored to an array of unsigned integers.

WP accessor (qcow2_rw_wp_at) routes reads and writes of an 8-byte
WP slot through the write pointer cache. The write pointer cache is
written to disk after the qcow2 metadata is written, thus guaranteeing
that the write pointer is updated after the corresponding data is
written. Per-completion cache flush is deferred. The WP cluster reaches
disk on the next flush.

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
 block/qcow2-cache.c    |   11 +-
 block/qcow2-refcount.c |    7 +
 block/qcow2.c          | 1219 +++++++++++++++++++++++++++++++++++++++-
 block/qcow2.h          |    2 +
 block/trace-events     |    2 +
 5 files changed, 1234 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 23d9588b08..73f2be3641 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -275,14 +275,23 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
 {
     int ret;
 
+    /*
+     * If the dependency graph is unchanged, nothing to do. This avoids
+     * a synchronous flush on every call below.
+     */
+    if (c->depends == dependency) {
+        return 0;
+    }
+
     if (dependency->depends) {
+        /* Flatten any chain on the dependency side as a cycle-breaker. */
         ret = qcow2_cache_flush_dependency(bs, dependency);
         if (ret < 0) {
             return ret;
         }
     }
 
-    if (c->depends && (c->depends != dependency)) {
+    if (c->depends) {
         ret = qcow2_cache_flush_dependency(bs, c);
         if (ret < 0) {
             return ret;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 6512cda407..f551726609 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1239,6 +1239,13 @@ int qcow2_write_caches(BlockDriverState *bs)
         }
     }
 
+    if (s->wp_cache) {
+        ret = qcow2_cache_write(bs, s->wp_cache);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     return 0;
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 9873789f58..e6f0fb5681 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -195,6 +195,320 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+#define QCOW2_WP_CONV_BIT       (1ULL << 63)
+#define QCOW2_ZT_IS_CONV(wp)    ((wp) & QCOW2_WP_CONV_BIT)
+#define QCOW2_GET_WP(wp)        ((wp) & ~QCOW2_WP_CONV_BIT)
+
+/*
+ * To emulate a real zoned device, closed, empty and full states are
+ * preserved after a power cycle. The open states are in-memory and will
+ * be lost after closing the device. Read-only and offline states are
+ * device-internal events, which are not considered for simplicity.
+ *
+ * The qcow2 state lock must be held when called.
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
+    zone_start = (uint64_t)index * bs->bl.zone_size;
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
+/* The qcow2 state lock must be held when called */
+static void qcow2_rm_exp_open_zone(BDRVQcow2State *s,
+                                   uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_REMOVE(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
+    s->nr_zones_exp_open--;
+}
+
+/* The qcow2 state lock must be held when called */
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
+/* The qcow2 state lock must be held when called */
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
+/* The qcow2 state lock must be held when called */
+static void qcow2_rm_closed_zone(BDRVQcow2State *s,
+                                 uint32_t index)
+{
+    Qcow2ZoneListEntry *zone_entry = &s->zone_list_entries[index];
+
+    QTAILQ_REMOVE(&s->closed_zones, zone_entry, closed_zone_entry);
+    s->nr_zones_closed--;
+}
+
+/* The qcow2 state lock must be held when called */
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
+/* The qcow2 state lock must be held when called */
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
+ *
+ * The qcow2 state lock must be held when called.
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
+        assert(zone_entry != NULL);
+        qcow2_rm_imp_open_zone(s, index);
+        QTAILQ_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
+        s->nr_zones_closed++;
+        return;
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
+}
+
+/*
+ * Read/Write the new wp value for zone `index` through write pointer
+ * cache. Reads return the value currently held in the cache, which may
+ * be ahead of the on-disk value if the cache hasn't been flushed yet.
+ * Writes update the cache and mark the entry dirty.
+ */
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_rw_wp_at(BlockDriverState *bs, uint64_t *wp,
+                  int32_t index, bool is_write)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t wp_byte_off = sizeof(uint64_t) * index;
+    uint64_t cluster_file_off =
+        s->zoned_header.zonedmeta_offset +
+        (wp_byte_off & ~((uint64_t)s->cluster_size - 1));
+    size_t off_in_cluster = wp_byte_off & (s->cluster_size - 1);
+    void *cluster_buf;
+    uint64_t *slot;
+    int ret;
+
+    assert(s->wp_cache != NULL);
+
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_cache_get(bs, s->wp_cache, cluster_file_off, &cluster_buf);
+    if (ret < 0) {
+        qemu_co_mutex_unlock(&s->lock);
+        error_report("Failed to %s WP slot (zone %d): %s",
+                     is_write ? "write" : "read", index, strerror(-ret));
+        return ret;
+    }
+
+    slot = (uint64_t *)((char *)cluster_buf + off_in_cluster);
+    if (is_write) {
+        *slot = cpu_to_be64(*wp);
+        qcow2_cache_entry_mark_dirty(s->wp_cache, cluster_buf);
+    } else {
+        *wp = be64_to_cpu(*slot);
+    }
+    qcow2_cache_put(s->wp_cache, &cluster_buf);
+    qemu_co_mutex_unlock(&s->lock);
+
+    trace_qcow2_wp_tracking(index, *wp >> BDRV_SECTOR_BITS);
+    return 0;
+}
+
+/* The qcow2 state lock must be held when called */
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
+ *
+ * The qcow2 state lock must be held when called.
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
+     *
+     * Only an implicitly open zone can be evicted to make room. If every
+     * open zone is explicitly open, the open zone limit cannot be satisfied.
+     */
+    if (s->nr_zones_imp_open > 0 && qcow2_can_activate_zone(bs)) {
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
+    uint64_t wps_size = s->zoned_header.nr_zones * sizeof(uint64_t);
+    g_autofree uint64_t *temp = NULL;
+
+    QEMU_BUILD_BUG_ON(!BDRV_ZT_IS_CONV(QCOW2_WP_CONV_BIT));
+
+    temp = g_new(uint64_t, s->zoned_header.nr_zones);
+    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
+                     wps_size, temp, 0);
+    if (ret < 0) {
+        error_report("Cannot read metadata");
+        return ret;
+    }
+
+    for (uint32_t i = 0; i < s->zoned_header.nr_zones; i++) {
+        bs->wps->wp[i] = be64_to_cpu(temp[i]);
+    }
+    return 0;
+}
+
 /*
  * Returns true if zone_opt is valid, false otherwise.
  */
@@ -547,6 +861,8 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 be32_to_cpu(zoned_ext.max_active_zones);
             zoned_ext.max_append_bytes =
                 be32_to_cpu(zoned_ext.max_append_bytes);
+            zoned_ext.zonedmeta_offset =
+                be64_to_cpu(zoned_ext.zonedmeta_offset);
             s->zoned_header = zoned_ext;
 
             /* validate the header first */
@@ -593,6 +909,38 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 }
             }
 
+            bs->wps = g_malloc(sizeof(BlockZoneWps)
+                + s->zoned_header.nr_zones * sizeof(uint64_t));
+            ret = qcow2_refresh_zonedmeta(bs);
+            if (ret < 0) {
+                g_free(bs->wps);
+                bs->wps = NULL;
+                return ret;
+            }
+
+            s->zone_list_entries = g_new0(Qcow2ZoneListEntry,
+                                          zoned_ext.nr_zones);
+            QTAILQ_INIT(&s->exp_open_zones);
+            QTAILQ_INIT(&s->imp_open_zones);
+            QTAILQ_INIT(&s->closed_zones);
+            qemu_co_mutex_init(&bs->wps->colock);
+
+            s->zone_wp_state = g_new0(Qcow2ZoneWPState, zoned_ext.nr_zones);
+            for (uint32_t i = 0; i < zoned_ext.nr_zones; i++) {
+                QTAILQ_INIT(&s->zone_wp_state[i].in_flight);
+                QTAILQ_INIT(&s->zone_wp_state[i].completed_pending);
+                qemu_co_queue_init(&s->zone_wp_state[i].drain);
+            }
+
+            s->wp_cache = qcow2_cache_create(bs,
+                DIV_ROUND_UP(zoned_ext.nr_zones * sizeof(uint64_t),
+                             s->cluster_size),
+                s->cluster_size);
+            if (!s->wp_cache) {
+                error_setg(errp, "Could not allocate the write pointer cache");
+                return -ENOMEM;
+            }
+
 #ifdef DEBUG_EXT
             printf("Qcow2: Got zoned format extension: "
                    "offset=%" PRIu64 "\n", offset);
@@ -2946,21 +3294,292 @@ static coroutine_fn GRAPH_RDLOCK int qcow2_co_pwritev_task_entry(AioTask *task)
                                  t->l2meta);
 }
 
+/*
+ * Walk the per-zone completed_pending list while the head's LBA equals
+ * the cached persisted-WP, advancing persisted-WP and marking each
+ * covered request RESOLVED. On any advance, the new persisted-WP is
+ * written into the WP cache and depends-on qcow2 L2 table cache is
+ * established so write pointer is updated after the corresponding write
+ * completes.
+ *
+ * Caller holds bs->wps->colock.
+ */
 static int coroutine_fn GRAPH_RDLOCK
-qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      QEMUIOVector *qiov, size_t qiov_offset,
-                      BdrvRequestFlags flags)
+qcow2_wp_greedy_advance_locked(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneWPState *zs = &s->zone_wp_state[index];
+    uint64_t wp_byte_off = sizeof(uint64_t) * index;
+    uint64_t cluster_file_off =
+        s->zoned_header.zonedmeta_offset +
+        (wp_byte_off & ~((uint64_t)s->cluster_size - 1));
+    size_t off_in_cluster = wp_byte_off & (s->cluster_size - 1);
+    void *cluster_buf;
+    uint64_t *slot;
+    uint64_t persisted_wp, new_persisted_wp;
+    Qcow2WPReq *head;
+    bool any_advanced = false;
+    int ret;
+
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_cache_get(bs, s->wp_cache, cluster_file_off, &cluster_buf);
+    if (ret < 0) {
+        qemu_co_mutex_unlock(&s->lock);
+        return ret;
+    }
+    slot = (uint64_t *)((char *)cluster_buf + off_in_cluster);
+    persisted_wp = be64_to_cpu(*slot);
+    new_persisted_wp = persisted_wp;
+
+    QTAILQ_FOREACH(head, &zs->completed_pending, entry) {
+        if (head->lba != new_persisted_wp) {
+            break;
+        }
+        new_persisted_wp += head->len;
+        any_advanced = true;
+    }
+
+    if (!any_advanced) {
+        qcow2_cache_put(s->wp_cache, &cluster_buf);
+        qemu_co_mutex_unlock(&s->lock);
+        return 0;
+    }
+
+    *slot = cpu_to_be64(new_persisted_wp);
+    qcow2_cache_entry_mark_dirty(s->wp_cache, cluster_buf);
+    qcow2_cache_put(s->wp_cache, &cluster_buf);
+
+    qcow2_cache_set_dependency(bs, s->wp_cache, s->l2_table_cache);
+    qemu_co_mutex_unlock(&s->lock);
+
+    while (!QTAILQ_EMPTY(&zs->completed_pending)) {
+        head = QTAILQ_FIRST(&zs->completed_pending);
+        if (head->lba >= new_persisted_wp) {
+            break;
+        }
+        QTAILQ_REMOVE(&zs->completed_pending, head, entry);
+        head->state = QCOW2_WP_REQ_RESOLVED;
+        qemu_co_queue_restart_all(&head->wait);
+    }
+
+    return 0;
+}
+
+/*
+ * Insert req into the zone's completed_pending list in ascending LBA
+ * order. Data writes may complete out of order; greedy_advance walks
+ * the list head while head->lba == persisted_wp, so the list must
+ * stay sorted.
+ *
+ * Caller holds bs->wps->colock.
+ */
+static void
+qcow2_wp_insert_pending_locked(Qcow2ZoneWPState *zs, Qcow2WPReq *req)
+{
+    Qcow2WPReq *iter;
+
+    req->state = QCOW2_WP_REQ_PENDING;
+
+    QTAILQ_FOREACH(iter, &zs->completed_pending, entry) {
+        if (iter->lba > req->lba) {
+            QTAILQ_INSERT_BEFORE(iter, req, entry);
+            return;
+        }
+    }
+    QTAILQ_INSERT_TAIL(&zs->completed_pending, req, entry);
+}
+
+/*
+ * Peer requests with lba > failed_lba are marked ABORTED. Survivors
+ * with lba < failed_lba are left untouched. Logical WP is rolled back
+ * to the contiguous extent above persisted-WP that remains covered by
+ * survivor requests.
+ *
+ * Caller holds bs->wps->colock.
+ */
+static void
+qcow2_wp_abort_higher_peers_locked(BlockDriverState *bs, uint32_t index,
+                                    uint64_t failed_lba)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2ZoneWPState *zs = &s->zone_wp_state[index];
+    Qcow2WPReq *r, *next;
+    uint64_t logical_wp;
+
+    QTAILQ_FOREACH(r, &zs->in_flight, entry) {
+        if (r->lba > failed_lba && r->state != QCOW2_WP_REQ_ABORTED) {
+            r->state = QCOW2_WP_REQ_ABORTED;
+            qemu_co_queue_restart_all(&r->wait);
+        }
+    }
+    QTAILQ_FOREACH_SAFE(r, &zs->completed_pending, entry, next) {
+        if (r->lba > failed_lba) {
+            r->state = QCOW2_WP_REQ_ABORTED;
+            QTAILQ_REMOVE(&zs->completed_pending, r, entry);
+            qemu_co_queue_restart_all(&r->wait);
+        }
+    }
+
+    /* Rewind logical_wp to the highest survivor end_offset. */
+    logical_wp = failed_lba;
+    QTAILQ_FOREACH(r, &zs->in_flight, entry) {
+        if (r->lba < failed_lba && r->lba + r->len > logical_wp) {
+            logical_wp = r->lba + r->len;
+        }
+    }
+    QTAILQ_FOREACH(r, &zs->completed_pending, entry) {
+        if (r->lba < failed_lba && r->lba + r->len > logical_wp) {
+            logical_wp = r->lba + r->len;
+        }
+    }
+    bs->wps->wp[index] = logical_wp;
+}
+
+/*
+ * If it is an append write request, the offset pointer needs to be updated to
+ * the wp value of that zone after the IO completion. The unique pointer is
+ * passed on to this function to prevent the value being changed in condition of
+ * multiple concurrent writes.
+ *
+ * For host-managed zoned writes, the WP lock is acquired across the WP
+ * check and advance, with the qcow2 state lock nested for the zone
+ * state TAILQ traversals.
+ */
+static int coroutine_fn GRAPH_RDLOCK
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
+    int index = 0;
+    Qcow2WPReq req;
+    Qcow2WPReq *wp_req = NULL;
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
+    start_offset = offset;
+    start_bytes = bytes;
+    if (bs->bl.zoned == BLK_Z_HM) {
+        index = start_offset / zone_size;
+        wp = &bs->wps->wp[index];
+        qemu_co_mutex_lock(&bs->wps->colock);
+        if (QCOW2_ZT_IS_CONV(*wp)) {
+            qemu_co_mutex_unlock(&bs->wps->colock);
+        } else {
+            if (offset != *wp && !is_append) {
+                /* The write offset must be equal to the zone write pointer */
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                error_report("Offset 0x%" PRIx64 " of regular writes must be "
+                             "equal to the zone write pointer 0x%" PRIx64 "",
+                             offset, *wp);
+                return -EIO;
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
+            qemu_co_mutex_lock(&s->lock);
+
+            /* Only allow writes when there are zone resources left */
+            zs = qcow2_get_zone_state(bs, index);
+            if (zs == BLK_ZS_CLOSED || zs == BLK_ZS_EMPTY) {
+                if (!qcow2_can_open_zone(bs)) {
+                    qemu_co_mutex_unlock(&s->lock);
+                    qemu_co_mutex_unlock(&bs->wps->colock);
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
+                qemu_co_mutex_unlock(&s->lock);
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                error_report("write exceeds zone capacity with end_offset: "
+                             "0x%" PRIx64 ", end_zone: 0x%" PRIx64,
+                             end_offset / 512, end_zone / 512);
+                return -EIO;
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
+            if (end_offset == end_zone) {
+                /* Reaching the zone capacity implies full state */
+                qcow2_rm_open_zone(s, index);
+                trace_qcow2_imp_open_zones(0x24,
+                                           s->nr_zones_imp_open);
+            } else {
+                qcow2_do_imp_open_zone(s, index, zs);
+                trace_qcow2_imp_open_zones(0x24,
+                                           s->nr_zones_imp_open);
+            }
+
+            qemu_co_mutex_unlock(&s->lock);
+
+            /*
+             * Submission for a zone append write. The logical-WP is updated
+             * while the on-disk WP is not touched.
+             */
+            if (is_append) {
+                start_offset = *wp;
+                end_offset = start_offset + start_bytes;
+                end_zone = (uint64_t)index * zone_size + zone_capacity;
+                if (end_offset > end_zone) {
+                    qemu_co_mutex_unlock(&bs->wps->colock);
+                    error_report("append: end_offset 0x%" PRIx64
+                                 " > end_zone 0x%" PRIx64,
+                                 end_offset, end_zone);
+                    return -EIO;
+                }
+                *offset_ptr = start_offset;
+                offset = start_offset;
+            }
+
+            wp_req = &req;
+            wp_req->lba = start_offset;
+            wp_req->len = start_bytes;
+            wp_req->state = QCOW2_WP_REQ_INFLIGHT;
+            qemu_co_queue_init(&wp_req->wait);
+            QTAILQ_INSERT_TAIL(&s->zone_wp_state[index].in_flight,
+                               wp_req, entry);
+
+            *wp = end_offset;
+            qemu_co_mutex_unlock(&bs->wps->colock);
+        }
+    }
+
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
 
         l2meta = NULL;
@@ -3021,14 +3640,81 @@ fail_nometa:
         if (ret == 0) {
             ret = aio_task_pool_status(aio);
         }
-        g_free(aio);
+        g_free(aio);
+    }
+
+    if (wp_req != NULL) {
+        qemu_co_mutex_lock(&bs->wps->colock);
+        QTAILQ_REMOVE(&s->zone_wp_state[index].in_flight, wp_req, entry);
+        if (QTAILQ_EMPTY(&s->zone_wp_state[index].in_flight)) {
+            qemu_co_queue_restart_all(&s->zone_wp_state[index].drain);
+        }
+
+        if (wp_req->state == QCOW2_WP_REQ_ABORTED) {
+            /*
+             * A peer's failure handler aborted us. Whether our data
+             * write itself succeeded or not, reject it.
+             */
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            ret = ret < 0 ? ret : -EIO;
+            goto wp_done;
+        }
+
+        if (ret < 0) {
+            /*
+             * This req's data write failed. Higher-LBA peers (still
+             * in_flight or already completed_pending) are marked ABORTED,
+             * their waiters woken; logical-WP rewinds to the highest
+             * surviving end_offset below this LBA. The zone remains usable.
+             */
+            qcow2_wp_abort_higher_peers_locked(bs, index, wp_req->lba);
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            goto wp_done;
+        }
+
+        qcow2_wp_insert_pending_locked(&s->zone_wp_state[index], wp_req);
+
+        ret = qcow2_wp_greedy_advance_locked(bs, index);
+        if (ret < 0) {
+            if (wp_req->state == QCOW2_WP_REQ_PENDING) {
+                QTAILQ_REMOVE(&s->zone_wp_state[index].completed_pending,
+                              wp_req, entry);
+            }
+            qcow2_wp_abort_higher_peers_locked(bs, index, wp_req->lba);
+            qemu_co_mutex_unlock(&bs->wps->colock);
+            goto wp_done;
+        }
+
+        /* Block until this write pointer req is RESOLVED or ABORTED. */
+        while (wp_req->state == QCOW2_WP_REQ_PENDING) {
+            qemu_co_queue_wait(&wp_req->wait, &bs->wps->colock);
+        }
+
+        if (wp_req->state == QCOW2_WP_REQ_ABORTED) {
+            ret = -EIO;
+        } else {
+            assert(wp_req->state == QCOW2_WP_REQ_RESOLVED);
+            ret = 0;
+        }
+        qemu_co_mutex_unlock(&bs->wps->colock);
     }
 
+wp_done:
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
@@ -3057,6 +3743,15 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
                      strerror(-ret));
     }
 
+    if (s->wp_cache) {
+        ret = qcow2_cache_flush(bs, s->wp_cache);
+        if (ret) {
+            result = ret;
+            error_report("Failed to flush the WP cache: %s",
+                         strerror(-ret));
+        }
+    }
+
     if (result == 0) {
         qcow2_mark_clean(bs);
     }
@@ -3064,6 +3759,25 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
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
@@ -3079,6 +3793,10 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     cache_clean_timer_del_and_wait(bs);
     qcow2_cache_destroy(s->l2_table_cache);
     qcow2_cache_destroy(s->refcount_block_cache);
+    if (s->wp_cache) {
+        qcow2_cache_destroy(s->wp_cache);
+        s->wp_cache = NULL;
+    }
 
     qcrypto_block_free(s->crypto);
     s->crypto = NULL;
@@ -3103,6 +3821,12 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
 
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
+    qcow2_do_close_all_zone(s);
+    g_free(s->zone_list_entries);
+    s->zone_list_entries = NULL;
+    g_free(s->zone_wp_state);
+    s->zone_wp_state = NULL;
+    g_free(bs->wps);
 }
 
 static void GRAPH_UNLOCKED qcow2_close(BlockDriverState *bs)
@@ -3420,7 +4144,9 @@ int qcow2_update_header(BlockDriverState *bs)
             .max_active_zones   =
                 cpu_to_be32(s->zoned_header.max_active_zones),
             .max_append_bytes =
-                cpu_to_be32(s->zoned_header.max_append_bytes)
+                cpu_to_be32(s->zoned_header.max_append_bytes),
+            .zonedmeta_offset   =
+                cpu_to_be64(s->zoned_header.zonedmeta_offset),
         };
         ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
                              &zoned_header, sizeof(zoned_header),
@@ -3829,7 +4555,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     int version;
     int refcount_order;
     uint64_t *refcount_table;
-    int ret;
+    uint64_t zoned_meta_size, zoned_clusterlen;
+    int64_t offset;
+    int ret, i;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
@@ -4192,6 +4920,48 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
+            meta[i] |= QCOW2_WP_CONV_BIT;
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
+
+        zoned_clusterlen = size_to_clusters(s, zoned_meta_size)
+                * s->cluster_size;
+        ret = qcow2_pre_write_overlap_check(blk_bs(blk), 0, offset,
+                                            zoned_clusterlen, false);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Overlap check failed for zoned "
+                                         "metadata");
+            goto unlock;
+        }
+        for (i = 0; i < nrz; ++i) {
+            meta[i] = cpu_to_be64(meta[i]);
+        }
+        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Could not write zoned metadata "
+                                         "to disk");
+            goto unlock;
+        }
     } else {
         s->zoned_header.zoned = QCOW2_Z_NONE;
     }
@@ -4597,6 +5367,439 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return ret;
 }
 
+static int coroutine_fn
+qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
+                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t zone_size = s->zoned_header.zone_size;
+    uint64_t zone_capacity = s->zoned_header.zone_capacity;
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
+    int64_t size = bs->bl.nr_zones * zone_size;
+    unsigned int nrz, si, i = 0;
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
+            zones[i].cap = MIN(zone_capacity, l);
+        } else {
+            zones[i].length = zone_size;
+            zones[i].cap = zone_capacity;
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
+            qemu_co_mutex_lock(&s->lock);
+            zones[i].state = qcow2_get_zone_state(bs, si + i);
+            qemu_co_mutex_unlock(&s->lock);
+        }
+        zones[i].wp = wp;
+    }
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    *nr_zones = i;
+    return 0;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_open_zone(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    qemu_co_mutex_lock(&s->lock);
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
+        qemu_co_mutex_unlock(&s->lock);
+        qemu_co_mutex_unlock(&bs->wps->colock);
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
+    qemu_co_mutex_unlock(&s->lock);
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int qcow2_close_zone(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    qemu_co_mutex_lock(&s->lock);
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
+    qemu_co_mutex_unlock(&s->lock);
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_finish_zone(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+
+    /* Wait for any in-flight writes to this zone to drain. */
+    if (s->zone_wp_state) {
+        while (!QTAILQ_EMPTY(&s->zone_wp_state[index].in_flight)) {
+            qemu_co_queue_wait(&s->zone_wp_state[index].drain,
+                               &bs->wps->colock);
+        }
+    }
+
+    qemu_co_mutex_lock(&s->lock);
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+
+    switch (zs) {
+    case BLK_ZS_EMPTY:
+        if (!qcow2_can_activate_zone(bs)) {
+            ret = -EBUSY;
+            goto unlock_state;
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
+            goto unlock_state;
+        }
+        qcow2_rm_closed_zone(s, index);
+        break;
+    case BLK_ZS_FULL:
+        ret = 0;
+        goto unlock_state;
+    default:
+        ret = -EINVAL;
+        goto unlock_state;
+    }
+
+    qemu_co_mutex_unlock(&s->lock);
+
+    uint64_t old_wp = *wp;
+    *wp = ((uint64_t)index + 1) * s->zoned_header.zone_size;
+    ret = qcow2_rw_wp_at(bs, wp, index, true);
+    if (ret < 0) {
+        /* Keep the in-memory write pointer consistent with the on-disk value. */
+        *wp = old_wp;
+        goto unlock;
+    }
+
+    /*
+     * Flush the WP cache so the on-disk write pointer reflects the new state
+     * on return.
+     */
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_cache_flush(bs, s->wp_cache);
+    qemu_co_mutex_unlock(&s->lock);
+    goto unlock;
+
+unlock_state:
+    qemu_co_mutex_unlock(&s->lock);
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
+                            int64_t len)
+{
+    BDRVQcow2State *s = bs->opaque;
+    unsigned int nrz = bs->bl.nr_zones;
+    int64_t zone_size = bs->bl.zone_size;
+    unsigned int n;
+    int ret = 0;
+    bool any_dirtied = false;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+    if (len == bs->total_sectors << BDRV_SECTOR_BITS) {
+        n = nrz;
+        index = 0;
+        wp = &bs->wps->wp[0];
+    } else {
+        n = len / zone_size;
+    }
+
+    for (unsigned int i = 0; i < n; ++i) {
+        uint64_t *wp_i = (uint64_t *)(wp + i);
+        uint64_t wpi_v = *wp_i;
+        if (QCOW2_ZT_IS_CONV(wpi_v)) {
+            continue;
+        }
+
+        /* Wait for any in-flight writes to this zone to drain. */
+        if (s->zone_wp_state) {
+            while (!QTAILQ_EMPTY(&s->zone_wp_state[index + i].in_flight)) {
+                qemu_co_queue_wait(&s->zone_wp_state[index + i].drain,
+                                   &bs->wps->colock);
+            }
+        }
+
+        qemu_co_mutex_lock(&s->lock);
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
+            qemu_co_mutex_unlock(&s->lock);
+            goto unlock;
+        }
+        qemu_co_mutex_unlock(&s->lock);
+
+        if (zs == BLK_ZS_EMPTY) {
+            continue;
+        }
+
+        /*
+         * Zero the data extent first. Data write fires before the WP cluster
+         * hits disk. So the wp advance cannot become durable while stale data
+         * is still readable.
+         */
+        ret = qcow2_co_pwrite_zeroes(bs, (uint64_t)(index + i) * zone_size,
+                                     zone_size, 0);
+        if (ret < 0) {
+            error_report("Failed to clear zone data at zone %u",
+                         index + i);
+            goto unlock;
+        }
+
+        qemu_co_mutex_lock(&s->lock);
+        qcow2_cache_depends_on_flush(s->wp_cache);
+        qemu_co_mutex_unlock(&s->lock);
+
+        uint64_t old_wp = *wp_i;
+        *wp_i = (uint64_t)(index + i) * zone_size;
+        ret = qcow2_rw_wp_at(bs, wp_i, index + i, true);
+        if (ret < 0) {
+            /* Keep the in-memory write pointer consistent with the on-disk value. */
+            *wp_i = old_wp;
+            goto unlock;
+        }
+        any_dirtied = true;
+    }
+
+    if (any_dirtied) {
+        /* Single flush at the end. */
+        qemu_co_mutex_lock(&s->lock);
+        ret = qcow2_cache_flush(bs, s->wp_cache);
+        qemu_co_mutex_unlock(&s->lock);
+    }
+
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return ret;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
+                   int64_t offset, int64_t len)
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
+        error_report("offset %" PRId64 " is equal to or greater than the "
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
+    /* The length must be zone-aligned and within the device capacity. */
+    if ((len < capacity - offset && (len & zone_size_mask)) ||
+        len > capacity - offset) {
+        error_report("number of sectors %" PRId64 " is not aligned to zone"
+                     " size %" PRId64 "", len / 512, zone_size / 512);
+        return -EINVAL;
+    }
+
+    qemu_co_mutex_lock(&wps->colock);
+    uint64_t wpv = wps->wp[index];
+    qemu_co_mutex_unlock(&wps->colock);
+
+    if (QCOW2_ZT_IS_CONV(wpv)) {
+        /*
+         * ZONE_RESET_ALL is a global operation that is allowed when the
+         * starting zone is conventional; the zone reset path itself skips
+         * conventional zones.
+         */
+        if (op != BLK_ZO_RESET || len != capacity) {
+            error_report("zone mgmt operation 0x%x is not allowed on "
+                         "a conventional zone", op);
+            return -EIO;
+        }
+    }
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
+        error_report("*offset %" PRId64 " is equal to or greater than the "
+                     "device capacity %" PRId64 "", *offset, capacity);
+        return -ENOSPC;
+    }
+
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
@@ -6686,6 +7889,10 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_pwritev_compressed_part    = qcow2_co_pwritev_compressed_part,
     .bdrv_make_empty                    = qcow2_make_empty,
 
+    .bdrv_co_zone_report                = qcow2_co_zone_report,
+    .bdrv_co_zone_mgmt                  = qcow2_co_zone_mgmt,
+    .bdrv_co_zone_append                = qcow2_co_zone_append,
+
     .bdrv_snapshot_create               = qcow2_snapshot_create,
     .bdrv_snapshot_goto                 = qcow2_snapshot_goto,
     .bdrv_snapshot_delete               = qcow2_snapshot_delete,
diff --git a/block/qcow2.h b/block/qcow2.h
index 0defb84d0c..9e7e09f6f8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -298,6 +298,8 @@ typedef struct Qcow2ZoneWPState {
     QTAILQ_HEAD(, Qcow2WPReq) in_flight;
     /* PENDING reqs, sorted by lba */
     QTAILQ_HEAD(, Qcow2WPReq) completed_pending;
+    /* zone mgmt ops wait here until in_flight has drained */
+    CoQueue drain;
 } Qcow2ZoneWPState;
 
 typedef struct Qcow2UnknownHeaderExtension {
diff --git a/block/trace-events b/block/trace-events
index 950c82d4b8..30a3e303ca 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -76,6 +76,8 @@ qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_pwrite_zeroes(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset 0x%" PRIx64 " nb_clusters %d"
+qcow2_wp_tracking(int index, uint64_t wp) "wps[%d]: 0x%" PRIx64
+qcow2_imp_open_zones(uint8_t op, int nrz) "nr_imp_open_zones after op 0x%x: %d"
 
 # qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
-- 
2.53.0


