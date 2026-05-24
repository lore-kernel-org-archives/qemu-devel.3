Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F1CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR93C-0004q7-9j; Sun, 24 May 2026 09:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3Mb-0008NZ-Ao
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:09 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3MZ-0002Pp-NQ
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:09 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 844D020202A5; Sun, 24 May 2026 16:35:05 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/5] qemu-options: document keep-alive*/numeric/mptcp for
 -incoming tcp:
Date: Sun, 24 May 2026 16:34:40 +0900
Message-ID: <20260524073442.435408-4-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
References: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at oss.nttdata.com
X-Virus-Status: Clean
Received-SPF: pass client-ip=49.212.34.109;
 envelope-from=Mitsuru.Kariya@oss.nttdata.com; helo=oss.nttdata.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 24 May 2026 09:39:19 -0400
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

-incoming tcp: and migrate tcp: parse their URIs through
socket_parse() -> inet_parse(), which uses the inet_opts QemuOptsList
(util/qemu-sockets.c).  That table has long accepted numeric, keep-alive
and (when supported by the host) keep-alive-count, keep-alive-idle,
keep-alive-interval and mptcp, but the -incoming synopsis only listed
to/ipv4/ipv6.

List the other accepted options too, so the documentation matches what
the parser actually supports.

Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7432b77571..d2b816e16f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5365,7 +5365,7 @@ SRST
 ERST
 
 DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
-    "-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]\n" \
+    "-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]\n" \
     "-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]\n" \
     "-incoming unix:socketpath\n" \
     "                prepare for incoming migration, listen on\n" \
@@ -5387,7 +5387,7 @@ migration channel types.  The channel type is specified in <channel>,
 or is 'main' for all other forms of -incoming.  If multiple -incoming
 options are specified for a channel type, the last one takes precedence.
 
-``-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]``
+``-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]``
   \ 
 ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
     Prepare for incoming migration, listen on a given tcp port.
-- 
2.43.0


