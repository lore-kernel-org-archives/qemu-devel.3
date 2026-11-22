Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD9606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M9AIzRQR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV5eT-00060h-9U; Sun, 22 Nov 2026 06:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV5eL-0005oF-CD
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:22:26 -0500
Received: from mail-pj2-x09.google.com ([2607:f8b0:4864:39::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xV5eI-00039q-PS
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 06:22:24 -0500
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-3b3fa8df5c4so1273118a91.0
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 03:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795346541; x=1795951341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Piiuo3L9loEVIaKH0H90X1sFByguw0+gC/qDB7xB44=;
 b=M9AIzRQRRqw5WI7NeyYb2R2vXMjBnvTxzoyV7MngcezAzhzPbHEaOhsO1V8YR1hD4K
 LsMgaS2VHk5mn0M+VbvbY11PIM5IMW4xC8E7WOqao49oFH9aSDe2qET4mfjrW9TvlUFW
 Qwb+uVvPuZX38Gx+JoR4YULIW4Br9IyN0gmEbbB6VKcCY2ZwZ3n7XBrTWgm3J8PczZBX
 kQwiJe9qwdH1b4+Dhq8OIGylvbUSH5NssB3VDT4QItKtWAQSmaGKjGEUEn6KBsRYre4E
 VoNwHyi7UGBNggHMY6Cy5UFsMic4iz6UUbnT0+g0FvX39peHjgRRqUdXzI2aYDJaAzuR
 OsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795346541; x=1795951341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Piiuo3L9loEVIaKH0H90X1sFByguw0+gC/qDB7xB44=;
 b=nZJw7tEKeImFEz5OHRUlYqcfA2dqHiPrM+oCkik0zTGOoEdpY00de+F9fNK8Kvrodc
 qslXVZAV8pQ0wb3n182JtKxa+Kgr9wd+EXaGuzy7FSo9CpvfLYobMvQTA3AlkE4Slrif
 a1d4+isLz0ddXgB3ZopmDrK0tyXLav4rFKUfNxBGLp/BEbc2C0I9rVhkzyXXFZS651T7
 0tUQyZ6tlOaVewjr+NwPZDMy0vByLIRX4DXrubP8DvQ8s0c80anOmPgDHsWnhnveg8VY
 KJxqqB0vUeekgxWBoj0hBHwUkOQZKEce5KViITsPQX3sxk2S0fhyLkKoN4e7goqsQEO3
 Gkpw==
X-Gm-Message-State: APuU4Z8qEU3xTd1iP2MqGfGI+jQCr51KSwnZST+Jtx+yUYlXxO3hranO
 Z+HdbXRd5XfOFwxYSCLQ+lhizT3cfyxYYHgO0aloNcQTyl4WZMUMJ8tE5cacneDrOqg=
X-Gm-Gg: AZFdTZelugETtQq8joinNh+eCbUc/d1s0c03AV0OPSEaGOb0CwmzDZScleQ9HFlScfF
 /EMy1LjObmrMURqzTU8i4PLdVGK2BneI0+YMqKOCWo5wR5GOMhvFq25KWyQF4mKAup1L22JZqec
 ILWYlx5C0hnMy6kTdfnVSdWGYPuMDkVyLHiqXFuLDPh/qtDaQOJpLgEz2Srt5sHy4MtBMWoqwqb
 ThjHAM5bAlT+eK/cTN1rH0HLyoflaIifhb07qwqt+BNoYdCaJbQEGPdeSe+4SSIta3OKJz2nJc5
 b312TaptyJAVRp+Wr5kwqK6+ILvjZ1nXwsNsis5xDeq68frJNOlgQFp8zYshYj0AWpHciGwj95c
 aUYZo8sanvp94tXmz4QGZdd19svIgX6I3hKTLIPU0mJV1QsCBFRptSmQM8fnMGaVsjI1+yN7W5w
 8/RYFoFt47QOgUc/z+4BWEnmFoHq24IWnGeRu2A2VYf8nKX8t80a9XYO2RdIEwtudLk2C/Bjo92
 QyR2BYYjg4wBFsagc+6Bxl22FybNWRFmbbq0A3RJ4SOrui9JwQS8YUKs8vUnFkuj9IgW+06WOMh
 A1YGLjmXFkWv/76XzeqqnikpweY=
X-Received: by 2002:a17:90b:4ec4:b0:3ac:adce:60be with SMTP id
 98e67ed59e1d1-3b41c8fe3b0mr8100043a91.21.1795346541285; 
 Sun, 22 Nov 2026 03:22:21 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b704cfesm3573820a91.1.2026.11.22.03.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:22:21 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 niming <niming@sangfor.com.cn>, zhuwei <zhuwei@sangfor.com.cn>,
 "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH 1/1] ui: fix QEMUCursor leak in qemu_graphic_console_finalize()
Date: Sun, 22 Nov 2026 19:22:13 +0800
Message-ID: <20261122112213.1645993-2-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122112213.1645993-1-zhuwei@sangfor.com.cn>
References: <20261122112213.1645993-1-zhuwei@sangfor.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::9;
 envelope-from=zachwade.k@gmail.com; helo=mail-pj2-x09.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhuwei <zhuwei@sangfor.com.cn>

qemu_console_set_cursor() stores the cursor in QemuGraphicConsole.cursor
with a reference taken by cursor_ref().  qemu_graphic_console_finalize()
only drops the reference on c->device, so the reference held by c->cursor
is never released.  As a result the reference count of the QEMUCursor,
and the pixel data it owns, never reach zero when the console is
finalized, leaking both.

Release the reference in qemu_graphic_console_finalize() with
g_clear_pointer(&c->cursor, cursor_unref), which is the same pattern
already used for the spice display cursor.

Fixes: 385ac97f8fad ("ui: keep current cursor with QemuConsole")
Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index c995abc5d1..327bbc4a5c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -469,6 +469,9 @@ qemu_graphic_console_finalize(Object *obj)
     QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(obj);
 
     g_clear_pointer(&c->device, object_unref);
+
+    /* Release the reference taken by qemu_console_set_cursor() */
+    g_clear_pointer(&c->cursor, cursor_unref);
 }
 
 static void
-- 
2.56.0


