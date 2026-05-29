Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FB7CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3CP-0003Fr-LR; Fri, 29 May 2026 15:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3CN-0003Fi-Bm
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3CM-0003zf-1V
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780084129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wN0+bHTwHr3kSFvMhpLlbwO4fA0ZMGMWuwxtAgKc2rw=;
 b=VVNe+y/yvAKrzLd5exBD0IZwz0z/wwNTZFqJJi3fCeVb/zStgoenrtqdZijvEwjjyP05KW
 yIQe1e4fsp8Cu27hEZkLg7Kj26eZHMzwryvXQDOLC8chKZR6l4YthiRlmNZfRSf8EXxU3l
 x+d+JgoG379FNg/rkpeW3fGiqvhUWfk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-1wvsL4sCNKmNzyl9o_BVGg-1; Fri,
 29 May 2026 15:48:47 -0400
X-MC-Unique: 1wvsL4sCNKmNzyl9o_BVGg-1
X-Mimecast-MFC-AGG-ID: 1wvsL4sCNKmNzyl9o_BVGg_1780084127
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09D77195609E
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 19:48:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C40C176F; Fri, 29 May 2026 19:48:44 +0000 (UTC)
Date: Fri, 29 May 2026 15:48:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 00/15] Net patches
Message-ID: <20260529194843.GA200075@fedora>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ES72+E43GqhXQKkZ"
Content-Disposition: inline
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ES72+E43GqhXQKkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ES72+E43GqhXQKkZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoZ7ZsACgkQnKSrs4Gr
c8juSggAqDqXhxwbsk+ymbuV/M/N853TtezqUFbHXGrbjXE/lgmESfearFPtTeXJ
Z/35vtMKDBI7QpFFeMhHDciCdyyOQOgXJR5+W0q6v651rSA1X7ydDYALfZ3GJF2f
i+++vCYvgcINPx6tCgE8hDOjkDZ3+sxrqsHifMm6eNyviCfVwpqRU3+pzIzJnS4n
7LhMj5j1DoypHDuHamo2IdfEkYUFe2+msdcDXCKB8qptZt8cBQgoArq/TmZgvZbG
yze/8OgaJBJ9It1LO9oNWDKllHdBMXuNBTsUJfB6oraLZ9fBBXUiETHLm6mtYTuj
ou2ag5kKcrUxFsxsSgDllmzx3ZVyKg==
=gmJX
-----END PGP SIGNATURE-----

--ES72+E43GqhXQKkZ--


