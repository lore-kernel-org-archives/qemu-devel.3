Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1654D103E2E5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Qao-0003lw-S5; Wed, 11 Mar 2026 16:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0Qaj-0003gk-Ax; Wed, 11 Mar 2026 16:55:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0Qab-00082n-9w; Wed, 11 Mar 2026 16:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773262468; bh=cbFwEQUAlt45RFRT5FJ2dSzJA7pXHrfL/Flm+6+wv5I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aZXY9P22VF/WrO101+e8u0Ks/udEiHmkfFwKDREg/1YkXBeO2iOWCWuF2TbfvwrU2
 r5EcsihX7Tgo64fV3Np6tM868/PWMJcUX4gWQ2fBbRKCy6FgS4K6gOGKl4mFcjG94z
 P96CRnx1urnVnGctD0boUyrGraLxGpQWNF9zwB5VQbSuAnnPpXGOk2P7tO7V5SvVy3
 U/CpdKPimFbK3TaVKVVGTT/jkrffSMqeTHu7wylP5yXzbz6uVnGhuWXXRHkZKvVGVO
 gb6OfesxCNqD0D3FKSh+udLUAGft543lO5lafCElfKA/Y5Ae2kJunXpyABzYDt0ciH
 qTN/AFX9d7rOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D075F1921EF;
 Wed, 11 Mar 2026 23:54:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2E6CD37C4D4;
 Wed, 11 Mar 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH trivial v2 2/7] meson.build: stop checking for splice()
Date: Wed, 11 Mar 2026 23:54:50 +0300
Message-ID: <20260311205459.1101023-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311205459.1101023-1-mjt@tls.msk.ru>
References: <20260311205459.1101023-1-mjt@tls.msk.ru>
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

CONFIG_SPLICE was only needed for linux-user/, where it is not
used anymore (assuming splice &Co is always present)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 meson.build | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/meson.build b/meson.build
index ed82247111..97af137f3f 100644
--- a/meson.build
+++ b/meson.build
@@ -2908,14 +2908,6 @@ config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(osdep_prefix + '''
 config_host_data.set('CONFIG_SIGNALFD', cc.links(osdep_prefix + '''
   #include <sys/signalfd.h>
   int main(void) { return signalfd(-1, NULL, SFD_CLOEXEC); }'''))
-config_host_data.set('CONFIG_SPLICE', cc.links(osdep_prefix + '''
-  int main(void)
-  {
-    int len, fd = 0;
-    len = tee(STDIN_FILENO, STDOUT_FILENO, INT_MAX, SPLICE_F_NONBLOCK);
-    splice(STDIN_FILENO, NULL, fd, NULL, len, SPLICE_F_MOVE);
-    return 0;
-  }'''))
 
 config_host_data.set('HAVE_MLOCKALL', cc.links(osdep_prefix + '''
   #include <sys/mman.h>
-- 
2.47.3


