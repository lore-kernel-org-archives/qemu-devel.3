Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08236D73094
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 15:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w92ui-0002xF-UN; Sat, 04 Apr 2026 11:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w92uh-0002x4-H6
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 11:27:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w92ud-0004dW-FS
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 11:27:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so11102475ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775316469; x=1775921269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VpOPu3N88OLYcGF2nSpup4up/DQqoLUQd3kVQiqld5Q=;
 b=GoPI8NOnSJtbtrfUNw0djthuXTLTiszglM1mnI2s+MpAZEuKs5s2kL0CErPD5/66g9
 55RK/HiDzeYYCvoyXpxe8FVmubcM5YdzrvWMW9wkn5nzRvw9gICM42/32X6xjLFJ0aP+
 kLSnquH0kBe+7fDYuWlqogKjXnvWxHs/KavP+NFxW0DP/txFOe2Hj56pLyPb7INgLrWe
 DQSlNWazXvokBt3uIOrUCHmnYCif1Zhpw63pMyjuWK2s8HbvYqCjwaM98fed3HlJfTzm
 uVohTw0+V2s/fui2Zg05Gzn9/KRMeAJgAcEeNXTW46v/De/yb3stkIRh8GQeK3dD8vui
 vg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316469; x=1775921269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpOPu3N88OLYcGF2nSpup4up/DQqoLUQd3kVQiqld5Q=;
 b=kGtLEgZdxLjJ+n+vSvZBmS8alWWACbgVF97vvc5HrQBrHuIFCe5ycKqTuY37yzlwlA
 jUtlasc/cDqdF3JburkqrCXD+UdOVpqeSjWdDFpwrSLVihf/MW1SUW+7WN+L1e4dDEi5
 pNA0gyr2iNDjxVb53kcOBl7wk1cbI4TQwiZXapUmztsb9B87A8SGj/S8WKyiKEb0JrEy
 yzLuUmF1QrHbJsRK+HkVMvyO7XW9bOm2S3tBXET/76p8FfWlqClAw2KLebRWS9zzyXv+
 y4KUqPHbxTnxjKDTBZfLnH5X6IKkGmLx/VnyNZQedBSeeK8Cd47BXr/GT7QjYhkeDTuc
 Gktg==
X-Gm-Message-State: AOJu0YwzTvhrMdsrvnBaGpaRB4bKZq6ewtZllwcoY8LU6uM8XJ2jYmaG
 dDkpMDk3XKbOn7E+3CDaeOhQLPM82l2esrPrNIAzNxJR6CmUzUndRwk1iVJ+FjwZE2QksQ==
X-Gm-Gg: AeBDiesTVZomR4ncxpgH37xflLiGnRy+tUrkcP5/Vglg5xzo5AWwhSSKf08h6m9OGIf
 jO7oUMeC4ZoeUAsjkJEwgEYWFZj4EX9Hw8OH5iokWEkSzV8fCRGJr/UFTWseV3whUTld8oULdsY
 cPOyrNkv/HmhexNlb/EcEG5j+bxarLqK7b5Vs5iPvhfA+6wU3m4SxxStCMip0Kf5xZCgZ/9IXWs
 S4FYHiKH6tDPAj1WorFncsLnGf7qDIGPZqxFZo1LtmlNfZC762aZzwldZCbE02RqXPt3v9Lu6uN
 fPYnwdgOIAjg7dyggLxP3WNHyxS7gGKzLJwd9uDZHo/HayGkpFaYMynDrfSnF3u0W8WSXb5hKZU
 fNINbiscxWsEc233LbY+yuX145n/h1U/HRDX8JhmnCVoGhNQ/sC4UPR3nByvdJAAZjou/Nd65Ph
 qixXtB9gheXv22IKWdh+2+VvoSnOAmIyCvrcqrBrIOR0ujI4ElYT+mqGM/yw==
X-Received: by 2002:a17:903:183:b0:2b0:5626:f75d with SMTP id
 d9443c01a7336-2b28176974bmr69306335ad.26.1775316469329; 
 Sat, 04 Apr 2026 08:27:49 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6475ae9sm8010120a12.2.2026.04.04.08.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:27:48 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] migration: add optional capabilities field to migrate and
 migrate-incoming
Date: Sat,  4 Apr 2026 22:27:36 +0700
Message-ID: <20260404152736.30190-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x636.google.com
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

From: Trieu Huynh <vikingtc4@gmail.com>

