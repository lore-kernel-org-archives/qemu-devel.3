Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADD8E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8dJ-0004bC-Lo; Sun, 12 Jan 2025 19:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8d7-0004Q9-4z
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8d5-0000kB-Kf
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso26093465e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729308; x=1737334108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukhH1iiiSXOet6r1KeHPOcyBDqXGlGqoY2zWACEw3zE=;
 b=nc6YSx+5k920gc+1n6iFpV/nkMIQiAxTgIxLqUuViPuiaBgVJ6tlEdDL5F2S7XC92k
 L0O4O0r8LaiXxXKXqMl/IHapNQrZXdxFiJVUNHxILcBvuJwrMV8ARxXI9R4MJ4yebqKw
 uobk5CCtA+TcB4foIERUNku55wYdWRt4PlOloeP4AgH46gPmA3eAE1tonq0iUTwHR5PO
 z0aBPMVx+hhZ04dFUiiu65TMh4zCfmNw3s+z4gQz+mgAG1eTUDmrol0nn0Si85/mmSGR
 /QfdF9fnuiG6uBptNqhOSQC3cMnycw6FwTjK9ZQJVibzPWR30Lf62RikMYJydGMQu+7t
 zOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729308; x=1737334108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ukhH1iiiSXOet6r1KeHPOcyBDqXGlGqoY2zWACEw3zE=;
 b=Ffot0/C4n4kCFh6izDMhI5hlJnk7NDE1O5aTDXPQrYFJjW5tr9UKOKKdKIKFa9djhQ
 viDYsoUtgw+Leauh1dKhCqCRPM/ISe8wPAbwxD1JOSRQEkyc41pRK4hgQpHfScTMJZMW
 MHO35lI0QbVn3q14B4wmP0iepvVA2BdZ5DS1BkiI8wGKHwvjV/1wShc/iiI9o7A3WkVU
 so51wRnYmOJmaA2vRjFk0D5sMap0x7IZeRW8Ht928ZRWV/7m9ck4YT6NzoCZhymguUeJ
 0FnxBV57QRWw7aUCpGjwMZkKRrojh18nRqzBjNGhXOUfvYoohYRB6xZT3KMXoZpfz6eI
 J8fA==
X-Gm-Message-State: AOJu0YxjUmYvC8TBJSFNSEdFGeSKGLdEJ5Nn7BvQOkE4x8TkC/xrxmrI
 wGVyuovP2S4XAa33+vp56wztO99ZeXzHrPdR/wdh8ScMsFVNwM6019x84OsY6ReRyTQd7Tjixy6
 d5Eg=
X-Gm-Gg: ASbGncvFp4NHP7dVbv30GfZoO/6laljNvUpuAp8z+ec8sxmoInxSa9YHHBjW34ZVHSE
 e+YeVM3X7mzc5K93Q4kxOtE05GOq6KQoRG7uW1M/MwM2gZxtNGwRQnSx7xvMquuQLYdV3JauIrk
 ZW8yUeMPjiaPGNoLFK3eX5Jm9VXoeY4nmJjTWIdxvd+mZUOvXMFrOQla23WNPas+B/hw0eNh3zr
 zpZXTUPyRS+mL9jHr6T756u0soM1V9DQbnxP68ScswDSea2zLUNUTtJpAGO6+4tGynlQ3ba1vEW
 U9+Jn0DOuRkTmMPrOiPkXSIIqb+N/70=
X-Google-Smtp-Source: AGHT+IFin18wfPWieqTxDbYHm3MTwo3zreDZRLfY3F3DoHY2MbztU9z6jUzsz6c9hu+K6AVxajqdMw==
X-Received: by 2002:a05:600c:4314:b0:434:a802:e9b2 with SMTP id
 5b1f17b1804b1-436eedef4damr95366165e9.4.1736729308115; 
 Sun, 12 Jan 2025 16:48:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89fc3sm162060225e9.30.2025.01.12.16.48.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 06/23] hw/mips/bootloader: Propagate CPU env to bl_gen_dsll()
Date: Mon, 13 Jan 2025 01:47:31 +0100
Message-ID: <20250113004748.41658-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Propagate the target specific CPU env to the locally
declared bl_gen_dsll() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index b2be9267516..7cf1f01d225 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -118,9 +118,10 @@ static void bl_gen_i_type(void **ptr, uint8_t opcode,
 }
 
 /* Single instructions */
-static void bl_gen_dsll(void **p, bl_reg rd, bl_reg rt, uint8_t sa)
+static void bl_gen_dsll(const CPUMIPSState *env, void **p,
+                        bl_reg rd, bl_reg rt, uint8_t sa)
 {
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
+    if (bootcpu_supports_isa(env, ISA_MIPS3)) {
         bl_gen_r_type(p, 0, 0, rt, rd, sa, 0x38);
     } else {
         g_assert_not_reached(); /* unsupported */
@@ -227,9 +228,9 @@ static void bl_gen_li(void **p, bl_reg rt, uint32_t imm)
 static void bl_gen_dli(void **p, bl_reg rt, uint64_t imm)
 {
     bl_gen_li(p, rt, extract64(imm, 32, 32));
-    bl_gen_dsll(p, rt, rt, 16);
+    bl_gen_dsll(&MIPS_CPU(first_cpu)->env, p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 16, 16));
-    bl_gen_dsll(p, rt, rt, 16);
+    bl_gen_dsll(&MIPS_CPU(first_cpu)->env, p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 0, 16));
 }
 
-- 
2.47.1


