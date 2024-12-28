Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BFBE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 18:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRb6l-0002m3-P0; Sat, 28 Dec 2024 13:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tRb6a-0002eo-OO
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 13:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tRb6Y-0005kp-Un
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 13:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735408797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=byLuYP9n1MrRQ0R9RhO4MKbQbolMhYh+Vl7XvA57xCA=;
 b=LE3YY8ZGKVIAEBtJ8x43I3ohQpSNyt/n45vQlpBCWDFWD4vrbXIKJ0BZKd9T99A3FR18cq
 LHalqkODgWdnfJMCe6OnIhY4OwLTBqFOz5f9PTG0/2PtagEMd41lQ7U6X6s9zn9FRJ/8NK
 kaDu4UWgVhzJQoo817noMP91ZuZ5ikw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-opoIRoUXOY-WmhA64JAsyA-1; Sat,
 28 Dec 2024 12:59:53 -0500
X-MC-Unique: opoIRoUXOY-WmhA64JAsyA-1
X-Mimecast-MFC-AGG-ID: opoIRoUXOY-WmhA64JAsyA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFDC5195609F; Sat, 28 Dec 2024 17:59:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0AF01956086; Sat, 28 Dec 2024 17:59:44 +0000 (UTC)
Date: Sat, 28 Dec 2024 10:14:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PULL v2 0/6] loongarch-to-apply queue
Message-ID: <20241228151430.GA984362@fedora>
References: <20241227062208.1232281-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4JbE6gvB2CuqvFA/"
Content-Disposition: inline
In-Reply-To: <20241227062208.1232281-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--4JbE6gvB2CuqvFA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--4JbE6gvB2CuqvFA/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdwFdYACgkQnKSrs4Gr
c8iznwf+PcRVM70U9imj8fLR/kqe5oo8L5xHCBgbNE0HI6zT8ye5+cbrEWIVqUEP
KOulscda7ZvRWbHGlKhuv4GFGyCXOFvR90c0ak96aJsWBLBXC0I5BniqfYzR9NLU
ZCTzJtjYkDIRble9n4wueWaKjOuFxvvEqinxWmbbNKUKvbZfsb1kF3iAUWeYBIJ4
b1h/j2ABujQWfA6kus5AvdOGbF2dslYZI5DaYf+zgW2yf1OKAnn3k2it2jv5d+qj
Z3HZ7CJ5RnzbUSfJVAw82vFD0y+bWo6VOUa1n1ovleF/ENiI/qczXPhUFxG2iZoo
pOApKgdo2EzoGtNCJa7MuS1ERbnOFA==
=fLPT
-----END PGP SIGNATURE-----

--4JbE6gvB2CuqvFA/--


