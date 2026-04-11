Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F9F3ED6A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgyJ-0006R4-3r; Sat, 11 Apr 2026 18:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgyI-0006Qt-3s
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:38:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgyF-0005x7-Km
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:38:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso49011935e9.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775947109; x=1776551909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=42U4D7cSh/x4jUGEvf5n81x+exxEiYajm+UJ+z2Xv+Q=;
 b=Nivt8FZMqMuSh+NKYvvFIsm68rDKEtgJ3c1iNJYverYh1ucPv5Gb7jgWqmWQkwCTvR
 Qo9hMLN29gYP8BvYQoO7pkeQRn/f7JBnPwgadk0OpoyYh1mVH11NucKF2eZsh/V5PO5n
 +KksBbHk73N9lDEWO0GSLb6I2MlXhyPm9hG4R30KJzmBuv7m1zW6kGI5LnF498fr8MgU
 oGMq2zBK9dLemdhSResK6APoWF+BjE8ixHA18wUX3GmNh63oZEoZGGCJG5ESeeNa6wh1
 lHc7784RCZwgprtbbVDJ9cxQWkx24atJobnp/MD358z8Y8RiW1meEe9wuI0LxX9OK3nZ
 by5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775947109; x=1776551909;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=42U4D7cSh/x4jUGEvf5n81x+exxEiYajm+UJ+z2Xv+Q=;
 b=WD/mF8DTcZ8ddT+bk0QfO97ITi7/lbTSK6yfFee3lmFJ9dvsozJPp09JUd9ewuh2yS
 CeQlaeqlwuqptXrEjqrGGnXvZjqqTXF/GiK3hUIj0QFRMNN1HdLat/odvzirsVwFhtTx
 aM5FoA8OKOgS5/oIwdenRdcL8pV3whHlkaEskYRYWB+WPHCHVP6S1DK0j57wPUxgQJPr
 q9Bv6Pw0xE+/tzYffQ9bbt8zUF8I8AFqn+5o3HzTTi8vWdp4PCw44mxJfCjRiGhicHve
 koaU+u6hUJ45BZe0Efz6NGgE19+oZsCdXC0r3MZhaVEZ/qGXHKL3CjHgSX+PaWf/3PaL
 r1Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhYclLxCZqW2O5rMwjGVqOconmf4nqEmDobUVKladSBO5IlULkl9nAOB8t04uIlH9MvlYZ6Jn+P8/f@nongnu.org
X-Gm-Message-State: AOJu0YxOhNKPgtfSXLYy0TLz0E7e7TOPuKTT4vbbJArNbojhTrgYyYsX
 pL5xRaUdALZkiCwAg9q4aN29bQ6xPnA7UvRAv6d2EvRGVrTtmdPEQa0MA0VXQdQfHkg=
X-Gm-Gg: AeBDiesE3bIKhDcwJM5in7Zb+B+MZO2irYCO/L26bi0u73AImPDanx6+zBP8WMFhBzY
 zQj76ctDE3FY9ayzTfEXWgGRpFbMW5VuIt2Mwsr5BNRglxtjG7V0o2oDT/u6hPgqkV8uI0Pv3ch
 a2YxNzmGCQFwRQXcIQbIRAqtGFKLrubtUOnrlL6QAfnvsmLATAHIEOV/UKPoVJcytlUExssjcRD
 xGPtkTHLj0fCBzv5dSdJcg9lW2VN1k18MSTWI04RFMq24C9tfVnqNfA5BbjcAOXTSO/OySnc26T
 /9SteuMyo0v3e6NMFBopWTj2m5L3jK/8Mo8ND2yOUatEJWidkSx1txAu4l/Or48R/gDIf3v8TSl
 SU/mUWMIkpu5BlOHbdM3NvRet3Tc2dNP0M7BDrDzY6xczUIn1AUalU9TBsEylDIdARFBVnj81fL
 seIDWzo6H4cYdJueybc3oMhDfXXBSb4fIJt1qy+g+Iu496jU91bN4NiuXQ/ZXCXsOWPww/qLpno
 wDW
X-Received: by 2002:a05:600c:890e:b0:488:bd79:94d8 with SMTP id
 5b1f17b1804b1-488d684331emr71220895e9.18.1775947109529; 
 Sat, 11 Apr 2026 15:38:29 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67b46ffsm75380845e9.6.2026.04.11.15.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:38:28 -0700 (PDT)
