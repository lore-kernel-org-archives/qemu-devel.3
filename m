Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D13FED7B8B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZt7-0001yM-FV; Tue, 14 Apr 2026 05:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZt6-0001y8-KP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:16:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCZt4-0008G6-TI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:16:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso51249865e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776158209; x=1776763009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9crJcEHJxv6WuEhcRiQRs8t+RpvdyFT6HSI1ygGFMg=;
 b=pdYNEKieXAqkBBRb+Jurxu8y0cZQAM3iIiz+Ky+wbtqSKSWm345R/Md8cIytExEI4K
 zvhIaqPkbXvcIzJ3+l+XlwT2HmeBMVoDsP/rECyoYA+fjufudNZgzsqzbMCGCFE+z7Aw
 G+/VsItU4/dsdGLWDPGtP7L0jT2QjZe8Roe0y6fWfjJ/WEQYUnB6S5CL5+6YrSKGnT6x
 2Cqx6nWbXlatxPbXFMBxBOK/qrrG0MmKie51amZ6Ap5WkTxo//hfLlQtEpL8QnsaETcJ
 98usKQ2PgIoTZhW2Z5Q2FWUFE+d6ilXhBg+msS7sm1Jmu0NVwFEzmuRe+q1nve/UhYcJ
 9z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776158209; x=1776763009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F9crJcEHJxv6WuEhcRiQRs8t+RpvdyFT6HSI1ygGFMg=;
 b=MsQFhna0es6WuKkV+Pj41J8EzBFCwj3euNxgDiIaDV/DZGvsaQGz98ank+qJ7/pZll
 tshwOGusW0vbeb2kbXGeLaGaPfaCfPdJE6o32d/zoREiVJrGsbRu3Bioke/iSOXxE3Uf
 EX41kfFjyI57N4IHle+BRRGQKfKzogs0A5j3G4w+ZarW3SOxFCtH3eFMHg4nLIgNMuAF
 OpYa9RidUCHUWqiNpPWqG7ix97rSI/lpbb8S1g+/mRn7cDlSgsydxxixHTOOyutkGJN5
 3NADVh2igQATsHnQp4ECgK3r/D70pMAweuX8mgO2ijX3l6h+ymiNpQ752xVYziD58d8C
 zVWw==
X-Gm-Message-State: AOJu0YxSGxbPojvFg/1J1pQKr03bILfIMJlDrLh769CX/GJ9qFZfotZE
 tNXDKDVvkE3PAkKVFVsCCtrLijPbSjKKtNwjUFdhCkkfqXDv8wQMYG7vB0VTJ5Un4mQ=
X-Gm-Gg: AeBDietb3kTmrjGNANjWuRC02dh3Q2UOUWXvSJaF1xLTk1Ce9++xQB1H/D9vPe3uveG
 c6G8YVIWvsrI1sRqcPb557/CJSV1vA94kQfVztSGL3ZNvoikaXBQKqrYEvTAmEFjmMjTaj70OVG
 qqUxAuhEADKDdixR2cYzO1YPUZQ9hpEItTnphGPSJli3dYV9qyFd9zlmSmoHOvg8D3inBfxG0FC
 8QdG3DRDYS39MFC4qIxRf/Ia7/0Ouv10NWyunro7Eq1vFFrbeeeJndg5Qe2dUI2xDdGsugJSgyf
 BHiikZSkz8tSpBRsFU2BGXjOF8xfgZi3TPMRPNo3te6hLGUNgZ66pk9gMMmUB3B5fpmRmB/HDv1
 DM9H8+1RVmjiw+mIHWjHtjEnXzS+oXrvy2enwPSwSmcmhXjezdHL/Se8SXVq1A3jqlKfgDibtWA
 0h4WHvqsEDzGSrUjjAp23ubU7NZgiiE6IfC0wyvzqBa8I7i0TdXvO5BfUyoIj0ipKp93+bI+FLN
 4gC
X-Received: by 2002:a05:600c:8883:b0:488:869c:eda4 with SMTP id
 5b1f17b1804b1-488d689b4edmr165447325e9.21.1776158208717; 
 Tue, 14 Apr 2026 02:16:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d687b241sm114979185e9.32.2026.04.14.02.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:16:47 -0700 (PDT)
Message-ID: <d0f10fe8-1df2-488e-ae4a-03534573ba29@linaro.org>
Date: Tue, 14 Apr 2026 11:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] bsd-user: Add syscall header generator for FreeBSD
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
 <20260413-syscall-nr-v1-1-f70408d042ea@bsdimp.com>
 <934e73a1-0dcc-499c-b0c4-bbcc3cfe26f2@linaro.org>
 <CANCZdfqwQKExBX-3g_+_0crJUi7qgU92PM7W2pAgBdRO0nO9FA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfqwQKExBX-3g_+_0crJUi7qgU92PM7W2pAgBdRO0nO9FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 14/4/26 04:44, Warner Losh wrote:
> 
> 
> On Mon, Apr 13, 2026 at 4:21 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     On 13/4/26 17:31, Warner Losh wrote:
>      > Generate the syscall numbers from the installed header that has them.
>      > Ideally, we'd use FreeBSD's lua infra for this, but that requires
>     that
>      > we have those files installed, and they aren't quite the same across
>      > supported versions yet, so use this simple, but effective hack.
>      >
>      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>      > ---
>      >   bsd-user/freebsd/syscallhdr.sh | 9 +++++++++
>      >   1 file changed, 9 insertions(+)
>      >
>      > diff --git a/bsd-user/freebsd/syscallhdr.sh b/bsd-user/freebsd/
>     syscallhdr.sh
>      > new file mode 100644
>      > index 0000000000..fa38500775
>      > --- /dev/null
>      > +++ b/bsd-user/freebsd/syscallhdr.sh
>      > @@ -0,0 +1,9 @@
>      > +#!/bin/sh
>      > +# Copyright (c) 2026 Warner Losh <imp@bsdimp.com
>     <mailto:imp@bsdimp.com>>
>      > +# SPDX-License-Identifier: GPL-2.0-or-later
>      > +
>      > +in="$1"
>      > +out="$2"
>      > +bsd="$3"
>      > +
> 
> 
> Hey, thanks for the review.
> 
>     echo '/* This file is autogenerated by syscallhdr.sh, do not edit. */' >
> 
>     $out
>     echo '/* SPDX-License-Identifier: GPL-2.0-or-later */' >> $out
> 
> 
> These aren't needed. The generated file starts off:
> /*
>   * System call numbers.
>   *
>   * DO NOT EDIT-- this file is automatically @generated.
>   */
> ...
> we're just doing sed -e s/SYS/TARGET_FREEBSD_NR/g on
> that file (though awk is mildly more convenient). No need to add
> a license, since it's already in the public domain, and you don't
> need a license to do anything you want to public domain material
> (including incorporating it into a GPL'd work). Since the generated
> file isn't committed to the repo, there's no style checker to appease.

Ah great, thanks for clarifying! R-b stands.

> 
> Warner

