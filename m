Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DDFC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwS-00067U-Ep; Tue, 14 Jul 2026 10:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwN-00066S-P0
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:56 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwK-0002aY-Mc
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:55 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1027568a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038611; x=1784643411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E28sxMwcOo8i2ZmSpMbygqgIQ2/6HAeSrQI+5niNHCQ=;
 b=Shly7FztIHo7k2sfwt39NvCaB+yd+xASyK8XustaNToWEbhXb+/5XZRy2v7/5/xphu
 6FZ7Lp+aCVd6B9+3fshq97EC72MhXvkhId7KUsJbfCxHiXyZtCIqNkrY+O/P0zCNPxMd
 hQuScVQ/aviC3ME9oz9IzXp2mm6yqHtvxYPdCsTY58rcx+0hpDtKG3tfY40YVCrtUi6F
 vjansiykRxTFlqqjM3ecm71QgREv63VLAPQbMuCUyrK3MbxeYqGNjX0qzjTYMdtoQnDp
 jB2rNTiZETiOGX569yjLs8feJMmex/APNqVq3WJYIuIqEw3rGQ5bU5X/1GC75SVU6PTA
 MY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038611; x=1784643411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E28sxMwcOo8i2ZmSpMbygqgIQ2/6HAeSrQI+5niNHCQ=;
 b=VJ4JLYdLGh2AtUljk8BSDvk7VmVEKYzvLZH9QcxyugtnrWpAcNkEaf2oTezTM6LWAR
 0kLFhNGzZtU94Rqs+6/2ZF2M9aSeuCyZK0a1WgqjJnqPOYpmi/NP479Xc/winbVT2Pro
 fUgel0XCHYm7IbT6wVnH3rPpVhd26WJkdfISryGqVkIcwGcVD/grcz5rDXhN/HUhgHkD
 5TT6IveATnYfcHjfgNTf7ySnwJF8qIZcl1/tssv5Ei9NobrwrrF4PcGpeg9VllcB5M/m
 q5s/2jio0dPs05CUPkvtyXklfCuHShzB6ZLKZOmmoWMSQgYU+3zPUroP4S4kifgs8ZMV
 P/Fw==
X-Gm-Message-State: AOJu0YyMTUwWV5RHjcPzd454b/QsaRe02M1QYMGp5kQMWtTiZ0yb+nH+
 dE3Z4zzLseJOTXzOtgP2TWfhgpwwRrUwoF+pAJwlS4d2+ZXQwbfBWTyZl7bJNj9h
X-Gm-Gg: AfdE7ckdpAQR91iz4r/MFcSC4fsZQ8z45cOuQXI7jItDa81W4HYdlLFFOQ6k9fyO3Rg
 TDAq1qSRmMVeyEO8wotQA/9Z05sGRY00jCyvFmlFaKoa0zE/9Crc5mdz8PuChEXl644SypBr+d8
 32yDNS5yNuNEktAKIzav+Cqct3C3koYR3Nt/c3QWDJ6vGNVrqyOESeXj7cn7VcBGrUhLwx7OEZp
 wJdDGZefYl3GXSfDw08avlaBGoljiQz+PpRvv554aDkXSTwc6MixmWFMA6TkuoVdd9uib9SR5+T
 zSf+If/ohcprTVkV6PyzIL0Vlhn7xftbUxTQ7AzSaO4Hsm6mCuVmOapSTE23sbdDEuS7EXKYb4N
 Dv0YnmUiqkk5BfgEv+a/bdyf3taojZe1XWGDZDB5nXoIRtvfxGklEIcCW/t/OE3k8CwywBrIyvM
 UC2B3yi6frL/lUEHCgdm7WXjntmqcDSn3d8jgfNfRv7w==
X-Received: by 2002:a17:90b:5745:b0:381:149:cf91 with SMTP id
 98e67ed59e1d1-38dc7778d65mr13201235a91.26.1784038611005; 
 Tue, 14 Jul 2026 07:16:51 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:16:50 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 03/11] migration: Rename postcopy_listen_thread_bh
Date: Tue, 14 Jul 2026 19:45:39 +0530
Message-ID: <20260714141547.1268000-4-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102c.google.com
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


