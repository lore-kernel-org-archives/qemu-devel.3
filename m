Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B4606A781
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FA2NRU3j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufQ-0004En-JH; Mon, 16 Nov 2026 06:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSued-0003v8-5G
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueS-0002CP-Q9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:36 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso2737793f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827611; x=1795432411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJLetTbZJ7Rf7k1mQrskTb9PQBrK7zGSIhhOsVLO8KY=;
 b=FA2NRU3jN/rh/pitxyrgYkS0D81jyXzKH2c0WJBU7hfBuRs3kaENLzleXDfUd/xs8W
 Qh2o0qkD402ysq6Epdr65hYE7qTNUy5dRid8qEW4ALs63+BGBPAEPillQ6qY8z6KldQi
 9SxSE08tkLV0OtZPdw4qZVzKKrt77b8etxf/6bpOfzeLKK9qAunM9THKgLhHpJJSjW6J
 isfdNiy5rJRGZhwqenpQzNF8ZDeh9s61il16oybaP6d593BXXPWzODdHe+JQjhIgTofU
 QpkOd3T8vgUiE8RZRfSJrArlqvaZN4TgFvKd4/B0wrXLXFh5AKQUp0Yt5oTBltk9fk3o
 quLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827611; x=1795432411;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aJLetTbZJ7Rf7k1mQrskTb9PQBrK7zGSIhhOsVLO8KY=;
 b=yjq/uGLBrluCZ9YcKtGsufXWPMXkjHE5fQKT4Q7/svzZ+mRMXpdESYUw2lws/P9Mww
 t2Gp18k0ebsiSo7qUIHFjUwe9SkN0vITnmil7d00prRAkxEZ9PCfmNPzN+bcTRxHxq8z
 SD1X5oMSD3tE8M0EsA7Wpv5nrygszu72IaJE6G1909GfIdbLU6BgPFUWEiZTl2NYZ1AW
 Gv4i08u9K0Y/IyHjcNMO+JwtaJlaYmR55YY10r+pMM1+4QwAtDNkJwppJ5oHAUVCBlkD
 nn61CRGO9sCjIuydufFxuvakyoT4lHN548QjQJJnMrz+3wcH9huHdMmzZM9MKsN2CKfu
 FNUA==
X-Gm-Message-State: APuU4Z81lhNyfGCB9dNDxtE043SK0UluHFocv4oGgMrhyIoqGXK0rtCT
 37ALpiHwUIzcVj8V1h3n1QmY2Qf3ncawlhsTpg9J8USU59I7pTAfX5jlvxkUxqIJZaA65vfgkv5
 VvYop3xk=
X-Gm-Gg: AZFdTZekmnOyM8fJCe1rHsR8nEG7vv+61kFE3zRu4SY3GXeT7NKxKXBMVUEFPBhz2kG
 baA4PV+sl8HprGjPMo1wT/44xUt15ngA+sMAqojfBAOva7oO2mqEKBqGkyf6quH1AbaWGI9+iuS
 cuhsdfTL0kVIcHjrexzy6HwrD+6wuCJh98SCDgeOHNkeRydbxtIF6mZV/ALk5JF3F2FkYzR0kDM
 89hZbTSfm0UoKnUy5ElqMEzXodYE6xonxRlNKRjgaf5U7dt8nyNpO1gCoDytKW5q0tQnO9vMZxq
 sTZk2iCeJXfgegiMAw1MzhpByWCXl4wdvIhlzedWjHvZS3Wt20xW5p7VebNI9DVN3ssJqzx7Ej3
 gj6oyA0hQNh/ivMreSQDPJQhq3X2sOttqzbqku7wOMxO+yjRTxjsCcjuywo6Fwe/v+IeJp7fZXF
 5XH1s0btINtynzVSiRHYWz6w8hpJGdhM1CmX87K+OIYVuBUmlGFwfCG/i1cCbY/2M7i0szvpl/X
 +gXT1qyEqo0VBIT2rPzim/tRNcxZmmg5bMAVcQX5WGAK/utRbMFZIs++IwgPhhcmIZPBI8afXvs
 f/Er0l03ZY97PoxxJVuaY4KnjfECF8Dwpu0vKfd24VB8nQomjvaN6r39leBeuip2V+ZOc1U3O9G
 rB4Kn/PF6ysIB9r3Zcb1MWSGQH7gVL2UDHg==
