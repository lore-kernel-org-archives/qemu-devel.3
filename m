Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60784ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfLd-0002v8-I3; Mon, 09 Sep 2024 10:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLX-0002WM-OX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:30 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLU-0004VM-Qq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:27 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4f9e39c55so2978037a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891983; x=1726496783;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ff6vB6OP2BGQkLDtZ3odfZR0Boq6VYV5mOBp8pXlipM=;
 b=be+qagHu7OVLEHaZXtQnsKueqNXuDwiXYeeMtudS+fjIrPDMDlnJS10pu48QrQeEbz
 sHhbVEEfcWeqqaC90tzMDCJqDfL9agC+KpZJCmxXkqxZ/NMSYoN4XExN/o8D3teA7IRi
 5bf6EgUjM1JeytaP8Xr7V8A9WzmHt4eBEH3jxfoEE0D/DcAYcU+rG6fzyVYHJIaT6yim
 Pgk4H6vQioE94qh0veVotpYkFvfVm/Gkw++ofZieeeqHda30xMJVGzN2lPFHbLnluzOs
 JvE7gu2ckFvG91TXG6HVaNDkyA/VauzHWhU4+Ku/xaUFcjSaMy8nrGBSdB2F39E8T4MJ
 ZBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891983; x=1726496783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ff6vB6OP2BGQkLDtZ3odfZR0Boq6VYV5mOBp8pXlipM=;
 b=TUcz3eQzmqnlah9Q63M4aCQ2xNvjGXh70XSdjTJUEYEaGfUDBxEKChCCzv4xJnbMGG
 PzFq7CmYH6ygGCeWdz2EZNAHQQvd37Gfqp0uiD5tC5mEn4lao2UlGVGAMJ5w52JrGq6j
 wGPN7ukFhrgagiH5MfhmQhUNysa/k0I+olmjBsfroxk1oi9rY/H8d8+eZAcJFBXYUW21
 WrrnZaGP5Ad0flbBk5ATmy46M3O6WFl0Ln/z0unJ6FfExxYH4GGvPZFSFHwDpWXCz03F
 HUAzIV+GEs5qr0fugN7lWWhE8TakPHTUa9SRaCcS4ZTjNBypKap+9DM3JPrhMwY1L8ek
 5hkA==
X-Gm-Message-State: AOJu0YwdyS/74h1BRm+3ZFGGtz9M+Y17RZ4IWezqn5LyHkR6dD8+pJwj
 nGgqG0v4ofgPTY7D+Q6c4VGO+h8Dfg9t9/amzYTAAYOEXaS1kD9krNx8+Mxuh5Jwe3UUOsvBMdd
 IHT+sug==
X-Google-Smtp-Source: AGHT+IFUEAEMRMllagyUged6Cbye+ISYX0WPfudWCviq7kjrNAtmZxH0Q2qwq4zuAQT/XFu/gGhHYg==
X-Received: by 2002:a05:6a20:d81a:b0:1cf:4596:d486 with SMTP id
 adf61e73a8af0-1cf4596d610mr1976199637.47.1725891982579; 
 Mon, 09 Sep 2024 07:26:22 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:26:22 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 09/10] migration: Support responsive CPU throttle
Date: Mon,  9 Sep 2024 22:25:42 +0800
Message-Id: <da17fbf2fb52c44c70620d50c16cbd9f81545c87.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x532.google.com
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
index d9d8ed0fda..5fba572f3e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -420,6 +420,12 @@ struct RAMState {
     /* Periodic throttle information */
     bool throttle_running;
     QemuThread throttle_thread;
+
+    /*
+     * Ratio of bytes_dirty_period and bytes_xfer_period in the previous
+     * sync.
+     */
+    uint64_t dirty_ratio_pct;
 };
 typedef struct RAMState RAMState;
 
@@ -1044,6 +1050,43 @@ static void migration_dirty_limit_guest(void)
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
@@ -1051,6 +1094,11 @@ static void migration_trigger_throttle(RAMState *rs)
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
@@ -1060,8 +1108,11 @@ static void migration_trigger_throttle(RAMState *rs)
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
index 5b9db57c8f..241bbfcee9 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -95,6 +95,7 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
+migration_dirty_ratio_high(uint64_t cur, uint64_t prev) "current ratio: %" PRIu64 " previous ratio: %" PRIu64
 migration_periodic_throttle(void) ""
 migration_periodic_throttle_start(void) ""
 migration_periodic_throttle_stop(void) ""
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 61d7182f88..4626301435 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2812,6 +2812,7 @@ static void test_migrate_auto_converge_args(AutoConvergeArgs *input_args)
     migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
     migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
     migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+    migrate_set_parameter_bool(from, "cpu-responsive-throttle", true);
 
     if (periodic) {
         migrate_set_parameter_bool(from, "cpu-periodic-throttle", true);
-- 
2.39.1


