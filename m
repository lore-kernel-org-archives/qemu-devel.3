Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD85C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 21:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnmJi-0002b7-Qx; Fri, 22 Mar 2024 17:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rnmJd-0002an-Ua
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 17:20:42 -0400
Received: from fhigh7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rnmJZ-0003kf-Gr
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 17:20:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id A52251140122;
 Fri, 22 Mar 2024 17:20:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 22 Mar 2024 17:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1711142433; x=1711228833; bh=8gwD78Ff6I
 DeVXMwdmRH3pQjjgKtI9zqKea1GYKEQMI=; b=F9B5X5qlLwecIN+zr14unGufM8
 ZZO6o8azDAB+m2NhnOBxFU7dsaDLswfqosaDKFzo1NMJH3q1JoDSxLiKNAysgMWV
 zuDLQBMo8zFd6GijOcHH7RlBpCvlV1LKwk3SHnXOUXVk1wKxBdXVVdRgy+REQDh6
 eJi0trRVSX64tE87uUEV2U6aKtHcgUCJVy5C/YfwOVtfyeemWasH8kcNc+3iZIb7
 SOc/aq/X/55GrhQ/JGTzsewqbM4KRj3J7rdZb1dGWcVleMCeV1g0G6apmBiplifm
 NIawuw/NzJpJf5KGheWGcThpITj2enUOJoVeTu5ujaQ2VET2B2xULZ1N167Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1711142433; x=1711228833; bh=8gwD78Ff6IDeVXMwdmRH3pQjjgKt
 I9zqKea1GYKEQMI=; b=J+6BftLYH2hR7klLbftOi7/jojbgQVpJThqsh894caea
 +WBKS8/T4ftw79Nz5xoX/i4V5JTFIotUVUYMIXCgKMlSZRtPolAxERtDwVxFAaGb
 1IYFTTiiPEFSw+D3I98vV7uTA3abUIFTOeM7ZMhFWrezdraI5LEbSqJb/zcWpMmo
 5oyrhV+TveoawEoFQiMlikoErCkeB+JPBZYm9DKf6B/zsHeKMpfMl9EIFia3DS0F
 htcyvENoguUaJVPYfII/ZDuMZ+NhFUf0xMm9CR1gw6MrjiLhQgN7qO9qZVeYlx9z
 HnfBUIgjXEkr2s+PCCfOnSrEk/+AIJg+ElAr3yf1ew==
X-ME-Sender: <xms:Ifb9ZQyu78XxLZ-KtI36ClNSIS02RHJswkjKxxF-kchz002zj9LVxQ>
 <xme:Ifb9ZUT_ccAASohezcj3980ZXGu4dkq-vsyUOQ8BjDZ4NgIbu9N5YhadDeK4-3vzr
 n75w58mtLMwEUC5Ag>
X-ME-Received: <xmr:Ifb9ZSUg8Z3xUeNvyGpu8mAsov_sBYB0SrK_fNfJs1eYmlM5tG6eA4_DSG-2e4qLfBczhjs4kiZe7HCk8eWR28Lkltlz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgkeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtjeenucfhrhhomheptehlhihs
 shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephf
 euteehieehheekvdetvdffheeuffeltdekhfduvedtkeffvdeggefghfehjeehnecuffho
 mhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomhdptghrrhgvvhdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihs
 shgrrdhish
X-ME-Proxy: <xmx:Ifb9ZehZi9-mvgwADPUP8W58JbS-kE6oDH-yFu2n_VSxD8iWImFvAQ>
 <xmx:Ifb9ZSB8P6-0_maVEBjwbbHDj_fbnlz5lqTkjZDxiGd6ekb9NqyFeg>
 <xmx:Ifb9ZfI181XfZMsKUXCWJCO60C5y9Ouoo1nAmF_JAd84V6kjshCvmA>
 <xmx:Ifb9ZZD1uiTnUHkDRkDIzsZvR1undWxBYgSv8GZdDz8MtA96DNg1vg>
 <xmx:Ifb9ZaYyAHdwfcRL3oAVcQ-rCzLzWZ001GlFKjjSHiMThtqsloC5Dg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 17:20:32 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 2C79DE582; Fri, 22 Mar 2024 22:20:30 +0100 (CET)
Date: Fri, 22 Mar 2024 22:20:30 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, 
 thuth@redhat.com, Andrew Walbran <qwandor@google.com>, 
 Frederick Mayle <fmayle@google.com>
Subject: Re: rutabaga 0.1.3
Message-ID: <wxhk5mcmsx2geak75py5ck6u5iis4vffmf7eekfjdyt65ol5qd@imbt42hgvgta>
References: <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
 <87cytwnqoj.fsf@alyssa.is>
 <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
 <87msssmax4.fsf@alyssa.is>
 <CAAfnVBm--wu3=ES0tY2JPXwm+Ga-tRLq=EpkZdzdVoHGUfb2KQ@mail.gmail.com>
 <CAAfnVBkk1QTAo4dT372QNFmWqFFG4TxM0OTv9XHQQf6fm11fag@mail.gmail.com>
 <ufctubdq3cyltmtgwc4ng2dn6akazaybqvz5f5a6pyvgwmsxw2@3kapq5mvvy7l>
 <CAAfnVBnN3jnnyszxRW4YH=39SHK=hji6RqhXAYwHEMw-pnRevw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nbjgcpyokqimoqzb"
Content-Disposition: inline
In-Reply-To: <CAAfnVBnN3jnnyszxRW4YH=39SHK=hji6RqhXAYwHEMw-pnRevw@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.158; envelope-from=hi@alyssa.is;
 helo=fhigh7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


