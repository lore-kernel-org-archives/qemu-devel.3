Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E53FF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 20:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGjA8-0004Ug-Dp; Sat, 25 Apr 2026 15:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjA6-0004To-VM
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjA4-0002bS-A4
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777147171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcW+l0X3Zi+UAFRRrgNHzB4Uhz7uaXJr1ulCcT1mUdo=;
 b=M+LEmOR4f8njlyDNezM0J/7I1G3o0OD30xLjPe99xW7xBdKBBteqzEkHVFssF9KnOqP9gC
 YrC79Gc1vCYqZUQBy7dsDIElyNCd4vxyqASbkoJs7Zx/yfUV83ac4rVY7OEekQ9HT5nuaz
 ld/OwjpoIRnS2UpURiOuyALRd9afH8Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-Z-N0hpDsOwuOW_Sk9azY5A-1; Sat,
 25 Apr 2026 15:59:29 -0400
X-MC-Unique: Z-N0hpDsOwuOW_Sk9azY5A-1
X-Mimecast-MFC-AGG-ID: Z-N0hpDsOwuOW_Sk9azY5A_1777147168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96FB819560AA; Sat, 25 Apr 2026 19:59:28 +0000 (UTC)
Received: from localhost (unknown [10.44.32.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5CBB180047F; Sat, 25 Apr 2026 19:59:27 +0000 (UTC)
Date: Sat, 25 Apr 2026 08:31:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/2] virtio-gpu hotfixes
Message-ID: <20260425123102.GA129314@fedora>
References: <20260423151946.1853943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZuPHajgo/Ww+cjAr"
Content-Disposition: inline
In-Reply-To: <20260423151946.1853943-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--ZuPHajgo/Ww+cjAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ZuPHajgo/Ww+cjAr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnstAUACgkQnKSrs4Gr
c8ivwgf/aoLQBrcqSLqT0xylRfuB8VobbJtHHC2cGlNskcHJgR3/1VWh/U+kUUzH
T/asXEFYZEhRr1FFmc88UB2I2P8CIIV8kwlVj9yurmlvHly8028dHztKlvt35ZMT
JP/vsYOkBv2Xsau4h2f7bEcKa6i8ReyrVTZMmvr/O1E1uetY3D7NhWKL2OubWCpw
EspseY202BrqfKyeJJg/JbFesWwZLqAo1s+My5kpyvmPMlQBDd8SX1VblSeokW5U
s7vF5ExcMYu7SuGVbfW4wdYn9nN1IHOQaLMoovdA49g2lHD0FQXP28f86nMEE5tF
PawLpUEXk+oxZjz8AkiLke8YW/6F1Q==
=iuq3
-----END PGP SIGNATURE-----

--ZuPHajgo/Ww+cjAr--


