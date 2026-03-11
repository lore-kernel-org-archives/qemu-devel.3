Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67D4112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBr-0001ev-Aj; Wed, 11 Mar 2026 11:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L9q-0004Ka-F2; Wed, 11 Mar 2026 11:07:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L9p-0005NG-0I; Wed, 11 Mar 2026 11:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241481; bh=WFDBd59LDeMuZab62RqqgKOzLkJ6gBfNQUKMlGkvZNE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EstVVpZX0FM/XP7uGMB7GAgq0MxGDuGYfBzrm2Tzvj+W0zBUYbpKEYblLhtXfg+yH
 CAXn6BnsCsa2A/RVacsKrXclvaDDfj7lILZihVlzfu6n5/4tqwailrcElXfl6oI54v
 YGnd9/1/yYp/VJFP6mYDV5cu0hwl+kAbRjhKEiEKxkFdt6wIGn5lxOsqLSP9+GjnhB
 l9h1Nce5z4AxIEb9kpHqbjYUid/i+c//xzIYkk5Rm9IP8bV+IbcqPK2AfGqM6n3WaD
 RYZAvBcTnHNBSr/eX3prAvnZmXVwR/CKbQUYkI/kviUn29z076wwJWiJcRLsKJsjha
 DQGR3cTQ2fgwg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C81C191E8C;
 Wed, 11 Mar 2026 18:04:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 81FB137C2CD;
 Wed, 11 Mar 2026 18:05:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 09/46] docs/about/emulation: Add documentation for
 hotblocks plugin arguments
Date: Wed, 11 Mar 2026 18:02:45 +0300
Message-ID: <20260311150327.1084669-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Alex Bradbury <asb@igalia.com>

Currently just 'inline'.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/35128cc5a86a0c18418f9d3150fb8771c54ef7d8.1753857212.git.asb@igalia.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
(cherry picked from commit e4ed74c9aef68cb2e7c10c2b7597fee5491a506a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b0..9c963f4705 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -463,6 +463,16 @@ Example::
   0x000000004002b0, 1, 4, 66087
   ...
 
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Hot Blocks plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter.
 
 Hot Pages
 .........
-- 
2.47.3


