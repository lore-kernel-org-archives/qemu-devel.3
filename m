Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9906C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4Ao-0008Aw-1u; Thu, 20 Feb 2025 05:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl4Al-0008AT-Oh
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:52:52 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl4Aj-00013M-8d
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:52:51 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6f754678c29so6589107b3.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740048768; x=1740653568; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwQqs2MUo29YuU8xbj8I9NFNJ0ZGtO71G9EnwFnBys0=;
 b=pzc2SbRO79RlROtuDp/KU2rtmrS10bK22jYLzBUXGH12r4xOgd3Y8jGHxL5K8FfNmO
 nObnV1vRoSmPZvNHBmiTazOt8ePWWUsbZ6j6N7rClahMT5EYJeMdmiURsH1RwhlRmtfL
 brDi0xMEZaOzl08FukpeyP+w66E+G8eCPvfh/IobmuQ15ycBUWCGeIYdGww4gxWJS5I0
 ny3mjhcrfLgL/dCJjl++kCm5BTDfhB/kmS1oj7B//GP/ZaT0PA54vohyR32f4AE7kdds
 3WT4Cjc+60RXub7kuVMephClpipxhFjycpGhXy+dUZzmJ81hU3CEZkjD7msrmgOOghQS
 Ajag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740048768; x=1740653568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwQqs2MUo29YuU8xbj8I9NFNJ0ZGtO71G9EnwFnBys0=;
 b=wtMu8ehKUW7DwNOlAA9lJU+sDfXwVCrpgfFWX+6bZDdgRLtDdGbb67u4kw48D/HM4J
 8mdNMzJUqoUpecF6UkzgkYXkd5Va79hO9MbJlRpPg0ZfDmyPfnys0ELL3tLRIOWDH2Fo
 H4JLVNaF2KnRHLXUhUxHk3/GCrHgEZ/lGlm/QdRZtc37Gts3M6/KYqS3ZNx6nsno+v15
 u5UB+QV+cYC02Y9tdULk9sFMbRh6AOPOWcOivtqEbEVmMuqLUTPjXOAA/sehD8S+oQjC
 T/7EqJptpkUiC2EG2xejpx3OLuGStw9PwVYeq++q2hTsqvdVOGbI/C1hcKGvnHUQXG43
 8/iQ==
X-Gm-Message-State: AOJu0YzUEh22I3BbfDAS3JkgQrYW+9AhGjIC6Oj4ePqez6yi5v4Fvpw4
 qm31WdlP33ZFlhqYehEOHcc6vhxQSFDSgWd5zaR9Do1xtfh//iOsFRbZs9hhiyyY6yEqfW0Co8+
 GzlloZxWTLZFVqqolB/JmXy/DXanpzPwPJPbt6A==
X-Gm-Gg: ASbGncuy2Wuvfm/if85M4DVJNERQ1pU8Cz9XTQUKFD+CtZ3yg/w5DEgnbaeXDLwoX/v
 Y61F90N/rftub1h5Mzqe9xjmN4YNZuaJoj3NWbOpdmTTSCztQeSF/LlnA5L8n5tku+I0e+j13pQ
 ==
X-Google-Smtp-Source: AGHT+IHql1vi73rS7Qz0C2FLVELu5Y5bZ+t6mBGqmmhedCFjRoENIdcAsnvEZjtN8uH6V83DC0DOAT3byy6bKum73iY=
X-Received: by 2002:a05:6902:1141:b0:e5b:3a59:525e with SMTP id
 3f1490d57ef6-e5dc904a281mr14688925276.18.1740048767621; Thu, 20 Feb 2025
 02:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <CAFEAcA8PYv3-JX66THwj-mDM0es6V5gVVWJsHTqkd9wTEVor4A@mail.gmail.com>
 <CAFEAcA-ioFgThGJ70cyhe7rA0kbnDULsr-BuAqE+3b3TE0BGwg@mail.gmail.com>
 <CAFEAcA-fZakXqgDV72fE5sFJv7ah=bvoXYpGqXZZzGutxt7r+A@mail.gmail.com>
In-Reply-To: <CAFEAcA-fZakXqgDV72fE5sFJv7ah=bvoXYpGqXZZzGutxt7r+A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 10:52:36 +0000
X-Gm-Features: AWEUYZksPweIXkSyJpL0bLRKlOjouUak4xMtIhxez_8kkKi727JLx3uQ8DIQyGA
Message-ID: <CAFEAcA-UP5VcDokb11KfpmQztRnWFS9pLcMZ5_2pe=BBKEv7Fg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 20 Feb 2025 at 10:43, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 18 Feb 2025 at 13:54, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Mon, 17 Feb 2025 at 14:55, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > >
> > > On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This series add support for (async) FIFO on the transmit path
> > > > of the PL011 UART.
> > > >
> > >
> > > Applied to target-arm.next, thanks (with a couple of minor
> > > tweaks to two of the patches).
> >
> > Unfortunately I seem to get failures in 'make check-functional'
> > with the last patch of this series applied.
>
> I had a look at this this morning because I wondered if it
> was a mistake in the style fixups I'd applied to the patches
> on my end, and I found the bug fairly quickly. The problem is
> that pl011_xmit() doesn't update the TXFE and TXFF FIFO empty/full
> status flag bits when it removes characters from the FIFO.
> So the guest kernel spins forever because TXFF is never unset.
>
> The following patch fixes this for me (and also makes us not
> set INT_TX for the case where we couldn't send any bytes to
> the chardev, which I noticed reading the code rather than
> because it had any visible bad effects):

