Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C97FC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kqf-0004jr-Bj; Mon, 21 Sep 2026 16:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8kqd-0004ja-0Z
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8kqb-0000la-Ib
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790023363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+FXVGzPlhLUQcGXVfz8rUyOzVSs865XRaC4xKJ6/k0=;
 b=aUGk/J2tdLjLsEhcJ/xopJ3cGg1GysQzBWqDJtKgWJeHgtKVYDaph5HsG6nY1jFh6z+pbY
 nQruek3V1KGmLgJoNHvC4QzfFSPY2hfgB63kv9+1v7hvWF2kAehi6SiuBi6uSZeVEml28M
 SFx+ZqmTgAqQWhBpqMk1u7OLFHwBW4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-xrVDkdg3MzqwNmLrKECNEQ-1; Mon,
 21 Sep 2026 16:42:39 -0400
X-MC-Unique: xrVDkdg3MzqwNmLrKECNEQ-1
X-Mimecast-MFC-AGG-ID: xrVDkdg3MzqwNmLrKECNEQ_1790023359
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C96A019560B9; Mon, 21 Sep 2026 20:42:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D3FF180057E; Mon, 21 Sep 2026 20:42:37 +0000 (UTC)
Date: Mon, 21 Sep 2026 16:42:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 8/9] block/accounting: Move latency_ns override down
Message-ID: <20260921204237.GD115897@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-9-hreitz@redhat.com>
 <20260903150842.GF825275@fedora>
 <292ff2f9-b3fe-423b-9b36-ada26904a617@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZjcocTV0L2RXAo+Z"
Content-Disposition: inline
In-Reply-To: <292ff2f9-b3fe-423b-9b36-ada26904a617@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--ZjcocTV0L2RXAo+Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:21:22AM +0200, Hanna Czenczek wrote:
> On 03.09.26 17:08, Stefan Hajnoczi wrote:
> > On Mon, Aug 31, 2026 at 03:52:04PM +0200, Hanna Czenczek wrote:
> > > I am not quite sure why `latency_ns` is overridden by a fixed value in
> > > qtest mode because personally, I find it much better if I can
> > > individually change requests' latency by modifying the qtest clock.
> > It looks like tests/qemu-iotests/136 relies on a hardcoded constant so
> > it can check min/max/avg against known values.
> >=20
> > > But I'm not going to change existing behavior for the histogram and
> > > such, so I will just move this override after the latency has been
> > > evaluated regarding a potential BLOCK_IO_DELAY event.
> > That's fine if you aren't taking the same testing approach as
> > tests/qemu-iotests/136. I think the benefit of hardcoding the value for
> > testing is that it would become possible to trigger the latency
> > threshold without worrying about timing in the test environment.
>=20
> FWIW, as far as I understand, in qtest mode, `clock_type` is
> `QEMU_CLOCK_VIRTUAL`, so it is not dependent on the test environment anyw=
ay,
> but on the qtest clock. That=E2=80=99s why I don=E2=80=99t understand the=
 fixed latency
> value, but maybe it was just easier this way for 136 because this way it
> does not have to do a clock_step for each request.

Yes, I think you're right. I'm not sure either. :/

Stefan

--ZjcocTV0L2RXAo+Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqxlr0ACgkQnKSrs4Gr
c8g0Lgf/aoIbkW0m+MQVWEUbM1/6427JnvUGkLMdeEsG0LYTGgn5JrykDeMBLyUM
eH1C44gAiBHBI5Namd0/5R8UyWepeND4RY99QYDw9gIxTbwy/9r2ULi8NRaOZHCi
5oMz2cqjO1a/yXSm0Je1h7b9kT9R7UpKTeppRimBG7HVT93tIYliMF1Kqfm85Xgw
v+NhbQJPHs1dQbaZHY5sPOMwC1TQSs8cMaMA9xMxvU//FJoWPJ0xE/qyRXnxz7aX
gTjg4DYk6iJH/x78uyOm3mNzlqFh/WxpSGg8oNrFP1SlG1SE2gUENcWrXRwSaNcu
C338p3BBUBlp80gPvCfNLHOMxdSSAA==
=88Dp
-----END PGP SIGNATURE-----

--ZjcocTV0L2RXAo+Z--


