Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860C606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=eHRMsDAl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqeh-0005Q2-Sg; Tue, 10 Nov 2026 13:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqed-0005NL-Nx
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:12 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqea-0003N9-9U
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:11 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso1298653f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794335586; x=1794940386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXXVM2yp1eVWA7kGXw2w9aDX2Sr2hnb8YxrJCeVkjsc=;
 b=eHRMsDAlOX3ISnKzeL/uk0aNGE+EZSIxKJBLtBMKj+4NvCtQ4/IysgmRsNDcGZk76O
 wVIhVxXkxAIh+4kcr9+5rKebCnufMoDQrYpNWaIxKaTcKOfwlPJoarfj+icDcDtrUffl
 FfBYt+4bwUi4TJI8zVOIsOi0a/31k+g046sWu9274Qn/iQnq3WcpRWNfwJN1Qctcaup4
 itWiJVpcsPaeBmSxYS/p7siZJ6/gLOa/lOofmoyvceBNp/W+aUc4aJMeFGs7ceICWZ27
 25iXtqUQ06SqPfwIYrF5EVRlbtlVjqMlxoDaIhIRHwcHKPeX4w5O6Rqr28WsyyPKsX4S
 Vc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335586; x=1794940386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AXXVM2yp1eVWA7kGXw2w9aDX2Sr2hnb8YxrJCeVkjsc=;
 b=pMKxi9qNm+h1RHJ7GT3mkaAgmmU4KN1VtE4XypZFbPc3Wi88ONqjxUa5Bf7+5r9lCT
 TgmCauXgyjPmjpk69IQQBbmVowSck5s1SPWae/kscbEj7c9HSOXtBIJWjKlajGWj7zI9
 Zy9eIuytoriCylTihM+G1I34KJEJC3swQQdt1S/Qs92SKV2k49ZtnHA9mto3MTtyo7fB
 pLTW6Z0bSUlVbcIUwKWv+5QJXxXhTZrjOZMbEZX8fiEr1hyzAlt9f45wx4RPo00Tf2Ft
 wNVUPojWv7DBUoG5gjH3h8gER43CZMzgn6Bn0OkZotUl2pIr01WkqYONd2eL+kiuVZUd
 xzcw==
X-Gm-Message-State: APuU4Z/Ohb1IdNJSrXVBh15OZgkqGJrdYYrxkwWXRIpbkYDTz5twicUL
 ufzD8FGOreo3V8iU3ijIJE0V35RonscEF5F4AZ8bG23nvj3CEtcRabbEh+M7/EAsyB04fFdK7UP
 gPAxL
X-Gm-Gg: AYBFou0U1j/PEdAVBbDewr9gw1q+9oqRF0Y9fHbIt2f75sUrezf36GU1Lwt6mIRPS3h
 n5nhoKKxX6+02HqQbHZ95ou+0g4nmy64Wq7RyDY/quDmWRnkWolTWC8F1aTneFM4ORKePHXEwkV
 rQ7sj/qPC49hKFocBnqS8wc2qZpaBLuIu/VbdRL8n+8P1KpaVMr3w5O+m6jRqentMSj1CR/BoUQ
 cI09pVAsMDXtfjruDO9GfrDGjEHvVSeotLaQfBzDnPRYvrH2UZ8NoqOKctrr0uXfQnr426iFjSo
 b8E2e3mBP3L0gw1rYSx8MkWKXUxr2XMUziu6msXc3Fr+oh0M7t4OXssn8ASDNmwMpQ+E4dn2tcg
 w+HydZaaHaYFlylASbTNXEazSmbKXGr4AjN3e2PBVnNaHd0AvBbgO3YwYE8TuXFV4IIiIq6Wtw8
 356CNuezvCCSu8UFvaVp1Ska1gCCgSD/CV3WYbR+TWUNKAwPmbrrhW8QNTgZtVXGEYxQhss/IjA
 ila1FTbIxKp78sBuM0+QnzDv2viykwIOX/19qF+hT29kKx5ZCn6TNQIkSv6TwKqOt5tcSMi34kq
 7eoHOGGtnxoHInprJSA7JROFXg==
