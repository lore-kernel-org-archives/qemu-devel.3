Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01C7C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTe2-0004KI-Ou; Tue, 17 Sep 2024 04:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqTe0-0004J9-4L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqTdy-0005bS-Q6
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726561985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zs5q4YoYZen+0OA5kpvZNNJTfInQ+FUpvU94DIGPibc=;
 b=GXnCRhyWOqBmSskb0MUcgi8rmsBsHKYLtp+nD9CqdnRmCHi5DfuziPnndgLRRLpGXBk03v
 Fh0r3KjGAXAq28KEBMTWqkbrw/Hf07bA//MoUQsVGAX/TX5OoH+wwZaf0Jrc3vxBAcgu7f
 X3LlAzM/wZNqs4bJHRH+9lIEURiCygg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-3EtBF5t3N62X5sL8Usjg2Q-1; Tue,
 17 Sep 2024 04:33:02 -0400
X-MC-Unique: 3EtBF5t3N62X5sL8Usjg2Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 132E61953940; Tue, 17 Sep 2024 08:33:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.41])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 941EB19560AA; Tue, 17 Sep 2024 08:32:59 +0000 (UTC)
Date: Tue, 17 Sep 2024 10:32:58 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 4/5] vhost-user-dev: Add cache BAR
Message-ID: <20240917083258.GE575885@fedora.redhat.com>
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nhym8/4K3DYqi6Ak"
Content-Disposition: inline
In-Reply-To: <20240912145335.129447-5-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Nhym8/4K3DYqi6Ak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:53:34PM +0200, Albert Esteve wrote:
> @@ -331,6 +333,37 @@ static void vub_device_realize(DeviceState *dev, Err=
or **errp)
>          do_vhost_user_cleanup(vdev, vub);
>      }
> =20
> +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost=
_dev,
> +                                                           &nregions,
> +                                                           memory_sizes,
> +                                                           errp);
> +
> +    if (ret < 0) {
> +        do_vhost_user_cleanup(vdev, vub);
> +    }
> +
> +    for (i =3D 0; i < nregions; i++) {
> +        if (memory_sizes[i]) {
> +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> +                error_setg(errp, "Shared memory %d size must be a power =
of 2 "
> +                                 "no smaller than the page size", i);
> +                return;
> +            }
> +
> +            cache_ptr =3D mmap(NULL, memory_sizes[i], PROT_NONE,
> +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +            if (cache_ptr =3D=3D MAP_FAILED) {
> +                error_setg_errno(errp, errno, "Unable to mmap blank cach=
e");
> +                return;
> +            }
> +
> +            virtio_new_shmem_region(vdev);
> +            memory_region_init_ram_ptr(vdev->shmem_list[i].mr,

I don't think this works because virtio_new_shmem_region() leaves .mr =3D
NULL? Why allocates the MemoryRegion and assigns it to shmem_list[i].mr?

--Nhym8/4K3DYqi6Ak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbpProACgkQnKSrs4Gr
c8hLEQgAwcxNkbiprjbIwHfysCV7avfdnVbYJ6Hc8Z9hDt4FCo1RR1gi/2/WbHA9
F/oXiWlokTVVrm8Sj3V9385TMsh5dNzYGQ/RPslz2vRWRNGseOInahO19ei/NDxx
3v3qYzP9j9gQoWlDh5rUbRB2hb9tBnLIg8vT/5H3ekbuUenfTjgo52Z7ynDEWcU7
OzV/6s15KALJMmbeE9Yv8bPoj+z1RFAcz6pc+OlCjXWKiphxWoJyAeDWLtpzj/el
Dvn3jHOwGi0SLBO64pVASp+Yomkh8agcZIZd54bP5uUBkzgCwzcYvVMJn5uHV458
mI+kHE7Of8xBnBqz2bsuiFAIwpURtQ==
=qa3r
-----END PGP SIGNATURE-----

--Nhym8/4K3DYqi6Ak--


