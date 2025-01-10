Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07232E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTq-0007jO-3F; Fri, 10 Jan 2025 11:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHTC-0007Kj-CU
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHT6-0004Hr-Bb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso25823215e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524958; x=1737129758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdLTUyiJZXg+Jy7eGhrfWWJqUYAsXZouUvxtiAwdX4U=;
 b=nOVySbNnyTBgoPClvI3NoUgqfmIzyVf8l2JywQ5d7VQQHLKEIVLN3cIUiXloHqH59Y
 Y/QGHTaofs17yVSEEJF4uwC2U1oHRgQQa8SwwkNqdfNudsIaQxYzSKx+KuCeNtI66NKB
 D3wrpEfLQKaZMIWw4dAGVldL/8F+t+Cr4BgC06mkhDdy49ik5/wuoSxnC/9t/WWcZ0CG
 T1r6yKkDieh+fTai+BTtpVJaTbvEGlBy3jDjnvbJf69ulCcaJMxqvXA3t31Ndi293k+B
 tVXhB4jKSD2lEJvH8G/lAPVCwBdeVW+wgLw1ZSGFbPJ4PS9nzXU+sAF7h6reYLCKplwn
 4ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524958; x=1737129758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DdLTUyiJZXg+Jy7eGhrfWWJqUYAsXZouUvxtiAwdX4U=;
 b=j+3f+TEPjuWfmmzK79HsWlfPGs7tQ9elkv1HeG4KsMfyD41jVPavloJQpNmOSyXbB4
 64WLzpkh9XfHGnWKCiACjtNvIXEyye5rmkCNGxtuCe5u+0A/nysaEa9gysgZeME2vEt8
 MtK3ClmQZl+U5OiAc0zUnoK2/kyK1ISOpxEnY9HGTLbvQqOtkO8cBmWWF+3fGQ2nXDAz
 WMHgVmh1EaDhxlThA2yIgg0rp72t9pj12WjWDzbBhjmhX5lYqlVsEhinOGIZ1fsHOahg
 Gmf2+gIzb9QD0OWe1xhuzs1QnclSKl40w0tLRkaZ3UBjjO/Xy84JnOdxJsaCzFx30rj1
 Ngzw==
X-Gm-Message-State: AOJu0YyWsEC0/DVdo8O6YrabVzLXJNgyhElDQQEB+yc4Z4a4jr9zRRmd
 fPZoBuJJTRIOlkn+eVPRFrsT7go05I64m4ELHhrOtJAVWMfI6tF6u8Q+bGHyKPV1jBTaUXcL43p
 DPYQ=
X-Gm-Gg: ASbGncv76Mn3CHXne2uK4jWybYUerKZiZdGrlONkMeiyLviCQvykUL3//lVARNzRL06
 cOITroTv7nMzsPZLa5HD0CG7c7JJWgjPB3qa5wgj5O5C9iTf+hTdkCDyy7eDA7rVwEthnz2PUGn
 pKGVaYWUYkgWuLX+IQSesNWfBVNrQdR63NbyXALIoTsHMbAjX9NHoYpJWtAom1NTkzU/lqSrWrA
 hpAmnrIShdbRwgWsKvgXQx8I5eWejUKUPZrIXPsDsNBE3rpq0qgDcxnns5bB5X1Kc7aecpTGq8T
 IopSN6/UnuLiYZkK2LcrgAoCfkfpWds=
X-Google-Smtp-Source: AGHT+IF0E8oxcLuBHXaUffKOJ/ByULhRSrOs5kdgzk5GTrdSSeCicvxwHpTn8BMxfaZnGPFuDai+mw==
X-Received: by 2002:a05:600c:3b88:b0:435:192:63fb with SMTP id
 5b1f17b1804b1-436e2686662mr101223575e9.3.1736524958131; 
 Fri, 10 Jan 2025 08:02:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc08bbsm89879665e9.12.2025.01.10.08.02.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] hw/arm/stellaris: Only create MPU when available
Date: Fri, 10 Jan 2025 17:02:02 +0100
Message-ID: <20250110160204.74997-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 655bf85e89e..d87587225c2 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1128,6 +1128,9 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     qdev_prop_set_uint8(nvic, "num-prio-bits", NUM_PRIO_BITS);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
     qdev_prop_set_bit(nvic, "enable-bitband", true);
+    if (!DEV_CAP(1, MPU)) {
+        qdev_prop_set_uint32(nvic, "mpu-ns-regions", 0); /* Disable MPU */
+    }
     qdev_connect_clock_in(nvic, "cpuclk",
                           qdev_get_clock_out(ssys_dev, "SYSCLK"));
     /* This SoC does not connect the systick reference clock */
-- 
2.47.1


