Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C26CCF34B2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjIX-0006Yr-1s; Wed, 19 Nov 2025 09:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vLjIV-0006Yj-Jb
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:36:39 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vLjIU-0003pQ-6Y
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:36:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B1F2C60172;
 Wed, 19 Nov 2025 14:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407ACC4AF10;
 Wed, 19 Nov 2025 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763562980;
 bh=WQeH04dqVpECHCQdx96l4lI4NrVvIMcfB360JpRUegc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uQYMcNfKecUfL5G8OpxVn4Vz4JL9L3kCbpQBEx9GBjM0S0f4B1NfzYrWRNUjXKtwl
 XWsXljUmwUw4skEcjzYg6iNIl250yyPBK7UCZMp0PJCUZCvCesKuMu9taKPDku3fCy
 M5GIaw98rXkQywBrfN2s6L/HtBiP8chUGnsv7OS32CS53mNS23aU/EGkma8GzOVH65
 rtBB3omKQyHFklWPcUeKBd5PqolzwLcocpMixNuCWNGCgvbEFVE4OhIw4P6+xO3BnS
 oN96zu6O93jciD5JiAg/MWEtKkpFXcbcfzEKLRutBI588htiOiv6W3nULj7hEpGpoG
 aC9rzt9n11ifg==
Date: Wed, 19 Nov 2025 15:36:15 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/9] contrib/gitdm: add group-map for Huawei
Message-ID: <20251119153615.247b74ba@foz.lan>
In-Reply-To: <20251119132515.00006f16@huawei.com>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-3-alex.bennee@linaro.org>
 <20251119132515.00006f16@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Wed, 19 Nov 2025 13:25:15 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> escreveu:

> On Wed, 19 Nov 2025 11:39:45 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>=20
> > While we do see contributions from the top-level domain some
> > contributors also post via other addresses.
> >=20
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

>=20
>=20
> > ---
> >  contrib/gitdm/group-map-huawei | 5 +++++
> >  gitdm.config                   | 1 +
> >  2 files changed, 6 insertions(+)
> >  create mode 100644 contrib/gitdm/group-map-huawei
> >=20
> > diff --git a/contrib/gitdm/group-map-huawei b/contrib/gitdm/group-map-h=
uawei
> > new file mode 100644
> > index 00000000000..c287dd5d2b3
> > --- /dev/null
> > +++ b/contrib/gitdm/group-map-huawei
> > @@ -0,0 +1,5 @@
> > +#
> > +# Some Huawei contributors submit via another domain
> > +#
> > +
> > +mchehab+huawei@kernel.org
> > diff --git a/gitdm.config b/gitdm.config
> > index 06ac729c7bc..2d75dd4deee 100644
> > --- a/gitdm.config
> > +++ b/gitdm.config
> > @@ -36,6 +36,7 @@ GroupMap contrib/gitdm/group-map-amd AMD
> >  GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
> >  GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
> >  GroupMap contrib/gitdm/group-map-facebook Facebook
> > +GroupMap contrib/gitdm/group-map-huawei Huawei
> >  GroupMap contrib/gitdm/group-map-ibm IBM
> >  GroupMap contrib/gitdm/group-map-janustech Janus Technologies
> >  GroupMap contrib/gitdm/group-map-netflix Netflix =20
>=20



Thanks,
Mauro

