Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA7606E54A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AJ32Z05B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzvj-0004nk-So; Thu, 05 Nov 2026 11:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOzvh-0004kq-T3
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:03:09 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOzvg-0004i8-9U
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:03:09 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c49b431f022so67231466b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:03:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793894586; cv=none;
 d=google.com; s=arc-20260327;
 b=cl+4HECouFz5moyovyPAlkCo7oL2W6v5fmyGR/blSJ9VWgikcLo/6Pgh96uZ3pQl6j
 Y7ayFkLRNRZrwh1uJk4Uh2mdwViVsCUGXtnsGlkusrPSaoCkfG4nGIXhQaVVg2y8/l/M
 dGGtesBr0g8vgAGb1sz/+LqjHRyEshdEmNmibwyLHFUUyPRfMqvP99n+p+VqAufj4547
 JFosacvBm11vmIgTQOS4+eZDxmUF43QI3yiAt0cwBlB0RCurmePskVWkpo1H6tRL7mDw
 xl+Nmx5pZI4SOQNdwtgbom9QwedlkwchY6rAqJiezsnNO5pp2VKyUlw2uZFUgrfOeHhv
 nf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wxCrwoS0mI+3tASJN+1geokZjdT3OaM62WAeunx1IHs=;
 fh=FxAHrDBojcxCrJjqfZjRJ9hwfFO8YudMVeEHapp63m8=;
 b=Kvmfj0aREOx6Gy9FrMcpxZMh9y10lCBFaicuECZRlbOrmioSxNSY1YH42p5Gp9oZ1M
 qkagJXpQ96CO9CkLdGicHE3jLOAP8CXyBk4uFENE+nzeReFhQ6CIdtlH1l5PI7IGKs23
 cD4vpHPNERf5HdCKp5+H7SBujRMMDE5aGlnm7Fs+Le9mP3wW4l/QXIY5M3KNjq87krkW
 ksjamyVxsne+A3ec27dO9bFMFe7CnL45C/VjQ3fBCvzu0pgo1YoS8JKsKcGILChXFRt5
 SGqimEtOMQQKkIDgdYclQZjVvwWR4KM7ItmJVesJsP54rJQmu0JN9yB6jUjbot9Q9Usj
 3tUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793894586; x=1794499386; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wxCrwoS0mI+3tASJN+1geokZjdT3OaM62WAeunx1IHs=;
 b=AJ32Z05BXitEkd5q4prGTg/ODIiaSpnqrGQ6lLjmKrTvrYoLS7tWFoYuqwRlGqyGun
 0hKrujPgTSZZtjILquJADto/pN+/aJktMs3ynwqGXtwvPcQ/8T0o7g01UrBDnqKYi7iC
 ZoEv1g0xHQfwKcz3PrgZgVnZB80M2D2DPuKseAXz6ZGUuIWruyvYN5UPeqwQwMZM4t0R
 BNFW0bkb5gjuEUaf6TjX0Uw7iyUjpS4ZjP/afTP2qsvfVancN7eGTlyujVw/XAm0xYD2
 zpFLBKZ5xUrQf3SVKAaoqhsmItuJy0O95Eu1wM8/pRYqTalWjP3bfcqq2JCr4wbpNLkT
 YdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894586; x=1794499386;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wxCrwoS0mI+3tASJN+1geokZjdT3OaM62WAeunx1IHs=;
 b=dS8AwZWopilXqcm7jiKd9sCi5YRtpsacU/sDuPugT5QA0J137ce3PfG+eHm1D+ZMkC
 6jb3VVnD5tQPo06Ok9yfagVtrA2P/SbU0k/F8biRHdpwemaYcrv9Rpwegcsox7gNAYs/
 ztlV6185zCNXy8LTYwNx5vdaw9/X4fPTsKLkTD0HJ1doSbmUuYV6TyK4qpDecLR6Cfis
 uSy0PuMFF9xT0zNe0Ll3EB23/qw1eVh398UTphnmCdBdkLNT+RSamxY3rr+1xAjuVX+c
 ar1K4HCYWxRXC77+us++hppPAkySz3t4A23dLNa36DG/mE3XpJO19vcKhRMLBqHcmwo5
 zR9g==
