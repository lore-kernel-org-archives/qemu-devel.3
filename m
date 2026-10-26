Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=luGXzujG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKGB-0004Xd-Lj; Mon, 26 Oct 2026 08:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG4-0004Wa-RR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKG2-0002ZQ-Uy
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:57:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so10242895e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793019417; x=1793624217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Go2SlSxJgFJMJitrfP75bb+tTb1pQf8ohmULLsU/JQE=;
 b=luGXzujGuRk3sZk93nf2Cb2fGg400LJBimy0DLg6DPP1AcqTI71816aJ1E0jWB/rLq
 2u0OYHRDOjdni9F/9WOy9/mVbLQ5O9W/Nx1RmxYal4PhK1lN0Hcwlw/i6F8iOcm+yguY
 3Zyn/fbnxyVLLBd/YmW3ioI+/3WttoyAA5FfJDAGuxOAdOEykairgw3GoTjoRCNPc0aX
 PJW8C9JF1JFBo5122XySUXWCrrxtUTPHCJI+lMI0riTq/o80HxpZqY/O4v+oEdwcx6yA
 XrvTvWQiwY3fCgdvo8grzHLKT679fsDhjHBXeRj6GM714WkPTaJxS0xWwdd2WRKe3Qp8
 g04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019417; x=1793624217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Go2SlSxJgFJMJitrfP75bb+tTb1pQf8ohmULLsU/JQE=;
 b=MjdH8hVozFiX9sxojxc9q0a51P0uLk3ENmI8Dbm7YqJ3gq5h0QYs8r9oLaPcGZAZxn
 SGaTe7jnFKccugFcZ2ZjiAuCRnK3CjWN+XypPEf6hY7jLGfJTWxEMxcpQ7MGvuuTJN4V
 gJh+Q7H/N7ZrzqEhZxXF7bhrA9UdRMzYbu/EuGpXxSECcoVVn4as+t05XHeFKQtQbDUV
 y98HeXUGThwcHX7VlxEciOU3nmhYliqs/5vFf3/fjoXEDNd6wtJC4BULIKRESXdtv2LI
 grQ7Ot34HjMQ9+t7NJzeurPgxSeGJAayjQCJvk81Fdxp8/Qj04rCs3QWAZqFkC4L6xiu
 WMoA==
X-Gm-Message-State: AFq9FYIX3oybx0104lPQG71HIvkF1FNT6qhXmgfROoDc+po4cpRFCu7j
 5elyDrx5BABCTUUuBbNeuRLXOQtueD+AD9vcEKX2q84CqvaV7ThKMospcjOsco5g6D8Q1D/tOJy
 4xgFWzOo=
X-Gm-Gg: AYBFou3oO4UDJdqgQAZ3q3NgYLaN+Ej3bj+4bJqQYVgz8ifiufIAMqYShnPtCYiAetM
 4OyasJ0RKivwS1NfKGaH4a5Oj7uLoIpR0bpZcIe41UgyyaSNZ9whANsTEUCQQng2wIQ3iWmdIIa
 x2dBnQldpQnrNYKFrO71wjfdeta7m52FG2DCRTCI/yeVzRIfZJ+IV7VmMVd2cdM0eOHzgiTho6Y
 Db3WnRTvtv4jy+kS2E37C12PBnH0u551HB+np+1DKtPAVxIJ2Aj09IjkRZScqscTGrR5gnI4pgf
 XinPbH+bjs4sKH1dYtTgI7KtTmL/7z3G3XaN/wl8Lw5Eozintn0KvUK/GxE0kLZjsmEC3tEEPdr
 oVeyucpQ8wJ9GS0vFXN2YOB+kwr2HsIs47IXEuZWhy2WGoVbM1fbvaf9mDzQ1QpIFR31Op81rAp
 oX2guQkpMPc3fyJsPDvgU+2iZu/1+R9dZlHdqvnA9n4qbuzA2q7OJo5RafaDEmazX3wGZu0h4UG
 NVHGFIolFY7KOxb2YTG3L7KdAcSdIHDk0/uPS6KEqow/Zfj1CmwDB8FpgRWWVZwmsOTCq++i+dU
 +BTwTNgZ7oogMffAbyHrs+b+10+ke+hd+McP1LRtgba+qVJOfZR8m40xljyq
