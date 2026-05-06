Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F32CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgqu-0005o0-Od; Wed, 06 May 2026 14:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgqa-0005jR-K4
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgqW-0006dX-QA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778091582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJTWDH+RMDBRw6z32nWM5I1eeBUaU/qi5bJ1+ClXTms=;
 b=SpHyMHdqNoz+ROeiNtqaAhbxkT6XQ6U0p6o88ICVrN2cgSiz/RYu54HQyUUKgaTS0Pq0O0
 OzJs66IACLnfZbNjCxTZ11zrzgr+gZVfGpQr4SrAOuHbw41WtIpmg+0tA3K/dMWAB3JjDx
 coOPWF8pPlyq23f6n1nqImd4rh4xx+c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-GeJ85Je9NT-E0NaopyakuQ-1; Wed,
 06 May 2026 14:19:40 -0400
X-MC-Unique: GeJ85Je9NT-E0NaopyakuQ-1
X-Mimecast-MFC-AGG-ID: GeJ85Je9NT-E0NaopyakuQ_1778091579
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C94318005B9; Wed,  6 May 2026 18:19:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A8D219560A2; Wed,  6 May 2026 18:19:38 +0000 (UTC)
Date: Wed, 6 May 2026 14:19:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 stefanha@redhat.com, Stafford Horne <shorne@gmail.com>
Subject: Re: [PULL 0/2] OpenRISC board maintainer updates for 2026-05-05
Message-ID: <20260506181937.GA208805@fedora>
References: <20260505172926.2235826-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EfLLO0Px+pxi0o+s"
Content-Disposition: inline
In-Reply-To: <20260505172926.2235826-1-shorne@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--EfLLO0Px+pxi0o+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--EfLLO0Px+pxi0o+s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7hjkACgkQnKSrs4Gr
c8iL5wf/QuhYyfjZuZ+W9Urwjzhi8CGOFT2cdT5XT+bIIDHpL965S9rCPutQ1h16
9Rhg1hVRSMlErg0hbS2SsMuJ3BkKjO1tPEFWLZ7BBzQgL9VzvHU3VJ/ozcsAGT2b
Aax/EJ6N/6rKGUWAtnpQ9LNXx92+ZwHzC9kqZIZQmZsPrxdXDtY4omHCavzRlTr3
silaI9dg9aC3QyiZRwjSbSrZVjfUZXKDA4ngWMUCR9S13tgbWntCFsKEKhOaPM5N
eysiouNV61IY3K3SSs9rd2zZY+84KIICIkwNm9dO7Nl96IMgjkb+aEQT36BBK8oj
OLBygV40yOrbY5mLkfUBJpu71fTN5g==
=2nR0
-----END PGP SIGNATURE-----

--EfLLO0Px+pxi0o+s--


