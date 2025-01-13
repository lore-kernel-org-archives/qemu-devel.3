Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D24E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8dP-0004h8-62; Sun, 12 Jan 2025 19:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dL-0004cX-Mr
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:48 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dK-0000m8-2U
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso26414545e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729324; x=1737334124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ff+NOtJyQbo2r4PRwy1cOlEv+D/dc6it23d0jmpFRLY=;
 b=ANnQ192c13JrfdtU3gqgLaP30TckYvsO+TXts7Kt1SAc3l/Z0MbdQaZmISx9s53xXM
 iwwwPkqr7pezSDzKvkHqy4fasBCPfrz5Voj7c+C9RXomno++W7Pn09n8DGwLNawG4UlZ
 8eRPAVExIYGYg2P8TRK89Nk6A0DIdfddr6PFb0pzXUVhL8PEr9BbqqV9j2Mzv8u+cy7Q
 /5LQzPXgv6HGHXAC1//ieiqhy3GSnzzouEt8y+VK2T5dwU/dx7nHQlrtn3n/NJcYVxLk
 b6mNSTnP6FhJ948tSha3jRNaEkIcY6Q1PivKPjjSU4GIr3ZFZYCeb5Tk09EX4G+OTq4t
 PePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729324; x=1737334124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ff+NOtJyQbo2r4PRwy1cOlEv+D/dc6it23d0jmpFRLY=;
 b=hrjPW0Pjkq46viYQAC7kGDiV7WA+kO2PQcQALUCFVP3CcJ0wFPf6kiWNMfL44z7Jvt
 efvpmtrzddx5pZl/Y5ullN3cCeN/CwIz58BNoFWCwiCMkFwhQmuU9kVTNTPUT6mHBaBV
 lH5Qr+mKrxl26s2nObdPCNRrfQhhWyd1DCgofrsL6aXoDsugS8sf5n9bogsIXs34vWEm
 3yqcodgLF+Qgj+FumS7xBshLDf1whVwcta7bRdDCTyltbRJtdz4BCwYqO3LOUkvzGU2n
 ANMf44g4e0lUbAHzNH6E9JHMztpc66S3+An8D0IOBMSi5iITFEaCzBfY2fTP4ncSQwl6
 UNNQ==
X-Gm-Message-State: AOJu0YyBmM7v9fDTaS62mDX2S7c4hMbeR/D6rH01KyyGGkuo78jmMvhL
 3YZB+y6y/w0K0ci0oIsUPLKpEdzBsrGMSkuPxpwYbkV/UCRyaNtL8OH+hlQGymQ79QI9htJmAKJ
 zgRc=
X-Gm-Gg: ASbGncs/0/UaQljkiJYA7d64fLBRafcpyhG/g2FLngBWAphfvmSKsgL3YN9sjbVawcS
 x5v6V5rPIbKqMSgepyQxBT4UNba3vGp9G8nK1lako+7RhjaU6b+/9j8T1L6snzMpmMbv1VC8SoU
 P0TkPRhebvQQqILcTSlMk8qVp6erwBhuAM8+ZanxBf9RrfGhsMcvxYWvI0MBx1HwvZhJ00BDtPo
 arqrQ708NHdKRsXt0Vqt8LOFF3y8y+9wVerncv0CP+ZhUf9Ik7W/8To+RU/crZheWjeHnQV5E/l
 6DIsfT6jvhnNa8vLBCqbl4b0GdCINZY=
X-Google-Smtp-Source: AGHT+IEzyjoAil0Yu8fQS8y7zI0asvx5Q6CYCf5Zap+tEYgeQ0EURtwYa7w6SC2cDAfd+MkrlR3n+g==
X-Received: by 2002:a05:6000:1f81:b0:38b:d765:7046 with SMTP id
 ffacd0b85a97d-38bd765733bmr3228174f8f.33.1736729323896; 
 Sun, 12 Jan 2025 16:48:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38428bsm10836435f8f.37.2025.01.12.16.48.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 09/23] hw/mips/bootloader: Propagate CPU env to bl_gen_sd()
Date: Mon, 13 Jan 2025 01:47:34 +0100
Message-ID: <20250113004748.41658-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
declared bl_gen_sd() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 30e6422d331..34c3043a563 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -205,9 +205,10 @@ static void bl_gen_sw(const CPUMIPSState *env, void **p,
     }
 }
 
-static void bl_gen_sd(void **p, bl_reg rt, uint8_t base, uint16_t offset)
+static void bl_gen_sd(const CPUMIPSState *env, void **p,
+                      bl_reg rt, uint8_t base, uint16_t offset)
 {
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
+    if (bootcpu_supports_isa(env, ISA_MIPS3)) {
         bl_gen_i_type(p, 0x3f, base, rt, offset);
     } else {
         g_assert_not_reached(); /* unsupported */
@@ -284,7 +285,7 @@ void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
     bl_gen_load_ulong(p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
     if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
-        bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
+        bl_gen_sd(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
         bl_gen_sw(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
     }
@@ -301,5 +302,5 @@ void bl_gen_write_u64(void **p, target_ulong addr, uint64_t val)
 {
     bl_gen_dli(p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
-    bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
+    bl_gen_sd(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
-- 
2.47.1


