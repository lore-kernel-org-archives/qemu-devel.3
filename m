Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04729CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 02:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHAkm-0008VF-A1; Wed, 14 Oct 2026 21:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHAkl-0008Uc-93
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:59:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHAkj-0000Ae-KO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:59:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso4274337f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792029568; x=1792634368; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bJEDJqn+RcXzns9wteQUg6pjdFBNbHjn/ja5BU37btc=;
 b=GCXaB8y2XRM2RruEyB+grUUYPgmE624AUb8O9TA5/sflvEymt8Q6DGIsWfyV2DP/rh
 4eTN7HBnL49NgbKRE+2c8t5Nr5VW6GQBiccpoj3PQxaLrkHe7pUuIrnc36cHcRdDbipT
 1C/AGfSwaCZwalfLffw8S/w/u4B6GX75U6KTKMWWEN/JYmzd2CMnfOKueQYGiz8nZtzU
 H7b1h9vv4eKx87ol9tclbzRTVMDEyPnIIQWMQMVFKuOsr5hCvkv2LAQ+twd2xb5Wh445
 G+Hk/iSdzTy2sXlPK+TcudkFiF1xnMroQd9PUqRMtIz5Ov/xWIaXfJjPYpe89v1b+Oi/
 RJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792029568; x=1792634368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJEDJqn+RcXzns9wteQUg6pjdFBNbHjn/ja5BU37btc=;
 b=xj1mqlZsal0IEXpC8Wa5HIJE5jBMW/oPMkrXw6oeleCG3fGfHD8atC4vTY11IerQZr
 ue0g3i+sfAHhqJnFETd5CXL0mLhTnyeIeAOjvJq5mKyYxqMRwTepmzaqiOwnURek4AI5
 ISBwuCbpK7TEcKrp6egX9uzWHhTJS05RlVoU2c4nBXMHya210Bnv/LE6yNmNXERrcZFS
 cdYi1Vln02w9t2swWGN7XmGSu0cxAePCqGOD3D6Ir9U/uEhECJ2DFGfmfab9LfyXdOGB
 UO0sVsnWsfGXFmPCFHVnyTuySwz/HIUCwluxgonYXvYh6AzJdagXBSjUOMVidzTtc9Ol
 CjCg==
X-Gm-Message-State: AFq9FYKIRj0yzed66JMr/rgBzFZBLKGgg2rVrw7xTS5CHtQSfURrYd1H
 Gux4u9yRxBFogWb1JWNWdlWXfadT9JXVkkDXiLF/fTAHHn+GYff4Bn5El8EBRZv9
X-Gm-Gg: AYBFou1f8aOBfN4LVN9OvL6ZAtMlOTbceM+zF0LguQhS2RK/+69AKgp/xmofnpb1YMu
 5cuhCjoEHHjuQxCiVft2iIfdxNh5wFutqfzUOl45YASSCIQig0GOi4Na9PHrnIkPSfGU1REyhSt
 O/wYYKSR8JYwdpy7/bh4YFZ7axWZayQFlgbWDfOyOIZecGitUxS4W79zeQkFgKeQAUxoSyOdjdG
 yCUjNQ6XuO1oDXSjUvUlxJhGwQ6hb8wJsRxL0s2XZ+S+3NWMfdYwXowyMJTeyF1mxmmOK6W5TtG
 DfoSOiIAO7vZQq8v0EbCFhqqK19Dubg8E13icg8wRnKKQAWojt9RJYlwBVjAj5sPkrOYmf0hWGk
 h8nhPXmg8a3e+kHcNudVC/ysw9E3VrLYXIwqoSd1RZUPStcpWDaNgsaQDHlnKvtItlwACaJpuWd
 swALlGmkteQgmNz1EBjgFPe83x8ovLjxU3mU1sr6AW/kqTTWs4ba0IRgF2HN6UbZ1PTUeIV0i3M
 SdS7+VJluJH4UYhBWMF6h0JVKs=
X-Received: by 2002:a5d:6f08:0:b0:48d:bae5:41c with SMTP id
 ffacd0b85a97d-48dbae50634mr33889907f8f.17.1792029568139; 
 Wed, 14 Oct 2026 18:59:28 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4f34sm15900886f8f.28.2026.10.14.18.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 18:59:27 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Thu, 15 Oct 2026 03:58:24 +0200
Subject: [PATCH v2 1/2] char-stdio: avoid closing stdio fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-fix-stdio-close-v2-1-0f01e6580e24@gmail.com>
References: <20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com>
In-Reply-To: <20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792029564; l=1413;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=69Gk2in8CGCJqPY5epdNvHxcT6nKbIw1hANRw2L/9vQ=;
 b=rK72/iDi0o3IxX59P86AO9wi7M+OTYdsOMAeBokA/LqX6KxUSHeRN7TGN0K1vB7nfbuPNXyML
 jYlI1VuDkgWA0nJz46a73iGhW145t5iL0nRKHUXGgVzNMs1mO5BpWek
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index fe1cbb2d88..19860e960d 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -89,6 +89,7 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
+    int fd_in, fd_out;
 
     if (is_daemonized()) {
         error_setg(errp, "cannot use stdio with -daemonize");
@@ -108,7 +109,20 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
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


