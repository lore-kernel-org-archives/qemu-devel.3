Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E20C4829E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 00:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ralqw-0000CQ-65; Thu, 15 Feb 2024 19:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ralqu-0000Bo-Lc; Thu, 15 Feb 2024 19:13:16 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ralqs-0007VD-MA; Thu, 15 Feb 2024 19:13:16 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7d6275d7d4dso673870241.2; 
 Thu, 15 Feb 2024 16:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708042393; x=1708647193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IgRNuQpDZUAOKdiYz5ZojhKKYKy4OUChSm3Z+UsCl0=;
 b=FIuALBfBsyvXM8l0CYLjxV/sJLYLpcUHpZEWs8ByTtkB27YDnVBKHDzKpmqvKmyNqg
 wjwPJ+DGest7lE1firpy5lPrTtFLVIEkiKqgFe/EhVcVzWbE8XIaOz5vklKfrppVDzNc
 jQpreFtt30keFRxSVZVdMp3NlhQx2mWRn0WpI1eCLzpY9v6gtq4usdpBepEMAuXH1ZBI
 6VCGJD8KURUaDcCmY95PzeY9ChUpNVQDpM7GYh5o/P4siYb/9E5aEsP5m62vZenLg6aO
 fk/+Ul7yvA0OKzrku7UKYqtBik0SEZZJ7sWvJx8bGIHsKdg0lp3GzIpqFMd6+KkUnpUT
 //Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708042393; x=1708647193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IgRNuQpDZUAOKdiYz5ZojhKKYKy4OUChSm3Z+UsCl0=;
 b=TMN2lIe4bNMdVFvTLenq6v8WRupviwyLTU1VkXjRDgIYy+2el+OugFngIMQg2Yrl0q
 fxbQ9xNbBocb5HzPceusq2HxwW6snKgJL2MXNuVFbNAs113FriijNcEksnL1bDcbRRqb
 ZRqB8QbkH/kmZY649X1I0sdwToMf1uA8Dn5Pw9ktigKxrINRWxQxPatIA63aJbiqFZ7k
 JizvBf8QlLdtFdbJrnzc4roZwamqOp0frq+zwVJqY32MCC3bSLukKvzYr791g4HU0CZ2
 VHrOmuD/zaFg4YORNMxH3uMNekQ9WXOdknMGFzt0aF3Q9GbyyrAulIhOC9eoF0W2UKwG
 7WTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1SHN7v91Uxt3KwNNfTj5dy1Boj6h8jt1+B3vvuEN0GYzCSQEgrP1DsL5mF4EuWHoUepj+mkEUGRutpR5wHY5npsYJLme6wvO2DV5O1/HNxOh7rWXtog3vjL1W1g==
X-Gm-Message-State: AOJu0YyHdg5DNIpnAoSRz32PQumQ2F0z7jxUFnD/VhM5sGXetTVUZsQ7
 wl5ZxWyjPk8+xbYVZylGNP6Sla4/Yd5+P38Bo+ntDvXZDxpZZ6t7h/fmIUWkkeX1XfM0xD4KK1w
 5duCqfa3ex6mczvNulsSeUyaiKur67yR/UTQ=
X-Google-Smtp-Source: AGHT+IFEcDB2dN0VniUKtrCcPHEk75+w2k4ZhU+IFh8rLrPRgwsYC9EhfjQTDS+6HRhQw0BSkBbz/CW0xqN2GDZfjHE=
X-Received: by 2002:a1f:6d82:0:b0:4c0:2553:3b19 with SMTP id
 i124-20020a1f6d82000000b004c025533b19mr3041805vkc.13.1708042392977; Thu, 15
 Feb 2024 16:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
 <20240215-alkaline-saturday-275cd8e3aa39@spud>
 <20240215-55440212b4d6cde9feab5d94@orel>
 <20240215-overhear-paycheck-8c70c17bd151@spud>
 <20240215-8e556e6029ee11ee7317db8b@orel>
 <20240215-landfall-clamp-34ce9760d4cd@spud>
