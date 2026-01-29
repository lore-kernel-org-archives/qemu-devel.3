Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BADD61013
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSG4-0007Hk-Mj; Thu, 29 Jan 2026 08:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlSG2-0007Fy-QO
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:40:26 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlSFz-0004vp-FB
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:40:25 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so715617f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769694021; x=1770298821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=41SgoHAty1G4uAyCceHWjx+1DM21xz+hX+xUTxscXoc=;
 b=OywS/jWOga1az4PtvnMHmO6fsmLkEFR9bMiBVbbEREqGDGc0mIsqM3o0WVzHKOND2A
 FHvy7xfJ1jf4aC/I1r7g/DlXRFqey8qLJUx+BoicTMbERnayZUnNiLEgopnMkSWqt9T2
 X7KcGMH06nGjrv0PW19u4vNdLyn+akhYZY1Z2bhHngK0MsS0gNxnYknDeAjokMwMsCeX
 At8eCLdRJpg7Njerx2E+wUeUjzqWodi0otuOaI4mUcOy0LSlEJctLdAJpCZYIbM0wa9u
 amo0GbXcpM7xaQJyEYpBeI2jooALYdBE8aLtuGd3nUVfnjUE6Ncqwxtr8Y3d5K+kJvbT
 c5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769694021; x=1770298821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=41SgoHAty1G4uAyCceHWjx+1DM21xz+hX+xUTxscXoc=;
 b=hqn39JnhF5/tvRP30mg+CuPD06mNX0EL6pHhZY3k9vWPs8U7M5C14+Pg2WUqVDFXBG
 OyaZyZdQIZ+kyeEOv4x5+2zLt6aQ28Ur7k8LhsexvN+ejHNMCMLh7RQCm7Retj2FY41N
 AGvs1DYQ/IHQHT7d1R0TkEkxSMZjsdvpeHzczO1UTypb8Paq/ajbJTShIFo8/upTYKbp
 zYSrHKQCvslZhKzYKKkE5cF4CMcrfmEH6qWSAumgQax0ga+O5nvqPg1nwIUEOk9THhQH
 BeoHKnzdlPXphMQyqlRoSJp1XCxQZ06y1aTjvxcbOHwOB5n+gnAch4qpNbS9m/EyIl6r
 earQ==
X-Gm-Message-State: AOJu0YwMw6I9Qpvmuny3I333DRtLZLcK+x4MfUVOUgJm3jrRt3TNp0BX
 /lb6yRDe5PXMinfiAsZ84WAfKt+oj1Upv63IuAQZbTpR9yxGChac6qFH17SeZHPiOhz10t5DZe6
 8BnQOg10=
X-Gm-Gg: AZuq6aJ5hgiS/LXa1XpS+6UyR+BrHsX5WUAJf9/lu7765haSNwqblxmPqsjofwF9fTC
 MdVyNyVe32R6q1pgDcVV9wGuD8mqda9PbEk5oKv9zIh6TpL0HY4NyYqLz12BZhy00lFDpXRAE+E
 sOuP6bzrLti2EZzgFD7V6+3MBOqRcKREQBEnQeoKobEXrgLfbQ4/WF5grcf+yIFBou791O6U310
 9wCft1dmik88777ICIVvAkBedE97DNUyUzHx3brXUcg6Y7cCUUSzVqgRjcrzHe7IQd9qJp+54R7
 KqF3TZvQVSim1ZrOYgaJaBYnhGn5JGTmfhkiK8zbIbIhjE9cyBypxkEpwKOmIJ7q8J6DV0sRg51
 +R+E/o1+fvoaJLlVQ7/Z6KSztofccWyLR1N/tQqNKLJxKo4yzzrhuT5WjwaD8zDDTiB7MVEJlNP
 cEya43KxHmSf3zh21g8gE84Xs3oLqxgsIhbwmaDjzxyrnF9QbBhMWSGg==
X-Received: by 2002:a05:6000:1ace:b0:435:9a4a:9b79 with SMTP id
 ffacd0b85a97d-435dd1c132cmr12241997f8f.31.1769694021132; 
 Thu, 29 Jan 2026 05:40:21 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfc9sm14631932f8f.21.2026.01.29.05.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 05:40:20 -0800 (PST)
Message-ID: <cfa01782-35e3-4ab0-ac40-9c1a0f156715@linaro.org>
Date: Thu, 29 Jan 2026 14:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] target/ppc: Remove most MO_TE uses in
 cpu_ld/st_code/data()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20260122221106.57184-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Ping for review?

On 22/1/26 23:10, Philippe Mathieu-Daudé wrote:
> Since v4:
> - Fixed incorrect rebase
> 
> Since v3 (DATA path):
> - Remove MO_UNALN in do_HASH (rth)
> - Complete CODE path
> 
> Philippe Mathieu-Daudé (11):
>    target/ppc: Inline cpu_ldl_data_ra() calls in ICBI helpers
>    target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in memory helpers
>    target/ppc: Inline cpu_ld/st_data_ra() calls in do_hash()
>    target/ppc: Expect page translation hash addresses to be aligned
>    target/ppc: Introduce the mo_endian_env() helper
>    target/ppc: Introduce ppc_code_endian() helper
>    target/ppc: Inline need_byteswap() and replace translator_ldl_swap()
>    target/ppc: Check endianness via env in ppc_disas_set_info()
>    target/ppc: Introduce ppc_env_is_little_endian() helper
>    target/ppc: Check endianness at runtime in mo_endian_env()
>    target/ppc: Inline cpu_ldl_code() call in ppc_ldl_code()
> 
>   target/ppc/internal.h        | 11 +++++++
>   target/ppc/cpu_init.c        |  9 ++----
>   target/ppc/gdbstub.c         |  2 +-
>   target/ppc/mem_helper.c      | 60 ++++++++++++++++++++++++++----------
>   target/ppc/tcg-excp_helper.c | 27 +++++++---------
>   target/ppc/translate.c       | 15 +++------
>   6 files changed, 75 insertions(+), 49 deletions(-)
> 


