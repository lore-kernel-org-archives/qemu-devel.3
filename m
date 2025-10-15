Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37D6CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v93Y7-00006Q-AQ; Wed, 15 Oct 2025 11:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v93Y4-000060-P0
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 11:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v93Xl-0008RP-No
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 11:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760542555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QYom/XcuVfsMH2BBcA1GNz/ZhKRnYI+ozMRkMjqiaig=;
 b=CxgiqHHfevnkwwoid7gQxNR1zIAtZk3r2TEEq1JhiP07MWuQeknxMSA2fqswVyhGI/3nYN
 klG23NAXTvBt7K/ADloAa4wVOgn+X6G28daksnUkmtftVP//fdoXE3hXAYAB6Wr/aVs7n4
 yerKTwuCfy86fa9B4LydnV/xcREDc/o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-p1AU5rx9PHGE9CxS6Rcw0w-1; Wed,
 15 Oct 2025 11:35:53 -0400
X-MC-Unique: p1AU5rx9PHGE9CxS6Rcw0w-1
X-Mimecast-MFC-AGG-ID: p1AU5rx9PHGE9CxS6Rcw0w_1760542552
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DC1F18026B5; Wed, 15 Oct 2025 15:35:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 329CB18003FC; Wed, 15 Oct 2025 15:35:46 +0000 (UTC)
Date: Wed, 15 Oct 2025 11:35:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, jasowang@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, hi@alyssa.is,
 Laurent Vivier <lvivier@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 david@redhat.com, manos.pitsidianakis@linaro.org,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, slp@redhat.com,
 dbassey@redhat.com
Subject: Re: [PATCH v9 7/7] vhost-user-device: Add shared memory BAR
Message-ID: <20251015153545.GC1133221@fedora>
References: <20251015085930.1517330-1-aesteve@redhat.com>
 <20251015085930.1517330-8-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+iljVMiGrSI2Z9AE"
Content-Disposition: inline
In-Reply-To: <20251015085930.1517330-8-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--+iljVMiGrSI2Z9AE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:59:30AM +0200, Albert Esteve wrote:
> @@ -25,10 +29,37 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_=
USER_TEST_DEVICE_PCI)
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Erro=
r **errp)
>  {
>      VHostUserDevicePCI *dev =3D VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
> -    DeviceState *vdev =3D DEVICE(&dev->vub);
> +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> +    VirtioSharedMemory *shmem, *next;
> +    uint64_t offset =3D 0, shmem_size =3D 0;
> =20
> +    vpci_dev->modern_mem_bar_idx =3D 2;
>      vpci_dev->nvectors =3D 1;
> -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> +
> +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> +        if (shmem->mr.size > UINT64_MAX - shmem_size) {
> +            error_setg(errp, "Total shared memory required overflow");
> +            return;
> +        }
> +        shmem_size =3D shmem_size + shmem->mr.size;
> +    }
> +    if (shmem_size) {

Let's reject invalid BAR configurations when VIRTIO Shared Memory
Regions are in use:

  if (vpci_dev->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
      error_setg(errp, "modern-pio-notify is not supported due to PCI BAR l=
ayout limitations");
      return;
  }

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+iljVMiGrSI2Z9AE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjvv1EACgkQnKSrs4Gr
c8j+Pwf+L5sAmWsXok/OctADNm5hdyoCCKVk/0XcgWgbekJMKagH+EpU3dS9YrDq
zAGTCmHhEXqHPuq3Sv5uuqJp0+1dHETAmtRcGOX/gIlDvZngWhcvdwqsbaSPilYH
2Nv/D42w5x3NLfadNJ3rt5sj1fav98gdkblNBsp0kTjYlgXLfsPu+4ka270AsDcF
byrN9OzkQ+3kOet4nyVnLDVeatiDJMYecsSek+wi8XRsz/PtvwpU7CBUXar8WADw
SwkWM0qBNfQZbV36OyLPETngS6YpgmAggVtYGqcuNlMyxOmnevuMe6L0/9q8fdol
eiZftuxJs/TZ9a9A+XzFPEpN1WFrYw==
=1msq
-----END PGP SIGNATURE-----

--+iljVMiGrSI2Z9AE--


