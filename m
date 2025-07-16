Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED1EC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1W1-00016H-1Z; Wed, 16 Jul 2025 08:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1Rx-0006Xw-3q
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1Rr-0000Mi-EX
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dT0bZ+Cf6sE7e/e5V8U1fDshqQ/tUsqdwBg1y0pj9No=;
 b=BvMhgakUgeEM5InQwUuMMnFB+/0LSIY5QMJxF6+QESdhybYLZdnuxbVOlYoUuSMxAzVeva
 vlGItypmI2XgzUV0/9RiFCH6h571feYe5gqvx6MI5tgukqRMKXbP3E51cKv1+HdGx59VVE
 +7r+HfvJnl+te5tw0CP9efl0D1yOX6s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-oYhhNYVLO1uWjVQlvhP1_A-1; Wed,
 16 Jul 2025 08:41:19 -0400
X-MC-Unique: oYhhNYVLO1uWjVQlvhP1_A-1
X-Mimecast-MFC-AGG-ID: oYhhNYVLO1uWjVQlvhP1_A_1752669678
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D70FB1800D9F; Wed, 16 Jul 2025 12:41:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53CFE180049D; Wed, 16 Jul 2025 12:41:17 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:41:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL 00/57] Block layer patches
Message-ID: <20250716124116.GA328322@fedora>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pqBQ03GmNJ/oQlq4"
Content-Disposition: inline
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--pqBQ03GmNJ/oQlq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--pqBQ03GmNJ/oQlq4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3newACgkQnKSrs4Gr
c8jORAf/Rc+1DQuc+IsU5oBJq1Yz1GeZVasJuYOnPwe8EPfzlNKPog+APGrTpfGK
rWvPKiCKyncUS6C5b95gtfp21T7oTsan7tU8sn+f70DSprX/JL49BS5kPD4Tran2
cM+hB3yXfowVNn8eKApsIOQA1gsRxFNc2aWpI2CYKyVrvWtQ7/rjHF/46GFfZWuC
6stmISiRYumZnuVUYqVKFjiRppBaatiDFP0zxlwWEkMKj1AD+AqA2piti6KWQe7L
Sdtk9XN8ABplpx8xfow4kePlMsy/r4GJkWtTKir85DHcNg9/B4q6VrxVzAfPpvO5
nm+4KrRNE4QrU7OgxiXJoKpaPHtGyQ==
=6fUB
-----END PGP SIGNATURE-----

--pqBQ03GmNJ/oQlq4--


