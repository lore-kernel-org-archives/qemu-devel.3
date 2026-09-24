Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034AEC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9oEQ-0000dN-4t; Thu, 24 Sep 2026 14:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9oEN-0000be-Ru
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9oEJ-00010y-SZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790274694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jm562vhUglO6ST/v8yTZ2+tI5aHN7domCJjbFi7t1b4=;
 b=A/fxC2zZWnF0h/gGMFiyzO0ZAO8n1nWIcP/3aloBb2BzIFDuXduPRfBojkE2suf6FUK1Zb
 zXnkRMS4RPtLsGudVaiFmPj+8+kXjI8Qbs88FWA5NqhHeMRwdKYLDG7mHAEPNSlbngslxm
 fgqACckb+L0EFoJlhn/vZWf78YqlnEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-mPWJEs5oNFWH8TaLx2MlvA-1; Thu,
 24 Sep 2026 14:31:30 -0400
X-MC-Unique: mPWJEs5oNFWH8TaLx2MlvA-1
X-Mimecast-MFC-AGG-ID: mPWJEs5oNFWH8TaLx2MlvA_1790274689
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72CBB1802565; Thu, 24 Sep 2026 18:31:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.118])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9E99426; Thu, 24 Sep 2026 18:31:26 +0000 (UTC)
Date: Thu, 24 Sep 2026 20:31:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
Message-ID: <arVsedIxGVp7Y-Us@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora>
 <6a6a77e9-8acb-4312-aa38-e06f81ac882e@redhat.com>
 <20260924151754.GC2966180@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZbFU2h1B9dJfqt32"
Content-Disposition: inline
In-Reply-To: <20260924151754.GC2966180@fedora>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--ZbFU2h1B9dJfqt32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.09.2026 um 17:17 hat Stefan Hajnoczi geschrieben:
> On Wed, Sep 23, 2026 at 12:48:36PM +0200, Hanna Czenczek wrote:
> > On 21.09.26 22:41, Stefan Hajnoczi wrote:
> > > On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
> > > > On 03.09.26 16:08, Stefan Hajnoczi wrote:
> > > > > On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
> > > > > > Based-on:<20260724152315.234183-1-hreitz@redhat.com>
> > > > > >             [PATCH 0/6] hw/[block]: Fix missing accounting
> > > > > >             Fri, 24 Jul 2026 17:23:09 +0200
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > I=E2=80=99m told there are installations where storage is very =
slow, and some
> > > > > > would like the VM stack to report this proactively.  To do so, =
we should
> > > > > > (via QAPI events) report on extremely slow I/O requests.
> > > > > >=20
> > > > > > We already have the latency histogram, but this is not deemed s=
ufficient
> > > > > > because it is not proactively reporting and would require repea=
ted
> > > > > > querying.  Therefore, this series introduces the event still.
> > > > > >=20
> > > > > > Now, from a user's perspective, it would be nice if this event =
could be
> > > > > > raised exactly when an I/O request crosses the user-defined thr=
eshold,
> > > > > > but this would require keeping all active requests in a list and
> > > > > > checking it periodically.  Now, if we used latency cookies for =
this
> > > > > Did you consider a per-request timer? The QEMUTimerList active_ti=
mers
> > > > > sorted list does not support efficient insertion, but improving i=
t would
> > > > > benefit all timer API users.
> > > > I'm not sure how that would address the problem. Does that not just=
 move the
> > > > list elsewhere?
> > > >=20
> > > > I.e. it still has the problem that every request needs to be put in=
to a list
> > > > (starting a timer), and be removed when the request is done, or the=
 timer
> > > > will fire and the below problems would occur if the request is done=
 but we
> > > > failed to remove it (either use-after-free; or spurious events plus=
 memory
> > > > leaks on top of a heap allocation per request).
> > > I wasn't thinking about the lifecycle here, but about the current
> > > limitation that users aren't notified until request completion. Reque=
sts
> > > can be stuck for a very long time or forever. Using a timer solves the
> > > timeliness problem.
> >=20
> > I still don=E2=80=99t follow. The lifecycle *is* the problem if the tim=
eliness. How
> > to implement repeated querying is not the problem.
> >=20
> > FWIW, the series that I had with timely waking did use a timer. But the
> > timer is just not the problem.
>=20
> Regarding the lifecycle, I don't see a fundamental problem. It's
> possible to add a timer to block layer I/O requests and know for certain
> that leaks, use-after-free, etc are not possible because the caller
> doesn't need to juggle anything. Even if the caller has to juggle
> something, this is a C codebase where APIs are not always safe. That's
> not a blocker as long as they API design allows disciplined users to use
> it correctly. If I misunderstood your concerns and there is a
> fundamental reason why the lifetime cannot be made correct, maybe you
> can explain?

