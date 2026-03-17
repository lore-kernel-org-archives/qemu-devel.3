Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37EDFEDA0E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZhI-0005RB-4z; Tue, 17 Mar 2026 15:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ZhF-0005Qm-O1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ZhE-0006WO-5f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so50531805e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774194; x=1774378994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yxhUc/dMZsL/5rHwZL5dJ30T9eaxJIiM7oyU8Vqo9Vc=;
 b=ufNtALO19Eg46qPoxfPKLmp8FmccOvLlYxjFyYqQthiws5sZ38IRC3BUPLOOy5mEha
 M4vcZSO09X/GzIU1SyTFZfcNOzowptyOYEQ/4EhrtSMjUrI+WtGXCgxXZqT/fqmzx6dU
 1/cyySo0niis0HISrcWVutZmSCRtyIThWyh5BVSKQOOuqfKrXjg+tt52ePkKsQ4X6mXQ
 bm9ffssSJ71p2yxV3sU4tQH6rF6HRcNgXj4rNWcY2oqh4balF1sfwhogrrVRJuNLcV7q
 Ku9bky/PNNW7ftWN+ZWYvzm/nVfRr/LNmCALMAyqOdr/ewg5ps5n5hmpud9UAPefQ6QI
 2wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774194; x=1774378994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yxhUc/dMZsL/5rHwZL5dJ30T9eaxJIiM7oyU8Vqo9Vc=;
 b=puFJQ5ecXKc0xILR9rg+5lLgGvpXAR1A8YSvOj/0ZXj1hRh8ewBtUTKWLcb7m+LzsH
 zPqYQw9fBz8wL7I9SR8DEDkw+enZzjZg7t4m44YQKBuwk40DHxQhKqzXungP6RFWnzhG
 Sx6OSjoaG5FqgY/UxlCDpc5Vg3GZPY3Y9ZJcYi7MoHstntv8APgovlaRv/AhAto5V4mX
 G/vKwxGGc6VG/AbCswprtl/gsg8XDW6P+HusrFT0Sxbwdqoiyzc4QLXIWknBDnTr9ff3
 WmaTjtTatI9d73t18UtpVqxd9liWycYTs9QtkvdGF56q7GvtrZCh3NquThHQRHiy1b+n
 ADJA==
X-Gm-Message-State: AOJu0YwOTFRBjqtANsIFBQ2m07AlouHWHXU6fN5IEXdiL914P2hi5EqS
 VwfMy/+oCeI2yqqOXLvLoraQIp9VyINxATeXbtQQrOAW+B+QlWFmIJG2rl0P7VLP1WnTQ2r+UAf
 pQkSItD4=
X-Gm-Gg: ATEYQzwm47jbBvAfXE+Dmd1j01EOcRwjYLwYb6UievEng+pk98T19jqVWubfn2iUEqo
 jYB390UknGyzcq8kJPmAwY6o2c7zfQnR1W97wraMR2l2xPX2s0lowcczcg/S6doRORQsYpediNd
 9y/hw4XK+SSlNIaHsweUxAXazC0GLQpIRrmhOSUX3MNPZVBHcEfONz4rujogsBvPb6UTP/b33Df
 yHO4HGhG97+e5P15rWn4KUJ+sGeadvwaSe8KliPp3eUxkeC+o4LFJbpCWh5e4d/datsVgQ+UhX5
 GcyLAieIA9jXVD2aLdVO6CGNXC6XBby5hXYTB07m2Clb+FHtMJVycEGFq0QqxT737I0GGWvnnoc
 dPVcFM6ZwgYBUyVmZQxTsuWtRKO5TgiBEkryuWoYCLBrKLW37EE8SgRsRB1RRyvRwIX63YYS4sG
 wKLpaioH7RAhhF70d6KdDQMvOwMZYrDwUJ8+2FQOuPdc1EREVNgRceFFxxAIY7RzndW/vntstA
X-Received: by 2002:a05:600c:1f96:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-486f44606efmr10760655e9.31.1773774194296; 
 Tue, 17 Mar 2026 12:03:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4434750sm10008485e9.12.2026.03.17.12.03.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 12:03:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] hw/misc: Build 'mac_via' as common unit file
Date: Tue, 17 Mar 2026 20:02:48 +0100
Message-ID: <20260317190250.70506-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317190250.70506-1-philmd@linaro.org>
References: <20260317190250.70506-1-philmd@linaro.org>
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

Nothing there is target-specific anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-39-philmd@linaro.org>
---
 hw/misc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 96b6705b7d0..092f70bde28 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -154,7 +154,7 @@ system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
 
 specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
 
-specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
+system_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
-- 
2.53.0


