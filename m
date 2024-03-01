Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE0C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 02:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfseR-0003y3-FI; Thu, 29 Feb 2024 21:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseQ-0003xk-5j
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:30 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseO-0005PA-K8
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:29 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-68f571be9ddso12293036d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709260167; x=1709864967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxHV8roC2fjNMfvMvdxuHI9CffnQMqXm91qkh+DJCQw=;
 b=UeTX4wiNdcfn8fEk80jfmdJhGNCH2jkbWNAVQld0oEUHscr3ykVSR41go+1A6usqAE
 yXA7mPrz96t/u4AR/VEPI+OAL2rG5e6aHQWRssRd0QHDf2mzHg/fcHwJ/1gb7Oj58Qlv
 3mL0mV9E0viy3eUlCWl0R2p5oSVSkEjRqp9o5FFth/7rFg/ugTThWjzb5Au4I9mJMn12
 y98EAFKTxHnzphGRJVOqfHoLwj/xkE/RQYnv9i7a2I/cG2b6Q2PkiqfRcxTbXxPjG5L5
 Uk2W0yyzorTWrfutPxe28UH7f/Th0AtK1MyWTBmsZqPhAUMBoqgaL7d2Raj28/piRGKP
 K5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709260167; x=1709864967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PxHV8roC2fjNMfvMvdxuHI9CffnQMqXm91qkh+DJCQw=;
 b=ZtsR04A68xl22HXeRNfEN+q9ymOO/z1wyPvu49tOHHtyiCGxDR4W/kLOj27hgcyubv
 gWTaqD352HG3lC4wm7qaSJOr9Ur7FJLR1QUUk7pe6dtsOgOIQNp/MzEhHP8adkXYXQRk
 g5pvDP7zj3Zo2coP6WuQkOWUXswBC0KmNLAoE5O53lJAJbB8/hv7Armpz7KkyU9DJ4Kt
 wln9tEyTujTESOxEDvrP4tJQRz8j24rGzg9Z2+bdve8KHx7MZzpYnsr3Mi31YM2RjmY3
 tx7sn3gYsyH7WXZo+FvGrXfrq2oXPJVJNmb3TmUsXHYvhPFUoA5LngXpcCtTsVz6+Cga
 JmtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfeS9Ck85ZcczGk+nAI3yFVDj9ft8CaxKFvTB0xOLK6KeDQbtCDsHHTy+sHZKLgeH1indkPCw10qE+UuzCKM2TgUVESg4=
X-Gm-Message-State: AOJu0Yy09XusL8zhVUXAuEn9ZuEkOnKK0yCG2gOFiB9PMM2BRCrHzKGl
 7hPqJ7vR3OjO25emmI1VX3jK2PUJILouWDfXGdvCz5bSSL6VBNoqNbUVDti4T3k=
X-Google-Smtp-Source: AGHT+IEsvuwiDHIehYUztD4V9Y3AFzD+uUaCTByOxeGLhLo5VYfEnJbjvXFFqFAYYgVKvUkV2xUmtw==
X-Received: by 2002:a0c:f50c:0:b0:690:50c5:4b72 with SMTP id
 j12-20020a0cf50c000000b0069050c54b72mr468754qvm.52.1709260167598; 
 Thu, 29 Feb 2024 18:29:27 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.120])
 by smtp.gmail.com with ESMTPSA id
 qo13-20020a056214590d00b0068d11cf887bsm1384107qvb.55.2024.02.29.18.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 18:29:27 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v4 3/7] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
Date: Fri,  1 Mar 2024 02:28:25 +0000
Message-Id: <20240301022829.3390548-4-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022829.3390548-1-hao.xiang@bytedance.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf31.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20240226195654.934709-4-hao.xiang@bytedance.com>
---
 migration/ram.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e1fa229acf..f9d6ea65cc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1122,10 +1122,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     QEMUFile *file = pss->pss_channel;
     int len = 0;
 
-    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_NONE) {
-        return 0;
-    }
-
     if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
         return 0;
     }
@@ -2045,7 +2041,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
  */
 static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
 {
-    RAMBlock *block = pss->block;
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
@@ -2061,17 +2056,34 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
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
@@ -2983,7 +2995,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
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


