Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370FEC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 22:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGQ07-0003HS-1S; Sat, 17 May 2025 18:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ05-0003GY-5Z
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ03-0006ia-M0
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747520843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O60b9V0lrkQD8+1+n6A853m7vfsfNHpkRVWx19HMZnY=;
 b=UkvgacOZ30aTA9vXLQgysQJMDbrrxUdTJzbTW5lsQmuGEhhvcLYMq5AKcDGknobgZpcUg5
 KA4dfZFb1HOka5gvEb0XeHyuN+u0ZgPG4UBv+vUhPxKXWrRNOChMvoILCcrPCkLaIOHG0B
 ogH1KP6ChQKa1dVX7LIqXdsjqpohJc4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-53Rl51R6NBSDbRV7jZioAw-1; Sat,
 17 May 2025 18:27:21 -0400
X-MC-Unique: 53Rl51R6NBSDbRV7jZioAw-1
X-Mimecast-MFC-AGG-ID: 53Rl51R6NBSDbRV7jZioAw_1747520840
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19A7F19560AF
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 22:27:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BB0E195608D; Sat, 17 May 2025 22:27:14 +0000 (UTC)
Date: Thu, 15 May 2025 17:53:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/14] NBD patches for 2025-05-14
Message-ID: <20250515215318.GA423634@fedora>
References: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PqQ/HOoeX2rK+zDe"
Content-Disposition: inline
In-Reply-To: <20250515022904.575509-16-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
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


--PqQ/HOoeX2rK+zDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--PqQ/HOoeX2rK+zDe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgmYk4ACgkQnKSrs4Gr
c8jpsgf/VPhDc2f5NyVFlnMf/aQCOuD2YspFZyOp3d+BBT9t5X4Ur/r07dpUvGXu
+iChFPnzTc1Jd8TAanfMiU9Jvgisn5MKXld7+NUwzPHm9xSAGtAazjxh+/R8kf6x
T0nkza8kQp+huz5ygkmu7twpn+xaSPRRW/baAif8ABS67FKIHEVpgjYUzcP8rMiQ
JpJpDVWAwZaGAPR8B6JSFfRM/qA+8fQ+DCzriqucKWcgHL556b0iyGSDAVr8Fknq
JJomugB7akaRrkePqcL9chvUUyEtHdLpNPJrM1rFf65rqnUbiS241qtLfWs4algQ
RsJAc2Rb5/ljP+dY9uueid2aYTfMnQ==
=2k2M
-----END PGP SIGNATURE-----

--PqQ/HOoeX2rK+zDe--


