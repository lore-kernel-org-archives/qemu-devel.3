Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D430FA1FEE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdit-0005HT-Oh; Wed, 22 Apr 2026 15:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdhw-00057V-Ji
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdhu-0008Oy-US
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so4804507f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887876; x=1777492676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kn5BVWh6SNOlIMzy+X3/6l0AXnMnHe8oiGXHu7DwUhg=;
 b=vBGPbMK205gYkVuF8OAkXYAOk3CQ2yUkeOOA0IS43CsB+uvyeuU75dHuGEi4kb1Mmg
 bszhoiJ2PGjyL6cTWLUCPFwINDu7qrKA8yAaEjDkHRGVeo5y0RTiaoc/zs8lSiwl7XE9
 KPmIC8fvmlK7VfrbLjPSykESHXzUbPL60OI3xxSrTTOgsfH3hULQWkMNbI5DqmIv3Pc9
 CdS2ijoe0rRTsrO6Rc/1VPIoX/CHoAy68b7BObZZgwRgLB4QrxDfpPthL600LvAFtHCX
 CIBw7MZynQIfQUP/5eCpp9tMSwsbWJtvr5xIYsPXuhsVD5anP/5izGycpgMQYF5jMZ/o
 cIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887876; x=1777492676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kn5BVWh6SNOlIMzy+X3/6l0AXnMnHe8oiGXHu7DwUhg=;
 b=gRU9SeibNTeIwuu7Sru4BwlDSx6cUVEJB0/vS9mhUaQ9F2KfLTaR12DPHKDdVRkqCj
 WbqYhq5yhz2bpHJV3e1TXF4Vy6xis4PccFQ0QMaYARmSH/FEmiSCSdzX/MN/OaPRiN0l
 jkzc5cmjQE3q0SdgQRhWtG6Vx6NaOF9BzKyhieEN+lpuhgVvVvxfd/VKmaNzFKJ+b+pC
 c0eWchCknljt6DX+vmSPpU58vZH5vmZvqU3BzbZO1dTsoUiDgRkMFS5Le80NnO9IxJf+
 kQJ8KvMmDFaAOmNEjX6QnHol6my5t/j1W6CKZt7nsNvAAsWNP+L72PDECqddKe7WQLpD
 0RGg==
X-Gm-Message-State: AOJu0YyJMpsrS7lVmtWnbBgdRytoblP9E+QP87GeQfMr4YRnRnMA4YeW
 d0rLA0FDylBYMbdyLNSltNOnzAghfyDLBgOE6IgMvp1/XNp1lNFWUyZ0V/8G16MS5kc6WJAY4BY
 v9ydxYS8=
X-Gm-Gg: AeBDieuxIN5P/AdpEW5MMyi6hyrU5XpB9Db8ThKAnViXJlBiS2wWKkIb3L+iGSW7FDu
 b52o2yGIyYERLHp7zkdArqyKWgjY9ZQQYGWMYueJ6mCNynJCto5t9AGEnwxV9dupiaRlI+ok+p2
 eNKYR77GjR9ysDnyNLaZ/DeY8H9sedn1HsOmq2bk1jiXz8ACEBuq/sz3Zr8wKk2ePRv1wajLUsY
 vlPcbZVT66vIqq+X5LxGwbKosbqtORbAzgUt1lvL/4lI4kSbkoDodV4+NhgZZL5tzp/11iR2Ep2
 48v9gnEG0eYcKVwpuykvVDXaa5hOnviAe9r5FFSF1rYyI93Zq1NpNnjRrGJDwZ6S9sBbJcRC7K0
 RFLJFnyWSZg6pQzogggNqxHlW2bgzMg5EEGxfuQVKni5Kg4X/gk3Ol6VSt5glErdlzCtUpjWike
 zP7pZRV90L/PJOCjxEgJWFAVmbp6mqbV6JeZvwNUZYU3NsthSIjpTwhKh7GaHkimnwwBlB2lmdZ
 VClKLRj3QY=
X-Received: by 2002:a05:6000:18a5:b0:43b:3d80:b0b9 with SMTP id
 ffacd0b85a97d-43fe3dc78d4mr36149357f8f.12.1776887876001; 
 Wed, 22 Apr 2026 12:57:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm51630647f8f.30.2026.04.22.12.57.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:57:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/48] hw/avr: Build as common unit files
Date: Wed, 22 Apr 2026 21:56:59 +0200
Message-ID: <20260422195746.88865-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-38-philmd@linaro.org>
---
 hw/misc/meson.build  | 2 +-
 hw/timer/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 092f70bde28..245ab9b98cc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -152,7 +152,7 @@ system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
 
 system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
 
-specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
+system_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
 
 system_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 178321c029c..201b5d8316d 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -33,4 +33,4 @@ system_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
 specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 
-specific_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
+system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
-- 
2.53.0


