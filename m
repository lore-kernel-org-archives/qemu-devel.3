Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58177C28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 13:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttS1Z-0007Nf-BK; Sat, 15 Mar 2025 09:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1ttS1Y-0007NR-64
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 09:58:00 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1ttS1V-0000ZM-3v
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 09:57:59 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-476964b2c1dso20587271cf.3
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742047076; x=1742651876; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CetDGquJ9vowBIgxC5JgUjvLrt/FK701CaePESKC1Ks=;
 b=fmqmGYgHNIB5oAAHXoNVZpc642KlLWhYMNtQ58+fOF+ExUWFriCxPhaWoa9yQgbGNs
 Abu9DMxC4uawuSxv42L+Gz/GeECSiobHmM2zaa1vm29vsRElohk35Ts5LY1ZSnNBckgo
 GoPFWq0Cvm0ZZOBFZAEor1q+4DPFXpGGPycYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742047076; x=1742651876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CetDGquJ9vowBIgxC5JgUjvLrt/FK701CaePESKC1Ks=;
 b=qdxKDtoKkg5CZSur+2DOemDrh5Avz70cu6B2Fpppx3XXAkM3OXjIo/EPntJK+/krzb
 x/lO5r/ZFagujD7rPy3hDuNz5qUaQ4UaFlMZQ4/d+UdMq5T4Ulsre2rIGQdVnDD819Gp
 Zf3x9j2csFpn0QtJePNfCqPtqgqKYOv+YjSDm7NueGPxyvW8uPQDGKbUWv1bmhyMEuIc
 h4EDSeWRRkyNFrDkww2PFF9uxSNiQ03wngVNIGhKF3LkasI39z+FodeBdtxtQIVhNt7K
 woT9XAgJKi0q/5uh+/aHyQ5OYdDEO7ceVveM1PmrkJax7LVIq3mXO211XUw98BieD/s2
 GiFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaG73FsUMU0T7qYZDjYwSXJbDTHwDXJeGHROO5uPDn0ZDJ0dSG9fVP/hZC50fVL/bX0b6PZYVV4J0v@nongnu.org
X-Gm-Message-State: AOJu0YyZJAk0Zpt990i81cREV/IbsYYiSKeb3tnEhCI5X8qigj0btlMD
 8i3UWRXNokQKd9HuXUcxd3BbLXR6kfCF7mmV+Rh+bbEWtPMTb5BNZofUGvIa5X8=
X-Gm-Gg: ASbGncvrqUgqN5xJ0gdgLOpIHWSl9vqNgagzbAdZ4kmvyK47iV/jDwJE4PLZ7XJDtUn
 d+3H7LXPiV0axRt+c3uJDr9OHoygYaVE6wjfrsh6EkQfFMho/22k36uTApLsH5zX2WM7LSuzPCN
 TnLT7q3TIVOrP6nbD0DqQYreIR3KD74dJl+YeiO0NLIOji3kaR9T7ck/gN7FTXJXy0gHYitepoz
 ARxaDTCP6+1v/h92TPUezElEOvESVmsc00G3zWE07lqB4dopH0KQ1ODtKNv6PmgwunMeHBO06P5
 9/D/joXilw4xDmFjliy4HBphgBhCuEkJqG7DVc+yyaW6xw==
X-Google-Smtp-Source: AGHT+IEcFfVHis7jcwe28FL8LSbnaqGDNdTJd8NalM/dgedLnqZMfQUDdWPlaZ+1PuC/96ZDIIQTdw==
X-Received: by 2002:a05:622a:438a:b0:476:6a3d:de44 with SMTP id
 d75a77b69052e-476c813f216mr72441371cf.18.1742047075913; 
 Sat, 15 Mar 2025 06:57:55 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb85d68csm34564101cf.81.2025.03.15.06.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 06:57:55 -0700 (PDT)
Date: Sat, 15 Mar 2025 07:57:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
Message-ID: <20250315135749.GI2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
 <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jhlRjx2apgIVsQIc"
Content-Disposition: inline
In-Reply-To: <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=trini@konsulko.com; helo=mail-qt1-x82e.google.com
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


--jhlRjx2apgIVsQIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 12:54:25PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > > >
> > > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 =
but it
> > > > > is not perfect.
> > > > >
> > > > > With both builds, executing the VESA ROM causes an intermittent h=
ang, at
> > > > > least on some AMD CPUs.
> > > > >
> > > > > With qemu-x86_64 kvm cannot be used since the move to long mode (=
64-bit)
> > > > > is done in a way that works on real hardware but not with QEMU. T=
his
> > > > > means that performance is 4-5x slower than it could be, at least =
on my
> > > > > CPU.
> > > > >
> > > > > We can work around the first problem by using Bochs, which is any=
way a
> > > > > better choice than VESA for QEMU. The second can be addressed by =
using
> > > > > the same descriptor across the jump to long mode.
> > > > >
> > > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > > > >
> > > > > In v3 some e820 patches are included to make booting reliable and=
 avoid
