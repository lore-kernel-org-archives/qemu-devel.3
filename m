Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C467BC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSm0-0006o6-3k; Mon, 29 Jul 2024 11:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSlx-0006cc-RV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:58:53 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSlw-00078Q-7H
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:58:53 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso50479521fa.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722268729; x=1722873529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EungNXOHErdEhNHmodW6Z8NrWsRg5rP923IRl8eYeo0=;
 b=NnxETyTtvbRh3AcHUH5amAi0hMqWmwk9eEK6E+6UlVB2m3oy9Q3i0bblLr7OvVs8ij
 JxJWLrHhGbwA9QHzsXdEDd658KXtvfzRLl2VkWJHZjWlfPIlu5uMX5bAQxdBM3rWGMcd
 8DjLtROblaFLABWy/H0lxodhPn5/4VGv6C+Og3i0Bt3adBn4Knm8gDgPotqd1/9cMSSH
 NsRLiIh+7TmN7lFMVpyuuzMHhHkkMPIMOunr34uvFlmYIInvcA7nIWjMrDBPfwwbeC0b
 LWaHvbYeklJdUg/NEgcOvzfXDaD7Hc6Ta4aAv3d73XuZEp9eoqhRIXqp2yNM5ZUK/X4T
 Q5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722268729; x=1722873529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EungNXOHErdEhNHmodW6Z8NrWsRg5rP923IRl8eYeo0=;
 b=q9nB/pMsZy3CUnPmxODpCXdiIxEvBNesApknISYxR6zeqbw+3EudNJC+qLZYDAwmpc
 +bh1dHl49ph6nu9eKMJY+U/vVsyj4LwWJzRdVmBVLJbtDrPKJvIH0wtbMPC0t6ydXOTa
 T7MvgqiNv57EudzXISy76Z9TXdPWJdOrz89MZaUMi5ylt4fSDfGFy5BPwlbzncdzd21m
 dbLq5bXVIWhy5VMaRD/Ert/xIg7UTX9EmzNfoMEzv9p1/HTsEDc/vldaWok0fPu2SE88
 KpUEzvW2LE/s/uVsM+2wkKuSV4Myee2YWPi7yCKLcUxICeE0XY9WfaY3UiQekL5f4ZJ/
 6jEQ==
X-Gm-Message-State: AOJu0YxliL4q+v/nghsG8BF5H7lfV5xrY50BFDE5mk+hjcRP5x84SdoO
 i0I2xrmZOgycyn7vdZk7EPHyHOjtDy4IgIwONVvrUqrTb1+ugtN5Y90ucKIzlmY+ga6jQ27mf9d
 zwHU/yYCRLU1Qz1Fevod5IG9Uh17+fkeMFQP5wnKdgtJIXBO7
X-Google-Smtp-Source: AGHT+IFZ/+o9N6jpsmzCK/kMcPcHS6Bx+NyxfDBlCQoy6zFofDOdqJo2sD6UC8TaTQwcY1kLSZcr2aDCOdI3sNxo1xA=
X-Received: by 2002:a2e:9416:0:b0:2f0:1f06:2b43 with SMTP id
 38308e7fff4ca-2f12ee6a3fdmr56524591fa.41.1722268729264; Mon, 29 Jul 2024
 08:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240723151454.1396826-1-peter.maydell@linaro.org>
In-Reply-To: <20240723151454.1396826-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:58:38 +0100
Message-ID: <CAFEAcA8uB+7dgYuQeCtmExdZJUtzfuu9L4YNLtQjT4-6+DEBMg@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Make use of 'segment' in pptlb helper less
 confusing
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Tue, 23 Jul 2024 at 16:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Coverity gets confused about the use of the 'segment' variable in the
> pptlb helper function: it thinks that we can take a code path where
> we first initialize it:
>   unsigned segment = XTENSA_MPU_PROBE_B;  // 0x40000000
> and then use that value as a shift count:
>   } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
>
> In fact this isn't possible, beacuse xtensa_mpu_lookup() is passed
> '&segment', and it uses that as an output value, which it will always
> set if it returns nonzero.  But the way the code is currently written
> is confusing to a human reader as well as to Coverity.
>
> Instead of initializing 'segment' at the top of the function with a
> value that's only used in the "nhits == 0" code path, use the
> constant value directly in that code path, and don't initialize
> segment.  This matches the way we use xtensa_mpu_lookup() in its
> other callsites in get_physical_addr_mpu().
>
> Resolves: Coverity CID 1547589
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> --


I'll take this via target-arm.next since I'm doing a pullreq
anyway.

thanks
-- PMM

