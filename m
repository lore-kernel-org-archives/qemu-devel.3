Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F8BC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4g-00011C-Va; Fri, 20 Jun 2025 18:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZF-0007Uw-TR
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZE-0006GY-BS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a522224582so1032922f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440618; x=1751045418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GJIXguPnTzHOl7nBNGD6GFgfAgl7y9Fdn3YOIBOtqE=;
 b=nOjA9/nySZw3lp1ogtlv5lGJMK2pOxJ+wO2PDWSA8Q8dB2Z7dmLig+AtXUnhiZWMw4
 C2GMJAMUfQdyE9VaPm5g5dH8ToCjusWniRY6jKDtregwZ7UR5TPztXADBG0+6icN87Rv
 hRmInjyBxSFKs2+Dc3R90zVbLTypCRdk+9n/9jqwbr1xaTYctUjH5/jLwYvZ910w9lpY
 H64C0MwkyPAcEN0PoYV9EnYMCKXbSTw79PHK/3ojKewMWwbpBaT4RVS65eHdOq2a4HRB
 hbwYcRVFMCwtSF2CiIvMlyf6qDxcC4QLM28NppTmR4O8i8irQj7k0YFR8ILfNuwDyrZZ
 o5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440618; x=1751045418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GJIXguPnTzHOl7nBNGD6GFgfAgl7y9Fdn3YOIBOtqE=;
 b=M++YRUPYRJ2PHZk3HYWm3VFMcdKR0GwXL4NI9oeksRuJvA9yIZrKP6e4k7KH/b2rkM
 cF4atAoDU1Gg8XLzYpcpQHv+YV65MetAspdz5bd8Ec/dbJ9NWz/OVLT31oN9wJW1lw/J
 N6OIzzjkJXOb11FDBGZW4Qj0qIhVDjl77MVWprWyLQ6X4WtLiae2J84G66JOPTDNBoFs
 WDX93IgvI/u+ogOf4b32X7LuwwlWRnd9kB3psHgpyWh3qwfKLVCWccPlGX53P5nSwJ9O
 xc/fr3U0zHBCN4E/V3qPMl+FaODiDoGN2/pdSB6U7zKjdLJLjWUcJwxBO9LgaWtMpXLo
 rwMQ==
X-Gm-Message-State: AOJu0Yx+ZwN5JguBJ90whCXrAROnW524UJ2QgPnKfbqWsuTLvPTLm/3v
 +cv5W2ZwKCQWewwLK4HjApEhWbMts6QTJAzHyU8u7vxuIBqjnOd6a1lO3rC6cnHojXaXTYAJdJH
 jzTFNpObrIg==
X-Gm-Gg: ASbGnctlInLYMoyxknJqt55G2n7T8Dz5/F5BkDB4neDY4vdivVBjNJARw7o1tDhKZG9
 cqvzO28rjP3KRn0qC9BpERVtDA089/6PUinIFIcpzR496W0PfgBixl/QCMs//9v46Lg9AyrQet1
 ytwCSii51yoRDldDJmINDkAVf4y0GB4Zp1GmzQiaNb5Swi3vxEC8cvm6KAGKo+NSXoZEpg/AmyP
 i8wBmsTXa+c5by8FhU/+zALFZ3bbPlEbLFXKBksBlFocMGRNx8+V1sBj80YwzzRNi6tt6dfNZ4e
 5abyPzTBnPXgVtt/duYrRAd5JoDrhxaJNGhPHyUrug1oz45rF2Hx82M1/S2LTGPaIbdQ9MNEJx6
 LV5AvRHjRgn3zXaWocvBDk5+3riluQqB37o8BtvKG91FrwBmNA8Snf5tc
X-Google-Smtp-Source: AGHT+IH7esC5FlTfsrgIuOltEUjk2uMoyK/Y+9wVx8bn6s//S+uxtC/r1zFtaGfqjtOqhGRy2mRlCQ==
X-Received: by 2002:a05:6000:288c:b0:3a5:2182:bd11 with SMTP id
 ffacd0b85a97d-3a6d12a24f8mr3110649f8f.20.1750440618558; 
 Fri, 20 Jun 2025 10:30:18 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb57fsm32104275e9.1.2025.06.20.10.30.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:30:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 18/42] accel/split: Implement
 synchronize_pre_loadvm()
Date: Fri, 20 Jun 2025 19:27:26 +0200
Message-ID: <20250620172751.94231-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 91ed0af2746..746a6a2782d 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -188,7 +188,16 @@ static void split_synchronize_state(CPUState *cpu)
 
 static void split_synchronize_pre_loadvm(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    if (hwc->ops->synchronize_pre_loadvm) {
+        hwc->ops->synchronize_pre_loadvm(cpu);
+    }
+    if (swc->ops->synchronize_pre_loadvm) {
+        swc->ops->synchronize_pre_loadvm(cpu);
+    }
 }
 
 static void split_synchronize_pre_resume(bool step_pending)
-- 
2.49.0