Hmm, but that's clearly not the only problem -- it fixed the
"no output at all issue", but now I see a test failure because
of garbled console output:

2025-02-20 10:34:51,562: Booting Linux on physical CPU 0x0
2025-02-20 10:34:51,563: Linux version 4.18.16-300.fc29.armv7hl
(mockbuild@buildvm-armv7-06.arm.fedoraproject.org) (gcc version 8.2.1
20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sun Oct 21 00:56:28 UTC 2018
2025-02-20 10:34:51,563: CPU: ARMv7 Processor [414fc0f0] revision 0
(ARMv7), cr=3D10c5387d
2025-02-20 10:34:51,564: CPU: div instructions available: patching division=
 code
2025-02-20 10:34:51,564: CPU: PIPT / VIPT nonaliasing data cache, PIPT
instruction cache
2025-02-20 10:34:51,565: OF: fdt: Machine model: linux,dummy-virt
2025-02-20 10:34:51,565: Memory policy: Data cache writealloc
2025-02-20 10:34:51,565: efi: Getting EFI parameters from FDT:
2025-02-20 10:34:51,566: efi: UEFI not found.
2025-02-20 10:34:51,566: cma: aetrsv6i
2025-02-20 10:34:51,566: psci: oi ocdteofmT
2025-02-20 10:34:51,566: ps:Sv1ecdniwe^Mps:Usdvni spsc:rt  gtnot psci:
SMC Calling Conventiov0
2025-02-20 10:34:51,567: pec:Eee1pec pvls9 1 2865^MBul1olt bi4^MKerloa
n:itte nltAA
2025-02-20 10:34:51,568: Det c stlere 3 rr4 5i 9(dr336bt)Memr 06112aib
6Keece11K ra0 ,21 sv,Kmrsv,Kim)Virtual kernel memory layout:
2025-02-20 10:34:51,568: vt :xf0  fa  f00 0f00 30 (0M^M lm  c00
0800xe0 0000  2M^M mue:x00 0f00  4B
2025-02-20 10:34:51,568: et x(tvl) (rl 97B
2025-02-20 10:34:51,569: n 0(trvl-xta) 0  0pv) 3 B
2025-02-20 10:34:51,570: bs prl-xta) 5 )random: get_random_u32 ca
___+:ag6 d=3D3MOes,P=3D,os^Mfta:aotg78ni  1asHierhlC pmti.        RCrtcnC
oN_S2orpi=3D.   TasCebd
2025-02-20 10:34:51,571: RC jtgeeyor_o_a1 __d^MNRIS1 rr GIC physical
location is 0x800000^MGIC2 n[mx00-02f,P81]arcte 1tm(
nna65H(r.cemk0fffffacl:0d20,aish_o:6i  M,routo1n per49419sn^MCocrm
dexCalibrating delay ose eceiife..oIl2^Mpxdl6i3
2025-02-20 10:34:51,572: SertFmo ia^MYemgmdl
2025-02-20 10:34:51,572: SEn: ili.Moutcea b te 2(d:,4t^MMoupnch
stlers14oe  9oeyo
2025-02-20 10:34:51,572: CP0Screv:iwein tuia norieI tst lrl
2025-02-20 10:34:51,573: /cpus/cpu@0 missing clock-frequen or^MCPU
rd1c  k  i 00^MSetgptiintm rx30 000Hircc Cmento^MEF rc ln  aae^Msm ii
cdrCs.smp ohu1o, USMPTao1reo cvae(15. gP.CPUA U)tt  Code.devtmpfs:
initialize^Mmo4aheu pr3vit e0cloejfe s fffm_cs0fffm_d_:924250sfut stbs
2025-02-20 10:34:51,574: piclo:niidit uye
2025-02-20 10:34:51,574: DM tre  vi^MNETeDM:rlae2  o tmi oerent aloaios
2025-02-20 10:34:51,574: audit: initializing netlink subsys (disabled)
2025-02-20 10:34:51,574: audit: type=3D2000 audit(0.480:1):
sat=3Dntalzdadt_nbe=3D e=3D^Mcpuidl:usn oenrmnu
2025-02-20 10:34:51,574: No ATG?
2025-02-20 10:34:51,575: hw-brapit fud5(1rsrvd rapon n  achon
eitrs^Mhw-brapit:mxmmwthontsz s8bts^MSerial MAP01 Ap1:ttAA tMIO09000ud
=3D 0) saP01 e1
2025-02-20 10:34:51,575: console [ttyAMA0] enabled
2025-02-20 10:34:51,668: cryptd: max_cpu_qlen set to 1000
2025-02-20 10:34:51,690: vgaarb: loaded
2025-02-20 10:34:51,697: SCSI subsystem initialized
2025-02-20 10:34:51,702: usbcore: registered new interface driver usbfs
2025-02-20 10:34:51,703: usbcore: registered new interface driver hub

(the log has no garbling after that so it's presumably OK with
the interrupt-driven real UART driver but the polling one you get
for earlycon has trouble.)

I also noticed that pl011_write_txdata() doesn't clear TXFE
when it puts a byte into the fifo -- I'm testing to see if
fixing that helps.

-- PMM

