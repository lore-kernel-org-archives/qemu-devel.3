Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7782DCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTw-0002wI-Ug; Wed, 22 Oct 2025 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTn-0002ts-VI
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTl-0001aI-En
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOhkWGBswSimZhnhemfbMKnjzI+fXszEQjpRE4VPOI8=;
 b=JuM+ERecdkS0QW+QzwIXV0lOc00K6/x6vKJG510pl3sX3Homa08llm8TCY2OoFBxHgjZHe
 jyRXHFvolcVtoE/iJQtpDpPoywSr/Ek+WvyUoKdS3alRr4UhfY2BI2t1ziWuoipQI9/6Mx
 i6NvL3RAYd0WfqdcznQfY/63KNuwDmg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-drhglUVyPgO_8hWNbnXhiA-1; Wed, 22 Oct 2025 15:26:35 -0400
X-MC-Unique: drhglUVyPgO_8hWNbnXhiA-1
X-Mimecast-MFC-AGG-ID: drhglUVyPgO_8hWNbnXhiA_1761161194
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e89265668fso42320391cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161194; x=1761765994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOhkWGBswSimZhnhemfbMKnjzI+fXszEQjpRE4VPOI8=;
 b=lA3gOllVn2hvdkUqWUUFFpRlMvSU0E1wJdboZaEevhiA1uULr1sEmksC8kjfY4a1f+
 Vgub1XvikKM17xyNhcKnX5wJzsvz+4WabHRDJkdnRR6xjh2cnKu2ff/Z6OhzOX+GD64C
 /E2xqZycpEwTW0z6dTeLZBsSE9bbdv+I1ylnvpC7/Mib4P5Xr3dq0GPcJzQfYf8KEKwy
 olWsIqkivICNogRiver4HXtHovqc6lzeS/t2PWoNp8j1cxhbEbFaxjMkboI9iPSC8yU9
 bLLKXB3ztGbCNVbazytwrxlEXqGgHkWPX45h9CsXl3FzqnuHzAYw5XKaALKYlCUCNooF
 v+8Q==
X-Gm-Message-State: AOJu0YyS6UFXmpk1PQKYJt2Wpao83lmhs1MBLoRWhV+vfzQ4a6/anS0/
 Yk48MIDcj0uuNoenF8zI0ZAjb9Uu2t8fy8hDlc7p4EsCoNaiLPBigYla3M0dxOTdNjiIK5wzwwn
 Q5H7AM0oOrBTMHV4MwdqSH0lcgT3814aZkyDP447UFnkI3MB01ftZu6u5lfrrSaGz9kZeAwKAMq
 uZAg7iflN7YiCjbcch0AxmvwEy6pSMRjVCb803zg==
X-Gm-Gg: ASbGncvV7+YMqejpUJsFqk//4Hcq1X/I2YFZJJ39c7sGyZ1nO5VEPMFllzeDuhZ2sMq
 iY0BuztrA1DOB28rhDOgRRHBPfOLzSzVa92v5xuNjT5rkXDADqCmmCqO7Ue1lp8TirqcVD1pO54
 Ek4rgAwgYXaFW88mNiLw41kOcl0y4Pd/Mm3V/3higKQbXT1qZtmeYgCwYEOKjHvg6Ga5XytOeU2
 wSDY9o9sNbT1H+D0GNwamKoy8lmOgTfXJNLmFagPMRpM6AsZsBbPFd51wEAKniZlwgJtHWFjxbh
 5RkjUabf0pQ8/BCGkNhbquEzijZM7KZknb56sJ67CA9qBOmg7R2oFa6cahmhjBRf
X-Received: by 2002:ac8:5ac6:0:b0:4de:cb90:dbe4 with SMTP id
 d75a77b69052e-4e89d393b93mr287185051cf.66.1761161194054; 
 Wed, 22 Oct 2025 12:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ8zZNeARO/JM75anJs6i/kTg4x4XiXSoJyeRTsYAiP17yDsWdwepbnJDPz65oJf4yguXO9g==
X-Received: by 2002:ac8:5ac6:0:b0:4de:cb90:dbe4 with SMTP id
 d75a77b69052e-4e89d393b93mr287184651cf.66.1761161193521; 
 Wed, 22 Oct 2025 12:26:33 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 11/13] migration/ram: Remove workaround on ram yield during
 load
Date: Wed, 22 Oct 2025 15:26:10 -0400
Message-ID: <20251022192612.2737648-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts e65cec5e5d97927d22b39167d3e8edeffc771788.

RAM load path had a hack in the past explicitly yield the thread to the
main coroutine when RAM load spinning in a tight loop.  Not needed now
because precopy RAM load now happens without the main thread.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..16e81cf3bb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4304,7 +4304,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
 static int ram_load_precopy(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    int flags = 0, ret = 0, invalid_flags = 0, i = 0;
+    int flags = 0, ret = 0, invalid_flags = 0;
 
     if (migrate_mapped_ram()) {
         invalid_flags |= (RAM_SAVE_FLAG_HOOK | RAM_SAVE_FLAG_MULTIFD_FLUSH |
@@ -4317,17 +4317,6 @@ static int ram_load_precopy(QEMUFile *f)
         void *host = NULL, *host_bak = NULL;
         uint8_t ch;
 
-        /*
-         * Yield periodically to let main loop run, but an iteration of
-         * the main loop is expensive, so do it each some iterations
-         */
-        if ((i & 32767) == 0 && qemu_in_coroutine()) {
-            aio_co_schedule(qemu_get_current_aio_context(),
-                            qemu_coroutine_self());
-            qemu_coroutine_yield();
-        }
-        i++;
-
         addr = qemu_get_be64(f);
         ret = qemu_file_get_error(f);
         if (ret) {
-- 
2.50.1


