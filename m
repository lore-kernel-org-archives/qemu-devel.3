Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCBCC88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Mnk-0006gp-U9; Tue, 15 Sep 2026 02:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6Mnh-0006g1-Bo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:37:53 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6MnZ-0001Dg-AY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789454241; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=2jbStDiS254YvbhyEOUZC6f0WPv1hY7v8gUee1Q8C3c=;
 b=DZR4xPKtt4xiYhzhsARxDrmcfEPbLF4MZ3eskjNdZ+oZZLL1+rjZEJy6urhYPzzNvHbijD98KfMElEyzUKoHJd0e0c8rAu/L2IIB4Dd8wDK4mr2V8tfdl9PslKfxZwI6Vu0/EG6LYvgmGbGDornhN21H1ZkdRMLZA4SvNPCe40c=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0XB0Kx0r_1789454240; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0XB0Kx0r_1789454240 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 15 Sep 2026 14:37:21 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 1/2] docs/migration: document that postcopy can be used with
 multifd
Date: Tue, 15 Sep 2026 14:37:18 +0800
Message-ID: <20260915063719.89031-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260915063719.89031-1-guobin@linux.alibaba.com>
References: <20260915063719.89031-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Since commit e27418861288 ("migration: enable multifd and postcopy
together") in the 10.1 release, the multifd and postcopy-ram capabilities
are no longer mutually exclusive, but the postcopy documentation does not
mention multifd at all, leaving users unaware that the two features can be
combined.

Add a short section describing how they interact: multifd carries the
pages of the precopy phase, the channels are flushed and synced before the
switchover (because loading a page in a multifd receive thread is not
atomic with regard to a running vCPU), and the postcopy phase itself does
not use the multifd channels.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 docs/devel/migration/postcopy.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index e319388d8f..570a3a1ce6 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -294,6 +294,32 @@ the background migration channel.  Anyone who cares about latencies of page
 faults during a postcopy migration should enable this feature.  By default,
 it's not enabled.
 
+Postcopy with multifd
+---------------------
+
+The ``multifd`` capability can be enabled together with ``postcopy-ram``
+since the 10.1 QEMU release.  The two features apply to different phases of
+the migration:
+
+  - During the precopy phase, guest pages are sent over the multifd channels
+    as usual, so the initial RAM transfer can use all of them.
+
+  - Just before switching to postcopy, the source flushes and syncs the
+    multifd channels.  This guarantees that all the pages already queued on
+    those channels are loaded on the destination *before* the destination
+    CPUs are started, which is required because loading a page in a multifd
+    receive thread is not atomic with regard to a running vCPU.
+
+  - During the postcopy phase the multifd channels are no longer used for
+    guest pages.  Both the background stream and the pages requested by the
+    destination go through the background migration channel instead, or
+    through the preempt channel for the requested pages when postcopy
+    preemption is enabled.
+
+Consequently, multifd only speeds up the precopy phase of a postcopy
+migration.  The bandwidth available once postcopy has started is the same as
+without multifd.
+
 Postcopy blocktime statistics
 -----------------------------
 
-- 
2.50.1 (Apple Git-155)


