Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B847C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQvW-0005Zh-Eq; Thu, 30 Jul 2026 09:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpQvQ-0005YP-0Y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpQvO-0005pm-EX
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785418549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UMSJN1Zy8GCTNNqKtJwk2wCQyWq9mBJiYnVHnZZNYXU=;
 b=K2VNuzNQ2/2tjg6SmxtWdclgIDfuB46i9+2ymiHJXrzqnLEhRUvH0qXDRNLZKQqItTWz6x
 nLMydqSBycwwpqicdH/htLfr3zddT9r21gZ4PCzDebvNFbFvXaSIXddbq+je42y3jPe6AU
 QgSxau5MgUZaOLhX/35cszfIA8O5XYA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-FLk_3xx2PaqPzKDp9Tc9Cw-1; Thu,
 30 Jul 2026 09:35:44 -0400
X-MC-Unique: FLk_3xx2PaqPzKDp9Tc9Cw-1
X-Mimecast-MFC-AGG-ID: FLk_3xx2PaqPzKDp9Tc9Cw_1785418541
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8166195608B; Thu, 30 Jul 2026 13:35:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.133])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D231218004AD; Thu, 30 Jul 2026 13:35:38 +0000 (UTC)
Date: Thu, 30 Jul 2026 09:35:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v3 6/7] hw/scsi/virtio-scsi: harden
 virtio_scsi_load_request() against invalid stream
Message-ID: <20260730133534.GA1442692@fedora>
References: <20260729231904.775331-1-lvivier@redhat.com>
 <20260729231904.775331-7-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XXM0IUzJagjN2qnZ"
Content-Disposition: inline
In-Reply-To: <20260729231904.775331-7-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

--XXM0IUzJagjN2qnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 01:19:03AM +0200, Laurent Vivier wrote:
> virtio_scsi_load_request() uses assert() and exit(1) for conditions
> that can be triggered by a crafted migration stream: an out-of-range
> queue index, a malformed SCSI request, or a command mode mismatch.
>=20
> Replace these with proper error returns so the migration fails
> gracefully instead of aborting the destination QEMU process.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 5db1764cc1f6 ("virtio-scsi: add migration support")
> Fixes: d2ad7dd46e72 ("virtio-scsi: add multiqueue capability")
> Fixes: 36b15c79aa1b ("virtio-scsi: start preparing for any_layout")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>=20
> Notes:
>     v2: add error_setg() calls with descriptive error messages for
>         all three error paths
>=20
>  hw/scsi/virtio-scsi.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XXM0IUzJagjN2qnZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmprUyYACgkQnKSrs4Gr
c8igeAgArYU4D8g5C1qn4dSnFaHq7o00BoZ6x4TzCKA+ep0zVsFqrwwHiUki6RrI
7ATIRZW7PdyMN155//PyGX2KQ7Iy7pSh2HrOuVbokNoLkm5LDOICqnZG86Cd60KQ
7CYl9IhEvdhEdatCs42jmXXrMfWFFTyqnrhsV+uu8JbTRo/whFhImRfmKquUAwih
/J1Qy4pHnOQ/P8jSqQuUmofUL6u5XYF8JpICWpSSGyfQu3l+Uxe2vTTdur6GrGBe
Wpk/SZQLUL0LqJOzOCr4uVvRUxfZ7qhAH8LTfj7yeQvpxbcsCCgUQt8mNUEIzb4K
Xaj2Z07sGhhkMO5Zl4SNd2PjbWzbhg==
=Yef0
-----END PGP SIGNATURE-----

--XXM0IUzJagjN2qnZ--


