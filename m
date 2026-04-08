Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24FF10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXkw-0008Ts-Up; Wed, 08 Apr 2026 14:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wAXkv-0008TM-DR; Wed, 08 Apr 2026 14:36:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wAQds-0000Pc-Ow; Wed, 08 Apr 2026 07:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775645720; bh=yPuWulHjK9XHbqL5n11NbBkjSHKE9YvNKtuG5clkRXo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Xeh8Vkgj8PvTf6iOOsnHgrCohwXkBTcAsIuoL4pmvmTVzjyOr7CUKBnjLByQ7EDg8
 pK2HUNC5cNkbuBty41CJKs3/hHlFqi96bb6g0GhZ45I5CvNGOry1WPNxm5moNi0iOY
 PZlgnxHsy2sf95HXPFc06kt/OJpswTBds9cxoZjDQY5m7c7SCV+v5FYOwixEJAVGBR
 F1oQVtfMVw5FX5QQsw0YfT4JZM5PlZ3f8qzPTFjU+2rPNzq7D71GI7zR8Jm9Pcop2s
 s3rRzbGnTOK+m2rDUHTD5lBJVnARPq3kIlcWRuo4EEZgKJ+OBs4w4dT9HurpatcS/e
 jUyN0XvrVmblA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13E5F19C29C;
 Wed, 08 Apr 2026 13:55:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 62B2C391676;
 Wed, 08 Apr 2026 13:56:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@kernel.org>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/3] Allow building qemu tools on 32-bit hosts
Date: Wed,  8 Apr 2026 13:55:57 +0300
Message-ID: <20260408105605.172465-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408105605.172465-1-mjt@tls.msk.ru>
References: <20260408105605.172465-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@kernel.org>

Qemu's tools like qemu-img are often needed on 32-bit platforms,
although the actual qemu emulators have been discontinued on 32-bit.

To allow building the tools on 32-bit this patch implements three small
changes:

a) The check in meson.build is changed to still error out if the user
tries to build qemu-system or qemu-user on a 32-bit platform, but allows
building tools (e.g. by "--enable-tools") alone.

b) The compile time check in atomic.h now checks against
sizeof(uint64_t) so that 32-bit environments can still build
successfully, while 128-bit atomic operations are prevented to sneak in.

c) Allow linking against libatomic as long as we don't build the
qemu-system and qemu-user binaries.

Sucessfully tested on the 32-bit big-endian powerpc architecture.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/atomic.h |  6 +++---
 meson.build           | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index dc9290084b..e4dd948863 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -58,11 +58,11 @@
 
 /*
  * Sanity check that the size of an atomic operation isn't "overly large".
- * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
+ * Despite the fact that e.g. x86-64 has 128-bit atomic operations, we do not
  * want to use them because we ought not need them, and this lets us do a
- * bit of sanity checking that other 32-bit hosts might build.
+ * bit of sanity checking that other 32- and 64-bit hosts might build.
  */
-#define ATOMIC_REG_SIZE  sizeof(void *)
+#define ATOMIC_REG_SIZE  sizeof(uint64_t)
 
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
diff --git a/meson.build b/meson.build
index daa58e46a3..ab3e97eb9f 100644
--- a/meson.build
+++ b/meson.build
@@ -323,8 +323,8 @@ endif
 # Compiler flags #
 ##################
 
-if cc.sizeof('void *') < 8
-  error('QEMU requires a 64-bit CPU host architecture')
+if (cc.sizeof('void *') < 8) and (have_system or have_user)
+  error('QEMU emulator requires a 64-bit CPU host architecture. Only tools may be built for 32-bit.')
 endif
 
 foreach lang : all_languages
@@ -423,8 +423,16 @@ endif
 #
 # Later checks assume we won't get atomic ops for int128 without
 # explicitly asking for -latomic, so we must disable GCC's new
-# automatic linking with the new -fno-link-libatomic flag
-qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
+# automatic linking with the new -fno-link-libatomic flag.
+#
+# When not building the emulators, but qemu helper tools only
+# (e.g. on 32-bit hosts), libatomic is sometimes required and
+# thus acceptable.
+if (have_system or have_user)
+  qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
+else
+  qemu_ldflags += cc.get_supported_link_arguments('-latomic')
+endif
 
 qemu_common_flags = qemu_isa_flags + qemu_common_flags
 
-- 
2.47.3


