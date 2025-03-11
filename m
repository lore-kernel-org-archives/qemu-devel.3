Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31972C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvee-0002Oi-7i; Tue, 11 Mar 2025 05:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trveS-0002K6-30
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trveO-00048F-Sh
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741684304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFB5UuILg4EzSyK8rBh9M2mTo8hBiOgWaGrrMhlasOM=;
 b=MKVHSJr5qn7dFExWmqvQ/1vcA9FJfOpfg3Zjp2GlupMfzKROrY6pk6GQ38WqqF2iTJqPaG
 MOgnlXRR/D8+ov7vZIZ3QLmp3AQhY/sZqu94ZniOrNXoYnmnHuz6Rg8C/ZP1n6ndagGxoR
 k8vNQQDpJtqGjxKTe+9kUE7keqkl3c0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-IBLDNP53NJu_OWfD9RHEEQ-1; Tue,
 11 Mar 2025 05:11:43 -0400
X-MC-Unique: IBLDNP53NJu_OWfD9RHEEQ-1
X-Mimecast-MFC-AGG-ID: IBLDNP53NJu_OWfD9RHEEQ_1741684302
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34672180AF6A; Tue, 11 Mar 2025 09:11:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1867A1800373; Tue, 11 Mar 2025 09:11:38 +0000 (UTC)
Date: Tue, 11 Mar 2025 17:11:36 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 04/12] scsi: introduce requests_lock
Message-ID: <20250311091136.GA939747@fedora>
References: <20250213180043.713434-1-stefanha@redhat.com>
 <20250213180043.713434-5-stefanha@redhat.com>
 <Z87rIcwaBfAaxzLs@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TYPLOhPpcJHvsCZv"
Content-Disposition: inline
In-Reply-To: <Z87rIcwaBfAaxzLs@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--TYPLOhPpcJHvsCZv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 02:37:37PM +0100, Kevin Wolf wrote:
> Am 13.02.2025 um 19:00 hat Stefan Hajnoczi geschrieben:
> > SCSIDevice keeps track of in-flight requests for device reset and Task
> > Management Functions (TMFs). The request list requires protection so
> > that multi-threaded SCSI emulation can be implemented in commits that
> > follow.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Some of this feels quite heavy-handed, and I imagine that having to take
> the lock in every request could cause considerable lock contention only
> so that we can iterate all requests in a slow path.
>=20
> This works for now, but maybe in the long run, we want to teach the
> SCSI layer about (virt)queues, and have a separate request list per
> queue (=3D AioContext)?

I had ideas about AioContext local storage but decided it was complex.

Now that I think about it, maybe it's not that much more complex because
TMF processing still needs to schedule BHs in different AioContexts even
when there is a single requests lock. So keeping AioContext local
request lists might be in the same ballpark while avoiding contention.

For the time being let's use this code and if optimization is needed,
then this would be a place to start.

Stefan

--TYPLOhPpcJHvsCZv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfP/kgACgkQnKSrs4Gr
c8hqQgf/ZoYVIJve4D5UiYnLaybK579RHRqXVekxHm18ddrsONPcRWTTBwP1CKSP
LK1PbWWCLvWaw8cQgC792D6usiS97a6Oj+yWQ5FG6CzvJb503srGqnk8QlF9pHom
Cp4OdVz+wlmGZHHhBI8EkF9CKL/ni0XafLyqYF1GWeFTo1G2PJ2hIzq3Z5HRzl0g
zjomV1vzrDeC088V5JAgK8SlcV36BFr0ayyzFxEiIOXUECDLPAPU9VLdZKnNbL6r
P7urAZ8LO8hRGf3k4qg9Z7y+VsqOAM8Q69MrYze4O0YZTDueiLiT8EFkekCLsuqC
TMNsBjpxgjA6HToecbbJkC+izwCXfQ==
=Uiyw
-----END PGP SIGNATURE-----

--TYPLOhPpcJHvsCZv--


