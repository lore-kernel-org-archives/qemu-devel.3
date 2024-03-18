Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450F8C54E71
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7tL-0006Oq-4A; Mon, 18 Mar 2024 03:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7tC-0006Jo-4O
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7tA-00010b-Id
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:58:33 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6ca2ac094so3644054b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748711; x=1711353511;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WbQw99DTFk6zvdCFZmgCS37i1/RpuGMUFEUjJZbY9GQ=;
 b=EJCAB1YB+Ai9jEY5F14I0jf2fdAn7GPbY16/BqB6CPb8xsbB169Pe+DiVGcDsAS9Jc
 BxkbMu0iBMnwDLkHTS7y3RFlw3SeiMyyDA/9/cDh9I9U11JQM3WEmnw+k9YTq6fnP5Lj
 7hpWtrkO/JxReb8VZoqwCjuBygzGT8fLGCDNyWUDp1vWm7e6KHP9kgBdVtZHfeg4p07e
 LXLxzXNH1jwwn21RQtokLFGQLa9vHMzay100sDciSS4HWLZjHuIp3V0ppDdD8jhFrTOo
 mvu7Qqxrcd+oJ1vqIao/9QSniE19F8QdgfkrSQ3erSyo6/irb+tGPiDu5/xzBTk7EQ48
 pzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748711; x=1711353511;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WbQw99DTFk6zvdCFZmgCS37i1/RpuGMUFEUjJZbY9GQ=;
 b=VVcDT8e3aVk8pXMxecxcUvs2f0xSXSKCGSSrfIqpTFpkVFSpiBKeby0K2VyFj5wtnQ
 Yl7N7bUsl4l2B+aplCsalTGMWfa0FgPNRsRWKWLDSKiz/WsLZD0RLlQp3GqDKcVOdUSq
 AaeapHGIUXhcNSFOLcfZfrVci4mJbTFTa0wAkm1zvE5hbNl6K56RKJ4Ua9Zaio8bxxFC
 Y7GnxbolHI6nNFE+Kb6pL9qLCaJ9+qp8S1tSRL0zN4i6vBcFPWbTPxeB+fqV57UI52Up
 PwWNCFygeZfgfIc2iSXX2rkwbMeH5ZxwcZtAXvcXReoJZ+e3vGVKtVt/co6Sle7sSmNO
 hsWA==
X-Gm-Message-State: AOJu0Yw99DJ7/q5FHH510FMzDJ2CpA8WJxaGgule/enAwxRbH4rjGGIP
 rNrSWlRpHy/u9fYC9pdTpwJgWqMmBcdWZasGwElBSFpr1MH4+i3EpAbr/VuYii1rpcxP0GGQfFl
 X
X-Google-Smtp-Source: AGHT+IEiWKIcq5KbBhI2wdDDjejMX22lez2ZHdESiK/KMcrh9ZE9lkOzFVMNZYXxaGpNgo9xBGER3w==
X-Received: by 2002:a05:6a20:e68c:b0:1a3:6194:aa2b with SMTP id
 mz12-20020a056a20e68c00b001a36194aa2bmr1914692pzb.23.1710748710830; 
 Mon, 18 Mar 2024 00:58:30 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 p3-20020a170902e34300b001dca3a65200sm8594259plc.228.2024.03.18.00.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:58:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] ui/cocoa: Add cursor composition
Date: Mon, 18 Mar 2024 16:58:12 +0900
Message-Id: <20240318-cursor-v1-0-0bbe6c382217@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABT092UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3eTSouL8Il1jE0vDJEMLAzNTCyMloOKCotS0zAqwQdGxtbUAaF5
 BOFgAAAA=
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add accelerated cursor composition to ui/cocoa. This does not only
improve performance for display devices that exposes the capability to
the guest according to dpy_cursor_define_supported(), but fixes the
cursor display for devices that unconditionally expects the availability
of the capability (e.g., virtio-gpu).

The common pattern to implement accelerated cursor composition is to
replace the cursor and warp it so that the replaced cursor is shown at
the correct position on the guest display. Unfortunately, ui/cocoa
cannot do the same because warping the cursor position interfers with
the mouse input so it uses CALayer instead; although it is not
specialized for cursor composition, it still can compose images with
hardware acceleration.

ui/cocoa was the only non-headless graphical display lacking cursor
composition so dpy_cursor_define_supported() is no longer needed and
removed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      ui/cocoa: Add cursor composition
      ui/console: Remove dpy_cursor_define_supported()

 meson.build             |  3 +-
 include/ui/console.h    |  1 -
 hw/display/qxl-render.c |  4 --
 hw/display/vmware_vga.c |  6 +--
 ui/console.c            | 13 -------
 ui/cocoa.m              | 97 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 23 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240318-cursor-3491b1806582

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


