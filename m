Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6405BC02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texDQ-0000WC-DI; Mon, 03 Feb 2025 09:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDN-0000VV-LL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDM-0007wT-7R
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738592055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBhfwMHFdfbug/NYFyh76kNBCtNYTSzoJ7X7tzsnPU8=;
 b=YMZDGA/I8m8cQv1K1J57NpXPCbee363suw93Y2WrnW9ISzdal71ZER1oLnyplgxW9qpLRu
 kNabbWolI07KhnN6zvVsNzUqNFTKW3fRm7j0iSDHK1YRSygosjeQ5ECsMqcz5hvT4sDRQ3
 YPOxKYhjszRC4PpVsoTqICOp8gBPb5o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-Ny0M4FPUN_KTpwzccmgIUw-1; Mon,
 03 Feb 2025 09:14:11 -0500
X-MC-Unique: Ny0M4FPUN_KTpwzccmgIUw-1
X-Mimecast-MFC-AGG-ID: Ny0M4FPUN_KTpwzccmgIUw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DF4E1955D80; Mon,  3 Feb 2025 14:14:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42C81180099C; Mon,  3 Feb 2025 14:14:08 +0000 (UTC)
Date: Sun, 2 Feb 2025 12:49:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] Block patches
Message-ID: <20250202174907.GA62424@fedora>
References: <20250130203339.256630-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YQT1Skfi0Y6kpsSc"
Content-Disposition: inline
In-Reply-To: <20250130203339.256630-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--YQT1Skfi0Y6kpsSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--YQT1Skfi0Y6kpsSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmefsBMACgkQnKSrs4Gr
c8hB3AgAq10yIEJ6Km3M4e+urc+5RrQwn7mPscxaHxrj8s5AYEWsg42dHlvgI/vX
9ud7MzPdarB+bn4TzCsmlBakaiJRZFrzDgvE1goq+EEng9/82CfVYzQ2O9p/Y2/h
RJI3aYJ2sU0rB5WBr/h82G8S/F0lXuLTL4F4ZSDDxfQ69KrVmGqhts24+A2t6YDR
J1G/AvrSL5/erbJv0/KYdR61rEI5rg8QtriYB1G6UaSjn2uRSKeJCwp7bOo08F+x
v3Rctu77zky7FV/RXFy8vMic2rO32EWXIMvwWZyXy8APCGmHwwoAXu83XH1D9kLq
XHAn+Chseyeyeh4lv7xbiLqOkVfdJw==
=m/+E
-----END PGP SIGNATURE-----

--YQT1Skfi0Y6kpsSc--


