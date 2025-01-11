Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DFAE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 06:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWUZG-00042C-07; Sat, 11 Jan 2025 01:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWUZD-00041x-H9
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 01:01:51 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWUZC-0000e7-0m
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 01:01:51 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso3772156a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 22:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736575308; x=1737180108;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdegUglfVdsuMq09v02kBZKGG+FikJdwVxvJi91xZ2I=;
 b=iAOdSqv1iOCJlPAaqtpt2WKHrprU6AcWj6rN0boaFfSs59ERnSqvStqoeOovvVKDLz
 O1SiSVD+l1pH0+L5VBB4tRgW8z26wr8wc6Ibo9ci4c8UkkfuDxuDUJo33j2YJsOlce5u
 quw2dwgjKm6mcYyigoBpw6EUtKpJJUCZZh0g0gspHLGt41QHP5bhUrGzaCalgdIwz+H5
 ESJo0OoaS2VooILp3P9XxLE+qM0lV+VQiwA1KVjutNTMOyI6OmVScqNT/NMox0WEIm5O
 Ys8l1L5IS9Jtl8tokqSI/0PdXnzcnB0TUMj0U6kojPDdogcjt/NxMq1sybjDhXTKFOF9
 kAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736575308; x=1737180108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdegUglfVdsuMq09v02kBZKGG+FikJdwVxvJi91xZ2I=;
 b=EiSTumej6JY6zUaxNuADy+0Q9bvKRke6YJEC93kfwzDV8A39+Rr4fvRn31+QcLotop
 wpxQzrF7YmOG6Fb4sUGlI0IDY/WaUCGHxI/AkCYVf+ZAYW3m3emJn4eiUXHOvI+LOg3r
 2NGkwWo0gp2FKIfi9ic69RR5p5zaJo+vMGB2o0jknU7RZ+W/ljG5yOJVyyneww1VNQos
 4WYSzZzwR8Qc8jmoMrbeh9sbp9ts2FF2f3Cyex0sTVx+WDxIOoibklsqrO3EjA9lpmOG
 QNuRNV7SRk7n4KUCHGiqpTww0f4TwqhUlykbmBHyynyUdwz+Oo096ZZ6XLX9G5JNO2P7
 q0Lw==
X-Gm-Message-State: AOJu0Yyr3IxDrVRn1qaiYBQffuVljpQXpnDhPx0rvi7bdOERkeJUL15e
 bpBzgq2oi4Rvw7HFwM3KsKHgNQU+pAADBAqXpnydl7NjibLAYxDB95bedvTWG+iENOwoZFJwoWN
 T6nA=
X-Gm-Gg: ASbGncteFLmLMGZDXbq4ilsSNsFEoH4105yutxFdmxYoaRxXVmA69Xq7gmOCimpaqqN
 21daif7P60co/pe6q89KV/xAiDug3n559Lhkm1RAu7XTZi5IdLbODvCZ/UI3SUH8UTcCuVBQSz5
 0sFyhiME3v8/ee5MCQQ2K+cDPBJTwp5Lfn56+jJIBThe6h++kzeigMI24H2a7VGKcKG+jh4N1Pf
 B2wMO4j9EVFwxiQjGepQlh2AAu9yaFCIy3GlQ/zKxBNZ0tu7Ac0/T9mX1SV2ANc+F0=
X-Google-Smtp-Source: AGHT+IG1gJ6NMN0wUvJa7k6exSzdYtfgj8GECbwEfKTS2mGpYe1U9FN/rONhV3BA/SBG/O+wgU0pQw==
X-Received: by 2002:a17:90b:2f4e:b0:2ee:8358:385 with SMTP id
 98e67ed59e1d1-2f548e992c9mr19333264a91.4.1736575308308; 
 Fri, 10 Jan 2025 22:01:48 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10f4d7sm21213165ad.10.2025.01.10.22.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 22:01:47 -0800 (PST)
Message-ID: <62aabac2-5064-41cb-89d2-f7eef057376b@daynix.com>
Date: Sat, 11 Jan 2025 15:01:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/cocoa: Do not automatically zoom for HiDPI
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240318-zoom-v1-1-07ad14fcde19@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240318-zoom-v1-1-07ad14fcde19@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

Can anyone review this change?

Regards,
Akihiko Odaki

On 2024/03/18 18:02, Akihiko Odaki wrote:
> Cocoa automatically zooms for a HiDPI display like Retina and makes
> the display blurry. Revert the automatic zooming.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   ui/cocoa.m | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index fa879d7dcd4b..c5b3c28000ff 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -522,7 +522,10 @@ - (void) resizeWindow
>       [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
>   
>       if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
> -        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
> +        CGFloat width = screen.width / [[self window] backingScaleFactor];
> +        CGFloat height = screen.height / [[self window] backingScaleFactor];
> +
> +        [[self window] setContentSize:NSMakeSize(width, height)];
>           [[self window] center];
>       } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
>           [[self window] setContentSize:[self screenSafeAreaSize]];
> @@ -575,8 +578,8 @@ - (void) updateUIInfoLocked
>   
>       info.xoff = 0;
>       info.yoff = 0;
> -    info.width = frameSize.width;
> -    info.height = frameSize.height;
> +    info.width = frameSize.width * [[self window] backingScaleFactor];
> +    info.height = frameSize.height * [[self window] backingScaleFactor];
>   
>       dpy_set_ui_info(dcl.con, &info, TRUE);
>   }
> 
> ---
> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
> change-id: 20240318-zoom-df4d6834e56b
> 
> Best regards,


