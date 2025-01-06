Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62788E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlZo-0002md-41; Mon, 06 Jan 2025 06:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUlZj-0002mM-Oz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:47:16 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUlZh-0005Pz-T0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:47:15 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e39779a268bso17493071276.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736164032; x=1736768832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIXk6jFp3F5dscXHuI+xJOw1sFcsYp8fS1Nyb/r9O6k=;
 b=NAdldwf83bLnxNw7AsMp4uf98+eVw6r/qJI3MuKCjYOG1j6XHYsZZT9XrK+Z+QLNLj
 4rDDeZZvtpV2o18jJDKAFq1LBxY3KfY3CPYb2zH/0FV60q7hqukYya3D5hm4PC+UXHhz
 Wfha2zh7RMTI2HZzq6FmnP/Ku77GWD22vjGs3osCmTcDShVz/AiE5UNPSsX5fFQDhkpf
 uYuj8ZRoGgRYnE6CNbIzOBmcnGE3pZcgEwrKAez34H46a9AUQWWe0A/07VN4VNUaAflV
 nWlHD4L8fHHgdk2y800FZfKYUqPF1Dj8ItsS4rvsrHZ28oQ6FjtdIp1VBq+lknXNEiqf
 pmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736164032; x=1736768832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIXk6jFp3F5dscXHuI+xJOw1sFcsYp8fS1Nyb/r9O6k=;
 b=Ro0IrvFBwQbAUnc6ThrORUunvkm+jVOSKWgvcWpZ6xRrSIo3V5BtQueyqhxEVGelQ4
 RW6QiJVU4r+vBSAkg5VxRX3r7oH2jUxxW86nCNizd1VMv3NyOHyDFR3Iuvcwq1n2sQJD
 q3ItpRljSmRw+qFCARhtxp4PZ2gGf9yx760FhjmBHE6jaWwKykSfTDzoHsiaDiUUiX5P
 mj9qtRQQM+mJPIGlwDshRPobPcdhvTk7wc8BPiSXOFo2yA/YpC/yYoA4kcxg6kenEnvj
 AKGkPOTfYtiVc64sqj/dKQYUuC3L+MeUAABA0eWqMv6EpDoc0+Z7tTqkp43oq14e0pbq
 IsMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzIxWE7SmjOc0/nlddZhFyPHYD6Lxbr/BbEMyXFojEP6PbGUSUeVXF/ULA8r7EIxlqOvt3UG/YtdSa@nongnu.org
X-Gm-Message-State: AOJu0Yz009/ZJX86skNYBEn5+NwcGJYcSBlUYdT37Y3uVZXcyZ6TK32T
 V0cWMxTkdgUSXq4vD0qHHX7wNUt8IivVFsyzDwBadO0hOSniPoq9+y9RBxDwUHnO2tVHc7caeQz
 x1D5ycElm4MZL/U9Ar82aoIDU2ACa4RJSf7z48A==
X-Gm-Gg: ASbGncsbDFQ1rutUlrWK90STgn9x5L7Tc0kxS5LkMJJL6vVGyh/LS1HmdVqEzCFZ2Xp
 gP9c1o0uE87dVr5Ce4Ln9k9eu4FrUQZQF6y7XALA=
X-Google-Smtp-Source: AGHT+IFx+KQEZKf9o2Jgq6xjb8qa4uuhbZE6Od36JKSK7c5iu3GooEkrtt4OHSzxHyk4rGz7Nb8gupGIs8tFYgAsK7Y=
X-Received: by 2002:a05:6902:200b:b0:e39:8992:57c8 with SMTP id
 3f1490d57ef6-e538ce70ea7mr38274744276.18.1736164032492; Mon, 06 Jan 2025
 03:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20241203094702.124748-1-abologna@redhat.com>
 <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
 <CAKmqyKMkN7z51MoAeOK-buDZjKeEV7AjzviyVcZ_AyMEJPgg0w@mail.gmail.com>
In-Reply-To: <CAKmqyKMkN7z51MoAeOK-buDZjKeEV7AjzviyVcZ_AyMEJPgg0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2025 11:47:00 +0000
Message-ID: <CAFEAcA97_XJNs=oZP2OUTsGdaEU0YD9_PFzucQO214+Vmo1mmQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,
 64} part of the same family
To: Alistair Francis <alistair23@gmail.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, David Abdurachmanov <davidlt@rivosinc.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Mon, 6 Jan 2025 at 01:29, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Jan 3, 2025 at 2:04=E2=80=AFAM Andrea Bolognani <abologna@redhat.=
com> wrote:
> >
> > On Tue, Dec 03, 2024 at 10:47:02AM +0100, Andrea Bolognani wrote:
> > > Currently the script won't generate a configuration file that
> > > sets up qemu-user-riscv32 on riscv64, likely under the
> > > assumption that 64-bit RISC-V machines can natively run 32-bit
> > > RISC-V code.
> > >
> > > However this functionality, while theoretically possible, in
> > > practice is missing from most commonly available RISC-V hardware
> > > and not enabled at the distro level. So qemu-user-riscv32 really
> > > is the only option to run riscv32 binaries on riscv64.
> > >
> > > Make riscv32 and riscv64 each its own family, so that the
> > > configuration file we need to make 32-on-64 userspace emulation
> > > work gets generated.
> > >
> > > Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> > > Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> > > Thanks: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> > > ---
> > >  scripts/qemu-binfmt-conf.sh | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > ping
> >
> > There are already two ACKs so I think we just need a maintainer to
> > pick this up.
>
> We didn't get an answer to the issue of a CPU supporting RV32 and yet
> the kernel still calls QEMU.
>
> I understand this allows things to work out of the box, but seems like
> a disservice to any hardware that does support RV32

There's the same thing on Arm too -- we don't set up qemu-user
aarch32 binfmt-misc on an aarch64 system because the host might
be able to natively execute the aarch32 binary. This is becoming
less true, but we still don't want to silently downgrade
native execution to emulation on the hosts where native execution
used to work.

I'm not sure the best approach here -- ideally we would want to
be able to register a binfmt-misc to the host kernel with "only use
this if you could not already natively execute it", but AFAIK that's
not possible.

-- PMM

