Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EEEC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Tu-0003JN-3j; Tue, 27 May 2025 19:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Ts-0003Ig-Vi
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tr-0001E7-GB
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0bhbecsmzeOLXe9dkL8LSOz4qm8m26wuFzD/NSoKEY=;
 b=Mej4WPp7j9hKCyM4+GM0eJd+8lbUgfP9umRirYyw5qY3nuKkFFlY7fOSL6yMqPeGQDfcKh
 dDIZhLYctLWtEH5Xoj+p50MNHt7YQlA+rfrx2af3UKWQBJHtEx3v6Yeee/UYcHPQCO9a5G
 1WTZQQgM7Y/SAG6ufwkPj9kgS1z+1Tg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-J9W93IK8Pdy-O3yLCUTJww-1; Tue, 27 May 2025 19:13:09 -0400
X-MC-Unique: J9W93IK8Pdy-O3yLCUTJww-1
X-Mimecast-MFC-AGG-ID: J9W93IK8Pdy-O3yLCUTJww_1748387589
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4768d63b1dcso5496611cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387589; x=1748992389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0bhbecsmzeOLXe9dkL8LSOz4qm8m26wuFzD/NSoKEY=;
 b=U/5mdQQTS0JgwhR/pAs3p8eYBTCyas3ruXFqX0w60NlvZd9vkFCwlAdRcKgCBWrXhB
 iRtnoXwa36BQL8AWDINfRQU83vS+oV8wQabFOK+haiqEl/rNJYRGMjkF7i5Tn4BTlqyI
 75cfgMh8fbMCAbT3yUZqvIXRU/4FZzhtP6+z8x+xlM8gKB0pcPjBWUeOmF5tLcSDu4qJ
 8zBBZaX1RzxlX4Eihiwg0mrhgWxaHVIYlXQJTNuhLFbBpol0VQPUmaNc7qbsApbuxCSz
 aHe20gCvGo0u49+/p8jJSGxzUrXUUvbyCl4z5cf5O+YvucAEERA8VSiJk1I00wYhuB+u
 JGVA==
X-Gm-Message-State: AOJu0YzTB0fnzpVHJ9ZKLDUBfgkVx5DQhUjIf2vVmrWmywno2jOYP2op
 sZOjUd+8jM/ChndqEr0nPztMwoGlf635Ie2G7U6XxTcX7Rnc1J4FcDz63//77URpNzYU5s7eeFo
 RvWgchyDlvXS/Fukn8kaNqPOVsoWgf40mTS0otEbAvCOJRss9k/A0KkzAN9CEWH7Ty4ToDzsbXb
 yCuJDZ44kE6fOcqEOqOI05Up6fALAjsL0csPqnRw==
X-Gm-Gg: ASbGnct76ujHvoeUXeI0Hz9EekXimuhCMyY7Zr07ve4/aHZv/shzXrn0afBycRywnN9
 uIwk0tPtBADbtMqSYIEDCW6fDNUByt/G62d8tYdynsk5XhsbvPPm9B+w3eyN7uTLWZournz/3uo
 1f0X60SjHmO9v91MB7MwO/qPYdPxvAynHveJ0801iyxGWNApMf6xsEV+efOEG3GFeTqZev9BRgu
 w3S3Flfsx/lHtbSp6agWHjiwp1bydMp6q46NIwS9XwVkdcBbhh8+Yfi25EgDvLerAhYDset1zab
X-Received: by 2002:a05:622a:244c:b0:48d:66ee:662a with SMTP id
 d75a77b69052e-4a2f52fcd28mr42988451cf.26.1748387589025; 
 Tue, 27 May 2025 16:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLs72MzepzXmA3vk1RLSkqhrEba0KURDIVug8ClPX+AubGrlpgj3ljrU4tUmG7AiE6XDWKow==
X-Received: by 2002:a05:622a:244c:b0:48d:66ee:662a with SMTP id
 d75a77b69052e-4a2f52fcd28mr42988001cf.26.1748387588640; 
 Tue, 27 May 2025 16:13:08 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 09/13] migration/postcopy: Initialize blocktime context only
 until listen
Date: Tue, 27 May 2025 19:12:44 -0400
Message-ID: <20250527231248.1279174-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527231248.1279174-1-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Before this patch, the blocktime context can be created very early, because
postcopy_ram_supported_by_host() <- migrate_caps_check() can happen during
migration object init.

The trick here is the blocktime context needs system vCPU information,
which seems to be possible to change after that point.  I didn't verify it,
but it doesn't sound right.

Now move it out and initialize the context only when postcopy listen
starts.  That is already during a migration so it should be guaranteed the
vCPU topology can never change on both sides.

While at it, assert that the ctx isn't created instead this time; the old
"if" trick isn't needed when we're sure it will only happen once now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 2aca41b3d7..e73f5d1cc7 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -324,13 +324,13 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis,
     }
 
 #ifdef UFFD_FEATURE_THREAD_ID
+    /*
+     * Postcopy blocktime conditionally needs THREAD_ID feature (introduced
+     * to Linux in 2017). Always try to enable it when QEMU is compiled
+     * with such environment.
+     */
     if (UFFD_FEATURE_THREAD_ID & supported_features) {
         asked_features |= UFFD_FEATURE_THREAD_ID;
-        if (migrate_postcopy_blocktime()) {
-            if (!mis->blocktime_ctx) {
-                mis->blocktime_ctx = blocktime_context_new();
-            }
-        }
     }
 #endif
 
@@ -1238,6 +1238,11 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (migrate_postcopy_blocktime()) {
+        assert(mis->blocktime_ctx == NULL);
+        mis->blocktime_ctx = blocktime_context_new();
+    }
+
     /* Now an eventfd we use to tell the fault-thread to quit */
     mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
     if (mis->userfault_event_fd == -1) {
-- 
2.49.0


