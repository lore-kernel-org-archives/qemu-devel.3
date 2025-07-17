Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB321C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 22:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucX4G-0005VP-9s; Thu, 17 Jul 2025 18:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ucVgg-0008B0-Nk
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 16:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ucVgf-0005cx-0i
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 16:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752785919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3BY6Spdis9w9M2zPAIp7oWM9VKiKR1Ss/J6p082wk3k=;
 b=GHnpGksJK70XI/i0Of14SzpaUlQTW3/AIrD/DjE8I6Rg3muYS6k0Xu0XKh+OQuhJiAiZlS
 pio2EzO6fi4FK+9m33vC1n9M1ESckFkvGb208hmrNeOR1coTOvGkP34vtBVDlfiLidX65M
 5oI3NtW2VBGMzQOmLSvh4o74a6v7Ceg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-b2mbBY_SNKuPlOsNhfzygg-1; Thu,
 17 Jul 2025 16:58:35 -0400
X-MC-Unique: b2mbBY_SNKuPlOsNhfzygg-1
X-Mimecast-MFC-AGG-ID: b2mbBY_SNKuPlOsNhfzygg_1752785915
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B15111800C38
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 20:58:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E71CB30001B1; Thu, 17 Jul 2025 20:58:33 +0000 (UTC)
Date: Thu, 17 Jul 2025 16:56:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/6] QAPI patches patches for 2025-07-16
Message-ID: <20250717205635.GA378750@fedora>
References: <20250716172535.3520175-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NeGn7mgfXORTMURs"
Content-Disposition: inline
In-Reply-To: <20250716172535.3520175-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--NeGn7mgfXORTMURs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--NeGn7mgfXORTMURs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh5Y4MACgkQnKSrs4Gr
c8hj6Af+JLOZ9ROt+vPfEC+f9unUf36uFc2PhSpYwnElb9srOic7n4uzaxoHzDzL
B+rzC+QZq4D39UroFpBYUeg33Pbi5LpehMsSJLbYiRjjpocLmJC6dd3nza5kEAdJ
WAhJkQ7S1ZIwzIDMgItHBFin/1JCoNQt9SCUdb4QGpu+03xDEtqmEoIcO836qSGa
egjf3keInDPL+W5E/prh+MiCyUD5oWM0UYt8X4gEw0ajqvYkF6741lA1YH1HBGrC
qAEhElNZdwhA+XRZFaJTAq5cAXNJ9Fnh2SAwgnoEGqeyutXqAa9etjh7V5MM6aCi
gSQ+H0WoQQ/Psi3l34MIkA/6GWfErw==
=q+i7
-----END PGP SIGNATURE-----

--NeGn7mgfXORTMURs--


