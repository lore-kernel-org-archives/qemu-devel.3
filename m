Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670A8C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjni1-000285-1I; Mon, 11 Mar 2024 18:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngi-0000af-9L
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngg-00043y-G4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rL6j1uu8QRSoTX9y8l1g+EBtq/hMZ1TFKKu6d9s4aA=;
 b=cnr4c5mhv1jmScm0oz9I7DLDr3vfHUQf9HHDLgE6PnXTNpAOMHo/jdkEzzdtn/zkEXtMTK
 mFvgFXjuS/ZjJRYI6ltm8mYIVJ7oF6EOT0urhB1KONpImnaFe+kmBZj/5dARfV1+wfVUhy
 MqMALbZFgK7KEjCC8Q2KZlI4FAVA69Y=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-1hGtw9PZMHuct1PVIV5Kuw-1; Mon, 11 Mar 2024 18:00:00 -0400
X-MC-Unique: 1hGtw9PZMHuct1PVIV5Kuw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7dadf2f724aso283637241.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194399; x=1710799199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rL6j1uu8QRSoTX9y8l1g+EBtq/hMZ1TFKKu6d9s4aA=;
 b=QFZSfIToL6i7S1SSQ5zLzqyD7U44eek8TcsWMSuSv7G6xObViyDS31xul6NFWM3xih
 DWTttFi9MzUi7klGu26A1deASdACWvrYkfWZS8qAZsHZHQYXqPyhGfATlNG02tNbNhi6
 dpZ6CsXlDJoptGTRLc4rTpVTCrFs4IcO/aKBkijtO27RdDt7M34+g5/Zn8eqqKB6WpSr
 FFHDD8uFhEla/9l5jAQn9OKBrTtQFRni7HJ2SS7OnSUMXriKNWyE76JlzQ163oBPluZG
 7HqUm5eKvD5PMbYbeChV7WtSROZVuKRYgdknS4h10OqPf6X3J7CK0OI1hstHttPSXHpc
 ENAw==
X-Gm-Message-State: AOJu0YyR0x1s0Z/DdGPgLVUpUbZHG6w1n1PXP1eSqjqL0dribFR4SkZo
 V5ngdxNsVZ5AuvaW8H7JDNub3Xd5ogsbmWXMv/oAvShvZeF5tDveif/FuJuwgsq7ZGQ93qqIxlE
 4hq28TdYh+NF2uDZ/uo9xZ5LrGz8C7Jq3jphi6/WXF0SYdnez4xXDeiBTIGy64l5gxGmG/ias/S
 IVu9w/3EW8KGQlMC8s0P/4o3kPMd4BmIpgVQ==
X-Received: by 2002:a67:ef8f:0:b0:473:2819:36b7 with SMTP id
 r15-20020a67ef8f000000b00473281936b7mr3899053vsp.1.1710194399258; 
 Mon, 11 Mar 2024 14:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ9eDbklkf8lao26lC4p3ePnMkQ0/VPWRRE8mrFqdJXKE7DXSqhlH8iPtb9Q15Lv6fdjONVA==
X-Received: by 2002:a67:ef8f:0:b0:473:2819:36b7 with SMTP id
 r15-20020a67ef8f000000b00473281936b7mr3899029vsp.1.1710194398813; 
 Mon, 11 Mar 2024 14:59:58 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:58 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 21/34] migration: export vcpu_dirty_limit_period
Date: Mon, 11 Mar 2024 17:59:12 -0400
Message-ID: <20240311215925.40618-22-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
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

From: Steve Sistare <steven.sistare@oracle.com>

Define and export vcpu_dirty_limit_period to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-6-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/client-options.h | 1 +
 migration/options.c                | 7 +++++++
 system/dirtylimit.c                | 3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 887fea1565..59f4b55cf4 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -20,5 +20,6 @@ bool migrate_switchover_ack(void);
 /* parameters */
 
 MigMode migrate_mode(void);
+uint64_t migrate_vcpu_dirty_limit_period(void);
 
 #endif
diff --git a/migration/options.c b/migration/options.c
index 642cfb00a3..09178c6f60 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -924,6 +924,13 @@ const char *migrate_tls_hostname(void)
     return s->parameters.tls_hostname;
 }
 
+uint64_t migrate_vcpu_dirty_limit_period(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.x_vcpu_dirty_limit_period;
+}
+
 uint64_t migrate_xbzrle_cache_size(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 1622bb7426..b0afaa0776 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -77,14 +77,13 @@ static bool dirtylimit_quit;
 
 static void vcpu_dirty_rate_stat_collect(void)
 {
-    MigrationState *s = migrate_get_current();
     VcpuStat stat;
     int i = 0;
     int64_t period = DIRTYLIMIT_CALC_TIME_MS;
 
     if (migrate_dirty_limit() &&
         migration_is_active()) {
-        period = s->parameters.x_vcpu_dirty_limit_period;
+        period = migrate_vcpu_dirty_limit_period();
     }
 
     /* calculate vcpu dirtyrate */
-- 
2.44.0


