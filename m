Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C426C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trUGc-00026s-3r; Sun, 09 Mar 2025 23:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGX-00022V-OP
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGO-000460-2c
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741579030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/X7aKZ1vhiQKtR+axhfeJ36V3d1UhCIbrF+MUo/lpg=;
 b=H4XZ/L033VdarcV0IaiCypMrGsl2rbxkV6JqId0SJJIPPgHjnBiP01YgN1a52Y3tJlT5zl
 P75BXxMFN73RzhejazUcrS1JMtpl57RP3xYEqM5URBIreZ2HJuDIX26daFDldv0Gb1GK7t
 cKyO8CU29h96O7d12206elo3qC0eya8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-pcEGVKVDNDOOQAGdWwtURA-1; Sun,
 09 Mar 2025 23:57:06 -0400
X-MC-Unique: pcEGVKVDNDOOQAGdWwtURA-1
X-Mimecast-MFC-AGG-ID: pcEGVKVDNDOOQAGdWwtURA_1741579025
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 886B2180049D; Mon, 10 Mar 2025 03:57:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FC991956048; Mon, 10 Mar 2025 03:57:03 +0000 (UTC)
Date: Sun, 9 Mar 2025 18:25:20 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/23] tcg patch queue
Message-ID: <20250309102520.GA59277@fedora>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FuAxWqAu4Gxl36EV"
Content-Disposition: inline
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--FuAxWqAu4Gxl36EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--FuAxWqAu4Gxl36EV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfNbI8ACgkQnKSrs4Gr
c8j/vQf+LYU05gZmdhtgtK1Kl7FV5kA5jBDq+by7EtKeBJGTQ1P81M/RCW68C2/V
A7H2N04MiAhrTidAmGEtDUpGSzv+ZUVpy23pS7Tdfre0IbOkCdiCNczlk46AuqNb
mdKC3piZEVL8ednLbDdiMtWYoHygfRB/QkIExSEgljAdGw0+/2XTb9jwey56kAvk
TKmv+TA9G5/oCMpIZL66KlCRyU+7Ofrt4FjcCaS9EWu/zLurhg6jibqf8ZeCe0lL
V3aTv6MCY6issbeIYNuIpkPfIjalHqdNr8xYEhhJ3/pdUsCjGgMTCbHo35IvLzfr
ZywagNwhCrJ8ARhkUDAYXbsadZng2A==
=rc61
-----END PGP SIGNATURE-----

--FuAxWqAu4Gxl36EV--


