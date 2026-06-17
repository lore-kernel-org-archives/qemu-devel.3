Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F79CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvwR-0000q6-Lq; Wed, 17 Jun 2026 15:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvwP-0000pl-07
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvwL-0002IC-1N
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781724522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXxWYnpftjGlu/EfOpDFzJwyeI+ox4tzzzhn4adT2mI=;
 b=OJSsZdWi1ey0R7GHhtcWICx/z3NGQ9N3tmeoJSuzK1lZExVmPBYbMo1qTQ1q50i2JAd+Lf
 Cp67q4MTzy8EGxMb7JgLSfBasFeGGIvf1GoEibjHiB9rMiEnCZnvPsg7RPn7VVJojHkyXQ
 805zs5DXqVTjFlRKUwDv2FPWtCTaDhc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-Dpfdw0C7OueB8fULAR6cVw-1; Wed,
 17 Jun 2026 15:28:41 -0400
X-MC-Unique: Dpfdw0C7OueB8fULAR6cVw-1
X-Mimecast-MFC-AGG-ID: Dpfdw0C7OueB8fULAR6cVw_1781724520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E3781954B2A
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:28:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2DAB19560A2; Wed, 17 Jun 2026 19:28:39 +0000 (UTC)
Date: Wed, 17 Jun 2026 15:28:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/14] QAPI patches for 2026-06-16
Message-ID: <20260617192838.GA694041@fedora>
References: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GD8gPJ4tEulmP6EI"
Content-Disposition: inline
In-Reply-To: <20260616141715.2974467-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--GD8gPJ4tEulmP6EI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--GD8gPJ4tEulmP6EI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoy9WYACgkQnKSrs4Gr
c8gHMgf/d4xF8a3HE4WoX4DeA+1D0qzl/IwBprUhtCVlCvee6uXUwzLbzLqcX/xV
P/YNU8Fc7XtLspYDcOSdJb7GMis35VHj7RMIPdoa48OKCHuU/yTr2f8NoCtee7tv
JcrG8dst59PxQqiojh4evdDSEfiH0kmGKwgRxEPAFAsGgmG4HQRNwju8xQddBOXk
aY6aB7hH0qzxOj3N84E44cv2+wnRyYOGUcrOmrV8b2SoZs35sT2D52nWoWdzvQrn
j1fN7srnDDHiiZuwb1L4DbKS6AXIUnkWbXQ05ebLd/NxagGQm1DLIW7+nRJ4BAs3
c2ftW7CuOldJu/OQ8B4Wj/IaL5fipQ==
=mcNo
-----END PGP SIGNATURE-----

--GD8gPJ4tEulmP6EI--


