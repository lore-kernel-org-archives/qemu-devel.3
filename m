Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77DFC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkcU-0004Gu-C2; Wed, 19 Aug 2026 14:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcR-0004F8-Gw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:31 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcO-0007N0-Sl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id E6332C08AF;
 Wed, 19 Aug 2026 21:02:25 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id M2bUThDaVKo0-OZ4AJoq1; Wed, 19 Aug 2026 21:02:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787162545;
 bh=DaeKnaftV441pYWOLN5La1ohWjtFSUg301klU0RusmE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oj+z3/PjW1ODxH6tGciuBDi7o3Z5SyApwS6tm19Rv5vY0wwaR6SBuaktOh+L+xff9
 7W+BdHfNd4Vq7SUsHESI3bdpJBwiEuqYq+GXKvR952+sa4dONun7GLBnZF1UhzNltf
 J6ShjaP3JLi5t+hIfO3nG5gPwoWvusp74AaH9W9s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v21 02/16] net/tap: improve script/downscript options
 documentation
Date: Wed, 19 Aug 2026 21:01:45 +0300
Message-ID: <20260819180201.1970193-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Properly document defaults and special values of "" and "no".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 qapi/net.json   | 12 +++++++++---
 qemu-options.hx |  9 +++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c5..8f0915c4d86 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -399,9 +399,15 @@
 # @fds: multiple file descriptors of already opened multiqueue capable
 #     tap
 #
-# @script: script to initialize the interface
-#
-# @downscript: script to shut down the interface
+# @script: script to initialize the interface.  An empty string or
+#     "no" disables script execution.  Defaults to
+#     ``<sysconfdir>/qemu-ifup``, where ``<sysconfdir>`` is the
+#     system configuration directory at build time (typically /etc).
+#
+# @downscript: script to shut down the interface.  An empty string or
+#     "no" disables script execution.  Defaults to
+#     ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the
+#     system configuration directory at build time (typically /etc).
 #
 # @br: bridge name (since 2.8)
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 34970fffc94..200949655ea 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3014,7 +3014,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use network scripts 'file' (default=" DEFAULT_NETWORK_SCRIPT ")\n"
     "                to configure it and 'dfile' (default=" DEFAULT_NETWORK_DOWN_SCRIPT ")\n"
     "                to deconfigure it\n"
-    "                use '[down]script=no' to disable script execution\n"
+    "                use '[down]script=no' or '[down]script=' to disable script execution\n"
     "                use network helper 'helper' (default=" DEFAULT_BRIDGE_HELPER ") to\n"
     "                configure it\n"
     "                use 'fd=h' to connect to an already opened TAP interface\n"
@@ -3550,9 +3550,10 @@ SRST
     Use the network script file to configure it and the network script
     dfile to deconfigure it. If name is not provided, the OS
     automatically provides one. The default network configure script is
-    ``/etc/qemu-ifup`` and the default network deconfigure script is
-    ``/etc/qemu-ifdown``. Use ``script=no`` or ``downscript=no`` to
-    disable script execution.
+    ``<sysconfdir>/qemu-ifup`` and the default network deconfigure script is
+    ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the system
+    configuration directory at build time (typically ``/etc``).
+    Use ``[down]script=no`` or ``[down]script=`` to disable script execution.
 
     If running QEMU as an unprivileged user, use the network helper
     to configure the TAP interface and attach it to the bridge.
-- 
2.43.0


