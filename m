Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E410FC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59E-0003sr-Dd; Fri, 13 Jun 2025 10:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ597-0003sa-9G
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002JE-Nu
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IV12Wf4LkVZLaVKBOcF5oGfPlhOljDoxLX6j8/o5TFE=;
 b=DhP8I0hSsXy1w+sEYyT0eKKfl+Ee5+f7F6kRLUMV8cfhjgj/9Nrz491fedfOcqKxAUU+kM
 YvHY3GKm9JYtNUwyRFFNqIAiuYgNTylM8CLB9fkkVcT97lExsE4DTMjutJic/p6OEJH5wS
 A5jq4qAv6CSk+W29xh48kgISyET60zg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-7OO_Ifa2O5iE7H7NmHeexg-1; Fri, 13 Jun 2025 10:12:27 -0400
X-MC-Unique: 7OO_Ifa2O5iE7H7NmHeexg-1
X-Mimecast-MFC-AGG-ID: 7OO_Ifa2O5iE7H7NmHeexg_1749823947
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4a584d0669fso41165061cf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823946; x=1750428746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IV12Wf4LkVZLaVKBOcF5oGfPlhOljDoxLX6j8/o5TFE=;
 b=d2KprCvCbVeqAdgAHNWgtP/g96T1JKCkQiEJrZy/zDxoeMPdQmVINuPmYrXCXZXHGU
 aWZSsNeq+cZgvvfJS4JJksXnpVQ7VkVevyjriT4juhju04udtbxHjHEWPFWrD060zQsb
 1y2U+wRphdL7jkCO8wQvB+wb49UXJ4L+9PMaopg5A660hbOdhXQuq4TNH4cmCfz13vt7
 2q9H43zK+Rgjp/MGzidx09cQIqBKSxC+Sukq/kcz6LRvfdc8gP++YdAyevja9ueMTput
 rRtmLqRePwkarE7Yml9hv1LC4ine8rTtvzyWVzb6DcUGkJ6ObUWMDnSHicBK3c8edBmh
 Cu2Q==
X-Gm-Message-State: AOJu0YyS41+79o0FxzuQChAByi43VVL5SE8ydzYyDhblSfebfB88Sj28
 4eAMv0OANDKXNnP2Ke4GtE3MVtUpg8dtt029Ych0dGi/0ICMp+LC1Pq7Z/5ydQ3U4tZlsnkUGok
 f4EeIfT5mQ+6PRJ3d0wg6q4pl4vt5sKqax9rCbL9R8zGLnNW4fVFKrKWK/zj/AO3FsS0RFAkCZe
 /qpVBle3cDU6zm+LW6PUkDGV4m1hN6+apnIf3jAg==
X-Gm-Gg: ASbGnct84kbEcKUbkjTRh5MwXGRADmJJKhiEk1FNET4OJSrooDtY3pUZZqCqvaIIXC9
 kQ6hdhY9olxEHGEh3d/Yktf4UG4QI+W3s8vPZHr2aSESZ18BBoJvHSF6LtrANUti2j/Y6CYqw/i
 M9ooH2V9VZWYkicjaYxmu30laLpy0wpGalYqMG4ji+femyX5OdVq2jKer9sQD5C+sdA7rzqWwEg
 0tS3PtTdOmerhyp//xnOKG73pa4r6i5hiZTmPi6vjs+onwF25uKQxNh7TerunpPG6QEPuVEWwOo
 0uQl7ci5VBI=
X-Received: by 2002:a05:622a:1f91:b0:4a4:3079:55e7 with SMTP id
 d75a77b69052e-4a72fe7a666mr55132531cf.17.1749823946385; 
 Fri, 13 Jun 2025 07:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiFvSXbiq1MSDlD/nc6Ke+ac2OT7uSdaNAkB4ZP4hRa0OtTreUsfpZ+bMPckjfJas84kbLGA==
X-Received: by 2002:a05:622a:1f91:b0:4a4:3079:55e7 with SMTP id
 d75a77b69052e-4a72fe7a666mr55131991cf.17.1749823945818; 
 Fri, 13 Jun 2025 07:12:25 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 05/14] migration/postcopy: Drop
 PostcopyBlocktimeContext.start_time
Date: Fri, 13 Jun 2025 10:12:08 -0400
Message-ID: <20250613141217.474825-6-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Now with 64bits, the offseting using start_time is not needed anymore,
because the array can always remember the whole timestamp.

Then drop the unused parameter in get_low_time_offset() altogether.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index ec91821b85..e9acb4ef6e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -123,7 +123,6 @@ typedef struct PostcopyBlocktimeContext {
     uint64_t last_begin;
     /* number of vCPU are suspended */
     int smp_cpus_down;
-    uint64_t start_time;
 
     /*
      * Handler for exit event, necessary for
@@ -157,7 +156,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
     ctx->exit_notifier.notify = migration_exit_cb;
-    ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     qemu_add_exit_notifier(&ctx->exit_notifier);
 
     return ctx;
@@ -818,9 +816,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
     return -1;
 }
 
-static uint64_t get_low_time_offset(PostcopyBlocktimeContext *dc)
+static uint64_t get_low_time_offset(void)
 {
-    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - dc->start_time;
+    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 }
 
 /*
@@ -847,7 +845,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         return;
     }
 
-    low_time_offset = get_low_time_offset(dc);
+    low_time_offset = get_low_time_offset();
     if (dc->vcpu_addr[cpu] == 0) {
         dc->smp_cpus_down++;
     }
@@ -907,7 +905,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
         return;
     }
 
-    low_time_offset = get_low_time_offset(dc);
+    low_time_offset = get_low_time_offset();
     /* lookup cpu, to clear it,
      * that algorithm looks straightforward, but it's not
      * optimal, more optimal algorithm is keeping tree or hash
-- 
2.49.0


