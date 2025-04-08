Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C3C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2FLz-0002Qn-SR; Tue, 08 Apr 2025 16:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLc-00029o-3v
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:04 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1u2FLY-0004yN-3l
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:15:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C7019A48F71;
 Tue,  8 Apr 2025 20:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09297C4CEEC;
 Tue,  8 Apr 2025 20:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744143294;
 bh=PTQEmEN9vlIeeSga0uIH4UsLep0Yj7zyUxnE3/azy2o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EqYGL4Njq1kra+c7SYniWfunkyB+omUPDBcrAt12k2OxVS9kYH1VlFurf9gU2Xecy
 IkY2MgfTpYJQhDSbFKrnd26QU+LbrAoZsnQHiK3Jn9m3SFW3+ab7lYO+b4wrSER7NX
 mCN0pcfIWVrOJI4MGmVGuzPZbc8A562FghjAZsNwyU76ls20Zpfd8pDA9/KeOaI4jl
 j5tGgjll1qNAbCbP0tbGWls9vTMePBasS1hK6Ewdwj46IA/m/lJEcXlgTViQ3N7Xh3
 zqvBZgd/XQVAsBnwuSLlZK62ErMAc+CRquUKdeG/jbT+9/XFeV1cYcOyVlcMn/A8mU
 zA3ExqVihOQ2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EBF33C369A5;
 Tue,  8 Apr 2025 20:14:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 08 Apr 2025 22:14:48 +0200
Subject: [PATCH 3/3] scripts: Clarify doc messages in archive-source.sh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-jag-sysctl-v1-3-3f4f38b751be@kernel.org>
References: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
In-Reply-To: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=PTQEmEN9vlIeeSga0uIH4UsLep0Yj7zyUxnE3/azy2o=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGf1g7uLEQy49b/IdJeLRAAzBd0nu2tTpwVxO
 iWD3d/F3TzecYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn9YO7AAoJELqXzVK3
 lkFPeI0L/3KjR1okWTLiBDmdr2YURT1VB+4ldvkNtPbeVbAm5dabfTjFkcHqltn2Mfzw+WHUyU4
 X3mcEIIDduoKyPS0SrOxlsVz6thb1wp+OaxW5Giq6Xx/CrqizH5yCW2dyCeJEUURW8n8WGYQ8l2
 pruGWjxz/Jn4poyATlwEqMKdhhAjKp1esHIuU4PKiYKDW6BdveCr5zpb+0t21c3rOTXTM5BI7aF
 engqOFRZQtYmrTiuX81llDc3WTJ8FtwNJ5VHkzoSWBPygqqsmCUFdYT0iN3uA88U2PvLNK/MkDy
 bGnqObONi6VTb0JDXVZHrcOGaBdVDd0Rc0i4X6nJtVITZBna6kyGkfJlgu2rQtxpL/GHcQLlBrJ
 QJ6Rudu+qXuetZ6Tjox6bV0lUuHOHRuaNypUSDFmSQEV99ko5Wcdv6JrQnGhn8QVsgOC/yivXAn
 aQMtdsXKjJ+zMktcvDwSdf/y35EERR6RtiaNlnQ4gT+niQMr0Y2w+2JWTn78PZ6D9T2bbO1uEo7
 fA=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=joel.granados@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 scripts/archive-source.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 7143aaefc1133fe991b329df3c78e6ed7726322f..eb6ee715a8a3a33d8abe333fd896ad1048821b0f 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -2,17 +2,15 @@
 #
 # Author: Fam Zheng <famz@redhat.com>
 #
-# Archive source tree, including submodules. This is created for test code to
-# export the source files, in order to be built in a different environment,
-# such as in a docker instance or VM.
+# This script exports source files and submodules used by test code to build in
+# "different" environments such as docker or VM.
 #
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
 
-# We want a predictable list of submodules for builds, that is
-# independent of what the developer currently has initialized
-# in their checkout, because the build environment is completely
-# different to the host OS.
+# subprojects is a predictable list of submodules that is independent of what
+# the developer has in their checkout. This is needed because the build
+# environment is completely different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs

-- 
2.44.1



