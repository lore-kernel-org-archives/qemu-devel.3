Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09E3C3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 16:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sproY-0003RO-I5; Sun, 15 Sep 2024 12:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproU-0003GW-3T
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sproS-0006Qb-4V
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 12:09:25 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71911585911so3163231b3a.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726416563; x=1727021363;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVIR2VPmJg+nV5CN3iMpYvvRb8M20NpY1SeasAo60A4=;
 b=qM8BaXk/UPmxJgjEbO8U3Dsgq4Nf28QoLhJeXVoQA7rpO+Kr3uPEnWAjdg2zjkVay0
 MI+hfFqD9AvtM1zfX74hFJv8IB4bAveyHGWiPwP6pHN5it7H8CqpthaG9+i0U3iyvVeZ
 byNEriJnZnMfLdpwUraKofvF0XpKWKXQjrEX9Uv2IHnubE2mgYailSB4DBtME/X/hZ20
 L1TDZWF2bgevp+iEaJ2/5OENNNHkQwUW8Tyipszh+wENSv+TzTuEYZpYGi54RUhXliZN
 xTmgB8qU+GN21UPVY/Gk5snMZl63DQz22s4lt5Dt/haP4V/7uLYa2e+fyhhkRrAY6XAs
 qPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726416563; x=1727021363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVIR2VPmJg+nV5CN3iMpYvvRb8M20NpY1SeasAo60A4=;
 b=n0NFN2owjCiiXnlouSTSQFw9chxCWnAcmo2PfVFotKXP+8Fdjb9M5vJy46S2Y63kI6
 uTaoI4AGFWDNvWRhYrrc03fg5loZsz53qf7QJAxCvzJpM9CnTZXUmfzmtbyDfSVfSC6d
 lJcHFpjycMLDxdN13bo4yK81ZonEUXjMXY7ZR+XsgkU+aqpoh1NfG0JkjIVzEWfNIxL5
 kRKYXUDz1rKYyLxcqfAD8uKSx8pKaN65bw1g6/WDn+t9u3zAqpUdl2xLyb3hkJzggJRA
 x1lS7XGN4JPhmBYD9YhldM1Cc2HlZmn561MrlzRBJR0TGYibbMSZPMdRvKglkSis5U1D
 cnmA==
X-Gm-Message-State: AOJu0YyANjiLSoiQqZfrjkfTx6anQokqvwJkz4kLtl13PeHT/G6z2RmX
 PqJTr3ZIP6puvHkkP0Uy4A9aZc16Kvx7/Uh8KZPsULQJjqArTSTuCD41A8j/R1sWBhl6ZbA48Rm
 tDn5Sug==
X-Google-Smtp-Source: AGHT+IFPlUPgQuwPek7A1EJ4jngrk8mlPeLbu5d7tnWvK2ySCdXGUF//La4NB6x5h1nSpvKCfUHnFQ==
X-Received: by 2002:a05:6a21:168d:b0:1ce:f77a:67bf with SMTP id
 adf61e73a8af0-1cf764c577cmr17969925637.49.1726416561953; 
 Sun, 15 Sep 2024 09:09:21 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.247])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bb5967sm2344795b3a.182.2024.09.15.09.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 09:09:21 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 7/7] migration: Support responsive CPU throttle
Date: Mon, 16 Sep 2024 00:08:50 +0800
Message-Id: <495340ef44d5d6865553503324d4717ebf98dd28.1726390099.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1726390098.git.yong.huang@smartx.com>
References: <cover.1726390098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Currently, the convergence algorithm determines that the migration
cannot converge according to the following principle:
The dirty pages generated in current iteration exceed a specific
percentage (throttle-trigger-threshold, 50 by default) of the number
of transmissions. Let's refer to this criteria as the "dirty rate".
If this criteria is met more than or equal to twice
(dirty_rate_high_cnt >= 2), the throttle percentage increased.

In most cases, above implementation is appropriate. However, for a
VM with high memory overload, each iteration is time-consuming.
The VM's computing performance may be throttled at a high percentage
and last for a long time due to the repeated confirmation behavior.
Which may be intolerable for some computationally sensitive software
in the VM.

As the comment mentioned in the migration_trigger_throttle function,
in order to avoid erroneous detection, the original algorithm confirms
the criteria repeatedly. Put differently, the criteria does not need
to be validated again once the detection is more reliable.

In the refinement, in order to make the detection more accurate, we
introduce another criteria, called the "dirty ratio" to determine
the migration convergence. The "dirty ratio" is the ratio of
bytes_xfer_period and bytes_dirty_period. When the algorithm
repeatedly detects that the "dirty ratio" of current sync is lower
than the previous, the algorithm determines that the migration cannot
converge. For the "dirty rate" and "dirty ratio", if one of the two
criteria is met, the penalty percentage would be increased. This
makes CPU throttle more responsively and therefor saves the time of
the entire iteration and therefore reduces the time of VM performance
degradation.

