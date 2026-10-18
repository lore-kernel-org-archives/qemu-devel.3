Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4518CCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIOOP-0006b2-3W; Sun, 18 Oct 2026 06:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1xIOOM-0006ac-VJ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:45:27 -0400
Received: from cockroach.ash.relay.mailchannels.net ([23.83.222.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1xIOOK-00020W-PS
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:45:26 -0400
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C14A4401C3C
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 10:44:40 +0000 (UTC)
Received: from sh-cp12.mia1.servername.online
 (100-96-9-235.trex-nlb.outbound.svc.cluster.local [100.96.9.235])
 (Authenticated sender: hostpapa)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5C199401D9D
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 10:44:36 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostpapa|x-authuser|frode@tennebo.com
X-MailChannels-Auth-Id: hostpapa
X-Descriptive-Arch: 6358993e4c162341_1792320280711_179607897
X-MC-Loop-Signature: 1792320280711:3129056381
X-MC-Ingress-Time: 1792320280710
Received: from sh-cp12.mia1.servername.online (sh-cp12.mia1.servername.online
 [199.204.250.122]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.9.235 (trex/8.0.2); Sun, 18 Oct 2026 10:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tennebo.com
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:
 Message-ID:Date:From:Reply-To:In-Reply-To:References:MIME-Version:Sender:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wldW/mhHkcuGpQ76y8K/jFo/zjz/5pAwyQD8dKEOylg=; b=LoCbsDlHJCaEIqahPnZ1abqrEc
 ei0RfXV0cUwlTMHMiz0/D8U1uFxdKOPrCp0Oo8EIVpB/GSiFIQjLMK4VPZ43KFkbAsmPYQMek25Gr
 RaD2X3/2Vl1GjuIRxy/sCK9ZLooKYB03qLnPBfmaOB9Hw+EWX+OXSaobTyX9jtscvUO36/An7/w/2
 0E9Fi8ER9oh/R/0zjfgrBgec68/DT0IwtSTQT/9CjjknYGxvJAkecp9wABiu8rlGQw1kbwwEsXNB7
 HsVGLR8A+l9kycYasjkmNzwJ/KbiLYSOkBsGb5oXGwVbWodvfh7hvVtxgYDVMY38dEdMMybPoTsjK
 PxU3H8PA==;
Received: from mail-wm1-f49.google.com ([209.85.128.49]:42000)
 by sh-cp12.mia1.servername.online with essmtpa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (Exim 4.100.1)
 (envelope-from <frode@tennebo.com>) id 1xIONS-0000000CjSk-1SbZ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:44:35 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso14712415e9.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:44:30 -0700 (PDT)
X-Gm-Message-State: AFq9FYJsya6CquGzAs7o5WPF0K78rm8W1W8scy2YAiCm1pRRriIG5pJg
 T6QgEwDtstaqSmpvsm4ErhC9kwXlxpGBnjwV7sVm5utU5JhCz5AI2bsh3M1bYNoo87zlHb3HoE9
 E5HGuLeX8SZdz1EOmRu8G8K0j0vFdhkE=
X-Received: by 2002:a05:600c:8709:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4a1d760536cmr92136705e9.13.1792320269297; Sun, 18 Oct 2026
 03:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
 <4d098749-fc9d-46c8-99f8-67d6414279e9@ilande.co.uk>
In-Reply-To: <4d098749-fc9d-46c8-99f8-67d6414279e9@ilande.co.uk>
From: =?UTF-8?Q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
Date: Sun, 18 Oct 2026 12:44:17 +0200
X-Gmail-Original-Message-ID: <CAGpFvKk3rS=AQxgismpcVBek7zR=axO0HL5mOEBKsOH+f=vG3A@mail.gmail.com>
X-Gm-Features: AclHuK8XpnXDxxP_Z9BTm2byaKDbggtym-RmXMJhl0gsrwxnImGTivoFdAbzU8I
Message-ID: <CAGpFvKk3rS=AQxgismpcVBek7zR=axO0HL5mOEBKsOH+f=vG3A@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/sparc,
 hw/sparc64: add hostid=/machineid= -machine properties
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-AuthUser: frode@tennebo.com
Received-SPF: pass client-ip=23.83.222.37; envelope-from=frode@tennebo.com;
 helo=cockroach.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: frode@tennebo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mark,

Thanks for getting back to me.

On Sun, 18 Oct 2026 at 11:26, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 19/09/2026 15:56, Frode Tenneb=C3=B8 wrote:
>
> > This series adds "hostid" and "machineid" as -machine sub-properties
> > for the sun4m and sun4u/sun4v machine families:
> >
> >      qemu-system-sparc  -machine SS-20,hostid=3D0x352e09,machineid=3D0x=
80
> >      qemu-system-sparc64 -machine sun4u,hostid=3D0x352e09,machineid=3D0=
x72
> >
> > Background: these machines report a classic 32-bit Sun "hostid" to
> > the guest OS (as read by hostid(1), and historically use by some
> > software for license checks), built from two independent pieces stored
> > in the emulated NVRAM/IDPROM - a fixed per-model machine-type byte, and
> > the low 24 bits of the machine's Ethernet MAC address. QEMU already
> > reproduces this scheme, but until now neither half was settable from
> > the command line: the machine-type byte was fixed per hwdef, and the
> > low 24 bits always tracked whatever MAC ended up on the emulated NIC.
> > Both properties default to that existing behaviour when left unset,
> > so this series is fully backward compatible.
> >
> > Patch 1 adds a small shared helper (hw/sparc/sun_hostid.c) rather
> > than duplicating the property getter/setter logic between the two
> > machine families: a generic SunHostIDProps struct that a machine's
> > own instance struct embeds anywhere, located via byte offset, plus
> > two functions to register the properties on a class and initialise
> > an instance.
> >
> > Patch 2 wires this into sun4m, via the existing sun4m-common
> > abstract machine class.
> >
> > Patch 3 wires it into sun4u/sun4v. Since sun4u.c had no shared
> > abstract machine class before this series, patch 3 introduces one
> > (sun4u-common) as the parent of both "sun4u" and "sun4v", and
> > registers the properties on it once - both machines pick them up
> > through QOM's class-hierarchy property lookup. The "niagara" machine
> > (hw/sparc64/niagara.c) is a separate machine family that does not
> > use this NVRAM/IDPROM hostid mechanism and is unaffected.
> >
> > PS: This is my first patch set for QEMU.
> >
> > ---
> > Frode Tenneb=C3=B8 (3):
> >        hw/sparc: add shared sun_hostid helper for hostid/machineid prop=
erties
> >        hw/sparc: add hostid=3D and machineid=3D -machine sub-properties
> >        hw/sparc64: add hostid=3D and machineid=3D -machine sub-properti=
es
> >
> >   docs/system/target-sparc.rst   | 23 +++++++++++
> >   docs/system/target-sparc64.rst | 22 +++++++++++
> >   hw/sparc/meson.build           |  1 +
> >   hw/sparc/sun4m.c               | 55 ++++++++++++++++++++++----
> >   hw/sparc/sun_hostid.c          | 88 +++++++++++++++++++++++++++++++++=
+++++++++
> >   hw/sparc64/meson.build         |  1 +
> >   hw/sparc64/sun4u.c             | 74 +++++++++++++++++++++++++++++++--=
--
> >   include/hw/nvram/sun_nvram.h   | 11 ++++--
> >   include/hw/sparc/sun_hostid.h  | 48 +++++++++++++++++++++++
> >   9 files changed, 306 insertions(+), 17 deletions(-)
> > ---
> > base-commit: f8296b816fabd370307cd22b0270b610fc0fa279
> > change-id: 20260917-add_hostid_sub-properties-473a0d2ea35e
> >
> > Best regards,
>
> Thanks for the series. Just out of curiosity, what is the use case for th=
is? Normally
> people want to change the hostid for licensing reasons (i.e. so that the =
virtual
> machine matches a real one), but I'd expect that to be already possible?

The use case is indeed what you state.  QEMU today will set a fixed value f=
or
the 'machineid' byte based on the -M flag and copy the last three
bytes from the MAC
address to the 'hostid' bytes.  Both are returned using the hostid(1) comma=
nd.
However, for licensing reasons, you could have one software checking the MA=
C-
address and another checking the hostid(1), but due to historic replacement=
 of
hardware, be completely unrelated.

What triggered this patch was a 'sun4u' machine running multiple
licensed software,
where the 'machineid' =3D 0x72 (i.e. SS-20, not possible to set in
'sun4u') and the
hostid !=3D MAC-address.  To get this emulated machine to run all the
desired software
was not possible to hack in any way with the existing QEMU SPARC implementa=
tion
and the most flexible fix I could think of is this set of patches.

On "old" real hardware, you would update the persistent NVRAM/IDPROM in
OpenBoot to reflect the machineid, hostid and MAC address to the desired va=
lues,
which is also what was originally done with my machine.  I think it is
possible to
change these values in an emulated OpenBoot environment, but OpenBoot
support in
sun4u is not complete.  Also, it is not possible to have a persistent
NVRAM/IDPROM
in QEMU for SPARC making this solution rather  clumsy as you need to reset =
the
values for each boot.  Also, in OpenBIOS I don't think it  is even
possible to change
the NVRAM as you can in OpenBoot.

I hope this explains my reasoning.

Regards,
 -Frode