When invoking migration, user must call migrate-set-capabilities as a
separate QMP command before calling migrate or migrate-incoming.

Add an optional 'capabilities' field to both commands. When provided,
the capabilities are applied before the migration starts, in the same
order as a migrate-set-capabilities call would apply them. Existing
callers that do not pass the field are unaffected.

This is particularly useful, eg. for snapshot-load workflows where a
single migrate-incoming call should express the full migration
configuration:

  { "execute": "migrate-incoming",
    "arguments": {
      "uri": "file:/tmp/snapshot",
      "capabilities": [{"capability": "mapped-ram", "state": true}]
    }}

Internal callers (HMP migrate-incoming, vl.c -incoming) pass
has_capabilities=false so their behaviour is unchanged.

Related-to: https://wiki.qemu.org/ToDo/LiveMigration#Allow_QMP_command_%22migrate[_incoming]%22_to_take_capabilities_and_parameters

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/migration-hmp-cmds.c |  4 ++--
 migration/migration.c          | 19 +++++++++++++++++++
 qapi/migration.json            | 12 ++++++++++++
 system/vl.c                    |  3 ++-
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54..32c338103d 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -522,7 +522,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
+    qmp_migrate_incoming(NULL, true, caps, false, NULL, true, false, &err);
     qapi_free_MigrationChannelList(caps);
 
 end:
@@ -829,7 +829,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, true, resume, &err);
+    qmp_migrate(NULL, true, caps, false, NULL, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..eb1a734dd9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1752,6 +1752,8 @@ void migrate_del_blocker(Error **reasonp)
 
 void qmp_migrate_incoming(const char *uri, bool has_channels,
                           MigrationChannelList *channels,
+                          bool has_capabilities,
+                          MigrationCapabilityStatusList *capabilities,
                           bool has_exit_on_error, bool exit_on_error,
                           Error **errp)
 {
@@ -1772,6 +1774,14 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    if (has_capabilities) {
+        qmp_migrate_set_capabilities(capabilities, errp);
+        if (*errp) {
+            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
+            return;
+        }
+    }
+
     mis->exit_on_error =
         has_exit_on_error ? exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
 
@@ -2020,6 +2030,8 @@ static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
 
 void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels,
+                 bool has_capabilities,
+                 MigrationCapabilityStatusList *capabilities,
                  bool has_resume, bool resume, Error **errp)
 {
     MigrationState *s = migrate_get_current();
@@ -2036,6 +2048,13 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
+    if (has_capabilities) {
+        qmp_migrate_set_capabilities(capabilities, errp);
+        if (*errp) {
+            return;
+        }
+    }
+
     if (!migrate_prepare(s, has_resume && resume, errp)) {
         /* Error detected, put into errp */
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..58d934f8fe 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1388,6 +1388,11 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
+# @capabilities: list of migration capabilities to set before
+#     starting the migration.  Equivalent to calling
+#     `migrate-set-capabilities` before `migrate`, but more
+#     convenient.
+#
 # @resume: when set, use the new uri/channels specified to resume
 #     paused postcopy migration.  This flag should only be used if
 #     the previous postcopy migration was interrupted.  The command
@@ -1453,6 +1458,7 @@
 { 'command': 'migrate',
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
+           '*capabilities': ['MigrationCapabilityStatus'],
            '*resume': 'bool' } }
 
 ##
@@ -1467,6 +1473,11 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
+# @capabilities: list of migration capabilities to set before
+#     starting the migration.  Equivalent to calling
+#     `migrate-set-capabilities` before `migrate-incoming`, but more
+#     convenient.
+#
 # @exit-on-error: Exit on incoming migration failure.  Default true.
 #     When set to false, the failure triggers a
 #     :qapi:event:`MIGRATION` event, and error details could be
@@ -1525,6 +1536,7 @@
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
                       '*channels': [ 'MigrationChannel' ],
+                      '*capabilities': ['MigrationCapabilityStatus'],
                       '*exit-on-error': 'bool' } }
 
 ##
diff --git a/system/vl.c b/system/vl.c
index 246623b319..ed569d75e7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2826,7 +2826,8 @@ void qmp_x_exit_preconfig(Error **errp)
                 g_new0(MigrationChannelList, 1);
 
             channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
-            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
+            qmp_migrate_incoming(NULL, true, channels, false, NULL, true,
+                                 true, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.43.0


