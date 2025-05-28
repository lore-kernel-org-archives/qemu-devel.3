Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFD8C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJKr-0003BH-Qt; Wed, 28 May 2025 12:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uKJKp-0003B6-Fs
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:08:55 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1uKJKm-0002aq-V9
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:08:55 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-604e2a2f200so5339621a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748448530; x=1749053330; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G09kR4unYSd9E6kTmOjGfizXBhTtP2c6s2m/AZv8wQU=;
 b=Ku2gwu4bqBZxbYbLNhpYx0yeGslva9TXEgs8teWIy4E0RDSn4xy+2zT10RghfByg5X
 76uAz9+G1XaS/EhEiFNQBvRSVuDjxLnQMRwlpXwsbSDEvfmvR7ErMKnVRoWUhqjYF9XS
 Hfr4gy64CokQEIkmVzFNCWJkkMlglG1qBPsGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748448530; x=1749053330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G09kR4unYSd9E6kTmOjGfizXBhTtP2c6s2m/AZv8wQU=;
 b=E5TJvAlE37BF7hXJXjNiUW2Ow9HyqJthGEiADEXFKEVhWSHkphteJaO02vKyEx+Ou9
 nbZB4d/y9ZwTs8XFNbeS6Rv3r8Wpf/LGZrqRuLI3kqBeSRU6epbD5h2EcSAAUPjoifsR
 lS8Xx1N4S2nZIxBvrT19EcQ7wqXDkmF3vlcwGoXojpuXgKNPKV3XtFU9lz8P2bFO1IK2
 ogSUL1zGl4BTqU6CirOSY4go8LXEJellImtsdiCga6zPTfYViHgyW7SjAWCSBiK8bPDL
 6/taCxdAaMr+2r6lLYpxgWY2Fn7pWYqza/C/oOz3THXtCTRKUCGAs38z73uJ8SOZQNAQ
 8v+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdWkfWMnT36MUx2C1R1xMt5svVbplqLFzxiFXDUQz9WNBJn/A4Za7yRUCvndZ6Yh+/LnNplExztK7J@nongnu.org
X-Gm-Message-State: AOJu0Yy+YsmyJgZ2QK55LvhJlZBh3VH+a0C8KRcyEg5g917tIlwk3ei3
 xhBjgZAl93HxsqOOL+aZts6HBFU4gWIi1PYTebF2TljhfvWIb5KL8w9x1bHpOAbABfBp9eQ3lDW
 QoRxTIav1BSNldfd/wDIT//XvOe7C/Mm9gWb9tldN
X-Gm-Gg: ASbGnctTCX5/3khe9vF4ccUUUmV62A8R2V60+q57VWU72s5X6ymHl3sWkD1ntf7cjjf
 Eua8lrij/8qwYuc4ULqWemzF46IAiKv46F+Uy04kXzuyvlBpQiAAprd1jYh+4ejuHQolh3/9gP8
 Zjno8eIovVN87Jo8WHtiWy5jns5elbkUg=
X-Google-Smtp-Source: AGHT+IGIBXiR5qr0ODdDrcBuyL/J03Zu1vZeE59hlz1XpZDKPy6PY+sa/D4jNneqgjahfi7lqAc3apYN1I/iTVuyA6k=
X-Received: by 2002:a05:6402:358f:b0:5ff:f524:90e0 with SMTP id
 4fb4d7f45d1cf-602d9163253mr13905547a12.11.1748448530103; Wed, 28 May 2025
 09:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
 <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
 <20250528151927.GB100073@bill-the-cat>
In-Reply-To: <20250528151927.GB100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 17:08:38 +0100
X-Gm-Features: AX0GCFsc-ZYsE2R_mTjr2KvvoIFxZ5wHHChatx1sp4dLogIlpo9HVlDXoOb-BwE
Message-ID: <CAFLszTh3WDhn_ZSRsBMTpD8i5AyNLFGiV0cbPhOfCUAud1_WOg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=sjg@chromium.org; helo=mail-ed1-x52c.google.com
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

