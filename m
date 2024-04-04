Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3B3CD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4P-0006XC-5k; Thu, 04 Apr 2024 15:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4M-0006Wl-Gn
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4I-0000JC-1l
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4155819f710so10161265e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260093; x=1712864893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RBM9iGLnlKBG0LPukIWmtJI1ZJZDBhgI9dJ0vdHJw0=;
 b=r012QBM9k29iolkwC1jbAk/5PbxI+X54q3VHY1r1YkbVKQapvbMjShLAZ4MvDnPp+j
 U2TAyoHZDlY9e1ZxgrwsScvkzL8l/5GN/OI4Bda8y7Q/tqeSxOsVAuhfK6dhjwSCmsDa
 uBi0js9hiulwBz9ST5kgPMR18wLXXMxFJr+RZCWUdyz2hjt96nZdUCdKV51SPvl7me2F
 idc3RWNxMVjOYQg77nt753wXs/aej0VbFFeDx39XO9HZ612+3fXELUvE6+d9Gm2HdOGn
 NuFZuEcqVBYM0p3tBZdjFDWKsKxqKLVbVOcUuU9GXAbFFUn1jyzPjKYJvE/OFN9bR3B8
 CYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260093; x=1712864893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RBM9iGLnlKBG0LPukIWmtJI1ZJZDBhgI9dJ0vdHJw0=;
 b=tFD9v1R9Zl5MNCsuRkWxwyfJjrypBMSjxZy+LIIIXUyboEruJMM4GvykUYP7DkQo5h
 9ZUUhuHeT3LmgHopqyn9rDvgTw64ceRXoXhiUStRTfMIPxmWyiXxwWDo3PEBrXN/8BSj
 DHL4h23li4I+/gYjm/OYmW1lNXyVfsvEr/yhdMKz+7yHN34tQi9SkPmnvJX/YnM3yhau
 0qW3eq1pWay/xvzba4dgFMlElBIjw7lTaYSTC2P6kQGP13cYYGa573pY+/TbWz93KhyF
 z6fy2C820JMroEz7GYzqG8gHdSHP54cch+G+/DffVYSG4UxkoteM8u4JGMjM02o3Ml4g
 dGzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0QGMw1hD1GOdeYik+F/6IqtrETk5BUxT9p/+br/cNDCNHjAT8Em5zqqKo9/Lnbvt2cCrOOjL33hdMNzRr4FyM2cjytE0=
X-Gm-Message-State: AOJu0YwL+2SEcqTgSqKbzVQ6xUApqIUT9zkYyKV+UCnBtnYyXUg8x80G
 w6FWDgcqCphMM+XNVAT7L/f3BoS7KJiuwwulGzrHJW5f72CH3HXnat+p+GaqoX7CdEFR1ezZmnI
 n
X-Google-Smtp-Source: AGHT+IEJGGWfe9DZzc11Y8Trl37kEwmZHpOCRfmkweYMGtPM0HCqEZmzN2gtufU+Ykt7SnF9T9QlbQ==
X-Received: by 2002:a05:600c:1c87:b0:414:63c2:23cc with SMTP id
 k7-20020a05600c1c8700b0041463c223ccmr539389wms.2.1712260092706; 
 Thu, 04 Apr 2024 12:48:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a5d5187000000b003434c764f01sm146600wrv.107.2024.04.04.12.48.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-9.1 2/7] yank: Restrict to system emulation
Date: Thu,  4 Apr 2024 21:47:52 +0200
Message-ID: <20240404194757.9343-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404194757.9343-1-philmd@linaro.org>
References: <20240404194757.9343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The yank feature is not used in user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/meson.build b/util/meson.build
index 0ef9886be0..247f55a80d 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -60,7 +60,6 @@ util_ss.add(files('stats64.c'))
 util_ss.add(files('systemd.c'))
 util_ss.add(files('transactions.c'))
 util_ss.add(files('guest-random.c'))
-util_ss.add(files('yank.c'))
 util_ss.add(files('int128.c'))
 util_ss.add(files('memalign.c'))
 util_ss.add(files('interval-tree.c'))
@@ -76,6 +75,7 @@ if have_system
   if host_os == 'linux'
     util_ss.add(files('userfaultfd.c'))
   endif
+  util_ss.add(files('yank.c'))
 endif
 
 if have_block or have_ga
-- 
2.41.0


