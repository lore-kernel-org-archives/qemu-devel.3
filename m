Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85ABC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x90bS-0006ps-8g; Tue, 22 Sep 2026 09:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x90bM-0006n4-HJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 09:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x90bJ-0007AT-3p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 09:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790083919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpG8hWKLkizcxoKaf2Kja6R4c1ny+IUramef1oEWEvc=;
 b=Om+HZAsDVKCzjNbMS/Q+t3FqHe75bzaR8ORS0koGHSfUXt7LQWdhiCLc3CCecvnfpIMFhe
 kHDOxXJEn1pELXB0DdiQpEPif1n7cxWbYv13g0qwsSSYuEIRKJn5CkPM0iRppjB0yuqO9x
 COtN7/QLVfGvBs+F1XwdGaEgLq0e4pM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-AdpnkFk4NCOxDvWR2cg5rA-1; Tue,
 22 Sep 2026 09:31:55 -0400
X-MC-Unique: AdpnkFk4NCOxDvWR2cg5rA-1
X-Mimecast-MFC-AGG-ID: AdpnkFk4NCOxDvWR2cg5rA_1790083914
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FE0E195FE11; Tue, 22 Sep 2026 13:31:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5C141800446; Tue, 22 Sep 2026 13:31:51 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:31:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <arKDQRZ7q7k0JvG1@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OpGrdwtXgZWLYaor"
Content-Disposition: inline
In-Reply-To: <20260921204126.GC115897@fedora>
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

--OpGrdwtXgZWLYaor
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.09.2026 um 22:41 hat Stefan Hajnoczi geschrieben:
> On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
> > On 03.09.26 16:08, Stefan Hajnoczi wrote:
> > > On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
> > > > Based-on:<20260724152315.234183-1-hreitz@redhat.com>
> > > >            [PATCH 0/6] hw/[block]: Fix missing accounting
> > > >            Fri, 24 Jul 2026 17:23:09 +0200
> > > >=20
> > > > Hi,
> > > >=20
> > > > I=E2=80=99m told there are installations where storage is very slow=
, and some
> > > > would like the VM stack to report this proactively.  To do so, we s=
hould
> > > > (via QAPI events) report on extremely slow I/O requests.
> > > >=20
> > > > We already have the latency histogram, but this is not deemed suffi=
cient
> > > > because it is not proactively reporting and would require repeated
> > > > querying.  Therefore, this series introduces the event still.
> > > >=20
> > > > Now, from a user's perspective, it would be nice if this event coul=
d be
> > > > raised exactly when an I/O request crosses the user-defined thresho=
ld,
> > > > but this would require keeping all active requests in a list and
> > > > checking it periodically.  Now, if we used latency cookies for this
> > > Did you consider a per-request timer? The QEMUTimerList active_timers
> > > sorted list does not support efficient insertion, but improving it wo=
uld
> > > benefit all timer API users.
> >=20
> > I'm not sure how that would address the problem. Does that not just mov=
e the
> > list elsewhere?
> >=20
> > I.e. it still has the problem that every request needs to be put into a=
 list
> > (starting a timer), and be removed when the request is done, or the tim=
er
> > will fire and the below problems would occur if the request is done but=
 we
> > failed to remove it (either use-after-free; or spurious events plus mem=
ory
> > leaks on top of a heap allocation per request).
>=20
> I wasn't thinking about the lifecycle here, but about the current
> limitation that users aren't notified until request completion. Requests
> can be stuck for a very long time or forever. Using a timer solves the
> timeliness problem.

I think we'll need to do this eventually. There was also talk about
stopping the VM if a request hangs for too long, which will definitely
need a timer.

But I think this specific series can work without it for now. Once we do
have the timer anyway, reporting the latency right when the threshold is
crossed can still be done.

We should be careful with the wording in the documentation to allow both
behaviours so we can make this change in the future.

