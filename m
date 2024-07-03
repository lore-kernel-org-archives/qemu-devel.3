Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C029C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 19:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP5eg-0004NB-RK; Wed, 03 Jul 2024 15:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxtram95@gmail.com>)
 id 1sP5L4-000571-RG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:08:22 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxtram95@gmail.com>)
 id 1sP5L3-0006qx-71
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:08:22 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-700cc388839so3592542a34.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720033699; x=1720638499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qT2GdtFlbiK+bt51XxWT71kip8Km0EdPAx9W2bU1URA=;
 b=UH2O4IRy5KQTBK4UkX1NMxGI8dY5FVe7HChxIdxunGt41lYeszV245V+y9bx3Ld4In
 /yCG2MYeXK95I8ZD7wMgiYgDgqu2zW59wQTwABMetkQIXPSqeGCFX2FHejdGnYhkCKD2
 5gFasEoYPumEQI0QRgXkh1V+1Q/wW9uK+EwCKT14dyh9qpGKk/m7s76FwbwjEkZFPlrb
 GeczLK71GMKKPavGyqd2b9qb5fnrAxaPrSG2oHBMgqS1A4fYrS8+71iMQVFNT2q+ZUdw
 efVAxXQYgky77mX5nFeJXp5ifXMhWSqoEk+3i9aHUw7ajPvshFiMgoe2N8sL6HhXbEPA
 jm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720033699; x=1720638499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qT2GdtFlbiK+bt51XxWT71kip8Km0EdPAx9W2bU1URA=;
 b=F3EnwVcJ0FHsOmlWWSJM67RJ1P2EtG9vagbwr3tuK+I61mLy5f+i4NwOGAobecKw7f
 WFArVXTxqon4qd472DheUJWeEb6HFo7ZLJ03NZgOv0FyrbGEnPk+zVw3RZQCsV2ZASn1
 ZPLf2t+jbbe7lN8E5ozYCKiqtFTY4kvUY5DXoE+/uP9tN92sAWM+Xu7LCHprPkV4pZXQ
 VuBxFeFn94S36tSNbom4D5IER/uU4I5QE4UiLIC9wkAEGtmlW9A26I2unXQsZojHehUI
 FbLpGpW5/2vxafrDQ8DXFfChquVgodsuWX+eCSQhSDV2XQ4S5sbtVeNu1iWpNeZ32kvc
 3CgQ==
X-Gm-Message-State: AOJu0Yx/xWunprihuEIpxtd/5bkCwbCowGS8RNMgImC5bo5g8WVrAyDQ
 ESL6xWiKykBIOO2OGs+gJbndIrBfLcmXiTMdWssbsdJH4pVR8lxq
X-Google-Smtp-Source: AGHT+IFtc6eBQ+IBZTO7X6VF0iUSQuilzqW6b/UEJtEpMB2kd1igkjzeDzR4Q/g5RSTh0M05LeR41Q==
X-Received: by 2002:a9d:7508:0:b0:6f9:9a98:a6a6 with SMTP id
 46e09a7af769-702075f32c4mr14157346a34.19.1720033699532; 
 Wed, 03 Jul 2024 12:08:19 -0700 (PDT)
Received: from localhost (47.ip-149-56-44.net. [149.56.44.47])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d69264fc0sm598920885a.1.2024.07.03.12.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 12:08:19 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH] char-stdio: Restore blocking mode of stdout on exit
Date: Wed,  3 Jul 2024 22:08:12 +0300
Message-ID: <20240703190812.3459514-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=maxtram95@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:28:37 -0400
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

qemu_chr_open_fd() sets stdout into non-blocking mode. Restore the old
fd flags on exit to avoid breaking unsuspecting applications that run on
the same terminal after qemu and don't expect to get EAGAIN.

While at at, also ensure term_exit is called once (at the moment it's
called both from char_stdio_finalize() and as the atexit() hook.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2423
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 chardev/char-stdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 3c648678ab..b960ddd4e4 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -41,6 +41,7 @@
 /* init terminal so that we can grab keys */
 static struct termios oldtty;
 static int old_fd0_flags;
+static int old_fd1_flags;
 static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
@@ -50,6 +51,8 @@ static void term_exit(void)
     if (stdio_in_use) {
         tcsetattr(0, TCSANOW, &oldtty);
         fcntl(0, F_SETFL, old_fd0_flags);
+        fcntl(1, F_SETFL, old_fd1_flags);
+        stdio_in_use = false;
     }
 }
 
@@ -102,6 +105,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
 
     stdio_in_use = true;
     old_fd0_flags = fcntl(0, F_GETFL);
+    old_fd1_flags = fcntl(1, F_GETFL);
     tcgetattr(0, &oldtty);
     if (!g_unix_set_fd_nonblocking(0, true, NULL)) {
         error_setg_errno(errp, errno, "Failed to set FD nonblocking");
-- 
2.45.2


