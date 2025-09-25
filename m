Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1789FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aAb-0007bY-3r; Wed, 24 Sep 2025 20:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aAX-0007aI-09
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:49:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aAR-0002Aq-18
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:49:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46de78b595dso1649595e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758761337; x=1759366137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NiizfBhHkcKu+6WbsfAaqecI2N44P0J47DWAWQMQgyU=;
 b=ydz29waBB2DXxC0g6wdtL/3suhcHSmxil2LQF49O9sFlPeEiZagUqzPaHQPKyqS467
 L0vdL/ej7I3DbO2jJBu86JwXPN7uh4qaeGZ0KBz0eBM/e8FpdIIURcdxkeDdPBkV0mrB
 iNQFHCG7Qo7RFF4gfTzmoK1qIIIDREytMBO7vw6XjRUzmSYrFIi35vbZS0sLzKUMPqxA
 E4Xpv50NA45uLLl6MQhAfJc5WwMi9FIawqOZZc9H1wV3SKJ3dsSGmNx1jqR/qEl3t+Ql
 3pGxx4ZOoj8wlb+2kTAQ1DLpgJi5Tm7iyc6kMXLz7qNjUf8d56T9UMWW9cl51RwQHJ9Z
 NRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758761337; x=1759366137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NiizfBhHkcKu+6WbsfAaqecI2N44P0J47DWAWQMQgyU=;
 b=wd/cnwxxTa6EkUajBKQwyDtJ/FLP3/gX8RIgTs+V8aExM86nMYrxRnYq+a/ZzELaw2
 7mdWLig9PhixMj4dCzE0b3brSMMsMN3pjw0MylVMU44c7jUaA6t4oVZb7VCUNhhNG6HE
 hC47N92bT049s9JfCO8uU0F52/oCas5M78vPN2UutHJmNCqzqBdit6cvotkHaODyv2ED
 JxvICUWdUD49FEGWNcuAk853mDxna0FnVjUtOixd/tYKIARzFOcNG7lOw9Bx/I8/Yh7m
 JweRH1jWsbMYuHSFZ3Fbpt21wPZReJJ09qyzeYezGbTTrpu+Nbs3cGEfo7rdwhOfA0xY
 X6cA==
X-Gm-Message-State: AOJu0YwfYjtGm7TWNt2aGQgU80L8LgJqrLcwnKojw09TxFByGgDu/1O1
 VxxfvQ6hcb/lh8bl2S92s8kGYYLkNE56hzy4yRGQMk0OKsrLrR7NqJhHhmjVJeAyAa2xEUXIaZB
 AFco/yJJ2yQ==
X-Gm-Gg: ASbGncthGUR67gO+XvmX+c9cr/3bMZHExZTQ/Hr+FznskWIt9bUlDBlEEo9nISkXrWa
 bOJOoXDk+kwpNHZL59A72aBKe4SL/oKr2iVK3PZnhcbm8dIIlo+JcH1Ny2pHV71d6kCFT9++duW
 H7h1aa2sSQbXyd9AyfQCfT1GktBwxyLLTkpfE3ZkFMG5MPtQLytrmGcpsXKgXXpzyCwbSS8RAnZ
 EQYXN9V10+1WyDGsOSLIoW8ZFNjgFeUmWO1miLG7L1i4ouvwN20fZAja2GADcP4Gs+FC25bPdPK
 xJeD+W1k2zFYJ29GCFDWn0Aq25OdPllUToqyU4c43y7HMKEMD3TAZbaaT4WKbQeOSYBu4/+XWca
 xXUszq30Xqx16UHHoVRGLxKInGfWMKFDFaz5SopBCpciu/twEONAMtwrrsEqYiCe6uYHrmEVe7J
 a64MzdPzM=
X-Google-Smtp-Source: AGHT+IG/+lcWw3d2GSA8khpNRg8GnzX3CXdgK+F0zFMzBmc+9JUWENyT54gk6vOvbgaOmJ2O4MBmdQ==
X-Received: by 2002:a05:600c:3b8a:b0:45d:98be:ee95 with SMTP id
 5b1f17b1804b1-46e329a0df0mr13682745e9.3.1758761337356; 
 Wed, 24 Sep 2025 17:48:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33baab12sm9574705e9.8.2025.09.24.17.48.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 17:48:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()
Date: Thu, 25 Sep 2025 02:48:55 +0200
Message-ID: <20250925004855.59084-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Both OpenRISCTLBEntry fields are of uint32_t type. Use the
appropriate VMSTATE_UINT32() macro.

There is no functional change (the migration stream is not
modified), because the OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 081c706d02c..fa054e528bd 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -26,8 +26,8 @@ static const VMStateDescription vmstate_tlb_entry = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
-        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(mr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(tr, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.51.0


