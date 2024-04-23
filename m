Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AF6C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnH-0002Ea-GD; Tue, 23 Apr 2024 18:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmi-0001UN-Ou
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmg-0006Ac-L2
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCdbk5570UvGKKfaVuO6SV7Ja4R5/Hc/ClE/x/VJt8U=;
 b=UJ5eF47MoNSAw4uYe4xcCjgF0Sdsrom7vyXUT6CVWwO17kXTb1xL/7ZC32tJitQwMJ4QYA
 akN6A5dBIVZQfdlm9ffeTt7qGWxDWGsuwuDAjLwXVhGpZ+z6NIezCXbgfAj1DBnDR9B/U/
 t+rdos7THLxDOXV19fdUUAn9BhsmSF8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-LlfpCsDDMuS0a5lpggJlKg-1; Tue, 23 Apr 2024 18:38:40 -0400
X-MC-Unique: LlfpCsDDMuS0a5lpggJlKg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-437972269edso20721451cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911920; x=1714516720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCdbk5570UvGKKfaVuO6SV7Ja4R5/Hc/ClE/x/VJt8U=;
 b=V8S1ElUy46hk6Go7cQ6U+lYt/T8m9bbli8edLci/4AL0/jcbXNbf0vE2FGjsdfJOh8
 MdgWZ8dqYKSc54gk3W+c0fYJi2hXIX6up71ul0rFO61vJiPNQzUTxGVURgJld0YpITrL
 3bCc/ak3Y0yBJcH8EVWdbVwFVs414w6Yq39o2o+PDBls/aubZBsmYv6iljrMYj9le0O/
 b7pR8a1QNPVaH7l5Q3oLR1O6psNQviP1TfpcwbSzF2mbH7dMvl87jvOh2x2QZfS0y0c7
 bT0nLJ54GW3SNxRc9k3SP2jGCwGOA3ud8ok26C1M9wwvT66culGuBkTGlf0AmzJ5cWWq
 4yFA==
X-Gm-Message-State: AOJu0YxDMye1Ze8PhCGkA+xNQrassBNE9dLTleo9NfvD8iANEeK/or63
 FekFvRqXXBTJGSYc8/xGs5YZ6Hb1cEmDqrgsWJXp3/iKOC9G1uOjfIJQq1THVGbVwHdXZnOXvQb
 qOGuHKq9GDdVH2baPlPoP897iKNzZn8uLZifG2qvgzBmS/6qAWvAuml37qLZXbt6+MoWQo5997T
 Y8TP00B12oEvCqnLlfiQAc/I8NK1PiTL95jw==
X-Received: by 2002:a05:620a:4010:b0:790:731d:f6c9 with SMTP id
 h16-20020a05620a401000b00790731df6c9mr898831qko.6.1713911919582; 
 Tue, 23 Apr 2024 15:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL5aOkZHTmQz2C5QrXxL7CawgdwIlWJT9RnpUMW03sb7D3QPar8gRdD7ueRa9EpLL5CdH7kg==
X-Received: by 2002:a05:620a:4010:b0:790:731d:f6c9 with SMTP id
 h16-20020a05620a401000b00790731df6c9mr898807qko.6.1713911918836; 
 Tue, 23 Apr 2024 15:38:38 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/26] migration: Introduce ram_bitmaps_destroy()
Date: Tue, 23 Apr 2024 18:38:06 -0400
Message-ID: <20240423223813.3237060-20-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

We will use it in ram_init_bitmaps() to clear the allocated bitmaps when
support for error reporting is added to memory_global_dirty_log_start().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240320064911.545001-11-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4cd4f0158c..f0bd71438a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2438,10 +2438,23 @@ static void xbzrle_cleanup(void)
     XBZRLE_cache_unlock();
 }
 
+static void ram_bitmaps_destroy(void)
+{
+    RAMBlock *block;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+        g_free(block->clear_bmap);
+        block->clear_bmap = NULL;
+        g_free(block->bmap);
+        block->bmap = NULL;
+        g_free(block->file_bmap);
+        block->file_bmap = NULL;
+    }
+}
+
 static void ram_save_cleanup(void *opaque)
 {
     RAMState **rsp = opaque;
-    RAMBlock *block;
 
     /* We don't use dirty log with background snapshots */
     if (!migrate_background_snapshot()) {
@@ -2458,12 +2471,7 @@ static void ram_save_cleanup(void *opaque)
         }
     }
 
-    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        g_free(block->clear_bmap);
-        block->clear_bmap = NULL;
-        g_free(block->bmap);
-        block->bmap = NULL;
-    }
+    ram_bitmaps_destroy();
 
     xbzrle_cleanup();
     compress_threads_save_cleanup();
-- 
2.44.0


