Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ABCCCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHr3d-0000qm-S8; Fri, 16 Oct 2026 19:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHr3R-0000pS-JI
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:09:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHr3Q-0008Ju-0F
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:09:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso205462f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792192174; x=1792796974; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SybzrlSeCswFO7FYiuMoW5HJFUUrckT5imgMOwP8N0Y=;
 b=oBor+6UlcLQSYRvNmkwk+q5ocGDGfttX4X7cDQXfzuCgq166bWoUkaLNoRI74P1Tkf
 C2AngeErjFJJjYe4ZyaedFNmz3J0uaG+bVnNfhIKsYVJv+EI4t1Rp9cAiTi4SXe3R4Zv
 avtCaOhpLFB5SCMUzmyQh16v8nIPfRDwlmsu5ymWkAhfzrS22ZgLhwTcCd5yIIDhpmIe
 KFfp8M9uDbPVRswE2ugoxOCoPx+6nDSLtgJQBCDMMPys1WYjST7pjk+rQoUpeo3Oi/JC
 2N8YZVmX7Hdke/UzgK5G9Q33qcEP7hodm5dewCxrEn9XgOPLR33z19lzM0UEEHnLpoRS
 UjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192174; x=1792796974;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SybzrlSeCswFO7FYiuMoW5HJFUUrckT5imgMOwP8N0Y=;
 b=ryCVaEfFT8OpI8r6v5eiaXihJItieQa+zdwYQQaNU+StuG7rZLQRFfKutCVp4XZ8Bk
 SyjviVyFt0ZuhQuxFul8RvfSputjX2o6QXHyK6VppyUelYU2RClpo2HBEzWYVkZ1cDzt
 qFYQig0B0hhBoZISMzXeBNSpuKYJ2sWEmcuqhdJFb3Z6S2k4wUDdPkz6qm0oRW+8jTrt
 icEzrinPn12kTAQD+0A57G5IzxK1BrfrrSJB3JqP+zREkxpRfTJsqMl70Z81DQOcV5V7
 c629eTjpCWYvxwZDX+rCKdD3Po114TzKPsk8qVb1y+/TbIGLz1sYwjzumyAw7phubjUe
 rNWQ==
X-Gm-Message-State: AFq9FYIhSnNHIxPcz8LWlKaUARjOmGw95hgrNf/nkukEHLPq3vgaPUi2
 uJiv6S4lFB8yEZgpwUsGgs3sTq1czaPYFMaj4PJy+Cgqxcr76grY1qcb
X-Gm-Gg: AYBFou2N1OegeWKEnRMOhbfSfKGfwer8aKUfYsfm2jDsvabWSo8p+ZoPU9434ttJbQp
 4knzNmulj+iNLL/JLGTirMC2qKzCT+xEu5zReaBU3QMJq3mBq0I4jXMfoxKVVEhalxv1Vl6gvPB
 DRHf1bMOCDvuI8oa5GsStcAq/vK9aAH0Aukof9U8HGeqlvb5u4G4h8/q/6I1rpkgA8PnLtTWAJY
 qL+hlFYXAcSZLthDrgrbu5jMkY5X4+M1vtiyxazJ9JcaQFGnwQ/Wdoox1GjQbeJO+LkwDB8KwYT
 HntoLoNlAet0i/hgnlGaaiUg4w7dXBWgOQf/7agH0G/GVA5+HkUwMelab4dW0vN8+MJSu8xRYWn
 8Q4J5dqbswAl+2zEeal0dW1/b0jJ+MTjTjuI4uOuFAApk+dX0jUr/bB70a+DTd80S9uywfPN+yY
 DkKuEl8iUyg6f56rcZDkYWaHFuDdtNr+JDBSb3sNzIF9WXuYBebmGQGos5OAMXxV8G2CYmdWnwM
 wuIMtwDV0K4yPkqRYCVVnttH24=
X-Received: by 2002:a05:6000:4a0a:b0:48e:a13:7c8d with SMTP id
 ffacd0b85a97d-48e0a137c9bmr543544f8f.49.1792192173649; 
 Fri, 16 Oct 2026 16:09:33 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f8babsm8319571f8f.33.2026.10.16.16.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:09:33 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sat, 17 Oct 2026 01:09:08 +0200
Subject: [PATCH v3 1/2] char-stdio: avoid closing stdio fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-fix-stdio-close-v3-1-cfff0122a2a4@gmail.com>
References: <20261017-fix-stdio-close-v3-0-cfff0122a2a4@gmail.com>
In-Reply-To: <20261017-fix-stdio-close-v3-0-cfff0122a2a4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792192170; l=1455;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=pvOT90U/WvataGtI03WFfg64IAuhdyZQT2nOcaf1pKQ=;
 b=BssOmKcKfMr0a+ZGIc4c2hEzVtPbjQLrQgvrm5UvTHxdcWPiphk22AaD+I9aO066uHW/tde3y
 i33LmewDOG9DxEHyrQ4s/pJgn1cEY/Cx/w+GH7vfcNSUNRgwtuHvTph
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use a duplicate of stdin and stdout fds to avoid closing the standard
descriptors when the stdio chardev is destroyed.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-stdio.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index f63bf413c7..16b49fd924 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -114,6 +114,7 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
+    int fd_in, fd_out;
 
     if (is_daemonized()) {
         error_setg(errp, "cannot use stdio with -daemonize");
@@ -133,7 +134,20 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
-    if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
+    fd_in = qemu_dup(0);
+    if (fd_in < 0) {
+        error_setg_errno(errp, errno, "Failed to dup stdin fd");
+        return false;
+    }
+    fd_out = qemu_dup(1);
+    if (fd_out < 0) {
+        error_setg_errno(errp, errno, "Failed to dup stdout fd");
+        qemu_close(fd_in);
+        return false;
+    }
+    if (!qemu_chr_open_fd(chr, fd_in, fd_out, errp)) {
+        qemu_close(fd_in);
+        qemu_close(fd_out);
         return false;
     }
 

-- 
2.56.0


