Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C73C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83yq-0004Gm-Hu; Thu, 24 Apr 2025 17:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u83yf-0004FV-Rn
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u83ye-0002Dl-Ax
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745529563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BSJr6zuaVnM4dlYT8uf31IrmWMFqU6YYQRjeaYyajc=;
 b=I0GaasL3o5xud8iy/QO5CQzcKEVBB0N4ZH00NJhmnKLEc7X3N/wXb5RudHHEkfsJWxZ3la
 rRYSqTd+x4hacWMo4R9tH0muJ/Ai9ljrb7/r5SbpRYlPxgP2pD/D2eIkLJsG+91/R1k1Zr
 pYlS/3j+sU2gd6WYUdKUEZlozhAzqbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-Y1XB58Z8OXaKBO6tiPv4-Q-1; Thu,
 24 Apr 2025 17:19:20 -0400
X-MC-Unique: Y1XB58Z8OXaKBO6tiPv4-Q-1
X-Mimecast-MFC-AGG-ID: Y1XB58Z8OXaKBO6tiPv4-Q_1745529559
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07951800446; Thu, 24 Apr 2025 21:19:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.253])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 503E41956095; Thu, 24 Apr 2025 21:19:17 +0000 (UTC)
Date: Thu, 24 Apr 2025 17:19:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PULL 00/13] loongarch-to-apply queue
Message-ID: <20250424211917.GA457812@fedora>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U8nXb8pzqXt3p6iB"
Content-Disposition: inline
In-Reply-To: <20250424023317.3980755-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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


--U8nXb8pzqXt3p6iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--U8nXb8pzqXt3p6iB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgKqtQACgkQnKSrs4Gr
c8i12Qf/aayPSzyxBvPiAYSvmKkXa0QgcvxeWTboQxX1rN+an86q9Ll+lm72KCwg
4OsuhVFS1ITJ6BptZCNjOzcdpaZ0eSJ4E7JvSNqS2EUfuORsiA9MzoYPpqE/BfBH
QZMA/Vr4RHwp4CenmErLyxAG3tC7TwnxLVhtt1tVF9rfyMkAPt6qsfMYC+t8Q5jG
i/+8hmkqjLOxmRyuDq/JPqNAuXZys9GYkRokTl67mZihP1QRarBXE3Nnim8/XVz2
orcxohRSO6bRCw8GthX9Xi5bVRdhFDMK7mlo0z3/beMMR6RyYpBq0lKlh8h89nzI
/sjdTdEzRHooVQ0cO+mxkp4Cwto4og==
=cVmg
-----END PGP SIGNATURE-----

--U8nXb8pzqXt3p6iB--


