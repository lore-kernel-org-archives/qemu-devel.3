Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAD6D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7s2J-0004Lf-39; Wed, 01 Apr 2026 05:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s2H-0004L7-Is
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:38:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s2F-0007LE-VL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:38:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso21842625e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036330; x=1775641130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LWkfLMj1kTWLGuW3ybIofqP+w9HzYCcbkVV/fiYc+IU=;
 b=Q51SDwlj8fseziHz+rHLlI4Q4T1/Zrp1ID25htAuCXdtAa4M+3WlA060Llsq+52Dnz
 Wh/npaHJ2spPwXEMGJ3WlO0J0xcMEfTW7PHTe1H5jzzU4C/2fgmt4UTgh2hTjm09M1g2
 9wEholnUvcRwyREAqz/GCoZyGbdtIwfnXkv0BjNqafZL3tzxLo29lUdF41UfCncx7YEf
 wOj3Toyfl0W80F20XdBm5qudGoBol7lZx37yMFCIaz4dJU9DYxGcY5EOj8Gt1MzrJPXe
 lH0MFI6AVDEQqrti1QMRSK0da1cr1WJOtjFSD+RxdfmQcMNCImglpelozMT0CsfHOufS
 R/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036330; x=1775641130;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LWkfLMj1kTWLGuW3ybIofqP+w9HzYCcbkVV/fiYc+IU=;
 b=OllsLvj1KUwdXPGU/2Rcb9ueMJ4A5qvjL5lGslbjYf/+0Hz7eKl0qjTT7j5qj+5C8G
 nFxKwseg7zMaUDwlAJboZTnaB5+dnvCNOuie2BqOw5KtpWKQPTmCGfdyBy7w2sJo2EoI
 YQq+yp8hzXEoTLNbKugj4vZDoGZ782bbp1oxBrbmOsuNMB+cyPJezbJgFJY083VY1fft
 vUQQSLLTF7GN6LdH1C6PwJ1C2b2FRYWXiYCv8n/Ctmfg+wPeFJgWT6P+EbNVROKcysdd
 FzSseFMFDmBwQEuKlyXRuNEevIQdV3pPYlC4jXMKC+47aXorJYGn6Yg30Hdh+5aeNVtK
 v2xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhM+c3WqqT1AXxIbehISkaE3GiIg3b5a117R+Bozm7DAGGxgWDx3udhUeW6WsyFku5vyO0LmsvAWpj@nongnu.org
X-Gm-Message-State: AOJu0YxnfsdGJQjTTWNLrIUoZD5ogJSF+ChVl4JnK9Ps24vPtCrM7DHP
 VYNoVW4cpbSkTCnbc0fH8T75PufgZgoAdueFCF3x+PzzygHF0owRPnxMnRTpg1IVFk+JeUL0Uyi
 TaK+ygag=
X-Gm-Gg: ATEYQzyA8iNVkhojK4gnSC77deQT77Vln4FzmHIG9Hh1VtbNKS59dvGw3AvAhO+UJVB
 s4IGmEU4iYLlPg8lMGGEmZyTluE0XoWxc2bjBPBPuYqRtCRwt9gg0CsTI0EFk2xB03oPuzzoDGh
 Xv+w8tGR9Jaxzx9JHbfQ8tMGJuQFG6Ah456qbEEnyssgIp3gaSywBFQL1+npb6alqzg/ukNCngP
 jvQbfW6fj4qzpeEs+fieGc6vJ2dEhdFWhsfIGwLwCADkYmcng+6B70Hc2/TfZpIv2UsBwwKp/ln
 FxuzNpU+6FNCE4hBVDir728e1m5hWqdlRsqHtleV1zEZRWXYo48sVV+7578gCJlV0ZY2RZ7IND3
 dkJMhplu/xqWJIBIqcyCp5v22JmsZTmESsEB5Dx1Y/OObpKsist3u+oSl7WuZfD6R+W/vqhiy80
 gK0svkfqaxQ0C012ZImiqP9tQcKKimZOOIvneUSVAuKNCRNvWK+6NxnI9wHTtzxuh6MA==
X-Received: by 2002:a05:600c:c107:b0:488:80b6:873a with SMTP id
 5b1f17b1804b1-4888359526cmr32052515e9.21.1775036329795; 
 Wed, 01 Apr 2026 02:38:49 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bc9e7sm48728335e9.26.2026.04.01.02.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:38:49 -0700 (PDT)
Message-ID: <46af5fed-7717-4b71-a6f0-e8c7760da63e@linaro.org>
Date: Wed, 1 Apr 2026 11:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 52/60] ui/console: simplify registering display/console
 change listener
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-52-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-52-48eb1dcf7b76@redhat.com>
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

On 17/3/26 09:51, Marc-André Lureau wrote:
> Introduce qemu_console_register_listener() which combines setting
> dcl->con, dcl->ops and calling register_displaychangelistener() into a
> single call. This removes repetitive boilerplate across all display
> backends and makes it harder to forget setting one of the fields.
> 
> Also move the early-return check in unregister_displaychangelistener()
> before the trace call, so that unregistering a never-registered listener
> (e.g. on error paths) does not dereference a NULL ops pointer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  6 ++++--
>   hw/display/qxl.c     |  4 +---
>   ui/console.c         | 11 ++++++++---
>   ui/curses.c          |  9 +++------
>   ui/dbus-console.c    |  6 ++----
>   ui/dbus-listener.c   | 27 ++++++++-------------------
>   ui/egl-headless.c    |  4 +---
>   ui/gtk.c             | 10 ++++------
>   ui/sdl2.c            |  8 +++-----
>   ui/spice-display.c   |  8 +++-----
>   ui/vnc.c             | 11 ++++-------
>   ui/cocoa.m           | 13 ++++---------
>   12 files changed, 45 insertions(+), 72 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 3189788fb5f..c695b433fe3 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -305,10 +305,12 @@ struct DisplayGLCtx {
>   
>   DisplayState *init_displaystate(void);
>   
> -void register_displaychangelistener(DisplayChangeListener *dcl);
> +void qemu_console_register_listener(QemuConsole *con,
> +                                    DisplayChangeListener *dcl,
> +                                    const DisplayChangeListenerOps *ops);
>   void update_displaychangelistener(DisplayChangeListener *dcl,
>                                     uint64_t interval);
> -void unregister_displaychangelistener(DisplayChangeListener *dcl);
> +void qemu_console_unregister_listener(DisplayChangeListener *dcl);

Good opportunity to document these prototype declarations :)

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


