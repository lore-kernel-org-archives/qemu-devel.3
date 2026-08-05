Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60F0C55184
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrPul-0002tl-3A; Tue, 04 Aug 2026 20:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPuj-0002td-Ol
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPui-0003gq-Ag
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785891319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejtaG1r6MMNIrUz6Lqa3tl4T6wq4xsjigfsB42bQxD4=;
 b=EmteYVpqWWFgjpEs0snjTlkFt5u4S0Dc1DTfZUvVIC5jtNWkG4MmW+hy1UYSaG/pBxDXj5
 a9Gj2Hwhje4JktzswVf0Npp3NvBjlqaP8gk5tg7RXfNtHuos9rjktFNZctHYLQEB2daf8+
 +/KrrwBDb0zDt3CUiQsMSjpUpTMoiIs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-3fsfAQFvOhaxq9DNZQk_iA-1; Tue,
 04 Aug 2026 20:55:16 -0400
X-MC-Unique: 3fsfAQFvOhaxq9DNZQk_iA-1
X-Mimecast-MFC-AGG-ID: 3fsfAQFvOhaxq9DNZQk_iA_1785891315
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DA641800366; Wed,  5 Aug 2026 00:55:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14C94300019F; Wed,  5 Aug 2026 00:55:13 +0000 (UTC)
Date: Tue, 4 Aug 2026 20:55:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PULL v2 0/7] IDE patches
Message-ID: <20260805005513.GA582272@fedora>
References: <20260804170015.3128363-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gCExrM0zLR/lnmMx"
Content-Disposition: inline
In-Reply-To: <20260804170015.3128363-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--gCExrM0zLR/lnmMx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--gCExrM0zLR/lnmMx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyifEACgkQnKSrs4Gr
c8jhxgf8ChalP94Kb9OJOEOuhLZgi4QoF9Vyk+BcCOxNjnCK7qs/uGQkYLnHpMyF
IX5+re4hcjbReEJBeg5+LsPZQvcA+UB+U4GH9OHMTvFSiQ5IuT7R7/r8qt1N7FD7
Ttrz5OEjlxRMEFxLYWN+IQsfpy/xaEXbAsdtL80k5XalZwlAU3mAsFviQyoJEkbA
WdP9UgoncgBfXkMOopnSloRwi3V5X9rBBXtLy+E7vOHR9gFZZdZ+geOTzq+5dCU/
qIPIpgLAph8oYNyonAp9gIJF23UZI66JtHqePhFkcs4hbbxtPVbZdzN9rnv0eJWQ
9H5jfjP5jw7kuwEg0x60YEYQ/XzoVQ==
=kVqj
-----END PGP SIGNATURE-----

--gCExrM0zLR/lnmMx--


