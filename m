Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266C2C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 02:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thg9x-0008IV-2l; Mon, 10 Feb 2025 21:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thg9v-0008I3-8n
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thg9s-0000Jd-E8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 21:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739241475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLs78yXCkzUUr+3ENs7Bh9woV8u9/4fBKeLBIQwmVEA=;
 b=V+b59YSRzs8nNFp9qXa/X3Vez014Cwgs9135Ddww6zbHR7s4bN5eYesKRVfxBk3qbSf5qv
 EghUvUSM1pNc1NsVmJ1yE0vPDz1piRpDGsmqhzlvkq6rM2URyx5YAD9YdWuOhsQ/mTr1TR
 K8DvKAlywwIPh26RQsCAQMZKaESVeg0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-TZkrqN5PPCOOigitSztY-Q-1; Mon,
 10 Feb 2025 21:37:51 -0500
X-MC-Unique: TZkrqN5PPCOOigitSztY-Q-1
X-Mimecast-MFC-AGG-ID: TZkrqN5PPCOOigitSztY-Q
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE36F180087B; Tue, 11 Feb 2025 02:37:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40EBD18004A7; Tue, 11 Feb 2025 02:37:50 +0000 (UTC)
Date: Mon, 10 Feb 2025 21:37:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/12] target-arm queue
Message-ID: <20250211023749.GA149889@fedora>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MQLwmwHbDErs1ybt"
Content-Disposition: inline
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--MQLwmwHbDErs1ybt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--MQLwmwHbDErs1ybt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeqt/wACgkQnKSrs4Gr
c8gEJwf/e1WXJAbDk89Ni7ATlWsQmbeLjkbAe+uB8Pg2KkuKZMh5+EwkhQ5j4hef
VSRbD5fbxZYt2pCs/s1fhLtiFso4+EIsMnGs3JeG9gOyJV7BlgzlA6KSzXBkn0ki
zcXTrfswSRKM7HznCX0i1zoZ8F7uGFxdIAoqAbiDl/f4VCfL+TV2/6AqurXs1C9U
8ri42hUcdu0AKdvOkv7xyuO0yzpnzFEP3Pn+FiTHU5uYwhVj/+csHmOSvrdssObN
D13CHIZC4dofEI2HVoCT0D/HfNQl1lr0ndakpFWPqXZGPv6bVycH5hr3xTRK+jcW
Mffk3zf6bEkIfyHzpLHwJd4P5s96Wg==
=bcPh
-----END PGP SIGNATURE-----

--MQLwmwHbDErs1ybt--


