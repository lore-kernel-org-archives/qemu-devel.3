Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C79DCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 07:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svAzc-0004Dy-OC; Mon, 30 Sep 2024 03:38:54 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svAz9-00043M-Qr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:38:25 -0400
Received: from [2a00:1450:4864:20::32e] (helo=mail-wm1-x32e.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svAyA-00008z-99
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:38:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so29051145e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727681754; x=1728286554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTheN6LnDYE/7gHrhVuAVd6VlwGt/9Pb92gg++hmAlc=;
 b=X3JHrWqG2618uAi578fJOJrrORQXtjJvRhi3DdxN4wFJe1K30fYU51IewhSI4B1Cu3
 jVB3Uziw7UzvftRvQ1AmGKme8Gazdfb7cSGZmOcf96W3sVnJXO/QlwuIfrux5wCFglxD
 sHtJjXdh0V3z6R0tEntMC0zFsCrwVui3nB6PQJmfu9LMn5BmIO9JcSNlDStPJMJ5j3ch
 56ejsiSze7Nb8lI8SE4aT8D5Ba34M88S5/Lch9HRgka8iBK+H4S8t1MbHEzvFb3YEwe6
 KrAmGwLxY7p4qhotGpuaxpE/1x9WhiQNseU/wD0l5KhSi8YYYwA3TAJpiX4WX0BTuVZR
 6AbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727681754; x=1728286554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTheN6LnDYE/7gHrhVuAVd6VlwGt/9Pb92gg++hmAlc=;
 b=Elmfka85yKZ43VbSFMqebBUnv3PbSG4VMrlKOvVGXqfaXYnKsDV338CIVdhJGFdoAq
 Q8C7rlcZrsrGBxTppspkJzrSny/rktOXczEwfwQXwfFyJwYSgy92j3fR4+8/ScXPGKNz
 kBmJwqc7apjZRCrpQ3KLhaxSgdxrN5vvqvj9DnC2Pf2VhRRIT6G8Mwz6mOtHCbyDRDrj
 9LYPWdLw24r4HLFW4GTqzI8RIH70/NnJEVcINGp2tkvILAvxj22HzZ9AhHrF/Pbpe1Pp
 A8fk74s+gy7L3YlnlNydsgiXn9ZwJzwfxzFPKDB1rygyLTDztmK/PoQXhnmBwTRHgN5r
 znOg==
X-Gm-Message-State: AOJu0YyC5TRz1/Q3amoBwzftY0pmPDsgzYHv97tHlhkTWMcthmgJFmQ3
 OcfrA5bQHeV8pOyTk/5jCPal9HUQwn7ABvJVIq3KcRTRBGQUM3zHiBq3eQYFMl80jtp+AQiMnGO
 RstQ=
X-Google-Smtp-Source: AGHT+IHEXr3aLIhI9JyM7H/sQJVL2/m/6ZOv4bKIitsJ0XgxUNKM1k7r/JUO4/aOFSZATCirYAHKaA==
X-Received: by 2002:a05:600c:3c9e:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-42f58440cefmr66722995e9.19.1727681754341; 
 Mon, 30 Sep 2024 00:35:54 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ffce1sm142805165e9.28.2024.09.30.00.35.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:35:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 07/13] hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
Date: Mon, 30 Sep 2024 09:34:44 +0200
Message-ID: <20240930073450.33195-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:1450:4864:20::32e
 (deferred)
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Move code evaluation from preprocessor to compiler so
both if() ladders are processed. Mostly style change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/xtfpga.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 955e8867a3..228f00b045 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -415,8 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             }
         }
         if (entry_point != env->pc) {
-            uint8_t boot[] = {
-#if TARGET_BIG_ENDIAN
+            uint8_t boot_be[] = {
                 0x60, 0x00, 0x08,       /* j    1f */
                 0x00,                   /* .literal_position */
                 0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */
@@ -425,7 +424,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 0x10, 0xff, 0xfe,       /* l32r a0, entry_pc */
                 0x12, 0xff, 0xfe,       /* l32r a2, entry_a2 */
                 0x0a, 0x00, 0x00,       /* jx   a0 */
-#else
+            };
+            uint8_t boot_le[] = {
                 0x06, 0x02, 0x00,       /* j    1f */
                 0x00,                   /* .literal_position */
                 0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */
@@ -434,14 +434,16 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 0x01, 0xfe, 0xff,       /* l32r a0, entry_pc */
                 0x21, 0xfe, 0xff,       /* l32r a2, entry_a2 */
                 0xa0, 0x00, 0x00,       /* jx   a0 */
-#endif
             };
+            const size_t boot_sz = TARGET_BIG_ENDIAN ? sizeof(boot_be)
+                                                     : sizeof(boot_le);
+            uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
             uint32_t entry_pc = tswap32(entry_point);
             uint32_t entry_a2 = tswap32(tagptr);
 
             memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
             memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
-            cpu_physical_memory_write(env->pc, boot, sizeof(boot));
+            cpu_physical_memory_write(env->pc, boot, boot_sz);
         }
     } else {
         if (flash) {
-- 
2.45.2


