Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B77BCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRWE-0001Hy-NY; Mon, 11 May 2026 10:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRVx-0001Br-Ph
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRVv-0002ZE-IZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778509302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EgqgLlqWEeGyKc/dumUTQ+ZYNxtti/YofunALgv1iBw=;
 b=Xo2lsmdrjVq26yv54vQ6Du89gB8XyF2xchTo9rDVXbHrZfnd/vZd+5sTs2Z0j65knYF3/c
 r1AW5dd8Uw/725acZD93GqxM6qm9hZAcuWHnsA34roTEwnquXbsi4jefg+6Ox6ATsnT03k
 JBa8MOkKsFoqR8OdJmCqO3hTMgnoLmo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-37SEMsuvOQy8y07DpOV26A-1; Mon,
 11 May 2026 10:21:38 -0400
X-MC-Unique: 37SEMsuvOQy8y07DpOV26A-1
X-Mimecast-MFC-AGG-ID: 37SEMsuvOQy8y07DpOV26A_1778509295
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 408581955F3B; Mon, 11 May 2026 14:21:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C68EA180058F; Mon, 11 May 2026 14:21:34 +0000 (UTC)
Date: Mon, 11 May 2026 10:21:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/67] target-arm queue
Message-ID: <20260511142133.GA520528@fedora>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vJjhhD+F8aOlAKGV"
Content-Disposition: inline
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--vJjhhD+F8aOlAKGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--vJjhhD+F8aOlAKGV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoB5e0ACgkQnKSrs4Gr
c8g+iwf+NMTJXqUAYd2cIxIFQFMyzbno9aVe+V4dR9KQAON/69NqXBgfPRVkyn4u
fiE+5CBLIsVCQDTVFl79sppXGz2heh+MIOhlhNi0OQykJPrg9Q9FmpKhUOT0wsTM
na0E05VUqiyDqkmOZsnvSvfLfEBIZSu53+sBpfSsmtxrgL7o8TJGNk/5Wcnrf965
CGefXpYsMzo3Uv7k/aitD6FzKezcilgi+7daGaxuRY5YCHUvPCya0RCUk8fiWTz5
ZE9J2FF3cUmOo4VlPvZlD01LJruJs+mHRzdqFLNlYUGQF+n/e5lrvCVtds1y/kwp
e7WH2mVY8I0CU3DfjtOXay9QB5Fr1g==
=9jef
-----END PGP SIGNATURE-----

--vJjhhD+F8aOlAKGV--


