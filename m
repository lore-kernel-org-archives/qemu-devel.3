Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B83C5DF70
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvex2-0007ny-Ue; Sun, 16 Aug 2026 13:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvex2-0007nq-0y
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:16 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvex0-00037M-Hh
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d032846c95so38601335ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902433; x=1787507233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A1pznOV9GW0rbqufDgwjkEClbA5koQWvItVltcogtdc=;
 b=kGzqqAZb1lteLK6YNBk770556qLh9G0fEF3itbeJn3wM+4pY8u0eryxLW7tvouQE2j
 RT2yznTxFkfTA+RJjG0Axicx2TBrwGlMesNSg5Ha+gs/paMWWiRt/VH8tkWHnp9itqKy
 lcW8sf01u+e5RYwyREb9fV1jSCyUrkwgpjd86nV+fphaXvy4kJHZs7Sp2DYAQm7jL6tW
 joZsDoXBmVIW/zqF38eX/xQmsV/RX9NkZsXivfED+kt73uVaorDTbw5qOCGlqnGMPnuk
 rVdpn6eoVOhdnzXB0jpPRky1tY5IolqoZqEyX6x4JjncEyy2fIxME4nhuvUue1KrLgiz
 uuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902433; x=1787507233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A1pznOV9GW0rbqufDgwjkEClbA5koQWvItVltcogtdc=;
 b=IRlqmfnCpoRjNxkGz9LFhftM75LTfM7DDqV+YYryQAMhnOr115ni11t2SZ/IVcD1vo
 IypeWFy+EyU4+qEZwJTahVFj3KvTr3bSbAOJE7Kzx6WAGA0FCpVc7r/GAJAA6NBCoa3c
 wAEK4TvA22Nd80Y6+yImVtZibexnK6gtOhKvUv6t/aejPZm7OjDpFrBbMWTlIkgZBiPT
 7zGQ6B/h0pF/tMs81k7HkWY8cnhYctQf9dNd95cTioTaGOTBbdnT9mX9ybt8Z9VnJqAG
 a9cTYTqg5NSnP4nmM+z1RoZZE8QGYxRRYay0vn7wh6gGXVrWAxvF+1yZGE6NMdU9Vy3M
 ntUQ==
X-Gm-Message-State: AOJu0Yz7TMdSrWa+6O6SkL0znYT4l5L54VSjTtjbHQs5R4MP9tAoH17e
 8d1gQF62lyMuu7EH+p5+IpE+8za1LPTzb3L52o2u8ocuAtJdKFw6fgiVrrSxSytW
X-Gm-Gg: AR+sD13uqbT4s7AOEoLVHC8OiV9xP9Ds5DrFMw6hjVb1Fua88y671rnHPN3fm8oz3eZ
 vv/17OOm/TFDX08C0RjnGcPkIi3OynBdFePwRz/GIlx2KIbsXliQrAQ/RyaIXgYV5wJSamRaigK
 AX2raXC1cOaOSR2zi+E/pLneT22A0AA+5WBBCTN8nckQkalThAkZERDRTKBRst7HJG7bpDqpTJQ
 mq2btlISOE2cx1RNRVovmySlwlS90UR6GY96gXDHo7aRnjzUcrwkIXgGOyU2SZ1kxKBDd85PN+Z
 trmf1ABzaMEtkSe78ikV+YXdQnJ+RkWTqGnKIMEwYuy5JnQzZv0pvYd1lBV1br5lGyhPXYnp81+
 gF/4GXL3jth7xLtzgWnUt9GEeZLXxP4SemB7psF+/3ncO3ZLN4yuta0VoaFs/H/iGaLQv4kQ/oj
 fZ6xZFciEYfmLNHPYmtIA0fYbLTFt5y7SIv4VoLKMsCeYzqVhvIOd67aqtgudroNBAJyX8hT9wp
 R0Iw7BYQ8iIBcU=
X-Received: by 2002:a05:6a21:7316:b0:3c4:de3:816c with SMTP id
 adf61e73a8af0-3cc71ed56f7mr22457209637.37.1786902433059; 
 Sun, 16 Aug 2026 10:47:13 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:12 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v5 03/11] migration: Rename postcopy_listen_thread_bh
Date: Sun, 16 Aug 2026 23:16:23 +0530
Message-ID: <20260816174631.1547811-4-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename postcopy_listen_thread_bh to postcopy_incoming_complete_bh for a
more robust naming scheme. This will allow fast snapshot load to use
this bh funciton directly to cleanup the incoming state.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/postcopy-ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4b8f882e1e..2e2c9fae10 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2103,7 +2103,7 @@ bool postcopy_is_paused(MigrationStatus status)
         status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
 }
 
-static void postcopy_listen_thread_bh(void *opaque)
+static void postcopy_incoming_complete_bh(void *opaque)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -2211,7 +2211,7 @@ out:
     rcu_unregister_thread();
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
-    migration_bh_schedule(postcopy_listen_thread_bh, NULL);
+    migration_bh_schedule(postcopy_incoming_complete_bh, NULL);
 
     object_unref(OBJECT(migr));
 
-- 
2.55.0


