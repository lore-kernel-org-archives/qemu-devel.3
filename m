Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4CEC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhkv-0002vA-QY; Mon, 24 Mar 2025 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkY-0002sk-Fx
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkV-0007W6-QC
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQGR7lkO7+GiaKkL6i5w67XzWNs36HQflkKrEh3XOgA=;
 b=VT9hbZ2GhrfSv7EIAvX+ZuSzHJ8CfV0QbkyOF8ufap1loWYAnEB04j0X8G6fQuhSg3RbJ4
 z0KS23BEdNStHIEE/QwYRW1W9nDNSeQhnUCPEOHThzJsQLtXH1nIpGz9EIGdUnPSjqpfrK
 KD0yk4NOJBVrpA/MzmqObwmKrO5iyvk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-KccxFEc1MQK_FnNREEiqsw-1; Mon,
 24 Mar 2025 09:21:45 -0400
X-MC-Unique: KccxFEc1MQK_FnNREEiqsw-1
X-Mimecast-MFC-AGG-ID: KccxFEc1MQK_FnNREEiqsw_1742822505
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00CDD19560BB; Mon, 24 Mar 2025 13:21:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 723C31808869; Mon, 24 Mar 2025 13:21:40 +0000 (UTC)
Date: Sun, 23 Mar 2025 18:29:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 0/3] Trivial patches for 2025-03-21
Message-ID: <20250323222928.GA41857@fedora>
References: <20250321081751.1999498-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Xoz1HeSZZkGmwHD/"
Content-Disposition: inline
In-Reply-To: <20250321081751.1999498-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


--Xoz1HeSZZkGmwHD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Xoz1HeSZZkGmwHD/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfgi0gACgkQnKSrs4Gr
c8jwUAf8Cu/4yr0n0GgnTKna4Ds0SaZuNZBrs27hjAoVnD2iOAB+14lr2hpK5Rl/
mzjJN8W7WRmk1ZbDDrorX3ZRePbTbWBZaasHoh6FoecV/1yeD6GuISchcw9aqfWc
UzB1kIEAN1XBl1drsGya7Pnp7jvrAlhvLbX3RwGehrGA3xduAT0xWyuB+tKXOooK
bVdGWNuqxsjuZH9p18HzoXrNX18FTRUtvXuRApYcuTi+blKauC+HXEtCWjR+AxZQ
jqzA7MVqIEqGHvuPd/aaTwwqEhmPbSda9DDiyI28mmXO3L52M6ICFTkQ7R58hbG7
LDPLxUniLB/CY0eMXk0MsZiAlL6OWg==
=tHUL
-----END PGP SIGNATURE-----

--Xoz1HeSZZkGmwHD/--


