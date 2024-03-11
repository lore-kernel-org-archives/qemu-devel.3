Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51EEC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnhV-0001Se-JU; Mon, 11 Mar 2024 18:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngr-0000r8-6z
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngo-0004HN-ET
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIq9EpMeiKCu6O9A+NAt96bPDqnWgTrQUrVo9wmJlvA=;
 b=INCkRMXOUJaIBmC9rYfqomFd6aSQbReW39WvWbr3b4NQ1sQQ5Vkio3hyz53Eum48iqamZn
 6z8Ky4qsQlr7qHMmkHG5Cfss+cNnMOjNQs+cr+uIbwutnDic3By+7rwDYVFdDTBoV7gP8D
 q/fOE6V5Wx3GDXMdBbpB1if2aHVTdzk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-v5fdqAhGNo-ntKNG1vKUFA-1; Mon, 11 Mar 2024 18:00:08 -0400
X-MC-Unique: v5fdqAhGNo-ntKNG1vKUFA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6818b8cb840so15028376d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194407; x=1710799207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIq9EpMeiKCu6O9A+NAt96bPDqnWgTrQUrVo9wmJlvA=;
 b=aj3QQyKfTaqD+yZHvq2GgzFvAAPT2sI7qo1KmzyuKykP43GnGlA5PfyNM9Dqbog090
 4ecxWeFNmXJcg003NNziqd3QInlGOnuXD6Om1ugxTTQvNFO3nWMuxX/jBWv/vpfacmhI
 LSoiWB7KVrtLNv0ci5EP72h5XP0ErjCCg4neFGZtlKzmBc9DHeE/R7ByGM4LY/c1IiuW
 +ukveLpb3HDJjvaR3FheXvYE/ofX1230klwTOmzj5O2bMzsRnLeC3VTCZ3AVFeVmhAoc
 12yY4BNANbvAInj+i4AvBgbuTCX1GllrZMNqFgBem7Wt2fVTcxD/MB3cF5/nqiF+UMXz
 2wZQ==
X-Gm-Message-State: AOJu0YzIuGdxHEUqyHKug4mfrjndhTHikG6gMDUtEhUfDoe8oFQsaur2
 pn/ElpMZFEAcZ++TSrf+JMfoTzYyqssWgswaqtkTR54LmQCjoIpdj0aa4LFtyFr8eyemP9gJEqC
 lZ58GW1k808lMm7fnCSQNKow/0lAyqK0eNTbs4+L5e6pEK1nnJfYGVEztBiLZn4nePDt0qYhZqb
 daTMbfEgX9bZBC+t2MnHRvrrozKmymoBDq7w==
X-Received: by 2002:ad4:4e6c:0:b0:690:b47e:60e3 with SMTP id
 ec12-20020ad44e6c000000b00690b47e60e3mr7387753qvb.5.1710194407433; 
 Mon, 11 Mar 2024 15:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP0gNPDOXkCdBgWOwrPCTgBobQvqvkHuhDlmEBkxrKeGWCqT/ju5dfVLAnkUisfWvZh7JHaA==
X-Received: by 2002:ad4:4e6c:0:b0:690:b47e:60e3 with SMTP id
 ec12-20020ad44e6c000000b00690b47e60e3mr7387714qvb.5.1710194406897; 
 Mon, 11 Mar 2024 15:00:06 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:06 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 27/34] migration: purge MigrationState from public interface
Date: Mon, 11 Mar 2024 17:59:18 -0400
Message-ID: <20240311215925.40618-28-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Move remaining MigrationState references from the public file
misc.h to the private file migration.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-12-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 6 ++----
 migration/migration.h    | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index d563d2c801..c9e200f4eb 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -64,7 +64,6 @@ bool migration_is_active(void);
 bool migration_is_device(void);
 bool migration_thread_is_self(void);
 bool migration_is_setup_or_active(void);
-bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
@@ -103,16 +102,15 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
-int migration_call_notifiers(MigrationState *s, MigrationEventType type,
-                             Error **errp);
-bool migration_has_failed(MigrationState *);
 bool migration_is_running(void);
 void migration_file_set_error(int err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
+
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
 bool migration_incoming_postcopy_advised(void);
+
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
diff --git a/migration/migration.h b/migration/migration.h
index e4983db9c9..8045e39c26 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -26,6 +26,7 @@
 #include "qom/object.h"
 #include "postcopy-ram.h"
 #include "sysemu/runstate.h"
+#include "migration/misc.h"
 
 struct PostcopyBlocktimeContext;
 
@@ -479,12 +480,17 @@ bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
+int migration_call_notifiers(MigrationState *s, MigrationEventType type,
+                             Error **errp);
+
 int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
 bool migration_postcopy_is_alive(int state);
 MigrationState *migrate_get_current(void);
+bool migration_has_failed(MigrationState *);
+bool migrate_mode_is_cpr(MigrationState *);
 
 uint64_t ram_get_total_transferred_pages(void);
 
-- 
2.44.0


