Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6811D116F3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 00:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQEiN-0006Lh-0p; Mon, 01 Dec 2025 19:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1vQEiK-0006LE-F7; Mon, 01 Dec 2025 19:57:56 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1vQEiI-0004hZ-Mx; Mon, 01 Dec 2025 19:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=22Sh/0PgUBEDjcfCtgk9esTzLqCFPYi9mrpE7ZRqkwI=; b=LmHnlXE09U1taDyL
 l0etBHGcIAc7D7XxOho+e4Vl5CC6J9wRJlQv3uCPVsFq2mdnhIlOobamSMpLx2WvhNR845RQL4h+W
 gC5Oj4OrZX5ZAQ1T73U0sQmNZDtSDw4iBmtbF6sZtRTuUGHpjO7blYQoidXZn+vvgAShm0oUbEBBb
 v8+JMShdCT5s1VnYZ5/t57PIqHiVGX/fB/zx88Afx5cEQdRhrkQRcp2tS0CFZ7ZAs1LhEUNk4xcCi
 cg5hmrran5Wtlp412G97mxjM0pG0a79VKjksSZ1uk7fQzVozEiEXbqtcYCNUETKzX+rnOCLUbIswC
 NeGGyAxkjWQuzzjxgA==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vQEiA-00000007X78-2k17;
 Tue, 02 Dec 2025 00:57:46 +0000
From: dave@treblig.org
To: qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 thuth@redhat.com
Cc: jak@jak-linux.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] qemu-options.hx: Replace deprecated -M example
Date: Tue,  2 Dec 2025 00:57:40 +0000
Message-ID: <20251202005740.299524-1-dave@treblig.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

The -M option was deprecated by -machine in 2011 by 80f52a669
and isn't actually documented in the manpage, but is still used in
one of the examples.  Replace it by -machine.
-M still gets used all over the place in other docs, and I'm
not sure I realised it was deprecated until Julian pointed out it
wasn't actually documented.

Reported-by: Julian Andres Klode <jak@jak-linux.org>
Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74..9cd0b7173c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -481,7 +481,7 @@ SRST
 
     ::
 
-        -M pc \
+        -machine pc \
         -smp 1,sockets=2,maxcpus=2 \
         -numa node,nodeid=0 -numa node,nodeid=1 \
         -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
-- 
2.52.0


