Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E249E8384B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 13:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsKwK-0006c4-AB; Tue, 17 Feb 2026 08:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsKw3-0006U3-Qo
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsKw2-0005Fl-9H
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771334171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WCk7/M6HpMxbYOCs24x66PvPpibdm2O1LlU/3jKC9k=;
 b=ELEC5+zGPc8txZnuIzXBS2fJ/FmCOrEjXITxLNaw9XFWsMRLNcoW56A/C5LrRSbKsgTbWJ
 66EKstSbCn0VcgY1/MBJWL0pQONjNPyNSPddl7o/iScaN0UEPQAyxNLwKMxMT8tuAnBG4S
 pQcSd6J2ZtVtYjS3QnH/bLEq++VdD/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-eo1pbKKHNfue8pzJuUeTLQ-1; Tue,
 17 Feb 2026 08:16:08 -0500
X-MC-Unique: eo1pbKKHNfue8pzJuUeTLQ-1
X-Mimecast-MFC-AGG-ID: eo1pbKKHNfue8pzJuUeTLQ_1771334167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 582B91933F8A; Tue, 17 Feb 2026 13:16:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C27111954123; Tue, 17 Feb 2026 13:16:04 +0000 (UTC)
Date: Tue, 17 Feb 2026 08:16:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 1/3] aio-poll: avoid unnecessary polling time
 computation
Message-ID: <20260217131603.GA442289@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-2-jhkim@linux.ibm.com>
 <20260216152131.GB396170@fedora>
 <bca708cd-a776-4103-a328-fa6b3d65a47e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xHCoFsdalIJzfD1N"
Content-Disposition: inline
In-Reply-To: <bca708cd-a776-4103-a328-fa6b3d65a47e@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--xHCoFsdalIJzfD1N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 02:47:27PM -0600, JAEHOON KIM wrote:
> On 2/16/2026 9:21 AM, Stefan Hajnoczi wrote:
> > On Tue, Jan 13, 2026 at 11:48:22AM -0600, Jaehoon Kim wrote:
> > > Nodes are no longer added to poll_aio_handlers when adaptive polling =
is
> > > disabled, preventing unnecessary try_poll_mode() calls. Additionally,
> > > aio_poll() skips try_poll_mode() when timeout is 0.
> > >=20
> > > This avoids iterating over all nodes to compute max_ns unnecessarily
> > > when polling is disabled or timeout is 0.
> > Did you consider optimizing the case when polling is active and there is
> > no way around calculating the polling time? Glib has ordered data
> > structures that have lower operation costs than O(n).
> >=20
> > Stefan
>=20
> If I understand correctly, while optimizing the data structure to be chea=
per
> than O(n) is one approach, I believe bypassing the function entirely
> efficient
> for cases where timeout=3D0 is frequently triggered.
>=20
> Since the result of the calculation is not used at all in these cases, it
> seems
> to more efficient to skip the function than to optimize calculation itsel=
f.

Yes, skipping it when not needed makes sense and I'm in favor of it.

I was thinking that, separately from this patch, the data structure
might be worth optimizing since the value needs to be computed when
polling is enabled.

Stefan

--xHCoFsdalIJzfD1N
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmUahMACgkQnKSrs4Gr
c8irPQgAou/7YMFkIczWc0F5VRNAv3NLLkjNGc/OvJmFMInqmv4dnh5T3YykxSqC
1g9ucvS4r87Uego6Imvr8bZlXl9bPZUnsaYUVoY7AzgCIctosBJm2bXzV5jD8jSB
IRF9GYHOTRzeubcZUPOTpoZmnE8DWNtbJ8/OGdDpZJ0HxZqPBrdPjinuRw5DwKAY
Ko/73s2g768+Ed64t8uEruM7Zmu+EbGSm4yxwXOqache2HUPutzIeamO1YhD/aFC
tNCXc7wYZfkCWrUV5shihAXbC26EwiC6nOFe2la3Nc8t/YBvopHWBX8WS82WoFYD
5ZX0KdBn8rWXD+IXB1GR4+4qThJ1yQ==
=8hPW
-----END PGP SIGNATURE-----

--xHCoFsdalIJzfD1N--