> > > > (which makes sense), then that would require that every cookie set =
up is
> > > > also finalized when the request is done, because if we don't, resul=
ts
> > > > could well be catastrophic:
> > > > - Either we use cookies as-is, which are often allocated on the sta=
ck or
> > > >    in some other structure managed by the device; then this would r=
esult
> > > >    in use-after-free,
> > > > - Or we allocate something specifically for this checking, so linge=
ring
> > > >    requests would at most create spurious latency events and memory
> > > >    leaks, but this would require an additional heap allocation per
> > > >    request that we would probably want to avoid.
> > > >=20
> > > > So ideally we could use latency cookies and could statically verify=
 that
> > > > they are always finalized when the request is done, but doing this =
in C
> > > > may well be impossible.
> > > I think you are saying that the cookie API is unsafe because cookie
> > > lifetime is not bounded by the request lifetime?
> >=20
> > Yes, because it is not statically proven to be so.
> >=20
> > > Maybe the block_acct_*() API can be integrated into the actual request
> > > so there is no way to leak the cookie. In other words, directly
> > > associate requests with a BlockAcctStats and stop requiring the user =
to
> > > manually manage a separate BlockAcctCookie.
> >=20
> > I don't follow what you mean concretely. If you are suggesting a list of
> > requests in BlockAcctStats, then that is exactly what I had.
>=20
> I meant that each I/O request should contain its own cookie and there is
> never a need to create a cookie separately from the request. That way
> the lifetime issue is solved.
>=20
> This would require API changes because device emulation code currently
> has some of the logic for cookies. Devices would no longer call
> block_acct_done() once they have called blk_aio_pwritev(), for
> example. I haven't looked in detail and am not sure if it's feasible.
>=20
> > The problem is that if the destructor has to be called explicitly, we m=
ay
> > forget to do so; and accounting is done on the device emulation level, =
so
> > there is no central place where the pairing of constructor and destruct=
or
> > would be obvious and trivial to verify.
>=20
> This is the part I'm asking about: can accounting be done by the block
> layer? There might be cases that are purely handled in device emulation
> code without a call into the block layer. In that case the accounting
> still needs to be done in device emulation code. But when device
> emulation calls blk_aio_*(), it should not do accounting itself.

Apart from cases where requests are completed entirely within the
device (like for all block_acct_invalid() callers), there are also cases
where a single device-level requests involves multiple backend-level
requests. I was thinking of IDE TRIM initially, but actually I think
splitting can happen for any request that uses the DMA helpers.

Conversely, virtio-blk can merge requests, so you get a single request
in the backend that covers multiple requests in the device.

Kevin

--OpGrdwtXgZWLYaor
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmqyg0UACgkQfwmycsiP
L9YD9w/+OjI/c8nERTBkvUIVXRKXqq+ZXJV8dSkUzXOy4oQrLkIszvXEMEvwbY7o
CqO3ktxt+sLxsurT8qsxnozvrwPJBmWM025Rx/UYqZle7atd+OzmgmVntvMsuZhc
FEm0+PBzLDE1D5jdv3FzYSCFsPQd9N9YL+LNVrvRQsB/4RendyW+tgTclOQ507vP
s/ZN6cCkLmrFn9Sf/iXn9xdcXmU2tNLlciJ8Fh97dTKgToNEAsPUWhUKOo2TI4Ld
ahR5e4aknBM3gtaCg9h4YEcpk9BPVSYDr6783s56Bhn/UUha/r0RzZ6CjaX1RLXT
J9zYVi90wd4BG/YWmdTNk8ueyHrjX84RVUyXPCwD2wPRY3xceJ5Sn8iQyAroxGs0
BMft16aXF9yrssQj+UtkJaOj/+SgKuoudxotv1cZXGgABNx3qI7RWnhmC9oBkOjg
8/+QjxlyrotHWWfSIsuCKQ5EBMU1ufVSc9H6PmfjqIQyflH1sDnV2fQDwwieBai4
f7NZptNgYWA4Ec52A8M68axap30ELXtUG/ON4Jbf+SYGhpN8JFJ9AKkPtiNHDHOn
G9QCu/1KDfE3LzvMMDqzgPpGStKQbXQKmQ434fNTyBVg7Iajx8IA/IoWpOmsxNMr
JnEDNTidstK5L2IujxEDAvtI4O0Ui9WFpjkJGlv/lo8az0+bzyY=
=u/8M
-----END PGP SIGNATURE-----

--OpGrdwtXgZWLYaor--


