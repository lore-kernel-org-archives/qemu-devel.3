Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C000CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Co-0003Je-Mn; Fri, 29 May 2026 15:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3Cn-0003JE-5E
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3Ck-00043e-WB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780084153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2hfsntq85WUQFgeIcC7fZgtQVkYyIpEiUF61C7H5IE=;
 b=Riai0TbgE6KTCk21qNiESJWR2jdXgi0Mt60YAStMawnARbA5cYmO0QSgT03wmQWD2x//lM
 eoA8zoZHF/WEK98U4TdwrzeiqfcMz1Mtfiu6YwxT/uH2/UwtpqrupfBFt26Iwo82CV1/Y+
 wmcXvym9vu4i7oJ2lLjbtUkrGDLO8i8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-3YQ6XPY_M7WWn9fZ1bCKwg-1; Fri,
 29 May 2026 15:49:12 -0400
X-MC-Unique: 3YQ6XPY_M7WWn9fZ1bCKwg-1
X-Mimecast-MFC-AGG-ID: 3YQ6XPY_M7WWn9fZ1bCKwg_1780084151
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CDF1195608F; Fri, 29 May 2026 19:49:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EAD8180034E; Fri, 29 May 2026 19:49:10 +0000 (UTC)
Date: Fri, 29 May 2026 15:49:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/21] target-arm queue
Message-ID: <20260529194909.GA200171@fedora>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0q3BNCK9CpxPZ8HV"
Content-Disposition: inline
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--0q3BNCK9CpxPZ8HV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--0q3BNCK9CpxPZ8HV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoZ7bUACgkQnKSrs4Gr
c8jJ8Qf/f2KZVeOMbf5plFHTcfayXtK3i9urLuaEeWsGgkUirLflLUS3oaoHel97
O9FgVBXzubViHru1cQ2vVNy0H9Amq1MxE3YhCdmK+GtKXddGCYbbgDL4NQwpDdvs
6+SXVwU5gJEnAvBbvlFi1mLWy7wyZI0Pls4AFq1OAi+SArtytiupeNGoYOU0wFY/
wJaETr0WldcHgvhfYFflMqvLxQu2hg6oYGW+teeHegX8C4BZuMHzYOAyMmYaLJmG
8ee5qDAPftFBK/+ycf5mm3rdgFoa6U3Wi0OMGOIfuVvXg3uyrvr3C6kf7CMuRKwb
hprmaGLnWpCDwLEDjCvY4/hQ9WglBg==
=+Hfu
-----END PGP SIGNATURE-----

--0q3BNCK9CpxPZ8HV--