On Wed, 28 May 2025 at 16:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 28, 2025 at 03:32:12PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> > > >
> > > > This series adds a standard way of passing information between different
> > > > firmware phases. This already exists in U-Boot at a very basic level, in
> > > > the form of a bloblist containing an spl_handoff structure, but the intent
> > > > here is to define something useful across projects.
> > > >
> > > > The need for this is growing as firmware fragments into multiple binaries
> > > > each with its own purpose. Without any run-time connection, we must rely
> > > > on build-time settings which are brittle and painful to keep in sync.
> > > >
> > > > This feature is named 'standard passage' since the name is more unique
> > > > than many others that could be chosen, it is a passage in the sense that
> > > > information is flowing from one place to another and it is standard,
> > > > because that is what we want to create.
> > > >
> > > > The implementation is mostly a pointer to a bloblist in a register, with
> > > > an extra register to point to a devicetree, for more complex data. This
> > > > should cover all cases (small memory footprint as well as complex data
> > > > flow) and be easy enough to implement on all architectures.
> > > >
> > > > The emphasis is on enabling open communcation between binaries, not
> > > > enabling passage of secret, undocumented data, although this is possible
> > > > in a private environment.
> > > >
> > > > To try this out:
> > > >
> > > > $ ./scripts/build-qemu -a arm -rsx
> > > >
> > > > This will build and run QEMU for arm64 and you should see the standdard
> > > > passage working:
> > > >
> > > >    Core:  49 devices, 13 uclasses, devicetree: passage
> > > >
> > > > This series is available at u-boot-dm/pass-working
> > > >
> > > > Changes in v5:
> > > > - Add RFC for test script
> > >
> > > And this is why I question if you are working in good faith. I've
> > > rejected this countless times. I'm still rejecting it. Stop including
> > > it. Point at the version you could easily be maintaining in the contrib
> > > repository where you have write access and no one will be telling you to
> > > not do something. People would even review the patches since it would be
> > > against mainline.
> >
> > I fully understand that you don't want the script and I'm only
> > including (as an RFC) so people can actually try this series out. I
> > didn't want to point to my tree as I thought that would annoy you. I
> > already went through why the contrib tree is not suitable for me.
>
> So I have to take changes that I disagree with, but you can't work with
> a tree for your tooling where the community would be happy to provide
> feedback? That does not sound like compromise. Again, I have trouble
> believing that you are working in good faith to resolve the differences
> here.

Yes, as mentioned before I would like you to take changes you disagree
with, at least once we have discussed alternatives and I'm sure that's
the way I want to go. It would save a lot of grief if you could do
that.

I could use your contrib/ repo but there isn't a lot of point, since I
have to have my own tree anyway, due to rejected / changes-requested
patches. It's just lots of fiddling around for no gain. I'm fine with
your not having the scripts in your tree and I'm fine with maintaining
the Python tools in my tree. Basically it seems my tree is the dumping
ground for the stuff you don't want in 'pure U-Boot', or don't want
yet. If you would like me to sync my scripts to the contrib/ tree
every now and then, yes I can do that. I don't see much point since we
can't reference them in docs or test them in CI, but I'm willing to do
it.

But I do want to post patches so I can get feedback from people who
are interested. Perhaps we could set up an 'experimental' mailing list
for that, since you seem really unhappy when I send them to the U-Boot
mailing list?

Re your 'good faith' thing, I'm really just trying to make progress
and I wish there was less 'email overhead' and more action. If you
have concerns, it would be better to discuss a resolution f2f or on a
VC, not endless email threads which don't relate to the patches I'm
sending. The series we are discussing here was sent in 2021 based on
bloblist from 2018! [1]. It is why Firmware Handoff happened. Give me
some credit for foresight, at least.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/cover/20211101011734.1614781-1-sjg@chromium.org/

