Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DDEC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqnf-00087Q-UV; Fri, 02 Feb 2024 05:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqne-00086z-IW
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqnd-0001Xc-7v
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzb46DUZSTMJoNeVIqZsw/shF+U8HEgAIFp5xpwtBDY=;
 b=JFm5MIc4iQzffzZWR3d+6997wm3OJ3vDCxoYvg6tQvMrWG/OAGH1eUjA2xm+iYQbFPjIRg
 uA3jSPQ+sUgSOffVHUvSZD+98nNKe6BFDaE8kVrQmjEdCEKv404c9Fz+LKYqmi4P6Uqa+O
 153+OAyYsxCZ+hIUaIN39Pwh0NJzUSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-WzK2ITtNOGKWR79D4gfjtg-1; Fri, 02 Feb 2024 05:29:28 -0500
X-MC-Unique: WzK2ITtNOGKWR79D4gfjtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 717A8185A784;
 Fri,  2 Feb 2024 10:29:28 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A20A240C9444;
 Fri,  2 Feb 2024 10:29:24 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 01/23] migration/multifd: Drop stale comment for multifd
 zero copy
Date: Fri,  2 Feb 2024 18:28:35 +0800
Message-ID: <20240202102857.110210-2-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

We've already done that with multifd_flush_after_each_section, for multifd
in general.  Drop the stale "TODO-like" comment.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 25cbc6dc6b..eee2586770 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -598,17 +598,6 @@ int multifd_send_sync_main(void)
         }
     }
 
-    /*
-     * When using zero-copy, it's necessary to flush the pages before any of
-     * the pages can be sent again, so we'll make sure the new version of the
-     * pages will always arrive _later_ than the old pages.
-     *
-     * Currently we achieve this by flushing the zero-page requested writes
-     * per ram iteration, but in the future we could potentially optimize it
-     * to be less frequent, e.g. only after we finished one whole scanning of
-     * all the dirty bitmaps.
-     */
-
     flush_zero_copy = migrate_zero_copy_send();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
-- 
2.43.0


