Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0212C36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpGi-0002g8-DK; Thu, 27 Mar 2025 11:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpGh-0002fw-BZ
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpGf-00062R-QT
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743089740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVJbi9jSUcmExBus59v72mNs9lrHVlaais4lj3pr/sg=;
 b=c2SFZBEg8g/+0B19vT/TkTNafpfx0/RkKjtuTgxBGrX6VjJcgg4uwVRYBcXFqKjPphq357
 4J3CGN9lAjxhaSPzLtQDqtCeZlApSdUR7LmsALknNeCQltY0mVFJbUqoKr+QqRjKtE6vnN
 nTVQ50Fa4dHN3DdvNPUg6SN6kjEOuhY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-i-BFy3mePFKQsgwpJI-t9w-1; Thu,
 27 Mar 2025 11:35:38 -0400
X-MC-Unique: i-BFy3mePFKQsgwpJI-t9w-1
X-Mimecast-MFC-AGG-ID: i-BFy3mePFKQsgwpJI-t9w_1743089737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DD8F196D2CF; Thu, 27 Mar 2025 15:35:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EF2A1801751; Thu, 27 Mar 2025 15:35:35 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:35:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 12/15] fuse: Reduce max read size
Message-ID: <20250327153534.GL37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-11-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Eb5t77td+hdI8FU+"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-11-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Eb5t77td+hdI8FU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:52PM +0100, Hanna Czenczek wrote:
> We are going to introduce parallel processing via coroutines, a maximum
> read size of 64 MB may be problematic, allowing users of the export to
> force us to allocate quite large amounts of memory with just a few
> requests.
>=20
> At least tone it down to 1 MB, which is still probably far more than
> enough.  (Larger requests are split automatically by the FUSE kernel
> driver anyway.)
>=20
> (Yes, we inadvertently already had parallel request processing due to
> nested polling before.  Better to fix this late than never.)
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Eb5t77td+hdI8FU+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflcEYACgkQnKSrs4Gr
c8jpqggAwKZ52QmR6nB9tHXruJXDWPKwxdU/OXRqWiKxVKztSKVvG1XAImL6Gn3h
ZLqj3Skk8b2smfGM1vPJmpNBGWuZj3k5GHztaZxJtxZOsKPN5JwHxdfJsXK2LKMk
bzWpABCEza3O4fV2D8J5EsB4R+c5dQCXUVbGo+C5a0zafH4liK4KJBjvWIVQeqKm
u4fHnUd4qex2WCOS5SJ3peeV11ZtJhslKrBfNMNL3G9Qj0VbUgqpSHz5ii5dqedl
s8YiDbOZyvS6RrqGZ9hP79lIOwNlQkIk0EJDNLk89/L7FieIl14JoeiNNSKIgV4A
C/MUbtz1gNpJyfZ+s7liyN4X+5qUJQ==
=HOPT
-----END PGP SIGNATURE-----

--Eb5t77td+hdI8FU+--


