Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE586C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 02:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPcy-0000A7-WE; Mon, 18 Mar 2024 22:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPcx-00009g-Ab
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:54:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmPcv-0004kD-Ui
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 22:54:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6aa5c5a6fso4906981b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710816897; x=1711421697;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LUFyKgFYLSCV3YFW5lpKa0Px1abb1/xX829AhzB9eRs=;
 b=CPpVOsUP0yDgy997TddVnr3znrwu4zF6F2VLnJJJ6xmKoUM2tRIBnpKeXLpl5aWc8c
 T94BDvWw3PwFZzKYgLlr5CYgwZ+e1x+1HzKdT0RoL5VpV/FEDkdQdklQpSQgOibze/h9
 GKTUJb3zj6762Qb3adFv5/xQbT0oWHD2+gsd0GgxUKFKlSpgSm/B3pJ+SpWCA56uuno4
 s1kuTYiddvm84zylqA1aAlxUBDepI62pIPMocuFf1Xa+QSlfSdwOznPp1pkSYMR+Pi3R
 cX2dPim80sZYsQCHFeu4ZepmOL22smPJyJhQd8kUNZm5NEkVC4gYsFfm+4oNKu1B9Y8S
 naJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710816897; x=1711421697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LUFyKgFYLSCV3YFW5lpKa0Px1abb1/xX829AhzB9eRs=;
 b=GCvN4rs052JGS345sMe2R2SvaLrtUMf27kv+jXFpz6ME/lHOgYSts31GXWZkmNLIrM
 l9kZ3k94IfNqebIw3llYPdQjfkhsvX80IIUxVBQZWNkViDa++Ijkt3vQ2ZzNyg185dNi
 1dLNC5sPxwO1DWoaJewm3LSkTsXcIHIPldTyCsOezalZTsAz0ILFa5lyl/mXE9ckJNqy
 uhR6xkq9tPHD9R0y9PUQK1q11fDNdjgJJMDqJM12uVx3GSrK/RZ1E8mxsuWQh7QGCaFh
 D86aCG7KMh5/EFviwwotCr3YD1S8tQSieQoZSJysEvTBUy0D4YqxJFA2dYXcdoRRmH0i
 ROjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7UcMF1zLIS3rEeC3XPbs2nvLWSY4Y3IvBCfdUp6mb+8C3ubnXW+uMzbubXxLeWt2rFoAlCt3g/qLiB4RTyTypPvMijhc=
X-Gm-Message-State: AOJu0Yyf2ZALxqNIzAf/5QXOI5WEyQfTHMvQEOX87JRuCu4mrClEooKZ
 i/z/5eXpnyiMhANPM3szRvbJbyFX+yg+TwPd8fbM0aKn491IAPLhNl0iJc1rhS1GikFpTatt6Hj
 /
X-Google-Smtp-Source: AGHT+IFFF9+Y4YhmX9F0osNYwnXMlrkcTTGkX84vfsYb3I/d1bhW6Go3KJDAWT5eF/ftJIfEdP3+IA==
X-Received: by 2002:a05:6a00:9a4:b0:6e6:98e4:99a1 with SMTP id
 u36-20020a056a0009a400b006e698e499a1mr16697544pfg.14.1710816896681; 
 Mon, 18 Mar 2024 19:54:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 z3-20020aa79e43000000b006e6fd17069fsm6188632pfq.37.2024.03.18.19.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 19:54:56 -0700 (PDT)
Message-ID: <f36ecb7c-5ce4-44e6-ad07-f8a82e4b8eeb@daynix.com>
Date: Tue, 19 Mar 2024 11:54:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 3/3] ui/console: Add 'rotate_arcdegree' field
 to allow per-console rotation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240318113140.88151-1-philmd@linaro.org>
 <20240318113140.88151-4-philmd@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240318113140.88151-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

On 2024/03/18 20:31, Philippe Mathieu-Daudé wrote:
> Add the 'rotate_arcdegree' field to QemuGraphicConsole and
> remove the use of the 'graphic_rotate' global.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>   ui/console.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/console.c b/ui/console.c
> index 84aee76846..94624c37ae 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -37,7 +37,6 @@
>   #include "trace.h"
>   #include "exec/memory.h"
>   #include "qom/object.h"
> -#include "sysemu/sysemu.h"
>   
>   #include "console-priv.h"
>   
> @@ -51,6 +50,8 @@ typedef struct QemuGraphicConsole {
>   
>       QEMUCursor *cursor;
>       int cursor_x, cursor_y, cursor_on;
> +
> +    unsigned rotate_arcdegree;
>   } QemuGraphicConsole;
>   
>   typedef QemuConsoleClass QemuGraphicConsoleClass;
> @@ -210,17 +211,23 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id)
>   
>   void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree)
>   {
> -    graphic_rotate = arcdegree;
> +    QemuGraphicConsole *gc = QEMU_GRAPHIC_CONSOLE(con);
> +
> +    gc->rotate_arcdegree = arcdegree;
>   }
>   
>   bool qemu_console_is_rotated(QemuConsole *con)
>   {
> -    return graphic_rotate != 0;
> +    QemuGraphicConsole *gc = QEMU_GRAPHIC_CONSOLE(con);
> +
> +    return gc->rotate_arcdegree != 0;
>   }
>   
>   unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con)
>   {
> -    return graphic_rotate;
> +    QemuGraphicConsole *gc = QEMU_GRAPHIC_CONSOLE(con);
> +
> +    return gc->rotate_arcdegree;
>   }
>   
>   void graphic_hw_invalidate(QemuConsole *con)

