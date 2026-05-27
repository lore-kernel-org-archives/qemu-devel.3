Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82243CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBY6-00030M-VM; Wed, 27 May 2026 06:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXu-0002gF-Mi
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXt-0000mE-41
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so122364225e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877888; x=1780482688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D3gUYP0SCA1U1P8NT3lyApiwDcaMCcgS3LWWXqC7ZnY=;
 b=YYIOz1x6c6RMOjaU4WI3E9HQ0uztGlWdVr6SJ42yclH94PvcAAFJAx7Tas+0BPxe60
 PRbf6WtOKmPNujELxsUs7Rt31VQakny1TVidmU/H8oh6gFWcfMsANOzRUitC8X3ALqex
 yh6BEepKMR8eA97kjvkl5nx7nEErRL8CLbfMNxY3/HknF5o15sXDwikbWOz3ganYYbwC
 4xWPECOoJ/STIIovkcJmskYjSnseS2e9/9d5BwOX7rSGigBmEZb5dXvXdaLCCOPsDK9G
 ZSfu9y1f7GJ3OZmi8uVTa1JgDBuTFUk3fI+5MCcfT3zCi//KD0flKirfGwSqlGiUwwgj
 UBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877888; x=1780482688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D3gUYP0SCA1U1P8NT3lyApiwDcaMCcgS3LWWXqC7ZnY=;
 b=gf5ieewWsgsIGFe2Y73fAem6YYFTl7ktDOL+K2UmxKfEkRsiw7RmUPOP2pH+LAscUp
 1PYLlvw8JW1BOCGi+7ahjFavqIpO5rA/hC7qDwKYqp/Vpw/w1CRA1X3pN7kBZgjSd1Gb
 AuQhUOzH6l5Px8LYNEEZxJ11nRieSmSllZwQOsfPU31vXu73ws8bjw7kQ8agZR/Sp7zz
 hPQOdPgWjAN5pCM8KxXDkc4A6xbUlouW21oodiZ4U8zJPSlTuDMNLZI9BpslxAaRklNq
 stfLviyuZbniu+uO1kbq3HYY8s+BKKAVr2Gnz86UIBfSNUBQAkytFo4EIIkJuuX9tAP7
 31Pg==
X-Gm-Message-State: AOJu0YylBn3IxmFvMJ0VidXA2luN5BQtPCGR7J3ckkSkvKywBvncAZuL
 nzKBBF/2hZ8iaufwzH1xGaPqtgZP5dqIKMmyMlUiMhNdxBGvZHvNqqC273HpHXHmgdHj/N32Bh8
 +4YPe3vSBXw==
X-Gm-Gg: Acq92OG4V12+szrwulw1T4/dFBYE3O8OxkD65hhAMimFAmUFIXc8tGN1R4Cz0UP4hmX
 X0Jyo05sY3Eo+3qu8F8x19lf2ZxbF5wIqMqjGHUeMMZzPkEYfAcMwwlwBsRwZktBf3xJb1AptRX
 yiJpYuxNCFvNHiN0bpKV1eFtuNmFOzpkkcyJyRO1qq/SokYtts7zVmNXLkTaLYbAZ2iXP0tVI3j
 mbaAOSaxinLoMasb4UnZUF0q1k7XsMvows78fzkODZXjRbjXSryj4Hdmj8Llg9HinCjqGbrmU4G
 BECc4NEu3ScO2HkldkLknFdP+GqdeLYbo6avyZSxS/Nm3oqyGtt4UJDgHAqqiAz63Kk9W3/EE7K
 mZZOMCmVxj/f3sXhzjIPzv27H4Ys4xxI0n2h8kMnPM/+bLbUi53czfU8nP21aSIPcQRw6vyEQpS
 dshGYg+656x/mgOQblrN4yO4hjPi0uvjj3mZK+j+is6uUEptflz0zsef8=
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id
 5b1f17b1804b1-4905872e758mr280258585e9.18.1779877887518; 
 Wed, 27 May 2026 03:31:27 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2a73sm5043957f8f.22.2026.05.27.03.31.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] target-info: Add target_riscv64()
Date: Wed, 27 May 2026 12:30:11 +0200
Message-ID: <20260527103037.4461-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Anton Johansson <anjo@rev.ng>

Adds a helper function to tell if the binary is targeting riscv64 or
not.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260520-hw-riscv-cpu-int-v3-7-d1123ea63d9c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 23c997de541..6c5b714288e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -99,4 +99,11 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_riscv64:
+ *
+ * Returns whether the target architecture is riscv64
+ */
+bool target_riscv64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 28c458fc7a7..04c69c41f8a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -93,3 +93,8 @@ bool target_s390x(void)
 {
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
+
+bool target_riscv64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_RISCV64;
+}
-- 
2.53.0


