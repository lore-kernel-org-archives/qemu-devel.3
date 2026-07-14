Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C793BC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjtTJ-0002vF-IZ; Wed, 15 Jul 2026 02:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTH-0002uk-90
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTE-0003rj-RV
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784098310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eoB3kP9zvxaGpQbigFGXiQKBWqZv0dG1rvG1jtdwBbE=;
 b=KQ1GaqKZgyOwSIukmywDdPKg3gzd62Rw20NSuGtN7qHOZNObuNw09tjn3F1cVlP/p4BMnh
 jPfrdM8mWo/W1xvh/uWI68zvlvEVCrtsr4IPSyK8ZDKHQnWWctMRlYe3p6BxGdzx9GO8Bt
 5wc9jG8oS6O8/a5l6aalM6zGrAAJLtE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-FqbtAxB3N_i2A2_vqFYl_A-1; Wed,
 15 Jul 2026 02:51:48 -0400
X-MC-Unique: FqbtAxB3N_i2A2_vqFYl_A-1
X-Mimecast-MFC-AGG-ID: FqbtAxB3N_i2A2_vqFYl_A_1784098308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11CDA1956065; Wed, 15 Jul 2026 06:51:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8961A180044F; Wed, 15 Jul 2026 06:51:47 +0000 (UTC)
Date: Tue, 14 Jul 2026 20:23:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/26] target-arm queue
Message-ID: <20260714192310.GA706195@fedora>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QXcZ2srKBJjvP0+x"
Content-Disposition: inline
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--QXcZ2srKBJjvP0+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--QXcZ2srKBJjvP0+x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpWjJ4ACgkQnKSrs4Gr
c8hNugf/UvpwlM7/ynkqYjfCBQOUHqv8vC5yL2SP2BMo1r/TrjbUdiIkg8kfrhY0
dXAay9qIOXg9LpYsmRxOjJYuGJx0uRaCnI2TIoESUhdgclNdpI9zl9olwLTA0+QA
OGPR9kgo0lq0kCGkmI6EwTj33nGv7bBhEdayWRQ1EHD16n1RiYwqXF7T4bB14VFT
mL1M+6U/27+UtZDqMX4veYk14R/HIMEwY4z7oTOgsWTjjIL8p7oTuaFq1aihb8oV
b22QsCh3vbAWWSMwtNV53u/Qto0o+vLUqtlCaa+bwOpZOXIVhP89iW0+ZwICTg+U
SRAg80pFC7KxWYmIatcAKe04qXvNQA==
=buYd
-----END PGP SIGNATURE-----

--QXcZ2srKBJjvP0+x--