In-Reply-To: <20240215-landfall-clamp-34ce9760d4cd@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Feb 2024 10:12:46 +1000
Message-ID: <CAKmqyKPy8C9fz2c7RMnFL1bG1XHZf9kdduGOjgTGP+O6PB_fSg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 6:00=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Feb 15, 2024 at 08:11:45PM +0100, Andrew Jones wrote:
> > On Thu, Feb 15, 2024 at 04:34:32PM +0000, Conor Dooley wrote:
> > > On Thu, Feb 15, 2024 at 03:26:18PM +0100, Andrew Jones wrote:
> > > > On Thu, Feb 15, 2024 at 01:33:47PM +0000, Conor Dooley wrote:
> > > > > On Fri, Feb 02, 2024 at 12:21:51PM -0300, Daniel Henrique Barboza=
 wrote:
> > > > > > The RVA22U64 and RVA22S64 profiles mandates certain extensions =
that,
> > > > > > until now, we were implying that they were available.
> > > > > >
> > > > > > We can't do this anymore since named features also has a riscv,=
isa
> > > > > > entry. Let's add them to riscv_cpu_named_features[].
> > > > > >
> > > > > > Instead of adding one bool for each named feature that we'll al=
ways
> > > > > > implement, i.e. can't be turned off, add a 'ext_always_enabled'=
 bool in
> > > > > > cpu->cfg. This bool will be set to 'true' in TCG accel init, an=
d all
> > > > > > named features will point to it. This also means that KVM won't=
 see
> > > > > > these features as always enable, which is our intention.
> > > > > >
> > > > > > If any accelerator adds support to disable one of these feature=
s, we'll
> > > > > > have to promote them to regular extensions and allow users to d=
isable it
> > > > > > via command line.
> > > > > >
> > > > > > After this patch, here's the riscv,isa from a buildroot using t=
he
> > > > > > 'rva22s64' CPU:
> > > > >
> > > > > Why does an "rva22s64" cpu have "zicclsm" in it? Isn't zicclsm on=
ly
> > > > > present in "u" profiles?
> > > >
> > > > "s" profiles mandate all the "u" profile mandatory extensions. For =
example
> > > > 6.2.2 says
> > > >
> > > > """
> > > > The RVA22S64 mandatory unprivileged extensions include all the mand=
atory unprivileged
> > > > extensions in RVA22U64.
> > > > """
> > >
> > > Doesn't that rule out emulating misaligned access in s-mode if you wa=
nt
> > > to be profile compliant?
> >
> > That's how I interpret it, but I'll defer to a profile spec author, or
> > at least to somebody more confident of their spec interpretation skills=
.
>
> Hmm, actually it doesn't. Your firmware just needs to _also_ implement
> it. So your OS kernel could test whether or not the misaligned access
> performance is beans and then choose to emulate misaligned access
> itself. Not ideal, but better than I thought.
>
> > > > > >  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> > > > > > rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_=
ziccrse_
> > > > > > zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_z=
ba_zbb_
> > > > > > zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpb=
mt#
> > > > >
> > > > > I want to raise my frustration with the crock we've been given he=
re by
> > > > > RVI. Any "named feature" that just creates a name for something t=
hat
> > > > > already is assumed is completely useless, and DT property that is=
 used
> > > > > to communicate it's presence cannot be used - instead the propert=
y needs
> > > > > to be inverted - indicating the absence of that named feature.
> > > > >
> > > > > Without the inversion, software that parses "riscv,isa" cannot ma=
ke any
> > > > > determination based on the absence of the property - it could be =
parsing
> > > > > an old DT that does not have the property or it could be parsing =
the DT
> > > > > of a system that does not support the extension.
> > > >
> > > > I'm guessing any platform which wants to advertise that it's compli=
ant
> > > > with a profile will update its hardware descriptions to ensure all =
the
> > > > profile's mandatory extensions are presented. But, I think I unders=
tand
> > > > your concern. If somebody is parsing the ISA string as way to deter=
mine
> > > > if the platform is compliant with a profile, then they may get a fa=
lse
> > > > negative due to the ISA string missing a newly named feature.
> > >
> > > Nah, you misunderstand me. I don't care at all about profiles or
> > > checking for compliance with one. I'm only interested in how my softw=
are
> > > can check that some feature is (or is not) supported. This creating a=
 name
