Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27510C47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 22:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSlIy-0000zU-IZ; Wed, 24 Jan 2024 17:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSlIw-0000zA-In
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:01:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSlIs-0005s0-0a
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706133660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SAnUBYIuiFw2VY3B2zyQtkCvm2LNngJths+XlfFPQw4=;
 b=cEytRFk+bazq4lPC2NaiSCc2m3leCH9OXT5RhJVPREg3J8H0T3qvkxWm8NEO48NFk4r55o
 Al+dn/F9LpQYWxjXn1Wftlp0I4qR+1N0pVDr5AzGxAdW9Uz+Mi5iPaBbV5oG7fMQ0xBTKN
 5wsR9dNs0CArbIsLz099/h2q0jzIzEk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-s7KcRMaqOH6wPoRmPn1rGg-1; Wed,
 24 Jan 2024 17:00:56 -0500
X-MC-Unique: s7KcRMaqOH6wPoRmPn1rGg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 288DE29AA3B7;
 Wed, 24 Jan 2024 22:00:56 +0000 (UTC)
Received: from localhost (unknown [10.39.192.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73054492BC6;
 Wed, 24 Jan 2024 22:00:55 +0000 (UTC)
Date: Wed, 24 Jan 2024 17:00:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/2] virtio-scsi: Attach event vq notifier with no_poll
Message-ID: <20240124220054.GA613094@fedora>
References: <20240124173834.66320-1-hreitz@redhat.com>
 <20240124173834.66320-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AKxFsHwvUfu8guYx"
Content-Disposition: inline
In-Reply-To: <20240124173834.66320-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--AKxFsHwvUfu8guYx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 06:38:29PM +0100, Hanna Czenczek wrote:
> As of commit 38738f7dbbda90fbc161757b7f4be35b52205552 ("virtio-scsi:
> don't waste CPU polling the event virtqueue"), we only attach an io_read
> notifier for the virtio-scsi event virtqueue instead, and no polling
> notifiers.  During operation, the event virtqueue is typically
> non-empty, but none of the buffers are intended to be used immediately.
> Instead, they only get used when certain events occur.  Therefore, it
> makes no sense to continuously poll it when non-empty, because it is
> supposed to be and stay non-empty.
>=20
> We do this by using virtio_queue_aio_attach_host_notifier_no_poll()
> instead of virtio_queue_aio_attach_host_notifier() for the event
> virtqueue.
>=20
> Commit 766aa2de0f29b657148e04599320d771c36fd126 ("virtio-scsi: implement
> BlockDevOps->drained_begin()") however has virtio_scsi_drained_end() use
> virtio_queue_aio_attach_host_notifier() for all virtqueues, including
> the event virtqueue.  This can lead to it being polled again, undoing
> the benefit of commit 38738f7dbbda90fbc161757b7f4be35b52205552.
>=20
> Fix it by using virtio_queue_aio_attach_host_notifier_no_poll() for the
> event virtqueue.
>=20
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Fixes: 766aa2de0f29b657148e04599320d771c36fd126
>        ("virtio-scsi: implement BlockDevOps->drained_begin()")
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thank you!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AKxFsHwvUfu8guYx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWxiJUACgkQnKSrs4Gr
c8hbCQf/fhI2RZoV1Db3OqSOwL5rJrXq9t/P7YSgHKA4GEPLD0iET7PCQiK1/ae1
C6X6zq8SjyBMhduyXRfeYSPuNxR1o7YWVRdwiUKo/uWmVbJyNewvVfhMgibm0u0q
3J4ZbdjBC91KFxg6+e/QkcyZwnci0kskalIFJOjC4ydizSJRY73gHpHZMptfDStF
zQ44XYznN3TfQOGfBl22Y5YmTb3MW/jO/TSSEmXNJkKO2Jrpcxmy3nWoQT0cexxV
4bgI3KGr+UXjuKM3BlO+SwlTeTT3z0tU97V5OA9S8+3u/lA+f4rOvfVwV3Zq5bRl
d8pIX0IVsLoqjVaElWsJen8vLJv47w==
=jdXK
-----END PGP SIGNATURE-----

--AKxFsHwvUfu8guYx--


