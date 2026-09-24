Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E36C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9knu-00026O-0Y; Thu, 24 Sep 2026 10:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9knQ-0001uQ-SE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9knO-0005Xs-Mg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790261491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HaDPFCElJxJzE73OnwjcyjypS7V/z1llxptWF5bYUS4=;
 b=iYiFlZw9TirX4ZTW2jDLWdOqqrA/7hdkfFDPo85cNNVX7MoyOisIc4DAgVPQZw9v81u1rv
 CWIoNMqRekCb0sXxLrEdoSITuQtXWGf9irfT/AeQGasLyFJo4LU5NB8CvHjVzJaWOYrh6C
 TTaLByzr5zB4KCk4SRh7Zut7+nM9pCU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-GOpeK4S0M8arvztgNhygwQ-1; Thu,
 24 Sep 2026 10:51:27 -0400
X-MC-Unique: GOpeK4S0M8arvztgNhygwQ-1
X-Mimecast-MFC-AGG-ID: GOpeK4S0M8arvztgNhygwQ_1790261486
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E2F71944B3E; Thu, 24 Sep 2026 14:51:26 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A85841D; Thu, 24 Sep 2026 14:51:25 +0000 (UTC)
Date: Thu, 24 Sep 2026 10:51:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <20260924145125.GB2966180@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora> <arKDQRZ7q7k0JvG1@redhat.com>
 <20260922171838.GA231912@fedora>
 <2c3712c9-24ba-4657-9ef3-f835fec48afb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BqsRmd1zCb2SS+y/"
Content-Disposition: inline
In-Reply-To: <2c3712c9-24ba-4657-9ef3-f835fec48afb@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

--BqsRmd1zCb2SS+y/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:52:17PM +0200, Hanna Czenczek wrote:
> On 22.09.26 19:18, Stefan Hajnoczi wrote:
> > On Tue, Sep 22, 2026 at 03:31:49PM +0200, Kevin Wolf wrote:
> > > Am 21.09.2026 um 22:41 hat Stefan Hajnoczi geschrieben:
> > > > On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
> > > > > On 03.09.26 16:08, Stefan Hajnoczi wrote:
> > > > > > On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
> > > > > The problem is that if the destructor has to be called explicitly=
, we may
> > > > > forget to do so; and accounting is done on the device emulation l=
evel, so
> > > > > there is no central place where the pairing of constructor and de=
structor
> > > > > would be obvious and trivial to verify.
> > > > This is the part I'm asking about: can accounting be done by the bl=
ock
> > > > layer? There might be cases that are purely handled in device emula=
tion
> > > > code without a call into the block layer. In that case the accounti=
ng
> > > > still needs to be done in device emulation code. But when device
> > > > emulation calls blk_aio_*(), it should not do accounting itself.
> > > Apart from cases where requests are completed entirely within the
> > > device (like for all block_acct_invalid() callers), there are also ca=
ses
> > > where a single device-level requests involves multiple backend-level
> > > requests. I was thinking of IDE TRIM initially, but actually I think
> > > splitting can happen for any request that uses the DMA helpers.
> > >=20
> > > Conversely, virtio-blk can merge requests, so you get a single request
> > > in the backend that covers multiple requests in the device.
> > Sticking to the requests as seen by the device seems like the cleanest
> > solution rather than cheating and counting host requests in some places.
> >=20
> > The idea to move the accounting into blk_aio_*() doesn't work well in
> > light of this.
>=20
> Does this mean you would be against separating delay monitoring from the
> rest of accounting?

I'm not against it. I just don't think we can push accounting down into
the block layer since accounting operates at the emulated device's
request level and there isn't a 1:1 correspondence between block layer
I/O requests and device level requests.

> Because to me that still sounds reasonable: To do delay monitoring in the=
 BB
> layer, separate from accounting cookies, to have a simple lifecycle and
> timely reporting.

Yes.

Stefan

--BqsRmd1zCb2SS+y/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmq1OO0ACgkQnKSrs4Gr
c8iNzQf8DpUoFTmDaxxKL+o4djW5DREFNZ5HdzwR+LPImVDBT76unraySl4NDGsD
SDaWyk7CWVuUvLGWaaDox7XL5r6glP0/blr3FalnJeQ7A5ssJcTcMu01aQsIaUO5
8/b7/PAYf7zC9T6HNQi3txNVddgaIM5HgPplBhvoFV45f2U6ATE1vheDk+yJMZVV
TSsXOBuDH1LC1sUq2glqCNtIBtxIawBhdqZd4gVh1Y+o9+Woh+Lvsty3IXDg6g55
4J7gVJZkBg4etPJQJwafIOPY6NhE1+Hwjs3AoCCHtKXcT7BeblL/pz8w0lxvahH5
m+Ii0Fh3b/JWuvVP9/sFUPH3QeUEHg==
=bt1L
-----END PGP SIGNATURE-----

--BqsRmd1zCb2SS+y/--


