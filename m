Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95299CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNFw-0006pa-In; Wed, 27 Aug 2025 17:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFj-0006lU-IW
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFf-0006t9-E4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRJ8eE7rheNIp6zO98qNHCY36RqYoQUzbq48qUhyxQg=;
 b=D/oFLSpOuK0Au5IwunR9Od9jfPe4h7/uEBbvGmoplw3MsEgGf8/QCfqWL39P5hukECVqGm
 VfDQ50ShQJ4mrYXnXSUTGlCGOYdnA4I+021s/amFyeWNo7nrkCwmW8k0Q0ITXxV0j/LOqm
 5oaNG9G3KIkHbreo2zVESyPGVA821/A=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78--hpwgCisOE6M8iAoK7lvUA-1; Wed, 27 Aug 2025 17:00:12 -0400
X-MC-Unique: -hpwgCisOE6M8iAoK7lvUA-1
X-Mimecast-MFC-AGG-ID: -hpwgCisOE6M8iAoK7lvUA_1756328408
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e96c3f851dcso270659276.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328408; x=1756933208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRJ8eE7rheNIp6zO98qNHCY36RqYoQUzbq48qUhyxQg=;
 b=ASk7wfKrfkjG14FxnR6g/WOfhP8SemtWT0sFm25KwGECFanC5cGDYIZ3tU3MDZd0PD
 G4FAc2wcfMlQGn7gcr1fgUX19kCj1X/MKRVt7gRqEOLtX4uV4ioBlHaLyPy6wTOU3w/8
 nH1dUmYwblFEMP5HwLeV60xRN6cBXqv8114X2mwPzU+7JCRIsZ3KpL6kUkEmsKHc4wzq
 qHP7SYlAH7YLAymXKBHo/eXb8jlLVFfhsSgjxFCmpJpYAQ9T2sg9VtUBcUEGwP+EOu0U
 +QA1sw9G2/vDheAwuoM6y3mLOGg2/QSmNpbrnhnQu4lD7W3xGClVO7wqptirLoZFOMtm
 XXEA==
X-Gm-Message-State: AOJu0Yy0N8Lnx2jP+wF8s6qtCaK8bsVh5aHkq8IFSDUHG1nu7bKriDeE
 nddBbIM2yDtZDcimhIMXxxcOtSF8g1H3q/NMyEYZfrY38sO3zyxtaKkFiPRBTq/xQk+7ItgftZO
 5cqjI+R58u0zf4cJA1Nw4guofnSRzl1PgdvpE47Ac7FfNDFV1LLIqmNGIKeeZV2dEz6byzkRr+x
 JoLauzu6Te0dOv1G7cVw+83HZbPrM+qopb27Li/Q==
X-Gm-Gg: ASbGncvi92rOBNhZXezqpP2kNZh2Rtekq16atQtntg8KPZQqKdeKZ5jVLd/p2yXbDJ5
 J9NJ3imh1T+v4p0+2/QZoF9Vx3Z9OoFohE0+sDbnRf09FAALjVjFkiWm/0g/reEZvehjRu/NVai
 XnA7wsHniQSE38rECx9Z+TlUSFRuh626lVfTY6Xtz5aWygGYmKWtuE4KPMdLaSWOozAsvihxz4O
 R7NczVl/xXD5I3XCpVhGSAhGgyGEbmD9pR01ZziRwSRIBe7S/VVt/RHcVUfLFBeofNXL9WmL/rG
 StMtIg2QuiUGTJjUkUHsIc3KQST7/sqYhj64cEjiRarsl/AjFNtWWmfABxTpAQOSfW2EhmVXCCp
 BSnSQv7IArXMhYJh3P3A=
X-Received: by 2002:a05:6902:1249:b0:e95:3d8c:f10e with SMTP id
 3f1490d57ef6-e953d8cf2a4mr14597214276.13.1756328407709; 
 Wed, 27 Aug 2025 14:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7gYZeSf/0Wf68bolNu0vksd3GOyhSqE61MyVfEdSnmecJOe2S3VaqtQjKAUOLLVKbkU3+/A==
X-Received: by 2002:a05:6902:1249:b0:e95:3d8c:f10e with SMTP id
 3f1490d57ef6-e953d8cf2a4mr14597146276.13.1756328407102; 
 Wed, 27 Aug 2025 14:00:07 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.14.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 14:00:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 8/9] migration/ram: Remove workaround on ram yield during
 load
Date: Wed, 27 Aug 2025 16:59:47 -0400
Message-ID: <20250827205949.364606-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7208bc114f..2d9a6d1095 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4168,7 +4168,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
 static int ram_load_precopy(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    int flags = 0, ret = 0, invalid_flags = 0, i = 0;
+    int flags = 0, ret = 0, invalid_flags = 0;
 
     if (migrate_mapped_ram()) {
         invalid_flags |= (RAM_SAVE_FLAG_HOOK | RAM_SAVE_FLAG_MULTIFD_FLUSH |
@@ -4181,17 +4181,6 @@ static int ram_load_precopy(QEMUFile *f)
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


