Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C187EC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7YO-0005LR-Gd; Tue, 24 Jun 2025 13:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU7YM-0005L3-3X
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU7YK-0000SG-0N
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750786521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPt/XLgaGzIT1Um5Oswp866uuLxKSAhqrKfx5Rcn9nY=;
 b=iYz2hJiEn7I6KNIVclkI4oju2x9ZU8GjRLxS0MshHIUSgx3l8gczQ16xf8TfT3uP6QSZmA
 kKcUyRZaXEv5gDb4D7Gk3FmswDTID4IyeLr47Cd6JyQX77maMtXA0CTQEX7gBVeAeZYYB4
 ak56mT03MTJZTOoNXVnmDih2/jwJh0w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-iZlI0RvRNTG2jaaDYSG0sA-1; Tue,
 24 Jun 2025 13:35:19 -0400
X-MC-Unique: iZlI0RvRNTG2jaaDYSG0sA-1
X-Mimecast-MFC-AGG-ID: iZlI0RvRNTG2jaaDYSG0sA_1750786518
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E39419560B3; Tue, 24 Jun 2025 17:35:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5DCC19560A3; Tue, 24 Jun 2025 17:35:17 +0000 (UTC)
Date: Tue, 24 Jun 2025 13:32:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/11] tcg patch queue
Message-ID: <20250624173233.GA16158@fedora>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XrlAo/pKUW6omAcr"
Content-Disposition: inline
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--XrlAo/pKUW6omAcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--XrlAo/pKUW6omAcr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmha4TEACgkQnKSrs4Gr
c8i6xwgArT5f0KNVUFTpdks6Gt/oVGjAMjUJKX5SKYhJAc7kQ9s6ma+djQpmxMeP
wnGVKqiUkBl4UvsJcSi/LHWtrwlourQ5IiZHgIIAMVfXexTIDCK+IFKvFrJkLMjM
HEjFnDcMG9ySpQqWFW5wNVDBzTTyyE8CUP3zjxLxP2VTTbW2dTdnunb6uxNzegHh
y5rc9Xf6zf6py3m4BV0isFiYOlePhBmJw5+SgaPaoNCNNHeQ/9766+jQGfyMslgi
l+0KwGZWxZISMR/AaugVGT15Pdq6fPY1Hb4V/YK7c0EqtO+7w4BPHZ3jMCQITy4Q
eJLV59JBCQHc+76kEKl+lykb7WdRwA==
=zWhi
-----END PGP SIGNATURE-----

--XrlAo/pKUW6omAcr--


