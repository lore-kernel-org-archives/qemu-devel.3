Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A582E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHzb-0005Sw-DA; Tue, 03 Feb 2026 10:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzY-00057c-RO
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzS-0002L6-6w
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:56 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so5583965e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131204; x=1770736004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z+C5PDsnQGcIFMRUR9zAjFAYU8U9yegFI04WOi65q9E=;
 b=K0HscoPYFG8ean/01wdAyUbib0w9NyzZchwxrvZGh/AjGkQa3t/Iq/O/Ux8icz2Ib+
 yMuVa4hdR1xBvlHATzvdTUsX+DOPyxP/cVdLj8/t/MXqakJUJdURErPbf8w5d2ysWqu0
 MwymI8tWtuhjdaO5bo3ZtbPug/qWaMuueIGJhLUZVRay+Q8r/8j2K9w1BTTdA2lCLKFY
 q5DmcAhLb1u0H9OtGFMvqIW5kP04NiqxeuGRYGeQ4Qk1TIdYa57Obp+mQlRbjhQ5ePpQ
 lBE2q2bAIbcYe8bQ4kQOWMC2RdMzsL0NUwD/B388SPqLKFpXOSYSlnjIgCsnBIcqTXEe
 Hywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131204; x=1770736004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z+C5PDsnQGcIFMRUR9zAjFAYU8U9yegFI04WOi65q9E=;
 b=XnZMmO3UeSVnjIsWFALzD4C69OQirYlQtHccoIleG2UHaM2sWuXYHtwdkqe6AU/i81
 lT9ND8XWvAQ7IzK4NuFxYCBGPjkRQjgyKIkXd800ksgA39HQm5JK3/Z6XweyIaaxbWNL
 bgX0tTzdYbdaVAD7KMfUa2OcT/XZ3ZwsK8XJsYS7EOecP57ncmJL9qpF41mV2bfkCVHV
 Cx7dtat56WMAE8Qpyd6y29/aUaYis1741NSlRP5ealCVd+MrpF4Z/92lMQ/icmhe8o6Z
 e6MYLBddHAgoPOBDVnc89lqIq3UHhe4zXeNjP/d6d+r0Jzc9ogfbqSmNQjowdy7/yr8K
 hslg==
X-Gm-Message-State: AOJu0YzTXGkJC1hWC5qoPn/BX971AXq37sTFuDXfTQKwWTiXqXZIqFy3
 AwgVSA+wYS2l7X0mc+vUny9f4q+ZUvKOYgrprK9CyTDqstfaGmtgvn7vALNt3pTYt18xVyl6ZBN
 GjpA1uWE=
X-Gm-Gg: AZuq6aL9zzxMZHzNvbRz8M16pfr93apIwRi4A1Fb4H+ieWUZWLzFW310rYiKCAufDb7
 9StLDzTfxxF/FQNCRlPLwnI1Z0bjhktX6X3vgiQGdee+lkek07em5hjP93uCuCSb/7+zXzdEuzh
 Lbmvp8cEIhU2tgd1oEDve37QIGHcmgHs4NkFw2opV6xxhRmb4Blf+qPIe5IVHmACdpxFN3jxGBF
 K9OWPByHQhs5PSKsH9arNZ6rXMnOwlfwK/j8EVj8xxh7UsB1W0Ad3nU069e53UnrSyEu4PUdLvo
 hqmSwe6DlmG/uomdY1c6go4qFaz+2Zn+dfX4DIOh0ZGUC42Hj1JMdl8vAYLNgbGunHRgBB04OJr
 Ag6iKZQYpgLEarusJyUo11CPBGNgkd9N9gS3kPhluN6zVx+vNww9GTy6FAUJwz1tUlNfHe5cIx1
 SJGN1YMBI6idLRal13EOKADFqjmg4KE0MKcye/Qi1bElnrwUo/xD4I4oxniD2J
X-Received: by 2002:a05:600c:4f4f:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-483051553a4mr52551835e9.17.1770131203777; 
 Tue, 03 Feb 2026 07:06:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd3953esm145542275e9.4.2026.02.03.07.06.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/30] target/alpha: Build system units in common source set
Date: Tue,  3 Feb 2026 16:04:23 +0100
Message-ID: <20260203150436.71907-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
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

Since commits bb5de52524c ("target: Widen pc/cs_base in
cpu_get_tb_cpu_state") and 32f0c394bbf ("target: Use vaddr
in gen_intermediate_code") we remove all uses of the target_ulong
type in target/alpha/. Use the meson target_common_system_arch[]
source set to prevent further uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202234550.34156-3-philmd@linaro.org>
---
 target/alpha/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index 7dbbd557171..9447f8020be 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -18,4 +18,4 @@ alpha_system_ss.add(files(
 ))
 
 target_arch += {'alpha': alpha_ss}
-target_system_arch += {'alpha': alpha_system_ss}
+target_common_system_arch += {'alpha': alpha_system_ss}
-- 
2.52.0


