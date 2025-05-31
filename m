Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD3EC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 11:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM3jB-0000yU-42; Mon, 02 Jun 2025 07:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j5-0000xX-Mm
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j3-00019M-22
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748865187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SdFDsaIQ9YssqdLjEJDOFDylFU6t47C0WDelPzO94nU=;
 b=Jd8bLwwidSwXBTI+lYOKYXUJTrTHHJPyH9ZExNBk6gVYltcfozVj9+RkuyUlj0+XH4nPQu
 jAPOsJrx0BXGpGNUvaZXob5ljBuhL/vZ9zK7iqD7QI8xoF7GKK5p2etf+mAAB07fr7QF9l
 t2PZuaUeAlzMYCjQfT7OoVHpoND1qgk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-P8jN7LGWMK-O8gBLkartVg-1; Mon,
 02 Jun 2025 07:53:05 -0400
X-MC-Unique: P8jN7LGWMK-O8gBLkartVg-1
X-Mimecast-MFC-AGG-ID: P8jN7LGWMK-O8gBLkartVg_1748865185
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D087F19560A3
 for <qemu-devel@nongnu.org>; Mon,  2 Jun 2025 11:53:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00E8519560A3; Mon,  2 Jun 2025 11:53:03 +0000 (UTC)
Date: Sat, 31 May 2025 19:05:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/77] i386, build system changes for 2025-05-30
Message-ID: <20250531230552.GA268159@fedora>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NCage1y0IT75lbCo"
Content-Disposition: inline
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.015, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--NCage1y0IT75lbCo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--NCage1y0IT75lbCo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg7i08ACgkQnKSrs4Gr
c8iJ0gf/d7SH3up3dfQHbnLfX6oAgR6G2qcWy9eBDuqj2oNz+125e+e6NYtn0//F
CeZtW5KSRMKKYwIC1JZ8tC4SdkWkNSsPyUIqjCYKeGN+ddLJpyT6sjLsdUervApD
lmviAZI6te2yhgymLjkV6uvHmLt0aNOVeRckTRXqTokT94o0Th4C7FD0cq/kVpe9
WCFeJOe8u0aI/OsGxniLpdP/6R1Eo0tMhc34jf5gJ/bgd9Fb01ggUpUrGvhi58sd
w+vx1lM27E2ixGl29WEVXqSzckTE/nO772ltVpLsk0ne3gmlF9NrXT7uibQTYjzh
IyafhVPzdmhZSsj0AuF3HoYLHI82vQ==
=wMnV
-----END PGP SIGNATURE-----

--NCage1y0IT75lbCo--


