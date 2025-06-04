Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CEDC5B559
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmuk-0004BO-NQ; Wed, 04 Jun 2025 08:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmuB-0003zw-HG; Wed, 04 Jun 2025 08:07:40 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmtz-0002Cd-Gm; Wed, 04 Jun 2025 08:07:39 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E3DD943A19;
 Wed,  4 Jun 2025 14:07:22 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it
Subject: [PATCH 1/4] block/graph-lock: fix typo in comment
Date: Wed,  4 Jun 2025 14:07:14 +0200
Message-Id: <20250604120717.458445-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604120717.458445-1-f.ebner@proxmox.com>
References: <20250604120717.458445-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 include/block/graph-lock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index 2c26c72108..67c8d04867 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -169,7 +169,7 @@ bdrv_graph_rdunlock_main_loop(void);
 /*
  * assert_bdrv_graph_readable:
  * Make sure that the reader is either the main loop,
- * or there is at least a reader helding the rdlock.
+ * or there is at least a reader holding the rdlock.
  * In this way an incoming writer is aware of the read and waits.
  */
 void GRAPH_RDLOCK assert_bdrv_graph_readable(void);
-- 
2.39.5



