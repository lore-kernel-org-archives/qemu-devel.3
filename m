Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F10C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW15x-0001s5-Cc; Mon, 22 Jul 2024 18:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW15s-0001kq-W4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:01:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW15r-00083r-B2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:01:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso36052565e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721685676; x=1722290476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0LAhdNu9e+7XBMJ1h9ByXqlJY0xiouNYvjQirplFstA=;
 b=eeUltH/iABupljZ80iRaENy1AKQcE1Kapsjw3j/8AaER+sMl8jiFX2RBVDl+j6JNyy
 AWEJVhXyiJPL3qSYWqadJlBWzaNDSTnDHqQTHLYOFPemukkqX9QdinK+4lIUb3QbJV+C
 9jqkGY/NwuXShbIsNuL4RATIhTunjgJbSPU1MMrfoDXeeLzf0sexvqI3QD/yFqJZBmql
 foMQHXT6wqEqFxcX6E4VFQSwdq0kik7Mqtr4p5y0KGL4euNwGXXqy4aZDk5CFpHX+MLR
 ZJgVho4j1nP/0y/sLpLanzTh7uuTrxTukBNZ/56lB1aqIND5x09kO9GGx5pJCkib89JS
 rRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721685676; x=1722290476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LAhdNu9e+7XBMJ1h9ByXqlJY0xiouNYvjQirplFstA=;
 b=qrMoJhJZFRhi8RnL6VNWSKfl99ked69ZMB8x9N5UDiqai5JmQ+y4ZlEjygufyAILxP
 O+jnyRIRNYmEeFbuh3PmA6w5M8ObRZwk8RqeJ8vsW7LvkLBzWnIYhrkwGZEBoxyXlBGU
 vfLRoDR6zH9gbFI5XtpiwIrjfV7YRX31hf9CXK+AJGeN6bXyrnDw4zbk72AG9Ze7aSFb
 QcHrD7D6xLqi2xywhKC64c/kMdsTOzgk3urQPn/QDU8ph5MyoNKI8zzW9GDYrIBLaF/Z
 tsux4eH0Nr+UJ4AcHTNVlMb/5908/ZzslJ6aS8bmZE0p0+jRkiiqF89C5tEXM19jlFMF
 pSBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWhnw/+ypoDpOchb8z/pRKUdmZ6r+BJkLkfx+FCKoU2B9jznmPgMbyDv/9z2IRFWyCuEjb+HDIZnmP+0RGzeIbiUYsf48=
X-Gm-Message-State: AOJu0Yz5WUwkBUkU+bPnQ16egv8+jLgpj7GYKBzPNWa9BPHYxarPGz9v
 rLhrhQcm988cwcEA/Mx8E7K++7bo2LMGO4BigvjhvPwMqj+tcaWuKL7IogCrFf0=
X-Google-Smtp-Source: AGHT+IFqESIfxYa46DHz9iTWDeobG+x88a2KlekyRxaZmLCr2gJy4TAMu68bmfstF8tN0wcYcXZ8Ew==
X-Received: by 2002:a05:600c:1d18:b0:426:67f0:b4fa with SMTP id
 5b1f17b1804b1-427dc51a013mr50523355e9.1.1721685676167; 
 Mon, 22 Jul 2024 15:01:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69019a5sm142440515e9.18.2024.07.22.15.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 15:01:15 -0700 (PDT)
Message-ID: <97219e8c-e210-4108-9873-abe2a933a3f1@linaro.org>
Date: Tue, 23 Jul 2024 00:01:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] bsd-user: Make compile for non-linux user-mode stuff
To: Gustavo Romero <gustavo.romero@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-14-imp@bsdimp.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722214313.89503-14-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Warner,

On 22/7/24 23:43, Warner Losh wrote:
> We include the files that define PR_MTE_TCF_SHIFT only on Linux, but use
> them unconditionally. Restrict its use to Linux-only.

We should check that in meson, i.e.:

config_host_data.set('CONFIG_PRCTL_PR_MTE_TCF_SHIFT',
                      cc.has_header_symbol('sys/prctl.h', 
'PR_MTE_TCF_SHIFT'))

(like we do for CONFIG_PRCTL_PR_SET_TIMERSLACK), then rework
linux-user/aarch64/mte_user_helper.h (and possibly
tests/tcg/aarch64/mte.h), moving in a common directory.

That said, your patch matches this file header:

   #if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
   #include <sys/prctl.h>
   #include "mte_user_helper.h"
   #endif

Even if this #ifdef'ry is ugly, it isn't wrong, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

¯\_(ツ)_/¯

> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   target/arm/gdbstub64.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 2e2bc2700b8..6dc81aecb2a 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -404,6 +404,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
>   
>   int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
>   {
> +#if defined(CONFIG_LINUX)
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
>   
> @@ -425,6 +426,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
>       arm_set_mte_tcf0(env, tcf);
>   
>       return 1;
> +#else
> +    return 0;
> +#endif
>   }
>   
>   static void handle_q_memtag(GArray *params, void *user_ctx)


