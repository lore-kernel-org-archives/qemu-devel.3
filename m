Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3963CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3JLL-0001lK-2A; Mon, 29 Sep 2025 15:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3JLJ-0001kw-6y
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3JLE-00070d-AW
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759173313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0s46jLWUmvXkRKZ7D+cuUgcmFCUDB0kP5oEWoqGYojE=;
 b=WeH4bpyZKgRTcPP0YiT+NkKaV3y2rNfAIeR0/YWySl7xL/Tm60Oqim0EeCFB6Hd4BeTPK0
 cs0vHEMiJM/bRSg+pydavCo/NK2vDHpYxokgYFg8tEe0hLtN6g7Y/YtJy0n0uMjyenaDjG
 /caMCdGauhg2HMJ12iq2EeY6Eh+E2aY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-WZZXvpm9MGuZCIId_Nw-8Q-1; Mon,
 29 Sep 2025 15:15:09 -0400
X-MC-Unique: WZZXvpm9MGuZCIId_Nw-8Q-1
X-Mimecast-MFC-AGG-ID: WZZXvpm9MGuZCIId_Nw-8Q_1759173308
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E4DD19774DF; Mon, 29 Sep 2025 19:15:07 +0000 (UTC)
Received: from localhost (unknown [10.2.17.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF4C4195608E; Mon, 29 Sep 2025 19:15:05 +0000 (UTC)
Date: Mon, 29 Sep 2025 15:15:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, slp@redhat.com,
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 david@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 1/7] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <20250929191504.GH81824@fedora>
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FkXsD49a/hQojCVE"
Content-Disposition: inline
In-Reply-To: <20250910115420.1012191-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--FkXsD49a/hQojCVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 01:54:14PM +0200, Albert Esteve wrote:
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                    QIOChannel *ioc,
> +                                    VhostUserHeader *hdr,
> +                                    VhostUserPayload *payload,
> +                                    int fd)
> +{
> +    VirtioSharedMemory *shmem;
> +    VhostUserMMap *vu_mmap = &payload->mmap;
> +    Error *local_err = NULL;
> +    g_autoptr(GString) shm_name = g_string_new(NULL);
> +
> +    if (fd < 0) {
> +        error_report("Bad fd for map");
> +        return -EBADF;
> +    }
> +
> +    if (QSIMPLEQ_EMPTY(&dev->vdev->shmem_list)) {
> +        error_report("Device has no VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    shmem = virtio_find_shmem_region(dev->vdev, vu_mmap->shmid);
> +    if (!shmem) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d not found or unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > shmem->mr.size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    g_string_printf(shm_name, "virtio-shm%i-%lu",
> +                    vu_mmap->shmid, vu_mmap->shm_offset);
> +
> +    memory_region_transaction_begin();
> +
> +    /* Create VirtioSharedMemoryMapping object */
> +    VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
> +        vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> +        vu_mmap->len, vu_mmap->flags & VHOST_USER_FLAG_MAP_RW);
> +
> +    if (!mapping) {
> +        memory_region_transaction_commit();
> +        return -EFAULT;
> +    }
> +
> +    /* Add the mapping to the shared memory region */
> +    if (virtio_add_shmem_map(shmem, mapping) != 0) {

Missing check for overlap with existing mappings. The spec does not
allow overlap.

--FkXsD49a/hQojCVE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmja2rgACgkQnKSrs4Gr
c8jMYAf+KZa7zwR42w8kifaZhbdtiFGBu6Uax2+bN4yR/MTcn/wI+ySzG2996yyw
z7Y1ur+uR9H99bYzOKZ1iELdDPwsTHi4JKDdbNWDT/0lgYYuZ1tXP12PxVu/0Z/j
otqVHygc6R6czOI6FdIJSXPzQuAw3Mn9xxB8UkYYs+VyJNZ0Wvk3okNVkPY0gXcD
ojR/WsUEASYu+U7yxPeqARnHtth9dKeeubiM75csEavAUM7fkuseCYE8Xdhq+S2K
yEWgCw9AMHwfEJdzY4drxQc7yrLDUtyMenEKPgckU/SeYNExy3uiOGxvlxfqJ28F
QMieC5sCtJ2sFL1d84D/8jBNPvTNVw==
=pn92
-----END PGP SIGNATURE-----

--FkXsD49a/hQojCVE--


