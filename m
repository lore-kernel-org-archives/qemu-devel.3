Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534BFC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRs-0000A2-6W; Tue, 20 May 2025 13:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRp-000056-KF
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRn-00019F-V0
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ArTcPfynfAjB7vrW9cw5ePgpA4S+h7XZwLMfRpl8hTg=;
 b=FCADfa9k8v68WM5uiO69LFB1TQbUEgOzTP2EvsNvPokltQHD42UDyyuLO6Cea/xamg6fR7
 kBYhyV3tiFGsDosFr8RGvYfG386Uz7VhwcAYmrfJCdGuNvPBxl7ehRYq4LBuZB73dU0kuR
 +tnNpGYvnBupJ9aQUFLiajMLJeFKi/o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-w6UeSLp_NZWr9ykf54oXjw-1; Tue, 20 May 2025 13:08:08 -0400
X-MC-Unique: w6UeSLp_NZWr9ykf54oXjw-1
X-Mimecast-MFC-AGG-ID: w6UeSLp_NZWr9ykf54oXjw_1747760888
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c5f3b8b1a1so964843185a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760887; x=1748365687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArTcPfynfAjB7vrW9cw5ePgpA4S+h7XZwLMfRpl8hTg=;
 b=tfCPUmxt/AMM1rA9ptpgHrYS3qrODNXee99ayp8law/+sX7cETQCexCu5lcw2Xmtkh
 z2a87+6x1e3G4LAis+0x8dQtc1UhbxfCHwk2t8hTS46spB0v1Qm4HLx+1fvlW3qV4qYc
 39iKXjl9orhT0iTAWqp8WZvGYN9rVteuyz4vkGxg8VXxSBUCXg9pOy7tk1lI+Q/PfYRJ
 vyqOBdx2pWkCPhbP8NnqAtbfymA1Ci0XTLJgza8br8q4Cuf4QioZLd8yBkJTDZ0J8ujx
 wAXWuac9I9c3AXC2rvMjhnp6h0Z06IpX3OmVNOezBE0fIDX23y/CvWl9FVGTIgwNJOV/
 PXPQ==
X-Gm-Message-State: AOJu0YxBP2zcFvJfjOiPTPy8NCG4d3y+SRvA7ZRk+6twLDX4HvUnfnFE
 UIW1moz8AF7MtCtr5M8INjptEuHqMoxIt88Z6WgGU8lqYxJYVOqXvLBDG5ZebiwkVQbctsd8pyQ
 GhOr6OUl85Kot0l7ogvsbhHkuZvV0JY+p1ARhJmVKGUWTBUUBT0SFsNZt1AdUHEfvlO1NEWHhzU
 5Tcf48F/+4W9a/r345+t5IcN0zgLdy+hnahYgw4Q==
X-Gm-Gg: ASbGnctXEgwTTSzBkmKDiBrgVrhVQpHc58ZwngZpi3vIVN5Be+f08EFZ49qWIMwfymA
 1Z9x9ki+VLbtvoCj8YksHyeA7ln6lD0Kmi+wALDYsetEGE4tArA1LX2RErn7ekcd8izsVyyn51a
 pHJv7OGhqGVWcbuq+HrWvPjK/bPOoh+HgvVWrH09aCmuzzBbkXVPn/FwaQNisrxv4CyTGWXzxHp
 PqXMqALGupZQqVq9daZ9rAtiXWJMs+ZqEPmpok/IFPHgxTv0sf/oofx38tfUdGg7Uv2Fzb9h01T
X-Received: by 2002:a05:620a:29d1:b0:7cc:ffaf:60a5 with SMTP id
 af79cd13be357-7cd46718b5bmr2289434185a.3.1747760887224; 
 Tue, 20 May 2025 10:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJHx9IKg71n1PTl3Wpw2I+skrld75ToKulHk++mMPOAqopLxllM0SWD9Z3KIz7ph4ynLuK9A==
X-Received: by 2002:a05:620a:29d1:b0:7cc:ffaf:60a5 with SMTP id
 af79cd13be357-7cd46718b5bmr2289427985a.3.1747760886587; 
 Tue, 20 May 2025 10:08:06 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:08:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 08/12] migration: enable multifd and postcopy together
Date: Tue, 20 May 2025 13:07:47 -0400
Message-ID: <20250520170751.786787-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Enable Multifd and Postcopy migration together.
The migration_ioc_process_incoming() routine checks
magic value sent on each channel and helps to properly
setup multifd and postcopy channels.

The Precopy and Multifd threads work during the initial
guest RAM transfer. When migration moves to the Postcopy
phase, the multifd threads cease to send data on multifd
channels and Postcopy threads on the destination
request/pull data from the source side.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/r/20250512125124.147064-3-ppandit@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-nocomp.c | 3 ++-
 migration/multifd.c        | 7 +++++++
 migration/options.c        | 5 -----
 migration/ram.c            | 5 ++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 88fe0f99f2..b48eae3d86 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -17,6 +17,7 @@
 #include "migration-stats.h"
 #include "multifd.h"
 #include "options.h"
+#include "migration.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -398,7 +399,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
     MultiFDSyncReq req;
     int ret;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || migration_in_postcopy()) {
         return 0;
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index ec108af624..f18b166bcf 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1379,6 +1379,13 @@ static void *multifd_recv_thread(void *opaque)
         }
 
         if (has_data) {
+            /*
+             * multifd thread should not be active and receive data
+             * when migration is in the Postcopy phase. Two threads
+             * writing the same memory area could easily corrupt
+             * the guest state.
+             */
+            assert(!migration_in_postcopy());
             if (is_device_state) {
                 assert(use_packets);
                 ret = multifd_device_state_recv(p, &local_err);
diff --git a/migration/options.c b/migration/options.c
index b6ae95358d..3fcd577cd7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -509,11 +509,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not compatible with ignore-shared");
             return false;
         }
-
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp, "Postcopy is not yet compatible with multifd");
-            return false;
-        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
diff --git a/migration/ram.c b/migration/ram.c
index e12913b43e..d26dbd37c4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1993,9 +1993,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
         }
     }
 
-    if (migrate_multifd()) {
-        RAMBlock *block = pss->block;
-        return ram_save_multifd_page(block, offset);
+    if (migrate_multifd() && !migration_in_postcopy()) {
+        return ram_save_multifd_page(pss->block, offset);
     }
 
     return ram_save_page(rs, pss);
-- 
2.49.0


