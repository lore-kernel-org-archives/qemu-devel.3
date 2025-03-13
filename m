Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EF7C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscc2-0001MB-60; Thu, 13 Mar 2025 03:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscbz-0001Gb-JZ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscby-0007P5-1x
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9R4nUderFA4XiVxLyzRn1p5PJpmOh+t2TcuFBW+FFNI=;
 b=X3+vxs5BcDcl989FArmPIXYtd1bxJl5kgV3yA6G8YUwzewN3rzVfi+Py/0XqoRYf39ol5k
 /ppEKHgm+7Go6Xb1fXFzyZeiYaAr5Hka4g1Fp0yXeRL8bBCQE2WWbiqiwQV5TZDTtOYe6r
 0Pb3QUp7IQKyTYyPp9ku5MAnVSVzMk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-q5PPGlKZPB-I-UF18t8hBQ-1; Thu,
 13 Mar 2025 03:04:07 -0400
X-MC-Unique: q5PPGlKZPB-I-UF18t8hBQ-1
X-Mimecast-MFC-AGG-ID: q5PPGlKZPB-I-UF18t8hBQ_1741849446
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A2DD1956055; Thu, 13 Mar 2025 07:04:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 995A91828AA4; Thu, 13 Mar 2025 07:04:05 +0000 (UTC)
Date: Thu, 13 Mar 2025 15:04:02 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PULL 0/1] Tracing patches
Message-ID: <20250313070402.GA1086043@fedora>
References: <20250311025331.598234-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R55fAn3brsu20Dzc"
Content-Disposition: inline
In-Reply-To: <20250311025331.598234-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--R55fAn3brsu20Dzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--R55fAn3brsu20Dzc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSg2IACgkQnKSrs4Gr
c8i7OQf9HGQ5OqtGI/DgcRDdnipftdbtxbjIgDUiQJHGsssm5YHqYuPyQkC/JISf
tQmFpFy1nLVW4xFTOXiuXzJnpqAfu5YWkcXMq6rP5/VTyB9TPegedvPX/qkfh207
q+RAlwe+SlSk7pMnlgpZRqXdRsh05xNDO9akZs9cU+L6J2iSNB05Jfg/dm70DB/D
ZW+MPq124CfIDV9PsXH4SxkSrIDGGVUQaHUpP3BH/R2UbxwuJ4IeUFp8s3O+ilQG
WZkQze/lAYEeUFaMlRhZktZCsVo4xTa03O3jOgj7lp7OjzzkIBOY2JkN1p0isJFM
FIZ+JHX5/w+FdxSlKnCbRuys9zPR9g==
=JPaG
-----END PGP SIGNATURE-----

--R55fAn3brsu20Dzc--


