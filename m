Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7C3C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh6v-000145-SZ; Mon, 26 Feb 2024 14:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6p-0000zM-Ke
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:55 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6o-0004uH-1V
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:55 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4c78b074fe0so661235e0c.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977473; x=1709582273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kj4WrPMcdHH42vMb8MjOr0OwgYlZTTIRTtBw9DfaH6Y=;
 b=jHVShwJ//PFpnFsa7/dukPCV31olDZI1J3Ca44zY3SJeiP+Z65I61JjzVOkU6YH9ig
 9lizHAPyKnDAtrn4KiHI6I6lphATbr6mKD5rEWmzsk9vQwr2dHtzgqlrfd2wVS3Z1mCo
 zMqp9t9TNoFiswHS2H3AyHPypJEGyqdzlqEARUIbged+ITcK8ldCbEvBE5fwf1Y3gb3o
 K49wOcHnPWP1LmPn1B0xdJuyfIrrVy14HWk4ht1h2pFjEXq26XJfLunlwmIl88S4VuF5
 gz1x9pru91zLStBFPRd+4oxMCpb1gh0Ix+GuzxXJj+UkiYRHJo4SpJzYxJBbutPDgVUB
 Z5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977473; x=1709582273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kj4WrPMcdHH42vMb8MjOr0OwgYlZTTIRTtBw9DfaH6Y=;
 b=W9nD6a4evsEEFStgdTS8BR8WTKmrJvena+WeTR0FXQNjEtpG2O4XwnbB0TIfwPK2i+
 eMQJkqRJswIUc659BLsVzfeUV7rXSGo7WxY3Br7YUXihjAnKGfQTUT3kcCgfog4wCj11
 yilYMIa/ZpWkmJlp84oSorJ4LVZZutGz+xthQpGHpMqtC2CYRwavwNmVYp0JohcYYfeL
 BayiIDXc+IDmBq3GZcJ4OUlu5G5kjZA+Njs/F+tYoCzA/RrsdljtvN6GK4O6n1ukxfNk
 lPm8mJX8jA4/TY/+Nm25966Tk3uuRW7Bb+hzWi7GJBD3lRBVKdT4ixVpxR+NTP72ivAS
 WH7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiRTdjD7h90AShRCYeYn+d6VFyRZolAwKXIh91kXmlORe8TPwaqgrF1LTI5LuFFG4nQPtsopozw8swLg7D/8998ZfOXS4=
X-Gm-Message-State: AOJu0YybzHbqjJRkPKq+plnPuEcTsFaY3bL4HFdkFFAfndyXWtMTB2or
 ascknQKyA7lv/16jekk2huuqSlVokG9CaD9RW8HEsHPrwrrPA2uztbTblV0osmY=
X-Google-Smtp-Source: AGHT+IHs5SZT+dUlpowdSkaj3k9ZtOTzNMnYhg42kJfwVzviTdj/xLLDjYoHfQcQFZ3nfZlQInIvRQ==
X-Received: by 2002:a1f:c706:0:b0:4cd:20ea:35aa with SMTP id
 x6-20020a1fc706000000b004cd20ea35aamr4316988vkf.8.1708977473118; 
 Mon, 26 Feb 2024 11:57:53 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:52 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 3/7] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
Date: Mon, 26 Feb 2024 19:56:50 +0000
Message-Id: <20240226195654.934709-4-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

1. Add a dedicated handler for MigrationOps::ram_save_target_page in
multifd live migration.
2. Refactor ram_save_target_page_legacy so that the legacy and multifd
handlers don't have internal functions calling into each other.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/ram.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 414cd0d753..f60627e11a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     QEMUFile *file = pss->pss_channel;
     int len = 0;
 
-    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_NONE) {
-        return 0;
-    }
-
     if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
         return 0;
     }
@@ -2046,7 +2042,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
  */
 static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
 {
-    RAMBlock *block = pss->block;
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
@@ -2062,17 +2057,34 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
+    return ram_save_page(rs, pss);
+}
+
+/**
+ * ram_save_target_page_multifd: send one target page to multifd workers
+ *
+ * Returns 1 if the page was queued, -1 otherwise.
+ *
+ * @rs: current RAM state
+ * @pss: data about the page we want to send
+ */
+static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
+{
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
+
     /*
-     * Do not use multifd in postcopy as one whole host page should be
-     * placed.  Meanwhile postcopy requires atomic update of pages, so even
-     * if host page size == guest page size the dest guest during run may
-     * still see partially copied pages which is data corruption.
+     * Backward compatibility support. While using multifd live
+     * migration, we still need to handle zero page checking on the
+     * migration main thread.
      */
-    if (migrate_multifd() && !migration_in_postcopy()) {
-        return ram_save_multifd_page(block, offset);
+    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
+        if (save_zero_page(rs, pss, offset)) {
+            return 1;
+        }
     }
 
-    return ram_save_page(rs, pss);
+    return ram_save_multifd_page(block, offset);
 }
 
 /* Should be called before sending a host page */
@@ -2984,7 +2996,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
-    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+
+    if (migrate_multifd()) {
+        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
+    } else {
+        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+    }
 
     bql_unlock();
     ret = multifd_send_sync_main();
-- 
2.30.2


