Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21B1CF649E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCRb-0000he-Sz; Mon, 30 Sep 2024 05:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRW-0000b8-9p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRU-0004Xx-67
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so51089695e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687502; x=1728292302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CVXM7w3ItHRS1f3yj+MesBCV77dY6lwF6BVY6QS2jI=;
 b=BgoyjkAaEt7a5wggprWcAPqNbOxHZJMtg5dJgiNBrEvByTTxuc9ck6jYqXHWq4vIqw
 Szz/BMIegoaF2is1Dnt5YrU/GEaHvrtjmbVWzrte6+Ysw1OOQI5RjZu32Aqrfx+d7W6Q
 RhGYJI9cI5q4DLNWiC3uOOScL5Vg8Mo11eozsoRMbf1lR9XKc0qSkH3WDU1xPDG/SlU/
 VGO9omdPAdcmCOLYzPDHNXXp20jCFt0YVxZ+bhonuBHyJLjmrGoE+03IJo9VK6J3Wtfu
 7sl8qHMw25bocHS/H7bsfOxhI38W+isOkbU5uzqMJtcR1qK2bXV7939vWt+yUgNKPXXN
 jZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687502; x=1728292302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8CVXM7w3ItHRS1f3yj+MesBCV77dY6lwF6BVY6QS2jI=;
 b=F4pPeTAuoZbPb4TnISKAZvaDznEmX14jdO7vJrwHXn1dIG9Er9hh7ckYlIMdTICc1A
 8RNKY0C7R9SUxJmC8s4sfQMLZkREQSt+eNIFry8ssNHpX0ssNuMqagpdNyy5mJDw0CIT
 hUisGyrMozAIVsmxOHjS0NAxkxwoTaRiOQvjNqDrn1h+C9SPzp/MKEZkaV79fs1KKyGq
 f5C0+iA8TmrgIVNhoCdQRSHZvtvkxJ+7mQ7TubVpbMX711OC2Y4+Ck+J7AOSXDc/LSjM
 9ZSw+iu0ujTJjAk1qLTgnRBjC54SJp3TQ9VoOj82BKgauWXJcpYFWsOBAXGTuCwN/J3Z
 1HIg==
X-Gm-Message-State: AOJu0YzpdWKnU9WpgeMZdjS/MfaluShmh0gdUVG206CWGRPGNBnbYeaj
 QKsXsSq9y5jcr0YNa6xcV70hCzhTxjR0acJLFdNdwjPpzBicKrBUi6GQxSQ2b9Ep3JfhV/7EWYc
 W
X-Google-Smtp-Source: AGHT+IHtiSufjhOEkxb6X6U2Pim46ybmDAGhY9KoqDYmOKrtCyKo1QHyweB4o4obH+kaIlCsfv27Qg==
X-Received: by 2002:a5d:574b:0:b0:37c:cf1a:b2a8 with SMTP id
 ffacd0b85a97d-37cd59def87mr10654824f8f.0.1727687501970; 
 Mon, 30 Sep 2024 02:11:41 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e8822sm8572863f8f.50.2024.09.30.02.11.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:11:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 05/12] target/mips: Introduce mo_endian() helper
Date: Mon, 30 Sep 2024 11:10:54 +0200
Message-ID: <20240930091101.40591-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Introduce mo_endian() which returns the endian MemOp
corresponding to the vCPU DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 2b6646b339..54955437ef 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -240,4 +240,9 @@ static inline bool cpu_is_bigendian(DisasContext *ctx)
     return extract32(ctx->CP0_Config0, CP0C0_BE, 1);
 }
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return cpu_is_bigendian(dc) ? MO_BE : MO_LE;
+}
+
 #endif
-- 
2.45.2


