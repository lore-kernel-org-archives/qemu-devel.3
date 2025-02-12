Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517D2C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiD47-0006Wv-1x; Wed, 12 Feb 2025 08:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiD45-0006WN-6t
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiD42-0002sm-FI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739367964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxbrKVGIhCNaP9XKMjQzlsuimwCBIC2QQbpDRBkecM4=;
 b=cEmgIz2K266WIqEBu5FTAlgoMZMdOcApH8P/jXyIRAzUPIJiy9w6pqaETaD/kOBCN7oFoX
 3zSHbDod16doHNY2hNP4KB4bzuyjyhAqX4CLPXODkXj2JHExPUt+Y+tnJdJEm1+al/7SM7
 5igjW4KfI22Higs+6Pn1WguTAEwes1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-H9F64VsXNzWsk6yvqgb-Gg-1; Wed,
 12 Feb 2025 08:46:02 -0500
X-MC-Unique: H9F64VsXNzWsk6yvqgb-Gg-1
X-Mimecast-MFC-AGG-ID: H9F64VsXNzWsk6yvqgb-Gg_1739367961
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A366C1956050
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:46:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E315418004A7; Wed, 12 Feb 2025 13:46:00 +0000 (UTC)
Date: Wed, 12 Feb 2025 08:45:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/7] Functional tests and Gitlab-CI patches
Message-ID: <20250212134559.GA195827@fedora>
References: <20250211123144.37617-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="75gF11pVuVfhEncI"
Content-Disposition: inline
In-Reply-To: <20250211123144.37617-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--75gF11pVuVfhEncI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--75gF11pVuVfhEncI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmesphcACgkQnKSrs4Gr
c8gYpgf/QnQOpoPbUlgxjBb2V86GTnseX5Y4DFBxz0/X23gLt9H2H4jRHmObUKtH
9xgrGDIJfBR21Kp04WXoX36OFYUAzKlJfPIuf/mFpMjCpBAUGUu92OS5UXoNNycj
DE7qD3iS3Q401wLPaZZFzqbYhLwJ1FgxJO3V+fdtsGZ1J3RaOGhXnPUozSbdYjjk
3ykuKgDbmT/PHvdhiMRpIZFrRIeLf8juPoGhCPWMxVA972Sep9nh5DTXkCRQCjE9
IGBD9fBLzCan9m9Bi8gq2mleisjJy62jrKUklZMYR74Eozn/Ai5etws/iY5BXBiD
xju8o4i6vllI6wEfVMmvXSfl34smIw==
=xIIi
-----END PGP SIGNATURE-----

--75gF11pVuVfhEncI--


