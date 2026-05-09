Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBBACD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlJ0-000204-Db; Sat, 09 May 2026 13:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIw-0001qE-OS
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIu-0005YF-TW
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778347047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4Slxdzy3hL0v2brTM0N78PBrN0bU27hlHRoj2ilZ3M=;
 b=Wp3CNmNIBcuK8HLWuqa9w5ekFMVppKCaRTbrDw2X6UYexpjhRY3VNvmZQ0eT6CJ6Vf/Ruc
 FEP81n4QxJv6zPXzTY+0X33pzPVgJj1bfk9DXGIM8R29rSPeS/m4vraSjqZLIQrLKBjbRg
 su83dwdUfP0nVBLlkzCGB0VWKrqSMr4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-sEyC3KEeONuqXR9QBMC2wQ-1; Sat,
 09 May 2026 13:17:23 -0400
X-MC-Unique: sEyC3KEeONuqXR9QBMC2wQ-1
X-Mimecast-MFC-AGG-ID: sEyC3KEeONuqXR9QBMC2wQ_1778347042
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0EBF195608C; Sat,  9 May 2026 17:17:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 496F21800352; Sat,  9 May 2026 17:17:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	uchouT <i@uchout.moe>
Subject: [PULL v2 33/33] qemu-options: document -chardev dbus
Date: Sat,  9 May 2026 21:13:54 +0400
Message-ID: <20260509171356.1157879-34-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: uchouT <i@uchout.moe>

Document the dbus backend introduced in commit 3e301c8d7ef0 ("ui/dbus:
add chardev backend & interface")

Signed-off-by: uchouT <i@uchout.moe>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260509094801.111103-1-i@uchout.moe>
---
 qemu-options.hx | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5387bcd751b..96ae41f787b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4077,6 +4077,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
 #if defined(CONFIG_SPICE)
     "-chardev spicevmc,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
     "-chardev spiceport,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
+#endif
+#if defined(CONFIG_DBUS_DISPLAY)
+    "-chardev dbus,id=id,name=name[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
 #endif
     , QEMU_ARCH_ALL
 )
@@ -4088,8 +4091,8 @@ The general form of a character device option is:
     Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``hub``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
-    ``spicevmc``, ``spiceport``. The specific backend will determine the
-    applicable options.
+    ``spicevmc``, ``spiceport``, ``dbus``. The specific backend will
+    determine the applicable options.
 
     Use ``-chardev help`` to print all available chardev backend types.
 
@@ -4408,6 +4411,15 @@ The available backends are:
 
     Connect to a spice port, allowing a Spice client to handle the
     traffic identified by a name (preferably a fqdn).
+
+``-chardev dbus,id=id,name=name``
+    ``dbus`` is only available when D-Bus display support is built in.
+
+    ``name`` name of the chardev as exported on the D-Bus display
+    interface
+
+    Export the character device on the D-Bus display interface, so that
+    a D-Bus client can connect to it.
 ERST
 
 DEFHEADING()
-- 
2.54.0


