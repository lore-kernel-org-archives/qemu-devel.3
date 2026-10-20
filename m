Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593F606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7e0PXza
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIxt1-00017D-C8; Mon, 19 Oct 2026 20:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xIxsz-00016g-LV; Mon, 19 Oct 2026 20:39:25 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xIxsy-0005Ba-39; Mon, 19 Oct 2026 20:39:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB0CC601FA;
 Tue, 20 Oct 2026 00:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6371F000C4;
 Tue, 20 Oct 2026 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792456753;
 bh=zqSn722jo7+QPtsauwBlkRXVlSIOEmGR5B2mt1TMD2g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=c7e0PXzaqhMPq4uOiqDjs2HH3Z105u1RfmvmcTiUkuZwWXilhRU83BlXsVFHY1wtL
 Ndi8rCk3GWz/Q7LSbDBPxvtBWiAhnVQwoUBuuefcXPXp5OPGMldr3dfNAED+bvv+Jo
 EuS1oR4GI8OE/0XdClWGqVjd99Jj683f2RssHsZk5Shmr0LAOEIGEdQ+Xpz49dBuXE
 pEmIDDtSGI1B3B8maiPDKPXeU9MqfiIPAZyPZ/xtff4SSqZTg+Sxz5UFStXdAYSFcD
 uHaPGQI6Tpbuk9lu1409plJVbLm6Wu8cP3fDFrh+YFMl3rWVq5i7rV5X1WQ2/kbBfz
 YaPY9Vc75eIiA==
Date: Tue, 20 Oct 2026 01:39:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Jinjie Ruan <2118537295@qq.com>,
 anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jonathan.cameron@oss.qualcomm.com
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
Message-ID: <20261020013906.0ee141e5@jic23-hlaptop>
In-Reply-To: <CAFEAcA8ffgrbh_gUK7wcZW5E8p=ZC+CC=3U23ah+nWHxOGpjrg@mail.gmail.com>
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
 <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
 <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
 <501bf5cc-cee1-4593-943d-505003541d41@huawei.com>
 <CAFEAcA8ffgrbh_gUK7wcZW5E8p=ZC+CC=3U23ah+nWHxOGpjrg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 13:28:03 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 19 Oct 2026 at 13:19, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2026/10/19 20:01, Peter Maydell =E5=86=99=E9=81=93: =20
> > > On Mon, 19 Oct 2026 at 12:46, Jinjie Ruan <2118537295@qq.com> wrote: =
=20
> > >> One honest caveat =20
> > >
> > > Please don't send LLM output to qemu-devel. =20
> >
> > Sorry. Here is my understanding:
> >
> > As mpam_csu_value() and mpam_mbwu_value() below done, the monitor code
> > scales the base value based on the software-configured PBM
> > (Partition-Based Monitoring) or MB MAX values, rather than just
> > returning zeroes. =20
>=20
> Thanks. So we report "you're using the full amount the system
> is configured to let you use". That seems reasonable.
>=20
> > And most of the code are to expose the many MPAM registers, constructing
> > the ACPI tables, and building the hardware topology of the memory
> > controllers and caches to correctly expose the MSC (Memory System
> > Controller) components. =20
>=20
> OK, that makes sense too -- I guess there's just a lot of pieces
> of hardware in there.
>=20
> thanks
> -- PMM
>=20
Hi Peter, ruanjinjie,

FWIW the much more minimal emulation that I posted years ago and
which I few crumbs of in here came up at plumbers this year with
an engineer from yet another company asking if I could look at
rebasing and upstreaming because they also found it very useful.
I was trying to work out if I could fit that into my todo list
or whether to ask a colleague to do it.

As such I'm very pleased to see this surface a few days later!
Even what I had was very useful for testing so I'm with this
much extended feature set I'm not surprised to hear even more
issues have shaken out.

It might take me a little while to get time to look at this series
but I definitely plan on doing so!

Jonathan

p.s. On off chance that (carefully unnamed) engineer sees this I
     had no idea ruanjinjie was working on this.

     Must have been something in the air :)





