Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859ADC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 05:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trrmu-00011g-3P; Tue, 11 Mar 2025 01:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrmr-00011C-U1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrmq-0006TF-G5
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741669455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+k/pIz+X/4xZbtwrl4O7DDKeiVdvTS1j8lhrU97GgP4=;
 b=QV22YgHVvDOCSygPOM4hNJJudqOESBvlayQJ5dIsQRyf2BNUQ7frBxWRaXEHVXidefdTmk
 gYAuxOeabErB2Bj6rShf+GHKELdeTkfa8srhX70VhJpgwwWKrFkVw+d8UPdIN42f+sEluH
 blP4miYbbcRf5FGaW+9fDYTyS/1IHwQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-nV_wOLN_NCGyqdGMu0dcbQ-1; Tue,
 11 Mar 2025 01:04:10 -0400
X-MC-Unique: nV_wOLN_NCGyqdGMu0dcbQ-1
X-Mimecast-MFC-AGG-ID: nV_wOLN_NCGyqdGMu0dcbQ_1741669449
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD1591809CA6; Tue, 11 Mar 2025 05:04:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9B711955BCB; Tue, 11 Mar 2025 05:04:07 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:04:05 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony.perard@vates.tech>
Subject: Re: [PULL 0/3] xen queue 2025-03-10
Message-ID: <20250311050405.GA602848@fedora>
References: <20250310144516.28828-1-anthony.perard@vates.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LCLMnbjli9QK7S0t"
Content-Disposition: inline
In-Reply-To: <20250310144516.28828-1-anthony.perard@vates.tech>
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


--LCLMnbjli9QK7S0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--LCLMnbjli9QK7S0t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfPxEUACgkQnKSrs4Gr
c8jMDQgAqf6pM5KrVtUKxdrSBDKix0gNw9z6MrMdHi3iy4vy858vWkawwVd00eC5
XgKrua3L0s3uOUuMiT1iguDkGwLY9gNMCyCx+NVQgdcBx9PquqMzZq475bJQor4N
rTr/RoNp+Hg7z2HnPfZRQ9nTIqOZbDicrfA6NscpJqiW0o8baV/AunbepZAFVhgv
7T3ut4mS9z29C0OLrsm1NZERzIjujKhMQ/wQMU/rPE2Ab/ONx6RluWkzk95FDQ6F
5VL8BPBX6qoFTRpUB4SC73km6tqyt8jB87kT5H2WM/cV9hIRZ7Nt0RTMiisiGeqX
BGXpnr3ogtmfdP+tY6F3vubTwXG8dA==
=lLK4
-----END PGP SIGNATURE-----

--LCLMnbjli9QK7S0t--


