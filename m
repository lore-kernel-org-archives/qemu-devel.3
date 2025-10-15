Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2F5CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v93Q3-0006kT-Mi; Wed, 15 Oct 2025 11:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v93Q0-0006jy-HV
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 11:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v93Ph-0006oq-0w
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 11:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760542047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n/50tlHOGBoGaeRg+7foL3dtTJRjL8C74PNhafhhHCs=;
 b=KM6WvoutQAWtQ2qwFdUaFrab1/Y3cPqHNcWbGbjFYpBHJdgM2WdvQyHCpOcpAedWfofKye
 f86HFWSo+sSyHLEqYx7/ps6Fu+VXeoFYpo6qMmF0Me6cZT74N93xCuYAMWI6V1zX70xCCe
 nbnhYcO6/7RBDvsJQkQSmmur6ri4P2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Xz6iVfQ9PPCQvybmh9b1ug-1; Wed,
 15 Oct 2025 11:27:26 -0400
X-MC-Unique: Xz6iVfQ9PPCQvybmh9b1ug-1
X-Mimecast-MFC-AGG-ID: Xz6iVfQ9PPCQvybmh9b1ug_1760542045
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D57C61800657; Wed, 15 Oct 2025 15:27:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F3FA18003FC; Wed, 15 Oct 2025 15:27:23 +0000 (UTC)
Date: Wed, 15 Oct 2025 11:27:22 -0400
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
Subject: Re: [PATCH v9 1/7] vhost-user: Add VirtIO Shared Memory map request
Message-ID: <20251015152722.GB1133221@fedora>
References: <20251015085930.1517330-1-aesteve@redhat.com>
 <20251015085930.1517330-2-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4qIUDEQ4pRsr28ME"
Content-Disposition: inline
In-Reply-To: <20251015085930.1517330-2-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--4qIUDEQ4pRsr28ME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 15, 2025 at 10:59:24AM +0200, Albert Esteve wrote:
> +static void virtio_shared_memory_mapping_instance_finalize(Object *obj)
> +{
> +    VirtioSharedMemoryMapping *mapping = VIRTIO_SHARED_MEMORY_MAPPING(obj);
> +
> +    /* Clean up MemoryRegion if it exists */
> +    if (mapping->mr) {
> +        /* Unparent the MemoryRegion to trigger cleanup */
> +        object_unparent(OBJECT(mapping->mr));
> +        mapping->mr = NULL;
> +    }
> +
> +    /* Close file descriptor */
> +    if (mapping->fd >= 0) {
> +        close(mapping->fd);
> +        mapping->fd = -1;
> +    }

This looks like a double close(), which could accidentally close a
reused fd in a multi-threaded program. reclaim_ramblock() already closes
the file descriptor (it's stored in RAMBlock), so I think the
VirtioSharedMemoryMapping struct should not hold on to fd and close it
here.

Other than that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4qIUDEQ4pRsr28ME
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjvvVoACgkQnKSrs4Gr
c8gGnAgAk8aHJeyQ/wImG2u6Xsobk98LQqNYalWSyGRpfMre7zSrW/pUFLsfEKWS
IXdwAPUwff3k/6TPwHgUdEwQaXK+iTuPZg7/KoqT/lT5e9CCjp/OAiGpJJiiCnMM
hvBcBSb4IJragbq1CpF5DDy3HqriWfLScbspHiXDvmYVqKLjhTHwCRulSHPPVmwj
TvM8j4iuuWBXUyW6HJcpoYgp/JQJCx+4P+0apvFfM95NrAoAhqhutXoEZUkyPEDj
rI0Yj/FZ8OVxDRGBOB5jWx0+YKs2fowxBrtQBQSBamY50yw1i6rE7+lCmZBUyWj0
r/ay1046SQK7+FcIhBlLZuE5NEKfNw==
=76Uc
-----END PGP SIGNATURE-----

--4qIUDEQ4pRsr28ME--


