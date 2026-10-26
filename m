Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581F606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L3d6gvUm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKGE-0004Y2-OF; Mon, 26 Oct 2026 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG6-0004Wq-E9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG4-0002Zs-RB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so24822065e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793019419; x=1793624219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aY84rM7uVtYYZDOMjGD+JkxdYBM6fj9mhrGf4jTcgBE=;
 b=L3d6gvUmKoNrrfIKdgkiTc0k/Nhmi5ehd2ybwiE7bEmjp+GLOtaA/c2Ev6Z7Fqc6bk
 jpC2igG3uqRQ5mV8NJGaGQjWoPh5mEx4RyrVq6HszRmUcgfJJTpdOnaosYb8aEAWVI/j
 8XU4xPwiNUjlK+76cYRfb9issTxkqk1JcnjnsYqqTFc8pbXgE6Ox+6jgfTvujEmzb1ai
 lrZpQ9GyiGbslcLZCnVImuln18UIM9Ovj1ktzA67hi3XP7Jtuk/MvlSSRCRHb+CJF+RN
 t6gcIUh/SbH2HJeEyXhQCo64gRtKWijTuByG1Izlcto6HqywyVAqfyfJiJoA4rcRlfsA
 D6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019419; x=1793624219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aY84rM7uVtYYZDOMjGD+JkxdYBM6fj9mhrGf4jTcgBE=;
 b=mjYA05JO+CL/bSuQSVWGC5CkwGZUrNhY2MurPc+fJgAlvIU6mIwgNGaW+YuxdhCvOJ
 jzZHqAuLcG/OlDx4WHFqmQwKLGuq+iDKviP3M2eO0hF7tHz/aYJgkfzQ86Z1p70JBwxy
 3mfjxNj8IuS6nj9yDSuly47vFVUrt/OM4g54ueJ45WtVwNNc/W+Ggom7tbpzEJRSKg/O
 64V1kwqtr8pTnazte9Dg0xSazRvQTo+AU0yFgnnXcE46xRpeuUUf2SSG3CKRR6mlaj7b
 ZnqXIlGeoyfMG7DohNTxmOW3ukt6k4hiQS8UBPzLr8KaG+6UjByI8ee1QTBRBnLcajBU
 HtIQ==
X-Gm-Message-State: AFq9FYJM4+7fXK29KqavGCgD1qr0vH7v4jHCUvbfZij6Q34Q1fDKxMNT
 abIUkHqdpreeny9D85IbTTLNgeFWqfllyw92SMr/D9YS5y2o6qb/QQksGDVIgycKaBCa8iO3NQT
 23hKw9VE=
X-Gm-Gg: AYBFou3gbBr7AS9E70JZOwgqcb2teWgsCAKOEAjIqZ1Lxq5Yp4u3nFgyw4aaZ90Rxwn
 JY+eCvygywFaNejYTALRmvSdtvCYoaBTXV1z+C72Im0X/YbkMQoxtFoQZCBV2ppKf9cW5jsl7cp
 9Mrg0r2bKkckq+jKUuV3VcJxijpR2iOhXuTYcsKNaxYGnWVygtRsugRgIcdQ6girjc+Ol7mYcek
 2DILeBnNPN1lMOJBK0kJElqg3+PwmKQ1IGQAarAiHUoAoxFCZcTDn6ID3GrrDmpRdJjY6JrDGg/
 eNr8kg475XTye4W3zenIsQtDGbgIaPiJgKThK+y/LwJQXlIN/+MvMTi/f0z2qRlkX35GmWdVKPc
 oFhDEHVNsBFnlP5gwWPVvhsulj9pvWZ6cykkAwHtcY4tGLS3ZYo3HZK2k2f/sRdpM0cRvetFKZK
 jZzE3xqkPpNd/hQsK+7XTGBJVK5P5/GsysjLrg/CNpHP/OR8DYWY0lKhVAxgWcKuiHSWs4e6GRF
 2zO4TTdwaHEiW2KVabO9fQD1DqmXKu5eefe0Fy7fnyQvKk3Y3dAlkv9ZiYy4x9AbShRqWlWpYL+
 DS4eQatklaCoJxxS0UCIeZH9JfSJ8mn9hoClZ7cjVECdc7sjV+OD0v/7ri21
