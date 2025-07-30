Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743C4C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCXh-0006ub-2E; Wed, 30 Jul 2025 15:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhASO-0007sO-GP
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhASM-0003lg-Vc
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753895950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RHjjccjzK45fezCxm8utx11ZnLFNNtyFYw0IBEUa954=;
 b=aGz8rpQstfoi66O8VlHHuypMexu8/MKc+826V/mv4VSRe/dZDxRYq+MjbG8cYT0TdJ7D7G
 68wcdTfErT7nHZpZwJDwyrphWCNwoCSShyUPhdDtA4fUMTdK88GvpBvAifaI1i5/gIEyMC
 wMD4hNXhtNlrB/5CiJipGksrQNzcvoE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-ybRVMK9LNsqC2jEit0rWzg-1; Wed,
 30 Jul 2025 13:19:04 -0400
X-MC-Unique: ybRVMK9LNsqC2jEit0rWzg-1
X-Mimecast-MFC-AGG-ID: ybRVMK9LNsqC2jEit0rWzg_1753895943
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E76A180036D; Wed, 30 Jul 2025 17:19:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.197])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF3F119541B0; Wed, 30 Jul 2025 17:19:02 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:19:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 19/21] qapi/block-export: Document FUSE's
 multi-threading
Message-ID: <20250730171901.GD74304@fedora>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-20-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1JLfrY5rBr/vDaE9"
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-20-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--1JLfrY5rBr/vDaE9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 01:44:35PM +0200, Hanna Czenczek wrote:
> Document for users that FUSE's multi-threading implementation
> distributes requests in a round-robin manner, regardless of where they
> originate from.
>=20
> As noted by Stefan, this will probably change with a FUSE-over-io_uring
> implementation (which is supposed to have CPU affinity), but documenting
> that is left for once that is done.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block-export.json | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1JLfrY5rBr/vDaE9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiKVAUACgkQnKSrs4Gr
c8gm7wf/ZJTBxcbq+IqhYlkIACGxSD7t+5Net8eXoLJTXJVqHLVAIWGck7z1UIW8
LIhOSKZDuzunSBOlzsly7W/nYZFYSjp8ePL0Ir3+uqdjL8STQl2GJMPNbcxun6v5
w/YD4yzzjsnjP/gHFQYoDZ9jNHJtgP/P+mKN6UOVTvrXJDmtm4IjkFd66n6UIyQm
fEOeZInEX6TdrwuVfznCR2ThobtATfGFV0Mr07xh1QmwmbFPH6BImWVt9lKdXehB
3obgw6qlHpTfnzJl7Uvpkng01sBhTs6YKvPixf3XmnRB30uRQRCtoGo6Dz+WwU6S
NW040gPQis6kJcncxEtb88/doHn8tg==
=3eKq
-----END PGP SIGNATURE-----

--1JLfrY5rBr/vDaE9--


