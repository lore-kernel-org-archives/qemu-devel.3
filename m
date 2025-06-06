Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14477C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWJQ-0003px-Sz; Fri, 06 Jun 2025 08:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJ3-0003Ml-FT
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJ0-0005zX-1z
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRjdgkT+SM7jCW9MUtI3FAgwqDoN5/Ld4xOkembi0iw=;
 b=cPnUGHJoSToavEdpnYSgY73gEmc9+XEUNpOQdzQBzpGCYdS1YYD+o99deH0zMmPmmOY4PI
 4BEZ/aPA1XSFIAoVn/EBMd6vx3IGyJZLIXmMKBI295PbMlNHmWYBe0ULua1OuXQhGVxhkI
 W0CvXoCUaaveIvf6ADNnYOEpIpVHoZ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-uGxQPm-xOAy7xuFoiVUVsQ-1; Fri, 06 Jun 2025 08:36:13 -0400
X-MC-Unique: uGxQPm-xOAy7xuFoiVUVsQ-1
X-Mimecast-MFC-AGG-ID: uGxQPm-xOAy7xuFoiVUVsQ_1749213372
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so1289041f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213371; x=1749818171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRjdgkT+SM7jCW9MUtI3FAgwqDoN5/Ld4xOkembi0iw=;
 b=iLQk5A4EKzdZsId+N3EUxD7kAeLJDVmbTf3wRtHMMZUDw2tUwiKCYHc2sI5F3s0aEA
 aibHf39Cd3sb+eIrN97YpGHQCyoRQO3iUmz4P8xkfd0XrDEIBWWu0dBrRkQ67B7HnCbP
 ZqcOMtqneZAJY21AISMqBcoevNKTl4uWOWp3ojTFBdTVDklY7SIdDCfmquqA5dmiy8Z2
 WB93H5afM7+xRsn20qjpg5SxblAkNmx1zgmk7IgvEQrovbBJYUuAVUGMyrzxc+m1ENCL
 0cU7QjqeJ7CWgksATdB/IOsh5hguQ+BmfBMs5Y4y95hmdcW432IK08KDJvPhn7h/9AbP
 u1Qw==
X-Gm-Message-State: AOJu0Yw2SwgLDXkRh0QSYSH1fW+PGZK78H6RaavgBcWXUGHRugPIL5gY
 ULAZN+Tm5Y4nDbT/m4rTBibvXySZIUQAT8U92TSwyFvNE3lsE53TXe4FFizX675DtnEcChxNBRw
 S6ot9DVlTcB1wjLls5N9NXnn6xt69cKNnyWYqzOxotRkzReLRXOobQ2tQyBp2nQrlTtp+3Y5dPF
 CEImDqMpn5t+QosxHmIefIeaB1ghv9sqRgxAG0tDub
X-Gm-Gg: ASbGncvy2LTrqdkQrhGPyv+m8+bdmyUT7Ft/rRXrh0Uo6HedlojNo5qwwSKohLzurgN
 N5V3iRz1SQSEkzK/IOeiBwBmJlu1am6YBK9nZKq3H1l3dBMnyUA1tTZK0Q53O0ADx/mL7NVqwzM
 5hAhSlxhzROhj/fvbakNr0IYBhTiIQwItpOR/kBxF0tEu+z4qbMZbn7ELVR/724YWGHpljYRfTP
 KhylJcMJzGHDkQ1ngtHj2X3FBFHQzkOyLMrjmmUJfl3a0zy3rCmcktga8jJku2GwCa5zlKTHsFF
 ofI6vBKES5nFeG2m5YEMTi6C
X-Received: by 2002:a05:6000:18a4:b0:3a4:dfaa:df8c with SMTP id
 ffacd0b85a97d-3a5319b6f06mr3034528f8f.11.1749213370961; 
 Fri, 06 Jun 2025 05:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa8XlNpzMhIibmrlaSoiKwZD9MQF+e4DhYO3G/BUGZRkALjov2oyXfqSleGgzkT3jcWYt2mQ==
X-Received: by 2002:a05:6000:18a4:b0:3a4:dfaa:df8c with SMTP id
 ffacd0b85a97d-3a5319b6f06mr3034495f8f.11.1749213370412; 
 Fri, 06 Jun 2025 05:36:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53246b678sm1732980f8f.101.2025.06.06.05.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/31] migration: Replace QemuSemaphore with QemuEvent
Date: Fri,  6 Jun 2025 14:34:38 +0200
Message-ID: <20250606123447.538131-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pause_event can utilize qemu_event_reset() to discard events.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250529-event-v5-7-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/migration.h |  2 +-
 migration/migration.c | 21 +++++++++------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d53f7cad84d..21aa6a3c8fe 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -379,7 +379,7 @@ struct MigrationState {
     QemuSemaphore wait_unplug_sem;
 
     /* Migration is paused due to pause-before-switchover */
-    QemuSemaphore pause_sem;
+    QemuEvent pause_event;
 
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
diff --git a/migration/migration.c b/migration/migration.c
index 4697732bef9..4098870bce3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1630,7 +1630,7 @@ void migration_cancel(void)
         }
         /* If the migration is paused, kick it out of the pause */
         if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
-            qemu_sem_post(&s->pause_sem);
+            qemu_event_set(&s->pause_event);
         }
         migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
@@ -2342,7 +2342,7 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
                    MigrationStatus_str(s->state));
         return;
     }
-    qemu_sem_post(&s->pause_sem);
+    qemu_event_set(&s->pause_event);
 }
 
 int migration_rp_wait(MigrationState *s)
@@ -2911,21 +2911,18 @@ static bool migration_switchover_prepare(MigrationState *s)
         return true;
     }
 
-    /* Since leaving this state is not atomic with posting the semaphore
+    /*
+     * Since leaving this state is not atomic with setting the event
      * it's possible that someone could have issued multiple migrate_continue
-     * and the semaphore is incorrectly positive at this point;
-     * the docs say it's undefined to reinit a semaphore that's already
-     * init'd, so use timedwait to eat up any existing posts.
+     * and the event is incorrectly set at this point so reset it.
      */
-    while (qemu_sem_timedwait(&s->pause_sem, 1) == 0) {
-        /* This block intentionally left blank */
-    }
+    qemu_event_reset(&s->pause_event);
 
     /* Update [POSTCOPY_]ACTIVE to PRE_SWITCHOVER */
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_PRE_SWITCHOVER);
     bql_unlock();
 
-    qemu_sem_wait(&s->pause_sem);
+    qemu_event_wait(&s->pause_event);
 
     bql_lock();
     /*
@@ -4057,7 +4054,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
     qemu_sem_destroy(&ms->rate_limit_sem);
-    qemu_sem_destroy(&ms->pause_sem);
+    qemu_event_destroy(&ms->pause_event);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
@@ -4072,7 +4069,7 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-    qemu_sem_init(&ms->pause_sem, 0);
+    qemu_event_init(&ms->pause_event, false);
     qemu_mutex_init(&ms->error_mutex);
 
     migrate_params_init(&ms->parameters);
-- 
2.49.0


