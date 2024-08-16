Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25547C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesJN-0006OY-A5; Fri, 16 Aug 2024 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>)
 id 1sesJL-00068U-Rg; Fri, 16 Aug 2024 04:27:51 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>)
 id 1sesJI-0004yj-CX; Fri, 16 Aug 2024 04:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723796864; x=1724056064;
 bh=lXAXvTPVE9jNO4PjN8ZXOLmDsprkEpKx2IZelUYLSjs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=D2kfbkzzMR6o/Bizu+Rd75y7Yn+EhI/rkZcbmOxK18SjJit7HUa3vIOeSI3r8F6bn
 bkjavvA50ZVfMTaoCWHetZDX6yiWdb1CS2g9zFJPrSoX0Rjk55jT0a5NvRcpO8iiqH
 daAW6xp9Va+IG+Hepn4enqj6Y2ecCx/F7DhHF8T6ou7PEWh+MjUArJnEMCaI4kR+C7
 2lXsQ6a0je38Bu/qEG9Hrzxw3lRZC3pQiOQEffTGc7RGmjRqhgWcJmmh4RhkPOxbTC
 1Vk8LyMEC8sUtVhLvES7ff4ZDFi4FWJXTPmH4nuWHXAPLhph3CZheMACClUCgIx510
 DQrrIvqc7TSew==
Date: Fri, 16 Aug 2024 08:27:39 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Joelle van Dyne <j@getutm.app>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.1 v2] hw/i386/pc: Ensure vmport prerequisites are
 fulfilled
Message-ID: <8k4duf_dozKAnKnCqWFNJpiQCk0RMmMvDXMzPMOuZB0weL6yxhJuDTRLWLdZAcIxFkEAdGjSUfjHZCnuRQ4DKxjQi660jJF8PgMrSxcBlaA=@szczek.dev>
In-Reply-To: <fca41463-b835-4958-9c08-dfe7d09654ff@linaro.org>
References: <CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=@szczek.dev>
 <fca41463-b835-4958-9c08-dfe7d09654ff@linaro.org>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 10ba7b4ec04a017d457e2414975644501d70fad4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=kamil@szczek.dev;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Friday, August 16th, 2024 at 10:22, Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:

>=20
>=20
> On 16/8/24 10:01, Kamil Szcz=C4=99k wrote:
>=20
> > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
> > to disable PS/2 mouse/keyboard'), the vmport will not be created unless
> > the i8042 PS/2 controller is enabled. To avoid confusion, let's fail if
> > vmport was explicitly requested, but the i8042 controller is disabled.
> > This also changes the behavior of vmport=3Dauto to take i8042 controlle=
r
> > availability into account.
> >=20
> > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek.dev
> > ---
> > hw/i386/pc.c | 8 ++++++--
> > hw/i386/pc_piix.c | 3 ++-
> > hw/i386/pc_q35.c | 2 +-
> > qemu-options.hx | 4 ++--
> > 4 files changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index c74931d577..c99f2ce540 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1075,7 +1075,7 @@ static const MemoryRegionOps ioportF0_io_ops =3D =
{
> > };
> >=20
> > static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
> > - bool create_i8042, bool no_vmport)
> > + bool create_i8042, bool no_vmport, Error **errp)
> > {
> > int i;
> > DriveInfo *fd[MAX_FD];
> > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, boo=
l create_fdctrl,
> > }
> >=20
> > if (!create_i8042) {
> > + if (!no_vmport) {
> > + error_setg(errp,
>=20
>=20
> Is 'errp' available? Does this patch compile?

It does and works as expected.

> Anyway, I think you want to call error_report() & exit().

Hmm, the error.h suggests that error_report() & exit() is a legacy approach=
, hence why I've used error_setg & error_fatal ptr. As far as I know both a=
pproaches are equivalent, no?

>=20
> > + "vmport requires the i8042 controller to be enabled");
> > + }
> > return;
> > }

