Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E215DC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 12:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKcU6-0000Tg-N4; Thu, 29 May 2025 08:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKcU3-0000SD-EG
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKcU1-0007c9-Lg
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748522140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLYUoFRTnAjvqQ2olypNsylTkp76TVg/zUwXmqNiGp0=;
 b=Dk4zUuqjtjeNigjlbOmU3iTeU8p3RhsRhALCCi15xTv6L3v1eRzD+bczTLz87dsYoSoPfp
 35L3j5DoONlYlXKCPAbm2o32F7IggGOur4IQz1JbGBwb4WU0+JruITREj1EIK20WFCfAbr
 z8IAJ5XCoGmWXVqbhO/6w8ryRW3zEzs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-FVX05vE4MkaW-Y0U9uS-oA-1; Thu,
 29 May 2025 08:35:37 -0400
X-MC-Unique: FVX05vE4MkaW-Y0U9uS-oA-1
X-Mimecast-MFC-AGG-ID: FVX05vE4MkaW-Y0U9uS-oA_1748522136
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC46B1800EC9; Thu, 29 May 2025 12:35:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B52E19560AF; Thu, 29 May 2025 12:35:35 +0000 (UTC)
Date: Thu, 29 May 2025 08:35:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/28] tcg patch queue
Message-ID: <20250529123534.GA55796@fedora>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2fmbNAqoYKXM8iIn"
Content-Disposition: inline
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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


--2fmbNAqoYKXM8iIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--2fmbNAqoYKXM8iIn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg4VJYACgkQnKSrs4Gr
c8h7nAf+J1HqTKVq2CUkETkT+9ZY4XHdWvdwdDDPPkF5ko6WVHlrbbY6FCGSNiRh
gdyopSl+qWBqFOfE9n6Ux0rdwHxxLoR63Na1Rqt4xTr4k6Uv9aHPc99voYEzV9BG
k4MtkuYBXmnd7NzYeZ7mHTAmRyH8sxWG1i8ND3ahkTyRaY3QyOVDUSjBpnIHbm1j
2BEKa/0AdexKMXCWOz3AUcTpCEwCVcqQ9Cjka55ql4w2uGdhFaqpwiDbYuduqiIy
ftR1W5ikwfSRXIn3f+yWtGfjY8aKbhkecgpKM7RIqWWm+z7N4+uZDuX3q+yhlqXu
yQpCjDQAQBxhR7qQYw0heQWP3OnxvQ==
=Z+bo
-----END PGP SIGNATURE-----

--2fmbNAqoYKXM8iIn--


