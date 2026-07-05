Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F24C44503
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 17:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgR6A-0007Lg-1t; Sun, 05 Jul 2026 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgR67-0007L0-43
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 13:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgR63-0004Hf-5f
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 13:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783274258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBFR/S91vFMGR9GnGeP0UjbS4fOEKvEebXcBCigugmg=;
 b=LgzzwEbyt6zvb81W+W5UMeDnscunC232zsn5P/tbEbNi+C/N8Mawz9z8SXZecSODqN5lVv
 O72g7rNlD8WepbnvS/vKJ8FmWJp9k4dlj5cNYC39vCN7C/+mVzugwWI9VfP9M3Wkg1SIEQ
 C41pMN2LFkpO4TckObItwxNBgKBEzjg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-3AdE996aNqmd3E69B_JPeA-1; Sun,
 05 Jul 2026 13:57:35 -0400
X-MC-Unique: 3AdE996aNqmd3E69B_JPeA-1
X-Mimecast-MFC-AGG-ID: 3AdE996aNqmd3E69B_JPeA_1783274254
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88C18195607A; Sun,  5 Jul 2026 17:57:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6826E1686; Sun,  5 Jul 2026 17:57:32 +0000 (UTC)
Date: Sun, 5 Jul 2026 19:57:31 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 0/3] Firmware 20260704 patches
Message-ID: <20260705175731.GA505611@fedora>
References: <20260704045316.1624628-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HuvZ9riOsKD6NXFm"
Content-Disposition: inline
In-Reply-To: <20260704045316.1624628-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--HuvZ9riOsKD6NXFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--HuvZ9riOsKD6NXFm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpKmwsACgkQnKSrs4Gr
c8j6DAgAry4fujKq3nCSapzjBIaOR8RiGiWEP5S5RlnMx0lmi35FhSsvu18fcaU9
l3yWp2RKgxahyn1CzPTbkD4v1WjoK6ZRIEqxh+im3tuvpsS/S93mG74lZw9Ozigk
3vCvD1J/0vc40GEeKyZR3EVbzFNUaBIn8wFwZMwFMfhqleoeEmo80c1F+2/AVXMu
TmXPjVGu0c4cXAkgosD/FizE2oy76tem+Bp/e0zyM4ElGb/hIKZuc7PAbgt+F4zm
+XIQjwonvyrg5tsex2Ty4F1zwqcJ6xtgnGqJfYaA4Zy1iS/9c4y/z3AwsFFmeMRw
7Hqn0bTRPF4k26C5dEKgE66oj4sRIg==
=7H2/
-----END PGP SIGNATURE-----

--HuvZ9riOsKD6NXFm--


