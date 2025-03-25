Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7E4C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3wN-0001J0-Vm; Tue, 25 Mar 2025 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vS-0000pr-BF
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vQ-00082Z-Mj
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1650159f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907754; x=1743512554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFyrhQBtENvr7c7C7/qCg1WgDkZETsoaD0YCLqZYx2k=;
 b=fMQFBux3glu/qbW8tkOYIkNAwMo4LdITAsXvrfaO0ifEwgFT/Qkq8aEbJuXVLXTeFG
 U+n86MR/9krLSEs2acs2JdoB0i5kBwVG9VDxebNqBSQS7yROa/WPf4tqLE+4pXkVwhJe
 FSW4dzWrDr91OPqlZgaMvLfJs63ueTJCM10Rx4U1stpBKNeB0qxh+uKqFdITPHpB2X6h
 JfPS3620UgWk0Mrc4c0OcOF05iU4mtf7DXjqiCe5cYACAbTV+6+IPu0ANXO6XUS6BiJo
 Jq6ydDKTdnpGW+Z1WEqkYkfwID1aVFJONbwRmFKOtMGFMuPTpi7jTWr1DlRaghtSleRb
 FxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907754; x=1743512554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFyrhQBtENvr7c7C7/qCg1WgDkZETsoaD0YCLqZYx2k=;
 b=NzG52NPwb6Vkg5WoMSq9ORvQkc2MJzvIWGSnohsi3h+qAbYxPghVmK+RbrR5gMpUri
 +k8w/AMJ1cz4cID1YcbiLlPVspqvzHPLj/w4vl7iQAiINy+chkKye7QfBsIazpwpEX/j
 jDNgiWZ9ehc3cGmfWgWn6uSRGmM9EkluV7762Rxfdq70TlBBj+iruTOIGA864BdAl2s3
 GYFJiXn3X5sKrkoHOd/I/EafPIh+irT2rI+YwtzTDdjWDsQwXF0SO8uZENoec5VUS5sM
 KXoxW8lkEyNr3rLoRLW9MhOZEWQ5WOUlMpTrUSU7GpDjWqTVT6kWzX92MI3B51u7ypkx
 KMzA==
X-Gm-Message-State: AOJu0YxFrOIgx8pWBVS4RwBPwM4OP2Ej2sQTn5WbY0xJXng69VxLX2tI
 H08cdbWyQt/1qQIE0GIhE/MhIyDHVQmnep8WnUGkaJCiXT7XAsyxVaYWo1RYRCwkZWy7JZPh70q
 E
X-Gm-Gg: ASbGncuTBF/MKGUJ2XhUs/s3xKzk1Q1/ep+5VvsRZIXwmqkSyw1MiSJRikiyk0h9GdS
 n/K4oR95uDvHRkHXr5WSz7FNpysIgfYxnPwEeCNMXO8ZCjOFNScJh5pDm4gnXaQ9DoA8V5Gcmc5
 58Pb9SQSIrr3YTkBBIBB8LS9VlSnUJj5Nuk7l6TuJz7a6GeGRZcr6kNcSzoxqSUasOjxySEToYz
 eycoASoeSqaHCGtcv2hhyySk0Y64Zje4mYhVAn0bUZ929wtLp48enuBOtg9u9Vsagpk07k7Smo4
 Thugh8f780DX6M3aDluvQyi81/OgNrLp7DIKvSb/UWet4hB4tuQ7MiTH9yCEqsyzA3v7bH11IN8
 WajMN8BKoV00IJmQV6mE=
X-Google-Smtp-Source: AGHT+IEBOArO4GvzBizOpIN8ZP+KW2vp0DsI/6kS0fhOEclGJnXrJwNPuVR6oaALc0w+GGyq3/xJpQ==
X-Received: by 2002:a5d:5f92:0:b0:391:212:459a with SMTP id
 ffacd0b85a97d-3997f90ff74mr15601417f8f.22.1742907753660; 
 Tue, 25 Mar 2025 06:02:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f3328bsm200503165e9.1.2025.03.25.06.02.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 06:02:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.1 2/5] gdbstub: Remove ldtul_be_p() and ldtul_le_p()
 macros
Date: Tue, 25 Mar 2025 14:02:17 +0100
Message-ID: <20250325130221.76116-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325130221.76116-1-philmd@linaro.org>
References: <20250325130221.76116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Last uses of ldtul_be_p() were removed in commit 78920b4ff2b
("target/sparc: Use explicit big-endian LD/ST API"), and of
ldtul_le_p() in 39631d57d7c ("target/riscv: Use explicit
little-endian LD/ST API"). Remove these legacy macros.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6f7cc48adcb..26140ef1ac0 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -95,13 +95,9 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
-#define ldtul_le_p(addr) ldq_le_p(addr)
-#define ldtul_be_p(addr) ldq_be_p(addr)
 #else
 #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
 #define ldtul_p(addr) ldl_p(addr)
-#define ldtul_le_p(addr) ldl_le_p(addr)
-#define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
 
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.47.1


