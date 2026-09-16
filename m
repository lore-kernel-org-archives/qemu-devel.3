Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B997C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCl-0002pg-2V; Mon, 21 Sep 2026 09:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCi-0002p9-Hl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCg-0002iz-Sm
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZWP8GLzosim+qyzIqSdMYTs7f6LrQHjJwP88asYn14=;
 b=YGMqNkJ6gk4JJ3jg7wnAqdH1yoc4btQxhvWrkn6v/Nzy+HHxwrlf7hbOsTIsEk1S4B51pm
 E7gydfmY8LKCk0YzCkIJNO3A4dbII+EOpP5cERv3EqYP1q/UM37v5c/ii2IEjUpm9H3coU
 b05ZHsSLwVxdQao85goAOgbSfNlRdms=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-b0ojyw1JPMSyCg-JS1J7Pw-1; Mon,
 21 Sep 2026 09:37:02 -0400
X-MC-Unique: b0ojyw1JPMSyCg-JS1J7Pw-1
X-Mimecast-MFC-AGG-ID: b0ojyw1JPMSyCg-JS1J7Pw_1789997821
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 991CA195D02E; Mon, 21 Sep 2026 13:37:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E65D180034C; Mon, 21 Sep 2026 13:37:00 +0000 (UTC)
Date: Wed, 16 Sep 2026 15:36:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 05/13] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Message-ID: <20260916193626.GB162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-6-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="giYP/nI99+MlqnzZ"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-6-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--giYP/nI99+MlqnzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 06:16:47PM +0800, Zhang Chen wrote:
> Replace raw object_ref/unref calls with iothread_ref_and_get/
> unref_and_put_aio_context in iothread-vq-mapping. This allows
> tracking IOThread users via the device's canonical QOM path,
> improving lifecycle traceability for virtio-blk and
> virtio-scsi devices.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  hw/block/virtio-blk.c                   |  8 +++++++-
>  hw/scsi/virtio-scsi-dataplane.c         |  9 +++++++--
>  hw/virtio/iothread-vq-mapping.c         | 20 +++++++++++++++-----
>  include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
>  4 files changed, 34 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--giYP/nI99+MlqnzZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq77oACgkQnKSrs4Gr
c8jQ+QgAhIekZwEKizm7q/w40PgQ/6IuD1jyOXCnWLQKucVQxul6ysXuQJao81wS
h0QVuWsLdX9yez+lXHV7fkIkYJMfF/K9VfYvorVhFKIDIZT/U7XhXWeUam03nFFg
TjLBvKJWAgz4CYxR9R5ejwIJ209sUCL+/OyhTumSgDKPezTo+BM3ZVWKmMffKJFi
swOPnZ2OlArvMjympqgpmNsABfWC2pLMznA3K2VrjvgFAPvz6tIh93SXJ8e08RPC
Yzl7aGlHZLBlO2yaLL362KDaXc/D1S0UYzbFDZ2l9Yt/aZPiPy8yVzKwxD4dRh8b
QDAYCBZjtphjTmrOwfqi55Totq55Bw==
=M8aa
-----END PGP SIGNATURE-----

--giYP/nI99+MlqnzZ--


