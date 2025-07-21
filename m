Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFCFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 18:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udvIg-0007At-Fc; Mon, 21 Jul 2025 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIc-0006se-9a
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIa-0005BE-EQ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753122698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZR/KzRiI0evYBcJi/rGC580CJ3BfwbrjQWSAqP39lc=;
 b=V+dq9D3QhX05OuccSR4u5Mftb1Gg+2QBtvCD49LV+ci6HTM6PYP6WpBuHuklGZdHeCI6up
 sd59nku1WV24QzhV8JaZ63wS7OhAw38d+/LwdyjXXG1VcsYC/TklFfQayPRk2CWqUPetUs
 zBFg3cM84EGOh4/RfH0/QrEvdaK2e3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-Bmtk_0fiNDW6YZrRLykSvA-1; Mon,
 21 Jul 2025 14:31:34 -0400
X-MC-Unique: Bmtk_0fiNDW6YZrRLykSvA-1
X-Mimecast-MFC-AGG-ID: Bmtk_0fiNDW6YZrRLykSvA_1753122693
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B04F71800343; Mon, 21 Jul 2025 18:31:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 628AD19560A3; Mon, 21 Jul 2025 18:31:33 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:31:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/20] target-arm queue
Message-ID: <20250721183132.GA77974@fedora>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EGMmYOu+HRizgc5h"
Content-Disposition: inline
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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


--EGMmYOu+HRizgc5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--EGMmYOu+HRizgc5h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+h4QACgkQnKSrs4Gr
c8jLSwf+KwEbvCzJfnOgutIw0Zmo/VxzNEbUAaiCVJ6WXoN6sN0BYM0SQDGVwV3L
/CfyS6cff3c+alOM2/gMTyhv0qGCNG2BhpeONAEAfJrfrcFOi+PRZt+DQwjSVCNZ
n2cgIH9D7gRTz4zeX8Xo9mviREMgIa6Iop4v07KjvpB4B49NgalkSFJjLlwymOgK
Sv2MOp1GMoo+nfiksTVDxqQ7McPchr7MIaRuqro3Qag4+ReqW8Ai5I82cFkfAo6W
4TO6DSFaB+m9vuvI5L3lmo6Eh//MY6kTKR9s5MpSpfGIvsuJo45G7Ll4G7iEPylP
v46jEy91AeOA/AT563GX1gA3s0f50g==
=No3T
-----END PGP SIGNATURE-----

--EGMmYOu+HRizgc5h--


