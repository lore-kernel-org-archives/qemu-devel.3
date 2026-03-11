Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A7D112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L6V-0005le-0C; Wed, 11 Mar 2026 11:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L5A-0004S2-Pe; Wed, 11 Mar 2026 11:02:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L58-0003pc-7Z; Wed, 11 Mar 2026 11:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241303; bh=Scoz5vWWtJuOsOhmD5izBqmtOTiJUw+vyXNsSYupuQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SiD40WsVs/KtSZe7SA4lvZddxM175TbFxljy/8u4OALdX2qx9Qx4UWOdLFaEbHy/C
 q4MCxBaxDzj/LRor4jxpO/abDrb4aHg7sO5mUGkglDWqxE7aoY+I2bnoSpJD0m352i
 GxbTSRsYymMvkQ6tJvGfOme948fOm9Dp64WY7u1LZuH6hHIeEdxg+bexu/w5luGUjR
 CkQeaCKJTbI3mCP42nwfxtc3tR9Z5jYdfUHzyMJn5Jb2SSOv/Grz+oDAhqHptSvk3S
 Ylg7+2jH3GBWt127A/z1p0Gl4Z7RUyDi6gC3FxZuHBNp0LjdBU737BAwrrYHxHV9Wk
 /MjQ/j0Cg268Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D00BC191E46;
 Wed, 11 Mar 2026 18:01:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B47C737C298;
 Wed, 11 Mar 2026 18:02:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 08/44] docs/about/emulation: Add documentation for
 hotblocks plugin arguments
Date: Wed, 11 Mar 2026 18:01:40 +0300
Message-ID: <20260311150221.1084186-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
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
index a72591ee4d..73b193a727 100644
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


