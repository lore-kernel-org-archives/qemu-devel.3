Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCD7C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq16-0001xL-5l; Tue, 14 Jan 2025 18:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq13-0001uQ-Vc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq11-00044M-Di
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlVGpZyH3jEvqbeBG9TEbCRFPM+u3fzxUZ2wn3/Cceo=;
 b=K/QqjsruTe+AvbY1cHvDjyZd1o5sVFhkkj+c96Y7M2f+xIJLwqoaihWs9SRUNh/IekKyTP
 BYfnT5A9W0je0KuoNvCPSp22mg2ZbNZNFx0dKZ5Sro85OB8tVf6NTGfoJrXgJIeCU8ySC3
 iLtygO6/85NB4QBVBPozY8fvdkdNqcE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-lmpIoBDvNxyJWRhB8T2kIQ-1; Tue, 14 Jan 2025 18:08:03 -0500
X-MC-Unique: lmpIoBDvNxyJWRhB8T2kIQ-1
X-Mimecast-MFC-AGG-ID: lmpIoBDvNxyJWRhB8T2kIQ
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46dd301a429so63825991cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896082; x=1737500882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlVGpZyH3jEvqbeBG9TEbCRFPM+u3fzxUZ2wn3/Cceo=;
 b=Av3kDX6WC6azM649bmWk1hBWjpYVNzazxAzWtEnyLZ9wDvYGaW021869PBu566OAk7
 Kf6Km+h4iAR0SA3LLZ0/wZBTi/hv2h4prJ4RXi0b9/WNmE0nhopraVoMvE12P/oevANN
 FWyCQr5N9/o+9wZIzyPO4Dt+g4Rw7b+skt/O4z49J1qaElMLl36QgMGL4WOY9s2U94mH
 c/8LEQAusKptYBRcnetmwE0zw9+FaMdGVgcnzYLQt6EJg+G++rhgnLwAt5Sn1+XNY7OJ
 ORF+gdiThlHI4HnWsx4lCOsls6cSoJpwc+IuQueLbMNmSQkkkmpdrmz1a9Zez1PtPkKx
 17Dw==
X-Gm-Message-State: AOJu0Yx6vgq3u6xqD8wKecwhDqMm43XNIvm+B9bcryvGRqwnp5S79yNj
 NwghTaHkg8cGKRVCDkIdFdN8VaGc5NdY2TjoLGskY+86uICR8MniZ56TFnCYBxH/ELKlQ5KvZxg
 PoVMZox3FJ8V0NfQBwAmrV2qtkJ4MlL1u09OIircAvL9fyfAZJRuhO+AG3ybXUu4KEkgL1TNdzh
 UfqkTapqmEpJkzT2ppntRzaKqmeWUT5BbC8w==
X-Gm-Gg: ASbGncuIji5c7npICp3SyMVEUHH524u0y0t9xCneYQuynd/54c/1UsXB+hiqs1vWarR
 osMWkm5FQu9IYI+pboMsn2jZz6OAH/YEQ9ggi2kVSCzoNJECL06CbipxDHYXwdB62wthhU+BXqp
 PNT2tRsufKQEqYRj2vbZ43nz5vyJPpJrlzzWpUXnZNdWJaZ4WfE3l5v3gkg9RUp6B+bfMswgeF5
 K02etLi8N+Pv0zC0yxngw9rbSqO9aMbdOvhAJew0BvmIElk32PCvSuXUDnJt8/0FG4ZmxguSl4g
 t9Cyfll2C8fVlJkyz6Pe26J2DY4Fd16g
X-Received: by 2002:a05:622a:4714:b0:46c:7141:9087 with SMTP id
 d75a77b69052e-46c714190f1mr334145101cf.1.1736896081749; 
 Tue, 14 Jan 2025 15:08:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQSrXmhW759nFP04QStqKNu2YGJ23xnFUYrhh9jrYz8SJsxhr88MCIH3tHdFJU6bbnmWFHtg==
X-Received: by 2002:a05:622a:4714:b0:46c:7141:9087 with SMTP id
 d75a77b69052e-46c714190f1mr334144861cf.1.1736896081420; 
 Tue, 14 Jan 2025 15:08:01 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 07/16] migration: Adjust postcopy bandwidth during switchover
Date: Tue, 14 Jan 2025 18:07:37 -0500
Message-ID: <20250114230746.3268797-8-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Precopy uses unlimited bandwidth always during switchover, it makes sense
because this is so critical and no one would like to throttle bandwidth
during the VM blackout.

OTOH, postcopy surprisingly didn't do that.  There's one line that in the
middle of the postcopy switchover it tries to switch to postcopy's
specified max-postcopy-bandwidth, but even so it's somewhere in the middle
which is strange.

This patch brings the two modes to always use unlimited bandwidth for
switchover, meanwhile only apply the postcopy max bandwidth after the
switchover is completed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 33c4824b68..13b7df0d5b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2502,7 +2502,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     int ret;
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
-    uint64_t bandwidth = migrate_max_postcopy_bandwidth();
     int cur_state = MIGRATION_STATUS_ACTIVE;
 
     /*
@@ -2551,6 +2550,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
+    /* Switchover phase, switch to unlimited */
+    migration_rate_set(RATE_LIMIT_DISABLED);
+
     /*
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
@@ -2567,12 +2569,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         ram_postcopy_send_discard_bitmap(ms);
     }
 
-    /*
-     * send rest of state - note things that are doing postcopy
-     * will notice we're in POSTCOPY_ACTIVE and not actually
-     * wrap their state up here
-     */
-    migration_rate_set(bandwidth);
     if (migrate_postcopy_ram()) {
         /* Ping just for debugging, helps line traces up */
         qemu_savevm_send_ping(ms->to_dst_file, 2);
@@ -2656,6 +2652,12 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
 
+    /*
+     * Now postcopy officially started, switch to postcopy bandwidth that
+     * user specified.
+     */
+    migration_rate_set(migrate_max_postcopy_bandwidth());
+
     return ret;
 
 fail_closefb:
-- 
2.47.0


