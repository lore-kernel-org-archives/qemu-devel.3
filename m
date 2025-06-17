Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4455EC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYdW-0006l4-6p; Tue, 17 Jun 2025 11:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRYL1-00017t-0P
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRW5Z-0006ID-OT
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750165854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6mpHHuzj9GaZX3d6VUesdjLnJKjZN4fyUJ98gd8GpM=;
 b=dEwGwf8TPI8C4xwrAzMpBN9d1euHhW9jQRJ5ONX60H43QqTzlZGQELLIE3sdNoKObmohVA
 b2UKaNLQ8KNr5XoWmmkv1KMDpUNWEoXG3v9DE45F2iCkWhGyTi5H7rKVWB2yOqy1u1taKB
 hR6gMiHfkS3dtaF5kTVYfkBsOctlfUc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-AR-4ZKAyM4KchgH-X5G_NA-1; Tue,
 17 Jun 2025 09:10:52 -0400
X-MC-Unique: AR-4ZKAyM4KchgH-X5G_NA-1
X-Mimecast-MFC-AGG-ID: AR-4ZKAyM4KchgH-X5G_NA_1750165850
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0065C195609D; Tue, 17 Jun 2025 13:10:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91B9719560A3; Tue, 17 Jun 2025 13:10:48 +0000 (UTC)
Date: Tue, 17 Jun 2025 09:10:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL v3 0/1] Tracing patches
Message-ID: <20250617131047.GA114693@fedora>
References: <20250616172112.428142-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3qgxTI9JXRJ1WE6O"
Content-Disposition: inline
In-Reply-To: <20250616172112.428142-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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


--3qgxTI9JXRJ1WE6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--3qgxTI9JXRJ1WE6O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhRaVcACgkQnKSrs4Gr
c8gdQQf8CC4vFDW1rjam0pnf+WWLIn8ZwDyNwJDGBMrlEbfivz6M18Cnfn0R/Sq1
1a/GNL1XOPc7bPSo8DBUs5f/M2K1rTnX6dp/hQidbeEeicARRG05PrJnbP/uDJ1t
zseUe5d06zT64pd3/FetLbioT04htn4eqYQIubh+vAR+AqBqnf/73UyGKyf9zQJe
gaUE5pyUmptRA9RvgSm29K0SnEJ91R0HXw4Aq1sMtS1eDrLhqI85CBONIUFttAci
urEPfhoHIuGkA8SwyhKPODt/Ln/34kkDFP8TTIMtguURDC0Esrwq1Nj/CvTWWWqP
TVk3ujnPuJYd86HeY6e2p/NJYdAFNQ==
=kZ+s
-----END PGP SIGNATURE-----

--3qgxTI9JXRJ1WE6O--


