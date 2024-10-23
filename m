Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB28CFA45D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fgo-0002Lk-DM; Wed, 23 Oct 2024 14:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgi-0002L6-3H
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgf-00040G-Ig
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729706544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffbOb1zLkckP3Rme6JyfNXdz8ft6fnCYj3dIDD3fnGQ=;
 b=BVFI++px5zwMedn1RMmvtJHBGHegzyMygP424DfOs2SL398mmh7ZIYiLDBWY7jCPU7RwEJ
 ou8a7NPEIR0L/MkWBe3gHz6uoMKvkJ8wYNggKd30rVv71xmyjWOfyPXDi+o5luC0rWHSx+
 Sl/mD81LRxoeJPsV6xJ/gnU+3B7++1w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-HM65LBG8M_WVl8TJBID7ww-1; Wed, 23 Oct 2024 14:02:23 -0400
X-MC-Unique: HM65LBG8M_WVl8TJBID7ww-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cc32a0b26bso1497326d6.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729706542; x=1730311342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffbOb1zLkckP3Rme6JyfNXdz8ft6fnCYj3dIDD3fnGQ=;
 b=mzonZRs9R1w+HLy2N/fZ9cO3zP5WCoURWaBwY7/KJ9K8Uy1Jl53lpkRcUAQJ5NrMMz
 Jeqd6SMyV1iWTsGFqgG//XOb82kQ1HxpAbKiizHki/B476EOykaKsAxY+yNoOhI47tjv
 ovzIp9h7QyWrU+N8hkskpU7CEkxBMmeH1txhF18MmsDB0EjIwtDuc3HOiWCQ+cvmUsiB
 OKpHw5qZt27gIehwxnlZmsH2NKLn2jlzOu+yC4g+I6jMstbVHOYB4LF5cBRZisvbN2L3
 LgvbZBmygXTXLU9jQkglpeORKLs0upNvubRiZoyihNXGPR/KlyZrqEXDkfqyEy44yxzw
 GSmA==
X-Gm-Message-State: AOJu0YwIPHQqPf17H264glIP+rZeJ853mFOw8wKkw6917Z/lv6qZcwmj
 cY/sAFMQv5cFCrIqaffLpohf5dd9e/PsbxfEN8j4moSLgPsNQZ4lYhOvjMh30ERXDnHunjEqhba
 hXknk7hzrklp1mbKwiLuiQUe3/ocRfFYlQFRViad08P42fh2Bp6mt+KLi+QLCrxXNhR5G3lmEM2
 o+o+flGAJZBo5QSIERIOSTPPY0aLaZtMen/w==
X-Received: by 2002:a05:6214:390d:b0:6cb:e9a5:acfb with SMTP id
 6a1803df08f44-6ce34259feemr39838446d6.38.1729706541633; 
 Wed, 23 Oct 2024 11:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxKojU9TywE/snPaG/+JCr7UIS85Mv5QmXatQKlX6i1h4/7Doyl2/UvMXhyeOSHY/gkW0b1w==
X-Received: by 2002:a05:6214:390d:b0:6cb:e9a5:acfb with SMTP id
 6a1803df08f44-6ce34259feemr39838076d6.38.1729706541202; 
 Wed, 23 Oct 2024 11:02:21 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009fcd0esm41746716d6.132.2024.10.23.11.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:02:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 2/4] migration: Reset current_migration properly
Date: Wed, 23 Oct 2024 14:02:14 -0400
Message-ID: <20241023180216.1072575-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241023180216.1072575-1-peterx@redhat.com>
References: <20241023180216.1072575-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

current_migration is never reset, even if the migration object is freed
already.  It means anyone references that can trigger UAF and it'll be hard
to debug.

Properly clear the pointer now, so far by doing it in the finalize() (as we
know there's only one instance of it).

Add a TODO entry for it showing that we can do better in the future.

To make it clear, also initialize the variable in the instance_init() so
it's very well paired at least.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bcb735869b..a82297db0f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -232,9 +232,9 @@ static int migration_stop_vm(MigrationState *s, RunState state)
 
 void migration_object_init(void)
 {
-    /* This can only be called once. */
-    assert(!current_migration);
-    current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
+    MIGRATION_OBJ(object_new(TYPE_MIGRATION));
+    /* This should be set when initialize the object */
+    assert(current_migration);
 
     /*
      * Init the migrate incoming object as well no matter whether
@@ -3877,12 +3877,31 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
+
+    /*
+     * We know we only have one intance of migration, and when reaching
+     * here it means migration object is gone.  Clear the global reference
+     * to reflect that.
+     */
+    current_migration = NULL;
 }
 
 static void migration_instance_init(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
+    /*
+     * There can only be one migration object globally. Keep a record of
+     * the pointer in current_migration, which will be reset after the
+     * object finalize().
+     *
+     * TODO: after migration/ code can always take a MigrationObject*
+     * pointer all over the place, logically we can drop current_migration
+     * variable.
+     */
+    assert(!current_migration);
+    current_migration = ms;
+
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-- 
2.45.0


