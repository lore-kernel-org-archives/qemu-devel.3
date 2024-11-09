Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB41CD5C0C7
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 05:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9dZn-0006O8-5l; Fri, 08 Nov 2024 23:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9dZm-0006Ny-Hb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 23:59:58 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9dZk-0000ff-Um
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 23:59:58 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso3030168b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 20:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731128395; x=1731733195;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gZ+IPpDpfPOMn4j4HmQOIMp3Etb7MIoneItHhCKeWk=;
 b=Vupv9Iis3qaZo7dkpZdQnmvS5IbskqA3l8d4q42EayJj3aCmtlpbzXV9B3/AGRQSIy
 5d/KQAdXc/8UoEorkyBWfQaBljM63vbgDZNKsXaWP1O17Xy4zhJroKA7msXnRzn6/Cpq
 8r67I/Ivk61N1d6A+Nmodmdyr0hAgSKI+r/o2WlpfCCc3HbP+DHLCs1ZUCg/dMz+7ewx
 SPhhICLEX4wfi7TmSCICloQo+5x3XbSQW3Gwir7PVFENEevlbpR/kufJAKvVArs1vDuG
 u5sfDS6bEYwvk3iqlh31Nwd/t5q5L5AU5DtQ4GMP0//mxHgoPUJf/8CyjzWnGr1BqSti
 KSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731128395; x=1731733195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gZ+IPpDpfPOMn4j4HmQOIMp3Etb7MIoneItHhCKeWk=;
 b=Q4i+RqpTUnF0PltIbR4JHs19M8wiIte0UaVf3DlBaW3qOASnJRS/RYY5WV0LkrAyQQ
 aBNKix+C5PHqv1Xvd9ONAnRCXckcglCa8LLXpyMfS2HMcbQD0AYmsxlFHuTvLqYy043r
 6liXuktLmoIBYp601wbaxShVkTY+Axth0bkplKexTNRTqu74wPxaB1QVXGZV3T8N7YRM
 BZ5V61/MGVvnK7zpGDyfiVRFomgsG3YPeoMTIOHV9GXKUssLevdYLY0kW3zftR5j8tfF
 9U6Q016q50ded6lDT9ZAYAOrAWFkL7GS7WOYio5SM+SNegANzyikbX7d3O5nTr2fG/EX
 c8EQ==
X-Gm-Message-State: AOJu0YylW4+xHBHE11cuv/d9anu1Tmv/tmGOQdUyxOY6QzVIU2tODxZN
 vBZ62kGjK4kXWN+LfV3hTWXdM6P4wqpHJzVS1/94u2Ku/uHBuDvRYjz686vaUgc8V/A3lheRP7G
 p6PRTqw==
X-Google-Smtp-Source: AGHT+IEYRMb8PSniLyEY2Zm2c9vYRGR0BcNWSXnvN8o37e612lhZkpx5cn+khrUzc8vMT0QM4DoneQ==
X-Received: by 2002:a05:6a21:8cca:b0:1db:df7b:471a with SMTP id
 adf61e73a8af0-1dc22b9162amr7666446637.43.1731128394606; 
 Fri, 08 Nov 2024 20:59:54 -0800 (PST)
Received: from localhost.localdomain ([118.114.63.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9ac8sm4718365b3a.79.2024.11.08.20.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 20:59:54 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Wei Wang <wei.w.wang@intel.com>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync during
 the first iteration
Date: Sat,  9 Nov 2024 12:59:42 +0800
Message-Id: <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1731128180.git.yong.huang@smartx.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x432.google.com
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

The first iteration's RAMBlock dirty sync can be omitted because QEMU
always initializes the RAMBlock's bmap to all 1s by default.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/cpu-throttle.c |  2 +-
 migration/ram.c          | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index 5179019e33..674dc2004e 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
      * effect on guest performance, therefore omit it to avoid
      * paying extra for the sync penalty.
      */
-    if (sync_cnt <= 1) {
+    if (!sync_cnt) {
         goto end;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..571dba10b7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
 {
     MigrationState *ms = migrate_get_current();
     RAMBlock *block;
-    unsigned long pages;
+    unsigned long pages, clear_bmap_pages;
     uint8_t shift;
 
     /* Skip setting bitmap if there is no RAM */
@@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
 
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages = block->max_length >> TARGET_PAGE_BITS;
+            clear_bmap_pages = clear_bmap_size(pages, shift);
             /*
              * The initial dirty bitmap for migration must be set with all
              * ones to make sure we'll migrate every guest RAM page to
@@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
                 block->file_bmap = bitmap_new(pages);
             }
             block->clear_bmap_shift = shift;
-            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
+            block->clear_bmap = bitmap_new(clear_bmap_pages);
+            /*
+             * Set clear_bmap to 1 unconditionally, as we always set bmap
+             * to all 1s by default.
+             */
+            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
         }
     }
 }
@@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
             if (!ret) {
                 goto out_unlock;
             }
-            migration_bitmap_sync_precopy(false);
         }
     }
 out_unlock:
-- 
2.39.1


