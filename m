Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67A3606A334
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=XTuu5zJ+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqed-0005NI-KA; Tue, 10 Nov 2026 13:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqea-0005L5-E2
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqeW-0003Mc-Aa
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so16017495e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794335582; x=1794940382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPzcitYLzdgLdpiyw0A2TaajXXBAe50hLVDnRF1w7+E=;
 b=XTuu5zJ+Cv2Cv+dhkw1ZHgsJpKYCdugPMgPshDLpCt4NMZhMqGz5T3kstRjizbRzba
 guTlyZWlCQzfhZId4misoODcRHqCHTtfYzaD6sgb5B7lrKf+92kH/HBZpcblMFU254VP
 dCYbupTsyCgQBoLpjmDnZhSW7lPvEwsraR7sNUO81RcSSsG9JXnYmPpRLDm0MOI/n5ne
 HHsEJSi6nS+LFl7vVdVrK+PmQiNW9EpA8377qb7fkemA1cRzO/9EBuO9jCF8BnGm0kP0
 +riIiZ+ND3WPjDVFxg5CmzpIFU+ai1vqa/qRv0sn5NVf/JEREmLvZtUHGyNLcKFrs0mW
 JgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335582; x=1794940382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPzcitYLzdgLdpiyw0A2TaajXXBAe50hLVDnRF1w7+E=;
 b=bUIcjdJhaLm6PcEZeB+iFHQUxp+ZCVVKICOL988/5vJVVlzBZviCZLhfHnbjiRxms6
 X4XNaYTG4A6NF8bwuRtkb/7Dw4XYC2qeWGPB2BCFdAMFUQVqKn7JucAAyqG8p1dZCvAr
 lvAf1srnaSs6JKhnLNlycKw6YSJ7NDNYnE1Z52Secx3cDTg6eIp6FdbD3ner5+Yg0vqJ
 dCqeSDGiR5TbU9kmOd5cGxSbhfkqhHHD05ot5TEwA2fl+1JW8vsGAwIlkcQzPoTG72VU
 3JSJVAtklZl3IKYBtY31F2o89t7QXUOvpKidiBLAyPNVxW0+Bqv74fg+dcr8H4VVS4lP
 hecQ==
X-Gm-Message-State: APuU4Z8m5jQqD31KJA1OfwvQXD/DfR/5/V1+i2td/TTkvM+sU3dG5Oj6
 3M3nJYMtJ7omCNacDZtZJrx1iG5bZPtEyg1HRvF6ewxrfqQbWWD0bjvuUX6yyuf+6yTzHBsAQpR
 EINtO
X-Gm-Gg: AYBFou2ckoWhGPyAsRmXvnptYVzlxQkspv8C1Kw36BTtn0RFCnFSM+610xQRAOtuK3d
 IHTdoAH3OqZUgPKW2p7k85M6VvyWYTbp9ykHm1bX//L/OVF0ssYyf7UWebB+nPHQIyXc7XC9RqQ
 6VQqsaOryBLI6WTKtHEopLzbIJCQm1N+ElsOcCZgEPd5wnCZp3xPF5MXIlZwhBNir6c/dbP9Jh6
 fYki7AXqORjEWMtKoFu4ROPOD2d1qkiwY3KQAXjqq6gxDAQnzYs8UjPUaqtYTPnoP3hU6b7r9eO
 AKvkoiju0WrOB2/OuOYMmIa/EbEZkn9W8wzBjzWAMAMCArK0VL1dEA+qd7kTde/cNHHzjLvemda
 l6Th3PK+f4aEYlK+cRuUhBXtZTox4Ysdav1zxsUmIwBv9W/ZGNwjAVX5CmrGVs8v2C6nmrpDKTq
 olpDx+AnAiuYIpX8ssPno/YjHwUrlDJ0uP174X8DpCF/Y5i+ILrROaH8wrAqpIKyFMM+fI2wnbP
 Am8Fc1waZIEsgepWQISP4eBezoBusxi4X4aD0ryqMRKgRlNQQrGVkxKaeq7qQSHopxApmujp9N3
 Tv+WiQaLBN5muh34QMIm9MMwWQ==
X-Received: by 2002:a05:600c:b8d:b0:4ba:761:97a1 with SMTP id
 5b1f17b1804b1-4ba076197d0mr38103975e9.14.1794335582257; 
 Tue, 10 Nov 2026 10:33:02 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f78:6441:d0f1:22af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm6384827f8f.37.2026.11.10.10.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:33:01 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 1/5] migration/postcopy: report COMPLETED only after the
 run BH has run
Date: Tue, 10 Nov 2026 19:32:53 +0100
Message-ID: <20261110183257.2930908-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110183257.2930908-1-den@openvz.org>
References: <20261110183257.2930908-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

The postcopy listen thread waits for main_thread_load_event before it
reports COMPLETED. That event is set as soon as qemu_loadvm_state_main()
returns in the main thread, while the run state is changed later, in
loadvm_postcopy_handle_run_bh(). The listen thread can therefore report
COMPLETED while the VM is still in RUN_STATE_INMIGRATE, easily so in a
bitmap-only postcopy where it has little to load.

Management reacting to COMPLETED then finds the VM still incoming: a
blockdev-add creates an inactive node, since bds_tree_init() forces
BDRV_O_INACTIVE in RUN_STATE_INMIGRATE, and attaching a device to it
fails with "Block node is read-only". Precopy gets this right:
process_incoming_migration_bh() changes the run state before it reports
COMPLETED.

Once CMD_POSTCOPY_RUN has scheduled the run BH, set the event at the
end of the BH instead. qemu_loadvm_state() keeps setting it in every
other case, including a load that failed before CMD_POSTCOPY_RUN. The
postcopy state it checks only becomes RUNNING on the main thread, right
before the BH is scheduled.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.h | 2 +-
 migration/savevm.c    | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 057c85d611..b223480d28 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -127,7 +127,7 @@ struct MigrationIncomingState {
     QemuEvent  thread_sync_event;
     /*
      * Free at the start of the main state load, set as the main thread finishes
-     * loading state.
+     * loading state, or in postcopy once the run BH has changed the run state.
      */
     QemuEvent main_thread_load_event;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index fe94ba96e4..7d0276c1d7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2263,6 +2263,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     }
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
+    qemu_event_set(&mis->main_thread_load_event);
 }
 
 /* After all discards we can start running and asking for pages */
@@ -3148,7 +3149,10 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis, errp);
-    qemu_event_set(&mis->main_thread_load_event);
+    /* Otherwise loadvm_postcopy_handle_run_bh() sets it */
+    if (postcopy_state_get() != POSTCOPY_INCOMING_RUNNING) {
+        qemu_event_set(&mis->main_thread_load_event);
+    }
 
     trace_qemu_loadvm_state_post_main(ret);
 

base-commit: 723622bedb0b423de7d1c61ebbe6e7a71934949c
prerequisite-patch-id: 67b7337e86202ef7509fc53ff8915a814a477e3b
-- 
2.53.0


