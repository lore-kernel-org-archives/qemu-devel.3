Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDE0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkhD-00009D-4b; Thu, 09 Jul 2026 05:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whkhB-00008y-Oo
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whkh9-0003CJ-A5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783587921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7stSOLUuCJ8Ybsiirpmxd/yPrrTFAFfxT3ctogUDLN0=;
 b=Ih2/n1f8LkZ6drCS0ypNnKX7aKhV1IUkwvE57am00iPh8E/anqxRZ0dclIWnvra1qHzBHr
 MlzqifdzcN5pHRVhc+sSNadUg409fQue6OE2fE73Hs7IsritwPaNxbuk9MORjCui7iBB5V
 vLL5W8nPuqQdn+dnvB26zfiUeY9ZSIA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-he24w0-EPKCT0JTYMJ2Erw-1; Thu,
 09 Jul 2026 05:05:19 -0400
X-MC-Unique: he24w0-EPKCT0JTYMJ2Erw-1
X-Mimecast-MFC-AGG-ID: he24w0-EPKCT0JTYMJ2Erw_1783587918
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39551955F13; Thu,  9 Jul 2026 09:05:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.11])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14BF4195608D; Thu,  9 Jul 2026 09:05:17 +0000 (UTC)
Date: Wed, 8 Jul 2026 17:32:21 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/23] MIPS & SH4 patches for 2026-07-07
Message-ID: <20260708153221.GA572331@fedora>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0+PLLgF3K3qN6HtB"
Content-Disposition: inline
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--0+PLLgF3K3qN6HtB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--0+PLLgF3K3qN6HtB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpObYUACgkQnKSrs4Gr
c8iLywgAycFOEVA+HW2i4qR3AE1bxiEvoslGph4SaMGbtciPP71wXr6rYpYDdw1i
XIEwDpd9jsWFsC7vkCG+MHPfBkWqTxlAADe4pDzHhe1FG3Wxw7ttDgk+JgdsNoNO
rzTkqFuklOvoABGr93VBBJLQJiywEG0V5IdW8Ky2NmAZGIy1Jtl/TfBUCYRfe3kf
0qPTsZY6hMgGJO+Kkrx+fsCgoNuDS+pgaxWuPz0HRUokg4WT17nPBROWmFAE790W
c5hIPzdJWYDaWhdrd3SwNlu/CD1UX8ylA2ubq7JrZx6UfGdSg9SriJTzfugrF821
6oyAVm+Q4Xt8doCr1f9302P4ae6Vxw==
=uwWM
-----END PGP SIGNATURE-----

--0+PLLgF3K3qN6HtB--