X-Gm-Message-State: APuU4Z+X5blaWtolM9cQZyyJa8fdPiNo39quEEKSOXsjcdQjsjStqG/P
 PC9wz4bV7KfjUHhD9oKFZ3SWh3MCjpR6ACY8uB7SSFjSsivCN9YveNEH9Q03OrBQnj5GlZCxamk
 wIzfhDtjsnNuX7VN1p7MzyL0PC1yJNJu/PaC+W2/6MA==
X-Gm-Gg: AYBFou0P4lFBhAX7FdJ8bpHmsRLY89Rq1J4djhEs6nmgl8NloUHFHiAiIb43mxQR7W/
 XeD3UEfR72C9E21qPB+lYESHf+ft6HtVvxP5d8l1saczWtE4826k37oS4HP9Ge86ItzWqufCwjK
 dIUuuYwToRDZSUm/ERXN0/n9mUdYcsIWpyK+q/swRITUQzT59hYa0uVWIYNTu9/zaBjjCUqn4Av
 TFCmvrm48RwL1wEOAcqRns1wn+CCStpufV/1QdEYQGJDK3pfAZZqy9oWgtojsIhMrBsyPPkqfbB
 0AGgXj5JmGYE10/pMAcR2itqhEDRLg1dT7hMsUdFePx9nzdrYH7X2O9LLsgjbfL4BZvLfACLtYu
 jfZn8cO/9GxqOyKHpuZswblWvkbGNgo04Vi1mkbrt0/1Hk5pEN7hz+CyGdzUg0zIW7I3p9dQCuw
 1se0GoqAyBcJkX5L06WXqLK33ghPU6IL5gnVBgy4K9vQ==
X-Received: by 2002:a17:907:3f1e:b0:c49:9383:a28 with SMTP id
 a640c23a62f3a-c4d34d1566dmr1027166b.35.1793894586394; Thu, 05 Nov 2026
 08:03:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022204223.854640-1-peter.maydell@linaro.org>
 <97a6d73ce1cca97a8de68bd7bc58b575e4026345.camel@wdc.com>
In-Reply-To: <97a6d73ce1cca97a8de68bd7bc58b575e4026345.camel@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 16:02:51 +0000
X-Gm-Features: AclHuK-byip71MFYd7RRO2Zo_NZPtyOELUmCfEM8onowyuomZKwtQnixH8hoPCU
Message-ID: <CAFEAcA8NTaF9JGkCfnuJDb4Ei65SStN+NcoG2gBNyEt=1C0QCg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/riscv_aplic: Check config value bounds in realize
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 03:07, Alistair Francis <Alistair.Francis@wdc.com> wrote:
>
> On Thu, 2026-10-22 at 21:42 +0100, Peter Maydell wrote:
> > The riscv aplic interrupt controller has various configurable
> > properties for things like num-harts and num-irqs, which have
> > architectural upper limits.
> >
> > Currently these are checked in riscv_aplic_create(), by assert().
> > QOM devices should check this kind of thing in their realize method,
> > and fail realize for out of range values (which in this case will
> > cause riscv_aplic_create() to make QEMU exit with an error, since it
> > uses &error_fatal).  This isn't a problem currently as no SoC creates
> > and configures the TYPE_RISCV_APLIC device itself, but it avoids one
> > for the future.
> >
> > Move the checks to the realize method. This requires slight
> > adjustments in some cases because:
> >  * property num-irqs is set to num_sources + 1
> >  * property iprio-mask is set to (1U << iprio_bits) - 1
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks; do you plan to queue this patch for 11.2 ?

-- PMM