I don't think there is a fundamental reason other than that humans are
bad at writing correct C code, but that this is based more on Hanna's
finding that our existing code has bugs in this respect and she isn't
sure if she caught all of them.

The current consequence of missing the end of a request is that it isn't
accounted for, and that's it. After the change, it means that a timer
callback will fire long after the request is gone, and therefore work on
a stale pointer, so it may turn into memory corruption and crashes.

Maybe this can be mitigated by not referencing data bound to the request
lifetime, but just keeping a copy of type/offset/length or whatever is
needed for emitting the QAPI event, at the cost of a heap allocation as
Hanna explained in the cover letter. It would still mean that a bogus
timeout is reported.

So I agree that we'd want to have those cases fixed before depending on
correct block_acct_start()/block_account_one_io() pairing.

And I'm afraid that Hanna is also right that it might be impossible to
get this done by static analysis in our callback-heavy device
implementations. If the full request control flow were in a coroutine,
TSA could probably do it, but I don't think it can work with our actual
code. Maybe simple cases like virtio-blk could be covered with the
latest TSA improvements coming from the kernel (I would have to check if
they cover callbacks well enough), but the scsi-disk state machine looks
too complicated for this.

> > > > > When an I/O request hangs for a long time, the management tool wi=
ll be
> > > > > unable to detect that the threshold has been exceeded in a timely
> > > > > manner.
> > > > Yes. But why would that be a real problem?
> > > >=20
> > > > Given the request so far is only to notify users of their storage b=
lock
> > > > showing problematic latencies at all, there is no need to provide t=
he alerts
> > > > in actual real time.
> > > What does the current approach solve that is not already possible with
> > > the block latency histogram?
> >=20
> > See what I linked above. Apparently having to repeatedly query the hist=
ogram
> > repeatedly is not deemed nice enough.
>=20
> Why at the QEMU level though? Libvirt can offer an event based on the
> block histogram.

At what intervals should libvirt poll QEMU? And why should polling be
better than using an event?

> The utility of this new feature is not clear to me. How is this QMP
> event actually going to be used? Usually a feature has a clear use case
> and the cost of committing to the QMP API and maintaining backwards
> compatibility is easy to justify. In this case I'm not sure what the
> real use case is or whether this is something someone thought might be
> nice to have but may never use - we'll have to maintain it forever
> either way.

The idea is to show a warning to the user that their storage has latency
issues and they need to look into that. Ideally before the latency
reaches critical values that result in errors.

> (Timeliness makes the need for this feature clear to me. QEMU has to be
> involved either by pausing the guest itself or by emitting a QMP event.
> This is why I'm particularly interested in timeliness.)

If you want to prevent a in-flight request from timing out in the guest,
then yes, QEMU would have pause the guest. I think emitting a QMP event
alone wouldn't be good enough for this. (Even more so considering that a
'stop' command actually involves draining all requests.)

Kevin

--ZbFU2h1B9dJfqt32
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmq1bHwACgkQfwmycsiP
L9ZdQQ/+LsP8OuENCwQHqyBTcDhmF+F/gDP9PEJS1ax6aAdELTtcRou9fyKSqavx
dC7so1HzVoF6j5FfS1hH8Ovk2EQZsMk0THEl8KR7K6V1YcOq6+gJ5pKioBnKQiIi
Msdz+0tssbfQnyHE9aCqljw1wwAttD3WAnfKrMOe0kZ3bSY19gBVo5zD8i1CliLl
I36OCJjgwLBXK0c0QGP/1S67p5ZxeddFH6rAnBH+vaTGbV6Slecdhgyezu8OV/LY
D1B17NdqFiM8lOT5xXvkOR2awXWHHkdcTc3/3nZEMDQLFqcs2gSqkUe25R9k15Vu
ZwxN64zk00pLOHPQBAHDq2D4kG+yfnFkC+T9XrW71ThBjgakOwcVcFdqXM/5n/OW
rmrZ9+vQuDTLgSdXabWdL4Zvhr7+muOBNT89kfcdO9kuR2PsRReYK0MAj/TyyyOg
XalyLfygXodyyRh/cVaLTfC5u5iOwTlSK/0C7qZa0gceDQ/QQWHPwX9CiS6MJDwo
Dc8pXeNa9FDWscKo13YiAuXgt2XYwonaqxnn6j3vraZ4tPUVyWMYDGA5mb6vE1k/
nwbrL801++WJp7oMgGSQeJa9b3R4+Rf/run80WEZqx7TAJ+/uYGUT5yooyxdBe3Y
FA3InEFayeF2j7+k1kxNTH5+NXNzrOsYZSJNHNMEYk5OGg15s+o=
=6evD
-----END PGP SIGNATURE-----

--ZbFU2h1B9dJfqt32--


