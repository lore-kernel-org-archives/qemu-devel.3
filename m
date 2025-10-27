Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C646CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 08:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJ3k-00041n-Oc; Mon, 27 Oct 2025 04:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDJ3f-00041R-78
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 04:58:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDJ3b-0002US-6x
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 04:58:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-79af647cef2so3745050b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761555500; x=1762160300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BRPwAmzEtN5zn/cUwTdexoYMkniskluAW6/Bh6lNOlY=;
 b=rOghzfF3kN9x2iZVhCpYV+c3ZiheP17OemRBySgMhqgvTuxM4KKB9lByRuF/YSrFHs
 hE9lnpCFRpg9+9x83j4Rk4Jzko5yg1B8ehBXXjAnylGJ5UjOa2qSo6G4Tk/lswGzQK1p
 0ZNAqFv+NR1f5H0sSixYAfezJgpNNOv9EIYOUlxCA/rZfuqXDn0zl/e16rGBHmb5Cp0d
 D7fC1/RMbEMySf47i5XvkYAspnKbnWOflDkEUzmpmGAVTsvuEL6DNETVRqETZwoXq54o
 CHdkpWzXzScCXEhDwXkzmQLCh4p6XLNa0X8Twb+Ah1oVmgevM4tgIK8rOfLEDjA72Jjx
 6Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761555500; x=1762160300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BRPwAmzEtN5zn/cUwTdexoYMkniskluAW6/Bh6lNOlY=;
 b=emZwh+/Bmr4TdWLggpMhxAWCI4NnxhZQ9/x+iBBVZ7dD1XqOVOWFE6u3ZgRwVZJbkI
 lrMnvAxETgUQuCPXV5vB8ikAVEAfkm6z6jHSurDuWund+VQuIG9oVwxUvx0zs1ypWAc5
 dIKgo51scbaFV8zDjICUt7BW/GJqBjNHMfJiDkD6Iw5MzVFIMFq/eXvHu/qbuMVLsE3q
 vbDv7CvBYMtjA3bcW6YIEW034FaUf+6uwZTT7IJXgt2Rk0uN86svIoE5gAL7nfGD62kg
 PB0sa1N4k/x9aGDkOEjpgXFLOrbr49GPSeSQweQIcE1wk7XAcu82Kd/x5bspUhMOct5y
 JEPQ==
X-Gm-Message-State: AOJu0YxrDTy44/WCHXuZ0HHIgd40o3PICHlJ1NF0FXQnmqbDuvNpZ/V4
 8WiDHS/Ai0V50lwd0VMxS5b9jluEMOy7XFbUZ/FJ74O7dpTuukjrgAkR9np0EalStwfCTZjSpps
 YDH0a
X-Gm-Gg: ASbGncvsxyUxzg0+FXZjyez2QYjLxeVRJU6KOHlrFq401sUskTQmGoA7ZXRbRZa2Y6g
 UkRn53LtTO1HMSddb6N1OweXKtUhLJb89l+T29EJoZj8PIRBkWX3JwjTZ3TUsHFLoAAzBCbcIXy
 2G+HANBsc1e/scOJ+jJYatoi4asqXg0M65hu5W2Wifg28gBVbEhioCaKyX3aBr3ap5Hk36atbEc
 AXZeouEKd09LrWj3x06EZOJI7B2KGcGj5B3rUM6BIIBxtmtdvI2Z8XeRK0Qq/9gNljrPWWM0nZc
 yYFh6KXYg77CGBPjnb6bVai8C9brDxbnjt6aALrVPmhcUOesNpiSTuEAFyGtAX5bNqGep0H8IUf
 rJln3D3X5zD9NSgl17iaY/NXIHUnXie07FglYc1s06Wm1Ev0DTrU6Ro4dQ6EMYpaLWyNhjZEp6Y
 dkRJbBIpKcol5hLVBcG45VAa2VIRCHgJ4=
X-Google-Smtp-Source: AGHT+IFe3V7F9XnzRwcv1AQVWDfpvCFTWNUjnU328ebrD7XDTw/DBD+qNHQ7UfLRaTzrkwXT2BmJKQ==
X-Received: by 2002:a05:6a21:6d99:b0:334:96ed:7a61 with SMTP id
 adf61e73a8af0-334a83edc85mr45490519637.0.1761555499971; 
 Mon, 27 Oct 2025 01:58:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414034661sm7473559b3a.26.2025.10.27.01.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 01:58:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] docs/about/emulation: update assets for uftrace plugin
 documentation
Date: Mon, 27 Oct 2025 01:58:08 -0700
Message-ID: <20251027085808.2306054-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Linaro is discontinuing its fileserver service by end of the year.
Migrate assets to GitHub.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 8a5e128f677..320443bfe61 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -886,24 +886,24 @@ As an example, we can trace qemu itself running git::
     $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
 
 For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
-<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.
+<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
 Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
 using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
 Some sequences taken from this trace:
 
 - Loading program and its interpreter
 
-.. image:: https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
    :height: 200px
 
 - open syscall
 
-.. image:: https://fileserver.linaro.org/s/rsXPTeZZPza4PcE/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
    :height: 200px
 
 - TB creation
 
-.. image:: https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
    :height: 200px
 
 It's usually better to use ``uftrace record`` directly. However, tracing
@@ -916,7 +916,7 @@ Example system trace
 
 A full trace example (chrome trace, from instructions below) generated from a
 system boot can be found `here
-<https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz>`_.
+<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
 Download it and open this trace on https://ui.perfetto.dev/. You can see code
 executed for all privilege levels, and zoom in/out using
 :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
@@ -924,27 +924,27 @@ taken from this trace:
 
 - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
 
-.. image:: https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
    :height: 200px
 
 - U-boot initialization (until code relocation, after which we can't track it)
 
-.. image:: https://fileserver.linaro.org/s/LKTgsXNZFi5GFNC/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
    :height: 200px
 
 - Stat and open syscalls in kernel
 
-.. image:: https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
    :height: 200px
 
 - Timer interrupt
 
-.. image:: https://fileserver.linaro.org/s/TM5yobYzJtP7P3C/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
    :height: 200px
 
 - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
 
-.. image:: https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
+.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
    :height: 200px
 
 Build and run system example
-- 
2.47.3


