Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29968CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 08:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsIrC-0003js-FD; Thu, 04 Apr 2024 04:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsIrA-0003jg-NH
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 04:54:00 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsIr9-0003Tt-2f
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 04:54:00 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56df8e6a376so1352180a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712220837; x=1712825637; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PPBiAvBdZaF2x4TE7b8DB+eIotNM/kjy68A+X501W2k=;
 b=qS44+4Tr3z55Yyi5gIOLTKKh5U0skSiYYJj/tjQZJv8OVIqIxXkWp6k644Y3K5ZCN4
 0Uo6yhkaoThExa8mjfvmheRinQL/Z6FZUfEzd76mTmKjWw31kAIwuWPBQW3QLKtQgdfu
 m6fjxoKGOePXN9D1MAJCKyy7znDof0UNa5aVsOVo2meJfcyiB5mRGMKfsTP/HmSrxyWv
 TM7/FnIlYJT2OeYNeC6Y86w0oWVg7d7Svdjdp/7+kv97srMQ7t7HuNLewm6w2HWRXrnT
 uSTJZWBg/GPGJahul5Te0Pqx/K/gdnAJbEJDd3tEuMMeh0asEc0FXrwgFua/i7mjmOqS
 zpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712220837; x=1712825637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PPBiAvBdZaF2x4TE7b8DB+eIotNM/kjy68A+X501W2k=;
 b=nVx7sCZBwynTbkwExh8va6frj0goYBBPV758aTFb3jBN6IDszhPcnOxEaF14LVHMQq
 CL9IwQ30+ofvh7GVO6hxLQp2Q/7gRlrdE2OXxLiUfAkH9fIxkOFZw3uhtD7Epa4QnOmf
 PysrrRMprtCyxp0c0AOzEA+2K4qdyKb2MTGy9rlbyOf0WUwi1Cqhcfc7GSkrS9lKKhdi
 9R74MJBKiUCg4W0PO393GSXkNLIvVaz1fChf9vPLlHYnKJeux9BeeKAgGXbl9YjQprWF
 rHiJnnT3++K/BcV9xzXPTKD174okULzCBHttMVHEqgMM8lBuWja5nratCwfx4yCdEX5u
 Z68w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh8XoJYpWPwzttg8c0CTn4tSpnF7nAy/P7UbLI6aPMkdk3LokjcMj1NoTMUvdCfQk1LSKexenUyLxvB3CJTPisYfPfB8E=
X-Gm-Message-State: AOJu0YwPtg75Ak3cTBCkg+DQo6OG2gDvT6hfBQrYjMkN1lmDs4Cyzo6v
 AAsw2NhOr9CvJjIANMcqwUmGjZPapra0ce6jGcssF/nUe7JJtEL6JbdYirgWk17fFnxwkHSODwF
 3YaP82/fonB44bn5i76cmyKNZR28+KnDQAEfzGQ==
X-Google-Smtp-Source: AGHT+IHdNz+ua219F5H8quJm4px5w917BK+HC22rVsr36ck7tnn7mXtRraOLbrJD4HzSEWOvIE7ge6ufjFWGE1Iz/Sk=
X-Received: by 2002:a50:a6d7:0:b0:56c:292f:84da with SMTP id
 f23-20020a50a6d7000000b0056c292f84damr4536535edc.17.1712220836853; Thu, 04
 Apr 2024 01:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
 <dd957513-1272-40cf-bda5-4d3f717f3c71@linaro.org>
 <CAM2a4uxuY5PGrHLo72+i2p6Cj-1R37kiXOehrhRMKUn3Xaia=g@mail.gmail.com>
 <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
In-Reply-To: <074ed71f-6dca-4a55-9163-60a9305dd27a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 09:53:45 +0100
Message-ID: <CAFEAcA-fmCNgyczGZaE=otT1x=iVt_-oPwkS308CWkP3wLdhbg@mail.gmail.com>
Subject: Re: Point where target instructions are read
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gautam Bhat <mindentropy@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 3 Apr 2024 at 23:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/3/24 08:15, Gautam Bhat wrote:
> > Here simple_test.bin is the raw binary file converted using objcopy.
> > addr=0xFFFE is the vector location where the PC will load with the
> > starting address.
> >
> > Now how do I load the address in that reset vector location and set my
> > PC? Is there some example code that I can look at?
>
> Hmm.  I can't find an example.  I see a TODO for m68k which *should* be loading the pc
> from the reset vector on reset.

Arm M profile does this.

> The loader device populates ram during the reset hold phase, so I believe you need to wait
> until after that is complete to perform the load, thus the reset_exit hook.

This will not work (yet) -- CPUs do not get reset as part of the
whole-system three-phase-reset, so using the exit phase method
is not sufficient to avoid the reset ordering problem here.

You need to use rom_ptr_for_as() to see if there's a ROM blob
at the address you're trying to load the PC from, and if there
is you use ldl_p() to get the PC from the blob; otherwise you
use ldl_phys(). Searching for "initial_pc" in target/arm/cpu.c
will find you the code that does this for M-profile.

thanks
-- PMM

