Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75F0CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 08:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNS6V-0003yE-Bn; Mon, 24 Nov 2025 03:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vNS6T-0003wV-CH
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 03:39:21 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vNS6Q-0003KH-0C
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 03:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1763973540; x=1764578340; i=lukasstraub2@web.de;
 bh=5BfmL47IB5p7RLI2PUHoeRFNVHnJ+vj4J4dBZkcx7UY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MePyNPed6VEA8kNdHiLrQP+gPMkyIWAsy/fqTZZO9X6EZ9i0BsO72ez9p1/wTVq1
 C/3C8x2NY988UXmGmTInMjNXqRgq34aJvrjs/9ktMXoujZGT8CM+nzeDDdN93Nw9t
 xGIDO0UkvUjKSFSo0BTN+FCR2OGmjBQIRXY9H3UPeUSDqNq6ayXyLrbE5c0VJcjar
 TUxQi/Z2kI+Uc4Zj5LGA+9niHbtGTcZHjeZJ3wznat0EhwcRosfjmKPMr6BLDh0OL
 Inp2gCXsrhVa7g8YFH8V89mhenHzA3Lh7u5BsUXKM3shDlbY38W6otKk6ogu0Husi
 YCvN7qwvZKCVBIrgxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([141.58.38.32]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1w5xnZ01mz-015ohg; Mon, 24
 Nov 2025 09:39:00 +0100
Date: Mon, 24 Nov 2025 09:38:57 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Zhang Chen <zhangckid@gmail.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Peter Xu
 <peterx@redhat.com>, "zhanghailiang@xfusion.com"
 <zhanghailiang@xfusion.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
Message-ID: <20251124093857.1fa22ded@penguin>
In-Reply-To: <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
 <aQu6bDAA7hnIPg-y@x1.local>
 <b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.com>
 <CAK3tnvK2h4gDYZn_P-mQPhM5qvSkPy2FJ_EzKqyMU9ZcyT8TTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kb=8f9B2PaZ=J7kJiCHBNsd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ajd9gOPG4p9RDhVE4BTLYQLjCqda2oNSHLtT3ZBitklKz6Awz5u
 Uvd0WnWtwOWyijLis3w2bgnRSzg0kYQtMAFvPacya8wxU476XKlkWEV/q3L08KMuCMDtUu9
 rDaPa1JpPmSfqIUgZTm9mXOgCtNnbzvVKDInlVitJcAzwZFa5VlkQvJCWz11+1iPSxCiZcd
 wvj3IIkCLY+ovgvq5Gt9A==
UI-OutboundReport: notjunk:1;M01:P0:KXgd9K0oRJs=;1gN7UE2LKkh12DLpi7Nh8EWUVFc
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--Sig_/kb=8f9B2PaZ=J7kJiCHBNsd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 11:21:56 +0800
Zhang Chen <zhangckid@gmail.com> wrote:

> On Thu, Nov 6, 2025 at 9:10=E2=80=AFAM Zhijian Li (Fujitsu)
> <lizhijian@fujitsu.com> wrote:
> >
> >
> >
> > On 06/11/2025 04:58, Peter Xu wrote: =20
> > > On Tue, Nov 04, 2025 at 09:36:06AM +0800, Li Zhijian wrote: =20
> > >> Commit 4881411136 ("migration: Always set DEVICE state") set a new D=
EVICE
> > >> state before completed during migration, which broke the original tr=
ansition
> > >> to COLO. The migration flow for precopy has changed to:
> > >> active -> pre-switchover -> device -> completed.
> > >>
> > >> This patch updates the transition state to ensure that the Pre-COLO
> > >> state corresponds to DEVICE state correctly.
> > >>
> > >> Fixes: 4881411136 ("migration: Always set DEVICE state")
> > >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > >> ---
> > >> [...]
> > >
> > > Thanks a lot for fixing it, Zhijian.  It means I broke COLO already f=
or
> > > 10.0/10.1..
> > >
> > > Hailiang/Chen, do you still know anyone who is using COLO, especially=
 in
> > > enterprise?  I don't expect any individual using it.. It definitely
> > > complicates migration logics all over the places.  Fabiano and I disc=
ussed
> > > a few times on removing legacy code and COLO was always in the list.
> > >
> > > We used to discuss RDMA obsoletion too, that's when Huawei developers=
 at
> > > least tried to re-implement the whole RDMA using rsocket, that didn't=
 land
> > > only because of a perf regression.  Meanwhile, Zhijian also provided =
an
> > > unit test, which we rely on recently to not break RDMA at the minimum.
> > >
> > > If we do not have known users, I sincerely want to discuss with you on
> > > obsoletion and removal of COLO from qemu codebase.  Do you see feasib=
le?
> > >
> > > Zhijian, do you have any input here? =20
> >
> >
> > If we don't have any known users, I personally have no objection to rem=
oving COLO.
> >
> >  From my previous understanding, its use cases are rather limited, and =
the checkpointing overhead is significant.
> > Moreover, with the continuous development of Cloud Native over the past=
 decade, service-based
> > FT/HA solutions have become very mature, which shrinks the use cases fo=
r VM-based FT solutions even further.
> >
> > I think it's worth keeping if we have:
> >
> > - Active users who depend on it.
> > - A unit test for the COLO framework.
> >
> > Thanks
> > Zhijian
> >
> > =20
>=20
> Add CC Lukas.
>=20
> [...]

Hello Everyone,

Thanks for bringing this to my attention.

I will write a migration unit-test and take maintainership of the colo
components.

Peter, what is your plan with refactoring the migration code and where
is the colo code blocking you?

I have quite a few cleanup patches lying around. Are you open to take
these in advance before the next merge window opens?

Best regards,
Lukas Straub


--Sig_/kb=8f9B2PaZ=J7kJiCHBNsd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmkkGaEACgkQNasLKJxd
slgJIxAAovGtBOxdxWujLwOQpgQ+Gp1QUVoyAU+0jOUaMxU7LlE4/s3cEbvLEYoT
UY+xFujDP1ko3ytRL861wQKw0TwMvnpX6V/lG10THI2so/+R9zNUxrBFxUoJg3q4
whpn7oJ7ICWcNS9kagri8dEJWt5tJjkH2ueHzmMcm05gtdosiNvWDjmrYChuaJr8
c+mOMniQDvC8vT4BX0UHIxhje05iHLitoLZ/36hWRHMdtR6dYtMFctFRL3zevX7w
F+ARmYjnxChOqke2ftZfO8iT2QpYkoz9VcsGsrENDKha7v24mRtVtNOzKxaHa1k2
OdMpmuBPpyqdysWEBs6pzta7AIhkLyq7ad3D58m3UzmjI/MzbmgJDrF4+dn1q3vk
clI1PbnANw+SEVN4yscOtxjqTh20c6gzj4mfW7iuuwaf/pNzz3qrUi5UnbRpWGi0
Y8GZLPZ2yDgGaVyFFs2Ao9cHTU+JrbJ73F2a6RqdWl8/984ZqFqE1CgKH4e2pjBG
AjFULuY1nK2nQaO9RIUZOYs4dburKQ97frpmrhQ01PFQXpqT5cCF8hoUpl9nLSgw
1JVaSij97oGcPMoZ+p8zPndhTttrYx9WMjQOXICPsbgRfrP0iKcfnQdtmB01XOE3
1pX5TwjnZJcutOSlfS4BlvlQDOUgel29OnJ0FmjZ3wFFhNWpPiQ=
=RWzs
-----END PGP SIGNATURE-----

--Sig_/kb=8f9B2PaZ=J7kJiCHBNsd--