In conclusion, this refinement significantly reduces the processing
time required for the throttle percentage step to its maximum while
the VM is under a high memory load.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/ram.c              | 55 ++++++++++++++++++++++++++++++++++--
 migration/trace-events       |  1 +
 tests/qtest/migration-test.c |  1 +
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 799eaa0382..8d856a89db 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -421,6 +421,12 @@ struct RAMState {
     bool background_sync_running;
     QemuThread background_sync_thread;
     QemuSemaphore quit_sem;
+
+    /*
+     * Ratio of bytes_dirty_period and bytes_xfer_period in the
+     * previous sync.
+     */
+    uint64_t dirty_ratio_pct;
 };
 typedef struct RAMState RAMState;
 
@@ -1049,6 +1055,43 @@ static void migration_dirty_limit_guest(void)
     trace_migration_dirty_limit_guest(quota_dirtyrate);
 }
 
+static bool migration_dirty_ratio_high(RAMState *rs)
+{
+    static int dirty_ratio_high_cnt;
+    uint64_t threshold = migrate_throttle_trigger_threshold();
+    uint64_t bytes_xfer_period =
+        migration_transferred_bytes() - rs->bytes_xfer_prev;
+    uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
+    bool dirty_ratio_high = false;
+    uint64_t prev, curr;
+
+    /* Calculate the dirty ratio percentage */
+    curr = 100 * (bytes_dirty_period * 1.0 / bytes_xfer_period);
+
+    prev = rs->dirty_ratio_pct;
+    rs->dirty_ratio_pct = curr;
+
+    if (prev == 0) {
+        return false;
+    }
+
+    /*
+     * If current dirty ratio is greater than previouse, determine
+     * that the migration do not converge.
+     */
+    if (curr > threshold && curr >= prev) {
+        trace_migration_dirty_ratio_high(curr, prev);
+        dirty_ratio_high_cnt++;
+    }
+
+    if (dirty_ratio_high_cnt >= 2) {
+        dirty_ratio_high = true;
+        dirty_ratio_high_cnt = 0;
+    }
+
+    return dirty_ratio_high;
+}
+
 static void migration_trigger_throttle(RAMState *rs)
 {
     uint64_t threshold = migrate_throttle_trigger_threshold();
@@ -1056,6 +1099,11 @@ static void migration_trigger_throttle(RAMState *rs)
         migration_transferred_bytes() - rs->bytes_xfer_prev;
     uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
     uint64_t bytes_dirty_threshold = bytes_xfer_period * threshold / 100;
+    bool dirty_ratio_high = false;
+
+    if (migrate_responsive_throttle() && (bytes_xfer_period != 0)) {
+        dirty_ratio_high = migration_dirty_ratio_high(rs);
+    }
 
     /*
      * The following detection logic can be refined later. For now:
@@ -1065,8 +1113,11 @@ static void migration_trigger_throttle(RAMState *rs)
      * twice, start or increase throttling.
      */
     if ((bytes_dirty_period > bytes_dirty_threshold) &&
-        (++rs->dirty_rate_high_cnt >= 2)) {
-        rs->dirty_rate_high_cnt = 0;
+        ((++rs->dirty_rate_high_cnt >= 2) || dirty_ratio_high)) {
+
+        rs->dirty_rate_high_cnt =
+            rs->dirty_rate_high_cnt >= 2 ? 0 : rs->dirty_rate_high_cnt;
+
         if (migrate_auto_converge()) {
             trace_migration_throttle();
             mig_throttle_guest_down(bytes_dirty_period,
diff --git a/migration/trace-events b/migration/trace-events
index 4f95f9fe14..0b219516e9 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -98,6 +98,7 @@ migration_background_sync_watcher_end(void) ""
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
+migration_dirty_ratio_high(uint64_t cur, uint64_t prev) "current ratio: %" PRIu64 " previous ratio: %" PRIu64
 migration_throttle(void) ""
 migration_dirty_limit_guest(int64_t dirtyrate) "guest dirty page rate limit %" PRIi64 " MB/s"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e0e94d26be..9f7c2f49a0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2815,6 +2815,7 @@ static void test_migrate_auto_converge(void)
     migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
     migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
     migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+    migrate_set_parameter_bool(from, "cpu-responsive-throttle", true);
 
     /*
      * Set the initial parameters so that the migration could not converge
-- 
2.39.1


