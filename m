Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4503BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVpw-0000SB-CF; Fri, 07 Mar 2025 06:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tqVps-0000Rt-2h
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tqVpo-0002Aw-CG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741346740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFRTlbvjSOjOegyVMo0ymctoNSuPn98Hrdo4uPNjNps=;
 b=IyrTiFtnkabXHzuDXFsVJSVjITuoo9K5VvTau1Yhh/VyvtOnGBLpAZlGADRDSdRIfeTqTB
 dO50YmwuWJNxcFX68f/Acgfw71zjcRvr21fRauSATec0YTH954wdjYJ1L2O10B7sHkly27
 7fCH2U3JiMEbtnr8AlUSI0Mm6zZO82s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-6TKKz5D9NjOmOkT0O9Q9Vg-1; Fri,
 07 Mar 2025 06:25:36 -0500
X-MC-Unique: 6TKKz5D9NjOmOkT0O9Q9Vg-1
X-Mimecast-MFC-AGG-ID: 6TKKz5D9NjOmOkT0O9Q9Vg_1741346735
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1DB419560B7
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 11:25:35 +0000 (UTC)
Received: from localhost (unknown [10.44.34.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45D92300019E; Fri,  7 Mar 2025 11:25:33 +0000 (UTC)
Date: Fri, 7 Mar 2025 12:25:32 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v4 00/11]
Message-ID: <ymk72bffcas5pzv5mmyo3ubgnyv72d2xepiinecaujocnizqil@i6tzfc3zgqwm>
References: <20250214202944.69897-1-victortoso@redhat.com>
 <Z7NOjiz20gzBQhX5@redhat.com>
 <zymp5hndhvvb6qvomct4kytoyxwgjtienz5ahlb4fbbuyffqpm@6ttbn2mod64w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ywt4hll4y5mz6sje"
Content-Disposition: inline
In-Reply-To: <zymp5hndhvvb6qvomct4kytoyxwgjtienz5ahlb4fbbuyffqpm@6ttbn2mod64w>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ywt4hll4y5mz6sje
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/11]
MIME-Version: 1.0

Hi,

On Mon, Feb 17, 2025 at 05:52:49PM +0100, Victor Toso wrote:
> On Mon, Feb 17, 2025 at 02:58:22PM +0000, Daniel P. Berrang=E9 wrote:
> > On Fri, Feb 14, 2025 at 09:29:33PM +0100, Victor Toso wrote:
> > > ################
> > > # Expectations #
> > > ################
> > >=20
> > > As is, this still is a PoC that works. I'd like to have the
> > > generated code included in QEMU's gitlab [0] in order to
> > > write library and tools on top. Initial version should be
> > > considered alpha. Moving to beta/stable would require
> > > functional libraries and tools, but this work needs to be
> > > merged before one commit to that.
> >=20
> > We don't need to overthink this. I don't think we're best
> > served by continuing to post many more rounds of this series.
> > Better to just get it into a dedicated git repo and iterate
> > via pull requests IMHO.
>=20
> Well, I'm happy to hear it. How the repo get created so we can
> move the discussion and patches there?

Now that pluggable backend [0] was merged, I take that we should
create a repo so I can submit a PR for to Go bindings. Who should
we ping for this?

[0] https://gitlab.com/qemu-project/qemu/-/commit/dde279925c97b

Cheers,
Victor

--ywt4hll4y5mz6sje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmfK16wACgkQl9kSPeN6
SE+8mQ//TikorpLETtw8s5BPjnyZzAlnbc1/mRX9ZVfaySE0HpLJ3OEhin72pM2W
E6x6ZBn2YfxS6+GCD/JMHK5IsqF1NWQcRzxYecPhg2c8Po9KjuKUo32XOdSGDTLP
krnoh6gt92RGiNsSab/SvD9f4M+84npoEnYWbqjXaxdkxSrRx/Q6TZNukSb6uF3J
h8x/i77YJD1M7fXvOzinpm404Oi8M+Yg6e0FxLERPOH/8UzAIjE04jiSukg7MB9b
cStG0tXFyIckigsqDSGZ3xrreu3GIpgiESSoRzsRpPBjK3n4gjv09LYN1NCnwqlF
kHOcMen52EFRdQDoV+jI/EGCxVhMjYADrSBDt+oXobtSbEB/ZXvc/rHej4FgY1O9
2BcG7wy5LJ/CgqAsMhgeUFvgekX//0024E/G9KPCNZqWvhG0YQqW7D0OuAsu+04u
W2zE3REyGIVJRlJT1kdo4qfMyNha5IwOkeEpNk7T+6H5XXXvuytKOiR+VLgtcYRA
pCI9ewx9jIdjHyJHxOIzRM1998lqEH4y4YfLiyN1KFc2lWjr/bKL9uBWa3LzaaAn
Ww3zJc7KtldRoP1f9JUqO4zEs1oZSitBuA9F17jQEOTVCFJ9Y1ZtwtCcRZtNs/up
MEK27kX9Eqo61QZu35pxBztuOxdlI4YO616c79PeVCfZ3xh6RPU=
=kqXV
-----END PGP SIGNATURE-----

--ywt4hll4y5mz6sje--


