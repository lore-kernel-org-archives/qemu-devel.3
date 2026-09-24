Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BE9C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lDD-0008Ct-TR; Thu, 24 Sep 2026 11:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9lD2-000867-Vv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9lD0-00086j-Iw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790263081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vQpz8hwzE/I3pmuUInybIZM8xeLcsasBd5RpD56ljuI=;
 b=P4aZEk2HQQi9Ab5y37LAoa4aFeH4TTodO2svPlPt5QdV2pWoBFFMRpN7W/Tj0kFet5PpXD
 k+CmZZavrH/xXTfJOBXA3H5uWTofvdPRY3zsV8DtyiEzAEGpTn2Wr9ngMtGJUjViUSGiFP
 0Yf5kjbasKBZJKD8gdAXp2QW29JaZBI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-1z00DTUAN1aedMeaFYGsdQ-1; Thu,
 24 Sep 2026 11:17:58 -0400
X-MC-Unique: 1z00DTUAN1aedMeaFYGsdQ-1
X-Mimecast-MFC-AGG-ID: 1z00DTUAN1aedMeaFYGsdQ_1790263077
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3B881954102; Thu, 24 Sep 2026 15:17:56 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13EA7426; Thu, 24 Sep 2026 15:17:55 +0000 (UTC)
Date: Thu, 24 Sep 2026 11:17:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <20260924151754.GC2966180@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora>
 <6a6a77e9-8acb-4312-aa38-e06f81ac882e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ui/yl+H2/FLoU25X"
Content-Disposition: inline
In-Reply-To: <6a6a77e9-8acb-4312-aa38-e06f81ac882e@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

--Ui/yl+H2/FLoU25X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:48:36PM +0200, Hanna Czenczek wrote:
> On 21.09.26 22:41, Stefan Hajnoczi wrote:
> > On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
> > > On 03.09.26 16:08, Stefan Hajnoczi wrote:
> > > > On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
> > > > > Based-on:<20260724152315.234183-1-hreitz@redhat.com>
> > > > >             [PATCH 0/6] hw/[block]: Fix missing accounting
> > > > >             Fri, 24 Jul 2026 17:23:09 +0200
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > I=E2=80=99m told there are installations where storage is very sl=
ow, and some
> > > > > would like the VM stack to report this proactively.  To do so, we=
 should
> > > > > (via QAPI events) report on extremely slow I/O requests.
> > > > >=20
> > > > > We already have the latency histogram, but this is not deemed suf=
ficient
> > > > > because it is not proactively reporting and would require repeated
> > > > > querying.  Therefore, this series introduces the event still.
> > > > >=20
> > > > > Now, from a user's perspective, it would be nice if this event co=
uld be
> > > > > raised exactly when an I/O request crosses the user-defined thres=
hold,
> > > > > but this would require keeping all active requests in a list and
> > > > > checking it periodically.  Now, if we used latency cookies for th=
is
> > > > Did you consider a per-request timer? The QEMUTimerList active_time=
rs
> > > > sorted list does not support efficient insertion, but improving it =
would
> > > > benefit all timer API users.
> > > I'm not sure how that would address the problem. Does that not just m=
ove the
> > > list elsewhere?
> > >=20
> > > I.e. it still has the problem that every request needs to be put into=
 a list
> > > (starting a timer), and be removed when the request is done, or the t=
imer
> > > will fire and the below problems would occur if the request is done b=
ut we
> > > failed to remove it (either use-after-free; or spurious events plus m=
emory
> > > leaks on top of a heap allocation per request).
> > I wasn't thinking about the lifecycle here, but about the current
> > limitation that users aren't notified until request completion. Requests
> > can be stuck for a very long time or forever. Using a timer solves the
> > timeliness problem.
>=20
> I still don=E2=80=99t follow. The lifecycle *is* the problem if the timel=
iness. How
> to implement repeated querying is not the problem.
>=20
> FWIW, the series that I had with timely waking did use a timer. But the
> timer is just not the problem.

