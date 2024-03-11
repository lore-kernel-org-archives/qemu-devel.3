Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D73DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngQ-0000IW-Us; Mon, 11 Mar 2024 17:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngN-0000GJ-UI
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngL-0003z0-Pc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qc0i8BnW6Y7BuHtVVuKYvIGbeCP0Ayl8x1jn5Sm+WgI=;
 b=GkCnBHnj4lkH300jLClTKDkSWnxOTKzr0JH7TRYYVkcH4AbL30Y2i57vqR3kpeKo5rdgT0
 gRgRKCb/MQ0RLH5zwXk+imRRnomdDjCtM3wK4gptK/hMpKE6dTkFTXk5e4YDChuRqYK82Z
 EtNqxfWj6+YQzGG7FmrmLNPjv95UyHM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-h9wBVvsBOn-BbcloWah00Q-1; Mon, 11 Mar 2024 17:59:39 -0400
X-MC-Unique: h9wBVvsBOn-BbcloWah00Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6818b8cb840so15026886d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194379; x=1710799179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qc0i8BnW6Y7BuHtVVuKYvIGbeCP0Ayl8x1jn5Sm+WgI=;
 b=OavWQh9fO3HKYiejE6iDsNy71tvxasmFOz0yvXopX3ra/wpGyb74eRCBLDuGlP5jSF
 z/lFBg8f0llA+yUP58g2tAgbPSr7B5ARWz0UW3h7qlKUHveJT6BjC/+x6b1QrCOS7JNT
 ImSzXkHIfxIW38AykLnAk7prlHgPzfghtb6p7tiqJncY6e8eAcdG9pGurNRSySoc8ojs
 GMJnv/oeEc/9AjWPRxlSEpkNjZymBIVazcjohAhU87tiAbPMurcFIOY4EaP7MwiVwP5O
 vrLsbluyPDgi3FvCYoDo4M97i1ZJwC5fwzZ6iMYlRSyQKZsjID/+tuZhR4B62EIAO3r/
 vvZw==
X-Gm-Message-State: AOJu0YxO2eU6514lQqtePbO15slaXoIElbsGLYo0OrC+rIWYawpHZLOE
 PUet13YBQdk6PqzBFcJiIbhbIjbDzInS6bVeiwXT/9imr7XEmgrG4UX8KpJr/11/+Tu2wbQVxCc
 AYFH9f6DugtTrt/qZdhWfo7ac/pvA8BuEekETAKjdb87VwCaFY6OBIr+Rz6aQZNxIE0AA5WYQup
 5I8Odi/HDUZVe/0IQUmfrkMQEBTiaKgdiGOA==
X-Received: by 2002:a05:6214:b6a:b0:690:ca31:f070 with SMTP id
 ey10-20020a0562140b6a00b00690ca31f070mr5305224qvb.2.1710194379066; 
 Mon, 11 Mar 2024 14:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOcDHtuVt2rJwLQXQNhTd4XDalzwWJL/qsute3enz3Sd6W1EkaaNsnBWPX7ewIFEZyhdeKEw==
X-Received: by 2002:a05:6214:b6a:b0:690:ca31:f070 with SMTP id
 ey10-20020a0562140b6a00b00690ca31f070mr5305201qvb.2.1710194378502; 
 Mon, 11 Mar 2024 14:59:38 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:37 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/34] migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in
 case of error
Date: Mon, 11 Mar 2024 17:58:59 -0400
Message-ID: <20240311215925.40618-9-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

When commit bd2270608fa0 ("migration/ram.c: add a notifier chain for
precopy") added PRECOPY_NOTIFY_SETUP notifiers at the end of
qemu_savevm_state_setup(), it didn't take into account a possible
error in the loop calling vmstate_save() or .save_setup() handlers.

Check ret value before calling the notifiers.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240304122844.1888308-10-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e84b26e1c8..76b57a9888 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1317,7 +1317,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
     MigrationState *ms = migrate_get_current();
     SaveStateEntry *se;
     Error *local_err = NULL;
-    int ret;
+    int ret = 0;
 
     json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
     json_writer_start_array(ms->vmdesc, "devices");
@@ -1351,6 +1351,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
         }
     }
 
+    if (ret) {
+        return;
+    }
+
     if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
         error_report_err(local_err);
     }
-- 
2.44.0


