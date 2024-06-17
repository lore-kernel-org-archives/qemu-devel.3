Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEB2C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGtm-0000QM-7a; Mon, 17 Jun 2024 14:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtZ-0000Dk-Mt
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtV-0006IQ-F2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p42qzqR5kciw8JLdqJ1YJNv4+ai0V2jb43gqFLRGij4=;
 b=D48H8++VplGVlteZvH3M+ijbJEc7XPgGZcw7EuI/aRfZV571H6MWdppY7Lh7X52GWJwLDm
 lxXeIL54EZWBlyyKiBAe94Reya3NfVx/wNY7K58be5k8fxivSnDOeVRUgTuYeWIoAloSKV
 4kDDllkmJUYz40oNxXML4k5VHsyLrS0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-arLO_fd-Pm-z-W4mYy-scQ-1; Mon, 17 Jun 2024 14:15:46 -0400
X-MC-Unique: arLO_fd-Pm-z-W4mYy-scQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b29f2d8cf3so11752816d6.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648145; x=1719252945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p42qzqR5kciw8JLdqJ1YJNv4+ai0V2jb43gqFLRGij4=;
 b=ddOf4ffHs3GOyP3sIzG9sCGmWwWTUfSl7Xfwr3GfsEQrvJzLQndF3mVXSNcjzTL3+3
 wVF5JG+IyV3b98nOpxBOWEA4W/YXWvFWRfMQs4bT9KdQMciUBOxeQCvKoDe3ES34yG5U
 2o0Wh8ocWxHVKz5XElKc9ZpNzlll/V432DUJlgDBq0Rf4FrhbIrlkgcdRB5qvw81eg/6
 y5ICx4SLQWchy+v5OrSbiJmfoIOlj4STaRk4sRwAYbhMYcWZ+k5/Cr+3xx0LOcCfoXse
 MAD2rFGL+awCdfwSRFCbz/4i3bOPcxfDojO4jd0jmuNo6Y9XE+kN+x4EOGVdYZunyS9c
 cV/Q==
X-Gm-Message-State: AOJu0YwNFq7p2lGTwysKeaF4Eqi+KWnk5KgVwCY+gWaTa7YXVX+oVtMK
 H2oE84AnT++GwFnltDzb8+bQEM+ffVlOLZwVyHa3QuElcAndbKCLCO/nT8XdFX++soTMry1A2Y/
 qfZG7EFUfgTk5EC3DFG2v2lopIycPQVKn6Ff7Ma+2PQjyM3g6v3LF40/VIVY9+hhypKGsr54Fmv
 l46D6RgldsFxSV4dZefyFKeyuL/i2JDInPCw==
X-Received: by 2002:a05:620a:2b85:b0:798:cf0f:b523 with SMTP id
 af79cd13be357-798d23c4660mr1304576085a.2.1718648144890; 
 Mon, 17 Jun 2024 11:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYn2ssArX0+Ktm0J1BKUoHy0VUXD62Zc3f3EcClrd9yoX/KpzHPw+oip+dGMS/s1RDQiPwaA==
X-Received: by 2002:a05:620a:2b85:b0:798:cf0f:b523 with SMTP id
 af79cd13be357-798d23c4660mr1304572285a.2.1718648144270; 
 Mon, 17 Jun 2024 11:15:44 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 04/10] migration: Cleanup incoming migration setup state
 change
Date: Mon, 17 Jun 2024 14:15:28 -0400
Message-ID: <20240617181534.1425179-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Destination QEMU can setup incoming ports for two purposes: either a fresh
new incoming migration, in which QEMU will switch to SETUP for channel
establishment, or a paused postcopy migration, in which QEMU will stay in
POSTCOPY_PAUSED until kicking off the RECOVER phase.

Now the state machine worked on dest node for the latter, only because
migrate_set_state() implicitly will become a noop if the current state
check failed.  It wasn't clear at all.

Clean it up by providing a helper migration_incoming_state_setup() doing
proper checks over current status.  Postcopy-paused will be explicitly
checked now, and then we can bail out for unknown states.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 75c9d80e8e..59442181a1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -595,6 +595,29 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
     return true;
 }
 
+static bool
+migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
+{
+    MigrationStatus current = mis->state;
+
+    if (current == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        /*
+         * Incoming postcopy migration will stay in PAUSED state even if
+         * reconnection happened.
+         */
+        return true;
+    }
+
+    if (current != MIGRATION_STATUS_NONE) {
+        error_setg(errp, "Illegal migration incoming state: %s",
+                   MigrationStatus_str(current));
+        return false;
+    }
+
+    migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
@@ -633,8 +656,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
-                      MIGRATION_STATUS_SETUP);
+    if (!migration_incoming_state_setup(mis, errp)) {
+        return;
+    }
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
-- 
2.45.0


