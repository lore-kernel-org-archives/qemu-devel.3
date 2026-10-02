Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2F5CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCb3K-0001Tv-Sb; Fri, 02 Oct 2026 07:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3I-0001TR-PR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:44 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3H-0008UB-3J
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:44 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso13741105e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790939021; x=1791543821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3NL85gesnrWtNA0x1156/EFbnVpOENQI5jaa40zkUhc=;
 b=V0wt0oKqcSzkVkWOHMMb4RqnZyXTk3yg0uhcTnqJRSv9+ebU9rhdYsYd6iFF9RBI7/
 Q6yj4j6MYsh8wS26PxgvqXVwRJu78Jq4/NSuhLBFJFlEpRWeucntywP/f1kyYmSqnYKk
 S8KNhO38MyADxcE0KxdgFJY/lQFaMhLhhyn3Poj1cegTuGThqPtkyy7a2Gxle4Hs1oW4
 rCPwES6HjrJucs4qlRqna7NYb9cVThL21C2oMOOadRL8SMAfaYeYrVqD2G4Yl4wkCKe3
 bxLaOo12JjgpdqJxO4WI8oSW2OXUk5ec/dHBJeirdTnXXdNi+UHl+m4+3Aq6ZWljVaxS
 5oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939021; x=1791543821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3NL85gesnrWtNA0x1156/EFbnVpOENQI5jaa40zkUhc=;
 b=K3gUAK9l9oYqazTaW2PNSOokWZC0HCdN79iYBRQcCfHA0kj/IA6VMAggC1ZUE89vPh
 1kqhpnwzepkShp9a+NnMil6B5d+PZgAkuY7+/DNMNaJjzhooJBmx9daCQslCqPOGsPPh
 0rrznXUeMqwvIL9dnUMofixjjahCCnUyjC04BuuZISPdxsCtn/Kz8dZRcs+VE7Yxbxq8
 L3Qyqw2WcwQ9o0glGLzwTPufioKbcpTr0Pm3h3TkWKrAkqCAauLoHFop+UsxbtQgVB9B
 smzOpiCjjfMa3DZQbP9GbKAqkrWzcA0ElaLHGoKOlkXNwO/G9EnJGQof+Ot5uCoVf/AK
 kDzA==
X-Gm-Message-State: AFuF++k1lElVNWyw/6kBoy8fz2rBOnk9IgkRdgvqGJCOX156j0wZNh1V
 qAGxT3bd3x3IpBDHg1DDt1FeOuCU/IWHtiyenGLr8BzthcTddrJTcTiva39T+UOqT/e8oL0E+4k
 uz8Z5
X-Gm-Gg: AYBFou2dtNcchGixprUa+aOcBtkjDteZDhYmH8454U8qAoDTbtTtdXbPAzIuHuhNLec
 NiUnegu9qyvLoh1q5CG4+0AEkO3q6kPBaKT3O6CKaFoW7XHiVJxpFrZFM7E/Gja881qTb9Fwcgi
 bRZJ46GYLzX2lQmt905SZn2C41Rg+5UxvAdkJAX1Ha3V4PExdt6FAtwn8qAtDySi4DCFFOFoo+L
 6JW9qRtOJfvZ9UUA+AymFhtxCk3QsVOKIDccktjDjRzFId10wasrpBJLCl9XGa2X8hr2hoA4/gV
 80V+HKVBcWfCus384dwhNWjYadT7F1pvaWIYK68GaCuRr82QpixMbZX+B3zbNYfYG7PGelUpzQy
 funT688mR3WlYJbHWo+Ar6I2Uf6cR3x/sbxVPRDBvtn6kRNWJNvxDDfUWDxMFxiBiTormtAr10T
 umOn6Z/MylRguTjyhTeYQPd1p5DSlFgpTWoRrrKMdm1B0yMSZViK3beQUxelquStv2N9I=
X-Received: by 2002:a05:600c:870f:b0:49f:fc4f:9efb with SMTP id
 5b1f17b1804b1-4a02753fd01mr43234085e9.7.1790939021288; 
 Fri, 02 Oct 2026 04:03:41 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9f21:a362:21c8:d9a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff3cab2sm24533785e9.2.2026.10.02.04.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 04:03:40 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 1/4] migration/postcopy: report COMPLETED only after the run
 BH has run
Date: Fri,  2 Oct 2026 13:02:55 +0200
Message-ID: <20261002110258.1835979-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002110258.1835979-1-den@openvz.org>
References: <20261002110258.1835979-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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

Set an event at the end of the run BH and wait for it in the listen
thread, unless loading failed before CMD_POSTCOPY_RUN and the BH was
never scheduled.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c    | 2 ++
 migration/migration.h    | 2 ++
 migration/postcopy-ram.c | 4 ++++
 migration/savevm.c       | 1 +
 4 files changed, 9 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index fab7949fe1..8944acf3cd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -324,6 +324,7 @@ void migration_object_init(void)
     qemu_mutex_init(&current_incoming->rp_mutex);
     qemu_mutex_init(&current_incoming->postcopy_prio_thread_mutex);
     qemu_event_init(&current_incoming->main_thread_load_event, false);
+    qemu_event_init(&current_incoming->postcopy_run_event, false);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_fast_load, 0);
@@ -493,6 +494,7 @@ void migration_incoming_state_destroy(void)
 
     migration_incoming_transport_cleanup(mis);
     qemu_event_reset(&mis->main_thread_load_event);
+    qemu_event_reset(&mis->postcopy_run_event);
 
     if (mis->page_requested) {
         g_tree_destroy(mis->page_requested);
diff --git a/migration/migration.h b/migration/migration.h
index 683bc7bdd5..c65212ff63 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -108,6 +108,8 @@ struct MigrationIncomingState {
      * loading state.
      */
     QemuEvent main_thread_load_event;
+    /* Set once the postcopy run BH has changed the run state */
+    QemuEvent postcopy_run_event;
 
     /* For network announces */
     AnnounceTimer  announce_timer;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5509cbdcb8..fd2c139cfe 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2443,6 +2443,10 @@ static void *postcopy_listen_thread(void *opaque)
      * state yet; wait for the end of the main thread.
      */
     qemu_event_wait(&mis->main_thread_load_event);
+    /* The VM run state is changed later, in loadvm_postcopy_handle_run_bh() */
+    if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING) {
+        qemu_event_wait(&mis->postcopy_run_event);
+    }
 
     /*
      * Device load in the main thread has finished, we should be in
diff --git a/migration/savevm.c b/migration/savevm.c
index 4b590ea672..5ec09d4889 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2263,6 +2263,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     }
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
+    qemu_event_set(&mis->postcopy_run_event);
 }
 
 /* After all discards we can start running and asking for pages */

base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
-- 
2.53.0


