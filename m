Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767BDC83000
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 18:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVDqU-00035G-3R; Fri, 27 Jun 2025 14:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uVDq4-0002zJ-8F
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uVDq1-0006gj-6W
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 14:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751049010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlYYgcgmoJj8Vgb5fguiW/Zm/YxzW9avIc1SSALjhyk=;
 b=bFGs9172Bjk1uuy9AvACDquXk/goX2dkgAmlphMUWZLfdLbDK3b9ZBqtd/smseNahtIU+m
 UVv0eDvM/R87YV58QtL/cdT+woApoiLFB3tzZw/9gpMJThlrG0GFaat6tU1IG69rRihldm
 CHqPn0BFjyunHHSCfE9NBl0ZAcRhPNY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-XAL6ieqMPyemOyVsXC9u8g-1; Fri,
 27 Jun 2025 14:30:07 -0400
X-MC-Unique: XAL6ieqMPyemOyVsXC9u8g-1
X-Mimecast-MFC-AGG-ID: XAL6ieqMPyemOyVsXC9u8g_1751049007
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4ADE1956048
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 18:30:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.103])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DD14195609D; Fri, 27 Jun 2025 18:30:04 +0000 (UTC)
Date: Fri, 27 Jun 2025 14:30:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/19] s390x and misc patches
Message-ID: <20250627183004.GA187424@fedora>
References: <20250626055350.218271-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A8+zQkxX0fwynOaI"
Content-Disposition: inline
In-Reply-To: <20250626055350.218271-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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


--A8+zQkxX0fwynOaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--A8+zQkxX0fwynOaI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhe4ysACgkQnKSrs4Gr
c8j8iQf+PMSZguiEgJGFNmV+KJYNKjfDlvl4BMaRsIgLpCmUvFbUYqgfcVbLR6no
zmseaNPyK2Kx7D4tdmrc00dmoeriPHhn0cWTuJqvcFqoF8Cdyf/mBvbzQ6sT8lyf
Qb0HfUVpr2GrFlNgMPU3TZMExc43j1ylcIyTq8UmHzyD0dLbjznnlKbT9eADc3yl
IjrIPSEBPrmW1fL91UVK/vTB981fRU0lUQs9/nhR/INOeFOmIbvKIU11+EZmhi75
LhXy28IJN07O1/6GvbCU8sHE+++bhHhFeLLhHLSfM6/A1krnD5Xj51jHhrT94iQY
xO2ba8XkIZUpP7gBoWKS+pYofrIYxA==
=qoyf
-----END PGP SIGNATURE-----

--A8+zQkxX0fwynOaI--


