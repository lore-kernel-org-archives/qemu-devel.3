Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB04CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 08:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru7Ba-0000xG-El; Tue, 09 Apr 2024 04:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru7BY-0000wq-LH
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:50:32 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru7BW-00078p-Gt
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:50:32 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so4387373a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712652629; x=1713257429; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hqgRmDRghhhbOVrW91LEfTvfhlWKyTVSf873gQJ8Nqw=;
 b=eEIMAF8L0WmD2EpeXcJoxL5yjDMsP1MaIra6d+xxF4iWzzl31U5v4W/h+2M0oHISWZ
 bcvs9AXZcGAiEzMDeZlLWTrW03CDMqsXZPcLNmkA08bCj7bysS6jfdPwSjnNLkQXq+DU
 cFK86KClDLTli+yA7lvSx7hZYlpAVFZcqkG+27xWmmVkrqpcVBsLCw+8raO4vKXBkIHo
 xOGLwi3wVZ6AVA8hUC5J1VnSHwEew4ZphdCO3lv15J74rsQ7Lfxm945P8JDqKWskk79y
 x8FAI77tj7t1Z+uN61zGgUmxS6d9ikzh4vZTObs5oISSaEAInZ+0uInutYIjcHVA7Yds
 TAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712652629; x=1713257429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hqgRmDRghhhbOVrW91LEfTvfhlWKyTVSf873gQJ8Nqw=;
 b=eAOOhbR9ihb5eHqHx/kC1D02ZXXUDAaoJC14CqSpBBETcmP4R8fSFZ3RkO0KpQbclB
 0LSY2szI5AMbQJkAVjBs37y3/iHAsRD2NxEm3dTB1C9YOvDdvcPD43Eu6fQDPeIyyP20
 rvcZxasAGL6FMtqxTovhVso69XTvPenwDy/os3jSfj10SikI7RjSYKdka56GJG2l0fog
 t8CdzTfPQ+wEx+FMK+bsx+OJjNOukqnWsI5i5LDDlr+wDImVhSC8S0OTfkDRghA9qQfg
 9MkXY5p0wQq5T3GLvAdC08WdIQMLUfY7KdWbFKWj1xqUJISxxDOc1Se07BIGykklbfVo
 U0tQ==
X-Gm-Message-State: AOJu0YyWyF+E1gJ27unOuZNGzRo3nFfILwFoY2dZomaY0HdfTrggR1f/
 wp5kE0Pjz0NduHVnnJkZiQdn7RFPSLcDYpRHdd9CmLjzxAA3n4Q9hO1C+e/Wgj5WnhfEhykMBPf
 f42cAFbNX8SE9JKMG2cgwdrKAu/Jwcxi93FMNERyCTgWS5NKr
X-Google-Smtp-Source: AGHT+IEKdM0F59LAmP2J8XBkzJcf3fDqPDgwXsXLQyQYLjwdesIhpeYoWybEfFnu3guQbMGDbejykmx9yi8PBi6R+64=
X-Received: by 2002:a50:cddd:0:b0:56b:cecb:a4c8 with SMTP id
 h29-20020a50cddd000000b0056bcecba4c8mr378886edj.39.1712652628971; Tue, 09 Apr
 2024 01:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240408174929.862917-1-richard.henderson@linaro.org>
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 09:50:18 +0100
Message-ID: <CAFEAcA-qn-zP2-OkeW1fLW2OPZbfk35jKZ0YUHXQ5Xf4Rma1Ow@mail.gmail.com>
Subject: Re: [PULL 00/35] misc patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 8 Apr 2024 at 18:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This started out to be tcg and linux-user only, but then added
> a few target bug fixes, and the trolled back through my inbox
> and picked up some other safe patch sets that got lost.
>
>
> r~
>
>
> The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:
>
>   Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240408
>
> for you to fetch changes up to 50dbeda88ab71f9d426b7f4b126c79c44860e475:
>
>   util/bufferiszero: Simplify test_buffer_is_zero_next_accel (2024-04-08 06:27:58 -1000)
>
> ----------------------------------------------------------------
> util/bufferiszero: Optimizations and cleanups, esp code removal
> target/m68k: Semihosting for non-coldfire cpus
> target/m68k: Fix fp accrued exception reporting
> target/hppa: Fix IIAOQ, IIASQ for pa2.0
> target/sh4: Fixes to mac.l and mac.w saturation
> target/sh4: Fixes to illegal delay slot reporting
> linux-user: Cleanups for do_setsockopt
> linux-user: Add FITRIM ioctl
> linux-user: Fix waitid return of siginfo_t and rusage
> tcg/optimize: Do not attempt to constant fold neg_vec
> accel/tcg: Improve can_do_io management, mmio bug fix

This pullreq alone is more patches than have been committed
in the entirety of the rc2-to-rc3 cycle so far. Are they
really all important enough to put into rc3 on the day
we tag it?

thanks
-- PMM

