Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB96CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNG0-0006tQ-Ly; Wed, 27 Aug 2025 17:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFh-0006kE-4n
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFd-0006s6-5m
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0rL3mXXfqHBhyeJ127a2ssZ77MbnTaaoR6sQ91RNEU=;
 b=CA+vNVi4QFuH4BEvr/MmzEvOZlmuOhPZqVeCnrTrF/eSkMtr/biHz+MoAB3ZN9Xs6FTViW
 967a5hyySpdkYX2LON9pNarGMx2wpImLCQzH86M3NfJgBobF8MIeknkVVUn5TozvxHKKxQ
 B2mMqGqhgJXBu3JyAHxjn6mhGKuk12I=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-FOWu-MbGPKmTpdOJDxDmIw-1; Wed, 27 Aug 2025 17:00:06 -0400
X-MC-Unique: FOWu-MbGPKmTpdOJDxDmIw-1
X-Mimecast-MFC-AGG-ID: FOWu-MbGPKmTpdOJDxDmIw_1756328406
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e96d57eb1d0so242233276.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328406; x=1756933206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0rL3mXXfqHBhyeJ127a2ssZ77MbnTaaoR6sQ91RNEU=;
 b=sH1R1y7xGr2xgvXd6Tx70rzhZSp9xNPa49zFTbAcXkfQo7zXxXUC7lzeH9chFTaBMr
 7Xvm7NnPDCrfuj/PCeBQDy012sbSU0aa8FKC77cii22fYj7wrsgjLWE0CgUTFt25f2fM
 k6LsAEaQyNjdImC59innHIYV6Cd5xKF0mDhhu3NlZiGWzsqNuQ0xX6HPS6Xdg01s5CYY
 EXWtOG1FxFS5rnpVBKake+NQ8PeAq9WFiSfB5Nfeejio7sqbxEO9//qDTXOA8+WL3xNd
 z5ZNPYjS5dSxNP3i1AOntAlvj0s03Y/8o6Mr/UFrOELIp1PiKCp0Yz7bfCA40WsScCoo
 CCOw==
X-Gm-Message-State: AOJu0Yw4HDHgqj/+dhk+jqZh4MJ37icwafR5BbYLpTmqDmyK1TPtdRcD
 /HSpIbmV8XTfUmA/ioY6sHKBoBf8+3sdV1nFHBoF+RnYGq5PRxnKJWtvv7ZTfdFVhXK5fWUsQ6O
 HKgBifBiIqxkwVclU9We2CRH6uOB14BOa0P+OyuAeY/KmRKjJmFk/Vn/Jw01W9RzVk8+qjqqOvP
 IGdaS3ki+u1r0oeBAfns4WvNIKNqk+owbhkVADMg==
X-Gm-Gg: ASbGncuJO8K9g9CsstLlvZYntvZploNXrUFuSOcu/pVlxXMy81qNOT4yVRqDHhqyvUZ
 7zqoLcjZFce4Sr7dx4G0qDm448Lp1FfGtPrTo5tFcZ1gdHILJ6xyClyUX8vhwYZXBcE1lHbbgBg
 3FkQqAez4/8SYzgbVte9Ywlvck3K9VyNEWjhiS6Xk2V8bcip/NYhrx29YAZhz6CYAzj5CXbg8ub
 xnPZndg8Z64mOymkPrfcc4BlAHDnnNupc0UKig4s7/UtEnng7LBb4ws5RIrlXIo7sdsfRxQbTO5
 jfU6FvCMdhr4kB7jATu9JKD6UVXe/h39SC9LOXy/N4SjgYlL9ezwpSLtkjf5M36Xyrt2jUSHETT
 YZYwZXBRdIbd2++atUt0=
X-Received: by 2002:a05:6902:1145:b0:e95:3636:fec7 with SMTP id
 3f1490d57ef6-e953637041bmr14363086276.3.1756328405695; 
 Wed, 27 Aug 2025 14:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpI/rLDdMeIg/XupM0lqAJf/9rUSqM2ymCzFKJaxl/Wt2t7IMda1Z5qm8Qk4hX+9j5vihTlw==
X-Received: by 2002:a05:6902:1145:b0:e95:3636:fec7 with SMTP id
 3f1490d57ef6-e953637041bmr14363024276.3.1756328405060; 
 Wed, 27 Aug 2025 14:00:05 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.14.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 14:00:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 7/9] migration/postcopy: Remove workaround on wait preempt
 channel
Date: Wed, 27 Aug 2025 16:59:46 -0400
Message-ID: <20250827205949.364606-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit 7afbdada7effbc2b97281bfbce0c6df351a3cf88.

Now after switching to a thread in loadvm process, the main thread should
be able to accept() even if loading the package could cause a page fault in
userfaultfd path.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ad606c5425..8018f7ad31 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2425,27 +2425,6 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
 
     QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
 
-    /*
-     * Before loading the guest states, ensure that the preempt channel has
-     * been ready to use, as some of the states (e.g. via virtio_load) might
-     * trigger page faults that will be handled through the preempt channel.
-     * So yield to the main thread in the case that the channel create event
-     * hasn't been dispatched.
-     *
-     * TODO: if we can move migration loadvm out of main thread, then we
-     * won't block main thread from polling the accept() fds.  We can drop
-     * this as a whole when that is done.
-     */
-    do {
-        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
-            mis->postcopy_qemufile_dst) {
-            break;
-        }
-
-        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
-        qemu_coroutine_yield();
-    } while (1);
-
     ret = qemu_loadvm_state_main(packf, mis, bql_held);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
-- 
2.50.1


