Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6729C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNC1f-0002Gt-Fg; Thu, 05 Jun 2025 10:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNC1d-0002Gg-C3
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNC1Y-00029u-1u
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749135411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCeQZ8rhksnrWKIedRzgUQLrZMSJuRrpERkMLVrc9FA=;
 b=WVPuEP3rHCNJcpQTK1cDujglAJ0h2E1RKM1xRn8mSQdFyZvNFizG74IC/T3a8CEcyNykrW
 V5xZcnpTjDdzns+oftOVZTtpX0xUvm/KmqfpJhKpBhFfiIa2z+ZsPa9vAMHMGfbUs7x9g2
 qnHLqAfdA0WROca0BAVnYknwMVKQK6U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-0Ws9Bv5iMN2swnIw0Ovf6g-1; Thu,
 05 Jun 2025 10:56:49 -0400
X-MC-Unique: 0Ws9Bv5iMN2swnIw0Ovf6g-1
X-Mimecast-MFC-AGG-ID: 0Ws9Bv5iMN2swnIw0Ovf6g_1749135408
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF8D8195608C
 for <qemu-devel@nongnu.org>; Thu,  5 Jun 2025 14:56:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 244C6180045C; Thu,  5 Jun 2025 14:56:47 +0000 (UTC)
Date: Thu, 5 Jun 2025 10:56:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/16] rust, i386 changes for 2025-06-03
Message-ID: <20250605145646.GA444867@fedora>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZT0Bipfbxmm0n+ML"
Content-Disposition: inline
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


--ZT0Bipfbxmm0n+ML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--ZT0Bipfbxmm0n+ML
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhBsC4ACgkQnKSrs4Gr
c8jxrAf9FPekCKAm1aOcdJSpbTgWJ9NYBetFTkcJH44cuWmRz3dUbPK6Iy8DcozE
+U6b37UTRKEHxyU5hBs7Q71TdHWpS0uNCBJ1torGNDj/m528wg+dqo9jXQ3cGl8A
a10Wjv49CPfUUo6LXMztlDB8pmrg3KVllMtYcrK0IdGK7VRXNClB6wSCsJp2gtMm
+fNs1lVWId+KvQ2irelNZ43XyN7S/XuOsUhBfpZf1uHjnVfK/hgNSgOiEFouwVI5
cZKvpIgO6CJooMW5f+p5PnYLwCe1FdaesK8n03fhGAWVLeg6Xn92fYb5DHOstwxw
/aW/SLWsJMSadm0aD4pBJB/pq3vfwQ==
=9Het
-----END PGP SIGNATURE-----

--ZT0Bipfbxmm0n+ML--


