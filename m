Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074F7C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x948o-00022J-K5; Tue, 22 Sep 2026 13:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x948n-0001wi-3P
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x948l-00056b-Dt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790097526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Owhc5UQ3Ztf7nLWWD7tj3HsUJBJtfDL66xgtL1Sgv5U=;
 b=IX/dVG/u06/JyKGDxkHuhRfz30EgBlzUagmraed/62sxgy+TEyrQVp3ifkVuC/QkrZNP4C
 oqX3SIK5NbAF2CnHcFBWgi+3ICUbVUoR6BYmGIvqvldtDfQ7t6ri3LFIQ02uzYV8Cjtm1w
 cZBJx6cdbo6wuRPLcib2iGHxotiPjNM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-LkLQsHu9O8-W5JDHChg0gg-1; Tue,
 22 Sep 2026 13:18:41 -0400
X-MC-Unique: LkLQsHu9O8-W5JDHChg0gg-1
X-Mimecast-MFC-AGG-ID: LkLQsHu9O8-W5JDHChg0gg_1790097521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B26AA1935330; Tue, 22 Sep 2026 17:18:40 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BB4130001B9; Tue, 22 Sep 2026 17:18:39 +0000 (UTC)
Date: Tue, 22 Sep 2026 13:18:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <20260922171838.GA231912@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora> <arKDQRZ7q7k0JvG1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WT7tplgdF1OlFVdr"
Content-Disposition: inline
In-Reply-To: <arKDQRZ7q7k0JvG1@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--WT7tplgdF1OlFVdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 03:31:49PM +0200, Kevin Wolf wrote:
> Am 21.09.2026 um 22:41 hat Stefan Hajnoczi geschrieben:
> > On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
> > > On 03.09.26 16:08, Stefan Hajnoczi wrote:
> > > > On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
> > > The problem is that if the destructor has to be called explicitly, we=
 may
> > > forget to do so; and accounting is done on the device emulation level=
, so
> > > there is no central place where the pairing of constructor and destru=
ctor
> > > would be obvious and trivial to verify.
> >=20
> > This is the part I'm asking about: can accounting be done by the block
> > layer? There might be cases that are purely handled in device emulation
> > code without a call into the block layer. In that case the accounting
> > still needs to be done in device emulation code. But when device
> > emulation calls blk_aio_*(), it should not do accounting itself.
>=20
> Apart from cases where requests are completed entirely within the
> device (like for all block_acct_invalid() callers), there are also cases
> where a single device-level requests involves multiple backend-level
> requests. I was thinking of IDE TRIM initially, but actually I think
> splitting can happen for any request that uses the DMA helpers.
>=20
> Conversely, virtio-blk can merge requests, so you get a single request
> in the backend that covers multiple requests in the device.

Sticking to the requests as seen by the device seems like the cleanest
solution rather than cheating and counting host requests in some places.

The idea to move the accounting into blk_aio_*() doesn't work well in
light of this.

Stefan

--WT7tplgdF1OlFVdr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqyuG8ACgkQnKSrs4Gr
c8iH/gf/Z/A0hYnsn5qP9yPjW0UJhn0lHqC6a9mCEt1jomOcYc51xG1+ik1qwSDJ
RVsIolh8K7nGgB/zZ3VAM9Ane0vDCXmrdvOTdFJ1e5N0S+/nWoujs5UA1gIXp5La
jyK0pl/t/bu2mJNaY1WUu03YbZXOi7q23prH72+kifhGVJKb6gWejOWPIbS1NFtt
Z9873glXHkA5B0PxLWetuyvMUkJHffc638hJ35sDp+Vzf0PScVZfsS3EE3aa5y0a
D3vYyW/IU8Pc1127eojW6GAxf6aviuLar3gl6QpaGvIf08NJlRlsb2r0wNdvgayG
P9mFKpt1/OHj8O0qObQaPTPNZZFKPw==
=SnuB
-----END PGP SIGNATURE-----

--WT7tplgdF1OlFVdr--


