Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D20F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcyi-0003fh-RK; Mon, 09 Mar 2026 11:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxK-0001cR-2O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxI-0000gX-EM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso6217043f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071737; x=1773676537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KlFX7pvMsJ8IE89oNifNcpYvuqCaxg303tu068sYy1A=;
 b=S1LvLNv6yqFPy22lIIHk99Y9WmXTZDpv9PC3F+2cM0RMEiDt6Zk0xRwZPxeSf4hN8M
 +sIjyYoVO1iwBarRN8L00gOC8A5K1L+B5nL+o/zA9bFgEF5wjhDp3CfurgraipHL10LI
 QM0NjgT8TdT4h6TDPi2i19+mHYdoRyk9HJHTG7Xij+y9BO5iayqyFF+OUJpZhLEwVlv2
 RxbTyzDl3j/QzQhBWo3k6nNEceoo4WSF4haQYglkJy9+CqSZn3lRLWQzPt2Pa4G7lOQe
 GtLrwtNeSsv6ihOjX90L0jyuaL9opiQjMe4m4YALlM789UPHZA8PTxMw5ET+HMm28v5n
 Cd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071737; x=1773676537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KlFX7pvMsJ8IE89oNifNcpYvuqCaxg303tu068sYy1A=;
 b=HE637+0xcQaD64k3r3QkyCdsanwt1JSlafY1yj2a8b07rV5DAxc1pNn3HAnUzDgKUx
 KX25CSehDdigCG/6I94Bweagm7TCGuJDwp38YxR0kI0+miUg73UT1dDSBu20kivGB8Jz
 dIm8I3Jd/4FzkHWZcDiKpWKmvNsKkTGc7QYl1M56JUB2VLdOR1WMDcS+7j/fQDxuVj5M
 XctlS/3YySQxTrENSuQX9dzjlewJ1A9DEQJs9tWJsOPGlFlpmLPHKodmg4Phdw2hkQ2p
 LewS2qIz8tBbbAaJz3wtKuOFVaUJ0FQ4WSn+QURq25G3IArhmBY5hukomnsxEbJtFheA
 fzSQ==
X-Gm-Message-State: AOJu0YwGVz8lM3Z42QHEbHc6XnlRxlQsFcJE6XjoIU4pPN1/l+AClxcS
 NZxXPw5OlfUb+ss8fERVOoQFt06GJdsxzASM/4HgLzqlqBACX5lbCLLUcvHkO7BM9/zQjGC1DPM
 pHAurdJ0=
X-Gm-Gg: ATEYQzzM/ckecE/I40EaF4XKB5a5aBGjggxwupoqtL9LqXwjDrewi8mT8dAjQmFC3Ps
 z03E7d5nupqAglI+Y7CO8+lxqhAx8oaES43m4rGIAgYJRDbbDM7UiTD0Hw/zl7ogEBsiGplWz+k
 rrO2ym+GT5gVL+o4IMR7Soa9Yxxor2GyEykyS619woSXBBAqV+XdiJz0WOv0q7gOB255hWqsj6v
 XtziPULORILxdcouNKM6HzHUk5h08oG5Tk7WECprEziGiOHTw3QMrkPUcZf5gbK5pikGUASG/1M
 zbj24MwHSyZqQG4XNJQPgll1vdD8dqZYqaJEcprFqWuvnRwc09W2G5piT6KDnzZbKMtnAAK1W77
 QWZUIoOKwWTtWYSrrZX58kd0RieziY9cAROxT7mx4/rS0EtkBR8+MABk6Wkgeo0k2tMXWcfZiN7
 7IX+B7MqXX99ROopu/b57/BJusnmYmLmhlKawykkqa0jS6r6HDBD8gLWXWkLxPm00Qu4cGfZOQ
X-Received: by 2002:a05:6000:2c03:b0:439:af96:29ea with SMTP id
 ffacd0b85a97d-439da895476mr19914333f8f.41.1773071737161; 
 Mon, 09 Mar 2026 08:55:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d95dsm29921110f8f.7.2026.03.09.08.55.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/49] net/passt: Don't try to read the pidfile if passt got a
 signal
Date: Mon,  9 Mar 2026 16:51:59 +0100
Message-ID: <20260309155219.62400-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Foley <pefoley@google.com>

g_subprocess_get_if_exited returns false if passt was killed by a signal, so we fall through to trying to read the pidfile.

Update the error when passt exits to include the exit code.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Peter Foley <pefoley@google.com>
Message-ID: <20260305-passt-v2-2-f0582198afc0@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/passt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index b3d4b713140..4ff94ee509d 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -270,8 +270,17 @@ static int net_passt_start_daemon(NetPasstState *s, int sock, Error **errp)
         return -1;
     }
 
-    if (g_subprocess_get_if_exited(daemon) &&
-        g_subprocess_get_exit_status(daemon)) {
+    if (g_subprocess_get_if_exited(daemon)) {
+        gint status = g_subprocess_get_exit_status(daemon);
+        if (status) {
+            error_setg(errp, "Passt exited with code %d", status);
+            return -1;
+        }
+    }
+
+    if (g_subprocess_get_if_signaled(daemon)) {
+        error_setg(errp, "Passt killed with signal %d",
+                   g_subprocess_get_term_sig(daemon));
         return -1;
     }
 
-- 
2.53.0


