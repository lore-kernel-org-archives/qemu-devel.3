Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7C2C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 14:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKega-0007e4-Vh; Thu, 29 May 2025 10:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKegZ-0007dh-Dw
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKegX-0000DP-B9
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748530602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9Yf920IK7V2z35+bkDaSy0sU35j9PUnpwnjnF09gc4=;
 b=Pw+00HaG6njzpCHQL9Ld8AVqLI6hXKN+bL2wLw5jXRqAC6b1z9gCldiqXTFA32MsCOAjMy
 J6hpiA/KiGWh0HmGGutuHn3JAdPYnGVR7uXNGQMcxk8Ppq45e/8AuJesjnnqHTjoMPV0tD
 gI8CIjKPr82av0KYwA1F0BVlIyzqS3Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-jRndJLS1McmYQR2VlFOjmA-1; Thu,
 29 May 2025 10:56:40 -0400
X-MC-Unique: jRndJLS1McmYQR2VlFOjmA-1
X-Mimecast-MFC-AGG-ID: jRndJLS1McmYQR2VlFOjmA_1748530600
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09EF119560B1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 14:56:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EB9D1955D82; Thu, 29 May 2025 14:56:38 +0000 (UTC)
Date: Thu, 29 May 2025 10:56:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/13] QAPI patches patches for 2025-05-28
Message-ID: <20250529145637.GA60844@fedora>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9BnLt0XzhoP/oR5d"
Content-Disposition: inline
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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


--9BnLt0XzhoP/oR5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--9BnLt0XzhoP/oR5d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg4daUACgkQnKSrs4Gr
c8iiNgf+NIxizX+b97GeggLons4xOYQKZ491QhhEGFj/RvqE5uzf5LW7QvTH95U/
eDVIo7R+Xx0bBg+7jxyH5V+O0bLFNL4iib8wYWVhcbdMjbTOr6gvojTcPEZtBTrA
ekPGYOea1WFiNIlvS1n8SSf+L+TvTYYji3n+HWh2qKch9K81AVbhCoxCnUFW9/wE
wYZYy/DEHqaw+iCWAVj2D7ek5lYyk3Jr53yvV1bJlIcKlgKDHVfQD6l0Yz5kSjgW
5ylWsbpPXkztM3T4rmvEIyyPUkP2yg6Em61zOPik6NSCqP6q3QAPQ6Lsb4j0sEo6
zExPUfcG2aDf176VIxWiTCmansjSDw==
=q0Ko
-----END PGP SIGNATURE-----

--9BnLt0XzhoP/oR5d--


