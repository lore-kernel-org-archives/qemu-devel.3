Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E85C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmAM7-00042t-Qo; Mon, 18 Mar 2024 06:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rmAM6-00042b-Ms; Mon, 18 Mar 2024 06:36:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rmAM4-00032b-IY; Mon, 18 Mar 2024 06:36:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e036b76725so1207575ad.1; 
 Mon, 18 Mar 2024 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710758190; x=1711362990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YLjNEEGj7YutZqv3ska1jpI5LSiCIkPKoN+5SjJg8zA=;
 b=IZw0hoh4K4lW6AqqoR3XQ4omPjPUCszRm3ccgy2z2XuT6FrsBg7RYisqxh6844xfSc
 eHhUZWNFckd7f7P+fPNuoZRlt7NepRyCTrDugfd5ZJkSTSH3LG5aZFqbQAyjOcj31+b/
 a0+8wuJkfwXYtIJDo2nRLGRWXlFGuWWgOmFTMemGDWjZmdfXfYJzbcCI6qfFB0FdG1OP
 lGQV3k8/WMF7OWcn/4QViIHHNrGePcSt/unIG1E9NRQDm2hLCEJ1oLQAK3tyBFc+l9Tw
 2IUxfliwvy1bP0UVeaG94/ieRbyPUEwHmCoQ/n3OCvAqhmH1umdV4434JVtDhTtKw0gY
 5F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710758190; x=1711362990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLjNEEGj7YutZqv3ska1jpI5LSiCIkPKoN+5SjJg8zA=;
 b=HwhcmbMVQV4cVzDB5vwYF7ZRGMQ1zjmyK3XAch1M4fQqWoULd9NlsHk/pbahucC44u
 snM+26KKBp03h2uURUAP1CX3mqvI08Ufd4E38icLDPkr/XW9LQOH7aLJs+faLtc0BtNu
 Yn4hyYbpjFf+eSC/XUHzk9pq/KDwGkUKz4UDI6sBss+JxjW0cgub/74D0revMiGKAq+i
 YTzxN9jhi8GgC/XBlqgcXLxM5Is4XE977tv1LgwVLGkHaEyEMDO5qtMlfJw2IILrpNEK
 riDcQ0Gt1yULtVBQZklWZGV1Z3zVMd4r5kr4+F7xp8NZPLsyFsofnX/MJRpzBb8q7e5h
 POiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAW/kIxiO7RU5yKiB0/O2WTHjURc9Halj3CrjWQVcPB2B4LaEXXg4QPfNoPReEzoKduGo1J0jjgcgoXnAkDMCYfGHNvD+6KvLlfGDg0btNJNMF0v8J5pcDlv4=
X-Gm-Message-State: AOJu0Yx05RCSpPrHI4pEFTWaLwd/Bibx8bt9++VfK/0N86+6M8x/DBe4
 GMO8SUXrPqNQDIOh+O8j+kQYHTjcrzo0zkoS7TI5Ty8sDNVdwM+m
X-Google-Smtp-Source: AGHT+IFHwnLsUx4EMcF+KW5xFEJsnKVXDV65UR9doblUWPBFT1lPoyr/Odvd1hg31zonHVQEOfbGKA==
X-Received: by 2002:a17:903:1209:b0:1dd:62c5:b6e2 with SMTP id
 l9-20020a170903120900b001dd62c5b6e2mr14493721plh.37.1710758190139; 
 Mon, 18 Mar 2024 03:36:30 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 ky6-20020a170902f98600b001dcfbbb1ddesm8907742plb.7.2024.03.18.03.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 03:36:29 -0700 (PDT)
Message-ID: <ab5892b3-38ec-43c5-9c82-8595ad4c77e0@gmail.com>
Date: Mon, 18 Mar 2024 19:36:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 3/3] ui/console: Add 'rotate_arcdegree' field to
 allow per-console rotation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240318100543.78846-1-philmd@linaro.org>
 <20240318100543.78846-4-philmd@linaro.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20240318100543.78846-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/03/18 19:05, Philippe Mathieu-Daudé wrote:
> Add the 'rotate_arcdegree' field to QemuConsole and remove
> the use of the 'graphic_rotate' global.

I think QemuGraphicConsole is a better place to put the field.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   ui/console-priv.h | 1 +
>   ui/console.c      | 7 +++----
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/console-priv.h b/ui/console-priv.h
> index 88569ed2cc..6e54b476d9 100644
> --- a/ui/console-priv.h
> +++ b/ui/console-priv.h
> @@ -31,6 +31,7 @@ struct QemuConsole {
>       const GraphicHwOps *hw_ops;
>       void *hw;
>       CoQueue dump_queue;
> +    unsigned rotate_arcdegree;
>   
>       QTAILQ_ENTRY(QemuConsole) next;
>   };
> diff --git a/ui/console.c b/ui/console.c
> index 84aee76846..a36674bacf 100644
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
> @@ -210,17 +209,17 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id)
>   
>   void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree)
>   {
> -    graphic_rotate = arcdegree;
> +    con->rotate_arcdegree = arcdegree;
>   }
>   
>   bool qemu_console_is_rotated(QemuConsole *con)
>   {
> -    return graphic_rotate != 0;
> +    return con->rotate_arcdegree != 0;
>   }
>   
>   unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con)
>   {
> -    return graphic_rotate;
> +    return con->rotate_arcdegree;
>   }
>   
>   void graphic_hw_invalidate(QemuConsole *con)