X-Received: by 2002:a05:6000:4b0b:b0:48e:20f9:8d75 with SMTP id
 ffacd0b85a97d-49c72c9c398mr21249342f8f.48.1794827611186; 
 Mon, 16 Nov 2026 03:13:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/33] tests/qtest: Make netfilter tests accept padded ethernet
 packets
Date: Mon, 16 Nov 2026 11:12:54 +0000
Message-ID: <20261116111303.1692832-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the various netfilter tests assume and assert that the data
they get from the filter is an exact match for the data that they
send in to it via the net socket backend.  This happens to be the
case currently because the net socket backend fails to pad frames to
the ethernet minimum when the device expects that (unlike e.g.  the
tap backend).  When we fix the socket backend to honour the device's
request for padding, the netfilter will see padded packets for
devices that require them (which is most of them), and not for those
that don't (notably virtio-net).

This seems best considered as a test error: if you're using netfilter
to look at what a particular network device is receiving, you want to
actually see what it is receiving.  And most real-world users of
filtering will be doing it with the backends like TAP that were
already doing pad-before-filter; it's only the oddball backends like
'socket' that forgot to pad.

Make the test cases accept as valid both padded and unpadded frames.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20261110180655.2072265-2-peter.maydell@linaro.org
---
 tests/qtest/test-filter-buffer.c     | 4 +++-
 tests/qtest/test-filter-mirror.c     | 4 +++-
 tests/qtest/test-filter-redirector.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-filter-buffer.c
index 441cbb975ca..418caccf00a 100644
--- a/tests/qtest/test-filter-buffer.c
+++ b/tests/qtest/test-filter-buffer.c
@@ -11,6 +11,7 @@
 #include "qobject/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
+#include "net/eth.h"
 
 /*
  * Test that changing interval at runtime affects packet release timing.
@@ -148,7 +149,8 @@ static void test_change_interval_timer(void)
     ret = recv(recv_sock, &len, sizeof(len), 0);
     g_assert_cmpint(ret, ==, sizeof(len));
     len = ntohl(len);
-    g_assert_cmpint(len, ==, sizeof(send_buf));
+    /* The snooped network device might or might not have asked for padding */
+    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
 
     ret = recv(recv_sock, recv_buf, len, 0);
     g_assert_cmpint(ret, ==, len);
diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
index 723d2c2f291..9972712cb49 100644
--- a/tests/qtest/test-filter-mirror.c
+++ b/tests/qtest/test-filter-mirror.c
@@ -15,6 +15,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "net/eth.h"
 
 static void test_mirror(void)
 {
@@ -58,7 +59,8 @@ static void test_mirror(void)
     g_assert_cmpint(ret, ==, sizeof(len));
     len = ntohl(len);
 
-    g_assert_cmpint(len, ==, sizeof(send_buf));
+    /* The snooped network device might or might not have asked for padding */
+    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
     recv_buf = g_malloc(len);
     ret = recv(recv_sock[0], recv_buf, len, 0);
     g_assert_cmpint(ret, ==, len);
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index 5540c232c0b..a4f9b73c72a 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -57,6 +57,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "net/eth.h"
 
 static void test_redirector_tx(void)
 {
@@ -115,7 +116,8 @@ static void test_redirector_tx(void)
     g_assert_cmpint(ret, ==, sizeof(len));
     len = ntohl(len);
 
-    g_assert_cmpint(len, ==, sizeof(send_buf));
+    /* The snooped network device might or might not have asked for padding */
+    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
     recv_buf = g_malloc(len);
     ret = recv(recv_sock, recv_buf, len, 0);
     g_assert_cmpint(ret, ==, len);
-- 
2.43.0


