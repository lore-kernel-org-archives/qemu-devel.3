Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16121CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 17:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ofA-0005LU-SO; Fri, 17 Oct 2025 13:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9of9-0005LL-9d
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9of6-0003fv-Hz
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760723681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aU6hwV6/6b3FpLhVOYyqIVCukbZE7lSDdJjaFJ9OQjw=;
 b=VmMRa2/5RhB9ZW0oDSkckZBs9q5bc3gGlepaQaDlOMPPoznRtb6X25Cp/r9stlRF6AezE6
 yXBJKALgs+lSQZjY7AnTPmKQS4jAGO0D78DD4QxZg4hoVt/zbeG72S0iV6YqAnSJOlBY9x
 +YOrWQhbCklsZpzmuUsVhe/tH9xnLdE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-bwE8lAJ1Pr2vYSIUpnRl6w-1; Fri,
 17 Oct 2025 13:54:37 -0400
X-MC-Unique: bwE8lAJ1Pr2vYSIUpnRl6w-1
X-Mimecast-MFC-AGG-ID: bwE8lAJ1Pr2vYSIUpnRl6w_1760723676
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD3961956080; Fri, 17 Oct 2025 17:54:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.235])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88DFB1956056; Fri, 17 Oct 2025 17:54:34 +0000 (UTC)
Date: Fri, 17 Oct 2025 13:54:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net,
 mst@redhat.com, kwolf@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/scsi: avoid deadlock upon TMF request cancelling
 with VirtIO
Message-ID: <20251017175433.GA14295@fedora>
References: <20251017094518.328905-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fmFsVtcwdh/aR8nO"
Content-Disposition: inline
In-Reply-To: <20251017094518.328905-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--fmFsVtcwdh/aR8nO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:43:30AM +0200, Fiona Ebner wrote:
> When scsi_req_dequeue() is reached via
> scsi_req_cancel_async()
> virtio_scsi_tmf_cancel_req()
> virtio_scsi_do_tmf_aio_context(),
> there is a deadlock when trying to acquire the SCSI device's requests
> lock, because it was already acquired in
> virtio_scsi_do_tmf_aio_context().
>=20
> In particular, the issue happens with a FreeBSD guest (13, 14, 15,
> maybe more), when it cancels SCSI requests, because of timeout.
>=20
> This is a regression caused by commit da6eebb33b ("virtio-scsi:
> perform TMFs in appropriate AioContexts") and the introduction of the
> requests_lock earlier.
>=20
> To fix the issue, only cancel the requests after releasing the
> requests_lock. For this, the SCSI device's requests are iterated while
> holding the requests_lock and the requests to be cancelled are
> collected in a list. Then, the collected requests are cancelled
> one by one while not holding the requests_lock. This is safe, because
> only requests from the current AioContext are collected and acted
> upon.
>=20
> Originally reported by Proxmox VE users:
> https://bugzilla.proxmox.com/show_bug.cgi?id=3D6810
> https://forum.proxmox.com/threads/173914/
>=20
> Fixes: da6eebb33b ("virtio-scsi: perform TMFs in appropriate AioContexts")
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>=20
> Changes in v2:
> * Different approach, collect requests for cancelling in a list for a
>   localized solution rather than keeping track of the lock status via
>   function arguments.
>=20
>  hw/scsi/virtio-scsi.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

I replace g_list_append() with g_list_prepend() like in
scsi_device_for_each_req_async_bh(). The GLib documentation says the
following (https://docs.gtk.org/glib/type_func.List.append.html):

  g_list_append() has to traverse the entire list to find the end, which
  is inefficient when adding multiple elements. A common idiom to avoid
  the inefficiency is to use g_list_prepend() and reverse the list with
  g_list_reverse() when all elements have been added.

We don't call g_list_reverse() in scsi_device_for_each_req_async_bh()
and I don't think it's necessary here either.

Stefan

--fmFsVtcwdh/aR8nO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjygtgACgkQnKSrs4Gr
c8gZ5wf/QWbH0Y/AtUFQVKMU3XWUW3zzIgpAqTD/oXu4CnSxhW/ndwdZVfDYJsHs
OTVsRQTSqxsOufxalcKqe6SGT8UhKNQ60e/UwvMyzZPd6Kh1z/hzbBDsTQ84YhSH
qV2Xjf07nSUNk5sCkYbdCXCc8vFm513wrkCRpPnH382sZU3M9T2DP4ZNjNfHEPQg
4l5ccJtknE2i/nAR0cDJ+LcpVI0GFgz76PaycXQ5S8yBAGnHjIKM75lQQWE8Nuur
uZk4NfHNw4ReDA1dr/Ng1dBIQ9YKLQmVqCoI7nPjPWP4UXIVpgkDkzI/0i7BIfIT
VePcBdrv6BFaQpSMvSerH/5h/byRXw==
=2qbl
-----END PGP SIGNATURE-----

--fmFsVtcwdh/aR8nO--


