Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93746C3ABC9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 18:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDp51-00030n-Fu; Sat, 10 May 2025 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4t-0002y7-7T
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4r-0007fB-Pt
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746902257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fum3VrOl5kziRGG91uSdW6+ykMSrCC4E3YB+bPXUas=;
 b=gNOup6kDzS4Q6db0Rm0BkgsIJ9k1HF7fSTEJjJ8MOR/UX1LRAUsLd2Ut07ssAdYXHSDYZI
 XyxJPwfOcAdel959ig1wiuCS60cOoPfOsVFaaBjpTfGqgbA8Z3+GRSka4Y9ExAKa2gm4o6
 vx7L2jz5u+b3IDeLzX5N7QMRiodlgHk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-3bNHTvYVPy6R-aPS21nWng-1; Sat,
 10 May 2025 14:37:35 -0400
X-MC-Unique: 3bNHTvYVPy6R-aPS21nWng-1
X-Mimecast-MFC-AGG-ID: 3bNHTvYVPy6R-aPS21nWng_1746902254
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A48C41955DCD
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 18:37:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.39])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04F8D1953B8B; Sat, 10 May 2025 18:37:33 +0000 (UTC)
Date: Sat, 10 May 2025 14:36:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/28] vfio queue
Message-ID: <20250510183633.GA117018@fedora>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VVW90x7Pto95jZ/k"
Content-Disposition: inline
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--VVW90x7Pto95jZ/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--VVW90x7Pto95jZ/k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgfnLEACgkQnKSrs4Gr
c8h8aAgAn/MIcyukzJ7n8MoaW5YGOTyJ4Aui2Sh0lYGGDOnU8HQ1FA686uo3q8Au
X1J8FeMbt64amAp6BIJs+lClTXV0vzQ7J56bSk8UnsbfhYvVSxQ8EjYbud3GIP/p
2lysEQjv20JvxpEtTO5Vqk3mA1uQRMTVnIjLQVivEd4iAU0j8hdh2U0UHutWuBSs
6RUVDU9p7hr+DbH+IkOhnQuPCwUW5PtxQWD18QzVCuLNCYy/1OyWxG7d6hLeu4E8
LtYK3hm0/D8M5xXBJNTmg8hzAe97jz+978d5W6uXpzUbhLsCFTPSbUlKN5kc83Wi
YA6OM6QPhh1NQWye6jzVG5fynkWH5w==
=QHD5
-----END PGP SIGNATURE-----

--VVW90x7Pto95jZ/k--


