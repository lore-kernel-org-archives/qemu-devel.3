Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A8C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTP2-000830-QF; Fri, 08 Aug 2025 16:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ukTP1-00082N-65
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ukTOz-0006SP-DP
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754683759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzXxYE55E28JTUWcfz0tPPCZru58WzltobAfxnVtDhU=;
 b=gvxayRJoYNSB40WR5ymdEwKYZ0VdxHNGWz/Yiu0fqCxUfHsUW1AoJs7pdyjZOmSIElt2Xy
 mvdoBjDr6dxhLSbLGtZEWHsJWKc9ch3irxMljVYGxvV5q/7e7yDWvQk7pvWM98XzoYbygO
 DdIH4z0KzN5Jx+1yFlo17cfW2hae0B0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-iVtN6zPgP1GmBcxz0ipVAQ-1; Fri,
 08 Aug 2025 16:09:16 -0400
X-MC-Unique: iVtN6zPgP1GmBcxz0ipVAQ-1
X-Mimecast-MFC-AGG-ID: iVtN6zPgP1GmBcxz0ipVAQ_1754683755
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D87DA1800352; Fri,  8 Aug 2025 20:09:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1972719560AD; Fri,  8 Aug 2025 20:09:10 +0000 (UTC)
Date: Fri, 8 Aug 2025 16:06:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL for-10.1 0/2] Trivial patches for 2025-08-07 v2
Message-ID: <20250808200620.GA164830@fedora>
References: <20250807204942.490526-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nRPxBGx+kv3MRv00"
Content-Disposition: inline
In-Reply-To: <20250807204942.490526-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--nRPxBGx+kv3MRv00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--nRPxBGx+kv3MRv00
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiWWLwACgkQnKSrs4Gr
c8gaiQgAgQbeA10Rpwc/5ndJ2fym3B7aJjxPRX0QUSs7KAEU8/S0xoJqZ57unc9E
THfVXNoNaEZfLjob8pmMb4dyEuWFBN8n5+fTvnC1N0gVy/9HzbnazRkU/FMo59wu
+U7XzfVFbM1Q9VpGAmdyYY7Pp/kbdqjCO5YPjGNSrA04SJIZGbyWHXRJJfuq7EEV
BFYl5+C4sky8qkL1dCts6C+Fic8ADQUMP+AUhiD4NtofUV8rT1tLkWUh894+nyS6
cdKqTdWH25YZjUhYlykvvucjm66Pyo5yPUoVf/FN7/AJicx105GDCUKDc1P/PUwX
w1TxuOpU4Rcho/1UajuXRhwh2HGGog==
=G6fd
-----END PGP SIGNATURE-----

--nRPxBGx+kv3MRv00--


