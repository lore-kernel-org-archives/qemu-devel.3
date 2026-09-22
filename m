Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B059C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x90Ad-0002jj-M1; Tue, 22 Sep 2026 09:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x90AN-0002iD-T9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 09:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x90AM-0004Hd-13
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 09:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790082248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ag0DIPgnl+12xKq0XSsB0hUPWOojZLU4HMfyZ5bQn1Q=;
 b=YxAK8Ef0LsjwbjAUX0P0zMt7ALRYuHh6XuUFU1bh4lnX+WOsTavKaYYpLWLDB4YnD4Cjtv
 1UefJsaVK9SVmuGTKQ1Xq8gbURYJk8fUGArYAGRH90uSi7C4W+aGTizihaQYmTgkvKtePj
 5lbRPB6AtqeqcLYy408JZ3bFtIu2gwc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-12xD9ZO6O7Gb8Ynv1iW50g-1; Tue,
 22 Sep 2026 09:04:05 -0400
X-MC-Unique: 12xD9ZO6O7Gb8Ynv1iW50g-1
X-Mimecast-MFC-AGG-ID: 12xD9ZO6O7Gb8Ynv1iW50g_1790082244
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9666219772EB; Tue, 22 Sep 2026 13:04:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFFE41800446; Tue, 22 Sep 2026 13:03:59 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:03:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, berto@igalia.com
Subject: Re: [PATCH 8/9] block/accounting: Move latency_ns override down
Message-ID: <arJ8tNgp9tDtKkfO@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-9-hreitz@redhat.com>
 <20260903150842.GF825275@fedora>
 <292ff2f9-b3fe-423b-9b36-ada26904a617@redhat.com>
 <20260921204237.GD115897@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8j9hOwVQ89UEnZ8x"
Content-Disposition: inline
In-Reply-To: <20260921204237.GD115897@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

--8j9hOwVQ89UEnZ8x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.09.2026 um 22:42 hat Stefan Hajnoczi geschrieben:
> On Wed, Sep 16, 2026 at 10:21:22AM +0200, Hanna Czenczek wrote:
> > On 03.09.26 17:08, Stefan Hajnoczi wrote:
> > > On Mon, Aug 31, 2026 at 03:52:04PM +0200, Hanna Czenczek wrote:
> > > > I am not quite sure why `latency_ns` is overridden by a fixed value=
 in
> > > > qtest mode because personally, I find it much better if I can
> > > > individually change requests' latency by modifying the qtest clock.
> > > It looks like tests/qemu-iotests/136 relies on a hardcoded constant so
> > > it can check min/max/avg against known values.
> > >=20
> > > > But I'm not going to change existing behavior for the histogram and
> > > > such, so I will just move this override after the latency has been
> > > > evaluated regarding a potential BLOCK_IO_DELAY event.
> > > That's fine if you aren't taking the same testing approach as
> > > tests/qemu-iotests/136. I think the benefit of hardcoding the value f=
or
> > > testing is that it would become possible to trigger the latency
> > > threshold without worrying about timing in the test environment.
> >=20
> > FWIW, as far as I understand, in qtest mode, `clock_type` is
> > `QEMU_CLOCK_VIRTUAL`, so it is not dependent on the test environment an=
yway,
> > but on the qtest clock. That=E2=80=99s why I don=E2=80=99t understand t=
he fixed latency
> > value, but maybe it was just easier this way for 136 because this way it
> > does not have to do a clock_step for each request.
>=20
> Yes, I think you're right. I'm not sure either. :/

What's even stranger is that both things were introduced in the same
commit. But it seems clearly related to 136 because the change was made
right before the test was added.

Berto, do you remember why you didn't rely just on clock_step?

I suppose we could just try to change the behaviour and fix up 136.
Behaviour under qtest is something I'd be okay with changing.

Kevin

--8j9hOwVQ89UEnZ8x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmqyfLwACgkQfwmycsiP
L9ZRHBAAjO4G867Cnuc8i9xUUsEBh6iuaVXtrSaBwC5IONXTAnqz8k0AGbM1iatV
z20RjulJcCd1TemIlTJDdqwqplbK5qcux1FMVK9vC/t2k+Da5001Qe1XqiVR3uJy
MUe3IzI82AUVj4g+kMIhuxBbercAy1zVmcj4LIn6T5Jhrk/TzrHT93B9w1wMKmQV
020sqfzptBT8iS9Hmmzt0ZuNVJk9DHNqXKiG2aa1VW8QoMTVgDAkIjXNtPGIqx+y
O4tXwmc1Kr3GB90fR0jZYOrarYUPpWrhQYdCwGZdHqBdOPBGpI7VSqozqfZTs/jK
cSRwFSCZAF7bLUaeBWQaLgVNvQ3dSEnhRqDgUQamT/CuCDvO4Li14DkUy/1kVuL+
IHCe9EEWcT7EFIG8dINFl9iV+RorwoY8BhVjea8hLhUAAoiC2xrESFJozZMdizf6
cudC8YDh2fzMCaCIb4f3LPgNvLzObqNamOlGhMudMIZw8FE58KZL8HuL5O5uoE7i
Ds2Lapbny17SF22h1yz9bAh8mCEciv3Xz+p0ZCgMLpYJV+hPqfIJBGIpaEu/osEc
havnBorVI+gdZi/iD8JwD43DeFCom/6i4FI+NVsqQHTI9o6NBittihWlNnie7g4B
c2p5OMfE2KjNu+03o6QHUzYWXH/cL0CR2azX5v50N6ve3cYI4wM=
=RNVU
-----END PGP SIGNATURE-----

--8j9hOwVQ89UEnZ8x--


