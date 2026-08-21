Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC29C5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 06:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxJ30-0004BR-Oh; Fri, 21 Aug 2026 02:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1wxJ2z-0004BJ-JK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 02:48:13 -0400
Received: from submarine.notk.org ([62.210.214.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1wxJ2x-0006yS-PR
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 02:48:13 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id B687314C2D6;
 Fri, 21 Aug 2026 08:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1787294886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Zj5chlGfnCQU/cpa21YKQoQRfXsJ0t56xVaih1y2ag=;
 b=Wr5GSOrbEw6wFJH5fZeOV4K6ivjZg9qoQMW0eK0dAzlrzUV/Y4SaHK5bbsenICq9KQcyT5
 OTo3//H7kMRzFlH1ExPyMtc0i4BL1jWyfTfZn3Da2C059JJAXB2Gmdt5vHWpTz8DHQMBf2
 63BKNTvwBLhXMKYO507sal8kgW4u3POJuTmrwis6Q3EkMKAIJX6RS9DEfnsh1dDnykgbCy
 cqyvm+8jGZKL3Oip6Sfd1GHFXwHNvHt9SdtSmF36G212lNDsC79WXlcP2O2BXnmTsY4Msa
 3vFEN4HjyStzv4gEVuc6i3ypg+oTARAdKRbclhIw1GS+KkmkHRcPTbaKXJs03w==
Received: from gaia.codewreck.org (localhost.lan [::1])
 by gaia.codewreck.org (OpenSMTPD) with ESMTP id fc3d6d80;
 Fri, 21 Aug 2026 06:48:04 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Fri, 21 Aug 2026 15:47:51 +0900
Subject: [PATCH] subprojects: re-include *.wrap files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-subprojects-ignore-v1-1-0640f7fee388@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAJj0h2oC/x3MPQqAMAxA4atIZgu1SP25ijjUNmocWklUBPHuF
 sdveO8BQSYU6IsHGC8SSjGjKgvwq4sLKgrZYLSxujWVknPaOW3oD1G0xMSoWtfVVjsbGhcghzv
 jTPc/Hcb3/QDAuDffZAAAAA==
X-Change-ID: 20260821-subprojects-ignore-8a9460a6d7ad
To: qemu-devel@nongnu.org
Cc: Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.17-dev-1f2f7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=w431d2GQblFvpzPBGZRL1Ka65GVox6UxBkp9z2FBYvU=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBqh/SjfO6CYqqifgBATC6OH0GPsnPej9B4oEgmx
 ATG8YN57WSJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaof0owAKCRCrTpvsapjm
 cL4qD/4vIhtsUChniwN2FUOlXyoPnBFLZCLJRi+Ub0uxgo1q9wP5MzupIw7CcJp0MzBxVr3Mnwi
 8p6PmWfm9x541T3dCaPY4r1zo2rTzoHsv+MHiVsxd6vtBBvQTfwwyuRSSaKFf0mxZ8abWhTSRxN
 pwBoUR/lCeozAvTCbpCq9rqg2LUbuKL59eSAG+rThTCVmn3/AXLvxggQEM9ugD2Q+kWGei4HDR6
 H8gRT3VrJL83CNpRPj2fstMw/S7Wq29JbV8QsQpM08qJFB+Hy1RQwrhmuJJN7Qk0z80c9OVxxhB
 IFsolxe7MyhPII9/ENlsCaDo1+BIoXVPXgOfmmuJOpD/NC3PpuAR15x1NZulVSlWHeGFzdCTyRi
 1+cxiftFAtbf2zrCZkAm326346deV+oUcLBqsJOiFekugRZuAmaGXR0XBNWuywhpcqvRrovrXNP
 Czj0fuq6c9vW/zfcie0ukTyR+IvseW/jvDP3HkNhrSF6aiDEJ4d1O1Z9PJwyJZQgiB4/ut+VESg
 JMbHh4wVk+o7H3oara9P1kU08NIb/WbkhLdIZcG0qpKEJk2sSglr0L2NoDS/dd0GVtGuV9X9YLe
 hi/hHcN5m/OcAaVMH4c+xm0IPw30W9YhOntHNCiby7PN7Hmd6jTUBzmpFS6HQGaxuLolf4JAhty
 C4v4w3dFgRmQPaA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
Received-SPF: pass client-ip=62.210.214.84;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
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

The existing wrap files e.g. anyhow-1-rs.wrap are ignored because
meson extract the sources in the subprojects directory

This is not a problem for git itself, because files that had already
been added are properly tracked, but tools such as fd-find blindly
trust the ignore rules and fail to pick up the .wrap files, making
discoverying the build system (when e.g. adding another crate or just
curiosity) more difficult than necessary

This added rule re-adds the wrap files so they now properly get picked
up.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Stumbled upon this when looking at the rust build system out of
curiosity (because stsquad asked something related on IRC)

It probably doesn't matter much, but took me more time than it should
have to find the wrap files, so might as well improve this for the next
one to look at these.
---
 subprojects/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 011ce4dc3b77..4bdedb081601 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -26,3 +26,6 @@
 
 # Workaround for Meson v1.9.0 https://github.com/mesonbuild/meson/issues/14948
 /.wraplock
+
+# re-include wrap files regardless of ignores above
+!/*.wrap

---
base-commit: acc271509ab015b9e064065f26d41a61e01e641b
change-id: 20260821-subprojects-ignore-8a9460a6d7ad

Best regards,
--  
Dominique Martinet | Asmadeus


