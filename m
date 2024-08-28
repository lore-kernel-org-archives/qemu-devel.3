Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE631C5474A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjANc-0000cR-Ei; Wed, 28 Aug 2024 00:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sjANZ-0000UY-Tl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:33:57 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sjANW-0002dr-90
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:33:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2025031eb60so55112375ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724819633; x=1725424433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zdwiYqr0w43Mh87Wpao4Jr5QC0LLctdaAixHY2H6x0=;
 b=YhIstGaSHMGvaNnY79jMN+EuraAGwUV3AQMvlXVUvTfb9TWHFPfGC4zNugCTuy2+Nm
 VFOPKEBloi86sQtehZlj1fdniZeDZ2DcFADWhdkx5lEvI+yE2eDcFLB618VTmZGf5PMs
 wC0ErXDm5Vls8yoAoYG4F1RcEvXkyLQA0K/9O4RXYiFlkhgJ6IAtcedOPrXgZByg6S/E
 AgHOPC/xC1QbGwaJKx7qwN6tv5suZFu/dHM+yJBct7iHAUaNSOnlCkXljF3AS3JCNSVo
 YWg+PjW4Ze8Fnq6Z3HKM2fR7QOpDzxSC0kzXUEhUzIfH10EPs5JvB8BjXRax/0ucnEU7
 2xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724819633; x=1725424433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zdwiYqr0w43Mh87Wpao4Jr5QC0LLctdaAixHY2H6x0=;
 b=UYq+T0GJFgiAIbzuZX3bE0rdEYTLKjQDGJWg/Z7nXwVpqVmgoQ7U0UBFxsm57DBMEy
 7abm6TO1yoh8cM5DQ/FHKXbrqYLykxKHqt4DgdpZ49mzPA47jDOwDON4Vp84Kl0ZL1o9
 e+2yQMnLNmw3TjPEDuJLP1bh53AKCQ7keui/D5VTC/pAoLFDHc+8RDKmZzI+riqdPdWI
 FmPebZjc9GbPwjxqiQ1kpZGWtj8tubV5LB18owjbUiZAQCWZzN7NybHuojibc2EgkKnG
 OXQ1yhsOq8WIkW5rAPIYTo6fvIdFrS8f3wXv2HRR8HRpp7ZJVLEj84B2G3+lf8V1nZSY
 RXbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgEobRSoq/7uKFPJNebIzLxGvh9A/xOx2TgwVWOUjLgKJ38HO2ejzGOCArP1cAIP1PdIQaycy8bfo3@nongnu.org
X-Gm-Message-State: AOJu0Yz1/szWQY7oS9/eJsrDyVybuGPbc9gsE2SqDws578lMbeT4qdp6
 0LmlLTxQYfGuRq+2yjaOx5IaS49NXg5Bx9jvfUV3xScr9W51dK7yKmznKg==
X-Google-Smtp-Source: AGHT+IFZA5Iy+G9nCiHF97A2dmNLj29tq3TCYXByNxHVlAcV8NNtXxAY+lmKBMcRTX95kK1hz2Xnzg==
X-Received: by 2002:a17:902:d509:b0:201:f409:ce73 with SMTP id
 d9443c01a7336-2039e545857mr147447095ad.65.1724819633014; 
 Tue, 27 Aug 2024 21:33:53 -0700 (PDT)
Received: from wheely.local0.net ([1.146.81.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557f093sm90342325ad.63.2024.08.27.21.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:33:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] chardev: Remove __-prefixed names
Date: Wed, 28 Aug 2024 14:33:35 +1000
Message-ID: <20240828043337.14587-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828043337.14587-1-npiggin@gmail.com>
References: <20240828043337.14587-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter points out double underscore prefix names tend to be reserved
for the system. Clean these up.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 chardev/char.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 47a744ebeb..46d4798e4e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -628,8 +628,8 @@ static void qemu_chardev_set_replay(Chardev *chr, Error **errp)
     }
 }
 
-static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
-                                         bool replay, Error **errp)
+static Chardev *do_qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
+                                          bool replay, Error **errp)
 {
     const ChardevClass *cc;
     Chardev *base = NULL, *chr = NULL;
@@ -707,12 +707,12 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
                                 Error **errp)
 {
     /* XXX: should this really not record/replay? */
-    return __qemu_chr_new_from_opts(opts, context, false, errp);
+    return do_qemu_chr_new_from_opts(opts, context, false, errp);
 }
 
-static Chardev *__qemu_chr_new(const char *label, const char *filename,
-                               bool permit_mux_mon, GMainContext *context,
-                               bool replay)
+static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
+                                       bool permit_mux_mon,
+                                       GMainContext *context, bool replay)
 {
     const char *p;
     Chardev *chr;
@@ -735,7 +735,7 @@ static Chardev *__qemu_chr_new(const char *label, const char *filename,
     if (!opts)
         return NULL;
 
-    chr = __qemu_chr_new_from_opts(opts, context, replay, &err);
+    chr = do_qemu_chr_new_from_opts(opts, context, replay, &err);
     if (!chr) {
         error_report_err(err);
         goto out;
@@ -760,7 +760,8 @@ out:
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
                                bool permit_mux_mon, GMainContext *context)
 {
-    return __qemu_chr_new(label, filename, permit_mux_mon, context, false);
+    return qemu_chr_new_from_name(label, filename, permit_mux_mon, context,
+                                  false);
 }
 
 static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
@@ -768,7 +769,8 @@ static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
                                           bool permit_mux_mon,
                                           GMainContext *context)
 {
-    return __qemu_chr_new(label, filename, permit_mux_mon, context, true);
+    return qemu_chr_new_from_name(label, filename, permit_mux_mon, context,
+                                  true);
 }
 
 Chardev *qemu_chr_new(const char *label, const char *filename,
-- 
2.45.2


