Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C3FCA1000
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut5ML-0002Dr-Vh; Mon, 01 Sep 2025 10:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut5MJ-0002DJ-56
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:18:11 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut5MF-0001yU-V4
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:18:10 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 901A4804C5;
 Mon, 01 Sep 2025 17:18:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:12c::1:9])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1Ifwtq2GlKo0-LgxGJxPS; Mon, 01 Sep 2025 17:18:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756736282;
 bh=Ow82EWlVYgwdIHF1kxgvdD9Wsxb67PKuMf+TI/P+Gso=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=YhlNjSS2ldGgh/Ubv+HoFxFyE4gFvHi2zQ0M8z7pnXc1rGH5C92aFRABArILz5MDg
 rVzMAUYBsLeH8feBp1tvrC7MGA7E8unVtjzCT8g08XEjUY56VFHqBP1AcVvEReala1
 tT0zG++9H4aBonYhyIq/YURRoDPvwNUpCdotvQJE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, armbru@redhat.com,
 eblake@redhat.com, devel@lists.libvirt.org
Subject: [PATCH v2] qapi: net/tap: deprecate vhostforce option
Date: Mon,  1 Sep 2025 17:17:58 +0300
Message-ID: <20250901141758.55605-1-vsementsov@yandex-team.ru>
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

This option doesn't make sense since long ago (10 years!)
commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").

Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
(that don't have MSI-X support), you should have set vhostforce=on
(with vhost=on or unset).

Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
for vhost-enabling options logic.

The current logic is:
  vhost=on / vhost=off : vhostforce ignored, doesn't make sense
  vhost unset : vhostforce counts, enabling vhost

Currently you may enable vhost several ways:
- vhost=on
- vhostforce=on
- vhost=on + vhostforce=on
- and even vhost=on + vhostforce=off

- they are all equal.

Let's finally deprecate the extra option.

Also, fix @vhostforce documentation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v2:
- improve wording
- add documentation fix

 docs/about/deprecated.rst |  7 +++++++
 qapi/net.json             | 11 +++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d50645a071..b17a5a41aa 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
 The ``reconnect`` option only allows specifying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
+TAP ``vhostforce`` (since 10.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``vhostforce`` option is redundant with the ``vhost`` option.
+If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
+
+
 VFIO device options
 '''''''''''''''''''
 
diff --git a/qapi/net.json b/qapi/net.json
index 78bcc9871e..e89c7aff5f 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -346,13 +346,20 @@
 # @vhostfds: file descriptors of multiple already opened vhost net
 #     devices
 #
-# @vhostforce: vhost on for non-MSIX virtio guests
+# @vhostforce: enable vhost-net network accelerator. Ignored when
+#    @vhost is set.
 #
 # @queues: number of queues to be created for multiqueue capable tap
 #
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# Features:
+#
+# @deprecated: Member @vhostforce is deprecated.  The @vhostforce
+#    option is redundant with the @vhost option. If they conflict,
+#    @vhost takes precedence.  Just use @vhost.
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -369,7 +376,7 @@
     '*vhost':      'bool',
     '*vhostfd':    'str',
     '*vhostfds':   'str',
-    '*vhostforce': 'bool',
+    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
     '*queues':     'uint32',
     '*poll-us':    'uint32'} }
 
-- 
2.48.1