X-Received: by 2002:a05:600c:c101:b0:4a5:87a:50ba with SMTP id
 5b1f17b1804b1-4a5087a51c5mr59882215e9.33.1793019419270; 
 Mon, 26 Oct 2026 05:56:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm20740192f8f.49.2026.10.26.05.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:56:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] tests/qtest/libqtest: Use a GArray for
 QTestState::irq_level[]
Date: Mon, 26 Oct 2026 12:56:55 +0000
Message-ID: <20261026125655.2668658-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026125655.2668658-1-peter.maydell@linaro.org>
References: <20261026125655.2668658-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Currently we use a fixed irq_level[] array of 256 elements in
QTestState to implement capturing the IRQ level reported by the QEMU
under test so we can return it in qtest_get_irq().  This is smaller
than is actually used by some devices, and if a test tries to
intercept more IRQs than this and one is reported to libqtest then
we'll fail an assertion in qtest_rsp_args().

Switch to a GArray, which automatically resizes as required.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/libqtest.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9e7a2d43a18..22b0dc193c9 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -42,8 +42,6 @@
 #include "qobject/qstring.h"
 #include "qobject/qbool.h"
 
-#define MAX_IRQ 256
-
 #define ACCEPT_TIMEOUT_MS 250
 #define ACCEPT_RETRIES (4 * 50)
 
@@ -88,7 +86,7 @@ struct QTestState
 #endif
     int expected_status;
     bool big_endian;
-    bool irq_level[MAX_IRQ];
+    GArray *irq_level;
     GString *rx;
     QTestTransportOps ops;
     GList *pending_events;
@@ -501,7 +499,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
                                        void *opaque)
 {
     QTestState *s;
-    int sock, qmpsock, i;
+    int sock, qmpsock;
     g_autofree gchar *socket_path = qtest_socket_path("sock");
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
     g_autofree gchar *args = qtest_qemu_args(extra_args);
@@ -525,9 +523,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
 
     s->rx = g_string_new("");
-    for (i = 0; i < MAX_IRQ; i++) {
-        s->irq_level[i] = false;
-    }
+    s->irq_level = g_array_new(false, true, sizeof(bool));
 
     s->fd = -1;
     s->qmp_fd = -1;
@@ -693,6 +689,7 @@ void qtest_quit(QTestState *s)
     close(s->fd);
     close(s->qmp_fd);
     g_string_free(s->rx, true);
+    g_array_unref(s->irq_level);
 
     for (GList *it = s->pending_events; it != NULL; it = it->next) {
         qobject_unref((QDict *)it->data);
@@ -778,12 +775,14 @@ redo:
         ret = qemu_strtol(words[2], NULL, 0, &irq);
         g_assert(!ret);
         g_assert_cmpint(irq, >=, 0);
-        g_assert_cmpint(irq, <, MAX_IRQ);
 
+        if (s->irq_level->len <= irq) {
+            g_array_set_size(s->irq_level, irq + 1);
+        }
         if (strcmp(words[1], "raise") == 0) {
-            s->irq_level[irq] = true;
+            g_array_index(s->irq_level, bool, irq) = true;
         } else {
-            s->irq_level[irq] = false;
+            g_array_index(s->irq_level, bool, irq) = false;
         }
 
         g_strfreev(words);
@@ -1192,7 +1191,10 @@ bool qtest_get_irq(QTestState *s, int num)
     /* dummy operation in order to make sure irq is up to date */
     qtest_inb(s, 0);
 
-    return s->irq_level[num];
+    if (s->irq_level->len <= num) {
+        return false;
+    }
+    return g_array_index(s->irq_level, bool, num);
 }
 
 void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
@@ -2100,9 +2102,7 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
     qts->pending_events = NULL;
     *s = qts; /* Expose qts early on, since the query endianness relies on it */
     qts->wstatus = 0;
-    for (int i = 0; i < MAX_IRQ; i++) {
-        qts->irq_level[i] = false;
-    }
+    qts->irq_level = g_array_new(false, true, sizeof(bool));
 
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
 
-- 
2.43.0


