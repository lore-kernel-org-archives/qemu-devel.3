Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C28DE7716A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcP-00039i-RW; Tue, 03 Dec 2024 19:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcK-000396-Qe
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcI-0005L5-2E
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeSfgc7Jyo9nB/kprDl4lAEUoTylMcAzUPDJAOUL/0Y=;
 b=hdT9J/uyFeQRtXEHGR+DDIvcCJ7239fnKK0GZjXln1emKe5+EimshQTjHx7sUiIc22434N
 gDKReAf7VGooMhyR7DgmBQT63LIXGIA+Hw3cSQ325QxFvxZ0m3/lQQtmjXRwzpb+Yyj9fB
 /V6ijZ8udaouTBwIKq9Gb/pJ4sbHlsc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-bup9oWohPPOAhpAQUte5KA-1; Tue, 03 Dec 2024 19:51:44 -0500
X-MC-Unique: bup9oWohPPOAhpAQUte5KA-1
X-Mimecast-MFC-AGG-ID: bup9oWohPPOAhpAQUte5KA
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b66a5121efso754671785a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273503; x=1733878303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeSfgc7Jyo9nB/kprDl4lAEUoTylMcAzUPDJAOUL/0Y=;
 b=dYrvH2187VRxFsu0VwEu7vxNucHhJDX1RWy/+Hp3y4K25kgGpPu189BlM4cPZd9loV
 Vz2rgKkLN9jzW9q/kmOl4QVdEvye8xMaWLCQ5HlePxbc66H+UUEnPxr4eIgbmjpVkFsV
 OxJj7VT5uszJrDiST9bMQ4JbklaSYFJQgV1no6Fr7IDpCPLJP2K0Fk/5jRTVZwSmD/22
 48FAUIDO0bz22k5WaL/OmzaJCMsTvBmWZTO8DWixsv74AxnP4ywQcyTnk4zIHXIwxg1C
 k6LuFhIxQNxWNVS3OoNJ5Gr/DdVzrIR7PpeFdhUnp38WrxUcN8mED5gi8/92Gg1kahsn
 GKew==
X-Gm-Message-State: AOJu0Yzbc2R2MrhNruuDXfE3kNOCWgMjsAsIjcAcpL1PJQowSS89CmMo
 KDnFz3VQ6E8gYVic38a5EEvei8pwURxm/TabDjsUS3j4RbWxU1kUoRLNkTSUkZ5PjL/6pfj0qYn
 DyvxLE+8aw0wS8GDPIK26YSxsTIDjiEUdJ9+OC9iyKK3LOkhQ03QsreCdBP4OlStXAu1Bgp5RTo
 c7Egg4xR1VGfLW5Vmn2yJG3ZoNErEqUlntcg==
X-Gm-Gg: ASbGncvcf0zv3MFx/KBOmNo8YuPpbOzRqcHk5D79XH8V6maHh4EEYom5i91Voekw78h
 0fV7iiavn3kBQtK2Ysj+BiEukG3qi0GarEACS8k2S5JYckFkcot4PBbBEKeU30nWWvwbUbg8+Fk
 gm61fOVNDFsx0Z/IwYk4zbSrPNaVJc4DJ2HbAr/yb7CyWrskI1hPMYrpu43MRBWBortFjgbjjn1
 /+uixiNpHR+dH2lB1ihE95T3z5U5KlDOK27eYlwBBbK3nONp1tg4t1IwV6o1A1jBsJF4SaWTq6i
 fOmTeTadYtOM47cIpojIeE/IXQ==
X-Received: by 2002:a05:620a:248f:b0:7b6:6add:4a3c with SMTP id
 af79cd13be357-7b6a5d3a035mr624332285a.21.1733273503263; 
 Tue, 03 Dec 2024 16:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcApxcf2wNJvtEwRWGFfA1Km44uCXjtDUDtamN8kBwMkDJRh1L+c+at2kpfbDQBdZ5+y5kjA==
X-Received: by 2002:a05:620a:248f:b0:7b6:6add:4a3c with SMTP id
 af79cd13be357-7b6a5d3a035mr624328885a.21.1733273502774; 
 Tue, 03 Dec 2024 16:51:42 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:42 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 01/11] migration: Add helper to get target runstate
Date: Tue,  3 Dec 2024 19:51:28 -0500
Message-ID: <20241204005138.702289-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

In 99% cases, after QEMU migrates to dest host, it tries to detect the
target VM runstate using global_state_get_runstate().

There's one outlier so far which is Xen that won't send global state.
That's the major reason why global_state_received() check was always there
together with global_state_get_runstate().

However it's utterly confusing why global_state_received() has anything to
do with "let's start VM or not".

Provide a helper to explain it, then we have an unified entry for getting
the target dest QEMU runstate after migration.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..d2a6b939cf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -135,6 +135,21 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
+static RunState migration_get_target_runstate(void)
+{
+    /*
+     * When the global state is not migrated, it means we don't know the
+     * runstate of the src QEMU.  We don't have much choice but assuming
+     * the VM is running.  NOTE: this is pretty rare case, so far only Xen
+     * uses it.
+     */
+    if (!global_state_received()) {
+        return RUN_STATE_RUNNING;
+    }
+
+    return global_state_get_runstate();
+}
+
 static bool transport_supports_multi_channels(MigrationAddress *addr)
 {
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
@@ -735,8 +750,7 @@ static void process_incoming_migration_bh(void *opaque)
      * unless we really are starting the VM.
      */
     if (!migrate_late_block_activate() ||
-         (autostart && (!global_state_received() ||
-            runstate_is_live(global_state_get_runstate())))) {
+        (autostart && runstate_is_live(migration_get_target_runstate()))) {
         /* Make sure all file formats throw away their mutable metadata.
          * If we get an error here, just don't restart the VM yet. */
         bdrv_activate_all(&local_err);
@@ -759,8 +773,7 @@ static void process_incoming_migration_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        runstate_is_live(global_state_get_runstate())) {
+    if (runstate_is_live(migration_get_target_runstate())) {
         if (autostart) {
             vm_start();
         } else {
-- 
2.47.0


