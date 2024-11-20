Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754E7D711BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDn9G-0000Ds-Qe; Wed, 20 Nov 2024 11:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDn9F-0000DI-Em
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDn9D-0005RS-Ra
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732118500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J99+4hSVKAmFhVLDQlgc3oplsYx5b7O6dXFRkHtUUlA=;
 b=dOYQvNc3lOJC89J9bTJ21Q+58vbqGNaE+elsiS4cQjiMKsqS3z34THYSdlFRDsO1ZBwsbH
 Jwm+fqnPdaf5/SEvLOVHzHpLUPV7vLjZXwoG/HcZBsW5W9ZC3DOhwDPkguTzm95aO2Bk4G
 J6hkBSAAMqF5MtGmQs3sx3PR7JgfgSg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-zIInjZK_MuOjp-jjvizmKQ-1; Wed, 20 Nov 2024 11:01:38 -0500
X-MC-Unique: zIInjZK_MuOjp-jjvizmKQ-1
X-Mimecast-MFC-AGG-ID: zIInjZK_MuOjp-jjvizmKQ
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83ab434c629so479582139f.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 08:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732118497; x=1732723297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J99+4hSVKAmFhVLDQlgc3oplsYx5b7O6dXFRkHtUUlA=;
 b=LWjwEz2ha6sNwT5Za8pWRpkJXxnBhj+7OR3YdQgSPEsNvksZt6I6comBiztIM20RKn
 r7wtt2/astbAIidAcyCt2vH0bvGP7aD9CEAYEneev7Xv09pbu0UjQsU+493llebBypc0
 wqMU2iUyLJvoJbOigaPjqb40KDqu6LTIaroU9XR0M8WhmlYFsgNzel9aGzWXM1GoIasx
 W3qA157xzHDZCKI5UCKUHpXCoDczh2WHudTJIHGgjEtHNb+b5327pfcSqjNlR4chMdCC
 NJKRoRDbaICnrs6KQe1/OqPwePr8PpBV9p1gIORutZPa+9TqMQ25zsoMX5Aqg4owGr3B
 pFEg==
X-Gm-Message-State: AOJu0YxxDVowqGwP5duRu4SMexk0LmNNXALeLhtA/DrQbDpupVPDHrBW
 tyYt7U55eN1boZUCJoXCgXTj1xYXPryk4D18Tv2WElcd+aPT/pSoP0+LLELwGsVViGnDXgjoqRf
 LGTsnkVNbeJSiFTHIHgNDH+iL547Kj9eZaOf8k5OdIX7tp0jeTjl0OBnR41XaKpfZBkvjFqMYzK
 OI6mnA5Ul9gkbfxZVh3wlsQOdAXjtLHcKWIw==
X-Received: by 2002:a05:6602:342a:b0:83a:71c6:26fb with SMTP id
 ca18e2360f4ac-83eb5fa2915mr460464539f.6.1732118496873; 
 Wed, 20 Nov 2024 08:01:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPXv1Sc+B3CTMYPD4q4HTeA0Mvivg/n4m9B26vc15jrM8XLGtNymRuHz45ib45sTdLUuzpJA==
X-Received: by 2002:a05:6602:342a:b0:83a:71c6:26fb with SMTP id
 ca18e2360f4ac-83eb5fa2915mr460431239f.6.1732118494356; 
 Wed, 20 Nov 2024 08:01:34 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756f2519sm3333028173.148.2024.11.20.08.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 08:01:33 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-stable <qemu-stable@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] migration: Allow pipes to keep working for fd migrations
Date: Wed, 20 Nov 2024 11:01:32 -0500
Message-ID: <20241120160132.3659735-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Libvirt may still use pipes for old file migrations in fd: URI form,
especially when loading old images dumped from Libvirt's compression
algorithms.

In that case, Libvirt needs to compress / uncompress the images on its own
over the migration binary stream, and pipes are passed over to QEMU for
outgoing / incoming migrations in "fd:" URIs.

For future such use case, it should be suggested to use mapped-ram when
saving such VM image.  However there can still be old images that was
compressed in such way, so libvirt needs to be able to load those images,
uncompress them and use the same pipe mechanism to pass that over to QEMU.

It means, even if new file migrations can be gradually moved over to
mapped-ram (after Libvirt start supporting it), Libvirt still needs the
uncompressor for the old images to be able to load like before.

Meanwhile since Libvirt currently exposes the compression capability to
guest images, it may needs its own lifecycle management to move that over
to mapped-ram, maybe can be done after mapped-ram saved the image, however
Dan and PeterK raised concern on temporary double disk space consumption.
I suppose for now the easiest is to enable pipes for both sides of "fd:"
migrations, until all things figured out from Libvirt side on how to move
on.

And for "channels" QMP interface support on "migrate" / "migrate-incoming"
commands, we'll also need to move away from pipe.  But let's leave that for
later too.

So far, still allow pipes to happen like before on both save/load sides,
just like we would allow sockets to pass.

Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Peter Krempa <pkrempa@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Fixes: c55deb860c ("migration: Deprecate fd: for file migration")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index aab5189eac..9bf9be6acb 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -25,6 +25,29 @@
 #include "io/channel-util.h"
 #include "trace.h"
 
+static bool fd_is_pipe(int fd)
+{
+    struct stat statbuf;
+
+    if (fstat(fd, &statbuf) == -1) {
+        return false;
+    }
+
+    return S_ISFIFO(statbuf.st_mode);
+}
+
+static bool migration_fd_valid(int fd)
+{
+    if (fd_is_socket(fd)) {
+        return true;
+    }
+
+    if (fd_is_pipe(fd)) {
+        return true;
+    }
+
+    return false;
+}
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
 {
@@ -34,7 +57,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
-    if (!fd_is_socket(fd)) {
+    if (!migration_fd_valid(fd)) {
         warn_report("fd: migration to a file is deprecated."
                     " Use file: instead.");
     }
@@ -68,7 +91,7 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
-    if (!fd_is_socket(fd)) {
+    if (!migration_fd_valid(fd)) {
         warn_report("fd: migration to a file is deprecated."
                     " Use file: instead.");
     }
-- 
2.45.0