Regarding the lifecycle, I don't see a fundamental problem. It's
possible to add a timer to block layer I/O requests and know for certain
that leaks, use-after-free, etc are not possible because the caller
doesn't need to juggle anything. Even if the caller has to juggle
something, this is a C codebase where APIs are not always safe. That's
not a blocker as long as they API design allows disciplined users to use
it correctly. If I misunderstood your concerns and there is a
fundamental reason why the lifetime cannot be made correct, maybe you
can explain?

> > > > > (which makes sense), then that would require that every cookie se=
t up is
> > > > > also finalized when the request is done, because if we don't, res=
ults
> > > > > could well be catastrophic:
> > > > > - Either we use cookies as-is, which are often allocated on the s=
tack or
> > > > >     in some other structure managed by the device; then this woul=
d result
> > > > >     in use-after-free,
> > > > > - Or we allocate something specifically for this checking, so lin=
gering
> > > > >     requests would at most create spurious latency events and mem=
ory
> > > > >     leaks, but this would require an additional heap allocation p=
er
> > > > >     request that we would probably want to avoid.
> > > > >=20
> > > > > So ideally we could use latency cookies and could statically veri=
fy that
> > > > > they are always finalized when the request is done, but doing thi=
s in C
> > > > > may well be impossible.
> > > > I think you are saying that the cookie API is unsafe because cookie
> > > > lifetime is not bounded by the request lifetime?
> > > Yes, because it is not statically proven to be so.
> > >=20
> > > > Maybe the block_acct_*() API can be integrated into the actual requ=
est
> > > > so there is no way to leak the cookie. In other words, directly
> > > > associate requests with a BlockAcctStats and stop requiring the use=
r to
> > > > manually manage a separate BlockAcctCookie.
> > > I don't follow what you mean concretely. If you are suggesting a list=
 of
> > > requests in BlockAcctStats, then that is exactly what I had.
> > I meant that each I/O request should contain its own cookie and there is
> > never a need to create a cookie separately from the request. That way
> > the lifetime issue is solved.
>=20
> Okay, I understood with your other email, because to me, =E2=80=9CI/O req=
uest=E2=80=9D
> sounded like some kind of object and I couldn=E2=80=99t think of any. My =
mind did
> not jump to the fact that you meant the actual execution thread of the
> request, i.e. code, not structure.
>=20
> > This would require API changes because device emulation code currently
> > has some of the logic for cookies. Devices would no longer call
> > block_acct_done() once they have called blk_aio_pwritev(), for
> > example. I haven't looked in detail and am not sure if it's feasible.
>=20
> As said in the other email, doing this would most likely change behavior
> because we can=E2=80=99t or don=E2=80=99t want to reproduce all currently=
 existing quirks.
> Which may be good or bad. Bad for me in any case because it would be more
> work, but, well=E2=80=A6
>=20
> > > The problem is that if the destructor has to be called explicitly, we=
 may
