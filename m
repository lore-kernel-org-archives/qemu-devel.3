Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6233BC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjCI-0004HL-Ca; Fri, 17 Jul 2026 10:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wkjCH-0004H6-GQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:05:49 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wkjCF-0004O7-Ew
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ylj/gGV0KnteduzBRLrpH1pKp2lI1ZPRTHtRNM9LIeY=; b=st4K5fi9ZebJUdRf5Xtbah53qu
 QmtYlRA/RF5g/0cYJ6nLFandzOuQ9Kczenpv01IPDOj5wfl7+s7Ny8nFSO5auvBQyurz9EV+b/82W
 fUhuH3NMc0sFQIGLsHMndtGQLcAGO8IqhdfvLXzyGP4TkMhPjQI6XJA7df5YtyAcfo6s5IUkLD4Ps
 rT3SUjeyGaeuv2+xhZrxRimn4mn9Sd26ThRfMRZMTYvSsY6ZkhebOK1Wgk8XoMJi2XhJPk1TeyAbq
 VisCTM7h14PnPy4aWdTjy4U5sH+V98Nd3WyD25Zf4XKxo+GeDOUXYmkCjYlna6ZAIgPzMROTrUQRV
 svWuh+UlzNgHy0EHSmw81yRY8XkjV7wMipz+gEj/nPngEPUW2UaOOLD6XvUjE/3fcGhHqfu3/4Tyu
 ZnY/gpG+NS4kHu7p6jqkxxRwhTuaMxZPSWAqhoQRyDLven+wPAMjPK/w5Gfos2SrLVh+R/IXuZQiH
 RB3qNwmURaMuiv55g0njy4svJw2LEsfdKwH88QSQe4OAj9xPd+bWJnIw6jIzeldxGckm0W9+Vxwrl
 mcM2FqdDT5H01jXTsM/IJ0Zqcp1TDyqFenPVKRigKD2SNVGdeHaq6yYatdGoG1IQK0TDiVxiE/QjQ
 3yucI2yoACGbetmqr9zuU516N9/7k6lTUYvvX00A4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Cc: Jia Jia <physicalmtea@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Date: Fri, 17 Jul 2026 16:05:42 +0200
Message-ID: <3767624.R56niFO833@weasel>
In-Reply-To: <20260713094935.5eda77f9@imammedo>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <alEEROvr0gbuWCB2@redhat.com> <20260713094935.5eda77f9@imammedo>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Monday, 13 July 2026 09:49:35 CEST Igor Mammedov wrote:
> On Fri, 10 Jul 2026 15:40:04 +0100
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Fri, Jul 10, 2026 at 04:31:51PM +0200, Christian Schoenebeck wrote:
> > > On Friday, 10 July 2026 14:51:49 CEST Igor Mammedov wrote:
> > > > On Fri, 10 Jul 2026 12:49:06 +0200
> > > >=20
> > > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > > On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote:
> > > [...]
> > >=20
> > > > note: I'm looking from pov of hotpluggable PCI device and generic
> > > > hotplug
> > > > infra, only.
> > >=20
> > > That's okay, but so far I don't see the relevance for this particular=
 9p
> > > device.
> > >=20
> > > > it's not guest users directly, it's how hotplug flow works for vari=
ous
> > > > guest OSes:
> > > >=20
> > > > 1. host plugs device in (-device or device_add)
> > > > 2. guest OS get's notified one way or another and does what ever gu=
est
> > > > side
> > > >=20
> > > >    init needed (incl. mounting share in 9pfs case)
> > >=20
> > > That's not affected by this patch, right?
> > >=20
> > > > opposite flow:
> > > > 1. host does device_del (basically notify guest to remove device)
> > > > 2. guest OS frees resources and tells qemu to delete device
> > > > 3. qemu process remove event (which incl. unrealize as part of
> > > > destroying
> > > > device)
> > >=20
> > > And that's not affected by this patch either, right?
>=20
> the patch would break unplug flow by effectively removing 'eject' knob
> from guest side, which is part of unplug flow.

These are two different things: device_del would not be affected by this.=20

1. Ejecting the device from host side e.g. via QMP would still work.

vs.

2. Ejecting from guest side OTOH would be disabled.

It is also different from regular block devices where you have convenient w=
ays
to eject a block device on guest OSes. For a virtio-9p device it is not that
easy.

> > > OK, here is the point where we deviate: you are apparently seeing this
> > > from a purely theoretical PoV.
> > >=20
> > > I am facing reality: for several years I'm the only person taking care
> > > about this piece of code at all (on a side channel, for free, next to
> > > my actual work). And for several months I get AI generated security
> > > reports thrown at me, where I have to a) filter legit ones, and b) fix
> > > those legit security issues.
> > >=20
> > > For that reason, I am tightening security wherever I can, to prevent
> > > further flood.
> > >=20
> > > So the question here is: are you concerned about a real-life issue be=
ing
> > > introduced by disabling hotplugging for 9pfs specifically?
>=20
> my concern is that there might be users that use unplug despite present
> bug(s), and the patch would regress their usecase.

I already got that with your first message, and directly asked which use-ca=
se
that would be exactly.

Just saying there might be one theoretical unknown person on this planet who
might be using it, and nobody even being capable to imagine what for, does =
not
justify keeping an exotic feature (again: context 9pfs) that already had
negative impact on security for anybody else, especially for such a low man
power codebase like 9pfs.

This is similar to a discussion in the past about retaining support for old=
er
macOS versions in QEMU:

https://lore.kernel.org/qemu-devel/CAFEAcA9VnQCG3r28BOLr_qXLRM2V68r3oK4ZfY9=
+bVz2j1oSyA@mail.gmail.com/

Anyway, I decided to drop this patch and retaining guest eject for now.

However if there is any other kind of bug, especially of security nature, t=
hen
I will definitely disable guest eject unless proven there are justified rea=
l-
world users or somebody willing to step-in and keeping care of.

/Christian



