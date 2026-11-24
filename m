Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D857606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr1v+Bxn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVfEo-000346-Bb; Mon, 23 Nov 2026 20:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xVfEk-00032t-Q1; Mon, 23 Nov 2026 20:22:22 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xVfEj-00085a-5x; Mon, 23 Nov 2026 20:22:22 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6118461F12;
 Tue, 24 Nov 2026 01:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCC61F000CA;
 Tue, 24 Nov 2026 01:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795483335;
 bh=espABGEeYKmPtwhixdYINBKmyjgpdd5Ji2o+11klab0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Pr1v+BxnAA4CUcpL2/VuicO5xe1vdWLSisLs7cZP3TfzKvyzBlY73N0Z5zr0szvSN
 p6CHYaUR+4i3oi8j55NHdqzVsLf8Rr+6wdJhjqwrsGoEKqOx8/vWJRMwqZmbCH5bTN
 M6poXNaDcQ2et8NpPjV9B7jo5WipqfGt3rNNdG4IKeHi2qvJ7Ilb8Iaw9xxYD8QVd+
 6qdqSLvGokWNJ1U0NDx0ilvKWA4G8GRHqtUT+lQ60QAwSunJa1AslYdjUlXNUVou3i
 3bSvjiQvp22PDnscQSPxm/lbaN8E3o1p94uVJC/J7BZ72YXsqFJqFCssPmpeG4f1GU
 /ZmHGH9j3ho1g==
Date: Tue, 24 Nov 2026 01:22:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jinjie Ruan <2118537295@qq.com>, <anisinha@redhat.com>,
 <armbru@redhat.com>, <eblake@redhat.com>, <imammedo@redhat.com>,
 <michael.roth@amd.com>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [PATCH 01/37] target/arm: Add support for MPAM CPU registers
Message-ID: <20261124012210.6ce17900@jic23-hlaptop>
In-Reply-To: <4bcf10e0-23bf-4d1a-9ef7-1dbf98f78931@huawei.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
 <20261103000316.150d658d@jic23-hlaptop>
 <4bcf10e0-23bf-4d1a-9ef7-1dbf98f78931@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 15:33:00 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> =E5=9C=A8 2026/11/3 8:03, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Fri, 16 Oct 2026 17:46:55 +0800
> > Jinjie Ruan <2118537295@qq.com> wrote:
> >  =20
> >> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>
> >> Add the MPAM system registers for TCG: MPAMIDR_EL1 (RO) reporting 64
> >> PARTIDs and 4 PMGs, and MPAM0_EL1/MPAM1_EL1 (RW, of which only
> >> MPAM1_EL1.MPAMEN is architecturally reset). Advertise FEAT_MPAM via
> >> ID_AA64PFR0.MPAM for TCG CPUs.
> >>
> >> It is common to support MPAM on CPU cores, but not in the rest of the
> >> system, so there is little disadvantage in always enabling these.
> >>
> >> Based on an RFC series by Jonathan Cameron, adapted to the current
> >> idregs[] storage and access_tid3() naming.
> >>
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
> >=20
> > Definitely wouldn't trust this guy :)  He took a few naughty short cuts.
> >  =20
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com> =20
> >  =20
> >> diff --git a/target/arm/helper.c b/target/arm/helper.c
> >> index ff0b766..896ac0e 100644
> >> --- a/target/arm/helper.c
> >> +++ b/target/arm/helper.c
> >> @@ -6907,6 +6907,23 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >>                .access =3D PL1_R, .type =3D ARM_CP_CONST,
> >>                .accessfn =3D access_tid3,
> >>                .resetvalue =3D cpu->isar.mvfr0 },
> >> +            { .name =3D "MPAMIDR_EL1", .state =3D ARM_CP_STATE_AA64,
> >> +              .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0xa, .crm =3D 4, .op=
c2 =3D 4,
> >> +              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> >> +              .accessfn =3D access_tid3,
> >> +              .resetvalue =3D cpu->isar.mpamidr_el1 },
> >> +            { .name =3D "MPAM0_EL1", .state =3D ARM_CP_STATE_AA64,
> >> +              .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0xa, .crm =3D 5, .op=
c2 =3D 1,
> >> +              .access =3D PL1_RW, .type =3D ARM_CP_ALIAS, =20
> >=20
> > Similar to patch 2 (I reviewed them backwards) not sure why=20
> > I ever set this to ARM_CP_ALIAS.
> >  =20
> >> +              .accessfn =3D access_tid3, =20
> >=20
> > Never trust code I bodged years ago :( Wrong trap. Now you
> > have the appropriate EL2 registers in next patch should use a trap
> > on the relevant bits being set there.  Will want to swap the patches
> > around for that to work I think.  Also possibly needs the EL3 trap
> > register defined. =20
>=20
> Maybe we can first implement only EL2 to reduce the workload?
>=20
> I believe that achieving EL1 and EL2 functions is basically sufficient.
I don't mind as long as it is correct enough not to trip up anyones
code.

>=20
> >=20
> >  =20
> >> +              .fieldoffset =3D offsetof(CPUARMState, mpam0_el1),
> >> +            },
> >> +            { .name =3D "MPAM1_EL1", .state =3D ARM_CP_STATE_AA64,
> >> +              .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0xa, .crm =3D 5, .op=
c2 =3D 0,
> >> +              .access =3D PL1_RW, .type =3D ARM_CP_ALIAS,
> >> +              .accessfn =3D access_tid3,
> >> +              .fieldoffset =3D offsetof(CPUARMState, mpam1_el1),
> >> +            },
> >>              { .name =3D "MVFR1_EL1", .state =3D ARM_CP_STATE_AA64,
> >>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 3, .opc2=
 =3D 1,
> >>                .access =3D PL1_R, .type =3D ARM_CP_CONST, =20
> >  =20
>=20


