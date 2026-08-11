Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E208C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wts1Y-0004fP-Lv; Tue, 11 Aug 2026 15:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wts1V-0004de-5g
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wts1T-0003Ff-Ji
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 15:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786476026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QrvDdTitIEldMA+HLf6MDff5/+znsieHEvyt1iNXKms=;
 b=XyrEmrGI68GYIKL7D3M6zR7XsHODAZJRJaOWn9LdZfXy7m3jUcruhXC3cwH83AHxxLBJEg
 MJSgb8poiYaVWoizLrb4Nd4iQbdVeKJOc84E5cvGSm7+b4FVYbf3CJvSuSOxfjHdWXINQv
 7MHvivu4cPsDhdvwSRTL5jxDxxPbYQ4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-syUeHIi4NGKbH7KiFGPBZQ-1; Tue,
 11 Aug 2026 15:20:18 -0400
X-MC-Unique: syUeHIi4NGKbH7KiFGPBZQ-1
X-Mimecast-MFC-AGG-ID: syUeHIi4NGKbH7KiFGPBZQ_1786476017
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57C801956042; Tue, 11 Aug 2026 19:20:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8D37180049F; Tue, 11 Aug 2026 19:20:16 +0000 (UTC)
Date: Tue, 11 Aug 2026 15:20:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V11 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
Message-ID: <20260811192015.GC170741@fedora>
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-5-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+YbDnjKjE+EkTgt0"
Content-Disposition: inline
In-Reply-To: <20260806202531.243806-5-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--+YbDnjKjE+EkTgt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026 at 04:25:13AM +0800, Zhang Chen wrote:
> Add an explicitly unsafe accessor for legacy callers that cannot
> provide a matching holder lifecycle, and convert blockdev.c to use it.
>=20
> Keep iothread_get_aio_context() temporarily so that later caller
> conversions remain independently buildable. It will be removed after
> all production callers have migrated.
>=20
> New code should use iothread_ref_and_get_aio_context().
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  blockdev.c                |  2 +-
>  include/system/iothread.h | 10 ++++++++++
>  iothread.c                |  5 +++++
>  3 files changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+YbDnjKjE+EkTgt0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7de8ACgkQnKSrs4Gr
c8jE8Qf7BMvmSCaH0Dygt1oeGnqbIlZ6aaocaX/jI8VFqwp1CFIIfvQmMTsiI4s4
mzLGgpM0wJbtqTQO7WZSuUa44gAnhSCYH1Uij5tCRcVRTcPZmB38l01f2rcGogHa
t0hITtfsKuTj1BcOBJzbWUeLzMqqPxGZscO2+WOQbUmwC+R9bGt2+YBeRxGna6FQ
bdAunbK2vL1/LDCePSo28u4n7r3PHLPQwIVzcIRz4rnMthMYx6u2VPU2mEJCskbo
sncea4SkisqwenuDV797o71RQd3vwBM//pF70RD8wldCcASnx3hCanlmgdPVxSom
MfLMOHRcpm02hH09NzZlrH65d29ApQ==
=Oh4i
-----END PGP SIGNATURE-----

--+YbDnjKjE+EkTgt0--


