Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767FEFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVJ9-0003Hb-VK; Thu, 30 Apr 2026 13:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIa-0003AM-Hj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIX-0008Rl-Li
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777570535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pjb+I1Dv/Yb97UafdwgPJ8UuzAl6/+2m4AtXJtvaDAk=;
 b=bqAa0jfWHmyH4Vjua3TFnWKvCZ9u1cNmo7Dvip29/h7tOYcIG6Zlt4noFE8QaQczn6LCYM
 qMmQIq7Z/8HwOyvIe/SnOz0TjzWb0Y5Krc/04YPBonX6pla2Mqn4jjEVPJX5VrQqpKofHK
 PDg/+YEzwQOdZ2zVdLRx/IYcchihzhU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-0gi0h3b3MBSuOJGZuBOjNg-1; Thu,
 30 Apr 2026 13:35:32 -0400
X-MC-Unique: 0gi0h3b3MBSuOJGZuBOjNg-1
X-Mimecast-MFC-AGG-ID: 0gi0h3b3MBSuOJGZuBOjNg_1777570531
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA7B1800364; Thu, 30 Apr 2026 17:35:30 +0000 (UTC)
Received: from localhost (unknown [10.2.17.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6366419560A6; Thu, 30 Apr 2026 17:35:30 +0000 (UTC)
Date: Thu, 30 Apr 2026 13:35:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] Qtest patches for 2026-04-29
Message-ID: <20260430173528.GA31701@fedora>
References: <20260429143235.25115-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ajiQBTMTyy2qV7LM"
Content-Disposition: inline
In-Reply-To: <20260429143235.25115-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--ajiQBTMTyy2qV7LM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ajiQBTMTyy2qV7LM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnzkuAACgkQnKSrs4Gr
c8iDSwf9GJJNbQzYlBf3M9i4laRx1dgq2eZGDTBWxoDB7Zj0xJCjhNo5AH9JkBsc
fBg5w3dHHpgScjJCpPzrejTnlQvr3+VP8ramDBXuj5G0+M5N00xrBld8gLXQHmRr
WetwvlewNzsZxLXIbaSIF14ZkIw3VxB2XRLpgRjIaONF2PmAXbtVaZIKWlu6DNsV
upRTqRkcSp+QquCsaHu2Ve+bxy0kXtOoqwH9e7z4Nkup8rKtyhQSonSTOORy9lTw
l1hGieAIJOgbdFM7wD6IJjVEzJKZ7o/AHnVsfrkGJAQAFCqDkcMckF57mYMCohlX
cErTKg27SUr4iVKXvWUAjqjy+jEqJw==
=UGU/
-----END PGP SIGNATURE-----

--ajiQBTMTyy2qV7LM--


