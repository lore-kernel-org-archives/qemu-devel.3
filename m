Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DD8C282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 02:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trp6k-0000Qb-Sj; Mon, 10 Mar 2025 22:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trp6j-0000QT-C2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trp6h-0005H4-Nx
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741659149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2v+RPrRoBq2FCxoPn39U1ImfL5Gj8FggAMbWyY/syQ=;
 b=OOhFVERhPuUJzrlFj2BM+C/OIkvt860irNKY1A/Mz6hAcVDFKMI41Syk88ab+drJNQEXSS
 Fu6ntCFJ27C09/lUl3W74qWo9I0di6MT4OmZRLywKBqpKqmDl/j9NXiedx1Z+C0BUR+9Ry
 ZR3J3Lk5+ep5E/J3fh4ymu0gtAnXrxo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-IZtiqmWpNgWDoqW39-Rs1Q-1; Mon,
 10 Mar 2025 22:12:25 -0400
X-MC-Unique: IZtiqmWpNgWDoqW39-Rs1Q-1
X-Mimecast-MFC-AGG-ID: IZtiqmWpNgWDoqW39-Rs1Q_1741659144
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B92E19560B4; Tue, 11 Mar 2025 02:12:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 234471956094; Tue, 11 Mar 2025 02:12:21 +0000 (UTC)
Date: Tue, 11 Mar 2025 10:12:19 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 alex.bennee@linaro.org, richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: Re: [PATCH] trace/control-target: cleanup headers and make
 compilation unit common
Message-ID: <20250311021219.GA487512@fedora>
References: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mBJcZu6MzrITOHAc"
Content-Disposition: inline
In-Reply-To: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--mBJcZu6MzrITOHAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2025 at 09:07:16PM -0800, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  trace/control-target.c | 2 --
>  trace/meson.build      | 4 +---
>  2 files changed, 1 insertion(+), 5 deletions(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--mBJcZu6MzrITOHAc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfPnAMACgkQnKSrs4Gr
c8hgkgf+Ky+CwP9kuLF+ISUIsrAjptUNmfhcrLF2RtchRjYIHvBOUf4ELtRdnLIY
karWMu+e5meLBsxdqPibsCMyDx5xyVH0Wa+qIFq2V/2lVD10pWwofLun3itBmTMV
qTi/hWsZ7DmrPYjIIAoUVrElUWRn4QdzPoPxfweb45f7vs8OsPz9Lvbv90pysII3
dAnYK7PzQGGcgApyQkWivNx4Y7mPc5qsrW/bfwDkm4OILjLNtE43FQn6OLXuCK/S
hV4wvLxDPYeAv5bAaCO9aY00HHm3+ZHYTC6SCx+kY7ywA6iFHi+CbFSmhoa62Gtj
atEtU5K8OVeSr8ny7y2XeqVfJ3D7Fw==
=lZFn
-----END PGP SIGNATURE-----

--mBJcZu6MzrITOHAc--


