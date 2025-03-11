Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F92C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 05:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trrmn-0000ze-UF; Tue, 11 Mar 2025 01:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrme-0000vT-Aa
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrmc-0006OD-Gv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741669440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qGr/FjriQh09HtXe5kJbzhA65doLLuc5KtF8uZla9g=;
 b=IGCEYhxWNLmgmBXMfsvrdU0GU4kbHu6lrA2UUb1/88NModdwsoMd2s+NRZQYclxyEYRuNf
 SjRvey2xjpOEe8Qn8YQyvdP1rgkD/UgbyNLdiAugf1dZ49mDfuZpKJ02CYnTlgQi6BznjB
 uthJv5X1tBwMPfQm5kSP2XqGqFIx7vU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-_j31_atTNQ-ZgriwCz4dqw-1; Tue,
 11 Mar 2025 01:03:58 -0400
X-MC-Unique: _j31_atTNQ-ZgriwCz4dqw-1
X-Mimecast-MFC-AGG-ID: _j31_atTNQ-ZgriwCz4dqw_1741669437
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95B0419560BB
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 05:03:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAF7B19560AD; Tue, 11 Mar 2025 05:03:56 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:03:54 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 0/5] Net patches
Message-ID: <20250311050354.GA602815@fedora>
References: <20250310122240.2908-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XHhIcoIaSiH/SVpD"
Content-Disposition: inline
In-Reply-To: <20250310122240.2908-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--XHhIcoIaSiH/SVpD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--XHhIcoIaSiH/SVpD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfPxDoACgkQnKSrs4Gr
c8jiUQf9E+4UItOEiOwp16R2rwCiv3RZ3nqYJOAPxp/0Y6CftRRDJC15mpNP+TCG
s88gIyG1OziLUwgXkBvQhXzEjTiyyf97nJWnKINsBIQp0+k6XHHVY5vRmNiFxykQ
uTNDQgzTpempbXp52nMFKOCbsYOjXIEgJTaNmxgzufDRVMiMeP0TDdFDqys1Syda
yu7wr6g0PzNmudaghUHUMVdbtYwW4oSakFVFmgJPtqfNyA89VG6uhgKlyszzM+RW
oWeQK3LEszidWpbV2TMJlC7mVfZIqIURYh/wHFx0Zv/1VePFS7SSGQ1ogeUcmI5s
OEFOO0929mJP4uGEvyRh/4oDLPgYpg==
=/9uD
-----END PGP SIGNATURE-----

--XHhIcoIaSiH/SVpD--


