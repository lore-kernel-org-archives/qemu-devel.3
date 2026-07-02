Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70187C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfEj2-0003s2-UT; Thu, 02 Jul 2026 06:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfEiP-0003bb-1u
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfEiM-0002XJ-8e
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782988333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hB9nsqAEn80gdXn+6lmOm89+Lusy25PDMUFZHPU+SkM=;
 b=QmdAk5FW5V914VNtvOvYaqIJvTbZswD8Cv7m7vcIGudt6dVrrJXcW9KmUHOUmzK5lY9RMC
 wnyQwym7kgP3/3q3FqjW+UTzlKiBgMwdpa4gdHF6+ur9aT5tjLNj6Dud/KrBxwUqxZpjej
 Nux8SiW/Pt755tWzqnB59Wsp2Fek5so=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-41N2lermMzSy4JEXuzFYRw-1; Thu,
 02 Jul 2026 06:32:10 -0400
X-MC-Unique: 41N2lermMzSy4JEXuzFYRw-1
X-Mimecast-MFC-AGG-ID: 41N2lermMzSy4JEXuzFYRw_1782988329
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37AB51944CF6; Thu,  2 Jul 2026 10:32:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82CA8180058D; Thu,  2 Jul 2026 10:32:08 +0000 (UTC)
Date: Thu, 2 Jul 2026 12:32:07 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/39] riscv-to-apply queue
Message-ID: <20260702103207.GA434767@fedora>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+mEBH8kugQ1Nzed9"
Content-Disposition: inline
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--+mEBH8kugQ1Nzed9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--+mEBH8kugQ1Nzed9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpGPicACgkQnKSrs4Gr
c8iRjAf+PXyfhUBjYiVqakVLNvRL35fmaLSwiRLp4C2z+Xq/9shZnhzgAahzilqx
lUnfmAsH2wxzuo4Fyq0JNzpY4iZ+kSXbvF1NvSkPWtgpPQ16//7VX3ZyelaD9Iit
UO4uzEAyUz2/C8ley9Wjt6HFrxDFBxFeRgerwb3fkMGFULym5sD3W5c8405Q4xcR
Nnl3Gw7w55imbThlYdK+ovZ95D1z8OqotTNcntWskyrvasiYQc/hBjsw3DGYhZlv
rjW3SLooB+UK1e2Oc7WuKzTJL3dMkdQl7RExIzcWKq11XciU9zQYqZT5lzE1CGeq
1HkODSWV9+0qYTdw7UgtSVMQiyvRpw==
=xQ2S
-----END PGP SIGNATURE-----

--+mEBH8kugQ1Nzed9--


