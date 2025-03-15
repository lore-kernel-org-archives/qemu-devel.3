Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8296DC35FF3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 07:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMEE-0004HL-Gi; Sat, 15 Mar 2025 03:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttME6-00042T-UH; Sat, 15 Mar 2025 03:46:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttME4-0005OX-OD; Sat, 15 Mar 2025 03:46:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 32699FFB1E;
 Sat, 15 Mar 2025 10:41:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 213421CACE8;
 Sat, 15 Mar 2025 10:42:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BD53655A28; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 42/42] ui/cocoa: Temporarily ignore annoying
 deprecated declaration warnings
Date: Sat, 15 Mar 2025 10:42:44 +0300
Message-Id: <20250315074249.634718-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

These warnings are breaking some build configurations since 2 months
now (https://gitlab.com/qemu-project/qemu/-/issues/2575):

  ui/cocoa.m:662:14: error: 'CVDisplayLinkCreateWithCGDisplay' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
    662 |         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
        |              ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:89:20: note: 'CVDisplayLinkCreateWithCGDisplay' has been explicitly marked deprecated here
     89 | CV_EXPORT CVReturn CVDisplayLinkCreateWithCGDisplay(
        |                    ^
  ui/cocoa.m:663:29: error: 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
    663 |             CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
        |                             ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:182:18: note: 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' has been explicitly marked deprecated here
    182 | CV_EXPORT CVTime CVDisplayLinkGetNominalOutputVideoRefreshPeriod( CVDisplayLinkRef CV_NONNULL displayLink );
        |                  ^
  ui/cocoa.m:664:13: error: 'CVDisplayLinkRelease' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
    664 |             CVDisplayLinkRelease(displayLink);
        |             ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:249:16: note: 'CVDisplayLinkRelease' has been explicitly marked deprecated here
    249 | CV_EXPORT void CVDisplayLinkRelease( CV_RELEASES_ARGUMENT CVDisplayLinkRef CV_NULLABLE displayLink );
        |                ^
  3 errors generated.

For the next release, ignore the warnings using #pragma directives.
At least until we figure the correct new API usage.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-Id: <20241121131954.98949-1-philmd@linaro.org>
(cherry picked from commit 9cf6e41fe293dd56089faac94c36ff5cb3d96726)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/cocoa.m b/ui/cocoa.m
index d39c9e2a3b..4bca03ae1a 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -553,6 +553,9 @@ - (void) setContentDimensions
     }
 }
 
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+
 - (void) updateUIInfoLocked
 {
     /* Must be called with the iothread lock, i.e. via updateUIInfo */
@@ -598,6 +601,8 @@ - (void) updateUIInfoLocked
     dpy_set_ui_info(dcl.con, &info, TRUE);
 }
 
+#pragma clang diagnostic pop
+
 - (void) updateUIInfo
 {
     if (!allow_events) {
-- 
2.39.5


