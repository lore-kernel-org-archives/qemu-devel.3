Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCB6D30CC0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 20:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vflAq-0003u7-6r; Tue, 13 Jan 2026 15:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vflAo-0003tk-Qn
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:39:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vflAn-0007Hm-Cd
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:39:30 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so54373875e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 12:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768336767; x=1768941567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oyXbQp4YAGMwt7g2na/cCqjuxeSDQoHhhgBmKBdDdWg=;
 b=G7Oclne6uwAWh/1DRpViHUBbM5dERQwcxf3UTI7/G6bz4SqAVVQdOU3x3wFysWStY6
 kuw1WrTRxZOX5l5L3di8k5eSbZ1xOXx2FKfYErxUMdeWg1AAkKeWCZRJ6HA1HkFzEtfL
 vXIjreTq2PpuiVG5lY/mahTbtSj/kaALn3CSypy8eaptvtwEW96P3/fmw1R7V0WBbAg7
 K9j3h10YF4Y5vHdLxNq/3Ob7qKbL4rs7UGE8NjiDpoG7i9rJbyFHPn6bU9ZzyeofrnSK
 cB3UcwwW9unRfDfsISH0nZo7IXeCwAI0Z3bEUOIzu53V2DCj3GecI7/9zm37/MTbEBE2
 CsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768336767; x=1768941567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyXbQp4YAGMwt7g2na/cCqjuxeSDQoHhhgBmKBdDdWg=;
 b=Fd/wW4dapxPGu+Ny0lEoK1frdiinUyRsuvXX6HkenLLB9CuMhN1e0kGHrKbwQamPph
 zuCHMMRVW3jDEaVqEHBkXP5XyujetsUu2gYHFByFjdQ+eRmxNEA/XgXQOzZDsPV+2zAK
 BbgtRqeYjvOka449lTxD7gMvfUlMfRAiaHBepuFVjuyhFyVumrygaeaMF+IqrgzBsQ6d
 wTJkXcea2F5ol8mjSHeXqbhUCgTFEV2fMlY/6lPKhLT0Vj22Zc0fDHY7XgKXttkiENhK
 R/SA6FDvzAc/oM9D1vx7ZegV/z3+BcTzl0oOORTKNvb0Yxem9w+bFwvjXLkcgDlg2+T+
 bNKw==
X-Gm-Message-State: AOJu0YwN0cvpnc282+BCwIyPMGMiwidSZhb8TfsG3tPjdxoY+8CeEnUa
 MxJgsiVOSsv6D7M0ji3VHgsHCz/NlEIxi8mRWitYeWQu8Nm4cEbfRjGqMkggtWBVU0ffjmG/7sq
 QxEy4B/E=
X-Gm-Gg: AY/fxX72QdbIPW6dBE+BMCsIgj401P51C8bmBvjyNRYCjU1kmj1Y9rHrhw0He1a6iii
 ZsqHpQBRnvK7BRQBpgXKul9atYMXspElzlD2u8LYsmGBZQa/rvChmnNKkd4WzcMdUmHo3Z75Yqx
 xKA/BYHfw2dloQr8pFp2tfBGdGO6jfISslCtLvFrKrTl9B77LfFVOgToYLzIF7/3ZGQ/3gAkALX
 042ZDFB2GB8L8WDDOA/3r71GjKRjjr7uAHoWpO/Zl5GK4KAH4LpLroAR/8CBprEZhSkaVUewTps
 HlS0buk9SPQrREk1qKPAlqz0UCrHWZNvLKN83e+shtGugtAjZzLzs6eYPAb3aP3SSq/BubFkVaw
 3paMnzH4F6PIJOg3OlDN1SNV5LqjnQWU3IvALzyK9xIMvkNpwx0qGonBh+VWuoHWhCzLtzeQC8Y
 1KlE2wnBaq3qmexL9FjQiEPz25XlmbnRLz8f/sH5CotOxXYRpG7LtgHN04qmeU
X-Received: by 2002:a05:600c:1383:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-47ee3353f47mr5240485e9.22.1768336767135; 
 Tue, 13 Jan 2026 12:39:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacdcsm45600920f8f.1.2026.01.13.12.39.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jan 2026 12:39:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
Date: Tue, 13 Jan 2026 21:39:24 +0100
Message-ID: <20260113203924.81560-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix typo to avoid the following build failure:

  target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
  target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no member named 'vcpu_dirty'
    988 |     qcpu->vcpu_dirty = true;
        |         ^~

Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: 2098164a6be ("accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Untested.
---
 target/i386/nvmm/nvmm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b9bd9ed985a..f808828d492 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -985,7 +985,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    qcpu->vcpu_dirty = true;
+    cpu->vcpu_dirty = true;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.52.0


