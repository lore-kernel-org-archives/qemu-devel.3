Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6779606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cUSVfyEZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlFt-0006nL-RY; Tue, 27 Oct 2026 13:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFp-0006mX-CG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFn-0000id-8M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4956869750eso710235e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793123189; x=1793727989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N8sT9/MtzApMiV5CXh0LloivfPnedXy5IEWayysGbdg=;
 b=cUSVfyEZpYNWcCYitM2+KlVYmol06/jGNXPlIG36iMaZS4cptc6I6C/A+uIAWqGY0S
 FKTnhVCM2hVbBVUq2PrS1TUix6PzfQugUS4kvMii+qPxu+oC3PqJog+jDzAC2SY6vOwW
 pO9NBliYnOqsQDrrKSy0RMMbUavpg6qvmWo5p3zsMA6hVfTmYbTrGnSOI3GVVW9SRj8W
 G/gXqBuuH4fXFBuPxx0ms68PHGkXQxD4gNxUQbS1EfKgUCAVNpH8Ler+wRMs7vf6XvzG
 8QFFlT3J1dR0kHSnJk42tiMDSolrWeA/yL0ZqOepchhaObH4vPIN1KfQZZKp+cw+g/rW
 hT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123189; x=1793727989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N8sT9/MtzApMiV5CXh0LloivfPnedXy5IEWayysGbdg=;
 b=ThKS6EeQpqVScUuXlBYdIVMgDENlaeqv9S0TYupJvvvZc05HYN8PLO5kvD0uZDdRg/
 Is72QKi1Z4L6F95E3stANsvy9Fd+fypzmmNuPb1X6ev1XhVaTx/PdWrz1+p1CdbYj3QQ
 ALKykhf04dVb75tP/ZX7OVLzLNpXPsGwpOUwV4NwgJWDClbV4vl6XRh70a47NufWeKKr
 4XYo+GZ733+5w6rGL4fb4pYDirTTZ5w1YnDDr2H5G88aLwFQ5/U8jRx8BjVVrUqBf+4O
 5Re6hSfCCAHTY+JBcpW8lL2+08+2tDc8RqO9ZxRm3BD8jpUdbJhNZUtfZHuMGIEjxtMW
 jHAg==
X-Gm-Message-State: AFq9FYIXjFmfew+g3CV4NS0xFbE14B77hkyN8dWq3e9H7G0qG8f1owsX
 q5ZZxZBR3E/Y9uDdj/oyYJTphwEX0w/sM61+GP6Qkb2j0oSsTKVltbLx38N8CfoG0cJ8RGas/oa
 E6onNP20=
X-Gm-Gg: AYBFou2c3q9TtPzTx+hyHjfh1+wVILCothzpnRlxTfalqpaLhKChH3Xa9WwUscepoFf
 PdfSXogLvPXPYtYwZc7q3iGrKMyO7TofnBLAtKkYzo6nSWh/2PP9UFspTsOTPPF9yiaJclHIjsq
 DZp+kIhFhhGJqdnGf21lfmYo06qlNl82um/A443jPPkc4xrE+0MsmqOc29ZaUwPYNrZ+3UFj3m1
 GEl4/2vXx/Qwp51tKyjHKIs5LpuDp8R4DJWw3bF2OusdXZ+fU2RkoMrtJxMGWfu6VyWwog7MRRP
 q5s4P2I6YN9pr+JOZiSDnicRANsH7ttdHKhs6C6nNcl4xYJMJh8rewiyE7Vs3rUP8biT7aut29O
 QAv3yFPtpe5WrjcPZgSgX+iwytoXGNWBVx5IC3Mu+o8lN5NmkcZTRzdJxDCbbZzdRFwfA9SQkY3
 eiixuD6QuyVqx5I1yeFgDIUSv13z+q9lSPDdHOAnJwi4IRKMwM+PAFzgsZsb/lHZVWsrZ4J4N5d
 +IY+7s92/XQkd+wImYpIoS9fRRZSWvjx3b778PsvKk2RP2y6Cw+FTXOmaVKnXJUamhM8rs2+PwR
 qCtJ3gQfVagHB+oiCu7CrMEa76BJmp/LELk5Mk4594izvDioo0vJTVl8W094kA==
X-Received: by 2002:a05:600c:c085:b0:4a7:8fe8:130c with SMTP id
 5b1f17b1804b1-4a78fe81333mr70752675e9.28.1793123188778; 
 Tue, 27 Oct 2026 10:46:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92b8812c5sm5518875e9.10.2026.10.27.10.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:46:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/4] tests/qtest: Make netfilter tests accept padded ethernet
 packets
Date: Tue, 27 Oct 2026 17:46:22 +0000
Message-ID: <20261027174625.4025878-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027174625.4025878-1-peter.maydell@linaro.org>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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


