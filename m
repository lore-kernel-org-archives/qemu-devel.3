Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2788CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rskDL-000720-Uk; Fri, 05 Apr 2024 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskDE-00071Q-Bg
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:06:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskDC-0008Od-QC
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:06:36 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso3208217a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712325993; x=1712930793; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wHGOW1wgnR+5ZgnC3ijf1kTcTTOtgDyd8J10Q0czdfc=;
 b=F+aOOMuocmjWxyHMo6W1GyF6YavrWF7M5H+Il+p/Dmk83/lxv2wGBERXwtHyGcoQbj
 w7zExWTiM4kVNoJ2qzZAN9tlo3QFUjTnc33Hfsgy5VSD9sc/3F2r4sWlIo4pUelfz3xM
 tqss8ODP5eAubxHw5DVGJjD81gl481mzxMlIeqmzUCjurRnNiZXqhm1hLyDYr1jny17l
 GzcF0d5Tma7/cLkNDJyU171X8NEeHQ5SDgB0pv/ufjqR/eux7LffSj/j+T0wiFOz+FEB
 Y+tpVkVge/Ca32mky/nJWj9OmfDWNGttpVS9hen7AZN2TyvZCcnXHV9Lj8UbfNGK7IIw
 AmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712325993; x=1712930793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wHGOW1wgnR+5ZgnC3ijf1kTcTTOtgDyd8J10Q0czdfc=;
 b=QuZSP/TtoVwj78ERmXfiBiGYHf6AKdhsq0K9sRQfn7MP5wseeBlngKQCxym6rhmlRh
 hjuUW4XRMXr+IVIgbD2Iu2P4SuDSHqQ/DyrUn8wcga7cF12YUCsjO0323ACF/3kAhWkr
 zsCE92O/wxBa5+jb8j++gD8OpQwgmEvlfMv0b2UGBTLwnXJUKZK5poD6YEFjQOjDnl/e
 mwjGtMu5gfW6V4BnqDutWLchzSv/PeF+c/gvyfMsgowZpAK4lc6Qr/t+DCNpDiirDOOj
 Fi/U0CruA3+9IyHu+EE69vF1zAU2SqfpLAv/0CGiVyS7uF+Ltp8iVilyDWblgAOUWep5
 +CaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqt+XPi7P5nhCkTcVKW+zoBRP2N2c6HVATQQom0sWnEAhvavZGk7nfERDvufdbGDsQo2YDl7x9ZSlDIda/Pj/8l9+EA8M=
X-Gm-Message-State: AOJu0Yw9LLCmho5YX+AG1x6QMChwWlH9ELX5Ej4cZ6Lb6ey4zIE7VDq8
 xtuq+2tMVXfn8gKhUd646lWniFhjUeEvySlo5YGY2YFusnstiv4PXzHJw6sGNKtU6s3z1P3wG7c
 ejHHqZ/UNXdRbSx0ReFT6uqyJL0k+GVm590gzCw==
X-Google-Smtp-Source: AGHT+IF7VokbM61rjklmRIAl+HBwVt1EteKRmceAx6kZPaqRrINdRAvscgfI3DYDuHo7fV9A7Fx09YQku3fUF3xh8JA=
X-Received: by 2002:a50:bb48:0:b0:56c:4f5:7227 with SMTP id
 y66-20020a50bb48000000b0056c04f57227mr1018226ede.41.1712325992905; Fri, 05
 Apr 2024 07:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-1-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2024 15:06:21 +0100
Message-ID: <CAFEAcA8=qJ763Q5UH5DvL=Wo4zhxvG0kO0VR77d5soYzDHsP=g@mail.gmail.com>
Subject: Re: [PATCH v12 00/23] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This patch set implements FEAT_NMI and FEAT_GICv3_NMI for ARMv8. These
> introduce support for a new category of interrupts in the architecture
> which we can use to provide NMI like functionality.

I think I'm now done with review on this series, so if you
address the last handful of things I pointed out in replies
to this series, I think v13 should be good to go in.
(No rush, as 9.0 won't be out for another couple of weeks
anyway and I won't start collecting up patches for 9.1
much before that.)

thanks
-- PMM

