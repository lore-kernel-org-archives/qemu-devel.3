Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF086C02188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq1U-00023F-Rv; Tue, 14 Jan 2025 18:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1D-00020J-9R
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq19-0004Bp-LB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhl80ZRJ0L6Cz/BkuObye4iJe3Q+DTb7+J4GtiBMHrE=;
 b=CFr6mfTTmnhQsCotihf8NwEVahmB7Ldvbl40lDM6wGccXCT2TCVAWP05N2PtYusAzNU+UP
 zCZMk88/Wrkv5xnO9ky0y3ReFu/68ny4QF2SS/P6j54BYahDZRX9/VRh6SyibMxSh9uu2E
 czhsdi7sUceYcH6xY3VCVltyigMPKec=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-A_sMUyqmON2UeIlqji1sOw-1; Tue, 14 Jan 2025 18:08:13 -0500
X-MC-Unique: A_sMUyqmON2UeIlqji1sOw-1
X-Mimecast-MFC-AGG-ID: A_sMUyqmON2UeIlqji1sOw
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4679aeb21e6so101066591cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896092; x=1737500892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hhl80ZRJ0L6Cz/BkuObye4iJe3Q+DTb7+J4GtiBMHrE=;
 b=bX7h6x2oLyOE5F/O9H8YAHLlChBkuv7SvoXnWp1QwxwGyO2L7awNJsEXYYLAPxeerY
 qfsiEvofI9S98K9bhaR5KZLZpZ15XjCKEyvgyGbC7hbKDveg1cFKE4NlHzMiLP6VUgXi
 tECblsLiPmWvhikE2YgYqPFfpvMR6Zjwi+Q0WRQXMA4IatVeQwzImpwrSGaVi8XgdG1v
 G9og+O9RPu3HDLtH1gx8pVxELGNppPuNbCQcIbIs8gFTC7S9S/Ad2ZyR2A/wpXp6RMRL
 oBN/1AjvyVJBzUyIzGd36y0o12xMJpZaDut8j4UcymfmKeIjJiPZ/6knIPFUTUMZxuNq
 hqLg==
X-Gm-Message-State: AOJu0YwgRZ18v8CqNDSke/EeSHhww/oruopIlyIRzPPtcQe9NiYnj/uI
 39sJc+pGS7HOVNOCxOjPUIFOXJblE2ZX0DnPV6tmdpE3E5cccafIFKfAmNwQdlTEKeV5vlvd8CD
 UowLgpvj/fBaDOLnPekqjAtU1k9VsbkrNuq6gNIyo6ylGpEc6I3c2XuYlDz7bw4qTBkdArykahM
 dmw2tY4iYVMMnoW51Y14U/8R9YeQ6ZjBlFsg==
X-Gm-Gg: ASbGncud4x2CyB/jDsge1N/aL6f88vr+FAcjrn9p6C7BoKtKLKMxwwHHVjMC+MmsdcA
 yTY/SnS36WmHnwu4ShcH761JfTteKx6TKMnu5iQYoSmTDuYCSvZ5vyFNLEE+1Guv/pS/2pGJpi/
 CMsz98NO/jLkesdnBEgQev1mV2OUCwgGpc3088x93PHQiForX6GKCwckFRPmuvA24UlVRetY9LB
 YnZol4XbxHYB5Gc5hWoI0wubCi5/QvhpfmBymjJOVxiMpgPGIhoH20oSdo7okoEp27kgnJwR0vy
 2oBq+bAY6dZj3LkDqrP/lwYmXhFl4KXK
X-Received: by 2002:a05:622a:1342:b0:467:6e45:218d with SMTP id
 d75a77b69052e-46c70fd4538mr435056851cf.3.1736896090730; 
 Tue, 14 Jan 2025 15:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwHJpZGpxw4K2ScjXB4dQY9Z0MRzHAGFy+LqFYRXcSoFOeIYemH54XbXHjLm/XZZ6d3CxFLQ==
X-Received: by 2002:a05:622a:1342:b0:467:6e45:218d with SMTP id
 d75a77b69052e-46c70fd4538mr435056431cf.3.1736896090322; 
 Tue, 14 Jan 2025 15:08:10 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:09 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 12/16] migration: Unwrap qemu_savevm_state_complete_precopy()
 in postcopy
Date: Tue, 14 Jan 2025 18:07:42 -0500
Message-ID: <20250114230746.3268797-13-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Postcopy invokes qemu_savevm_state_complete_precopy() twice for a long
time, and that caused way too much confusions.  Let's clean this up and
make postcopy easier to read.

It's actually fairly straightforward: postcopy starts with saving
non-postcopiable iterables, then later it saves again with non-iterable
only.  Move these two calls out makes everything much easier to follow.
Otherwise it's very unclear what qemu_savevm_state_complete_precopy() did
in either of the calls.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  1 +
 migration/migration.c | 13 +++++++++++--
 migration/savevm.c    |  1 -
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index c48a53e95e..7957460062 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -44,6 +44,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
+int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
diff --git a/migration/migration.c b/migration/migration.c
index 2c5674c2ae..a8fe423a2b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2566,7 +2566,11 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
      */
-    qemu_savevm_state_complete_precopy(ms->to_dst_file, true);
+    ret = qemu_savevm_state_complete_precopy_iterable(ms->to_dst_file, true);
+    if (ret) {
+        error_setg(errp, "Postcopy save non-postcopiable iterables failed");
+        goto fail;
+    }
 
     /*
      * in Finish migrate and with the io-lock held everything should
@@ -2605,7 +2609,12 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    qemu_savevm_state_complete_precopy(fb, false);
+    ret = qemu_savevm_state_complete_precopy_non_iterable(fb, true);
+    if (ret) {
+        error_setg(errp, "Postcopy save non-iterable device states failed");
+        goto fail_closefb;
+    }
+
     if (migrate_postcopy_ram()) {
         qemu_savevm_send_ping(fb, 3);
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 9aef2fa3c9..0ddc4c8eb5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1477,7 +1477,6 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
-static
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
-- 
2.47.0


