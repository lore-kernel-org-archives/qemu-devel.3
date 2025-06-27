Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9351DC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 18:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVDqW-0003Ec-EM; Fri, 27 Jun 2025 14:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uVDqN-00038G-SG
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uVDqJ-0007h5-T6
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751049029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1pwaEMo+9PNjyCdYUvgs2NOQBHwed6afoh6k0G3pP7o=;
 b=eP51Es6IG67kqvy0sbp5wpj+Kp7lp1Fy09gq+uy7ZB1tEY4JRZW+/C9+yPKdWMGwN1q5yH
 S1oDE1+NMSdRd7HV8Pyvq9LC3GYkGD46UNd+t508Wq4b/fnFKpESf6Oyp5GCJM5vUO4om+
 Ju1i94V3CSs0Pyr4ZJBS2uDvqDz3EHY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-V-GHj29BOwOOoBuvl5L6Sw-1; Fri,
 27 Jun 2025 14:30:28 -0400
X-MC-Unique: V-GHj29BOwOOoBuvl5L6Sw-1
X-Mimecast-MFC-AGG-ID: V-GHj29BOwOOoBuvl5L6Sw_1751049027
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA0C9180028B
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 18:30:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.103])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6CE719560A7; Fri, 27 Jun 2025 18:30:25 +0000 (UTC)
Date: Fri, 27 Jun 2025 14:30:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/25] vfio queue
Message-ID: <20250627183019.GA187464@fedora>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e7IsEyapM/sLibZl"
Content-Disposition: inline
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--e7IsEyapM/sLibZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--e7IsEyapM/sLibZl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhe4zsACgkQnKSrs4Gr
c8g/egf+NlHKnlok/q6zvaXTOMnuUvOhtji9zEi8bDJDytotcJOxgaEV6k1dxVyR
owup9Nd06YZOkXv5edn4AA9X/7md43HcQRKGdBVnzuFfzTcFsIvTzP59PfoImIb1
tXIQEv9GfY5O9R0gRmHLKYHGDLTl3clEVA71I0TglS6g05f+tqE9Y//P6rzSs/Vh
5RXmbMcsL/NoPU0B30JupMX0yJymLoX5ADRCt1lwPOfmElNedeXMFpT2jITl0g3f
6ausxdSXgUSmHn0Y6V4dg2/DDwY8yVZ2h9z0I0D3gLN+mNTSyMPnyDszqtCoo9K/
LkAsGb6EPCsgNxnbo3lg7xARE4Ih5w==
=jLCg
-----END PGP SIGNATURE-----

--e7IsEyapM/sLibZl--