X-Received: by 2002:a05:600c:a318:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4a35aee2cfdmr91609605e9.31.1793019417365; 
 Mon, 26 Oct 2026 05:56:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm20740192f8f.49.2026.10.26.05.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:56:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] system/qtest: Avoid fixed-size irq_levels array for IRQ
 intercept
Date: Mon, 26 Oct 2026 12:56:53 +0000
Message-ID: <20261026125655.2668658-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026125655.2668658-1-peter.maydell@linaro.org>
References: <20261026125655.2668658-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The current implementation of the irq_intercept_out and
irq_intercept_in commands uses a fixed-size static irq_levels[] array
to track the state of the intercepted IRQ lines.  This is sized at
MAX_IRQ == 256, which is smaller than some real device models use
(for instance the GICv2 on the virt board has 384 inputs).  A test
that tried to intercept the inputs to such a device and then assert
an interrupt over 255 would overrun the array.

Reimplement the IRQ interception so that it allocates an array
of the required size rather than using a static one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/qtest.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 47c954838dd..a3de815ce65 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -57,12 +57,18 @@ static DeviceState *irq_intercept_dev;
 static FILE *qtest_log_fp;
 static QTest *qtest;
 static GString *inbuf;
-static int irq_levels[MAX_IRQ];
 static GTimer *timer;
 static bool qtest_opened;
 static void (*qtest_server_send)(void*, const char*);
 static void *qtest_server_send_opaque;
 
+typedef struct IrqInterceptState {
+    int *irq_levels;
+    int num_irqs;
+} IrqInterceptState;
+
+IrqInterceptState irq_intercept_state;
+
 #define FMT_timeval "%.06f"
 
 /**
@@ -327,9 +333,10 @@ void qtest_sendf(CharFrontend *chr, const char *fmt, ...)
 
 static void qtest_irq_handler(void *opaque, int n, int level)
 {
-    if (irq_levels[n] != level) {
+    assert(n >= 0 && n < irq_intercept_state.num_irqs);
+    if (irq_intercept_state.irq_levels[n] != level) {
         CharFrontend *chr = &qtest->qtest_chr;
-        irq_levels[n] = level;
+        irq_intercept_state.irq_levels[n] = level;
         qtest_sendf(chr, "IRQ %s %d\n",
                     level ? "raise" : "lower", n);
     }
@@ -353,6 +360,13 @@ static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name,
     *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
 }
 
+static void qtest_init_irq_intercept(int num_irqs)
+{
+    g_free(irq_intercept_state.irq_levels);
+    irq_intercept_state.irq_levels = g_new0(int, num_irqs);
+    irq_intercept_state.num_irqs = num_irqs;
+}
+
 static void qtest_process_command(CharFrontend *chr, gchar **words)
 {
     const gchar *command;
@@ -413,12 +427,14 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                 /* NULL is valid and matchable, for "unnamed GPIO" */
                 if (g_strcmp0(ngl->name, words[2]) == 0) {
                     int i;
+                    qtest_init_irq_intercept(ngl->num_out);
                     for (i = 0; i < ngl->num_out; ++i) {
                         qtest_install_gpio_out_intercept(dev, ngl->name, i);
                     }
                     interception_succeeded = true;
                 }
             } else {
+                qtest_init_irq_intercept(ngl->num_in);
                 qemu_irq_set_observer(ngl->in, qtest_irq_handler,
                                       ngl->num_in);
                 interception_succeeded = true;
@@ -861,8 +877,10 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
          * used.  Injects an extra reset even when it's not used, and
          * that can mess up tests, e.g. -boot once.
          */
-        for (i = 0; i < ARRAY_SIZE(irq_levels); i++) {
-            irq_levels[i] = 0;
+        if (irq_intercept_state.irq_levels) {
+            for (i = 0; i < irq_intercept_state.num_irqs; i++) {
+                irq_intercept_state.irq_levels[i] = 0;
+            }
         }
 
         g_clear_pointer(&timer, g_timer_destroy);
-- 
2.43.0


