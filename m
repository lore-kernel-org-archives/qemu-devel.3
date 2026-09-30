Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620F8CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrir-0001RI-0z; Wed, 30 Sep 2026 06:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrig-0001II-Nw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0006jH-BV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/ZFiglobtEygR+pSH2umMEJ04yTYt3Ey+a7zaXzn3s=;
 b=J7im94REpeTxmUZVjGHw8T9T4REyIQ3rBxWhCqIwPPJ0OgjbohxwdTBLcfUvg+cPg6yRjh
 vNY0i/LmSpUCu+YBMra4mCwdjO+0CiD0p+0/LuZ6HyL/MSbGIgxFFSDWpxlYr3ZWihSRO8
 PY3RrZkVQwvjbfKWpnMvHmuWqCYfYho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-851SnS5gOaCDtrDpOS970g-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: 851SnS5gOaCDtrDpOS970g-1
X-Mimecast-MFC-AGG-ID: 851SnS5gOaCDtrDpOS970g_1790764759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BD7E195FCFA; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F254118002B1; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E1F0421E6899; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 021/105] qapi: convert trivial intro sections for sockets.json
Date: Wed, 30 Sep 2026 12:37:46 +0200
Message-ID: <20260930103910.3934848-22-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-22-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Straightforward semantic conflict with commit f58893b0b7
(spdm-socket: convert SpdmTransportType to QAPI enum) resolved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/sockets.json | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index a9a8006c22..09d14946ab 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -9,8 +9,7 @@
 
 ##
 # @NetworkAddressFamily:
-#
-# The network address family
+#     The network address family
 #
 # @ipv4: IPV4 family
 #
@@ -41,9 +40,8 @@
 
 ##
 # @InetSocketAddress:
-#
-# Captures a socket address or address range in the Internet
-# namespace.
+#     Captures a socket address or address range in the Internet
+#     namespace.
 #
 # @numeric: true if the host/port are guaranteed to be numeric, false
 #     if name resolution should be attempted.  Defaults to false.
@@ -98,8 +96,8 @@
 
 ##
 # @UnixSocketAddress:
-#
-# Captures a socket address in the local ("Unix socket") namespace.
+#     Captures a socket address in the local ("Unix socket")
+#     namespace.
 #
 # @path: filesystem path to use
 #
@@ -121,8 +119,7 @@
 
 ##
 # @VsockSocketAddress:
-#
-# Captures a socket address in the vsock namespace.
+#     Captures a socket address in the vsock namespace.
 #
 # @cid: unique host identifier
 #
@@ -140,8 +137,7 @@
 
 ##
 # @FdSocketAddress:
-#
-# A file descriptor name or number.
+#     A file descriptor name or number.
 #
 # @str: decimal is for file descriptor number, otherwise it's a file
 #     descriptor name.  Named file descriptors are permitted in
@@ -197,9 +193,8 @@
 
 ##
 # @SocketAddressLegacy:
-#
-# Captures the address of a socket, which could also be a named file
-# descriptor
+#     Captures the address of a socket, which could also be a named
+#     file descriptor
 #
 # @type: Transport type
 #
@@ -219,8 +214,7 @@
 
 ##
 # @SocketAddressType:
-#
-# Available `SocketAddress` types
+#     Available `SocketAddress` types
 #
 # @inet: Internet address
 #
@@ -237,9 +231,8 @@
 
 ##
 # @SocketAddress:
-#
-# Captures the address of a socket, which could also be a socket file
-# descriptor
+#     Captures the address of a socket, which could also be a socket
+#     file descriptor
 #
 # @type: Transport type
 #
@@ -255,8 +248,7 @@
 
 ##
 # @SpdmTransportType:
-#
-# SPDM transport type
+#     SPDM transport type
 #
 # @unspecified: Unspecified transport
 #
-- 
2.55.0


