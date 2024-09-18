Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5186ECDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzTL-0002El-2K; Wed, 18 Sep 2024 14:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTG-000219-O3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTE-000210-OU
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726684328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcORaTdOlKE0GN8MprplNyrFUTHIsXM5RvJ3/UsElD0=;
 b=fVC5PCWMc7js8wj6Qhfpf7xCRSuNVotVrdJCd+fCl8/CXgagkLRiydnGU3c9l2G0B0VYQV
 gBUQb+W4PZkaqfCFY+zKHWH4VR7rRYkjijy7+uHeEudk64fHmRi/d1bN+Vukd4fPj+SBgH
 sP2ERPkfCDaLVO6buv+hjcFTaM35R2g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-SbdMavxVNFWNVKZRe1qzUQ-1; Wed, 18 Sep 2024 14:32:06 -0400
X-MC-Unique: SbdMavxVNFWNVKZRe1qzUQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c3702d3ecfso146035236d6.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726684326; x=1727289126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcORaTdOlKE0GN8MprplNyrFUTHIsXM5RvJ3/UsElD0=;
 b=no2rMXAP7Tmz9M1sSJe0ytiLLbA7HEpe+a0l6EsJ/2m+DahDZAGoymdWCRnRIBL0hT
 aOX3ju9dZrgRG6rGZoj0gME4goYyxFlKo/vAJPIe5V2M1MBQNyqmW4bJkSQMEo7KeGQn
 ltr39HonlDF4M/loqAx6xyMKPZfar5Tby0aAA8GsjvN4t64pd5lkkEzV4Mpg9MALUbD2
 Jf3q7Tzi8FK18/3oTdefAnjSaUcd1lx93pD2utgfqubv9LlyAaVgIvkZDeuBnRNRCslF
 TegTnNyvIgHVQNykGn1gTT2IJctRs3GDIk915Gi/+vGC5cEljlp4Vs8R6wv2qqVyGBck
 PqKQ==
X-Gm-Message-State: AOJu0YxSDNJxNpDzK7P+CabtgxpF/VudCUX3INrcjwR8YyyprXWUP6aM
 4IxipK3p7zblelCzi8EkvjGJT9joG6ITIhIm9ZzClMXJH2o69PA9iGTJJ+ttijUF6ioMKr5l8U0
 BrKbEAZdkHU+ShUIH3g0QKNm1sZWZGrOzN649wFVnfrhrk6zonH4wXWrvqHVj8WDaoRaxE5tX3/
 CDPn0Hyy7ecbv1Q1rofRVd61BHTFTPeN2QnA==
X-Received: by 2002:a05:6214:45a1:b0:6c3:5d09:cf8a with SMTP id
 6a1803df08f44-6c5735685cemr388022686d6.26.1726684325727; 
 Wed, 18 Sep 2024 11:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXFYWKFgiIiQNDUCgj/GfFeJlifIaFPAalwWfksM3aEif90jC2SVvLMS0Lz9rbi/QuHgkd1Q==
X-Received: by 2002:a05:6214:45a1:b0:6c3:5d09:cf8a with SMTP id
 6a1803df08f44-6c5735685cemr388022266d6.26.1726684325316; 
 Wed, 18 Sep 2024 11:32:05 -0700 (PDT)
Received: from x1n.. (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494a28sm30486d6.68.2024.09.18.11.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:32:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, qemu-stable@nongnu.org
Subject: [PULL v2 6/6] migration/multifd: Fix rb->receivedmap cleanup race
Date: Wed, 18 Sep 2024 14:31:51 -0400
Message-ID: <20240918183151.6413-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240918183151.6413-1-peterx@redhat.com>
References: <20240918183151.6413-1-peterx@redhat.com>
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


