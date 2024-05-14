Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD31C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6vOv-0007dc-2a; Tue, 14 May 2024 12:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1s6vOl-0007ZO-7d
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:53:07 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@atishpatra.org>)
 id 1s6vOj-0002UH-GG
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:53:06 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51ef64d051bso6833069e87.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atishpatra.org; s=google; t=1715705582; x=1716310382; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Gv2b3TU8zPjY3OZoVr5HBCcC6uCtFh6xvKQvXxm6Nc=;
 b=Bzrp9lUAqmGehWiaWdDxoE0/kX+ra8ficHrRcSuy3U98sgo84BtV/6gNw9V9Cu8Mp2
 p/YaHOJ+jhxs1efjiqlZHnF5FXxZ9NJSMGVaIWSoWWIc+udB6gm7Axgyrc72sMjc8LB5
 TMYizZkW1KHH48FLCkKQh0LKMedXmokwWxIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715705582; x=1716310382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Gv2b3TU8zPjY3OZoVr5HBCcC6uCtFh6xvKQvXxm6Nc=;
 b=U1FCREQq21p5r+olLgea/8jxlS4UgS6m1mSQdhVJmOmj6YC1bLiHKphWpO70D4ktSY
 L+o43r06k5sEi7gj1X1ECBpM1N/Tg93JRsSkFTez4JgUdVzXc8QR9VQFRRAS6oJp/fwu
 l3gWBifPasx2BureICit5ghOvhb2qAbZl1BwEV33fk4XHUy/v0ZLqXwjnzu70/0pZjaT
 /rHQxo4ycF4R/wpJJjMj/tPpO+OzgoAgY6c380NSODMihtobHUy9+K7/7aGHJeihB7wy
 413jjzHseKijxjd1NO4midKwZmFiydLec/f8YOdn5RwfoNhp+CMB+DetNriaupx+Cbzj
 SFOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkhHX4Z57pgv3EMf4KQE9JFDd8HSq8a/0j030N7YUKUzo8N/KtzljaBathi3RO16Z7gBl+cbeYhsJin5rtmK2GaBwzeUY=
X-Gm-Message-State: AOJu0YyHuvxKjRAAPD4nlpuZUStsIwkvDEwC2bB1qYd3m+63Cfcql2yq
 ZDzNqYDcJaqAPrdjm5P997V8R17qcbKh9MiKYcPINE+9dKiXk0baIz4vS7mIOAo/4mQKhWn5eJe
 DSA/7RoeVdvja98/jF1Oyj0WOnE5+t1qm9Le0
X-Google-Smtp-Source: AGHT+IF9agKfrfJtbLfEbyyGBnkzwOzSfCc9XuvnaQqgU4uaq0jSrb0qCpA58gl17M5eZdY0K/wRolgwjlTwoULRnus=
X-Received: by 2002:a05:6512:3d1e:b0:51e:b5b6:29fb with SMTP id
 2adb3069b0e04-5220fb6b0f8mr12866683e87.21.1715705582622; Tue, 14 May 2024
 09:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <CAFEAcA_33s35DmdEQ=+O_kSodgEUg=R49n+iXOqEcmgY4Ng_8w@mail.gmail.com>
In-Reply-To: <CAFEAcA_33s35DmdEQ=+O_kSodgEUg=R49n+iXOqEcmgY4Ng_8w@mail.gmail.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Tue, 14 May 2024 09:52:51 -0700
Message-ID: <CAOnJCULyZTWV=v9P_BvL0z5HYFB4aK2npaUJrtGsfV0Jc=6rWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Assorted fixes for PMU
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=atishp@atishpatra.org; helo=mail-lf1-x135.google.com
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

On Tue, May 14, 2024 at 2:16=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 29 Apr 2024 at 20:29, Atish Patra <atishp@rivosinc.com> wrote:
> >
> > This series contains few miscallenous fixes related to hpmcounters
> > and related code. The first patch fixes an issue with cycle/instret
> > counters overcouting while the remaining two are more for specification
> > compliance.
>
> I've noticed a number of riscv patchsets from various people
> recently where the subject line for the cover letter doesn't
> include any indication that it's a riscv related patchset.
> For instance this one is just "Assorted fixes for PMU", which
> could easily be an Arm PMU series. Could you all try to make sure
> that cover letter subject lines indicate the architecture or
> other subcomponent they affect, please? This helps people who
> are skimming over the mailing list looking for patches relevant
> to them.
>

Makes sense. I will include RISC-V in the series cover letter as well.
Thanks for the feedback.

> thanks
> -- PMM
>


--=20
Regards,
Atish

