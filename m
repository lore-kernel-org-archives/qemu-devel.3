Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C60CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ixi-00006A-KN; Mon, 29 Sep 2025 14:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3Ixf-0008Tl-6S
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3IxW-0008T9-24
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759171846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vVRGwRzVeEpFSHtwZ+AG7Ug9IGOlaCIFp3j40pNV1tY=;
 b=c28gEal6604+z/l9rTFKoscY4TU3nZpKXJGlNMzyBthTgjt95XrxDnw0DP1Zi1B8KyN2Sc
 wNQlzkEK9VV3qOFI9H284VCVd9FM5QyUnoEvXd374K994bAVpl1n0mvGSgTWnGHCN/fr3Q
 Wk+6nasYGqh3t305diklBh/u9rU5T4c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-Dj5n5EwANYCOVdTyzYLYKA-1; Mon,
 29 Sep 2025 14:50:41 -0400
X-MC-Unique: Dj5n5EwANYCOVdTyzYLYKA-1
X-Mimecast-MFC-AGG-ID: Dj5n5EwANYCOVdTyzYLYKA_1759171840
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75AD918002CB; Mon, 29 Sep 2025 18:50:40 +0000 (UTC)
Received: from localhost (unknown [10.2.17.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82D57180047F; Mon, 29 Sep 2025 18:50:39 +0000 (UTC)
Date: Mon, 29 Sep 2025 14:50:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, slp@redhat.com,
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 david@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 4/7] vhost_user: Add frontend get_shmem_config command
Message-ID: <20250929185038.GF81824@fedora>
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yNlhVKNWgLI82AYH"
Content-Disposition: inline
In-Reply-To: <20250910115420.1012191-5-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--yNlhVKNWgLI82AYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 01:54:17PM +0200, Albert Esteve wrote:
> +static int vhost_user_get_shmem_config(struct vhost_dev *dev,
> +                                       int *nregions,
> +                                       uint64_t *memory_sizes,
> +                                       Error **errp)
> +{
> +    int ret;
> +    VhostUserMsg msg = {
> +        .hdr.request = VHOST_USER_GET_SHMEM_CONFIG,
> +        .hdr.flags = VHOST_USER_VERSION,
> +    };
> +
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_SHMEM)) {
> +        return 0;

Missing *nregions = 0?

--yNlhVKNWgLI82AYH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmja1P4ACgkQnKSrs4Gr
c8jjswgAwy7zX9cgwj8ddXOVPyOq9Lmb3DialbATlC6Qmu59nY68MeXF60r6qTdX
LjeGG87MbiL8YykuUPI+09exRN3499tO7t/XYwuz4PZ61F7Gi83C6UGsP8aiBIh/
Cc0tNOqX/hnQ+dDpF6igb7yjLxpkS0ouR9RiZeqvVr20G7J9S1vNIgO8jTZUIdMf
ce8V6eGakIfpbKRiLMmH+ZxFe3wdlYYK85Iw/+mEWrewxUGV/2RGrmgf8B26fF2G
zkgz+0WBOQ2XUAp39FcNPCoI6fq+Yg0NGHplTzuApj7y8fEOqJaAh7SKTOwFmmgL
2X1j2ksbjqxxEQL+yJwXhpHQfCiclw==
=fpp7
-----END PGP SIGNATURE-----

--yNlhVKNWgLI82AYH--


