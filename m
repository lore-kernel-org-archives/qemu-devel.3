Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E7C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqS8L-0003Jp-9U; Fri, 07 Mar 2025 02:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7y-0002z9-UP
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7v-0002J5-Sv
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741332490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xrj17KlcoIaIZyeQbehGcaSBUOVelMH3N7V1JJbFEgQ=;
 b=eCthdYLvdrQepSwiaoiyiURxP+ruU2N9QKN4bUKDRaCbmDeX5v8BiBdY1D9Z68qyHTRFTI
 izQx4PfETcr9XfeQUd7RrU7l5yAe64kBmOoACfxTcdk6mRayYvY31ivlz63rPZhNUKATbq
 HZKDwEFu1RCJsgUg4qY9tDUdM75OqKU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-1oZZZB-ONWWcYqlP1rqLZA-1; Fri,
 07 Mar 2025 02:28:06 -0500
X-MC-Unique: 1oZZZB-ONWWcYqlP1rqLZA-1
X-Mimecast-MFC-AGG-ID: 1oZZZB-ONWWcYqlP1rqLZA_1741332486
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C5A4195608A; Fri,  7 Mar 2025 07:28:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.2])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FB791955DCE; Fri,  7 Mar 2025 07:28:04 +0000 (UTC)
Date: Fri, 7 Mar 2025 15:18:54 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/54] Accelerators & CPU patches
Message-ID: <20250307071854.GA362102@fedora>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dA8nWJ1MS3xIseoP"
Content-Disposition: inline
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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


--dA8nWJ1MS3xIseoP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--dA8nWJ1MS3xIseoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfKnd0ACgkQnKSrs4Gr
c8hHSAgAtiZcbEJ5IgLUD62lAbrhwkME0u1gHnV74+a1dP27dVYZRLF7THx+PYSS
O+gp0Ex1WkjpmiyAymm+y0vi5FIrOFs2eRzTB06aWK2VU6s+5I/jXR8PfRNAozjl
F8dLA4tM7u11YeHjF7GMJ0OdnZF5oLj1c8SMnPHUHoAgwh8jvLU1AyCum+y272Kc
LbZ4sUulkT3ASJImPJQZ3po6FECOwkXx8Waq814ud/dozOMa70LJJm8SKEkVdWfk
NpuDeMluM41USqM/bRhHNwXRMMcjCAZn/SJqw4wn2dQgKK/HPhkmZce5Bvi+a/wu
lv6yRq0s+v8yjK3P/2pI79S/FO5crA==
=RHWK
-----END PGP SIGNATURE-----

--dA8nWJ1MS3xIseoP--


