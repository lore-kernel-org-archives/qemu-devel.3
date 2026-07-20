Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CE0C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlknw-000450-QE; Mon, 20 Jul 2026 06:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlknv-00044d-OT
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlknt-0004Pl-Tl
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784541652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpcwMM3den6aFfHRkBGx/y8ZMBfEQcUbrB0srPjeSQM=;
 b=hUBcLWa2IhABgZUTjasW+hMXvg4ZnxUjJUtb82YGyiTPaAPvqMXJOoavUqvcR1HxHwQMlc
 3JCXel8tZGaNB/DHnWMBnGdaTeQnfkoic2YpexoIqUe1xC4xmfvu+J5PMI1JUJhFRmIvWM
 d0khbHBN4srshzPHczK233eYgLelsJw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-AXdKw6baObGXmNZ0IO6_mQ-1; Mon,
 20 Jul 2026 06:00:49 -0400
X-MC-Unique: AXdKw6baObGXmNZ0IO6_mQ-1
X-Mimecast-MFC-AGG-ID: AXdKw6baObGXmNZ0IO6_mQ_1784541648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 695EC1955F78; Mon, 20 Jul 2026 10:00:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.56])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE07C18004AD; Mon, 20 Jul 2026 10:00:47 +0000 (UTC)
Date: Mon, 20 Jul 2026 05:59:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] Docker fixes for 2026-07-16
Message-ID: <20260720095941.GA815480@fedora>
References: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/uugwLvhF4j32GCK"
Content-Disposition: inline
In-Reply-To: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--/uugwLvhF4j32GCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--/uugwLvhF4j32GCK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpd8YwACgkQnKSrs4Gr
c8jPCgf9HkyjFZ3mt2+JOargJ3HMTMs1nLyCMiP5gdvcWi5HZXzN5ISH+hucLaTx
WM/AdYNn/eBv7IDnFjbLbc6PLgnlNdMR+LvkGFcW68Ww4YCeEwuCdPyj9rfNuqPl
1SUHueF4puhwDA8FZprOL6T4vHaw2uDsip9/GrxDmdNszHMyzZBdUNMrXLYZby+8
OAYskuzdjrPTwrqGn1lMrK46YxZMVagqUAeyiMAWIoVMBbT+PzH5RMM8apTz23RT
Dk1gnWz+ZZWMOKTPFaN7wZl2RUP9IcC1cfHx1EidqKL5vhJvA6Gifl9yimt4uDNb
lsoFyciIAimdLzdtLLqF5q3ux75oGg==
=qIHx
-----END PGP SIGNATURE-----

--/uugwLvhF4j32GCK--


