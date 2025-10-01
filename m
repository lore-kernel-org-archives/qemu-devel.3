Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37581CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yhR-0005PR-5K; Wed, 01 Oct 2025 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yhA-00059l-TQ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ygn-0004Iz-3H
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nnf9f3wQ1KjvUlRbvsmzC1Pg7xl6tn4yh36ROAXVrtc=;
 b=XSlsJV2OJNPUSEkPTUFAQIoH7W4GFPb/khzgzxgFfsuMtTwmZYIan5Q/kX8Xt8N/yy/g/W
 MFigtUnXbLdUHX6X23XwTBsK0V/0YNdnTgutFAw9uN2y++MbnL3s+hcrNdAjK5S73dxGVw
 97PPnTuwHgtHCD4zzxwn91FGmeomdTM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-y0gjCV2ZNx2lvU-OPlpPDw-1; Wed,
 01 Oct 2025 11:24:07 -0400
X-MC-Unique: y0gjCV2ZNx2lvU-OPlpPDw-1
X-Mimecast-MFC-AGG-ID: y0gjCV2ZNx2lvU-OPlpPDw_1759332246
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EDC5195608A; Wed,  1 Oct 2025 15:24:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9D89195608E; Wed,  1 Oct 2025 15:24:05 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:00:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: update inserted/removed nodes from
 BlockRAMRegistrar
Message-ID: <20251001150010.GA183984@fedora>
References: <20250930204555.162133-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pkjnU8mzbDeJGYDK"
Content-Disposition: inline
In-Reply-To: <20250930204555.162133-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--pkjnU8mzbDeJGYDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 04:45:51PM -0400, Stefan Hajnoczi wrote:
> This patch series fixes a bug in BlockRAMRegistrar: it currently doesn't =
react
> to block graph changes and newly inserted nodes lack RAMBlock information
> needed to map I/O buffers. This is important for vdpa-blk devices because=
 they
> rely on the ability to map I/O buffers.
>=20
> Stefan Hajnoczi (4):
>   block: add BdrvChildClass->propagate_attach/detach() callbacks
>   block: add blk_add_attach/detach_notifier() APIs
>   block: rename RAMBlockRegistrar->notifier field
>   block: update inserted/removed nodes from BlockRAMRegistrar
>=20
>  include/block/block_int-common.h            |  11 ++
>  include/system/block-backend-global-state.h |   9 ++
>  include/system/block-ram-registrar.h        |   4 +-
>  block.c                                     |  56 +++++--
>  block/block-backend.c                       |  44 ++++++
>  block/block-ram-registrar.c                 |  75 ++++++++-
>  tests/unit/test-block-backend.c             | 164 ++++++++++++++++++++
>  7 files changed, 344 insertions(+), 19 deletions(-)

I need to send a v2 because I forgot to squash in a compiler warning
fix.

Stefan

--pkjnU8mzbDeJGYDK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjdQfoACgkQnKSrs4Gr
c8hOqgf+JwNYGrl6cHke293+F3/RAXl2vge/LdmGo6rXH2+a/A4BrWbMiTyNb6QW
v1bAm2ZrM0MmxC6QGG2MNoZoypFWxGhJ6IPgSTtX/CoI9TnCjwyMWpddU3mAv0Da
MEG6yP3JhcJqCSvUv7sQtBG/bxgyyY0Oos6KPsP4iLhR32VXf63yhul4frPDDFPj
0LfAUQscwISoxyilwAyyswHMD0P3WUx+U6Yky4sJ0qwVev2vtP5nWRR5kay2Zc+K
8UznZOvGAo+V8/j4FEqZSiRtNfUDML/69r+UZNOmjunfOsMrmXAxL7WeUm8m4jdD
2szEGjwRDCQuaXCKU8mNBdNeAYQctQ==
=jFyv
-----END PGP SIGNATURE-----

--pkjnU8mzbDeJGYDK--


