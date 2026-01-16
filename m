Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0E7D47CAD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgY44-0005zs-Cq; Thu, 15 Jan 2026 19:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3w-0005vx-Kg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:40 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3t-0000qg-SW
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:From:From
 :Subject; bh=spUoSBLxVK/LW2IDytQ4t3d9mqfWBv3rna67/EINeR8=; b=XyDaLURKCHM1x1hb
 6cRA2zfs+ZNObGk85Le7rYxnRvK5zS6oi1BPp0LNfD71Fpe1ZDyacIbDAWzAnMViCoyQcxQL6xL1b
 UnP/rs5qX/Tjggyks9AHkovz6+A1yihYVJdUELqZecoNcZm5CgHf2t4zx9clR39mP6qv1EXmjhv0Q
 8Ue7ESyCm6yR5ATRsoSHw3/1b/QI3BSMGj6HI9/YBUw2cMVBbAoHGrUDGfwGvriQjEQETRpDdneNp
 lf4GH4xFF8PoFPT/G6Z0JyaItVdSy2ifd08G+Ae0r48BgqepV9IKyKtdohYyw/oFPPzDGkyZGS3x4
 ZHXvrvZf61X9krrv7w==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vgY3s-0000000F7wG-0YkN;
 Fri, 16 Jan 2026 00:51:36 +0000
From: dave@treblig.org
To: dave@treblig.org, armbru@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] hmp*hx: Move info docs
Date: Fri, 16 Jan 2026 00:50:46 +0000
Message-ID: <20260116005050.376616-3-dave@treblig.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116005050.376616-1-dave@treblig.org>
References: <20260116005050.376616-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Move the docs for the info subcommand from the separate hx
into the top level file next to the 'info' command itself.
That makes every command in the top level file have a RST section.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
2.52.0


