Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED213C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwRz-0008Jy-J3; Mon, 17 Feb 2025 03:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRx-0008He-Ts
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRw-0001zu-54
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739780755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iZP2Nx43GogpFVNnqeoIME47z0QGGUYsvhsmFNNam54=;
 b=EjA2VnBcgLFntXfPc78zJJHug8OmzoeDmmnVmrz9AajlesFQiIZXiBTtNHjkM8AwfGS5Zd
 XEFuz/WHwenJ9keiga29WUxGRu9fvlwowC4VFxOUq/SHreML/Vbz7taJ5pKyoDeqrRnzWT
 jV76wTvJPSHIEztrFVxetXXv4cO7FZs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-V7LtN6fGNrKWgd-3WRKQRg-1; Mon,
 17 Feb 2025 03:25:53 -0500
X-MC-Unique: V7LtN6fGNrKWgd-3WRKQRg-1
X-Mimecast-MFC-AGG-ID: V7LtN6fGNrKWgd-3WRKQRg_1739780753
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 304A91800877; Mon, 17 Feb 2025 08:25:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 114D219560A3; Mon, 17 Feb 2025 08:25:50 +0000 (UTC)
Date: Mon, 17 Feb 2025 16:25:37 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/22] Migration patches for 2025-02-14
Message-ID: <20250217082537.GA788088@fedora>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OiflXD7vjYFbhf6Q"
Content-Disposition: inline
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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


--OiflXD7vjYFbhf6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--OiflXD7vjYFbhf6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmey8oEACgkQnKSrs4Gr
c8h2KwgAiyDZaM8LptWvMHhykmB4DQKzTqnOxgW/nVWX2yihsGPnF9XRO39r9IPw
2GEHqJ7Vwo1IRL0lrv8gLCxo3dixFUygEeJAgdyGirxE83leq0xMqlJOfhZCFhYm
BvM/HNTQ42RPGM+7mRFXUXLGmOg5zmfqCrxD8no5pBEBaqVxJW1tWKjnYbkmOvPy
c44bVk636+lUgWHIYCvGuxNJRh91AVaQMBUD+gH+DF4RbTeXVlYh+DxQC2FEdtFN
2G5wbjd5gsDntq0X8+s14TM8jHa3CK7AgExAOn/yHiU2qxWru136JrGRT8rYLvNU
fQm6oE7V+z4wnvCbS76qy8BOFQSapw==
=PyHj
-----END PGP SIGNATURE-----

--OiflXD7vjYFbhf6Q--


