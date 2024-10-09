Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F48CEDD89
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW2I-000530-Vl; Wed, 09 Oct 2024 08:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW21-0004sf-EK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1y-0005Vu-Mh
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufhUOpepsGW4qLY30+zYqQtKIYZv17OEXI7XMvauCAU=;
 b=Xpt0lAzE64vOpO6vYI9hRMnsHd0iIjXAA4OE8RPdf+7qiAnFQmDtj0a9T6yU1IJ6XgP5kf
 hQtS4CHncuatrc3YdKFzLCDy1+/XVfD0ln/06cZoadC0BqXHsTQAs/U4/q/caMQClu/iBc
 c8lX1UXUR9w//AdLYBzbRiV2m8NtGgg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-u5byBmSxN-Ow4g2Wsg2qHg-1; Wed, 09 Oct 2024 08:43:04 -0400
X-MC-Unique: u5byBmSxN-Ow4g2Wsg2qHg-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-82aa8af04feso684811939f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477783; x=1729082583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufhUOpepsGW4qLY30+zYqQtKIYZv17OEXI7XMvauCAU=;
 b=BqzmABID9934gg5juxlKmfy+IeucOJ39IS+9eZodfcGPzrcZ8AedGDbUz3mfVE3xg4
 w6hC0x6KV6PbEHkcCZSvjoXLoSnq8UQkIXrYR6DnBzr9W4Dd944+J9+147JVQQ/ahABt
 L54agPwzfcAO9kONIBfovm3yE08mFkYkzamjB872p+lqSYlOh+IFQHrATdoeYJS648Ic
 OnExLB0+TOe1jz/kMxDlSsTgYSpEArty1qCrN+D5S8+nprhYamA6PLMfv+r7l9towU5k
 RvU/noOgcg2lJZr3OxseU1aueM+sA0MoZBwQE7nHmW3IcoUnVYKlHE9S/vq4cHqs9+b8
 bZrg==
X-Gm-Message-State: AOJu0Yz3WifO4mlDoYqENTvoVWBXZYeFc4HF6XxQmxMwBojq2Lk9MUUm
 VM8g1+2i0EuGbqt/n4T9mvjTglhuzDDxHd6aE4ZHGzm82p+FxgeDqNtKHxg+uz66YwWiftySCLp
 ryTCk2X6j5gcnbTmdJYdcWI6XwRjxwcDDwyXkuW2nVLrl80T9LWPktic6uLECSAzQ0AyiWcndap
 qz02RW1ZBScK69I/gDFJj6h76F2uMexEJcwg==
X-Received: by 2002:a05:6602:6101:b0:82a:4c58:e1e0 with SMTP id
 ca18e2360f4ac-8353d4f11d4mr249867439f.12.1728477782840; 
 Wed, 09 Oct 2024 05:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn5VvcapvqGxQ50KmhJFVnEWT/3/GQA3GxrhLud8Pl+7z+b3QnS8vH1AFWBM5F2i3qzn2l2g==
X-Received: by 2002:a05:6602:6101:b0:82a:4c58:e1e0 with SMTP id
 ca18e2360f4ac-8353d4f11d4mr249862639f.12.1728477782174; 
 Wed, 09 Oct 2024 05:43:02 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:43:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 11/12] util/iova-tree: Remove deadcode
Date: Wed,  9 Oct 2024 08:42:37 -0400
Message-ID: <20241009124238.371084-12-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

iova_tree_find_address, and iova_tree_foreach have never been
used since the code was originally added by:
  eecf5eedbd ("util: implement simple iova tree")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20240918142515.153074-1-dave@treblig.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/iova-tree.h | 25 -------------------------
 util/iova-tree.c         | 23 -----------------------
 2 files changed, 48 deletions(-)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 2a10a7052e..44a45931d5 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -111,31 +111,6 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
  */
 const DMAMap *iova_tree_find_iova(const IOVATree *tree, const DMAMap *map);
 
-/**
- * iova_tree_find_address:
- *
- * @tree: the iova tree to search from
- * @iova: the iova address to find
- *
- * Similar to iova_tree_find(), but it tries to find mapping with
- * range iova=iova & size=0.
- *
- * Return: same as iova_tree_find().
- */
-const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova);
-
-/**
- * iova_tree_foreach:
- *
- * @tree: the iova tree to iterate on
- * @iterator: the iterator for the mappings, return true to stop
- *
- * Iterate over the iova tree.
- *
- * Return: 1 if found any overlap, 0 if not, <0 if error.
- */
-void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator);
-
 /**
  * iova_tree_alloc_map:
  *
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 536789797e..06295e2755 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -115,13 +115,6 @@ const DMAMap *iova_tree_find_iova(const IOVATree *tree, const DMAMap *map)
     return args.result;
 }
 
-const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova)
-{
-    const DMAMap map = { .iova = iova, .size = 0 };
-
-    return iova_tree_find(tree, &map);
-}
-
 static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
 {
     /* Key and value are sharing the same range data */
@@ -148,22 +141,6 @@ int iova_tree_insert(IOVATree *tree, const DMAMap *map)
     return IOVA_OK;
 }
 
-static gboolean iova_tree_traverse(gpointer key, gpointer value,
-                                gpointer data)
-{
-    iova_tree_iterator iterator = data;
-    DMAMap *map = key;
-
-    g_assert(key == value);
-
-    return iterator(map);
-}
-
-void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator)
-{
-    g_tree_foreach(tree->tree, iova_tree_traverse, iterator);
-}
-
 void iova_tree_remove(IOVATree *tree, DMAMap map)
 {
     const DMAMap *overlap;
-- 
2.45.0


