Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218CBC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7GW-0006nL-1f; Thu, 22 Feb 2024 06:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7GL-0006GR-FB; Thu, 22 Feb 2024 06:29:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7GH-0005G8-Ew; Thu, 22 Feb 2024 06:29:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8123F4FB64;
 Thu, 22 Feb 2024 14:26:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 07E6E87190;
 Thu, 22 Feb 2024 14:26:04 +0300 (MSK)
Received: (nullmailer pid 2526244 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Tianlan Zhou <bobby825@126.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 34/34] system/vl: Update description for input grab key
Date: Thu, 22 Feb 2024 14:26:01 +0300
Message-Id: <20240222112601.2526057-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Tianlan Zhou <bobby825@126.com>

Input grab key should be Ctrl-Alt-g, not just Ctrl-Alt.

Fixes: f8d2c9369b ("sdl: use ctrl-alt-g as grab hotkey")
Signed-off-by: Tianlan Zhou <bobby825@126.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index a82555ae15..b8469d9965 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -891,7 +891,7 @@ static void help(int exitcode)
     printf("\nDuring emulation, the following keys are useful:\n"
            "ctrl-alt-f      toggle full screen\n"
            "ctrl-alt-n      switch to virtual console 'n'\n"
-           "ctrl-alt        toggle mouse and keyboard grab\n"
+           "ctrl-alt-g      toggle mouse and keyboard grab\n"
            "\n"
            "When using -nographic, press 'ctrl-a h' to get some help.\n"
            "\n"
-- 
2.39.2


