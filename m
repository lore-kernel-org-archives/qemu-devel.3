Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D81CDD543
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxvp-0008K4-4E; Wed, 18 Sep 2024 12:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqxvl-0008AS-E4; Wed, 18 Sep 2024 12:53:29 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqxvj-0007vF-MH; Wed, 18 Sep 2024 12:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=DeMsBehUtFKVwAO7DEZvGx8WTNJ0TsF1r2iYur2FeqE=; b=aQ7Ds+t6Dh1aeD1w
 6XoyBuM4W5y3DqA7LGNGhCvW/DSJml9Q1VAnqHITbltOJDgWb5Jx5KI90FcjVgXn76f7hNAfHSvUo
 AXDFy+h6JKLasSPg1IotlXPKT6Ef8SPXSk0wC2kQwD8f9XJrdZYe23F+Ez8TJZc9DKbieGDVAV9UY
 hNosjW4+4YAMyYP6cTA4ZpmD7CouBSOK6HpsZ8r7L3W3Iss/19DEd4/KIKEG5PLL6lzAf57Z4R0IA
 cBn0HlIwhzrOVI+zPWRPJSjLCANm3JvXm1UZrlr1QHzaAPs3sieEKtomQB8Itce9Be3pKVp4r4+7X
 it6aGYHbYuYKchC+4w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqxvg-006JyL-25;
 Wed, 18 Sep 2024 16:53:24 +0000
From: dave@treblig.org
To: philmd@linaro.org,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] util/cutils: Remove unused qemu_get_exec_dir
Date: Wed, 18 Sep 2024 17:53:23 +0100
Message-ID: <20240918165323.179683-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

qemu_get_exec_dir has been unused since commit:
  5bebe03f51 ("util/cutils: Clean up global variable shadowing in get_relocated_path()")

Remove it, and fix up a comment that pointed to it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/qemu/cutils.h | 5 +----
 util/cutils.c         | 5 -----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index da15547bfb..34a9b9b220 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -241,13 +241,10 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
 int qemu_pstrcmp0(const char **str1, const char **str2);
 
 /* Find program directory, and save it for later usage with
- * qemu_get_exec_dir().
+ * get_relocated_path().
  * Try OS specific API first, if not working, parse from argv0. */
 void qemu_init_exec_dir(const char *argv0);
 
-/* Get the saved exec dir.  */
-const char *qemu_get_exec_dir(void);
-
 /**
  * get_relocated_path:
  * @dir: the directory (typically a `CONFIG_*DIR` variable) to be relocated.
diff --git a/util/cutils.c b/util/cutils.c
index 42364039a5..9803f11a59 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1144,11 +1144,6 @@ void qemu_init_exec_dir(const char *argv0)
 #endif
 }
 
-const char *qemu_get_exec_dir(void)
-{
-    return exec_dir;
-}
-
 char *get_relocated_path(const char *dir)
 {
     size_t prefix_len = strlen(CONFIG_PREFIX);
-- 
2.46.0


