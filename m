Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60663C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 14:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXLaK-0002gn-HF; Mon, 13 Jan 2025 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tXLa0-0002d8-3k
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 09:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tXLZy-0005S3-B0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 09:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736779088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ekeLMXSAWOhIx2L8xnDJXU7qy/c/4W+y25F45U7bQQ=;
 b=Hft+YdZl3wMLV3pYS1VmpWs2xwgIpAoT2qfHTbS6QauJtHcGjIMmqrrdTdEv0vshL7uVTO
 qGIMlta+eMrm/yyOr/4IGwj6b/yVsD6ITMMzPkkxFg4SnkMn6F7nfPpmfyAcGvZnJqb8JF
 QxXCQsOxwx472EhGhs2w8Lip37bu064=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-hzLXkYPyNL-0dyakS8-5Ag-1; Mon,
 13 Jan 2025 09:38:04 -0500
X-MC-Unique: hzLXkYPyNL-0dyakS8-5Ag-1
X-Mimecast-MFC-AGG-ID: hzLXkYPyNL-0dyakS8-5Ag
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39E93190D5B8; Mon, 13 Jan 2025 14:38:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97A691956056; Mon, 13 Jan 2025 14:38:00 +0000 (UTC)
Date: Mon, 13 Jan 2025 09:37:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v2 00/32] testing updates for 10.0 (tuxrun, libvirt,
 dockerfiles, misc)
Message-ID: <20250113143759.GA5904@fedora>
References: <20250111121341.141204-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d4h4i0Zr2zSL1sfh"
Content-Disposition: inline
In-Reply-To: <20250111121341.141204-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--d4h4i0Zr2zSL1sfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--d4h4i0Zr2zSL1sfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeFJUYACgkQnKSrs4Gr
c8gZSQf+IOHNQ0ZTWnkI/LMoOtqqIFK9KQVGR9+VUXCSooUziVf0oZy01MSThAdK
HIpeLLtt5g9thCx36m5LRgLtAaG5Med57q9FktfbTGY0dnEEyBNisbH49mOxM5Ns
KXpB4OEQO7QMeWa0eoTVISNCkOW5LJzx1P7DzNqm2/ECTlwb6As1ENzx8cEyigAp
QWacUFtIwicxIWRPA5JTux+U1CBD9qh57w6+yInumSiTTsl9s9r0D22oQ1nbJ3KL
easLB/rilHoC44+haoTkRKFNe3sazTrzKF7Nq8TZ3KiGEUWC/CF5dwIo/4C7fDVb
GYymWi804RUN9u3I2vjLRr4VZcOUeA==
=S6du
-----END PGP SIGNATURE-----

--d4h4i0Zr2zSL1sfh--


