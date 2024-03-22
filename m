Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA2DC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 13:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnebz-0003VV-Oc; Fri, 22 Mar 2024 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnebx-0003Ue-OS
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:07:05 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnebv-0006kS-4l
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:07:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56bcb9640bbso2281496a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711112821; x=1711717621; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NdAGvFh9v2vtrvHy+ZgoS5liRzTxQboPJqHxj7/u0dg=;
 b=lpRx68reJvm6wMPV6do67EJGKGjxcQXtfQ694VxuEQ9qeLHi+bnco4jh/77LSPY0s9
 7iqWHnAQKpDALW0UCLssCqI1zrqw1Ba6ANH9ktpUhA96RCOp6DY3/myPSf1DsueXMvfE
 mu95243GqHh4piUPSBcIu1aRlVwbwM2VKeCOw+PpPBY/xiSslQG32kPawEA6P2gL+43F
 ZoCp5CDG9QrVkHBDUn3SNj/IUSiKUds7ILwvDRxK3K0zke6rAa+CX8vLB+zqdXKQWbS7
 hOfYl7Vp/2pjmibHKYIq1FQupM180R+yDew1QU8C/KuCSvym3xrak3TBt3c6zRSfQ/nw
 Q2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711112821; x=1711717621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NdAGvFh9v2vtrvHy+ZgoS5liRzTxQboPJqHxj7/u0dg=;
 b=hFpvCtqZ61XbnotxPKqBLCtO+WFTqYpBBwwPJ0vLeOYGYJI8inBgqgnQPbGZ1pbQeE
 otEx9LcMtTXu58FhDFAjfVGk4DRzsD323cVMu0By06z7mN1wn6LH0N0e72Ozzgszz/va
 d1GNuN2J2iIHKUBLxtxsy/45mI5Ulhu5wE6rE01YL+2yThEmNyf2nE5h/9giUFTShzwC
 SzsnjVffXEXiyhO4pnbbEgi3Jlt2qYNTxHmtDHviQT5bhaCs/2HVUyEmD2fSiTtyUXny
 1DYsffqcDz8z9JPsMvb1iwTXoDqT8yrtKtBn+mJRsDGUjIWLciTu8hglBev7gd9vtmJ2
 95jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyAlFWzlQ6VqOxyn4s8o/5tHp/kPjQo8BZNskWae5CR8IDByXdAftw3822tiBgPC2iWZ80e3kL8zRnCSUzZhypx5QqQPM=
X-Gm-Message-State: AOJu0YwQ+SPYYfefj8qAlKj8ordutx1RYwH+vKMe0xRiFhm8J1oOPbqP
 7MZ7cdJQhusmLxaC/UE+L6c/u4SAeZYk/M8w1Y74P+O8GOam/MQPjM4ZSftsYyHbpE2WPd47+vW
 eeW4gkR8v2sod1H4I+z6UsZRekyHULfXstf98S+N4VjzSw+X7
X-Google-Smtp-Source: AGHT+IEDjpxBve92RwmHdoX5dcyBDscuXFncgb6ww3g/BIs8lK6ZDKvKMNp94sXsnCwDo0RWN6MIiiS3Va7tD6k0uw0=
X-Received: by 2002:a50:d5da:0:b0:56b:d139:490 with SMTP id
 g26-20020a50d5da000000b0056bd1390490mr1715498edj.6.1711112821204; Fri, 22 Mar
 2024 06:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-zoom-v1-1-07ad14fcde19@daynix.com>
In-Reply-To: <20240318-zoom-v1-1-07ad14fcde19@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 13:06:50 +0000
Message-ID: <CAFEAcA_i3Os6YPwxx99sWvK5qdzopMGBZgvVKJ7qX-waCc7RnQ@mail.gmail.com>
Subject: Re: [PATCH] ui/cocoa: Do not automatically zoom for HiDPI
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 18 Mar 2024 at 09:02, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Cocoa automatically zooms for a HiDPI display like Retina and makes
> the display blurry. Revert the automatic zooming.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index fa879d7dcd4b..c5b3c28000ff 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -522,7 +522,10 @@ - (void) resizeWindow
>      [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
>
>      if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
> -        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
> +        CGFloat width = screen.width / [[self window] backingScaleFactor];
> +        CGFloat height = screen.height / [[self window] backingScaleFactor];
> +
> +        [[self window] setContentSize:NSMakeSize(width, height)];
>          [[self window] center];
>      } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
>          [[self window] setContentSize:[self screenSafeAreaSize]];
> @@ -575,8 +578,8 @@ - (void) updateUIInfoLocked
>
>      info.xoff = 0;
>      info.yoff = 0;
> -    info.width = frameSize.width;
> -    info.height = frameSize.height;
> +    info.width = frameSize.width * [[self window] backingScaleFactor];
> +    info.height = frameSize.height * [[self window] backingScaleFactor];
>
>      dpy_set_ui_info(dcl.con, &info, TRUE);
>  }

Could we / should we use convertRectToBacking and convertRectFromBacking
rather than doing the multiply/divide ourselves? The docs seem to
recommend against directly using backingScaleFactor when possible.

thanks
-- PMM

