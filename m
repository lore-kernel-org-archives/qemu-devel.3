Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69456C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rai0r-0005y8-KG; Thu, 15 Feb 2024 15:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rai0p-0005oU-IG
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:07:15 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rai0o-00043n-3E
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:07:15 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-563d696ce87so495309a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708027632; x=1708632432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZmI/qXqvBC4G+5ykIK4JRiBXGGdwJnEinXFvnol2i/M=;
 b=gXcJeQ4YspBSbq31sEGjl9FQ3nw3KiVx2nDpxBLl6t6YANgWQlgka4lMUmFbZkTxs1
 iPJo/kNys+6XFj5bAEjY0ipG/GYnurEMd/x4NXj2/GeqmgJgGMBJXh4IaAcgY1883j+z
 J+Z0/dfc0474EpJ1BC54OGrSveCbWXaleaDNs8k5ornKOf3+Pwpc9w41nNGmymTV02x0
 UEWkGpcarR+iemyD2qWH9wi75vFPqayDUHF1r49iJw4kQ5ilQBQ7JfgDZrdDG3m9tQVo
 9I9thSOrgTRRJk3C7X4hUT4ZXtC68GrgKTvHempsz6xtnCf+gm3CECWx+iowTbUqTYZT
 0yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708027632; x=1708632432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmI/qXqvBC4G+5ykIK4JRiBXGGdwJnEinXFvnol2i/M=;
 b=T9Cy8v5zA73WY09OZVrhf/zxjmzQ/yH/G40845Cq8xHPQZmcU1rqxPIn8iDY5ktLCO
 3GTSefE6c+oGXrUvOwPAL6HIOTR+Z4MkI7Kk7Yrlxu+GZkBTrVMQ6gmSL92u3KvNz1Hz
 WZW7VRtew5S901lOcIV9TlXj0BKDg2CRt3wNxvoDl2foZX713gy32rJ4O9/BwbNK3mS2
 ivhwg8tVOIq+b7x0Ll4/w9ZfAMZgMtnMHAaPe2PhmIRXOdI4n5i9vtT2iBivqVXnSSjh
 pm/lITb4dINd98PasU8YM5CVm7hZgF4t+sbhIrua64YrmuDPiSGJ2XWFZyl/wRzG3Cgp
 NwIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5dj7l50ZiKfFoUyOyolzYrFJEzouAHfVdMFVqSHzCSjMDcEAl52EGAUEVkpaimVDbZABVkmutwWdGuRcCWRT9V6MvQB8=
X-Gm-Message-State: AOJu0YwDe3KAwsN0EfCSAxx7VdqQzGptesJhOYvp1Qbr/4IPKLr9IM2L
 wolwHi0lTVhgQry2gCdQe1stAQ7o4t66YQoTNzMVUvcf/wkF7ApozzLv9n9QaWE=
X-Google-Smtp-Source: AGHT+IEavLD2jtewehmuf2W4DDIOilRaPboL+020362tIU3AfHzgmWYC5Iu8gk8XRBYnRS7N7cndkA==
X-Received: by 2002:a05:6402:24a1:b0:561:3b53:d0af with SMTP id
 q33-20020a05640224a100b005613b53d0afmr5748283eda.12.1708027632203; 
 Thu, 15 Feb 2024 12:07:12 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a056402414600b00563c179b993sm557345eda.11.2024.02.15.12.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:07:11 -0800 (PST)
Message-ID: <98a45842-0ce4-4271-b503-f96ef7f0777b@linaro.org>
Date: Thu, 15 Feb 2024 21:07:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/tcg: update licenses to GPLv2 as intended
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20240215184036.214065-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215184036.214065-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/2/24 19:40, Alex Bennée wrote:
> My default header template is GPLv3 but for QEMU code we really should
> stick to GPLv2-or-later (allowing others to up-license it if they
> wish). While this is test code we should still be consistent on the
> source distribution.
> 
> I wrote all of this code so its not a problem. However there remains
> one GPLv3 file left which is the crt0-tc2x.S for TriCore.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/aarch64/semicall.h                      | 4 ++--
>   tests/tcg/arm/semicall.h                          | 4 ++--
>   tests/tcg/multiarch/float_helpers.h               | 4 ++--
>   tests/tcg/riscv64/semicall.h                      | 4 ++--
>   tests/tcg/multiarch/arm-compat-semi/semiconsole.c | 4 ++--
>   tests/tcg/multiarch/arm-compat-semi/semihosting.c | 4 ++--
>   tests/tcg/multiarch/float_convd.c                 | 4 ++--
>   tests/tcg/multiarch/float_convs.c                 | 4 ++--
>   tests/tcg/multiarch/float_madds.c                 | 4 ++--
>   tests/tcg/multiarch/libs/float_helpers.c          | 4 ++--
>   tests/tcg/i386/system/boot.S                      | 6 +++---
>   tests/tcg/x86_64/system/boot.S                    | 6 +++---
>   12 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


