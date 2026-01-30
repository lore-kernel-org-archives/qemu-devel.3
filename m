Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568FCE6BF0B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnx2-00073g-5o; Fri, 30 Jan 2026 07:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnwz-00071q-T7
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:50:14 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnwx-0000aw-1w
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769777396; x=1770382196; i=lukasstraub2@web.de;
 bh=R5nIHM6KP1Ud+Kc14eNAb2ZyGxe2eediwKQS002BhDg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bfJGd3c1W9jD6kGbpiCw6vsnASPDBLSSffZfx9XRlHlYrVeRDBN3A44XIjXA2PYw
 eNTD1E9cECdZ8eoL9ir7c1lxEDQoQQj89E/e0rtUgJzs4Kvf8RBFZz5vUe9/wzi2V
 3GqqPlfOTRXRRBujVPcvyw9ABTRdGPT3EuucfbWGxLpOe7afQWXw4+SRyujFdbGfb
 OQIernepJupU2f33Rfe5iWXtRmqFnNP0ogo7PTeux3DOO1WoAovek1yTv3tecvH4S
 sY0zIP24GZg117iNlebFW1ZL8Bg35taeZYcW50t3c/QVfnAFPhEg5QUtS4PAWtgvE
 Se5KqT3gF4MKMaxgcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1w0a8z41KI-013khQ; Fri, 30
 Jan 2026 13:49:56 +0100
Date: Fri, 30 Jan 2026 13:49:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 05/10] colo: Fix crash during device vmstate load
Message-ID: <20260130134942.721a2758@penguin>
In-Reply-To: <aXkiX-jvFOieE9FG@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-5-ae926ccd8eae@web.de>
 <aXkiX-jvFOieE9FG@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fsV0531OPH2eh1/=ew5mXEL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:EDToBtEfxfwUEfh3nH8qY32Gm0A8pucKnqhne+s4FaPps4IFXM+
 H29ao5dw/SrtEFN4ZunE/43K4uFJqLc1ei07dKhRTgPOU/xWGtzBsCMj0slkN/BM5opDKlG
 QiEnwJduAlanqU3KTuOXIhZ8jnB1JFVTRg0hcRIs65sc6Guh4RwQGs+fVIzsCAHX4M4tcgj
 mL/4gUWnTwrRuP9EwGGHQ==
UI-OutboundReport: notjunk:1;M01:P0:i5E7nUqnIZg=;n/PBf2lsJcJXb/2PNJUiM2Llr7e
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--Sig_/fsV0531OPH2eh1/=ew5mXEL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Jan 2026 15:38:55 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Sun, Jan 25, 2026 at 09:40:10PM +0100, Lukas Straub wrote:
> > With colo we load device vmstate during each checkpoint, on top of
> > a vm that was already running. Some devices expect a reset before
> > loading vmstate on such a previously running vm.
> >=20
> > This fixes a crash when using COLO with Q35 machine.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> Yes makes sense, maybe you can add some comments into the code too since
> this was overlooked before,
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
> Have you tried to measure how many overheads will this introduce to loadi=
ng
> each snapshot?

It's a large overhead actually, between 10-20 milliseconds.

Regards,
Lukas Straub

>=20
> > ---
> >  migration/colo.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/migration/colo.c b/migration/colo.c
> > index db783f6fa77500386d923dd97e522883027e71d8..627b3706687036554eda390=
9b4194116a7640493 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -727,6 +727,7 @@ static void colo_incoming_process_checkpoint(Migrat=
ionIncomingState *mis,
> > =20
> >      bql_lock();
> >      vmstate_loading =3D true;
> > +    qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
> >      colo_flush_ram_cache();
> >      ret =3D qemu_load_device_state(fb, errp);
> >      if (ret < 0) {
> >=20
> > --=20
> > 2.39.5
> >  =20
>=20


--Sig_/fsV0531OPH2eh1/=ew5mXEL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml8qOYACgkQNasLKJxd
slgfGQ//W+cdg9ZRCZW9DF0VXrxdL77fT5DFUZf7LEAgOopt8211xopBOxDfazXD
C/RUvUXatNWhSXVUfzFy8UsBqNrmOIkVR19ZxnV8gr5b3gUzeiRrW/36eAS4WRKl
i5avJz4TrANnHnS2p9lpampqmKHQ/YvNOijpHOmTXupevZUj/VT5lc+c1YdtX4eB
KmAmXZEkSCQ23MVKvEHji8CPufoZvvCHsHJmx94O98rJSU+01s1aii6Sc5GZSjo8
oRMM2DGKv14nveOhLWmx3fHRm0egPrVNkBCS417whW2e5tQHeANlgraZ3n4h+oPe
CMUMl2Uze0b0BKiehJRAt3CJQMKKKfLxz8iNfmFMvKzJxcje5e1TeIcv+NnRNzcl
V7M1pTlDCUGFKo/8SKjwLMFWSfsHAEFf9/d9+T8AekGuH4Goe0qRc91V1Xh2KQQk
/2pplDndxEFbAvAvo262kT/t8zw5j/0pv95+coGJThc+24C46wT7fn3Wi6nNCd0i
2Q2R8yS0BI/WqmjxxWnL3Jp5RHy8gyQfzShbJZgbprEoFgFVqfEzbXFNOeAFlkp0
6qRj4IonVHwcgKojt0j0hYlC+cOe67PGZTr+luvDcD5lyqdS8nSFHhsB+DF9TU8D
88rhl9W6reevtxr36VD/7QEa6YM8NbdX1cMhjZ2D+DLTLPtAaog=
=FvAb
-----END PGP SIGNATURE-----

--Sig_/fsV0531OPH2eh1/=ew5mXEL--

