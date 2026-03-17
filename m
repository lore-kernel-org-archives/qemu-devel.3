Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863C1FEDA0A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Zh2-0005PI-J0; Tue, 17 Mar 2026 15:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2Zh1-0005P3-4H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2Zgz-0005oQ-7d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so72302315e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774179; x=1774378979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vTQ62ilT2m/rzys2ifT5XG6JmBUDkEBylAkRPmKwKFU=;
 b=ARI87cz201XWzGdHcUSp5TQu4dzzqaiI5H6vtoH6Vi0syIfGepg5s0l1yc+kp4oMyq
 AJhPeHzm6VrX0to+XZSFSQmDpPnvxra0s5r2aK3BQnRdZTk5Lo4m/spfNVl36R7TcAQw
 dKgFNPe2AugvPTEJPuvkO+rJLwTuUsWA1/kKmtLfMltY0pp727e9uj1CZ6TzHnXWaaY+
 R9lcDl9XUC3GjC+DVXBOzr75BSASZtlFSeOvKAiY2N/5m7y43LBaq8C864ha+QwPMdR8
 vTxQzZhYFxrzhVBK+x3sL/SBLQr+tMSKIVJXpbwA5FbKnJHO4bW4nE0Gl/ePo4V1qbAd
 2FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774179; x=1774378979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vTQ62ilT2m/rzys2ifT5XG6JmBUDkEBylAkRPmKwKFU=;
 b=rsb+/jjbRw8DlSM2wdmTGueLXSQ5eTQQjkfa+Dn3GI2NaviFpohrPQN/xc2zueZ4d3
 LlP4vOTAj9nDOupae+aGkegneEmzg1GcVXfvVsKhDddouuk2LlwMi1q6K1RXLYb0Ll+s
 ZAwcWF7sNlhXOKIrPMHvO2KSr3jaHSQWUcSKMHu3cSTJDSZkQ3WLLS1KWdyL2RtKi5XK
 /wK54WpFHmLBv7AsY7JD+ze42ayv4fKxlfhVoR+ykP0Qv9Gg2dxHEt/S1pTuX6aUmIn6
 mM6Op140a1qZT1z+lWYU//Mj2Dht4iuHXNccG05hzTgQQ6b2LpVi1juCg3ZuVqkVyC8A
 jnOw==
X-Gm-Message-State: AOJu0YxE7S1ZNnofTob16YSMRR338fd95bYczWiH1/bLPK5qer+CNO8S
 EFmJYl2e5eHBKsPAea6mC2FkqkPNUd/Y458cBxEGHyztJGLq5/a/1QCcXqQqj3t0CfuYWkv1Mzh
 5uKb9k78=
X-Gm-Gg: ATEYQzxDRcT7BmV/oB0zXIuPvbaoc0Wm/NJOSoRq59zfHXhgDcD3dskczvb7EKmQVMj
 G09aV4RZZYOBDXH8y4zbEk/kss3m3lcThdLOwVp7AzUMa13BAZD/keHeiEnb05O7z4qJ8srB1Y9
 l+ACQziRZXePvJ3YcRvgrvih/l3wMyTjFiD5D7+K1KR2HSR8lcKwO+1yaQeHJ8esUhmWg5d8adN
 3yp/QKDeyzMNBODQpPrtv6b9Nx47cFZ4JAn/baufhdmdEh73OJm5mHk77LL7SpCUPhXMDO41XQK
 5YZQqAORJxjZ2Wr8mfZoBPlNkZJnxKlGp5tnHSe0gjFqFzdD3YGpOjiivpjzNRHw8ht426lRYAe
 91oV7StDP7rJRxsk0KzwdogiQt3RouI1ywXj0Hvj3YPhgQYKLb9NVDWaLcSkjnmt6uEPpiVnSH9
 hcmYsoVq8OYJhEh0MLSoM65kAzesnFTgNLvhgOmG+mvcGqbk9eJJTeUNcYk/ZOEyh+ECXmJYaz
X-Received: by 2002:a05:600c:4e4a:b0:485:ae14:8192 with SMTP id
 5b1f17b1804b1-486f442d3d1mr11797025e9.7.1773774178422; 
 Tue, 17 Mar 2026 12:02:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a3dfasm1232868f8f.33.2026.03.17.12.02.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 12:02:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] fsdev: Build stubs once
Date: Tue, 17 Mar 2026 20:02:46 +0100
Message-ID: <20260317190250.70506-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317190250.70506-1-philmd@linaro.org>
References: <20260317190250.70506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225035739.42848-11-philmd@linaro.org>
---
 fsdev/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsdev/meson.build b/fsdev/meson.build
index 95fe816604f..61bc8830be8 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -4,7 +4,8 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-iov-marshal.c',
   '9p-marshal.c',
   'qemu-fsdev.c',
-), if_false: files('qemu-fsdev-dummy.c'))
+))
 if host_os in ['linux', 'darwin', 'freebsd']
   system_ss.add_all(fsdev_ss)
+  stub_ss.add(files('qemu-fsdev-dummy.c'))
 endif
-- 
2.53.0