X-Received: by 2002:a05:6000:2305:b0:48f:bcdf:6f68 with SMTP id
 ffacd0b85a97d-498303f104amr7405303f8f.37.1794335586549; 
 Tue, 10 Nov 2026 10:33:06 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f78:6441:d0f1:22af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm6384827f8f.37.2026.11.10.10.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:33:05 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 4/5] migration/postcopy: answer the package-loaded ping
 from the run BH
Date: Tue, 10 Nov 2026 19:32:56 +0100
Message-ID: <20261110183257.2930908-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110183257.2930908-1-den@openvz.org>
References: <20261110183257.2930908-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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

Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") keeps
the source in POSTCOPY_DEVICE until the destination answers the
QEMU_VM_PING_PACKAGED_LOADED ping packaged right before
CMD_POSTCOPY_RUN. The destination answers it from the generic
MIG_CMD_PING handler as soon as it reads it, so the source's
postcopy-active means the device state is loaded, not that the
destination has left RUN_STATE_INMIGRATE. Management acting on the
destination once the source reports postcopy-active can still race
with loadvm_postcopy_handle_run_bh().

Answering early also leaves the source unrecoverable when the
destination dies in the run BH, for example while synchronizing the CPU
state: by then the source has moved to POSTCOPY_ACTIVE and can no
longer fail the migration and resume the VM itself.

Record the ping in the MIG_CMD_PING handler instead of answering it,
and send the pong at the end of the run BH, after the run state change.

The wire format is unchanged: the pong only arrives later, and an
older destination keeps answering at once. The cost is that the source
stays in POSTCOPY_DEVICE for the duration of the run BH, including
block layer activation when the destination autostarts.

An autostarting destination that dies between vm_start() and the pong
now leaves the source in POSTCOPY_DEVICE, so the source resumes after
the guest has briefly run on the destination. The pong cannot go out
before vm_start(), which is where the run state changes. With -S, as
libvirt starts the destination, the run BH does not start the VM.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Tested-by: Juraj Marcin <jmarcin@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 1 +
 migration/migration.h | 2 ++
 migration/savevm.c    | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 5686209ab1..138cc307cb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -514,6 +514,7 @@ void migration_incoming_state_destroy(void)
     }
 
     qemu_event_reset(&mis->main_thread_load_event);
+    mis->postcopy_package_loaded_ping = false;
 
     if (mis->page_requested) {
         g_tree_destroy(mis->page_requested);
diff --git a/migration/migration.h b/migration/migration.h
index b223480d28..4adec429e9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -130,6 +130,8 @@ struct MigrationIncomingState {
      * loading state, or in postcopy once the run BH has changed the run state.
      */
     QemuEvent main_thread_load_event;
+    /* QEMU_VM_PING_PACKAGED_LOADED received, answered by the run BH */
+    bool postcopy_package_loaded_ping;
 
     /* For network announces */
     AnnounceTimer  announce_timer;
diff --git a/migration/savevm.c b/migration/savevm.c
index 600db7a1ab..c1aa3d054d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2269,6 +2269,10 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
                           MIGRATION_STATUS_POSTCOPY_ACTIVE);
     }
+    if (mis->postcopy_package_loaded_ping) {
+        mis->postcopy_package_loaded_ping = false;
+        migrate_send_rp_pong(mis, QEMU_VM_PING_PACKAGED_LOADED);
+    }
     qemu_event_set(&mis->main_thread_load_event);
 }
 
@@ -2620,6 +2624,10 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
                        tmp32);
             return -1;
         }
+        if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
+            mis->postcopy_package_loaded_ping = true;
+            return 0;
+        }
         migrate_send_rp_pong(mis, tmp32);
         return 0;
 
-- 
2.53.0


