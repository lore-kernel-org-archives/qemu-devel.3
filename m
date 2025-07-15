Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE25C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubluM-0001u2-Sa; Tue, 15 Jul 2025 16:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkZ-0002dQ-8y
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkV-0005QN-Dt
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752609332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x6hS2kX5vJ9fM9+vMxEbYMd2hmIuQpCdSfG7JcgzXGk=;
 b=XVX1wG4NnVAcVyjsDtk28xk6lsWStU3mvvggXfohiETSqSdkAka4kSgjdaXbZujKpYPAoy
 72aYcGkTbWi5llwzYsbIzmRQk0CJWmooK1L7DPFkfiKB+4r5PD9hFPQ59drhw5zJMjamV2
 HEK+oQSueveML3QIh8niPMyyiIT1i4o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-wuPXrJXYPMmVA6D9MD8Gpg-1; Tue,
 15 Jul 2025 15:55:29 -0400
X-MC-Unique: wuPXrJXYPMmVA6D9MD8Gpg-1
X-Mimecast-MFC-AGG-ID: wuPXrJXYPMmVA6D9MD8Gpg_1752609328
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F5D718002A9; Tue, 15 Jul 2025 19:55:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DE6E197702B; Tue, 15 Jul 2025 19:55:25 +0000 (UTC)
Date: Tue, 15 Jul 2025 15:50:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 0/6] Trivial patches for 2025-07-13
Message-ID: <20250715195017.GA242254@fedora>
References: <20250713091059.35165-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W7xiTtneZtIlLRFI"
Content-Disposition: inline
In-Reply-To: <20250713091059.35165-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--W7xiTtneZtIlLRFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--W7xiTtneZtIlLRFI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh2sPkACgkQnKSrs4Gr
c8gpoQgAwKr4zRDACmMWRrpsNXNoqNY5Xm665IrKM9Yqw32VeFJaos1D5QqD8ftZ
6j0aAZPQjLBpAXNfA0EQMeRrHghenDVe+kClLnzBfOnOfN0q6VlSU82yAijREQlv
6eYVDhQMwNq8BEdJriD6GqsiToNGCGK0haGlomx/5s/hO4cSsX52aDw08ltTH4NE
ySlITLeERoH8xJVKDyBGoXfm+48UrpPmsvW8tf5owLhAxOqcHuBgZyVSjrPECgei
9zPQczesEMIY2SjBl843E28u1OFeu481zpROoPUWb/FG7K7mq0zYQuAh0DvIFk81
1X3h+PLbdVs4m11dwCcr6GhUgYhWTA==
=AlAD
-----END PGP SIGNATURE-----

--W7xiTtneZtIlLRFI--


