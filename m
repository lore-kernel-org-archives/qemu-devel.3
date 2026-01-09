Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4929AD16808
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 10:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veA0l-00069o-6c; Fri, 09 Jan 2026 05:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veA0j-00068r-Gj
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 05:46:29 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veA0h-0001Z0-FC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 05:46:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so23079725e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 02:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767955585; x=1768560385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3v1P4kFoh5NMkdugX+5HE2EVOAjB37nx3sn3FwTZS0=;
 b=v76cK1WA2DgSPy2h0GvQYXT7F7hLoCrLt66fZrERwXrJnrIJejR34QAw0S7bI5Enmt
 vfbB+iTvaQQ359vkOSZKzHUeLZZELRVHy60D02m6ukrSB1TD18dg7tkXegoKKLwFVQQx
 5wwv4ezZb01ZpinRefnUPcSsv6mV/W2eXzw6LG3wLjRv4O299wUI4YsTm5txJrBTyB3V
 KMcEpz26LwCz1uX8NRVJjU1VGHbgD6vgpluUBv1T0cO+Bx6q9UgXjhVnLX8zg/LWn5fN
 198cwfOyKfi64SZU9tWnyOupv7j6/vUADKbBHEyj0ZfROOdWg97yNaUCSSpfAu0jFe+C
 dN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767955585; x=1768560385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N3v1P4kFoh5NMkdugX+5HE2EVOAjB37nx3sn3FwTZS0=;
 b=V3hcRxNjdsqYZx4k18RcBJlfYZHWirkRJweM5YpNJn3cIolSPvngYH2GNopMWs/nyG
 Co3cbYx+9dr+9sX+EaeG4lHe2H2Vy6p4m1B9DQrr9e0yf+XJVK6B/s5qSKWCZH64+Er2
 MDIHCl6zFP840XL7gd5SklntPQrng1Ags2f477trF+jucuWpQMHnX6LTGPdbVQuepN6i
 bob0vP+CChFKala5P9D/0/vanoJUyPmXcFEL1aoYKM90QN01np2GO3YfCLHN3VXUldyg
 8dQ1FMgoTsFjnDHxXZ/QbnrPoGVpXtMyOrx9xyhlgCnrbVaz04Qqn/2NLmXsUQWJnnXH
 jz9A==
X-Gm-Message-State: AOJu0YwODUAw1I+e2QnItEsbDZ6YXVD7fFfFXyT3j0+7+2eNJhAIi/Ut
 jpZesomoqSEKekrY3dcyyISvNb7gjlptlGVQcDaPzV3Oj8LSSZFwtUblTI+4weOZsZ0=
X-Gm-Gg: AY/fxX5cTUm+c40Q6T5R57a2QNUWgfvqff61YI0Ps/PlvVKJ/a89yRYi7otHbkd4skg
 pYGpWNYn62n0Gc5r4EZ38AVqNe6klw+sjFVs93A4/qYZiiIvkuEZxrNBj2NIer6pVZ7Zm3YaOEU
 dSMzWLCmnfJqVvHdArlso850+s2K+uxZdR90nBhVwY3G+3RX5mRF/HUiY2HYyH1PDDxRIDc0a/z
 QvX0qFCNvctNSLZkB1HGBeNBNsBoj8jUAWPpj/YlwCsNMWBUOs5gEe4bIylx3zzYBs2gXjFvwyb
 FuAivjdbnAfcaISmz+iYya/I/ZAX5m606n0lzcWFCe4pmujyaJGjPdAemV0ENks0hivJ59iMaWU
 9k49pF+2yLPnNcGSsMWNagQcUq/gp4mVQt0TAyHOA1dqFeTB6GfOYGLnZNJuKb9VP/NORBdKoE7
 vm9ddggCFmHerWq3//MAIj3oH5DOJwvsAvnxpxAOQw/C49W0bw/980tIu6fQZXiLPL
X-Google-Smtp-Source: AGHT+IE/nYRJKvbaSC2tfpub7YEEbxE3P1NYBbFPwqDNyS14tcjzXCD8RcHddzgl/AIBtxW5fULKKA==
X-Received: by 2002:a05:600c:a48:b0:47a:829a:ebb with SMTP id
 5b1f17b1804b1-47d84b36a2amr97903225e9.19.1767955585052; 
 Fri, 09 Jan 2026 02:46:25 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm202580365e9.1.2026.01.09.02.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 02:46:24 -0800 (PST)
