Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95767C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWEa-0001Kk-WE; Wed, 13 Mar 2024 17:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEW-0001JQ-5c
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:33:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWER-0007i1-5n
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:33:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so152029f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365630; x=1710970430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1fMeXU8v0Ez38VZMi0gdzDmageBAPVY2CeRzL99JPY=;
 b=bmAVAnjj9HgnfKk9ZH5RNt938xpuc9IWtFO4hrvTkILdSsHTI4sz/pF6CaNlVJILvo
 U9go1COAI+KQmSPE9tcsbxhAXzE/dCEvjzwNh18Seyk72eYV6MotH4iUNjq807KAKQCk
 fSz7R0KomMKIqSFULJPQ/Ew/pXkrhrucoiLA4KhCrqKTak9dBLjx5oZhVme2h3zy1i2+
 HmD8EHu98zgz3ykQdCccT4+tI6+XoBxw0w4XvJUxDvCNLkCrgyKZHcJyNjlgypiR0oQ3
 XB3dZRaXSCdVB7s86AN5H3+qrVN897iCmk+bzFTpJfavwi13/ylzSp8Pwo8EceG9TIUH
 cp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365630; x=1710970430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1fMeXU8v0Ez38VZMi0gdzDmageBAPVY2CeRzL99JPY=;
 b=MMcMuvvF41td55QItYLEAKqD1ZvlGO3dYRBsvDDkG6H5jk38ES9uq/Bpmy+nZz4BKP
 F8g4NDYCLtOrql/xbBKLNVfTlVKPvFiVROxruF5vMNKz5f8oz3d/oX/3ZvoL8pxxWq5E
 OzbEoaPjOOaCWxRMNr0zjy22pm+p/YcXCUdUAdSyV5lyzVt6Y0BV38RRIqNwkWQmRPgv
 99CmzuOpPz8ZGHIc2DrXykY2tqvN+ukfN710rDWXLBnmB5aD+J1FY1JFmkMj/tyeHzZ1
 0QXIA3fVPvwgGSZS/n1QTetEEgVPighdx9vsE2XFd9dgu5gOW64fM7/YSflA4gta8f1z
 Xa2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4P0iKkDEjt+xvavLmdLWtRhRwHSSON1xWIDRkQGRNUqP5LyDGH9KpPevuG+7VIsztEGU0i0MtjOXbZAu+fDbq3RPiG0I=
X-Gm-Message-State: AOJu0YxuhiqTMJ2Lq+9qbeffs9rJRLlgtBfi8Imalw1dx4YjsDpeGv1N
 uSvFoOkFg8SYlignGm6FIY/gb0uO4H8d5AuObcrGjEWFp2/xEqKiu3wGIY9Vc7s=
X-Google-Smtp-Source: AGHT+IEcezJa10tRbpm7wav8hNcpK46J07KU7J7ILJsejc07uQKr1ZycLgQAVLx00+0Oalqqapm+rA==
X-Received: by 2002:a5d:4c51:0:b0:33e:bf71:3665 with SMTP id
 n17-20020a5d4c51000000b0033ebf713665mr1084303wrt.8.1710365629723; 
 Wed, 13 Mar 2024 14:33:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a5d6810000000b0033e22a7b3f8sm62664wru.75.2024.03.13.14.33.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:33:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.0? 01/12] accel/tcg/plugin: Remove CONFIG_SOFTMMU_GATE
 definition
Date: Wed, 13 Mar 2024 22:33:28 +0100
Message-ID: <20240313213339.82071-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The CONFIG_SOFTMMU_GATE definition was never used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/plugin-gen.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8028786c7b..cd78ef94a1 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -57,12 +57,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#ifdef CONFIG_SOFTMMU
-# define CONFIG_SOFTMMU_GATE 1
-#else
-# define CONFIG_SOFTMMU_GATE 0
-#endif
-
 /*
  * plugin_cb_start TCG op args[]:
  * 0: enum plugin_gen_from
-- 
2.41.0