Message-ID: <4a9327c0-889b-4907-9a83-9261ef1ac5b6@linaro.org>
Date: Sun, 12 Apr 2026 00:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 60/67] ui/console: rename public API to use consistent
 qemu_console_ prefix
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-60-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-60-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/4/26 21:19, Marc-André Lureau wrote:
> Rename the display and graphic console public functions to follow a
> consistent qemu_console_ (or qemu_graphic_console_) naming convention.
> 
> The previous API used a mix of prefixes: dpy_, graphic_hw_,
> graphic_console_, console_has_, and update_displaychangelistener().
> Unify them under a common qemu_console_ namespace for better
> discoverability and consistency.
> 
> The main renames are:
> - dpy_gfx_*() / dpy_text_*() / dpy_gl_*() → qemu_console_*()
> - dpy_{get,set}_ui_info() → qemu_console_{get,set}_ui_info()
> - graphic_hw_*() → qemu_console_hw_*()
> - graphic_console_*() → qemu_graphic_console_*()
> - console_has_gl() → qemu_console_has_gl()
> - update_displaychangelistener() → qemu_console_listener_set_refresh()
> 
> No functional changes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h             | 108 +++++++++++++++---------------
>   hw/arm/musicpal.c                |   4 +-
>   hw/display/artist.c              |   4 +-
>   hw/display/ati.c                 |  16 ++---
>   hw/display/bcm2835_fb.c          |   5 +-
>   hw/display/bochs-display.c       |  14 ++--
>   hw/display/cg3.c                 |   6 +-
>   hw/display/cirrus_vga.c          |   8 +--
>   hw/display/cirrus_vga_isa.c      |   2 +-
>   hw/display/dm163.c               |   6 +-
>   hw/display/exynos4210_fimd.c     |   4 +-
>   hw/display/g364fb.c              |  10 +--
>   hw/display/jazz_led.c            |   8 +--
>   hw/display/macfb.c               |   6 +-
>   hw/display/next-fb.c             |   4 +-
>   hw/display/omap_lcdc.c           |   4 +-
>   hw/display/pl110.c               |   4 +-
>   hw/display/qxl-render.c          |  12 ++--
>   hw/display/qxl.c                 |  14 ++--
>   hw/display/ramfb-standalone.c    |   2 +-
>   hw/display/ramfb.c               |   4 +-
>   hw/display/sm501.c               |   6 +-
>   hw/display/ssd0303.c             |   4 +-
>   hw/display/ssd0323.c             |   5 +-
>   hw/display/tcx.c                 |  16 ++---
>   hw/display/vga-isa.c             |   2 +-
>   hw/display/vga-mmio.c            |   2 +-
>   hw/display/vga-pci.c             |   6 +-
>   hw/display/vga.c                 |  40 ++++++-----
>   hw/display/vhost-user-gpu.c      |  22 +++---
>   hw/display/virtio-gpu-base.c     |   2 +-
>   hw/display/virtio-gpu-rutabaga.c |  10 +--
>   hw/display/virtio-gpu-udmabuf.c  |   4 +-
>   hw/display/virtio-gpu-virgl.c    |  20 +++---
>   hw/display/virtio-gpu.c          |  26 ++++----
>   hw/display/virtio-vga.c          |   2 +-
>   hw/display/vmware_vga.c          |  12 ++--
>   hw/display/xenfb.c               |   6 +-
>   hw/display/xlnx_dp.c             |  10 +--
>   hw/vfio/display.c                |  32 ++++-----
>   ui/console-vc.c                  |  12 ++--
>   ui/console.c                     | 140 +++++++++++++++++++--------------------
>   ui/curses.c                      |   8 +--
>   ui/dbus-console.c                |   4 +-
>   ui/dbus-listener.c               |  10 +--
>   ui/egl-headless.c                |   4 +-
>   ui/gtk-egl.c                     |   6 +-
>   ui/gtk-gl-area.c                 |   6 +-
>   ui/gtk.c                         |  18 ++---
>   ui/sdl2-2d.c                     |   2 +-
>   ui/sdl2-gl.c                     |   2 +-
>   ui/sdl2.c                        |   6 +-
>   ui/spice-display.c               |  16 ++---
>   ui/vnc.c                         |  22 +++---
>   hw/display/apple-gfx.m           |  16 ++---
>   ui/cocoa.m                       |  10 +--
>   56 files changed, 372 insertions(+), 382 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

