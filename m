Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F406C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kwf-0005bM-4f; Mon, 21 Sep 2026 16:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8kwd-0005ay-Hd
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8kwa-0001mB-1B
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790023735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKz15nPEPBIp/9s//EvqvzQjS/kj7suLcRTmAmS6v1U=;
 b=gu0izNL8gbg3emR5yGT4qtpAHniadcI7iKBkwEBuhPx3y9hRQSsUmBwanCTR/v5xaarsYU
 o7DNH+FwdM+fjmZFV/2aPoI/5/AJLmaB7jez1sMDvRKtdkaALwN4U69K/OPgCi15JThpXA
 lFSM4FbIgy09swbZJ0K72wpntGidK0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-0ac3xSRVPKi4bw2_yhAZ_A-1; Mon,
 21 Sep 2026 16:48:53 -0400
X-MC-Unique: 0ac3xSRVPKi4bw2_yhAZ_A-1
X-Mimecast-MFC-AGG-ID: 0ac3xSRVPKi4bw2_yhAZ_A_1790023732
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65AF11953963; Mon, 21 Sep 2026 20:48:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6888300106A; Mon, 21 Sep 2026 20:48:51 +0000 (UTC)
Date: Mon, 21 Sep 2026 16:48:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
Message-ID: <20260921204850.GE115897@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-7-hreitz@redhat.com>
 <20260903142359.GD825275@fedora>
 <28da45c4-51ce-452c-b7d7-a18b68d2dd1e@redhat.com>
 <ccada8d9-b94b-469c-9602-1d1085fdba47@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jcPDX8sebcdI7b1A"
Content-Disposition: inline
In-Reply-To: <ccada8d9-b94b-469c-9602-1d1085fdba47@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

--jcPDX8sebcdI7b1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 02:04:58PM +0200, Hanna Czenczek wrote:
> On 16.09.26 10:14, Hanna Czenczek wrote:
> > On 03.09.26 16:23, Stefan Hajnoczi wrote:
> > > On Mon, Aug 31, 2026 at 03:52:02PM +0200, Hanna Czenczek wrote:
> > > > When a request finishes with a higher latency than a predefined
> > > > threshold, emit the BLOCK_IO_DELAY event.
> > > >=20
> > > > Note there would be an alternative, more precise solution: We
> > > > could keep
> > > > all active cookies per BlockBackend in a list and repeatedly iterate
> > > > over it in a background coroutine (woken on a timer so it would wake
> > > > always exactly when the next request would time out, so it generally
> > > > stays asleep until there is actually a timeout). This way, we
> > > > could emit
> > > > the event exactly when a request crosses the delay threshold, while=
 it
> > > > is still running; and we could hypothetically even take actions like
> > > > pausing the VM until the request is done so the guest operating sys=
tem
> > > > is shielded from extreme latency spikes.
> > > >=20
> > > > In practice, this is very complicated because latency cookies are
> > > > created and finalized all over the place, so it is very hard to
> > > > guarantee that every `block_acct_start()` is matched by the right
> > > > finalization to ensure that cookies are properly removed from the l=
ist
> > > > when they are done. Even if we fix all non-matching places now,
> > > > there is
> > > > hardly a guarantee this will be kept in order in the future.
> > > I think this patch series already couples the accounting so closely w=
ith
> > > BlockBackend (i.e. adding the offset field into the cookie struct and
> > > adding a BB pointer into the stats struct) that we might as well fully
> > > integrate the two. Then callers don't need to manually manage cookies
> > > because BlockBackend does that internally and the concerns about
> > > lifetimes go away.
> >=20
> > I don=E2=80=99t follow how integrating them into BlockBackend automatic=
ally
> > solves the problem.
> >=20
> > Are you suggesting that blk_* I/O functions should do the accounting
> > instead of the device emulation code?

Yes.

>=20
> The thing is, AFAIU, doing that would cause changes in behavior, because =
the
> hardware device requests don=E2=80=99t always line up with the BB request=
s.

Did you find a fundamental incompatibility that rules out letting the
block layer handles stats for blk_aio_*()?

> What I could do would be to abandon the cookie-based approach altogether,=
 of
> course; instead creating a completely different tracking object in those =
BB
> functions and put those into a list. And then we could decide at a later
> point if we want to integrate cookies with that. The only downside I see =
is
> that this would mean the latency reporting would not line up with the
> requests reported in the stats, or the histogram.

The tracking object could be a timer! :)

Stefan

--jcPDX8sebcdI7b1A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqxmDIACgkQnKSrs4Gr
c8iMHgf/atxBRlKL5RC1hA/vyy0/Xcitc6dw1MZBzRQaqTfhpsDrPECG54XlhvkU
6/92V/PRmVmKvu4FImxRzkBknxw2LIb3ME+J+9BhaL1ixRovYpnRjE+cNaHkOI0H
1fAbPw/dLj7Wi94XsPzTHNBYke47c80LcBmPHPhT2GbVK9RAb0LMjec7Q/OyWKkL
ESSB9857xy5itlEQLZTi1Z4G48xgvDsXgOuCkSzCgbhgxqNZa6jroEta4n0mHcWu
6YwzS5UpJRorQR+GrU9cnDCZSwjbiT5Lcf1q7dWHQnlmZ/z4dIgRNI5fO+PXUUVB
WDr/Dvo79jcw3gJlnRdzVNQnoYei4g==
=qBVm
-----END PGP SIGNATURE-----

--jcPDX8sebcdI7b1A--


