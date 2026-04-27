Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D416FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT7n-0003Ay-L2; Mon, 27 Apr 2026 17:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHT7W-0002jz-Th
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHT7U-0004M2-Sr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777323836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1WvKzWVJbZ83vaKb6a9wfF6e0k+qbroYHv6I2bPY0g=;
 b=PAZGA4xuTc1De82szO9NPDzeyK/OiETONei3BU7te1mSVThy7TyyThEalfJn6xdvEY7aFp
 PeC0Rw7FYrcz7SdO67wkKZMp4nh2KMl2WmvBaWpTQVnN1egtyum1lPAWz+5wReE+oJ7aZG
 O4AD8e1UcFQHNs64iav1KsNO1J3DGzw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-uUWgK-ndNmGZAygbW-w_WA-1; Mon,
 27 Apr 2026 17:03:51 -0400
X-MC-Unique: uUWgK-ndNmGZAygbW-w_WA-1
X-Mimecast-MFC-AGG-ID: uUWgK-ndNmGZAygbW-w_WA_1777323829
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D613195608F; Mon, 27 Apr 2026 21:03:48 +0000 (UTC)
Received: from localhost (unknown [10.44.34.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE37C1800348; Mon, 27 Apr 2026 21:03:45 +0000 (UTC)
Date: Mon, 27 Apr 2026 17:03:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v6 6/8] hw/nvme: add basic live migration support
Message-ID: <20260427210343.GG218226@fedora>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-7-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P7ocELvbgVXN2EOd"
Content-Disposition: inline
In-Reply-To: <20260419130139.15554-7-alexander@mihalicyn.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--P7ocELvbgVXN2EOd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 03:01:37PM +0200, Alexander Mikhalitsyn wrote:
> @@ -4903,6 +4916,25 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl =
*n, uint64_t dma_addr,
>      __nvme_init_sq(sq);
>  }
> =20
> +static void nvme_restore_sq(NvmeSQueue *sq_from)
> +{
> +    NvmeCtrl *n =3D sq_from->ctrl;
> +    NvmeSQueue *sq =3D sq_from;
> +
> +    if (sq_from->sqid =3D=3D 0) {
> +        sq =3D &n->admin_sq;

docs/devel/migration/main.rst says:

  - The destination should treat an incoming migration stream as hostile
    (which we do to varying degrees in the existing code).  Check that offs=
ets
    into buffers and the like can't cause overruns.  Fail the incoming migr=
ation
    in the case of a corrupted stream like this.

Can a corrupt/malicious device state reach this point multiple times
(i.e. several sqid 0 queues are stored in the device state)? If yes,
then input validation would be good here to avoid undefined behavior
later in the sq code.

The same issue may apply to duplicate sqids in general. It seems safest
to reject them during restore.

> +        sq->ctrl =3D n;
> +        sq->dma_addr =3D sq_from->dma_addr;
> +        sq->sqid =3D sq_from->sqid;
> +        sq->size =3D sq_from->size;
> +        sq->cqid =3D sq_from->cqid;
> +        sq->head =3D sq_from->head;
> +        sq->tail =3D sq_from->tail;
> +    }
> +
> +    __nvme_init_sq(sq);
> +}
> +
>  static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeSQueue *sq;
> @@ -5605,6 +5637,39 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl =
*n, uint64_t dma_addr,
>      __nvme_init_cq(cq);
>  }
> =20
> +static void copy_cq_req_list(NvmeCQueue *cq_to, NvmeCQueue *cq_from)

This moves the NvmeRequests rather than copying them. Rename to
move_cq_req_list()?

> +{
> +    NvmeRequest *req, *next;
> +
> +    QTAILQ_FOREACH_SAFE(req, &cq_from->req_list, entry, next) {
> +        QTAILQ_REMOVE(&cq_from->req_list, req, entry);
> +        QTAILQ_INSERT_TAIL(&cq_to->req_list, req, entry);
> +    }
> +}
> +
> +static void nvme_restore_cq(NvmeCQueue *cq_from)
> +{
> +    NvmeCtrl *n =3D cq_from->ctrl;
> +    NvmeCQueue *cq =3D cq_from;
> +
> +    if (cq_from->cqid =3D=3D 0) {
> +        cq =3D &n->admin_cq;

Same question about duplicate CQs in corrupt/malicious device states.

I reviewed the new draining (busy wait removal). I'll leave the rest for
Klaus because I'm not that familiar with the NVMe emulation code.

Stefan

--P7ocELvbgVXN2EOd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnvzy8ACgkQnKSrs4Gr
c8gRTwgAhkHgJQPjdjr1wQGYbJ4r5IFm8d2vMAkXz3WPtr5YfT86IsI5ipxAQ/bv
hD1E5ra+txsv5oWNGUj0x2OplpstIrCvqPBO0BBz4HnR7txv5L1Xnic4RAKOCaQ4
NovdqsDPc6g1DuEjeKPAagc4rhS3bynPvukgxLwCLvfHPwQVDFyNRwOGlZTkjP9Y
9INMrwQdZraNMAr8JS8Ock91i6WH+f9rMei/KlUirykFb+9r3RdvwPfabS+YUGdH
V1FMkwINaUqX467u2mkZLWUPrK14Z5mD7k7MOphvso7ZcBpEWtFwOhF8R7yu3Agv
oTN7cau8cYSj3gxF5w2Ey8/CRIfX/A==
=eZqz
-----END PGP SIGNATURE-----

--P7ocELvbgVXN2EOd--


