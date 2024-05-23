Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5EAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sABKa-0007uB-Ce; Thu, 23 May 2024 12:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sABKV-0007ti-Fm
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:30:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sABKP-000583-VB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:30:11 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so7070676a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716481804; x=1717086604; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y1dI3gZMTh8jlXSzSD3ItEq4HArM3M6fdydTGJ9tneY=;
 b=RJETcLX7Q73FdPWIxU3IsOaaJF5ESHt4d4tDXdk5bi8dfAyizFIvxuWCI4yZxd1LVo
 uqKaj5qGqtCqWXu7QiAXVmh7JsvE8zeySKBZzrP7MMAgVhv/2s/sjCqTDSCd5Jp9UX80
 n2s6sJNVTcIxlZ5uw4/Zair4/2GL+47r79HqR1OvTZ1M78wrQ/zrA1ZHJMBbbAA2Cc6H
 pHMlf74DH8EqS9hvVRk4O/ESo7Jg1swcx9+k0fEysYV+6dpsBD5kWWCpJhxOozBZmqQa
 mPNDcbKgPeCRglxiV7j1/n29ZuBZvsj3ePLeUa8IBzNuLSRM2hdEDo7bPQDhmbz30lYM
 7zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716481804; x=1717086604;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1dI3gZMTh8jlXSzSD3ItEq4HArM3M6fdydTGJ9tneY=;
 b=LAfXQ5xDajJeQyQ4hRBHvO311+UMGP6WwtaujpGXYTBWTokZboslAK5rcXFoKMYcXg
 rCTtdQ8fk5ykdr5p48nzt0OW83J0+Gitj/q3Ld9bxR1kvOKLCjMmBklnACrZgD2/AiDl
 mhLJ2gT2C0L5WOW+6k2+WP5dXXUIxlxaOUR9YAi5UvB4RhQQi168n6OCmurp/EXs8eMs
 gT/sAt1wkHqNve1Q/PGb5ClYkBk1BwpgCl3zgIKDl6umulqPf0ps7bPTcC5wiJIKr20g
 5pGLGwyycOtRTz3be29QpSU1v7xkR1LvOnPcRFn2QZf72J6HyHctxdBg7R3PQ1yoMKs8
 cvmg==
X-Gm-Message-State: AOJu0YxOLH+amA17rICL44Tq/FzbQ3II2GWbpTsnodDDz5osXpxX3X/u
 WH03a+iypxwjDLJRLGVOA23P/1ecdqU+6WvpvjjpUDYgZKzdNjMrCQPS3w3I9UFWbLtDmbv5uiU
 tcsgER1fthWobYug1pq1ppkVlagUdvBTHekQik+ckHLybj6a0
X-Google-Smtp-Source: AGHT+IHW65KCYmR26mSVubx9HoH9/aKpndJL5oKegQQzD0suoLbMR8Gooy/rOACxBxoAYP/SKLZ3RSz9iXeMEuC4Ubc=
X-Received: by 2002:a50:d5dc:0:b0:572:a167:65c6 with SMTP id
 4fb4d7f45d1cf-57832ac45abmr3141187a12.25.1716481804211; Thu, 23 May 2024
 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 17:29:53 +0100
Message-ID: <CAFEAcA_kBwz4gUMv92vyR9Eh3uBpuFmT5tU-anrLp+oWu5aFYg@mail.gmail.com>
Subject: Re: [PULL 00/37] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 23 May 2024 at 16:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; most of this is the first half of RTH's decodetree conversion;
> the rest is a mix of fixes from the last couple of weeks.
>
> thanks
> -- PMM
>
> The following changes since commit 7e1c0047015ffbd408e1aa4a5ec1abe4751dbf7e:
>
>   Merge tag 'migration-20240522-pull-request' of https://gitlab.com/farosas/qemu into staging (2024-05-22 15:32:25 -0700)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240523
>
> for you to fetch changes up to 051aca523db178ad4c49d5ed736ad26308d1df7b:
>
>   target/arm: Convert disas_simd_3same_logic to decodetree (2024-05-23 16:06:29 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * xlnx_dpdma: fix descriptor endianness bug
>  * hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
>  * hw/arm/npcm7xx: remove setting of mp-affinity
>  * hw/char: Correct STM32L4x5 usart register CR2 field ADD_0 size
>  * hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
>  * hw/input/tsc2005: Fix -Wchar-subscripts warning in tsc2005_txrx()
>  * hw: arm: Remove use of tabs in some source files
>  * docs/system: Remove ADC from raspi documentation
>  * target/arm: Start of the conversion of A64 SIMD to decodetree

Better hold off on this -- I noticed belatedly a problem with
the change to half-prec negation (see other thread).

thanks
-- PMM

