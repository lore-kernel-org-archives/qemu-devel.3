Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C76CAC5AB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 21:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqgAk-0007IY-Tj; Tue, 17 Sep 2024 17:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAN-0006fY-Is
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAL-0004tM-FR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726610120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcORaTdOlKE0GN8MprplNyrFUTHIsXM5RvJ3/UsElD0=;
 b=RJ1/ngjZXZ1wJVODyMX5Zw7MNGXulcodxURkiYhmSGDF+n2Bk7Nv61p3U9SN8cxbs8ceHx
 x2dorwbf+rg1SCq7GSuysHOs53nYP2P+GVB0JieaI4qAunO7bL5IWE0fgecnozw8Yb/e0C
 jaRuSIUUr5dcs5jZ6VBCL4qxMInKvNk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-pp78o2xXOryk1hE9RQDRgg-1; Tue, 17 Sep 2024 17:55:19 -0400
X-MC-Unique: pp78o2xXOryk1hE9RQDRgg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9b1216a68so1073850985a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 14:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726610118; x=1727214918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcORaTdOlKE0GN8MprplNyrFUTHIsXM5RvJ3/UsElD0=;
 b=kBb+3RxyaDmetkz+/M/y66fCcogOYbyDqOSgaDXmMJM02435plFscA4OCuIjC07S85
 ghkkE0qGJpfIkX4vBjsY8T5gYCiZ6Vz6iwpBz1hJG680UNmQxew/VFiKabBo0n0o1qoj
 9eKZmt26a52tzFyrk8pakd1SqPSuNFPycTCqO2lXqVjCxVNEUILpV5OmUZQFCy9fuOjB
 bQQDKJbUW9DQuVQRfMESDsfEgZNcB3ltUZpdDlxUV4ktSqlPOeshqGjnKsyTWueDQ9zW
 gYxubc5wk2dU/nCiaSmDmFzDN8KMwqyyU5UG7veIOK4NYbv9o3N8uJwmmJVrGgr/wnSQ
 NiVA==
X-Gm-Message-State: AOJu0Yz8fP+iHGIrDsKpRJPLWk75jHNXnt6bLgLL6aZVzUJXqwTCyDMb
 hiv5KlmNg8hLbuPRNJMKEGJfYjBz+bEMMz6Ru2YkBuNASJuhT9upFtLLrS652E/bXSUNtIyEayK
 WF8FW1ltM43l1pVrhazzJKcRiuUotNmmK/8fPLLUhpZyy5iCqoamyv6M+aZ/FkMRsH8FivF/G7x
 0zN/PLbYX1n18HNWPZlyfTQ5kICWNZzWAPWQ==
X-Received: by 2002:a05:620a:45a7:b0:7a7:f809:9f3f with SMTP id
 af79cd13be357-7ab30d23c19mr2789422885a.16.1726610118129; 
 Tue, 17 Sep 2024 14:55:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXT7SfkigeDr7r75fSppWtZICdCAaiIqlf7VVOzgRzBR5mdtYSMY2cM7u3bj9TawRLeCf4bA==
X-Received: by 2002:a05:620a:45a7:b0:7a7:f809:9f3f with SMTP id
 af79cd13be357-7ab30d23c19mr2789419185a.16.1726610117699; 
 Tue, 17 Sep 2024 14:55:17 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e97c9fasm402869685a.28.2024.09.17.14.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 14:55:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-stable@nongnu.org
Subject: [PULL 6/6] migration/multifd: Fix rb->receivedmap cleanup race
Date: Tue, 17 Sep 2024 17:55:06 -0400
Message-ID: <20240917215506.472181-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917215506.472181-1-peterx@redhat.com>
References: <20240917215506.472181-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Fix a segmentation fault in multifd when rb->receivedmap is cleared
too early.

After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
multiple page faults"), multifd started using the rb->receivedmap
bitmap, which belongs to ram.c and is initialized and *freed* from the
ram SaveVMHandlers.

Multifd threads are live until migration_incoming_state_destroy(),
which is called after qemu_loadvm_state_cleanup(), leading to a crash
when accessing rb->receivedmap.

process_incoming_migration_co()        ...
  qemu_loadvm_state()                  multifd_nocomp_recv()
    qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
      rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
  ...
  migration_incoming_state_destroy()
    multifd_recv_cleanup()
      multifd_recv_terminate_threads(NULL)

Move the loadvm cleanup into migration_incoming_state_destroy(), after
multifd_recv_cleanup() to ensure multifd threads have already exited
when rb->receivedmap is cleared.

Adjust the postcopy listen thread comment to indicate that we still
want to skip the cpu synchronization.

CC: qemu-stable@nongnu.org
Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240917185802.15619-3-farosas@suse.de
[peterx: added comment in migration_incoming_state_destroy()]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 +++++
 migration/savevm.c    | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3dea06d577..ae2be31557 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -378,6 +378,11 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     multifd_recv_cleanup();
+    /*
+     * RAM state cleanup needs to happen after multifd cleanup, because
+     * multifd threads can use some of its states (receivedmap).
+     */
+    qemu_loadvm_state_cleanup();
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
diff --git a/migration/savevm.c b/migration/savevm.c
index d0759694fd..7e1e27182a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2979,7 +2979,10 @@ int qemu_loadvm_state(QEMUFile *f)
     trace_qemu_loadvm_state_post_main(ret);
 
     if (mis->have_listen_thread) {
-        /* Listen thread still going, can't clean up yet */
+        /*
+         * Postcopy listen thread still going, don't synchronize the
+         * cpus yet.
+         */
         return ret;
     }
 
@@ -3022,7 +3025,6 @@ int qemu_loadvm_state(QEMUFile *f)
         }
     }
 
-    qemu_loadvm_state_cleanup();
     cpu_synchronize_all_post_init();
 
     return ret;
-- 
2.45.0


