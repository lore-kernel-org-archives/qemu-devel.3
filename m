Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848BCCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGy-0007vK-Ho; Sat, 30 Aug 2025 11:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1urycs-0008W6-73
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:54:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1urycp-0006WW-AH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:54:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4316680EB0;
 Fri, 29 Aug 2025 15:54:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a45::1:13])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VsaNvi1Gs0U0-5Bb0ybcf; Fri, 29 Aug 2025 15:54:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756472072;
 bh=fSURjKxp8aN/QzOarNoSx4w8f8QS2PoH+Lpg9ZtltA8=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=goUAaQ1iIC5L7M4+R25uxXDH6qKhR/BqOu0SZJVGG+OyZJe5yYugQSj0wveh8azwf
 6C1fGZ4I0VG48NeTPoeFN3T/E6UHJRj2lAMqGO2ZNPGIwmEqVrlztc41wM6D5vErUk
 RXf+cDVbItgE4esMbnDHWj1hhNTIaip1FVj6ewTg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, armbru@redhat.com,
 eblake@redhat.com, devel@lists.libvirt.org
Subject: [PATCH] qapi: net/tap: deprecate vhostforce option
Date: Fri, 29 Aug 2025 15:54:29 +0300
Message-ID: <20250829125429.795595-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

This option simply duplicates the @vhost option since long ago
(10 years!)
commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").
Let's finally deprecate it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/about/deprecated.rst | 7 +++++++
 qapi/net.json             | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d50645a071..d14cb37480 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
 The ``reconnect`` option only allows specifying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
+TAP ``vhostforce`` (since 10.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``vhostforce`` option just duplicates the main ``vhost`` option.
+Use ``vhost`` alone.
+
+
 VFIO device options
 '''''''''''''''''''
 
diff --git a/qapi/net.json b/qapi/net.json
index 78bcc9871e..d1216bb60a 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -353,6 +353,10 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# Features:
+#
+# @deprecated: Member @vhostforce is deprecated.  Simply use @vhost.
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -369,7 +373,7 @@
     '*vhost':      'bool',
     '*vhostfd':    'str',
     '*vhostfds':   'str',
-    '*vhostforce': 'bool',
+    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
     '*queues':     'uint32',
     '*poll-us':    'uint32'} }
 
-- 
2.48.1


