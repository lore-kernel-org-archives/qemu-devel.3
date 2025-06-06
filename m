Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70BCC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWL6-0004tA-OG; Fri, 06 Jun 2025 08:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJ7-0003V1-5J
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJ4-000602-NI
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/OYOGxT4Py9fvxqOnTI/FCsh6WbDenbHkCr+dNtijQ=;
 b=ihIbijZyOc2X2ORVR8PepIpUz0G3VPktrZdlTa3X52DdtuwF4vk/Og7+lRKyy739sRFJFZ
 XHgDV64Eriglqf2HFFa/tTDaXafZXRus+I6PqWvHy5yDjN4Nl5Pu2D6/mbO1bYl08ET264
 5Dad0jNOMg+0yrgWI1oRJPfYrxoHPWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9tbwzWm_N_WHix40W91UDA-1; Fri, 06 Jun 2025 08:36:20 -0400
X-MC-Unique: 9tbwzWm_N_WHix40W91UDA-1
X-Mimecast-MFC-AGG-ID: 9tbwzWm_N_WHix40W91UDA_1749213379
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so1152330f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213378; x=1749818178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/OYOGxT4Py9fvxqOnTI/FCsh6WbDenbHkCr+dNtijQ=;
 b=P9KRfka7Z4byUDtnlig7BjLlaYJuemz8wjobSB3BOzlkl0tMI7P+BzltiExB6HRl5M
 newQHUaCZuGGqeDNan7NtljezLM5Y1lWisMtGtILEgtPZWXgdXh/Cwh/rE7QKcrkWSlz
 FVXnImHex4YcHz3nunjRnqPbutcRPviVP3BJVIAmKQCkp19Ew0v7KUOItL9s8pNhk8tY
 OV0Fhul5oDUy1gmu5M9sk8qepfN5Z8LLsAEw7rxe4Jr+xOkrmo737GWgB6+cGE2u0W1P
 3TDnuQ4amm0RDq2g5u0D/g93g3XKzz1kN9rKyD4DId2vP707jip6XkxX4ziNW2APJNr2
 9sHA==
X-Gm-Message-State: AOJu0Yw8olq3jKLrBQBCJePjZEK1qf/vpXA2yewy/3z2IEAgJ8wFadW2
 GDVXgw3Z71/zOSWiQBf7zbL0DTzGNZ8Ios9UT00yLX8Po4xUl8DsvEg1W3z9Wv/17HvuZkCAr9E
 EpMlfz+M7B7MrfYMmY/8SIoI5s3Iewe/9Z86UsuZTseXX8IeAW/g9eDz0lAoBtivtrNH+/mJp/l
 fdW86WnRaBkfhR2303sHIQo6QvaRGwQ/87J4zRXa6T
X-Gm-Gg: ASbGncuPOFVtHZ4qIMmxHbOrp0VohOLmAX0HVO3t2Yhjk6Xn2bsx5H7u8KSt5SwogFS
 eosA9BzBJg7cyze4Vn6C5K1u+x+0+r7s6bliLgsSq0i9vxNs+AmZ/v379R5PMFlS+ZoVT5k9+C+
 FiQU7QnjU1n5GkUYFoAKQD0RWJDRmHNoYFmp+U3haG0w8SBF/HCPoR+ac6JUsMy3RcTvTxoTbd5
 kuP6r2K7fbjhHLSNlC+WeNZTSo9VPynjoWTn/Up8IxEU3vG8LWWNgp5YiwMrH852miMRvIJHI3o
 pypRgGdYo8fU9hbOyXbKuG5k
X-Received: by 2002:a05:6000:2310:b0:3a4:cec5:b59c with SMTP id
 ffacd0b85a97d-3a526e1cf0fmr7369632f8f.25.1749213378074; 
 Fri, 06 Jun 2025 05:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6hqdQ12+B5TulpjL/iF1elf9cft/7dagENTRrTamCfJa6piTmN0lDIEn5rk8txKqMVlXHGQ==
X-Received: by 2002:a05:6000:2310:b0:3a4:cec5:b59c with SMTP id
 ffacd0b85a97d-3a526e1cf0fmr7369611f8f.25.1749213377501; 
 Fri, 06 Jun 2025 05:36:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45213709729sm22626255e9.19.2025.06.06.05.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 26/31] migration/postcopy: Replace QemuSemaphore with QemuEvent
Date: Fri,  6 Jun 2025 14:34:40 +0200
Message-ID: <20250606123447.538131-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

thread_sync_sem is an one-shot event so it can be converted into
QemuEvent, which is more lightweight.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250529-event-v5-9-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/migration.h    |  4 ++--
 migration/postcopy-ram.c | 10 +++++-----
 migration/savevm.c       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index aaec471c00f..739289de934 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -98,9 +98,9 @@ struct MigrationIncomingState {
     void (*transport_cleanup)(void *data);
     /*
      * Used to sync thread creations.  Note that we can't create threads in
-     * parallel with this sem.
+     * parallel with this event.
      */
-    QemuSemaphore  thread_sync_sem;
+    QemuEvent  thread_sync_event;
     /*
      * Free at the start of the main state load, set as the main thread finishes
      * loading state.
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 995614b38c9..75fd310fb2b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -90,10 +90,10 @@ void postcopy_thread_create(MigrationIncomingState *mis,
                             QemuThread *thread, const char *name,
                             void *(*fn)(void *), int joinable)
 {
-    qemu_sem_init(&mis->thread_sync_sem, 0);
+    qemu_event_init(&mis->thread_sync_event, false);
     qemu_thread_create(thread, name, fn, mis, joinable);
-    qemu_sem_wait(&mis->thread_sync_sem);
-    qemu_sem_destroy(&mis->thread_sync_sem);
+    qemu_event_wait(&mis->thread_sync_event);
+    qemu_event_destroy(&mis->thread_sync_event);
 }
 
 /* Postcopy needs to detect accesses to pages that haven't yet been copied
@@ -964,7 +964,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
     mis->last_rb = NULL; /* last RAMBlock we sent part of */
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
 
     struct pollfd *pfd;
     size_t pfd_len = 2 + mis->postcopy_remote_fds->len;
@@ -1716,7 +1716,7 @@ void *postcopy_preempt_thread(void *opaque)
 
     rcu_register_thread();
 
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
 
     /*
      * The preempt channel is established in asynchronous way.  Wait
diff --git a/migration/savevm.c b/migration/savevm.c
index 006514c3e30..52105dd2f10 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2078,7 +2078,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
     trace_postcopy_ram_listen_thread_start();
 
     rcu_register_thread();
-- 
2.49.0


