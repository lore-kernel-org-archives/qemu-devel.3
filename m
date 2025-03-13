Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1E2C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsceE-00047f-Ea; Thu, 13 Mar 2025 03:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscdt-0003qy-Lr
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscdr-0007xz-W0
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vcc3zyJFTDFp1v3p2ZXiFruOkRU5QZY9hhU5dvzbig=;
 b=jMHU0HFbka2O4s70m4mEnpUaQXR0+DJe4gwxEeEM/c1AJlqPvPjy+UXrtDcNUftrkQczxe
 /Sbk0yhL+e5uDB4AlBIkhWigiM6wkh7VBB+v8N51vICVucFYGmdgelYBltk6jgkUllewAz
 usMAiOBcwCA0DOY8jPC58YtoWWpTk40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-IRNYKBb5PcWMN0bsT9PaKw-1; Thu,
 13 Mar 2025 03:06:03 -0400
X-MC-Unique: IRNYKBb5PcWMN0bsT9PaKw-1
X-Mimecast-MFC-AGG-ID: IRNYKBb5PcWMN0bsT9PaKw_1741849562
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21EAA180AF50; Thu, 13 Mar 2025 07:06:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E2B8300376F; Thu, 13 Mar 2025 07:06:00 +0000 (UTC)
Date: Thu, 13 Mar 2025 15:05:58 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL v2 00/14] Misc HW patches for 2025-03-11
Message-ID: <20250313070558.GA1086242@fedora>
References: <20250312101455.99631-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7LPzqGLGii8WWKE"
Content-Disposition: inline
In-Reply-To: <20250312101455.99631-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--Y7LPzqGLGii8WWKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Y7LPzqGLGii8WWKE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSg9YACgkQnKSrs4Gr
c8iHjgf/STzPMmTY7YuTMx+Pr5ZxbCGqPHglcSIQZEyyDr1rAzuea2gv7cgxGQQc
ToJacNhU2fKUrVQnBM7/QYGW4kFKAz1cUIkdnYYmvE85+VS7fnth9vsHyzsgngeV
iQ4D42JrDAoyJ7MzZK6EDNbQ6tyWdzGr2lpW0NyGtb2iV0b3fSCJam+1XhfsmQ2T
6gZHKXgaB62tHdqeti18imCKe1kEo3KvJCt51iF2EY05B2X5XgZli2PU+gwH3Z9U
74QODGmBRTbzYIMW2ma6x4MB7uwc3yVS7GTyu5mo8eAHeJZvIxSzfTKIxZDr+Txq
7flDOzRF7KbxrCuhs57D+QCVsAZh0A==
=ECPe
-----END PGP SIGNATURE-----

--Y7LPzqGLGii8WWKE--


