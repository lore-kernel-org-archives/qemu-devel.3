Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB507C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKbw-0004ZJ-CO; Thu, 07 Mar 2024 15:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKbv-0004Z2-1w
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:45:03 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKbt-0002mE-CY
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:45:02 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so875381a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709844299; x=1710449099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4qKnJm8WUgKUl5gXGhBURiml3FQfLJ/SDsCgAjuZtXk=;
 b=ChMen/XEIyuBE69gmSq96LIt4KonyYuFdQXSJZPDY0v4IYVm+gCU80H8Jts1vPgGJe
 YiQRP9uDkivjhoYlbVQkA09Y+45LjSswsF9WMJkTek2tVaB4cM3gvBVImLxUVyWN7G87
 /5kdqcldU8runsrv6FKztX574135dr95eLeDXqkkdTcMZL3i0jibUAe0HIvDrbLYhbwU
 5HFiV9+GOqZLpUuDOsBRaauZom4jKHcfno+i0g7WNlbsNa2MrZ5uuYHLai6jYCSgpbbo
 EzYWqX8ND3x+jHMmKD/qFeWRK9aPHJtlp6gwZ+4Z3DGpyyfj7jzRxVpreteKE8+TW3Ut
 F13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709844299; x=1710449099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4qKnJm8WUgKUl5gXGhBURiml3FQfLJ/SDsCgAjuZtXk=;
 b=mqF+rXnCWZXK1Xy4z95KwRw6bmYeMaHXFlKIEPY7CVKMEnt/oNcrgTTvVFN3VgwjW/
 L1zlld9oYUI5tqxBrzPpJcO4qo2zx0l97Knf8fkktOzDfc4DktsEImDlyUbV21EQ3ZWG
 /an1i2pxSRjSXwYIdswISAbs4ol9n9n1uB88wh7iCrYYvLocRZfgnOIzlCOvorQmuk1o
 olkXrQp8xIJYpbcBv5AtQm5AoTDFZYsO6BSzh+xcotdP9s0GgXkd9zNfrEwY1VPTvsPk
 FDZYsBrAobA9leB/jPakiUZ41V2QPiTo7hOwynblNFEnfeji7HkiW177SFPluDWut2St
 tYEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMNla7qMjLtdeqqwxhJqBraJvmlflt2UJsZN96AjaM24Qn7uBhsysubDy1G0//9xK0u+4KzTqFXxmRRjRYPmQp20+LOeQ=
X-Gm-Message-State: AOJu0YyUgWOrVgInWSWLN6B/WWoSCSkLgjqE9j5iFT/rDQYTT8s2yEeO
 HGm52b7vvvp/cJyXad0Fn/pah+ALMfusutjgussFG59HqHPcvWhrtoIVHrZyDeQ=
X-Google-Smtp-Source: AGHT+IExq8aPQlrhulioiZVR1CHetMb81mUbNtkqTx0JzB8OQQiQB9KhaFH99FUFxPc01CHqyTd43Q==
X-Received: by 2002:a17:90a:5312:b0:29b:b5c:415d with SMTP id
 x18-20020a17090a531200b0029b0b5c415dmr17311031pjh.38.1709844299691; 
 Thu, 07 Mar 2024 12:44:59 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p1-20020a17090adf8100b0029b178a7068sm1961051pjv.50.2024.03.07.12.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:44:59 -0800 (PST)
Message-ID: <065c0f23-d7a2-4280-bc8c-c82fa35be080@linaro.org>
Date: Thu, 7 Mar 2024 10:44:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] linux-user: Move tswap_siginfo out of target code
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-2-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307182623.1450717-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 3/7/24 08:26, Gustavo Romero wrote:
> Move tswap_siginfo from target code to handle_pending_signal. This will
> allow some cleanups and having the siginfo ready to be used in gdbstub.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/signal.c     |  2 +-
>   linux-user/alpha/signal.c       |  2 +-
>   linux-user/arm/signal.c         |  2 +-
>   linux-user/hexagon/signal.c     |  2 +-
>   linux-user/hppa/signal.c        |  2 +-
>   linux-user/i386/signal.c        |  6 +++---
>   linux-user/loongarch64/signal.c |  2 +-
>   linux-user/m68k/signal.c        |  4 ++--
>   linux-user/microblaze/signal.c  |  2 +-
>   linux-user/mips/signal.c        |  4 ++--
>   linux-user/nios2/signal.c       |  2 +-
>   linux-user/openrisc/signal.c    |  2 +-
>   linux-user/ppc/signal.c         |  4 ++--
>   linux-user/riscv/signal.c       |  2 +-
>   linux-user/s390x/signal.c       |  2 +-
>   linux-user/sh4/signal.c         |  2 +-
>   linux-user/signal-common.h      |  2 --
>   linux-user/signal.c             | 10 ++++++++--
>   linux-user/sparc/signal.c       |  2 +-
>   linux-user/xtensa/signal.c      |  2 +-
>   20 files changed, 31 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

