Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcV8-00008E-IE; Mon, 29 Jul 2024 22:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcV6-00007c-Na
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:22:08 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcV5-0006sy-6A
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:22:08 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b5d3113168so23450796d6.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306122; x=1722910922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pkLZTmEY9dxtVQ0wb6MO1CwmXaO0v5ngNRGRZrlJftg=;
 b=pfEkvktbAM+KFBlpblfSGMK9+KMcazMZEV2waslEnWxNb5p5OnaesBzMh9N9K3m5m9
 z1kId9tEdv4ZYmdHzqm1iidgQuPODnQ2SzZi6DU7Gf/mLTanjERFh9u1FUr2e1U1qDZW
 mJx0g3QCOOzc2yniILFFg7C1wugetkEp5kxcj/832vWETX1pq21wyw4yF+yxJIFC8Ibq
 YPxgoQhCJAUvym28/MmrwttR/nbOPM/qQgkHSX/HjRW3gm+vERPfBLREXE13y+mvGJ8W
 Fm+bE7PhYKRn5fks1Kw3xnLy8oaQrcpruEW8PepUnwjgnKU01AFpFNBZfJdjnps5VOo5
 pgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306122; x=1722910922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkLZTmEY9dxtVQ0wb6MO1CwmXaO0v5ngNRGRZrlJftg=;
 b=PNSDe4vSauyfQP6e8nmVAW+gvCi44a/XkTTGzcQ7RQIIMemS/GKC2QcLfS/RqRRbhi
 voheHKji0blxqr1VIrO1vnN4FLH4NTWoY4fecdYEC6AOYqV0Q1K2q9ZagpyKiZaT3LOt
 Z9sbxBpk2jwfTvuvAGthaWlvbhxdLhF9+UH2ItxxMK5wNwgiUFHVJEGhk+9A+KxfTetN
 0KTXnUDMy5l6VzfvcdyiXr5g+V3jX4UugdnpmfqcnhDUbhnb8k4N+3d5gIemSewAbZCl
 Kqzoti9RIyuWr6hO4gvDVAfcE59giol67XJM5czggJ+i06GFVPwrl4SER1HpBcpXN3e2
 69NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN4l5LUrkm4ebPiZa17cz8DvubrtAYNL/rh2WqyMTbnQjIAQo/6ljTB9EtTno4bHp5dIq8rpxQmtDpSvCdMU7k2sgAa+0=
X-Gm-Message-State: AOJu0Yz1XIspnTyruDNl+H+l9kFIkUgy8QLvyv6pRhvTiZSL4hZW+hDy
 1R+6YFW3U5q8YwJPcRRmyDw+5Fgtg+jhbmXUG9+1jbsfuPwsXH3LVuS1icXZmJG5X/649gxeWYi
 HpSs=
X-Google-Smtp-Source: AGHT+IGm5PBT5QA/Cnc1N1tHTBIzO0ZKp1uFDnrUwTeiETpRMSmZmaXuurKFROPvVJKQlgbwfOxqHA==
X-Received: by 2002:a17:902:c40b:b0:1f7:3d0d:4cd with SMTP id
 d9443c01a7336-1ff0483dea9mr74308975ad.24.1722292072052; 
 Mon, 29 Jul 2024 15:27:52 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cf1db4sm88578735ad.87.2024.07.29.15.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:27:51 -0700 (PDT)
Message-ID: <1e08eb52-4521-4b24-9b35-65ef81decb0c@linaro.org>
Date: Tue, 30 Jul 2024 08:27:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] tests/tcg: move test plugins into tcg subdir
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf31.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> You cannot use plugins without TCG enabled so it doesn't make sense to
> have them separated off in the test directory structure. While we are
> at it rename the directory to plugins to reflect the plural nature of
> the directory and match up with contrib/plugins.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Suggested-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                               | 2 +-
>   tests/{plugin => tcg/plugins}/bb.c        | 0
>   tests/{plugin => tcg/plugins}/empty.c     | 0
>   tests/{plugin => tcg/plugins}/inline.c    | 0
>   tests/{plugin => tcg/plugins}/insn.c      | 0
>   tests/{plugin => tcg/plugins}/mem.c       | 0
>   tests/{plugin => tcg/plugins}/syscall.c   | 0
>   tests/avocado/tcg_plugins.py              | 4 ++--
>   tests/meson.build                         | 2 +-
>   tests/tcg/Makefile.target                 | 4 ++--
>   tests/{plugin => tcg/plugins}/meson.build | 6 +++---
>   11 files changed, 9 insertions(+), 9 deletions(-)
>   rename tests/{plugin => tcg/plugins}/bb.c (100%)
>   rename tests/{plugin => tcg/plugins}/empty.c (100%)
>   rename tests/{plugin => tcg/plugins}/inline.c (100%)
>   rename tests/{plugin => tcg/plugins}/insn.c (100%)
>   rename tests/{plugin => tcg/plugins}/mem.c (100%)
>   rename tests/{plugin => tcg/plugins}/syscall.c (100%)
>   rename tests/{plugin => tcg/plugins}/meson.build (70%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

