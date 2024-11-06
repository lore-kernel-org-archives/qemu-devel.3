Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1649FD59F7F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 23:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8p0H-0000kQ-Jg; Wed, 06 Nov 2024 17:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8p0F-0000kB-Nb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:59:55 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8p0D-0002oF-N5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:59:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431688d5127so2840595e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 14:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730933992; x=1731538792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OWyz3L5L86eFg5lHeMME0s3gmlfrXvrcQpz6UH1yjk4=;
 b=hVR2aKD/rzeX61Aq56vTifSiUFLHQTWw8zgqtl14jEDF0IP2Ch19JWMRHghfeE5QKx
 fL4Ux4apbdUaZz4Ayb99ib0o/4ppJ4fVujlC0fBbtK7LiO6JSaqTj8duekvaNeL1wFUr
 psdUExjKnTwnKY0wmTYu5U4LPHZdq/yB3ljPG3l7DExGgLL9mKz9YgqbRkEoQ2Hh7pKI
 JiDUapt80C9slKJ4J6e+qzV3iWwKNo8TfnmkgTP0RrRTK3YEkV2pkpmb3S61B6ntk+Li
 v8EDAutZ82rLeGNA2mhezdlZXBjPNDmQ2oHCs4GRBrCWUzzRvnQTeYLlqGSqP1xXLnbd
 oJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730933992; x=1731538792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OWyz3L5L86eFg5lHeMME0s3gmlfrXvrcQpz6UH1yjk4=;
 b=pvlX58rgWlBhN8/KJqgEVdeblZVaAROe2t5z5auegH+c9M67pcRC1yPtJx5dFKFMXS
 k9jpvxbwaMw//VobYO9Vt5pLLdgYNXH27QjgW8FJMPpx7OM9IznLyXQ0xQ0Ez+pAr6ai
 9jY9On5hG1KCgEPxpkPv6+2H15fO1SVhxg7aXHeWYK1ZUz06/fzamH17Uqm+0FDZviin
 459uEanLHFQdC81xf+BvKl/Bsl3TSIXpkd/204ORiLQm7wXA27mSFyjBh91Apb1Yx3b3
 CP5NDzyUCkaNYuDbj8wSoGMA7dSEk97AO/YtP8TB0fhoFpVaSEPDekYaXxaId1DBy350
 wQdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVqFjaU2NHfZ9+UWOnECf/a8OP6CXbsm4Da0lRvaXtaivdbHx51tRx5Um2a+K31hM3fma1FrHP9Asv@nongnu.org
X-Gm-Message-State: AOJu0Yz2mOsnZNNSoutQcOBLXbCfSuWvFzc6XxjuB0jMZN3nZ5Hdtn3x
 uvRO9TktMKxEVt6zu+qVYF26Eq8WFz/UJNwIjd9lAYO5FX0kkDq8qOJWddEWtWE=
X-Google-Smtp-Source: AGHT+IFs+1X5qlOXkePFzSulI+CyhNoBeeVdLoo9f1AdYZ4xS/4cnOr+jF4avFQ4+Dw532mCV0bb0g==
X-Received: by 2002:a05:600c:354c:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-4319ab8d515mr390798025e9.0.1730933991859; 
 Wed, 06 Nov 2024 14:59:51 -0800 (PST)
Received: from [172.20.143.32] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b2d13sm37900195e9.12.2024.11.06.14.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 14:59:50 -0800 (PST)
Message-ID: <c78fe9ea-11e6-4f3f-858b-7fe5f6331c58@linaro.org>
Date: Wed, 6 Nov 2024 22:59:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RFT] cocoa: Remove deprecated
 CVDisplayLinkCreateWithCGDisplay() calls
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241106175051.561352-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241106175051.561352-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

+Phil & Akihiko