> > > for something implicit business is not a problem in and of itself, bu=
t
> > > putting then into "riscv,isa" is a pointless activity as it communica=
tes
> > > nothing.
> > >
> > > > I'm not
> > > > sure how much of a problem that will be in practice, though, since =
testing
> > > > for profile compliance, just for the sake of it, doesn't seem very =
useful.
> > > > Software really only needs to know which extensions are available a=
nd if
> > > > it's an old feature that got newly named, then software likely alre=
ady
> > > > has another way of detecting it.
> > >
> > > Right. That part is fine, but creating extensions for these things we
> > > previously assumed present gives me the impression that creating syst=
ems
> > > that do not support these features is valid. IFF that does happen,
> > > removing the string from "riscv,isa" isn't going to be able to
> > > communicate that the feature is unsupported.
> >
> > Ah, now I think I understand the concern. The new names might as well b=
e
> > ignored because the absence of the names in the hardware descriptions i=
s
> > ambiguous.
>
> Correct.
>
> > I guess I'd encourage software that has a role in advertising
> > features to use the new names when it has detected the feature or assum=
es
> > the feature is present (and presumably wouldn't be running if its
> > assumption was wrong). If, for example, Linux puts a new name in
> > /proc/cpuinfo after detecting or assuming the feature's presence, then =
it
> > no longer matters that the hardware description had it or not from the
> > perspective of the /proc/cpuinfo consumer (assuming they're aware of wh=
ich
> > kernel version they need). With these types of fixups and enough time,
> > then hopefully most of the software ecosystem will able to live in
> > ignorant bliss.
>
> Yeah, that's effectively what we have to do. I started doing that for
> zifencei/zicsr in Linux and it should be done for anything else like
> this going forwards.
>
> > > The commit message here
> > > says:
> > > > > > If any accelerator adds support to disable one of these feature=
s, we'll
> > > > > > have to promote them to regular extensions and allow users to d=
isable it
> > > > > > via command line.
> > >
> > > Which is part of what prompted me here, since they cannot be handled =
in
> > > the same way that "regular extensions" are.
> > >
> >
> > From QEMU's perspective, they can.
>
> No they can't. For a "regular extension" you populate the DT with the
> extension. For these extensions it has to put negated properties in the
> DT, otherwise it is incorrectly describing the hardware it is emulating.
> That is handling them differently in my book! If QEMU generates an
> incorrect DT representation of the hardware it is emulating, that's a
> QEMU bug.

QEMU listing the extensions that it supports seems to me to be the
correct approach.

It's clunky that the list of "extensions" are constantly changing.
There isn't much we can do about that from a QEMU perspective though.

Listing the hardware and what it supports is the job of the DT.

I see your concern about what happens if the "extensions" are disabled
though. Realislity they probably never will be.

>
> > Linux or whatever software consuming
> > the hardware descriptions may want to distrust the absence of newly
> > named feature extensions and do their own checks, but that's not QEMU's
> > concern.
>
> Software should be able to trust that the DT describes the system
> correctly. I can only speak for Linux here, but validating the DT is not
> the job of the running kernel - it should be a correct description.

AFAIK the DT is correct. We are describing the hardware within the
scope of the DT spec.

If a new node exists that describes what the hardware does not support
we can update to support that as well.

>
> > Actually, being able to disable these newly named features allows
> > Linux and other software to test how they behave when the feature goes
> > away.
>
> That's helpful sure, but it doesn't absolve QEMU of having to correctly
> generate a DT.

I'm pretty sure there isn't anything for us to do differently here
right? It's just a bad situation that we are trying to support.

Alistair

>
> Thanks,
> Conor.

