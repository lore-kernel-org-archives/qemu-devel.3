Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB05606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FuPS92S6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqFM-0007DX-FY; Tue, 10 Nov 2026 13:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFJ-0007Bj-Br
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:01 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqFH-0000If-DK
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:07:01 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2024321f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794334018; x=1794938818; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fP6hp4P+erJ9gJfxTUKysDGWbM+GXPKl+5MRuAY0a4w=;
 b=FuPS92S6k0GYHOQuLMQkF9+5QShVKjED5oPXgZ9S20/snTXFZYoyX7jrwj29mxNZBk
 FwQkK4YEneqCqUOu8Cx9PUJTK7G2zdCiQndHEfQq9rUo25uHxx36E5yg7r3zWxvCsOII
 jJZ+FbiigrLiutzyjwZogsIHEfmk3/ePG3Ap5A7Z0SWJF0QXC19q4ytFUcMlUhfT89D3
 ZJp3ZOqmppmy3AgCedj6RURn7w9c0YtB9D1/R7rr8ctVZ9j9YrtnTgrqJEr9q4HDLjNh
 dWdMceIDMMbNX91q7EVtLSdAOrFoc9zcOhjsV/gEAy+xIhHHi5g9mGQFlVA1RBo0KfU+
 palA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334018; x=1794938818;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fP6hp4P+erJ9gJfxTUKysDGWbM+GXPKl+5MRuAY0a4w=;
 b=JgMMTBn48Rfx/utBUAD5dQP7fwmAcMYbJl0oVvzI8IE736BildibfHg0cGlEVBJYHr
 NYSrPQFDMVq+3zxuWWW4Hyq0X9+W9nClK4F9ZUfYC7jDyBC83YtwQ9/63BqQsR2hDVOR
 lYqlfGnxPHB4qmY9Vw+DU8izq8FZ9KVRyHzToSi6KMyX0vkpwu4270t8s3W+LEqaLYoS
 7GYMyNWJ1AbNg7JzYxjVEl8NpyIZ5pXxdTOy1HqYDpJX4rPS6ssn26d8ZCw9TNWjIJUj
 gIjRVlxwpk5vZqm7PqmNPYT/XPb0vqjywsoXuh3uROUDHYMQXDVGK4WLudFnr7vTgCvx
 Z/XQ==
X-Gm-Message-State: APuU4Z/EeytOpFzK1YmqFmPc5qXHh2MDZYhEXM3qGONSIKoo+a86/kkY
 RkX96W+Imqf9ePpe2uxUo92DDkIbkqV+HN1e/qhsqQKGFEbvUChi9cW3yQKbHdZUrT5Wl1VvUEJ
 RZv/fMnc=
X-Gm-Gg: AYBFou1H2BaQekcIbEnGVW0d5GJ3zSwJHotzenoHSMj5DrbOepDdyeVb0NM8udONfeL
 cMEumOqksa6FhsO2GG4/F6R0LeumBdZzUJ6sM1qL9UQ7yJmSaSYGqvtj+7UvKbY5VuCdPPFUHmg
 nRW9CtZHuuXMHaJ5s3cPaRzyjYni3mTD8PuNhreEafTxIrJw6g6Ja6+6YE1bETBdMKnCJH/yq+h
 lZ2aU3DiGKAm8UK3gOkWY0O2F7z408Qz6DaH0Axlr8rklrvsua2Ri7KxNBAi3Zfc/jOYVN5f5qD
 2CLm0aXzY1cZvK6qJ3cgz4q+VsDRWiy3G3tk893zMa2yME5ypLVAHsK1akAxSDqYsg6sn6VYa6B
 oQ2cpruKohWV/RYlz8sQxBAz38JH0lXllAGnx9/l3RR0y0BustDrw74cU4tnFQF+GHdwIFiXibT
 jjX4sJ9dIzPLsGUKY5G96n0qGm9ATYVCyATv1o5O3WBFQE0xuxYbaa6lQ+h+mKq1zYRK5Yau54C
 /Kv6hKgZpdYm3N0WZxgNMZXZkrR1DDHgCovZGveoyIWTstGoaGaLorx3+Z72Lm4wXEeqbvX8Qmp
 SgkoI/xUAagC20g0in4MkEUHdytegZcr7pc5lRT87bZ+7QIc317mp6/ic06psiDrrm8yrv05aKn
 GXwr4WPToMt06NYkAxrW8dLLa6rAjkP15gA==
X-Received: by 2002:a05:6000:a87:b0:48e:824:f0b9 with SMTP id
 ffacd0b85a97d-4983105fc57mr5598232f8f.45.1794334017698; 
 Tue, 10 Nov 2026 10:06:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm6825701f8f.53.2026.11.10.10.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:06:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org,
 "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowangio@gmail.com>,
 "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
 "Laurent Vivier" <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Zhang Chen" <zhangckid@gmail.com>, "Li Zhijian" <lizhijian@fujitsu.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 for-11.2 1/3] tests/qtest: Make netfilter tests accept
 padded ethernet packets
Date: Tue, 10 Nov 2026 18:06:53 +0000
Message-ID: <20261110180655.2072265-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110180655.2072265-1-peter.maydell@linaro.org>
References: <20261110180655.2072265-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