On 6/11/24 17:50, Paolo Bonzini wrote:
> When building on macOS 15 we get:
> 
> ../../ui/cocoa.m:662:14: error: 'CVDisplayLinkCreateWithCGDisplay' is deprecated:
>      first deprecated in macOS 15.0
>      - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:),
>        or NSScreen.displayLink(target:selector:)
>      [-Werror,-Wdeprecated-declarations]
>    662 |         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
>        |              ^
> 
> Instead get the refresh rate from either CGDisplayModeGetRefreshRate or IOKit,
> following the model of https://github.com/gwm17/glfw/commit/4ec7daf3e92.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2575
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: use kIOMainPortDefault
> 
>   meson.build |  2 +-
>   ui/cocoa.m  | 90 ++++++++++++++++++++++++++++++++++++++++++++++-------
>   2 files changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index c386593c527..b12ccc12223 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1135,7 +1135,7 @@ if get_option('attr').allowed()
>   endif
>   
>   cocoa = dependency('appleframeworks',
> -                   modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
> +                   modules: ['Cocoa', 'IOKit', 'QuartzCore'],
>                      required: get_option('cocoa'))
>   
>   vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 4c2dd335323..c3fa55477fd 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -25,6 +25,7 @@
>   #include "qemu/osdep.h"
>   
>   #import <Cocoa/Cocoa.h>
> +#import <IOKit/IOKitLib.h>
>   #import <QuartzCore/QuartzCore.h>
>   #include <crt_externs.h>
>   
> @@ -292,6 +293,75 @@ static void handleAnyDeviceErrors(Error * err)
>       }
>   }
>   
> +static bool get_fallback_refresh_rate(CGDirectDisplayID displayID, double *p_rate)
> +{
> +    bool found = false;
> +    io_iterator_t it;
> +    io_service_t service;
> +    CFNumberRef indexRef, clockRef, countRef;
> +    uint32_t clock, count;
> +
> +    if (IOServiceGetMatchingServices(kIOMainPortDefault,
> +                                     IOServiceMatching("IOFramebuffer"),
> +                                     &it) != 0) {
> +        return false;
> +    }
> +    while ((service = IOIteratorNext(it)) != 0) {
> +        uint32_t index;
> +        bool found_display_id;
> +        indexRef = IORegistryEntryCreateCFProperty(service,
> +                                                   CFSTR("IOFramebufferOpenGLIndex"),
> +                                                   kCFAllocatorDefault,
> +                                                   kNilOptions);
> +        if (!indexRef) {
> +            continue;
> +        }
> +        found_display_id =
> +            CFNumberGetValue(indexRef, kCFNumberIntType, &index) &&
> +            CGOpenGLDisplayMaskToDisplayID(1 << index) == displayID;
> +        CFRelease(indexRef);
> +        if (found_display_id) {
> +            break;
> +        }
> +    }
> +    if (!service) {
> +        goto out;
> +    }
> +
> +    clockRef = IORegistryEntryCreateCFProperty(service,
> +                                               CFSTR("IOFBCurrentPixelClock"),
> +                                               kCFAllocatorDefault,
> +                                               kNilOptions);
> +    if (!clockRef) {
> +        goto out;
> +    }
> +    if (!CFNumberGetValue(clockRef, kCFNumberIntType, &clock) || !clock) {
> +        goto out_clock_ref;
> +    }
> +
> +    countRef = IORegistryEntryCreateCFProperty(service,
> +                                               CFSTR("IOFBCurrentPixelCount"),
> +                                               kCFAllocatorDefault,
> +                                               kNilOptions);
> +    if (!countRef) {
> +        goto out_clock_ref;
> +    }
> +    if (!CFNumberGetValue(countRef, kCFNumberIntType, &count) || !count) {
> +        goto out_count_ref;
> +    }
> +
> +    *p_rate = clock / (double) count;
> +    found = true;
> +
> +out_count_ref:
> +    CFRelease(countRef);
> +out_clock_ref:
> +    CFRelease(clockRef);
> +out:
> +    IOObjectRelease(it);
> +    return found;
> +}
> +
>   /*
>    ------------------------------------------------------
>       QemuCocoaView
> @@ -655,20 +725,16 @@ - (void) updateUIInfoLocked
>           NSSize screenSize = [[[self window] screen] frame].size;
>           CGSize screenPhysicalSize = CGDisplayScreenSize(display);
>           bool isFullscreen = ([[self window] styleMask] & NSWindowStyleMaskFullScreen) != 0;
> -        CVDisplayLinkRef displayLink;
> +        CGDisplayModeRef mode = CGDisplayCopyDisplayMode(display);
> +        double rate = CGDisplayModeGetRefreshRate(mode);
> +
> +        if (rate != 0.0 || get_fallback_refresh_rate(display, &rate)) {
> +            update_displaychangelistener(&dcl, 1000 / rate);
> +            info.refresh_rate = (int64_t)1000 * rate;
> +        }
> +        CGDisplayModeRelease(mode);
>   
>           frameSize = isFullscreen ? [self screenSafeAreaSize] : [self frame].size;
> -
> -        if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
> -            CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
> -            CVDisplayLinkRelease(displayLink);
> -            if (!(period.flags & kCVTimeIsIndefinite)) {
> -                update_displaychangelistener(&dcl,
> -                                             1000 * period.timeValue / period.timeScale);
> -                info.refresh_rate = (int64_t)1000 * period.timeScale / period.timeValue;
> -            }
> -        }
> -
>           info.width_mm = frameSize.width / screenSize.width * screenPhysicalSize.width;
>           info.height_mm = frameSize.height / screenSize.height * screenPhysicalSize.height;
>       } else {


