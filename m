Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229CDC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxzV-0007rO-EP; Tue, 07 Jul 2026 01:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxzQ-0007fp-MQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgxzP-0004ON-7D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783400698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gdgnTotNRTRfyM/qZYGC/Dn5KUgoLo/zc6+Vc90w1do=;
 b=SyOUviSQ8U6HaLB4pag2Sec1W9Jtx1BO5MF0WX7R7u7vZhpz8rrPXUm1BQuMoPhRXwUwbN
 /x9iu6jNzTOEN2ZPmDYtFHSO56CFxdmaIV7Xq5I94hI83XexGVpyTR4S9im1onwZoNSMDE
 9a48Zkqo5yyWCYUKn+2bkp6fEMiAbVs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-rRvjhnsjNAmJwu-3XLsCVA-1; Tue,
 07 Jul 2026 01:04:53 -0400
X-MC-Unique: rRvjhnsjNAmJwu-3XLsCVA-1
X-Mimecast-MFC-AGG-ID: rRvjhnsjNAmJwu-3XLsCVA_1783400692
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 810D71801310; Tue,  7 Jul 2026 05:04:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDC583691C; Tue,  7 Jul 2026 05:04:51 +0000 (UTC)
Date: Tue, 7 Jul 2026 07:04:50 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/32] Accelerator patches for 2026-07-06
Message-ID: <20260707050450.GA524667@fedora>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b7iUZ+TWBRlstfXB"
Content-Disposition: inline
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--b7iUZ+TWBRlstfXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--b7iUZ+TWBRlstfXB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpMiPIACgkQnKSrs4Gr
c8gemAf9GhI6XYpqbnSGhvDHhWL5/Cm9+ZFplkPVI+P0SPYKJlsinp0p2JDKa4r2
c+aZcPlQWevVtgMHElbwRVvBsNHuLGdlonLDaE5Irc0w7WPo8QiQnEVlkGrKqsfE
s0oZMxSvHq36ZZ7djp/BBPZBXaMUwxxcp2Ail6mkgJ5vw+GBA8/Q1k0XASB32NX+
Ue3fZCOL/4ZJAMcWjpKgbgCDqpjIyS4ZQvt0KRH6bc/Cb5oXSBA1fUZfjMIMJ66l
9dWT4PNmrRDQfCS0Xf9bNsR9UfzXy/8wUkKXZTKvKH8Jjr4rakqid0fKmw/xPUQu
ocmdpXOwKvIZCb5Z/nf64ZC7n7mw3A==
=tlYm
-----END PGP SIGNATURE-----

--b7iUZ+TWBRlstfXB--


