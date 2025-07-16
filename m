Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD1DC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1bV-00064r-Lz; Wed, 16 Jul 2025 08:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1Rn-0006Tt-LE
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1Rg-0000Lf-17
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iz+3d5+JSrK35VSexVUCUW0N/U4gRiJ1I/moRxWQ0hU=;
 b=VykqseI+JG36MQTqvDjpHyGynHZCLBzMzUPFyAaGF7Ekzr0XR2C/8f+8UadwhkFfG0hud/
 ZxSDGs7MyPnErWD1o01L0NxQvakpcDNpcUkTg6f5TCvlLDirU9XRJL8aapr2M13qqnZKeF
 s1luLs5Wgsp0i22+nPnP3W5vxSZ/kUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-2znkdw4xNVeYKNWEXi3VeA-1; Wed,
 16 Jul 2025 08:41:08 -0400
X-MC-Unique: 2znkdw4xNVeYKNWEXi3VeA-1
X-Mimecast-MFC-AGG-ID: 2znkdw4xNVeYKNWEXi3VeA_1752669667
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CAE01955F41
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 12:41:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D70F300019F; Wed, 16 Jul 2025 12:41:05 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:41:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/7] vfio queue
Message-ID: <20250716124104.GA328283@fedora>
References: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V8wuSRFaQdWSQYTA"
Content-Disposition: inline
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--V8wuSRFaQdWSQYTA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--V8wuSRFaQdWSQYTA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3neAACgkQnKSrs4Gr
c8gInggAyYar7aFWNv4Jlzvr1Ju2Eau/yt/7eChbXhDmL55QEHFYTaRz+7NIofze
iDCX1zLp2sDyCu0KQY2poMV7lfm2Z+27A2l10IBnu+QDsoDKw4v7/CoB/UIZS9h7
Ax+6usyQH4IH5N7NT2Pd1MCnOfZLH2jXFFqFLUuKJQpUwxRmUBsajpoFuIHzJ+tc
DPNM8yT5cG1GLfa1Swc7pDz+po9cFmDDZI7DJYeAvA3NUxbRwZS+XRN2J7oVQEqU
eG4anAYSzVDOFRHvpeQrdEWOAWznyoWUGJWbKCWoH9kYXOb302K7/lk/5ypoVxI6
eSoyHAjsizXZi21zNUlqTDf+uuHx+w==
=3Uap
-----END PGP SIGNATURE-----

--V8wuSRFaQdWSQYTA--


