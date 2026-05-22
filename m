Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF0ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXmy-00045X-If; Fri, 22 May 2026 17:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmi-0002rj-74; Fri, 22 May 2026 17:52:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmf-0004FH-NL; Fri, 22 May 2026 17:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=p6pAbECg2KacMKKyb2n/g/X3bm43YbGdZyTLDTpukU4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uvPGKfOwKa9ssoZmJ5idOGBdx4h15Xgpa/FCnaTfAp3CooH93ug0JpCxy3u5pSUcp
 SULs+P8RaZi2tHbh/PxWp3TXJvgkDJ5mx/Ppz0A3Ifh60UJA8UKDP14kDP5jFep7/6
 l2WNNz48sv0Jo+8m5M90UqbD+A9yYmQ3YFPQ+qEZRi9UeKF3YtX+4XobVTD3e7FtQs
 HvH8aopRWf/6RGC2ZxnENl///6e+1gCsiGLfsXNStPo8xoRVoWP7g7Cqk881c+u0dM
 bZ6vExzSH8z7CjhOksnjSar8tOL6TrCA2xmQ94W1nD3WpRxsgIbttk8RnhpQCupJFB
 5UI7vK4l72Bmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 180071AFB78;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3CF823B71C7;
 Sat, 23 May 2026 00:49:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 130/149] meson.build: Add -fzero-init-padding-bits=all
Date: Sat, 23 May 2026 00:49:02 +0300
Message-ID: <20260522214923.807017-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The C standard doesn't always guarantee that struct and union padding
bits are zero initialized, even if the code initializes a struct.
For QEMU, this is potentially problematic, because we often have
structs that match data structures in guest memory, where we
initialize them and then bulk copy them into the guest.  If the
compiler didn't zero init the whole of the memory containing the
struct, we could potentially leak random data from the host into the
guest via the padding bytes.

We already use -ftrivial-auto-var-init=zero, which will zero out
padding in many of these cases, but -fzero-init-padding-bits=all
closes some gaps, for example cases where we initialize a
variable with a struct initializer, and cases involving unions.

Follow the Linux kernel in using both options. Compare kernel
commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").

This option exists in gcc-15 and above; it's not supported
by clang, but clang documents that it guarantees zero init
of these cases always:
https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
Older gcc which don't have the option behave as if it were set.

(These options are passed through the cc.get_supported_arguments()
filter, so we don't need to do anything extra to avoid passing it to
a compiler that doesn't recognize it.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20260508104723.2144051-1-peter.maydell@linaro.org
(cherry picked from commit a163fc1f864bef27f6e527cbad9defba7af9e60a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 5ba29bc07d..7ae0d109ab 100644
--- a/meson.build
+++ b/meson.build
@@ -703,6 +703,12 @@ hardening_flags = [
     # it harder to take advantage of uninitialized stack
     # data to drive exploits
     '-ftrivial-auto-var-init=zero',
+    # Ensure GCC zero-initializes padding bits and trailing fields in
+    # unions. This avoids potentially leaking host data into the guest
+    # when we init a struct and copy it into guest memory.  GCC prior
+    # to GCC 15 and clang don't have this, but they zero the padding
+    # and trailing portions of a union by default.
+    '-fzero-init-padding-bits=all',
 ]
 
 # Zero out registers used during a function call
-- 
2.47.3


