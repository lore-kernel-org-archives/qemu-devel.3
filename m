Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9996CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 19:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8ws-0007PF-D8; Thu, 21 May 2026 15:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ8wo-0007Og-Ta
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ8wn-0004f4-HZ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779391244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1kLRT4K6mchA9D403BCAOuvEMRiSR/EoOF9J0cWfws=;
 b=FIvlSjNhtxXBJER1c/r8Q4Sunz7AMgCW65L22ZOFPXWC6Lo6e296HVXi6nROF7NhHnhIYG
 /c1I6ZLvHketoTU3s3DEBOdBaGgBNSLOG3D6mTUq29f1kVnKDExCDUB7snE7C/ICf0ompK
 qHd7OqNU5Yaa/0Ymro21QI/BmCestuk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-78N5ERiyOLSwIG_NLDvnyQ-1; Thu,
 21 May 2026 15:20:42 -0400
X-MC-Unique: 78N5ERiyOLSwIG_NLDvnyQ-1
X-Mimecast-MFC-AGG-ID: 78N5ERiyOLSwIG_NLDvnyQ_1779391241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B06071956095
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 19:20:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51A961800352; Thu, 21 May 2026 19:20:41 +0000 (UTC)
Date: Thu, 21 May 2026 15:20:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/4] QAPI patches for 2026-05-21
Message-ID: <20260521192040.GA1309208@fedora>
References: <20260521112729.1287282-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1UH1qsjHp2cBfO8y"
Content-Disposition: inline
In-Reply-To: <20260521112729.1287282-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--1UH1qsjHp2cBfO8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--1UH1qsjHp2cBfO8y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoPWwgACgkQnKSrs4Gr
c8hihwf/TCrQHwSanrS4FgnO9N1aOnSkllhLCulbt65IDOOtK8Yf/bz8Ek7Thd+S
X0mydtGxMAZrcOnjUbeb6EMFpHqJ7FYSwHMZE0kgkFzuRt71N8ibCTVma8TSKRVp
IchWNpyP9DHuvyxdGVkIFTnnKAm2HnKPQXio332jrujw/rsnFn6VIbDCmtx1yarf
nj3Qt4xAW6NYP+jNI6kcOjSkzsYCGa+wDNhzNQYvmIyXfS24e8v/s2xZsPcIjMDi
q6M4xIIkzm2FmZvFpCgE3GAzoLeL8EYp6/GhYt0s7KGCI/YLN584WjnIpl03qYwO
AiiPiO0QcY1X8guoC52kVgnF2O4iVg==
=oEXf
-----END PGP SIGNATURE-----

--1UH1qsjHp2cBfO8y--


