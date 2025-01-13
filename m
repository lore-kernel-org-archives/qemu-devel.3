Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2F5C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXW-000625-Qh; Mon, 13 Jan 2025 14:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXR-00060w-7v
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXP-0007SF-35
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so54209895e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798149; x=1737402949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90vMRgdrB/kNHL2lPqK50NFXkY3ERKj+k5MjSo7lg7I=;
 b=jLrBMHiSaZAq1RkzuQ58VHpvd0pLpcsKkRGzGcv2Vf8Czrn0xu4Q629hwaBBul3QaC
 kUSfSy3wzLL4aLTS11k1bND562sEli+yIYg2pJrs0ItqH6y9tfLb4Fay9Fk4fU2cnyjB
 9qJws7dMFVqGT7WTluJWCwfQMrOjsOMwXdy6dEn77zcPSNwMO/YBSlwOuChBeDKObfMz
 wZMq/D8LP2OzBvFUJeXmP7VaIBWSaGjzNV5+1JOOgv5zS/4bK11+9/nLUpHOg9r/V51k
 3If2woQ9n5ZYAsTp66/000q/Ge9ddID6xzaH6/gZps35a2nrogMn1SiIjANO40GoKj55
 V3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798149; x=1737402949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90vMRgdrB/kNHL2lPqK50NFXkY3ERKj+k5MjSo7lg7I=;
 b=azTszXQDqENahyl/eRrR1+cZHH7SAMfQL8HaI1cX6pNUa5P0ceL42or39kUYzfssEX
 kgTLOMiitIVxK28Xl/jkMXsERUKA0PCOorqzFN8jHd4QW8d2IxSCawOOyYOQ2l930NqU
 c5RTtrPSSpdtl/al9e2v6B4gCaU7997wLh1kWhpXVZvLD7qEJedMt2G9OKSWc7s5Hj48
 Lzmibe/w7mW44H8Nt2kNqoVCsnuQc6fxANgEQDwdDyewbdW5l2a1gtsplIO3zG6ZWEGf
 W0KvBtJiWjYysp3E43iRx311f3bVoY3s1E+aIsbPPbkjnFLMSlN9B3YZTCEzksX/X12H
 L9Hw==
X-Gm-Message-State: AOJu0YzqlGpJt8xxvwA2oaKim2wsWnHwu8b40GwcYZ2Bw9hL8gVFKo07
 nTouvQ2YCUbGwj89ht9UimD+aRqp/huDD2rehYJMuK3TIlPmDfL0eYr77gVUQaKOrEdQl7vsCUQ
 PgJU=
X-Gm-Gg: ASbGnctPNtnbxPBrzICOcDL24IyrgYOKzzFRvbeYeP9y9fOObj2G2lKxJK5X274DKy/
 r77pflSgP1WXYGBsoH8wT97olPxFmWSnU7z+jBEyHGyPE0dNr/8yd4kkHULrsz3OwHbmyTSFBsS
 RtgMnG/QQO3+eZEwT23RUQ1ZnEIxOyiCepolLP/qnD9rzUEbNQd9jcttQbTyBpdnoj9IlS1lTum
 COdmarWELVF6EaQd+pJButvlgPg8me9l2xkX264lN2Wizm191OoogCs4kqit4roLf89unwUwbqR
 clDF8C7/f56RpfbS2jdqTz4MaLGSHZs=
X-Google-Smtp-Source: AGHT+IFAbSUzZQUFnjPEkavptl5rwMv0azjsZpQnffaUWoGQ/RYZtZNrX5588N9MSjnRjfP7kJSjWA==
X-Received: by 2002:a05:600c:4185:b0:436:ed38:5c85 with SMTP id
 5b1f17b1804b1-436ed385d5fmr169549995e9.14.1736798148396; 
 Mon, 13 Jan 2025 11:55:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c1d6sm13190857f8f.50.2025.01.13.11.55.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:55:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 04/19] hw/mips/malta: Propagate MaltaState to
 write_bootloader()
Date: Mon, 13 Jan 2025 20:55:10 +0100
Message-ID: <20250113195525.57150-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Pass MaltaState as argument to write_bootloader() so next
commit can propagate it to bl_setup_gt64120_jump_kernel().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 090c2514354..ec8fd954b4b 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -692,7 +692,8 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
                        kernel_entry);
 }
 
-static void write_bootloader_nanomips(uint8_t *base, uint64_t run_addr,
+static void write_bootloader_nanomips(MaltaState *s,
+                                      uint8_t *base, uint64_t run_addr,
                                       uint64_t kernel_entry)
 {
     uint16_t *p;
@@ -744,7 +745,8 @@ static void write_bootloader_nanomips(uint8_t *base, uint64_t run_addr,
  *   a2 - 32-bit address of the environment variables table
  *   a3 - RAM size in bytes
  */
-static void write_bootloader(uint8_t *base, uint64_t run_addr,
+static void write_bootloader(MaltaState *s,
+                             uint8_t *base, uint64_t run_addr,
                              uint64_t kernel_entry)
 {
     uint32_t *p;
@@ -1172,10 +1174,10 @@ void mips_malta_init(MachineState *machine)
         kernel_entry = load_kernel();
 
         if (!cpu_type_supports_isa(machine->cpu_type, ISA_NANOMIPS32)) {
-            write_bootloader(memory_region_get_ram_ptr(bios),
+            write_bootloader(s, memory_region_get_ram_ptr(bios),
                              bootloader_run_addr, kernel_entry);
         } else {
-            write_bootloader_nanomips(memory_region_get_ram_ptr(bios),
+            write_bootloader_nanomips(s, memory_region_get_ram_ptr(bios),
                                       bootloader_run_addr, kernel_entry);
         }
     } else {
-- 
2.47.1


