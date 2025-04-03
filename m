Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B44C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0N7s-0001D8-P7; Thu, 03 Apr 2025 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0N7o-0001CW-Ht
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0N7m-0002je-Ui
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743696542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i6i7VJ3PsrNBVHXenjdVw0WcdHD0e4kWdvwc8HerVTc=;
 b=C/sD8QSSyqG6OIBR4IaTHpQ1xXCV75Mg7DikuNfDTRkh6lDl6W+zZMQbD3A4uMWYmAk1L7
 vKLbdzsrlEgEFFEE0vU+N/5RMIyLPRFFYa3g6C1Br33mAhzKei2AbgEO+LSWqe4S/xohkr
 B5dmc9mj0geS8ZYFl3/D3NkjY2GQoV0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-KTVyhtItNkmWJSCTJ0jhkw-1; Thu,
 03 Apr 2025 12:08:58 -0400
X-MC-Unique: KTVyhtItNkmWJSCTJ0jhkw-1
X-Mimecast-MFC-AGG-ID: KTVyhtItNkmWJSCTJ0jhkw_1743696537
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4766C1955BC1; Thu,  3 Apr 2025 16:08:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.203])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E375195609D; Thu,  3 Apr 2025 16:08:56 +0000 (UTC)
Date: Thu, 3 Apr 2025 12:08:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] [PATCH] block/file-posix.c: Use pwritev2() with
 RWF_DSYNC for FUA - update
Message-ID: <20250403160855.GC349582@fedora>
References: <20250403081633.158591-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="owDC9HSLUb9osZmA"
Content-Disposition: inline
In-Reply-To: <20250403081633.158591-1-prantoran@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--owDC9HSLUb9osZmA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 01:16:31AM -0700, Pinku Deb Nath wrote:
> The testing with "-t writeback" works for turning on enable_write_cache.
> I renamed the function to qemu_pwritev_fua() and fixed any typos.
>=20
> I moved the handle_aiocb_flush() into the qemu_pwritev_fua() and
> removed from the previously todo seciont. Initially I thought
> of only passing aiocb, but then I was not sure whethe I could
> derive buf from aiocb, so I added arguments for iovec and iovcnt
> into qemu_pwritev_fua().
>=20
> For handling buf in handle_aiocb_rw_linear(), I created iovec
> and passed its reference. I assumed that there will be only one
> buffer/iovec, so I passed 1 for iovcnt.
>=20
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
>=20
> Pinku Deb Nath (2):
>   block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA
>   block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA - update
>=20
>  block/file-posix.c | 54 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 12 deletions(-)

Thanks for sending this updates patch series. Please squash changes in
the future instead of appending them as separate commits. This means
editing previous commits (e.g. git rebase -i master) so that they
contain changes made after code review.

So if commit 1 is '+ printf("foo\n")', then instead of adding commit 2
to add a semi-colon to the end of the line, just edit the commit so it
is '+ printf("foo\n");' in v2 of your patch.

One reason to squash changes is so that git-bisect(1) works. Without
squashing, there will be intermediate commits that are broken and maybe
don't even compile. git-bisect(1) is only usable when each commit
compiles and passes tests.

Reviews also tend to prefer to see the final state of commits so they
don't have to review every incremental edit that was made (often
replacing code they already reviewed). It saves them time.

Thanks,
Stefan

--owDC9HSLUb9osZmA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfuspcACgkQnKSrs4Gr
c8gDiQf9FCDLqeXOX0ShqPK6SPWoQGasdB7jqEw4cG5DAKdVD1UxdrwV8tXB2X83
GJz53sLb0rs5xdFH1AE5NN3PhFdTpmn7JsSpKsaOGDEEYD2L3kTb1nPZDWhcMLRg
ZmIcuwh3DL9IVVdKpG/PzzP49nG3/8Y6BQbLi6sAsXyXM0HFDdXwFMKhwcpEBQu5
JZ4VfNmzR3t3YQlFXnclcikJMmXnomgroF1t+o+IBuYV6sAJqwLHm/p8Sg/j8iIt
+UX5/2ijtUA8g2jY0THMrDg+fdxW2r3vc1rlFDLhtHt5uwD26LjlbDRU7XieDrwD
mQI3SfYvvuZAYJmP/byfIX+hTCY1yA==
=RPtn
-----END PGP SIGNATURE-----

--owDC9HSLUb9osZmA--


