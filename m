Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4796C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcCW-0002zi-Oe; Mon, 26 May 2025 14:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uJcCS-0002yR-0d
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uJcCO-0004mS-Kr
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748282717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBFnDzcR7mTX5Jx/Ur1m0hZi37CL9PCQAI6KEXQ6wEU=;
 b=H/itcLKjc6AQCCaEZyo7vpUkSsVTg+U4Y1h+ufFmpSupkj10jL8DlOBS42oMPwrFP1jMcb
 eyUQi6eeea7pG9PDSPPv/84PxuDokQJfl6yIWq9bouMEddxu6YRqlsH8lyimQcXfsOle6L
 JQkFMPuRbpGM95VwQeRgLtOr4bLbmvI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-zaK26mV2OgWOkFCi0gtGeA-1; Mon,
 26 May 2025 14:05:15 -0400
X-MC-Unique: zaK26mV2OgWOkFCi0gtGeA-1
X-Mimecast-MFC-AGG-ID: zaK26mV2OgWOkFCi0gtGeA_1748282714
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44CD719560B5; Mon, 26 May 2025 18:05:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 787411956095; Mon, 26 May 2025 18:05:13 +0000 (UTC)
Date: Mon, 26 May 2025 14:05:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/39] aspeed queue
Message-ID: <20250526180511.GA12355@fedora>
References: <20250526080512.1697528-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="amirXvl1P2ShuEIR"
Content-Disposition: inline
In-Reply-To: <20250526080512.1697528-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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


--amirXvl1P2ShuEIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--amirXvl1P2ShuEIR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg0rVcACgkQnKSrs4Gr
c8juxAf6AzWIgRck7KW7wrqoXVkhmpnui8VlBhOdnUGf6oQGhRxnR8ODaIC4W4th
fuugOqOD3DbwnWDD4FAgogi1w5CQ7imOPyvKdF9mjce9PjY6+2pWQbLmCHyKubOR
m55nfXkRU7Rm0X3LFt5aPmiUUM6g3J2hTXieX2eoWW7TXGF3UneQPIiIIUv4W+vv
lU4YyBXbZPBokFHiyU5QE4yQJJpUvKAaYuoaYo3Z/bySQyK9qxMqBrFDdGXyHI1Y
lS4PV81zlXUwgVwqlcX9jv9/af5nqZFJhJaAPCMyTDjZUg039bCVx7BthfRpyf9R
/+Ls5FxFU7o6AhI0Y3US7HZtMQSkOQ==
=Zh2o
-----END PGP SIGNATURE-----

--amirXvl1P2ShuEIR--


