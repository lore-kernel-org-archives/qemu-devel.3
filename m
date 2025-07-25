Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFD7C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKIV-0007DQ-Q3; Fri, 25 Jul 2025 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKIM-00075s-Pc
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKIK-0005dm-Vm
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753457112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S454C4K8J+bFFd5Un4Qz5rtVYW7atVnBnOSNgvsPf9o=;
 b=X48PGuXD3weC84U4s7594qiGBxJrPRo7oC+gTe2v/60TvnAtNxGgWNVt25vr4fEVWgRO7c
 wrh2REw7+4jTT1gLaq1ZM4WDPtCmF1KJw8p08AMIjT3euDX9pw48berT2dxZ+h32YG4FYm
 CbuCvopm9QNM3VZoOOl94Y0kUQ3yg7M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-y6jNGw09M-2Vk2ISrEMJBQ-1; Fri,
 25 Jul 2025 11:25:07 -0400
X-MC-Unique: y6jNGw09M-2Vk2ISrEMJBQ-1
X-Mimecast-MFC-AGG-ID: y6jNGw09M-2Vk2ISrEMJBQ_1753457106
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAFA81956095; Fri, 25 Jul 2025 15:25:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.248])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA81118001D8; Fri, 25 Jul 2025 15:25:04 +0000 (UTC)
Date: Fri, 25 Jul 2025 11:25:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mads Ynddal <mads@ynddal.dk>, Alexandre Iooss <erdnaxe@crans.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/1] Tracing patches
Message-ID: <20250725152503.GA603992@fedora>
References: <20250724144636.107828-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="beBLCbmynT32qR3U"
Content-Disposition: inline
In-Reply-To: <20250724144636.107828-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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


--beBLCbmynT32qR3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--beBLCbmynT32qR3U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiDoc8ACgkQnKSrs4Gr
c8jrdQgAra8fFPiEyQOiu/wJ5bFF7MyV87Lblm3+FPGOG5D9VaqpMgYoxhbHxq6a
48w+ERzTn0aDEZM0f3yfWnkLBV+YveEM3LQa4JVlqnw/hl70YAROQ0Fv/I3QyEn6
7fGy4Oozmy+1sfuVnnrDOG+9dO6C9eoA9B0GKgZaKWi6BmTHqjZrMRwSLRm/grJ3
AaHRinWEDzKFHG3DHBnnfpstyBhGEWbXNAJ9bEiReZEcKc7thYDV7nsgynOMBGYn
t2FJVtkWJxDJFDzVSGezMEXPJtdg9OLjN8RFBCiywQZDvmiSkPS/LcMRrqxKH01u
xLbx5E/VIkoeSEypwVETISTAVSXZgA==
=zbn9
-----END PGP SIGNATURE-----

--beBLCbmynT32qR3U--


