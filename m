Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF3CE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjpu-00085n-Qi; Thu, 12 Dec 2024 09:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLhxY-00063w-W4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:06:25 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tLhxX-0005HS-1K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:06:24 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17])
 by air.basealt.ru (Postfix) with ESMTPSA id A4833233A0;
 Thu, 12 Dec 2024 15:06:19 +0300 (MSK)
From: gerben@altlinux.org
To: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org,
	Denis Rastyogin <gerben@altlinux.org>
Subject: [PATCH] target/arm: remove redundant code
Date: Thu, 12 Dec 2024 15:06:14 +0300
Message-ID: <20241212120618.518369-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Dec 2024 09:05:36 -0500
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

From: Denis Rastyogin <gerben@altlinux.org>

This call is redundant as it only retrieves a value that is not used further.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 target/arm/vfp_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 62638d2b1f..f020c3c34b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1095,8 +1095,6 @@ float64 HELPER(rintd)(float64 x, void *fp_status)
 
     ret = float64_round_to_int(x, fp_status);
 
-    new_flags = get_float_exception_flags(fp_status);
-
     /* Suppress any inexact exceptions the conversion produced */
     if (!(old_flags & float_flag_inexact)) {
         new_flags = get_float_exception_flags(fp_status);
-- 
2.42.2


