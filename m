Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93597606D4CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dm4PXVpD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgiv-0007sg-Kd; Wed, 04 Nov 2026 14:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xOgiu-0007sQ-Br; Wed, 04 Nov 2026 14:32:40 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xOgis-0001PN-OS; Wed, 04 Nov 2026 14:32:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CA5640E25;
 Wed,  4 Nov 2026 19:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5691F0093A;
 Wed,  4 Nov 2026 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793820757;
 bh=2YUHNf6MUjOZDD6UY+Oljg2J2+kFMPFC9emoVx0oRXg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Dm4PXVpDEPQrfbQxLqRjMP4YFOpdGV+0ENqdgEnremjq+0AoNLT7nFZaf6IfiK4ee
 QYuk2LA4+xs9eMpKWjjNVDl7WDx+Mi7p390GCzGh5wUV5mNBBFfopJ/nvYaeW2GJFv
 MYktcvJQQbm2ToTHE9xzo/Mji9osJuCS+Fl0zKTIAzGiM5sut4kxdHsoLAJ3ZweQyE
 i7vhyiLUvzKuuRGh4SCWuMLoADyS75A9ttiqsvL6I+IuQIBTaC8XSixGxijWsWo3vU
 HtZ5ZEZO0UeI1YKQI0uYYXkk+iA4jsAQHz7qWar1iDFqpZqv+CTzF2wVzY+oUmI37M
 PxPN0XpqVvplQ==
Date: Wed, 4 Nov 2026 19:32:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jinjie Ruan <2118537295@qq.com>, <anisinha@redhat.com>,
 <armbru@redhat.com>, <eblake@redhat.com>, <imammedo@redhat.com>,
 <michael.roth@amd.com>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [PATCH 17/37] hw/arm/virt: Add mpam and mpam-min-msc machine
 properties
Message-ID: <20261104193228.37080f59@jic23-hlaptop>
In-Reply-To: <f015a1ca-af03-489e-b967-a36536673415@huawei.com>
References: <tencent_4A73E52B4D6BC21D11E7564A8A6EA6EF5805@qq.com>
 <20261103015138.2191fa9b@jic23-hlaptop>
 <f015a1ca-af03-489e-b967-a36536673415@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 16:49:15 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> =E5=9C=A8 2026/11/3 9:51, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Fri, 16 Oct 2026 18:10:35 +0800
> > Jinjie Ruan <2118537295@qq.com> wrote:
> >  =20
> >> From: Jinjie Ruan <ruanjinjie@huawei.com>
> >>
> >> Add the two MPAM machine properties: mpam=3Don enables MSC emulation
> >> for the virt board, and mpam-min-msc=3Don collapses the per-node
> >> memory MSCs into a single MSC with one RIS per node.  The state
> >> fields and the property accessors only; MSC creation arrives with
> >> the later patches.
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com> =20
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >=20
> > I'm curious to get more viewpoints on the somewhat weird mpam-min-msc
> > though.  It is kind of handy for testing IIRC but not sure it is realis=
tic. =20
>=20
> Hi Jonathan,
>=20
> I think the code is already in fairly good shape now. Perhaps we can
> drop this option in the official submission?

I think we do need a way to trigger using the RIS support (which
I think was the purpose of that?)

Maybe there is a better way to do it than a parameter that
says squash what you can into a single MSC.

Jonathan

>=20
>=20


