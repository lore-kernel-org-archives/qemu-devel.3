Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B55C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom7V-0005vc-DO; Tue, 28 Jul 2026 14:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wom7T-0005n6-Ot
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wom7Q-0001cc-R2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785261684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i44HHCfHLt5r5ckvKMA4SC3fmEGB/tgSReDT4I7wau0=;
 b=JAHIVXrOS+QC9hMNHCgGbjKorplvH9x+YvYxxd8I3dxUwj1WDONRVKuMuW8gq5VZ0TPmkW
 6xxU9ObD0kLqCrCBYDnlFf9jkAIunyY7bZQvKN3bhZdCD5/TEtSXQR1YKqIq2MI00JCscN
 VkLbX+nLhaiFW6Egn7VyboxXd0QR2OI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-1KAl3Co1MLCKH6UgKvOxbg-1; Tue,
 28 Jul 2026 14:01:00 -0400
X-MC-Unique: 1KAl3Co1MLCKH6UgKvOxbg-1
X-Mimecast-MFC-AGG-ID: 1KAl3Co1MLCKH6UgKvOxbg_1785261647
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E33CC195609F; Tue, 28 Jul 2026 18:00:46 +0000 (UTC)
Received: from localhost (unknown [10.2.17.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FF9B30001A4; Tue, 28 Jul 2026 18:00:46 +0000 (UTC)
Date: Tue, 28 Jul 2026 14:00:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/20] target-arm queue
Message-ID: <20260728180044.GA1324127@fedora>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FAyzWU4zU6kzraAB"
Content-Disposition: inline
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--FAyzWU4zU6kzraAB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--FAyzWU4zU6kzraAB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpo7kwACgkQnKSrs4Gr
c8jLLgf/XkmckuCWwUPedtI8qZ85MrrsCHbIhwWsdNpPXWPCJAAR4eYUdfB3uQ0M
+UIMiUPuJzTWcJYqh16uxOtDn09c1p93vaua0n84ha33nXLTJk9DISk3P9r9gECs
UXW1g43UcO6vxyL6uDlqcPGjJoHl3wCTTpn8twHtLo1Lgkn/r1zSkYP26IA4d5MQ
BrbHe4h6RRPFEx072tJUIRwjYP3ljnich6fYNCYv5rn6JLXFkXQKOQr8/zvyx1jj
RXaYpc7OOrgv9pG8ZJ4UQn2OTHvLvPuAytssYjS+v4jdh1KdDHraab5Shz1hMgEY
gjHzcD6/CNENNaVjxAz/GSiLhfz2Zg==
=At8A
-----END PGP SIGNATURE-----

--FAyzWU4zU6kzraAB--


