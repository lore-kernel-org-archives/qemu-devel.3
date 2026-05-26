Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B81CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtFe-0004dO-BO; Tue, 26 May 2026 10:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRtFW-0004Mm-Q6
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRtFV-0007DU-7q
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779807556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ATTUON2i4IU+4SKtIzQw+ncHlBNg6Q6D4XxNkZ38H5k=;
 b=GfiMOgMXoMGwUeTqslkkYa0D8AV/AHcRA5XJTxq9bZDjD9SljpTGDsnjyyG1O/psXKlg5r
 o325dYjrChaYE62ymQjCAOY7NKZYfdYv+Pr5ck121FS1BW/6ZZaPQDVoY+Ud8i0sSSvuKB
 FU6Yk/6sieJDkftGGs/bp12CkIRQKJc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-8U5jcD-zO3WvE_mvqn0FQw-1; Tue,
 26 May 2026 10:59:11 -0400
X-MC-Unique: 8U5jcD-zO3WvE_mvqn0FQw-1
X-Mimecast-MFC-AGG-ID: 8U5jcD-zO3WvE_mvqn0FQw_1779807550
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34821180061B; Tue, 26 May 2026 14:59:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C51DA1681; Tue, 26 May 2026 14:59:09 +0000 (UTC)
Date: Tue, 26 May 2026 10:59:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@gmail.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL v3 00/38] Ui patches
Message-ID: <20260526145908.GA1733401@fedora>
References: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YBPrUXO9SBHSR81t"
Content-Disposition: inline
In-Reply-To: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--YBPrUXO9SBHSR81t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--YBPrUXO9SBHSR81t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoVtTwACgkQnKSrs4Gr
c8jXtgf+MUCRARGmEt+Ay0eEELSEnSpl5Xel8Rqp/V8DFH61YiEa4PVU8jZgiKFH
J6lLeJ7q9eqccDSufXdeHQyH1Nb1gsv3+k1OXAPIjshfsSoFXjFXq0cUMlheSsw9
lB6X0rxHWimVu+qN7JalkTuueT5AlIopDJfV9VSbeaj8NkU0vc5SAEFvU/zbrpZo
mmh0XLFUYENSnkChQRiyZsZj9RxUNeJKZGroV4DTLIkn48JmgeuLwTHceiAm9P8j
NLgPcXleEKJs2WBxQo/H6oQa0WRvXeqKuPBMRZNr7UYT2qE6Jf2UdUnOqeC4Snjt
JgZEfHgjh0q0KAj4cOReWR/kPGLoDw==
=5Hdi
-----END PGP SIGNATURE-----

--YBPrUXO9SBHSR81t--


