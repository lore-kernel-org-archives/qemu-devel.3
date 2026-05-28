Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8DFCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScbX-00064u-9Q; Thu, 28 May 2026 11:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScbV-00064S-Lq
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:25:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScbT-0002eh-Uj
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:25:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-452169ae568so8375667f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779981898; x=1780586698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9/Ja37LZtpam2DGtcZQELBh7bImXz1K7m9NzDHBwgpI=;
 b=VIuMeQLTmlIoaVCEmlDxkkVSpcertEQ2T1a8RQZcU01773N8RuOSOadKlse+JO/XAL
 4qZNxpaw1RYGyk7kCfSvZXuavtaPbgrVjgFoALGr/cXCNYUp9xE4/MhIKY1cDRMRu4gG
 oAyawF0HNei6zJ7MA80sHuAC/OYFwwD9zygl8582hNeGK5Q0rTgfEpvnEqu9ZnoFu7Q6
 aaXH7gfVpQBEuJxnR8CvK6aHGJyB5o/4IhBeU1+mCnuqFGWkSouqp0LPoP909l4tz4ta
 ILYbY15G3O1sxb1rPQrnbjxyNLPdXi5+p6KRvOpjRl2PY3r5eXqHFPBmlHaU5f7xhja7
 P9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981898; x=1780586698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/Ja37LZtpam2DGtcZQELBh7bImXz1K7m9NzDHBwgpI=;
 b=ka8CNujt9Y1BxdJcdrbkN2lnDxbdC/wRHbfT1Xo6fhB5lJD/M5U19ginIBoTw+JQ8o
 IRe0lAOv+sAf/63XwIMe9un4b2Slx/Rn294aGXhREWMrWHI+N83lsMhX7wIq2NVcGYbm
 HoSlKUZ/kcCcPK5dsw9aeCHc4UjxMXCh71oy6cfHwhGvnNzW6AOPY6FfGC3SazU62MAr
 4uSk2TBc4gZMQKfPMJP1miBbAN5QXhhHk2Do7LBvX8SbnZsu2ofRn0WFtzqASsPfKRoB
 2y7XOXAVQ5X7zmBZfjD9h5zlINebFngdNYcewIiWNVkRsDaaruuWtJC0Pi/BZGbPLTD2
 3jOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CGjfedj3uCpC4snrLjlhRWBEehMBipX6FNs0TpYJv+TfNpnZCNNUXvYm+imxFJVkNHdvEhX4vDuby@nongnu.org
X-Gm-Message-State: AOJu0YwH/vhRx27RJ/4Zfg7XPV2dFUAtxE+FKiL7bIk8rd7cqcUsLmvD
 xoCNrkQvdfBTQOqzejY1MMUWne8D2cxOQO17/1GAkFtxbozgMyVhopjIHwPomUIf/OGgt3/mVDw
 ZfDSNBoA6JA==
X-Gm-Gg: Acq92OF9FpqR5zW7V6xDvTqjux/wRapvnVz5ilUBZ0Ot6CcAClTbqihdYgGnNR0Fiar
 0UzOVU3QWMHNLwmGIXPwyChwCRHVhxiUf0CTMhbUsHtizREShQTTkTwD3ZNjAILAFlXCWVgvzzB
 6n+iL5GmTDWPukdOo/oaLU/cDrFMvOZQBwdFAMm97g7q7F37Im0HY7X0FfvltMjnexAfRhRa5Rg
 I4r+GZp6mm5GoGnmO+6GsrPsx9YG/qXOtspjZ98xYAY+gPoSzzLErLFe8LTgu67qHU7Id0mpayb
 9m0Wcg88LqqEhkn8GJnFJ5i/EDiONfoci1UbJ8SAdwaHLH9WC1yjGJxeIeOAHXfUMTiknSCGhVe
 e5bGtf3ibK7CS815M6QgqfaYkvTOUOhr8lPbK8kqskSYWRHCOFmiOoGK1x3n75AbaoKQjdSrkGv
 5K2Rbc95BqGYhk6HsB+NLydxlgfFNotXbtkG+vmX6vJI4NElYVrX3Csyn2Dl1xSVHquAUeU3rXY
 zp/
X-Received: by 2002:a05:600c:1d22:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-4909588bf5emr30730815e9.18.1779981897742; 
 Thu, 28 May 2026 08:24:57 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ee91c34bfsm5529008f8f.2.2026.05.28.08.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:24:57 -0700 (PDT)
Message-ID: <2e90e85b-a8cb-4f6c-b7d4-f2f6159b6d55@linaro.org>
Date: Thu, 28 May 2026 17:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/monitor: Refine `info tlb` command logic
Content-Language: en-US
To: AlanoSong@163.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, pbonzini@redhat.com, zhao1.liu@intel.com
References: <20260524124129.174254-1-AlanoSong@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260524124129.174254-1-AlanoSong@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi,

On 24/5/26 14:41, AlanoSong@163.com wrote:
> When booting an i386 guest, the `info tlb` command
> may walk the entire page table hierarchy and emit
> an enormous amount of output (as many as 800+ million
> entries under my test).
> It will take dozens of minutes to print all the info,
> because each monitor print function will holds 'mon_lock'.
> This effectively hangs the qemu monitor, and even leading
> to program exit due to timeout.
> 
> So it may be better to show only the first 32 entries
> and the last entry by default.
> 
> And if full output is required, the user can redirect
> the output to a file by specifying a file name, e.g.:
> `info tlb xxx.txt`.
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>   hmp-commands-info.hx  |  10 +-
>   target/i386/monitor.c | 230 ++++++++++++++++++++++++++++++++++--------
>   2 files changed, 195 insertions(+), 45 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c2..33b4604d11 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -188,17 +188,19 @@ ERST
>   
>       {
>           .name       = "tlb",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show virtual to physical memory mappings",
> +        .args_type  = "file:s?",
> +        .params     = "[file]",
> +        .help       = "show virtual to physical memory mappings (optionally save to file)",
>           .cmd        = hmp_info_tlb,
>           .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
>                           | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
>       },
>   
>   SRST
> -  ``info tlb``
> +  ``info tlb`` [*file*]
>       Show virtual to physical memory mappings.
> +    If *file* is specified, the output is saved to the given file
> +    instead of being printed to the monitor.
>   ERST

What about passing count or range by argument instead, keeping the
default behavior?

