Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80314C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 19:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txssp-0002l3-72; Thu, 27 Mar 2025 15:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txssk-0002k2-Hl
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 15:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txsse-0003CG-QY
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 15:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743103627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0Wa+G8tzXu8fB2+PZk5BQ5bRMrrHVuDy2OKV8lQqYk=;
 b=YvUWWIItbGO9YEDioKlvJ/TDA6jFZlFC3EwvEgRVQbj7gCRVelYNlknj47zWkJhwxDeDZC
 GO3NL9irG9wcSVodXGQGrzlrHPaHYUtXzLtrxDvgLwINASzzx2wlR0mhvNVr60qnUL5RMQ
 oZhIuTdDYzcYMWz8tJg6Uofl1+cHG50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-KUILcefWPJuQYi5bYJaCOg-1; Thu,
 27 Mar 2025 15:27:03 -0400
X-MC-Unique: KUILcefWPJuQYi5bYJaCOg-1
X-Mimecast-MFC-AGG-ID: KUILcefWPJuQYi5bYJaCOg_1743103622
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EACA180AB16; Thu, 27 Mar 2025 19:27:01 +0000 (UTC)
Received: from localhost (unknown [10.2.17.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1310530001A1; Thu, 27 Mar 2025 19:27:00 +0000 (UTC)
Date: Thu, 27 Mar 2025 15:26:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
Subject: Re: [PATCH v1 2/2] block/nvme: Enable NVMe userspace driver for s390x
Message-ID: <20250327192659.GD46883@fedora>
References: <20250326181007.1099-1-alifm@linux.ibm.com>
 <20250326181007.1099-3-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pYzDdEiwEpukorzU"
Content-Disposition: inline
In-Reply-To: <20250326181007.1099-3-alifm@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--pYzDdEiwEpukorzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 11:10:07AM -0700, Farhan Ali wrote:
> +static inline uint32_t nvme_mmio_read_32(const void *addr)
> +{
> +    uint32_t ret;
> +
> +#ifdef __s390x__
> +    ret = s390x_pci_mmio_read_32(addr);
> +#else
> +    /* Prevent the compiler from optimizing away the load */
> +    ret = *((volatile uint32_t *)addr);
> +#endif

The NVMe driver should not need to worry about s390 PCI MMIO specifics.
It would be nice to add a QEMU PCI MMIO load/store API that hides this.

block/nvme.c would use the API to access MMIO registers instead of
accessing them directly. The functions could be static inline in the
header file to minimize overhead on platforms that can directly access
PCI MMIO registers.

--pYzDdEiwEpukorzU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflpoMACgkQnKSrs4Gr
c8huvQf9E93SOVe7ayF+9FBPHaVRLePwiFvxZTl/yoOAfER/37ssz26Jcm/T1/sz
H6bnnJmfdNoF13ShtkYxU4aKtzSs5g9X6iTiUZrALFwvU15jkQK8Lspbe98mWy92
ODkHO9HQLVhzSFciOg81qJFnkJQTs+D+ZK+CtdNaYaWoxqHs4HhY5EXBObRkRUFp
0Ji5nVf2MrZVXjZoNHceIw9u7JrfLWFN9Tf9ljQ/xh+FO1uuQzB99USXK8WusRb1
fFETxEjQAB36XJvaFbLn1iLmuiYI7oE3iQWW4S71FY2fMEVCX2YOvO2p7MzMnqIf
83OFXL8r79/lCJs8yBMUL1n+pUoBPw==
=ikFc
-----END PGP SIGNATURE-----

--pYzDdEiwEpukorzU--


