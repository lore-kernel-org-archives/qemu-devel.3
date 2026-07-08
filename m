Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93BCC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkhF-00009t-Dc; Thu, 09 Jul 2026 05:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whkhE-00009X-DG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whkhC-0003Cn-UN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783587926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xs3Pep1+cxIGQytLVwTDLCG0TdS++2TK8oohaEX/j+E=;
 b=LKJcMiOXKJttl9lJxWIkPnPHzYnU9/kD1b9QDwn5Y+Ma5D6nvMDRR2feL4JFgS2Ut/HORO
 FeSMOm7NjRf0mS40dYwK/4aooI+/BztEKJaXISPbPHqrI3TQSysJ9hHIs75Djg7pvj0gfq
 oAd4IHffgNf0bStgiw3H2lbwLlCCsHI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57--dOBp967Pq6xMIs8aF2pRg-1; Thu,
 09 Jul 2026 05:05:24 -0400
X-MC-Unique: -dOBp967Pq6xMIs8aF2pRg-1
X-Mimecast-MFC-AGG-ID: -dOBp967Pq6xMIs8aF2pRg_1783587923
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CD371955F3D; Thu,  9 Jul 2026 09:05:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E8BF180059E; Thu,  9 Jul 2026 09:05:22 +0000 (UTC)
Date: Wed, 8 Jul 2026 17:32:48 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] qemu-openbios queue 20260707
Message-ID: <20260708153248.GA572434@fedora>
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AUyMXksMPWgtGpVo"
Content-Disposition: inline
In-Reply-To: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--AUyMXksMPWgtGpVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--AUyMXksMPWgtGpVo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpObaAACgkQnKSrs4Gr
c8iyKwf/bVSZySrhT05SwAzYLDZ+SxSEiizoKRimPnWqVvSzI/cxsOIpxBGSQuhS
Lq3LWHktQZHkZ15Yqt+N+wCOxJcCeadwvfKMCQ9qh8tpxiUBDMui8GHMyItay3WS
Hiq5UB1mg5cRpKgLByG2ovPEJmGIaO5YJsbuYZS0Z8U9j5/Ymjb2B9lyfBpoTdMd
ArLnLvLLXbhhJFGmuwDBnd7Hw+KRyn0Skf0TEk7i/Jp65pa3bR6UEKro7knP4+X4
DdHWrUOoUVTRW3357NTrjBCTNpPdJGqnBHH0JizAFsRnJZt5XQrR1lgeDRu2Jbqe
wz15c9o8sbiaoJSleK1E9HMIJSKjlg==
=TS/A
-----END PGP SIGNATURE-----

--AUyMXksMPWgtGpVo--


