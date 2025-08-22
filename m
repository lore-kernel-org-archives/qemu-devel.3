Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49242CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSo5-0004a5-AL; Fri, 22 Aug 2025 10:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSnu-0004YJ-Mn
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSni-0001SL-B8
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:40 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2ea94c7dso2266065b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755873087; x=1756477887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46NHqqnDVFeCyTicknz7UWSyUHI1/BQZRAEyvIm08Hg=;
 b=AxnyGsgpxk6p9Kd8dA1a6H+rbmnB7PjHMFksXpEj402P2A1pvOPZP8pdeiI7ttC3ES
 ciD6wrwGtY8bQgIsILOQ9tI7Rk42FIja8Xp9oJdsKoU2N6bIkrJCHenYgK/mY//Saiov
 3BgyXmYJ3AMe+uZ+4MOWytauiug6K2OC3Xjunx2gJL3jcjD6KHhJPzDSTBD1EDXmkXu8
 F6oD0UOgDbVTA1mdyC/LG8pVtOUtUFXPpp8N7mFNC4fA8xkk9V3+IjpbgpYkqSB58KVL
 E3yEEHjTyid1LU/3vpvKswfiR6S1TithJlOgSAF+6BijHeJ5R369ZvtWqgrVRasMMwJV
 whig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755873087; x=1756477887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46NHqqnDVFeCyTicknz7UWSyUHI1/BQZRAEyvIm08Hg=;
 b=kqZqcvDSnzSD29dQAR404JuVrxqgEmmMDIAnZ2ODkK2rh6z5CzqsmqutuVE9D3fPoU
 KEnSKWfFOCQmK3GFjevBGP7MB/ziq9oYd+NgwuLD4axcDWHgyl6pgWrYB/gTZG7oLo0a
 ux7oX4i+9dcGusoSiTwiwrwNGkuRIVCJdyPv5mAq+R7ujX/n+mNhHJK4GyVOB+25EqQ+
 g5nR+/A3CDGZU2PiApY/CCVyYhOtFzRdoHRHBMOl9KzSsmoV3ECjA7VpWdPCv5su9kDb
 yw4mLnKbyEtMrckKyjM1i97SdES3sJuBV9wWe1ShNo0QrsA8UhohKXQiQa2Ee89X4tlH
 3GnQ==
X-Gm-Message-State: AOJu0Yyi3K/K6qmwYWGTofhnUpdp911eWwtg9JnFH2iVoRMDvZU5SFJT
 DuUNzVXsG39LXfSnyvlq9k1SKGQ7Pk3Uw3pgUI8ZsgIkKLREu4WLluS4z5+4NIt4vJhe/S6unW2
 DqhGSzEhpWA==
X-Gm-Gg: ASbGncsbG3tOxeR2OT/d3GkQ0PW/suPTO5uu2UDUR7MBavu+LDelsCF1h1UjWSTRRhp
 RGFIPzXtGNnyVoZMK8hLVEgYLoVsTkoaHzzuF3MA7bmx71UE8WTD2NUp7JPMDIciebSHpzSrB5+
 8VOW2IYxyEbWzR3bPoyi5XPmD1xDODHCx5TSAIygcoFet8ag3dbjkHpAKICVwiTXrHUQPPOUJ5H
 ZtlAOP4xa/piPmXsA3BhKM7LuND/kQ908A6Syqomd5zL6Ax8uVSMhOVFbgpDgmaKWuC/RT2C0p8
 pUO+1RR9AenmMdh7SdAvJVvC9G48DuRJ27oapn2w28Ce1U1tMCUUOHfotIyWlPoBrCdXpblnblI
 84rwJzA7Y9KfoO3pSIglR58jFcF45u2CwQ1yV6W4MT4CtU2Y=
X-Google-Smtp-Source: AGHT+IGR0EQMdaROLezv0fCFPKPSL1XwVNeSqoTLrWCnV4drqCyPAOArMWGTn4WL4JoVHWUIEMsKNg==
X-Received: by 2002:a05:6a00:2e95:b0:76b:d746:733a with SMTP id
 d2e1a72fcca58-7702fadbe8bmr4547699b3a.21.1755873086738; 
 Fri, 22 Aug 2025 07:31:26 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77040215981sm86919b3a.87.2025.08.22.07.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:31:26 -0700 (PDT)
Message-ID: <7c026d43-04b4-4615-8478-639393b640c2@linaro.org>
Date: Fri, 22 Aug 2025 07:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] single-binary: compile once semihosting
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li
 <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 richard.henderson@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025-08-04 11:39, Pierrick Bouvier wrote:
> This series compiles once semihosting files in system mode.
> The most complicated file was semihosting/arm-compat-semi.c, which was carefully
> cleaned in easy to understand steps.
> 
> v2
> --
> 
> - use vaddr for syscalls.c/.h
> - static qualifier for console_{in,out}_gf
> - use vaddr for arm-compat-semi.c
> - semihosting/arm-compat-semi: fix cast for common_semi_set_ret
> 
> v3
> --
> 
> - keep common_semi_sys_exit_extended (Peter)
> 
> Pierrick Bouvier (12):
>    semihosting/syscalls: compile once in system and per target for user
>      mode
>    semihosting/syscalls: replace uint64_t with vaddr where appropriate
>    semihosting/guestfd: compile once for system/user
>    semihosting/arm-compat-semi: change common_semi_sys_exit_extended
>    target/riscv/common-semi-target: remove sizeof(target_ulong)
>    target/{arm,riscv}/common-semi-target: eradicate target_ulong
>    include/semihosting/common-semi: extract common_semi API
>    semihosting/arm-compat-semi: eradicate sizeof(target_ulong)
>    semihosting/arm-compat-semi: replace target_ulong with uint64_t
>    semihosting/arm-compat-semi: eradicate target_long
>    semihosting/arm-compat-semi: remove dependency on cpu.h
>    semihosting/arm-compat-semi: compile once in system and per target for
>      user mode
> 
>   include/semihosting/common-semi.h             |   6 +
>   include/semihosting/guestfd.h                 |   7 --
>   include/semihosting/semihost.h                |   2 +
>   include/semihosting/syscalls.h                |  30 ++---
>   semihosting/arm-compat-semi-stub.c            |  19 +++
>   semihosting/arm-compat-semi.c                 |  65 ++++++++---
>   semihosting/guestfd.c                         |  26 +----
>   semihosting/syscalls.c                        | 109 +++++++++---------
>   ...mon-semi-target.h => common-semi-target.c} |  22 ++--
>   ...mon-semi-target.h => common-semi-target.c} |  27 +++--
>   semihosting/meson.build                       |  18 +--
>   target/arm/meson.build                        |   4 +
>   target/riscv/meson.build                      |   4 +
>   13 files changed, 190 insertions(+), 149 deletions(-)
>   create mode 100644 semihosting/arm-compat-semi-stub.c
>   rename target/arm/{common-semi-target.h => common-semi-target.c} (59%)
>   rename target/riscv/{common-semi-target.h => common-semi-target.c} (53%)
> 

Ping on this series.
I'll be out next week, but it should be ready to be pulled once the 
trunk reopens.

Regards,
Pierrick

