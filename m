Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA2C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 02:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thg9d-0008Ds-Mk; Mon, 10 Feb 2025 21:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thg9b-0008DM-F9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thg9X-0000GT-Eq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739241451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8mv7Wtl83YpB1KMblXOpwN1rAv4sdsU8d+QvvHEwkg=;
 b=LjtW1HN0E+LS5gwWIrVMT2O4ChjVRJKGC9EqjnEuiA5tol1YSoopMqQjlkiR1p6Pm+Hmr7
 CDdG5TqOlAUIWGhR5wuc0ZqWTiArth4cCVZp/T/RVecs09EdEseR+Rqgko+zMSD/yjvyYK
 NbV1BisuCrjU1x/ztyeElmjbIftjOdI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-TozyFYMyNvipZ7lQ_Xe2hA-1; Mon,
 10 Feb 2025 21:37:27 -0500
X-MC-Unique: TozyFYMyNvipZ7lQ_Xe2hA-1
X-Mimecast-MFC-AGG-ID: TozyFYMyNvipZ7lQ_Xe2hA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB6A21956088; Tue, 11 Feb 2025 02:37:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 443F6195608D; Tue, 11 Feb 2025 02:37:24 +0000 (UTC)
Date: Mon, 10 Feb 2025 21:37:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 00/17] testing and gdbstub updates
Message-ID: <20250211023723.GA149825@fedora>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sqzcT9Yljrwtlpvr"
Content-Disposition: inline
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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


--sqzcT9Yljrwtlpvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--sqzcT9Yljrwtlpvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeqt+MACgkQnKSrs4Gr
c8h/dAgAjVNYu5MjjvpdB9KBMwJI8D/N2Vq8VI/nsDsX8+cqYPIje6OMFEU2RnqE
isaa8gyokWBDnRpVNi73W7ElMTFpM9LzHz3dP2uzyCjQSJ/p39ZVCiStomebooWL
IikjBQy9dHUbJB6RTr58EFWdZaNa5FkJ5TTIstmREnYD+j6YTrHJzhLGqvhIoTiE
L+sXxXzUDxgGD8dg3qDxyD+Wpn6wQ1+GJbKf4y52kvPprS0reJbFEO64cXa8MaRj
Sco9NymDeLwph0YAC2VJ4uY2ilcJUlC3WhtKOSbQH7vHEidEnDH1QuGiBQXsBdJB
tlRe9k6c3TtoK2XE7SSGB4OelWtRFQ==
=SHII
-----END PGP SIGNATURE-----

--sqzcT9Yljrwtlpvr--


