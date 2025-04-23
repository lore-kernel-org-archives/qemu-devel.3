Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 17:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7eMc-0005Tz-QP; Wed, 23 Apr 2025 13:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7eMb-0005Ti-Cg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7eMZ-0005BR-8x
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745431101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HVGsuir8uw83Mkj1Y8521HV6NN+LGjuI2FATsEMM6ec=;
 b=Q4ZKWoEMYSoEmbojYlWJbvBxtU7SFx+b1Ek3Zu5YzEw3OSbsy8DCFr3uBvIiTaw8A+QZLE
 IUxiywQY3Do3PSk88bvDAqxEDIlR0kwGDYIpTVVY2rKDssZDf3du+cLzBDuA3OarG95aqN
 jav6bySxBemj4tAgWnH5MwQPZx+MQn8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-oK88PrJHPNWEOve0DC5KdQ-1; Wed,
 23 Apr 2025 13:58:19 -0400
X-MC-Unique: oK88PrJHPNWEOve0DC5KdQ-1
X-Mimecast-MFC-AGG-ID: oK88PrJHPNWEOve0DC5KdQ_1745431099
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAABC1800261
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:58:18 +0000 (UTC)
Received: from localhost (dhcp-2-16-89.telco5g.eng.rdu2.redhat.com
 [10.2.16.89])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4760C1956095; Wed, 23 Apr 2025 17:58:18 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:58:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/34] i386, Rust, SCSI changes for 2025-04-23
Message-ID: <20250423175816.GA353719@fedora>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jflbwcHjc5fE4a/M"
Content-Disposition: inline
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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


--jflbwcHjc5fE4a/M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--jflbwcHjc5fE4a/M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgJKjgACgkQnKSrs4Gr
c8i38Af/caramjvVlIWrXly2/d6c5kvS5wp63DR/CKHBwIoVuFxU5uCBq1QmRLTR
DgiWyVOjvj/XcMF23ff+/0f0muXmtTvusH2t5nKVZdmrmzoN0UB1oXuoxyHLb+/y
++Y5AV072ts88NEGxNYJyTVuYzKiz0+/Cji26z4H0stx0Ynd8oGEWfvshjxU9Lhe
6mXzfkOaTrJGfw7revtqrOoeyQPdLlHiKnDyE5zJShYH9IFRofCCngHdKKvfXFwU
IjbUrJ2Cwaqx6FwCYyTlbwQVfzsFD/Q+SrfxDtp50yOv0aN/oX607XXWiCPxBWgB
JcLXYbvcl9TGqjHsrdOAT+3gu3L3Ug==
=bz7h
-----END PGP SIGNATURE-----

--jflbwcHjc5fE4a/M--