Message-ID: <206b07b2-461c-49bf-859e-8d61c2d8bdf7@linaro.org>
Date: Fri, 9 Jan 2026 11:46:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dump: Build stubs once for non-x86 targets
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260108161220.15146-1-philmd@linaro.org>
 <20260108161220.15146-5-philmd@linaro.org>
 <CAMxuvazRztSC-buX=MEm=UbG55qGyqgAdyzbVvow9eM4h13x1A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMxuvazRztSC-buX=MEm=UbG55qGyqgAdyzbVvow9eM4h13x1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 9/1/26 09:50, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jan 8, 2026 at 8:12 PM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     Rather than compiling the same content for all targets (unused
>     most of the time, i.e. qemu-system-avr ...), extract the non
>     x86 specific parts to a stub file and build it once for all
>     non-x86 targets.
>     Add a Kconfig symbol to only select the target-specific file
>     with the x86 target (rename this file with '-x86' suffix).
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>     ---
>       dump/win_dump-stubs.c               | 21 +++++++++++++++++++++
>       dump/{win_dump.c => win_dump-x86.c} | 20 +-------------------
>       Kconfig                             |  1 +
>       dump/Kconfig                        |  4 ++++
>       dump/meson.build                    |  3 ++-
>       5 files changed, 29 insertions(+), 20 deletions(-)
>       create mode 100644 dump/win_dump-stubs.c
>       rename dump/{win_dump.c => win_dump-x86.c} (97%)
>       create mode 100644 dump/Kconfig
> 
>     diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c
>     new file mode 100644
>     index 00000000000..07d1a0c5ea9
>     --- /dev/null
>     +++ b/dump/win_dump-stubs.c
>     @@ -0,0 +1,21 @@
>     +/*
>     + * Windows crashdump stubs
>     + *
>     + * SPDX-License-Identifier: GPL-2.0-or-later
>     + */
>     +
>     +#include "qemu/osdep.h"
>     +#include "qapi/error.h"
>     +#include "win_dump.h"
>     +
>     +bool win_dump_available(DumpState *s, Error **errp)
>     +{
>     +    error_setg(errp, "x86-64 Windows guest dump not built-in");
>     +
>     +    return false;
>     +}
>     +
>     +void create_win_dump(DumpState *s, Error **errp)
>     +{
>     +    g_assert_not_reached();
>     +}
>     diff --git a/dump/win_dump.c b/dump/win_dump-x86.c
>     similarity index 97%
>     rename from dump/win_dump.c
>     rename to dump/win_dump-x86.c
>     index e5fdc12ad34..4f8bcc356fc 100644
>     --- a/dump/win_dump.c
>     +++ b/dump/win_dump-x86.c
>     @@ -1,5 +1,5 @@
>       /*
>     - * Windows crashdump (target specific implementations)
>     + * Windows crashdump (x86 specific implementations)
>        *
>        * Copyright (c) 2018 Virtuozzo International GmbH
>        *
>     @@ -18,8 +18,6 @@
>       #include "win_dump.h"
>       #include "cpu.h"
> 
>     -#if defined(TARGET_X86_64)
>     -
>       static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);
> 
>       bool win_dump_available(DumpState *s, Error **errp)
>     @@ -494,19 +492,3 @@ out_free:
>       out_cr3:
>           first_x86_cpu->env.cr <http://env.cr>[3] = saved_cr3;
>       }
>     -
>     -#else /* !TARGET_X86_64 */
>     -
>     -bool win_dump_available(DumpState *s, Error **errp)
>     -{
>     -    error_setg(errp, "Windows dump is only available for x86-64");
>     -
>     -    return false;
>     -}
>     -
>     -void create_win_dump(DumpState *s, Error **errp)
>     -{
>     -    g_assert_not_reached();
>     -}
>     -
>     -#endif
>     diff --git a/Kconfig b/Kconfig
>     index 63ca7f46df7..26388c12838 100644
>     --- a/Kconfig
>     +++ b/Kconfig
>     @@ -1,6 +1,7 @@
>       source Kconfig.host
>       source backends/Kconfig
>       source accel/Kconfig
>     +source dump/Kconfig
>       source target/Kconfig
>       source hw/Kconfig
>       source semihosting/Kconfig
>     diff --git a/dump/Kconfig b/dump/Kconfig
>     new file mode 100644
>     index 00000000000..99f99ff4a4f
>     --- /dev/null
>     +++ b/dump/Kconfig
>     @@ -0,0 +1,4 @@
>     +config WINDUMP
>     +    bool
>     +    default y if I386
>     +    depends on I386
>     diff --git a/dump/meson.build b/dump/meson.build
>     index 4277ce9328a..26e1561ed48 100644
>     --- a/dump/meson.build
>     +++ b/dump/meson.build
>     @@ -1,2 +1,3 @@
>       system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
>     -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true:
>     files('win_dump.c'))
>     +specific_ss.add(when: 'CONFIG_WINDUMP', if_true: files('win_dump-
>     x86.c'))
> 
> 
> I thought this could end up in qemu-user, but apparently I was wrong..

I was myself surprised too. I think this is somehow by luck, because
IIUC Kconfig symbols aren't evaluated for user emulation (IOW the file
isn't added because CONFIG_WINDUMP is unset on USER).

> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com 
> <mailto:marcandre.lureau@redhat.com>>

Thanks!

> 
>     +system_ss.add(when: 'CONFIG_WINDUMP', if_false: files('win_dump-
>     stubs.c'))
>     -- 
>     2.52.0
> 


