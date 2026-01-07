Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0058D0D16F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZoL-0000h5-8B; Wed, 07 Jan 2026 15:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoI-0000fJ-M2
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:14 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoH-0002DT-A6
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so20384835e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816431; x=1768421231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hR9wCi10Z1B9CMvfv/nZnVusEZy92tCkS16l/IToK2E=;
 b=gEGJM+ZsgvZMXoYec6L7XDFP6K1XW+JyTQ3VA2zCpKUJIL/3L9xCvIraCxhmNMxLuH
 lQBZVK8cYs0wDMq4tEXz8wHBW0Ia0O51324HZ1JHClu8jFxnnEb76M2VSI9LXDFO69iJ
 zz9r+xsO369AKOWcIH6x62G9d4jVxN3x4XWWgryqXSoepI/6a6oyUw1jesA6YvmNpstn
 FcB75GSkGTMTiDjnrqZnvDddJujAd4u3mmAQHrL4oGg6rQxTJ6zB0U08Y0lbLeWFERr/
 5eZh43yYhqQUsWGAqv5krBfWdHHSvzbLjm7EvhuRUduD5/i82T/0tsHLYR+YdrKo+Oda
 hrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816431; x=1768421231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hR9wCi10Z1B9CMvfv/nZnVusEZy92tCkS16l/IToK2E=;
 b=Akak+/3HTlqrIu+hDNIF49UAw9W3b60HMKPFBDniTpqXVgbVH0Hx4oPqbdisEIbrUK
 ivouWgevgXeclIml58pIgD64mcV+NPDSXMqtxgcO3lOuOZBprPH4fwXZQHxKht0Wfgju
 h9wOGel9U87+kY98oxb2RZQtkB8HjGiuOM6UuBXPM/QGJaXUv9s7fEG5WZoWm2edJcin
 MSu6F6HUe1dlnCHzdPQcpSIHNeDxryNuAf/pGVCkWTGc4iw6PolDZEdQVr1Jb1MB67dU
 fWR6oB4xQfSPvx2dHTbfeUA/i5r2M1V6M8IyX632ZPeKT0i7kTXH8zpVRYqp8h7tpELX
 EzZQ==
X-Gm-Message-State: AOJu0YxuRDQjQjWk85SiKjT/RFtcExYud/JlNO2ToRUQ3BgbAgaBqiA/
 VERx2y645M5RqdJIVL36KtKsPewzO/jdajqqBSqG4yy+LzkhkE4tfoBMpnbT4GYoHVl1l3bt5ZA
 sNq439YY=
X-Gm-Gg: AY/fxX6HTbqwVAEp1g34YYAwDs5IacTWoFYpfcaezhztZTiQCeN9zlEteEAej/cFHvm
 4C4U8J62PjY0QDoOnCfQV5dz5NI0a9nJd4+z1MiAOtwf10k34szlXNrt0fSRl9FtfsfJ+PxERuM
 NCF14abUhQtbsM1LtSDEpa/xDWA+0r+zhECIuN0cJwMv/mKCUvr1UMNm3nb1jpxDT+5KYiYZ8My
 3wMB7fegr2YdbMJjOWmHlICN2hz0gfMQqjpPz43bmXEdLGjuEAuRzOFKsrKtbxzgTGVD1fVs8Kh
 WefhNi5KjSw/o4rp67JQFy7JMl7gq0D3efAPSRKGBjIqgcp0Ciduq0dEslz9/mE5Oh9KOGP2QsE
 vJTLRZFAKesLgqow0bVMUQ+9MonG4cAHGJNCSpe3+zPkeVB96zbYikKCQnQ/YedLHkJSYCFol4t
 Kb9j+Vf0nVCSOxkn6Y1NxFDYCCtz43a8kB3G5sMubDG0HUeJhRPLK7GeRLYTMB
X-Google-Smtp-Source: AGHT+IF5R1/MxqzBMFB9an0KSN9eiFPU3MnXlKkAII8PK5ioPg+8b9UCEKJX6Q9TG/GoqzPh4VNAzQ==
X-Received: by 2002:a05:600c:8b2c:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-47d84b186b4mr40956745e9.7.1767816431466; 
 Wed, 07 Jan 2026 12:07:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d87018bbbsm23174985e9.1.2026.01.07.12.07.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] target/rx: Build system units in common source set
Date: Wed,  7 Jan 2026 21:06:54 +0100
Message-ID: <20260107200702.54582-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since commit range 2982b948a9f..86114e43ffd we remove all
uses of the target_ulong type in target/rx/. Use the meson
target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/meson.build b/target/rx/meson.build
index d196737ce33..86dc231eb0a 100644
--- a/target/rx/meson.build
+++ b/target/rx/meson.build
@@ -13,4 +13,4 @@ rx_ss.add(files(
   'disas.c'))
 
 target_arch += {'rx': rx_ss}
-target_system_arch += {'rx': ss.source_set()}
+target_common_system_arch += {'rx': ss.source_set()}
-- 
2.52.0


