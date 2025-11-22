Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FEDCFD2F3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 21:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMupr-0000TP-BH; Sat, 22 Nov 2025 16:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMupk-0000SX-OX; Sat, 22 Nov 2025 16:07:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMupb-0006wb-4W; Sat, 22 Nov 2025 16:07:48 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DAAD516D307;
 Sun, 23 Nov 2025 00:03:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A6E53223DB;
 Sun, 23 Nov 2025 00:03:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Chenxi Mao <maochenxi@bosc.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.22 13/25] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
Date: Sat, 22 Nov 2025 23:55:31 +0300
Message-ID: <20251122210344.48374-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
References: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Richard W.M. Jones" <rjones@redhat.com>

curl_easy_setopt takes a variable argument that depends on what
CURLOPT you are setting.  Some require a long constant.  Passing a
plain int constant is potentially wrong on some platforms.

With warnings enabled, multiple warnings like this were printed:

../block/curl.c: In function ‘curl_init_state’:
../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
  474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
      |             ^

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009141026.4042021-2-rjones@redhat.com>
(cherry picked from commit ed26056d90ddff21351f3efd2cb47fea4f0e1d45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/curl.c b/block/curl.c
index f9c5a1c182..d2b094802e 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -478,11 +478,11 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
                              (void *)curl_read_cb) ||
             curl_easy_setopt(state->curl, CURLOPT_WRITEDATA, (void *)state) ||
             curl_easy_setopt(state->curl, CURLOPT_PRIVATE, (void *)state) ||
-            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1) ||
+            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1L) ||
             curl_easy_setopt(state->curl, CURLOPT_ERRORBUFFER, state->errmsg) ||
-            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1)) {
+            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1L)) {
             goto err;
         }
         if (s->username) {
@@ -805,7 +805,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->accept_range = false;
-    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1) ||
+    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1L) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION, curl_header_cb) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERDATA, s)) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index bd7650a7a2..e0c1075446 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -28,8 +28,8 @@ int download_url(const char *name, const char *url)
     if (curl_easy_setopt(curl, CURLOPT_URL, url) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, NULL) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEDATA, file) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L) != CURLE_OK
             || curl_easy_perform(curl) != CURLE_OK) {
         unlink(name);
         fclose(file);
-- 
2.47.3


