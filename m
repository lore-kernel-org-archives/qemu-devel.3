Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F93C46CD2
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 02:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTuSy-0003xO-G8; Sat, 27 Jan 2024 21:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTuSv-0003x5-Bv
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 21:00:10 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTuSs-0002sI-2j
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 21:00:09 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b37f4804so1941018b3a.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 18:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706407203; x=1707012003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I5tlprTkAZRsNOl5bMelh27fW7wWvdSU3I6ChYajoeU=;
 b=CwzZ9T+UqzvMmoNOyjvjTTQk+LWqfiKYiE7VE7VxmRp/iqMyYdOFCtgI4G83w648Ls
 Buo80qNPdSSW2MoNeR+Sbph2IoifXH8E447is7g9kEQJPF/2zg5xovrI0hnPFxNyJMdI
 0/WPudwrEo77vfbJnE1ghwVZWZBDQJJ9S6dm4l/qeK7KhrDx/SbRZfQaUvHpo/zW5sj3
 iG+L5NaLMcLdBgMk5dNzEIc+1gm21N+4VpfCJHk91Dkt9drnx2r/qTDofWjU2c6ZK2U7
 4DsKGq/j0+RJVglyDvOLGnnTy5oJrzARML/KOODOCk0Ap3hMVX2uoV3tfG85CoeHJCfo
 vfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706407203; x=1707012003;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I5tlprTkAZRsNOl5bMelh27fW7wWvdSU3I6ChYajoeU=;
 b=e2w41nkAxPkmZR997LEQOQq+1Uhs1Bkhyk8icWQvLI5L8t+1lnfRJ7mcsXYZZVXOY/
 yEjA1D/a4nEQLcqCwSFn9LfJeOOtFxtByfPJK5TsUJ4xDjjr6YF9PTf0Sv8EoVuphJQ3
 N/6+D0F/MAdio+07kfCzaeWWQul1b7lyy/c8QEzOLUqYkLxD8jrWZhhDdZKk1OMg8o8l
 hP8W3Fr+NpRDe6LQe4BTN+uTN9fcJXbEnrnIcXZWzDN8JCH1LX2tTVMzseNN68WYoDpa
 7xKZuoGMkkAFKte97wxdNgJegLXUMaTiSYE17O/vseXxmyIapmJXN83AKcXqnNB3+tWl
 lt8A==
X-Gm-Message-State: AOJu0YzEX78tWZJX4s4lvc3N+WAl1LN5fhVn2lN9PeNWQWegiKBCPWJz
 SWx3PTGEkUKJGKThS5KkiMPYABVVxS7y8cGNE1aRjpElnKtKSllGlAlfvhBjnn4=
X-Google-Smtp-Source: AGHT+IE2FyVCqGrEppRBUrAOa4/dP27YdfHf0ucY3NPg1AiyKnvlIek9E/DmFjAq35UELF3qAZJFtA==
X-Received: by 2002:a05:6a20:5194:b0:19c:9ba6:4c21 with SMTP id
 j20-20020a056a20519400b0019c9ba64c21mr1705058pzf.24.1706407203453; 
 Sat, 27 Jan 2024 18:00:03 -0800 (PST)
Received: from [192.168.198.227]
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a63e34f000000b005c2420fb198sm3494188pgj.37.2024.01.27.18.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 18:00:03 -0800 (PST)
Message-ID: <2ac820e5-fcb9-4a98-ade1-be4fab207ea4@linaro.org>
Date: Sun, 28 Jan 2024 11:59:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240125054631.78867-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125054631.78867-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/25/24 15:46, Philippe Mathieu-Daudé wrote:
> Since v5:
> - Use v4 instead of v3...
> - Rebased on commit 53e8868d69
>    ("meson: remove OS definitions from config_targetos")
> 
> Ilya Leoshkevich (4):
>    accel/tcg: Make use of qemu_target_page_mask() in perf.c
>    tcg: Make tb_cflags() usable from target-agnostic code
>    accel/tcg: Remove #ifdef TARGET_I386 from perf.c
>    accel/tcg: Move perf and debuginfo support to tcg/
> 
>   include/exec/exec-all.h            |  6 ------
>   include/exec/translation-block.h   |  6 ++++++
>   {accel => include}/tcg/debuginfo.h |  4 ++--
>   {accel => include}/tcg/perf.h      |  4 ++--
>   accel/tcg/translate-all.c          |  2 +-
>   hw/core/loader.c                   |  2 +-
>   linux-user/elfload.c               |  2 +-
>   linux-user/exit.c                  |  2 +-
>   linux-user/main.c                  |  2 +-
>   system/vl.c                        |  2 +-
>   {accel/tcg => tcg}/debuginfo.c     |  3 +--
>   {accel/tcg => tcg}/perf.c          | 14 +++++---------
>   tcg/tcg.c                          |  2 +-
>   accel/tcg/meson.build              |  4 ----
>   tcg/meson.build                    |  5 +++++
>   15 files changed, 28 insertions(+), 32 deletions(-)
>   rename {accel => include}/tcg/debuginfo.h (96%)
>   rename {accel => include}/tcg/perf.h (95%)
>   rename {accel/tcg => tcg}/debuginfo.c (98%)
>   rename {accel/tcg => tcg}/perf.c (97%)
> 

Queued, thanks.


r~

