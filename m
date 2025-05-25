Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93882C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJD9a-0005sI-Tg; Sun, 25 May 2025 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uJD9Z-0005o2-3a
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uJD9W-0007Ej-GL
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748186437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWG3ZwG/6+QVCXgy9Ie9kdr6YYEjPvk2A2Ppku2jSTM=;
 b=dFnDYOepXvp5U8hrlSSDJyDtkTudB3kYrIGvifxxlod1De2pT3zQ+h+EL6OQpaRIV7Rg68
 l/IjodhNrQIWflGG3J1eTeMOqGZsGLF6ZaVGryq2ZpvXzmXaZxKHH0d8km43Uz+2FASP1y
 5+8sNFm62ATu9iclDm8isQlJFkdgtVA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-xQTa-LyOOAWeEDLGn91aQA-1; Sun,
 25 May 2025 11:20:35 -0400
X-MC-Unique: xQTa-LyOOAWeEDLGn91aQA-1
X-Mimecast-MFC-AGG-ID: xQTa-LyOOAWeEDLGn91aQA_1748186435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 342121800447
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 15:20:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AFFE195608D; Sun, 25 May 2025 15:20:33 +0000 (UTC)
Date: Sun, 25 May 2025 11:20:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 0/9] Audio patches
Message-ID: <20250525152032.GA68471@fedora>
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XuAgDUsBtCUWhDF6"
Content-Disposition: inline
In-Reply-To: <20250525132717.527392-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--XuAgDUsBtCUWhDF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--XuAgDUsBtCUWhDF6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgzNUAACgkQnKSrs4Gr
c8hErwgAvkHywCJ/sulHt+LTCUAvQxXwclDXrWXvUnzcsRB31VC5Ajp8ZcFxEaqO
5tlmgrhXrxFrW6N0vYDySzHFkmj9KtQ2Im1H8rncrHnxEcErdr51boc/vdsLfhCS
Wj+D8jySQOnLr4Ufcdc6pdEAPX6Zn3MfoLjijXcpRO7tIAEEIpF7PYPmucscjBMY
pmi62Fo3Dn/A9gT2VpQoMTldp7Pzh4hyIalK7XVA8JPvbnlIz2xuv8EKfs+oRfCZ
tcULGzC/s5UvAE8bRPnAZHG/6fMo+CTaBwGWiQq1eK7uufnvtLPBkFfKkd98PNJd
VxdiWBmIN3EQuGUlkAlS7s3s9W0FzA==
=BcDw
-----END PGP SIGNATURE-----

--XuAgDUsBtCUWhDF6--


