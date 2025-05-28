Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D788C5B543
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 14:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKHpe-0003Yo-IQ; Wed, 28 May 2025 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uKHpW-0003VQ-MR
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:32:32 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uKHpU-0000Jl-Qw
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:32:30 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60461fc88d7so6980330a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748442747; x=1749047547; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hlyxwwbkYDCgxjmtT+iaqRm3xTS+mo2sOBLrwaQWENM=;
 b=OUoyvI/SVIG2erU7sHFr4XYC4OVcxEc65d1xfuPB+mg7nbghBwHct2tDDGwIMZ+hpB
 jBpnBS4H9T2bI15l3wFpV7T8ia6dteLjSUQ5iJDYecPwbJspFmrULTGZA+yVSGfwfWtd
 VsnFEowP002YS95zJ2srOs8mWQYyCMe85QVrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442747; x=1749047547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hlyxwwbkYDCgxjmtT+iaqRm3xTS+mo2sOBLrwaQWENM=;
 b=du2qnK4Ba9yzEeBOvJ+4v1DcI22+NHfQCbI8L9KomoPho6YrpYY/ISqFjp1LhBdJW+
 DuOxTiD9N1T+zVOU7AnY4Iq/XDjZ1q7haI9mRDapI8XPDe2bk6CtNgFrlkttX4Vq6l+u
 MbLieXyfovvSx5190mtOBrEatOtB0x0gtjF8skWBoJiEI0VggRrORnNoZCIKSxymAV3P
 jN7DavJXt8Pslq7+P0Fs1rrOAOEkEBSSC3TuYYiHEc0N9+XOMYZ9PHK6EnJko/uPlGEj
 uJGNdIT0yWF6EeKqLHpcbJhXEXm6LUVHne/BMkUjExmbP8/AEDz8s8GwXka/rk8LZIMC
 /Orw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUlg/85CRxLYjobNLac0s+PoyMACr6S2lBTc9NM4+n5Kd6J0rp4GOywBseRtLVFTtrcsKEC5uWJBZ0@nongnu.org
X-Gm-Message-State: AOJu0Yxug21Q6e/tzmizKm7LhgU5fun/BYodd+btfnel85phtrbwYf9j
 zTi1lG4WqGFEq7Odb5OREaNcg0ccD2K0WCsFI0RsZqohemxFL/8GjZl+Gom9X28hrkoQ7VkZpK4
 5fAy0xAxRUAr9a6XjykvdpRu4Tr0d4dgypQ3TxuEL
X-Gm-Gg: ASbGnct7KRFPgPH3qRMpkv/moqoYOr7e/p9gdkucvVIUtMTIx03VyhnnMEZHKarlg/r
 E1lT/v4B+SGNUxTMHaFvyqQMpBjwC3JNfJr1EoC2xVa3J1/kxOaswhb7pbTNjmPnlTLXAnnHka1
 C0/TBUaOaBjjYK5/rnhf98NvTzrc+s06s=
X-Google-Smtp-Source: AGHT+IEtBjpnrCkR+rvCtZR6h+C3QvbbBMGUo5TaDKUa4mpvb0XZCv0UF7MPI/rYm2UicCE0F15hx9taUmJMhZelg7Y=
X-Received: by 2002:a05:6402:2685:b0:601:ff94:4a41 with SMTP id
 4fb4d7f45d1cf-6051c508081mr1848208a12.29.1748442746647; Wed, 28 May 2025
 07:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
In-Reply-To: <20250528142521.GW100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 15:32:12 +0100
X-Gm-Features: AX0GCFvcCHrPLCj_kfo01VmkqMM7E9fRLJsRanSmS7gq4al0pvRFhb8qpEpdfGQ
Message-ID: <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] passage: Define a standard for firmware data flow
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, Alexander Graf <agraf@csgraf.de>, 
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Fabio Estevam <festevam@gmail.com>, Harrison Mutai <harrison.mutai@arm.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Liya Huang <1425075683@qq.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=sjg@chromium.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Tom,

On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> >
> > This series adds a standard way of passing information between different
> > firmware phases. This already exists in U-Boot at a very basic level, in
> > the form of a bloblist containing an spl_handoff structure, but the intent
> > here is to define something useful across projects.
> >
> > The need for this is growing as firmware fragments into multiple binaries
> > each with its own purpose. Without any run-time connection, we must rely
> > on build-time settings which are brittle and painful to keep in sync.
> >
> > This feature is named 'standard passage' since the name is more unique
> > than many others that could be chosen, it is a passage in the sense that
> > information is flowing from one place to another and it is standard,
> > because that is what we want to create.
> >
> > The implementation is mostly a pointer to a bloblist in a register, with
> > an extra register to point to a devicetree, for more complex data. This
> > should cover all cases (small memory footprint as well as complex data
> > flow) and be easy enough to implement on all architectures.
> >
> > The emphasis is on enabling open communcation between binaries, not
> > enabling passage of secret, undocumented data, although this is possible
> > in a private environment.
> >
> > To try this out:
> >
> > $ ./scripts/build-qemu -a arm -rsx
> >
> > This will build and run QEMU for arm64 and you should see the standdard
> > passage working:
> >
> >    Core:  49 devices, 13 uclasses, devicetree: passage
> >
> > This series is available at u-boot-dm/pass-working
> >
> > Changes in v5:
> > - Add RFC for test script
>
> And this is why I question if you are working in good faith. I've
> rejected this countless times. I'm still rejecting it. Stop including
> it. Point at the version you could easily be maintaining in the contrib
> repository where you have write access and no one will be telling you to
> not do something. People would even review the patches since it would be
> against mainline.

I fully understand that you don't want the script and I'm only
including (as an RFC) so people can actually try this series out. I
didn't want to point to my tree as I thought that would annoy you. I
already went through why the contrib tree is not suitable for me.

Please just ignore that patch. I've marked it as rejected in patchwork
and if I send a v6, I'll drop it.

Regards,
Simon

