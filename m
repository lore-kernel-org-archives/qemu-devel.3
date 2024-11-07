Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B3D3E79F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rEk-0004oE-9L; Wed, 06 Nov 2024 20:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEi-0004nt-LJ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEg-00036u-Mi
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so2636405e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942577; x=1731547377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uljKpTWKHfIbJ0MtlmY9PWC2nyD8V11sN9kOWSbXIe4=;
 b=T9lNBK6oc1xRwhKUmBfILBWYq7PmOsdyURt+5QRCIWlGrg974bZyCyDCoZ3mearwKa
 mDeBncfy1Gcpuao+bZNoGkCxNEg+gefW3mWL0DV5jB66sBV9i1MdOTC55wxvy0qZqxgF
 2DhGeheuwLBcA5mQBAQv0lA5BNxhEx/83uiH+Pg9lPOLCfeOSMICk/Hwbx9seAyto3Oj
 J9BdvAMvz7K9exs01RX2PO/CjiC6bd+ugOk8wXLvW4+Bba+ublk3pywL7YWIjhmLRkFa
 Ia6WIR52DcFVNO9MNmKV7jAV9o88NRexA7wMrfa6qncvCX/+mVRsV79QRBbISey3quYu
 8uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942577; x=1731547377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uljKpTWKHfIbJ0MtlmY9PWC2nyD8V11sN9kOWSbXIe4=;
 b=NBreIlqxEpMqZYLDhEcaMaEKtsSPzIuAF3c3VlfPlLyPRofHu+czohGfuOrjjjJBCJ
 nXkAS/MW1HtSdyHL0uZQ+L1in76Y2xcTo0OK83sFOi/Y4r9uj5hiJro2MQLtq5mq54/v
 sgSLZMhX3DzGaqaYl41r2sNwNwCkw6QsOtTZTySS6ZxyWw4APG9gWxegK866bpgUOvue
 LvfBXSCOSfhm8ytmLdLw9ZRTagE77rjR6uxbehDwjD0vb9SCtLjqCmDIVFNAFKO5H1Ej
 ivzW5A31D0zDMnD9cXYpNXgl17uNXCV/8cHQG9hUimZUlK+R1rwEYtLCHU8Z5gqDWT6K
 KURw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX84dF3AOQgh3jWwNgeUULSAGMaS9M8kebapgn8yQ7MEreE2Y1EchPI+RYKrUHEHXYC4D4nGaaj/wqV@nongnu.org
X-Gm-Message-State: AOJu0YyktGluCl8Lyu9ygLrTv+1pR1OweEt7U3FTXM+y5H1uYeHVWT6R
 JkSHBsYukYayAfEDzf7g+pItW6zKRL2AVNICJwwK4oFNoA65cXg8l+G9WZERgng=
X-Google-Smtp-Source: AGHT+IFl38hyCz9YXLRq/MobqxxNGh98itOKQ54cZY/EW6aA1fy1nVWAvaKfNf1JFB1tz6RubjhmgA==
X-Received: by 2002:a05:600c:5118:b0:42c:b54c:a6d7 with SMTP id
 5b1f17b1804b1-432af36d8b9mr8311635e9.14.1730942577366; 
 Wed, 06 Nov 2024 17:22:57 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053069fsm5314805e9.4.2024.11.06.17.22.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:22:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [RFC PATCH v2 05/16] hw/timer/xilinx_timer: Allow down to 8-bit
 memory access
Date: Thu,  7 Nov 2024 01:22:11 +0000
Message-ID: <20241107012223.94337-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Allow down to 8-bit access, per the datasheet (reference added
in previous commit):

 "Timer Counter registers are accessed as one of the following types:
  • Byte (8 bits)
  • Half word (2 bytes)
  • Word (4 bytes)"

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
RFC: This breaks the UART qtest, instead of having TX register
receiving 'T' = 0x54, it receives 0x54000000, converted to '\0'
char. It works if we use SWI instead of SBI (storing 32-bit).
---
 hw/timer/xilinx_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 383fc8b3c8..c117bff225 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -198,7 +198,7 @@ static const MemoryRegionOps timer_ops = {
         .max_access_size = 4,
     },
     .valid = {
-        .min_access_size = 4,
+        .min_access_size = 1,
         .max_access_size = 4
     }
 };
-- 
2.45.2


