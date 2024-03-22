Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EB2C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rndvc-0002mU-VC; Fri, 22 Mar 2024 08:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rndvb-0002lx-1l
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:23:19 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rndvW-0006mx-57
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:23:18 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56ba6c83805so2514179a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711110191; x=1711714991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mGTYEp7xXke03iXFHcbE0XE0Uhl1M4evAYMIRPiy2xk=;
 b=HXig6mwvW/bOvK7sn/DIpV/ThS4ygbnlA3MhKoTsE/PTBwzsJLgV8J7+Xp5Y3kUkJs
 SGAVNjjojFID7C7P54AGdf+sCUxBezIblCyiOqum3Eoh4duconB1ZFd64SE+DBNOuqku
 pdo2xPr1dduo25nx7TUDztT664j7uvBvrkbgSCsdWqNyR5mlWkjr7N4fhByjDeqIZ9rS
 QxcPqmet2Im6jqtcwKTvHG6/c/GvN5XB1bvv6axJvloXvEk5b5iUTdgDgt8QAtpoN8kD
 hAyI6qQI9j+xPFlJoLNaUP2PAN/AjxRIwHeZZr13xYmt+aIMQ4lz/nyOkzCPoq9BC9EM
 L9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711110191; x=1711714991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGTYEp7xXke03iXFHcbE0XE0Uhl1M4evAYMIRPiy2xk=;
 b=pFiEDL/5eUedXcXeaRHJPcjaEPmpqIhlADemU3lLAjoiz03HjkcobB67Re9zbLeLbU
 Roo7AEZSmbA6bMrKICPRbDH5cPhv7HEExqvo+v+onDmPHDnu7lIqmvzTuNmN3CHeZxwb
 T2c+QGzKkL291ZctaThtTUSwCkK/f1OP8sZOJ17S38N9jz8xgttlKB1Rei6uPM3FnQbC
 NuXn5QIqvPEC4kFjiuFEdZFcCirnhyNoMwMGNyIUFu4CfolUI5t08h820Le3VSJCzL8Z
 o/V4I07d0zGUBvrV+XCdVsRvzlUod3qnD8GA+QovPX8Xz3BtJDRC9b4TnSZ4mG3eVKXd
 ZFQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh53t7aIIXfV4+i1XOByCR4epFnEzbU2oMuSHDR9SfPXuzkmSe3weeZO2K6kIt08suqfLrhJMR9iy+SPIa/88lH9+LkqQ=
X-Gm-Message-State: AOJu0YxQoVWFMkZwFlTrxoOs7feHmdjfBJ/CuMQeZ/8lETCEUOBNHZ7T
 F1WPEaIFsvM57mlzz6al6AmaPAAFb+1WJdpI/ecMYCeXu6DCL+O+MfJdltAUf3ZnoZWt5o0cyvg
 BqFF+48/mzK/BymKDrn8kLZjD5gp9K1ZEv9GATg==
X-Google-Smtp-Source: AGHT+IEdb+aOr5tU6Yzz0LjUNM1sT7aSgrTx4ZVcE41gOC7Lar/M5SP/mE6xoJyqHNDaoBFtpJgfbbCOY3v3EOSZMjM=
X-Received: by 2002:a05:6402:d64:b0:56b:dee9:7f4b with SMTP id
 ec36-20020a0564020d6400b0056bdee97f4bmr1363421edb.11.1711110191027; Fri, 22
 Mar 2024 05:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
 <20240318-fixes-v1-2-34f1a849b0d9@daynix.com>
In-Reply-To: <20240318-fixes-v1-2-34f1a849b0d9@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 12:23:00 +0000
Message-ID: <CAFEAcA8-rOcRrTbRPxpz2nZTGuFR_Z4ziihP7YksXPdjE62Dxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ui/cocoa: Resize window after toggling zoom-to-fit
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 18 Mar 2024 at 07:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Resize the window so that the content will fit without zooming.
>
> Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index d6a5b462f78b..1324be6d32fe 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1378,6 +1378,7 @@ - (void)zoomToFit:(id) sender
>
>      [[cocoaView window] setStyleMask:styleMask];
>      [sender setState:styleMask & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
> +    [cocoaView resizeWindow];
>  }
>
>  - (void)toggleZoomInterpolation:(id) sender
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

