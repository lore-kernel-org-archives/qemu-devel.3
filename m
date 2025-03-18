Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E812C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWNA-0006As-Dv; Tue, 18 Mar 2025 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuWMZ-0005J3-7r
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:48:07 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuWMV-0003jH-Jj
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:48:06 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e643f235a34so1000089276.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742302081; x=1742906881; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8slg3rOHyYBzQ/7Yb912beQ4u4EfQcKUFPIw0EirfLs=;
 b=zlrMrKsmoQnySdkHLVyFswf/VFTBFoT6Jx7saQjFNUP2l2Yves/BOXhepQbJ1+g1ur
 21XXRaPSyD90MUWs4aDTiSMF9XvN14E69sSV7GrsycXb1eAyaJuHwecqvZdTRaX/d0J/
 b/42LfN7Jp7Qqa9RYHgxwSXY1CfQbSciG+neqp3Yp9F1yju3dgbRVHzgbKPa8ilE2wS9
 NpMlgPw/GoacxeIp6vn08NOR4A+aipoCqTWekrCstDRy+DdOY7Y7DXMx1zdBcOCLanZq
 i2TqAUEXdu5mp+delLLMps+iksQVt3QUlEV/MkyEsAKkvhavPZg+sJjgtud59qvgaMzr
 zjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742302081; x=1742906881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8slg3rOHyYBzQ/7Yb912beQ4u4EfQcKUFPIw0EirfLs=;
 b=sbo0R2bkWNeOZ76fZXuW6MsmAezMQuNzGikXg+U2gOZFDuAeMbGHY1yde1Wvtyby8e
 fOHRrclTefP7QCz17u50Au3U9zPukrkwrxkXl1THnQcALh0+S0a+Taw7WYadYcylX/b+
 Lc4obr8/lapSISFkBWenidzyU43Q50nrZrVuc9xJMyueC+ZAFqTDTLsAof+hP3si+UGz
 oJmBOaqtd9ZxQ+/C7dgo5YH45aOgibRla9u2Nsxyjfzo5tr3q5NEd0osfTjBXw+tuBrx
 mmMWWlhVRcHDC+/DzMyTe5m6g6apvQ9c4ZsFBm4ka//dlneGRWVKSCCgWTi61P5iMb2c
 34fA==
X-Gm-Message-State: AOJu0YzToyOh0kGTEiEpB54jOtvHzGD5LzlXvkLWO85MKvdhFuEnn0os
 52z5lv7XZ5IE+uHbPvf1viGN8xI3mE466it6NJcN3IDmqSMc1ylxbbzH2qcCbN5k9D/e35mm2vP
 KEnVt3F7EatyAXKsA1mz4EmX6tro1FaJnn7cptg==
X-Gm-Gg: ASbGncvswx5ewMSnCaPsSd481k00sns+u06oEsahafTzJi07ugM9GdyrgH2vyEy3V+2
 2c8qMimht8RYkvmFbDfWT4HdB57Q5Mk9bRyQb3zkWzvQoGgudZIxpRRfsMW3oM5X6tOVVLG8tbg
 M9qgA+sHUkdjj8mMOJg4zeoRXnfuA=
X-Google-Smtp-Source: AGHT+IEQwuhuln8+CACHXRg23nE9E4Ir3EzobpQ+E8vKgc3O8ZXsfqoDMfvU4WLRzflGkyV5v0UK1wwFgXnbwrFjNqI=
X-Received: by 2002:a05:6902:2d41:b0:e64:60c:54ce with SMTP id
 3f1490d57ef6-e64060c55fcmr11870366276.2.1742302081114; Tue, 18 Mar 2025
 05:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
 <CAFEAcA9Cy_870gxNmPFykzTjXOfi0raotmA1NRpZEQKfFfB=0g@mail.gmail.com>
In-Reply-To: <CAFEAcA9Cy_870gxNmPFykzTjXOfi0raotmA1NRpZEQKfFfB=0g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 12:47:49 +0000
X-Gm-Features: AQ5f1JotXtyRSF-yg8G2NNirSk_YOR4QVWN85v7N2eTx2d23zF47r3yjGjF1iRw
Message-ID: <CAFEAcA_DzikGAsKC=zMc7OVcinTj3PnO+3WACGOQxwpTHKzSCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/arm: Flag PMCNTENCLR with ARM_CP_NO_RAW
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 17 Mar 2025 at 11:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 17 Mar 2025 at 11:16, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > Supersedes: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
> > ("[PATCH v2] target/arm: Define raw write for PMU CLR registers")
> >
> > A normal write to PMCNTENCLR clears written bits so it is not
> > appropriate for writing a raw value. This kind of situation is usually
> > handled by setting a raw write function, but flag the register with
> > ARM_CP_NO_RAW instead to workaround a problem with KVM.
>
> I'm not sure there's a "problem with KVM" here -- it implements the
> write to PMCNTENCLR to have the semantics the architecture specifies.

I checked with the KVM developers on this one, and you are correct
that this is a KVM issue, so I was wrong here; sorry about that.
There is a fix queued:

https://web.git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?h=next&id=f2aeb7bbd5745fbcf7f0769e29a184e24924b9a9

which will restore the "just writes the value" semantics. This
is apparently the intended semantics for KVM_SET_ONE_REG for
all cases: the write is supposed to do "sets register to the
specified value", not "behaves as if the guest vCPU had done
the register write insn, with attendant side effects".

thanks
-- PMM

