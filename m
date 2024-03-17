Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54390C54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaN-0002Fs-Uj; Sun, 17 Mar 2024 16:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaK-0002FU-L0
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaJ-0002eB-3o
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/dYvsDyDFOzN5fd9fyhA5B4S0ZtJhXWR0ak14NU83A=;
 b=K6UaqosRW7DFw0IagjLsJYYAEry2PgUEQxlaATD6azyP4rST8GUD3MlZ3SQG3ceZ6nH9tv
 I4yxJ2PFberQ2h4uayJJYIteLOGw6eOLifVMQXkOOLmadvwnjKUfAUj4H97bAySP1IfAQU
 KOfi5+66+kDhyDrHwVpupHAcij0oWYc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-DR4brby5MneDeA9lfEib8g-1; Sun, 17 Mar 2024 16:58:20 -0400
X-MC-Unique: DR4brby5MneDeA9lfEib8g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-430b9ee6bfbso4063311cf.0
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709100; x=1711313900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/dYvsDyDFOzN5fd9fyhA5B4S0ZtJhXWR0ak14NU83A=;
 b=FW1e6+5y/7mwG3S/ylbtWvotXHykbeYc+lJ9B5bDkwh6bnyYOnXLAVkOy63TXnebtb
 zKC7jlv72MvAKMiZNHKJ1bvNfDFPoutB1Lk6gZKNqVtGVWjdMOm7D8gGmgAiGj7sKHsI
 K808/H8dQH82AqSCP+xrr+hWj4gawB1uNxqE5KY/1c4m3FaXDdLkNxxl9Lf+dplLcsWO
 qxK/W5kElvC52plX2yXY/jquAZ3L4jTctDOaw0L0N3bdF0TRhBECHeahrFzL5Gez876t
 +dP0JCjxHQl5AiGY4Vs26aSG089GYx/ZmQLHM6I7jod5apuAZ07Nf85pZMiadFZbENU7
 z+5w==
X-Gm-Message-State: AOJu0YzckwzhV39F/2I1+eedgh0fgJ9kVX3QpZPvJcqo2+j+HT+mBSPM
 bnFMJEm70Yy9PWZ99MhBBis7OcJ/EiTVCqJX4zjnJon4eyRueR3io3v9QlxSEn8Zu2qLHsP5LLV
 C7pKn4e2zRM2z/ajGWoXO+qxPzbm1etnsYeZPuwOXGQetjm8JUdd7Czd4dHOtwZNHNGsn/2gTl2
 r1rTalIx60l2e2CXchkA6yRx7eDnryRsPt+g==
X-Received: by 2002:a05:6214:3d9a:b0:691:456f:415a with SMTP id
 om26-20020a0562143d9a00b00691456f415amr12266806qvb.4.1710709100095; 
 Sun, 17 Mar 2024 13:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHATVsL922WTpVpieM6CBIj9hhmoIIY7wU/do2vt1iq6/Y/zKNh54++8r6oTSjtt+c05el91Q==
X-Received: by 2002:a05:6214:3d9a:b0:691:456f:415a with SMTP id
 om26-20020a0562143d9a00b00691456f415amr12266788qvb.4.1710709099599; 
 Sun, 17 Mar 2024 13:58:19 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:19 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/10] migration/multifd: Duplicate the fd for the outgoing_args
Date: Sun, 17 Mar 2024 16:58:03 -0400
Message-ID: <20240317205803.361163-11-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Fabiano Rosas <farosas@suse.de>

We currently store the file descriptor used during the main outgoing
channel creation to use it again when creating the multifd
channels.

Since this fd is used for the first iochannel, there's risk that the
QIOChannel gets freed and the fd closed while outgoing_args.fd still
has it available. This could lead to an fd-reuse bug.

Duplicate the outgoing_args fd to avoid this issue.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240315032040.7974-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index c07030f715..fe0d096abd 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,8 +49,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
 {
     QIOChannel *ioc;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
-
-    outgoing_args.fd = -1;
+    int newfd;
 
     if (fd == -1) {
         return;
@@ -63,7 +62,17 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
-    outgoing_args.fd = fd;
+    /*
+     * This is dup()ed just to avoid referencing an fd that might
+     * be already closed by the iochannel.
+     */
+    newfd = dup(fd);
+    if (newfd == -1) {
+        error_setg_errno(errp, errno, "Could not dup FD %d", fd);
+        object_unref(ioc);
+        return;
+    }
+    outgoing_args.fd = newfd;
 
     qio_channel_set_name(ioc, "migration-fd-outgoing");
     migration_channel_connect(s, ioc, NULL, NULL);
-- 
2.44.0