> > > > > ACPI tables being dropped. Also, several MTTR problems are addres=
sed, to
> > > > > support memory sizes above 4GB reliably.
> > > >
> > > > Do you plan to rebase the prerequisite series' this requires so tha=
t it
> > > > can be merged?
> > >
> > > Here's my understanding of where things are:
> > >
> > > 1. You rejected the membuf series and my replies to try to resolve
> > > that haven't gone anywhere yet. So your tree doesn't have any tests
> > > for that code and still has the old naming.
> >
> > https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
> > gratuitous summary of why the series as it stands is a step in the wrong
> > direction. Tests are good. They're not a reason to pull an otherwise bad
> > series. This series should be rebased to not depend on that series. The
> > tests from the other series should be split out.
>=20
> It's not a bad series, unfortunately. I replied with my own comments
> and I stand by them.
>=20
> I don't mind if you want to drop the #ifdef (which shows how a flag
> could be used and the code-size impact). But other than that, I am
> firm on this for now. I've already applied it to my tree and a membuf
> implementation with tests and without a power-of-two limitation is
> important for my current work on distros and expo.

Well, you need to rebase this series without that then as I'm not going
to take something another long time project contributor said was wrong
and offered lots of constructive feedback on.

> > > 2. I sent the first part of the PXE series so you could apply that.
> >
> > Yes, I should be applying that next week.
> >
> > > 3. You rejected the second part of this series because it didn't
> > > include support for lwip without cmdline. I offered to handle that
> > > case later but I'm pretty sure you rejected that too.
> >
> > That's not how I would characterize it, no. I said you should probably
> > focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
> > do the net_loop-alike thing, since he's one of the network custodians
> > and the lwip person. I was trying to direct you to where your efforts
> > might be most useful but if you insist on instead doing the
> > net_loop-alike part and Jerome ack's it, that's fine.
>=20
> As you know there have been many arguments from the EFI guys about
> sandbox and you have already rejected my sandbox-focussed EFI-memory
> series for your tree. If I were actually a guru, that wouldn't have
> happened.
>=20
> I see that Jerome has created some tests, which is good.
>=20
> So really, you should consider applying the full PXE series so that
> Jerome can build on that and add support for non-CMDLINE PXE in lwip
> in a way that you would like.

I saw that Jerome posted sandbox for lwip as well and was pleased. You
can pickup whatever is left and move forward once both your current
series and his have been merged.

> > > 4. This series is now marked 'changes requested' but the only feedback
> > > I see is in the RFC patch.
> >
> > Yes, rebase to something that can be applied is a change I've requested.
> > Because my feedback was "Do you plan to rebase the prerequisite series'
> > this requires so that it can be merged?". I would have otherwise merged
> > it by now.
>=20
> OK I sent a PR.

Eh? v4 as-is needs to be rebased to mainline. That you didn't make it
against mainline but instead your tree is why this wasn't merged
already.

> > Patchwork reflects mainline status.
>=20
> OK. I am finding it more and more slow and painful. Since we are
> talking about Patchwork, I noticed some patches assigned to me in
> there, so I've assigned them to you. I'll try to look there more
> often.

I guess you missed the email where I told you what was assigned to you
in patchwork and could easily be put in a pull request by you to me to
get to mainline.

--=20
Tom

--jhlRjx2apgIVsQIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfVh1AACgkQFHw5/5Y0
tyzlDQwApFLVYTfrRgYzcIKhfRQb+us/ZxgFtx/TBQ9y1qk9m74YCITHzo/d+6Y8
R/KJTaOpTj0JEJvO8aoGh/TA/Iib1fNCWL7QJMN8C6zX7yjRTNI7nWQo7PDZESGb
Kxpt1xkNQ3z8R2yQPSqkoWrwxhnmyAJPferpKLz+TTiYdYw5SrzI7TKndCjHAKAk
OAtDFKy9/a4AbCWFM29wMFOz/MTQ32A4ohLcEOt+9ziYexHpzm0kEsTNC8tdHKD1
+/VCmrerbqMzPUooFIx8sq5awC4TddxEhDmKrv2pvcktCxrg4LQRRKLYx8atFwq/
86QeDua80xDr0pjPnDdnhiHlbRJr4JDgXIyQP1MVqNwHU/MUx8npALx9ycGZPFfB
hrzZIYFvPEJXOH55xfCRF/b2Qu4iJgwZl6UhGuxkRPDUdrgFhO01K0Kso4IGyfWa
28hIuGBYJQQOeG/XiAyJnh9lqgo0WFiaAcEHtRUEiRJC026JNes18+foLrEGKrfJ
WoKoduNW
=80gd
-----END PGP SIGNATURE-----

--jhlRjx2apgIVsQIc--

