Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B69CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 22:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPpHq-0005bg-8w; Wed, 20 May 2026 18:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPpHo-0005bI-QN
 for qemu-devel@nongnu.org; Wed, 20 May 2026 18:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPpHn-00009K-3q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 18:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779315666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=da8fE8ZKDY3iF7DkDMJRlzMjDCu2ckZ/8rGy8iJRSyE=;
 b=KOOUaLQtEG3zi9zTRci0FQT/OUwfani5jeHz/YyfSaAy15jIIR987SIxFM9zaQwZ6EyhtE
 Jxk3xo2DqbnpAJiuy8FCMJDl4d/QEA68zGUqsrGiioFOj7iHaBG1fGrs7dDrfrElnpPAuD
 S/HT2NyIXiozkNQuOHbbavt4BQcHO4k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-GqeqYQ6OMfGE_7JGcqi5uQ-1; Wed,
 20 May 2026 18:21:02 -0400
X-MC-Unique: GqeqYQ6OMfGE_7JGcqi5uQ-1
X-Mimecast-MFC-AGG-ID: GqeqYQ6OMfGE_7JGcqi5uQ_1779315660
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D3801956080; Wed, 20 May 2026 22:21:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.222])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBCE21800347; Wed, 20 May 2026 22:20:58 +0000 (UTC)
Date: Wed, 20 May 2026 18:20:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com
Subject: Re: [PULL 0/5] ufs queue
Message-ID: <20260520222056.GA403949@fedora>
References: <cover.1779263628.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lu+JjvY327Q+8EGW"
Content-Disposition: inline
In-Reply-To: <cover.1779263628.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--lu+JjvY327Q+8EGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--lu+JjvY327Q+8EGW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoOM8gACgkQnKSrs4Gr
c8hSoQgAixaB1QHJd/hTUDO7R/pPNWBggrhMcs9yH/p5z335VHFuJTYCQ/o3PQNL
ectNnsh5xBNavSgJ+0kimvsV5947G2ufr+SNU+P6O3NJ76hryPFJq9SpO3LB1fJm
HcIoEcGuRLjzC8o+BcB/wZS9aZQLfQbMlB8Dni3UzB9VFS8nhVadl2hmg1JN71XH
zz+NQKchr0Ne9vrCye3jRvtf8jtPUHHjaMifJD2+CxopkAzVX42MqcJ+K1RnyKyh
2ky19wNkMcbAHrWfduLUevg42ypMbMFlLcgGanI4iY07/bj7jdqv9xbf3QNoXUjN
74qlaE4WjApVGy+1Vh0VDXFng1+pIw==
=9H1L
-----END PGP SIGNATURE-----

--lu+JjvY327Q+8EGW--


