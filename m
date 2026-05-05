Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22308CD3436
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEzc-0002i6-1b; Tue, 05 May 2026 08:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEzZ-0002fe-Bl
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEzV-0006xM-FS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777984508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LJ/PY35q50uBwYdkhyC+RqHy0XFW7jPX2haUv8L0n0=;
 b=RffTRieXKjsecmkLSQC0/fhge8xptEJg2ng9mAgLvmPkfcU6+5FTYn4ThiWsgydqHmzFuN
 yPT8ifDRnpMSJNh8PU0OYOeJj+jc9p0T75QerfcgJRWcp1yS35nrZhHL/4s1WyppEQwXce
 0Z8vRHR+RL9P1W+EuRXQ8vWB/yDi/xE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ed1qM9csMIKEQ4mL8eWn0A-1; Tue,
 05 May 2026 08:35:06 -0400
X-MC-Unique: ed1qM9csMIKEQ4mL8eWn0A-1
X-Mimecast-MFC-AGG-ID: ed1qM9csMIKEQ4mL8eWn0A_1777984505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8439E18005A9; Tue,  5 May 2026 12:35:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 165AD196B09E; Tue,  5 May 2026 12:35:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C51921E6A02; Tue, 05 May 2026 14:35:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/4] hmp*hx: Move info docs
Date: Tue,  5 May 2026 14:34:59 +0200
Message-ID: <20260505123502.1316554-2-armbru@redhat.com>
In-Reply-To: <20260505123502.1316554-1-armbru@redhat.com>
References: <20260505123502.1316554-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Move the docs for the info subcommand from the separate hx
into the top level file next to the 'info' command itself.
That makes every command in the top level file have a RST section.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260504174914.122607-2-dave@treblig.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx |  9 +--------
 hmp-commands.hx      | 27 +++++++++++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e..964eed004c 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -8,14 +8,7 @@ HXCOMM
 HXCOMM In this file, generally SRST fragments should have two extra
 HXCOMM spaces of indent, so that the documentation list item for "info foo"
 HXCOMM appears inside the documentation list item for the top level
-HXCOMM "info" documentation entry. The exception is the first SRST
-HXCOMM fragment that defines that top level entry.
-
-SRST
-``info`` *subcommand*
-  Show various information about the system state.
-
-ERST
+HXCOMM "info" documentation entry.
 
     {
         .name       = "version",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12..f4a6eeda93 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1814,16 +1814,6 @@ SRST
   command.
 ERST
 
-    {
-        .name       = "info",
-        .args_type  = "item:s?",
-        .params     = "[subcommand]",
-        .help       = "show various information about the system state",
-        .cmd        = hmp_info_help,
-        .sub_table  = hmp_info_cmds,
-        .flags      = "p",
-    },
-
 #if defined(CONFIG_FDT)
     {
         .name       = "dumpdtb",
@@ -1867,3 +1857,20 @@ SRST
   List event channels in the guest
 ERST
 #endif
+
+HXCOMM *** MUST BE LAST ENTRY **
+    {
+        .name       = "info",
+        .args_type  = "item:s?",
+        .params     = "[subcommand]",
+        .help       = "show various information about the system state",
+        .cmd        = hmp_info_help,
+        .sub_table  = hmp_info_cmds,
+        .flags      = "p",
+    },
+
+SRST
+``info`` *subcommand*
+  Show various information about the system state.
+ERST
+HXCOMM *** MUST BE LAST ENTRY **
-- 
2.54.0


