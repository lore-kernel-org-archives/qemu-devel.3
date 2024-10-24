Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA00D10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QJ-0005et-Nz; Thu, 24 Oct 2024 17:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QD-0005dK-7v
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45Q8-0005X4-Ab
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQuiqCDFP7O6dGnJw0uzIfXFNnqGc/QZrj0NrKoRZoA=;
 b=dapSrsSveM0iMTkcX1KDAJQut2OaUhp5eJXyNMjgLIALxraleysE03Rk1rNdV6rMzWiV/1
 +jhEUj+wLBVC+3X99gXGDAvsBLxvQHPdIMTY3SSMY6DaSrUMNIXEnNxafhWu2Ci/DH3sV4
 f4UoIjEvGQHycrNLR1TPonpnbC+8jQ4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-i2T0jw7OPSqRnFb0-FQumA-1; Thu, 24 Oct 2024 17:31:01 -0400
X-MC-Unique: i2T0jw7OPSqRnFb0-FQumA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-460afc4747bso26777841cf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805461; x=1730410261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQuiqCDFP7O6dGnJw0uzIfXFNnqGc/QZrj0NrKoRZoA=;
 b=KsCCkVVM8Q5HwBAwVS3EHPiKf9i6oeFOxTc2/flXkHwdfnBFE14pIN4FbB5oOFfyiY
 DyEmvKksMOfZkKHoalsQahFGSqFtVGnVCgTLCVNsCPLQ17agG8Rg/MNNL5NJDd/QyzE/
 wKrjnw8JH7DVD2LBDVyLh6hgxhMr2lVUf3ZafXuc/zE/gtsggGmnkFbCNemLNgwQG4nP
 7UWoDtLmIhygVTlmlaC8dUt1DzzITiV3a+VkRg48QeWo4yP4/X7YpTcGF60lRDL8qPvy
 sjJcpznZz4BwPi6EIg5bJCoIzKTrlSS5nOo+aGZbUqgjVCsy5x0Y73qLPWtGQuEk3LMs
 5/kA==
X-Gm-Message-State: AOJu0Yw2MU/Oc3bUeLJq+sXvwUqeHCPPhVWKYblGTSshJaMuo7u9WQii
 BpqP4m64OXrPHfTYAFQFWKXa1KV+31LFFuKaWWN/00aVpHKIRyd4Mip3YLZyTuRrH2T3F0AXzIz
 ehhhOC6og+8QWOFzcZJ0zStYYts/O4PZBQfOQrQ5TAAvva9dX6A+NeayoI/JCeGe+KIE+dk1G7j
 4wB7hy4NFc98yFQ0qBWVMVpeQ9ghllSGDXMA==
X-Received: by 2002:a05:622a:1992:b0:460:a82a:39c9 with SMTP id
 d75a77b69052e-4612525f1d1mr52367221cf.10.1729805460731; 
 Thu, 24 Oct 2024 14:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs0Kkco9NPHLR6DyTeQgaXjiAae4BYQ7N0k1m99KfGVb8p8HZ/bVQIkjtE0mJV4IjUFEz3vQ==
X-Received: by 2002:a05:622a:1992:b0:460:a82a:39c9 with SMTP id
 d75a77b69052e-4612525f1d1mr52366921cf.10.1729805460308; 
 Thu, 24 Oct 2024 14:31:00 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:30:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 1/8] migration: Take migration object refcount earlier for
 threads
Date: Thu, 24 Oct 2024 17:30:49 -0400
Message-ID: <20241024213056.1395400-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Both migration thread or background snapshot thread will take a refcount of
the migration object at the entrace of the thread function.

That makes sense, because it protects the object from being freed by the
main thread in migration_shutdown() later, but it might still race with it
if the thread is scheduled too late.  Consider the case right after
pthread_create() happened, VM shuts down with the object released, but
right after that the migration thread finally got created, referencing
MigrationState* in the opaque pointer which is already freed.

The only 100% safe way to make sure it won't get freed is taking the
refcount right before the thread is created, meanwhile when BQL is held.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 74812ca785..e82ffa8cf3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3491,7 +3491,6 @@ static void *migration_thread(void *opaque)
 
     rcu_register_thread();
 
-    object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
     if (!multifd_send_setup()) {
@@ -3629,7 +3628,6 @@ static void *bg_migration_thread(void *opaque)
     int ret;
 
     rcu_register_thread();
-    object_ref(OBJECT(s));
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
@@ -3841,6 +3839,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         }
     }
 
+    /*
+     * Take a refcount to make sure the migration object won't get freed by
+     * the main thread already in migration_shutdown().
+     *
+     * The refcount will be released at the end of the thread function.
+     */
+    object_ref(OBJECT(s));
+
     if (migrate_background_snapshot()) {
         qemu_thread_create(&s->thread, MIGRATION_THREAD_SNAPSHOT,
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
-- 
2.45.0