--nbjgcpyokqimoqzb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 04:23:20PM -0800, Gurchetan Singh wrote:
> On Sat, Mar 2, 2024 at 6:38=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> > Hi Gurchetan,
> >
> > > >> > Would this be a suitable commit for the 0.1.3 release of rutabag=
a?
> > > >> >
> > > >> > https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d31=
7c6edf44138def886f47cb1c7c
> > > >> >
> > > >> > The gfxstream/AEMU commits would remain unchanged.
> > > >>
> > > >> That combination works for me.
> > > >
> > > > Just FYI, still working on it.  Could take 1-2 more weeks.
> > >
> > > FYI:
> > >
> > > https://android.googlesource.com/platform/hardware/google/gfxstream/+=
/refs/tags/v0.1.2-gfxstream-release
> > >
> > > https://android.googlesource.com/platform/hardware/google/aemu/+/refs=
/tags/v0.1.2-aemu-release
> > >
> > >
> > https://chromium.googlesource.com/crosvm/crosvm/+/refs/tags/v0.1.3-ruta=
baga-release
> >
> > Unlike the commit I tested for you, the commit that ended up being
> > tagged as v0.1.3-rutabaga-release doesn't work for me:
> >
> >         qemu: The errno is EBADF: Bad file number
> >         qemu: CHECK failed in rutabaga_cmd_resource_map_blob()
> > ../hw/display/virtio-gpu-rutabaga.c:655
> >         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
> >         qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob()
> > ../hw/display/virtio-gpu-rutabaga.c:723
> >         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
> >         qemu: The errno is EBADF: Bad file number
> >         qemu: CHECK failed in rutabaga_cmd_resource_map_blob()
> > ../hw/display/virtio-gpu-rutabaga.c:655
> >         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
> >         qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob()
> > ../hw/display/virtio-gpu-rutabaga.c:723
> >         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
> >         qemu: The errno is EBADF: Bad file number
> >         qemu: CHECK failed in rutabaga_cmd_resource_map_blob()
> > ../hw/display/virtio-gpu-rutabaga.c:655
> >         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x208, error 0x1200
> >         qemu: invalid resource id
> >         qemu: CHECK failed in rutabaga_cmd_submit_3d()
> > ../hw/display/virtio-gpu-rutabaga.c:341
> >         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x207, error 0x1200
> >         qemu: CHECK failed in rutabaga_cmd_resource_unmap_blob()
> > ../hw/display/virtio-gpu-rutabaga.c:723
> >         qemu: virtio_gpu_rutabaga_process_cmd: ctrl 0x209, error 0x1200
> >
>
> Thank you for the bug report .. does crrev.com/c/5342655 fix this for you?

Hi Gurchetan, thanks for looking into it, and sorry for the late reply.

Alas it doesn't seem to make a difference.

(The commit message is also incorrect.  AsFd is implemented for
SafeDescriptor in rutabaga_gfx/src/rutabaga_os/sys/linux/descriptor.rs.)

> I bisected it to:
> >
> >         commit f3dbf20eedadb135e2fd813474fbb9731d465f3a
> >         Author: Andrew Walbran <qwandor@google.com>
> >         Date:   Wed Nov 29 17:23:45 2023 +0000
> >
> >             rutabaga_gfx: Uprev nix to 0.27.1
> >
> >             The new version of nix uses OwnedFd in various places, whic=
h allows us
> >             to have less unsafe code.
> >
> >             TEST=3DCQ
> >             BUG=3Db:293289578
> >
> >             Change-Id: I61aa80c4105eaf1182c5c325109b5aba11cf60de
> >             Reviewed-on: https://chromium-review.googlesource.com/c/cro=
svm/crosvm/+/5072293
> >             Auto-Submit: Andrew Walbran <qwandor@google.com>
> >             Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
> >             Reviewed-by: Frederick Mayle <fmayle@google.com>
> >             Commit-Queue: Frederick Mayle <fmayle@google.com>
> >

--nbjgcpyokqimoqzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmX99hoACgkQ+dvtSFmy
ccD/CxAAgIHqiYo0emvX8Sk2aGBxRsFUDelpTibkgwBqaykFjFY47jfmI+xuriOg
QLAuARBzSKmchfK2ufYwWmcB+WXPm/5fATKJlrpCT9f4ioBaOo3nOQArnzE/As6S
P9x1HpB/Z9gjUH5wGUarwcmbWVqWKaN/75px4qHdZSG8PVNd5V7DFRC6NUchx/ml
NKOCbu6RG4l+kfK0In+5QJBfitweMk6CAp5S4vN2IeBMPtq24iF5uHgK93EWTA6i
5lcVjBAEeM5+3l6MKzN8d360DegAg02wQnZKB/+UN94X31RkuIA+gjrIyQcfRagG
jZheUSH1nzkKlOoGDRNWjIPOlR/pbYrmMIT92JaFCPY3uHpT8fuosYsiiFtn9JEY
S4Kr8xl4fw3qRNhWFPejqTraTMybqs17l3+WXYHaKMlIUuyksp/5gpDL5i5/7cof
32kXjMq3C2vIB8h9m2TW1wGDe6oUcj2dcdRuYQdcPeTQK7sx9Xo47B4ZYajS3/7W
CqSH3MfBesMgfl/GFkWRXnhobthuw2RTKlJXNdL1ZqheSNMB5uDzYaTg9WPuiU3f
fUTEwyI6DVRIaGFG5lnq6G0/VHznwWs3iPLc8eL2DgaU67T1AE+cZmsd3tUE71L3
mWF0EMyFmyAfhcBV2NXQM0g1w9dKn1OqRVW5Rjb7yazjnUeyk7c=
=m5oG
-----END PGP SIGNATURE-----

--nbjgcpyokqimoqzb--