> > > forget to do so; and accounting is done on the device emulation level=
, so
> > > there is no central place where the pairing of constructor and destru=
ctor
> > > would be obvious and trivial to verify.
> > This is the part I'm asking about: can accounting be done by the block
> > layer? There might be cases that are purely handled in device emulation
> > code without a call into the block layer. In that case the accounting
> > still needs to be done in device emulation code. But when device
> > emulation calls blk_aio_*(), it should not do accounting itself.
> >=20
> > > I.e. it=E2=80=99s not like our functions current look like
> > >=20
> > > ````
> > > run_co_ide_request() {
> > >  =C2=A0 =C2=A0 start_cookie();
> > >  =C2=A0 =C2=A0 run_co_request();
> > >  =C2=A0 =C2=A0 finalize_cookie();
> > > }
> > > ```
> > >=20
> > > Where the pairing of start and finalize are obvious; instead, start a=
nd stop
> > > are in very different parts of the code, in all device emulation code.
> > >=20
> > > > The API is already weird because devices use:
> > > >=20
> > > >     block_acct_failed(blk_get_stats(s->blk), &req->acct);
> > > >=20
> > > > i.e. why does the device have to reach into s->blk to access the st=
ats?
> > > > If the stats belong to s->blk, then s->blk should do the accounting
> > > > during the request lifetime.
> > > >=20
> > > > This would require a redesign of not just the cookie API, but also =
the
> > > > error policy API. There is also a wrinkle in that virtio-blk merges=
 I/O
> > > > requests and accounts the merges.
> > > >=20
> > > > > So, because it is basically impossible (or at least it would be v=
ery
> > > > > hard, and presumably require a large refactoring) to guarantee, w=
ithout
> > > > > additional heap allocations, that a list of active requests won=
=E2=80=99t run
> > > > > into catastrophic use-after-frees, this series does the much simp=
ler
> > > > > version first, which is to just raise an event when a request *fi=
nishes*
> > > > > and took more than a user-defined latency threshold.
> > > > Does this achieve the goal of warning when requests exceed a thresh=
old?
> > > According to
> > > https://redhat.atlassian.net/browse/RHEL-141617?focusedCommentId=3D18=
127333
> > > (and the following two comments), yes.
> > The issue says one purpose of this feature is to pause the guest to
> > avoid BSODs. This won't work if the request has to finish first, because
> > the BSOD occurs sometime after the treshold is reached but before QEMU
> > or any other component can react to the QMP event.
>=20
> I know. I linked to a specific comment chain that says it is enough for n=
ow.
>=20
> Whether the pausing is something anyone actually would ever want is a
> completely different story, honestly. It is an idea I had for the original
> design, but nothing that has actually ever been requested.
>
> > > > When an I/O request hangs for a long time, the management tool will=
 be
> > > > unable to detect that the threshold has been exceeded in a timely
> > > > manner.
> > > Yes. But why would that be a real problem?
> > >=20
> > > Given the request so far is only to notify users of their storage blo=
ck
> > > showing problematic latencies at all, there is no need to provide the=
 alerts
> > > in actual real time.
> > What does the current approach solve that is not already possible with
> > the block latency histogram?
>=20
> See what I linked above. Apparently having to repeatedly query the histog=
ram
> repeatedly is not deemed nice enough.

Why at the QEMU level though? Libvirt can offer an event based on the
block histogram.

The utility of this new feature is not clear to me. How is this QMP
event actually going to be used? Usually a feature has a clear use case
and the cost of committing to the QMP API and maintaining backwards
compatibility is easy to justify. In this case I'm not sure what the
real use case is or whether this is something someone thought might be
nice to have but may never use - we'll have to maintain it forever
either way.

(Timeliness makes the need for this feature clear to me. QEMU has to be
involved either by pausing the guest itself or by emitting a QMP event.
This is why I'm particularly interested in timeliness.)

Stefan

--Ui/yl+H2/FLoU25X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmq1PyIACgkQnKSrs4Gr
c8iZhAgAnK3kKgiwUGw64jXiTJYOb3HtG/EU8R/jxTvAWLAINnLNYzCB+xrOUtNr
QigIfanT785AiapS8Cs4XFkgp6L3Z3dFY+qlm9q0SUUYV9S+MT/SpxJa6iLjy9l1
fccdwwofUmBJTevaqXyOXvRJlWqE7RiCk8RDbDwpveTdZHnshA814I0netc7smDk
J/a7fwMGZUuJfjPKch9JDxnDE0X3YdVYNreyC1KSY6j++IaZnEDAQ+eg0evTF8S5
ri4SEIIkLL1cFGp9tdreDK8syBxmiFcuOsR8E11pl7+J1h3jG1PC8qvnb/iXe/28
q+b6duJpUWISxwboCjmtPcLZXvr4KQ==
=tAXt
-----END PGP SIGNATURE-----

--Ui/yl+H2/FLoU25X--


