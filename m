Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F47ED73E9B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZxV-00037z-Br; Thu, 29 Jan 2026 16:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZxT-00035p-7b
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:53:47 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZxR-0004FS-54
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:53:46 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 13FD6C01B1;
 Fri, 30 Jan 2026 00:53:41 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b74::1:d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id drrd0G0AjGk0-BLgSv0dS; Fri, 30 Jan 2026 00:53:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769723620;
 bh=4ms1x1k3XuyD5N8SuGsfyhPc5HG6fTidUSgiSLPPWII=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=QmhSM35ZXrsMHepcHsLyp1e37bK2u0frDZ93J9SgvKpUgiIe47hYlDFiy6gZ/ls+t
 4zV60p/dPFfdF5Z6UOPuMPy4jMWw/a+qRZPxkQPpiJpSeQmFnFfqbtMTd0rkDJK2XR
 A9+DkNsJVcflcylosPOQk8kqDOil0PwCP/Q9LQFQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: pierrick.bouvier@linaro.org, eblake@redhat.com, armbru@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH] qapi/net: deprecate TAP fd and vhostfd options
Date: Fri, 30 Jan 2026 00:53:38 +0300
Message-ID: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

They are the same as fds and vhostfds, except they accept only
one fd. Let's deprecate redundant options.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all!

after "[PATCH v2 00/12] net: refactoring and fixes" options fd
and vhostfd becomes redundant, fds and vhostfds may be used instead.

this patch also based on
"[PATCH v6] qapi: net: deprecate vhostforce option", that's why
it's sent separately.

Based-on: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
Based-on: <20251113071711.349651-1-vsementsov@yandex-team.ru>

 docs/about/deprecated.rst | 6 ++++++
 qapi/net.json             | 9 +++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e8ff478583..9010f8ab07 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -451,6 +451,12 @@ TAP ``vhostforce`` (since 11.0)
 The ``vhostforce`` option is redundant with the ``vhost`` option.
 If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
 
+TAP ``fd`` and ``vhostfd`` (since 11.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Use ``fds`` and ``vhostfds`` correspondingly, each set with one fd
+instead of ``fd`` and ``vhsotfd``.
+
 Vhost-user ``vhostforce`` (since 11.0)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/qapi/net.json b/qapi/net.json
index 9a00d578e9..2d5aed3ef8 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -326,8 +326,7 @@
 #
 # @fd: file descriptor of an already opened tap
 #
-# @fds: multiple file descriptors of already opened multiqueue capable
-#     tap
+# @fds: multiple file descriptors of already opened tap
 #
 # @script: script to initialize the interface
 #
@@ -359,13 +358,15 @@
 # Features:
 #
 # @deprecated: Member @vhostforce is deprecated.  Use @vhost instead.
+#     Member @fd is deprecated.  Use @fds instead.
+#     Member @vhostfd is deprecated.  Use @vhostfds instead.
 #
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
   'data': {
     '*ifname':     'str',
-    '*fd':         'str',
+    '*fd':         { 'type': 'str', 'features': [ 'deprecated' ] },
     '*fds':        'str',
     '*script':     'str',
     '*downscript': 'str',
@@ -374,7 +375,7 @@
     '*sndbuf':     'size',
     '*vnet_hdr':   'bool',
     '*vhost':      'bool',
-    '*vhostfd':    'str',
+    '*vhostfd':    { 'type': 'str', 'features': [ 'deprecated' ] },
     '*vhostfds':   'str',
     '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
     '*queues':     'uint32',
-- 
2.52.0


