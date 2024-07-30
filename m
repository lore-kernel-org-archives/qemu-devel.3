Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2ECC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 05:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYfSb-0005tU-Th; Tue, 30 Jul 2024 01:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYfSa-0005sy-0X
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 01:31:44 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYfSY-0000QC-7n
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 01:31:43 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7094641d4e6so1000995a34.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722317500; x=1722922300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwLSu5y6Pw1eNTzcJj0xpU9SqbojhH4pdya7j4wqa6E=;
 b=lR2bjfQdrwkod8PEe9wxFYraOFEGALsZmmzNLj8SvQZeqn5KbFaNficeoJu9Fa6YUT
 WezWtOt13p66G6/PwlXVCz4ApKRnEL4i2IUeLXlIZZv7uLquf2thOX7t2wbO2IJDNYXU
 OVLaFZpvPxXHhmNKJEyCp8qlR9QIUs2dLVUhj9K4nUWM5oRKI7TVF/wby99PpeMKoRML
 Qvj2jzcfKstUtOKcwrTqMPQI2PZ1Jb+lgiImtFzHGh9WVPKWzDKReJ3F+iWwkLjYkhH7
 +R54gzC1Je0jrjNBshDimJNNd/92m7r15dJvaPl89uEfL2ZjDxORwsRzzpG5Icr+ULHj
 hbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722317500; x=1722922300;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mwLSu5y6Pw1eNTzcJj0xpU9SqbojhH4pdya7j4wqa6E=;
 b=flgjqH0/SBbwxUh8NT3VjUMtJLZu/R5cfk4OjPxbQFC/e/1RXBC8m1lmYbLtfNI2TI
 fx55eYCKqkMztsBc/BTUHu9D6cimdJ3CFPS557s+jVpy4/UnA/iSXfJSvqh5L0R53aBP
 GgWjJWMlXPRPayeDQ6jzQM9+3meGyV8mtRYNAQan1XLJRItTs+adTnbvA0IsF1xos/Yy
 tuG2JY46oe5agrnRMoOyqCDOITG7sAMreJquOpP6D/E4+O0tBPKxu/QyLNDfU4bucqPz
 J9hPwB2AF6PJ8FeTR/qFxU55n5D57totYixGrISrzT/hWdIRIlK2g8YcFNfwq97yNMvO
 YwVw==
X-Gm-Message-State: AOJu0YzVtmHp2gk4VytKtm9tThQUzk7xZ+iJP2l3j7LYn1jI4vkDKiUM
 V11R8UrnI035PLSdf5GEj9nHcgLHs4WGv5Sk8/p2hVrwZkqTzVLgsM3JnZ7FxjWGcGhgEZL6Qqw
 i5q4=
X-Google-Smtp-Source: AGHT+IGY98MLKM6jT99wpkEeVlyRUkbVrr6eJFfjwKeswy0v/UhCe7qQ8pvV+M34Pl1xof1gxHi8yw==
X-Received: by 2002:a05:6830:6c0e:b0:703:64c6:305b with SMTP id
 46e09a7af769-70940c054ebmr13956668a34.2.1722317500315; 
 Mon, 29 Jul 2024 22:31:40 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:3e4:c598:8b5f:3919?
 (2403-580a-f89b-0-3e4-c598-8b5f-3919.ip6.aussiebb.net.
 [2403:580a:f89b:0:3e4:c598:8b5f:3919])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8146aesm7649341b3a.131.2024.07.29.22.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 22:31:39 -0700 (PDT)
Message-ID: <f2a1811f-82a1-4493-a0b1-2b65d17acb0b@linaro.org>
Date: Tue, 30 Jul 2024 15:31:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] misc patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240730011202.480829-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240730011202.480829-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 7/30/24 11:11, Richard Henderson wrote:
> The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:
> 
>    Merge tag 'pull-ppc-for-9.1-2-20240726-1' of https://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240730
> 
> for you to fetch changes up to d9b019e0a05cbbaa184815dd201b25006950c6d7:
> 
>    linux-user: open_self_stat: Implement num_threads (2024-07-30 07:59:23 +1000)
> 
> ----------------------------------------------------------------
> util/getauxval: Ensure setting errno if not found
> util/getauxval: Use elf_aux_info on OpenBSD
> linux-user: open_self_stat: Implement num_threads
> target/rx: Use target_ulong for address in LI
> 
> ----------------------------------------------------------------
> Brad Smith (1):
>        util/cpuinfo: Make use of elf_aux_info(3) on OpenBSD
> 
> Fabio D'Urso (1):
>        linux-user: open_self_stat: Implement num_threads
> 
> Richard Henderson (1):
>        target/rx: Use target_ulong for address in LI
> 
> Vivian Wang (2):
>        util/getauxval: Ensure setting errno if not found
>        linux-user/main: Check errno when getting AT_EXECFD
> 
>   linux-user/main.c      |  3 ++-
>   linux-user/syscall.c   | 10 ++++++++++
>   target/rx/translate.c  |  3 ++-
>   util/cpuinfo-aarch64.c |  9 ++++++---
>   util/cpuinfo-ppc.c     |  5 +++--
>   util/getauxval.c       |  9 +++++++--
>   meson.build            |  8 ++++++++
>   7 files changed, 38 insertions(+), 9 deletions(-)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

