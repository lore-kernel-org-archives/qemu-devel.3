Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72692C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 02:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thg9i-0008Eg-5I; Mon, 10 Feb 2025 21:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thg9f-0008E4-I6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:37:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thg9d-0000I5-KN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739241460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2fER0An3lR0vtoo8QSlwxAUQNH+k4M3284XKSICOV+Q=;
 b=Y0jj/ETmmMR8NZcK/iurklSzxEjvN34D6YAUFmfNMiafFWEDU38NQCY/2LwnzAOV1sUzOp
 YlNhwiqmFi9cguGJ3BiLFjL9YtPo5VMvLWoigCWiy+SJr/M6hw5b1Q5i8tlMWHgzgiOE//
 LTL5K3oCFe88BF0iHMR8FAamibnSyiI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-3oevupjwOq-U2TyGXvz47g-1; Mon,
 10 Feb 2025 21:37:38 -0500
X-MC-Unique: 3oevupjwOq-U2TyGXvz47g-1
X-Mimecast-MFC-AGG-ID: 3oevupjwOq-U2TyGXvz47g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB4D31800873; Tue, 11 Feb 2025 02:37:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B6DE1956094; Tue, 11 Feb 2025 02:37:35 +0000 (UTC)
Date: Mon, 10 Feb 2025 21:37:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 00/25] Block layer patches
Message-ID: <20250211023735.GA149858@fedora>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TeqTH5mtBQRZ6oKb"
Content-Disposition: inline
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--TeqTH5mtBQRZ6oKb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--TeqTH5mtBQRZ6oKb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeqt+4ACgkQnKSrs4Gr
c8hSAgf9EtQA9GrFnXKSh4arym2isNCdBXaUnSOn5k38RXvU1DcKmunmiCGyexHX
A6u1EFkJYmaocOxpcjI2QVLeRw+fGr2OapIn1ZBfZZXa0wSewiD906oJmd56wKpI
o4dvdMwoQqjIszAIqLJuOLFWlmBXlzmGDiw2Gnomj6YgdeKxNO6ZlJbmzkK6EwxM
AaYHiSG3hRvWK2ZCfx6dNiicdQFjazma6VIb8XetXZn16IOTT0u+F+de6Eb/Z+MD
06pfDtmIjSN2TxiOrGXuKCcj4ExXy1YE0cvaztium9SNY5HlnWJb7P1edXdZp4FN
9ooaVMKfVs0W91pi8GY0iLMx3Jrbww==
=beph
-----END PGP SIGNATURE-----

--TeqTH5mtBQRZ6oKb--


