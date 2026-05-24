Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6947ACD5BC9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 19:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wREHv-0001Y7-Jy; Sun, 24 May 2026 15:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wREHt-0001XO-EI
 for qemu-devel@nongnu.org; Sun, 24 May 2026 15:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wREHr-0006Lg-Gg
 for qemu-devel@nongnu.org; Sun, 24 May 2026 15:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779650098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h95zDu9eDL3VxXV9EzUmtuRBvRcfuFqhw/daPuBVIeY=;
 b=MElhcqtdKyrFW0KboQbyw1xB/kZqvYELuaYdQj2jEgtJFWw928DMKohyjEYHxwYnJ+PYTa
 2IfIZSYjF4WKbJFgGKksk6IV5A2/G+r6+JCfqSscy8yHIR0XF3zSQ9eDuqSjzigZxd2eVI
 44AEboUflfu7/MFEYCTj6TTbkMscKrA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-H5U5UCajMNil5R0u4JkbWg-1; Sun,
 24 May 2026 15:14:56 -0400
X-MC-Unique: H5U5UCajMNil5R0u4JkbWg-1
X-Mimecast-MFC-AGG-ID: H5U5UCajMNil5R0u4JkbWg_1779650095
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30AE61800451; Sun, 24 May 2026 19:14:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C876419560A3; Sun, 24 May 2026 19:14:54 +0000 (UTC)
Date: Sun, 24 May 2026 15:14:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/30] fpu patch queue
Message-ID: <20260524191410.GA1497638@fedora>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IQgX6T03y4uLyFGC"
Content-Disposition: inline
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--IQgX6T03y4uLyFGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--IQgX6T03y4uLyFGC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoTTgIACgkQnKSrs4Gr
c8hWMwgAvGGzGBjxCUFuoNAyxcCf5olm1ZvvdzzooTfA5+fHI9mCBaxT5ZQ1n6fO
ImwGMPOqE4Eq3yM9G5UDkxEmgPwIjmVK67IQih56RJPGeSpghoby3+4Kl3sBJZQ+
OjhbJGgZD9WDvYRInQCLolx8MVKnza3L5pGq5ksoIALZWU1BqKAQCtxkncz9Yslt
9KcigbPwOwlHQw6Jx/2HN3hkTxF75MWZ2dH5A8mWJC+c2mSYQQzELJJzk0XDBkql
U3HhltA3j9AS6Ri8iaskSYI0Gx9WCB9akRyX6ZZ1vJWsnjiM+TWX04ZgOVpZPmyi
JjjhL9Mkpg9xOPKNL9lZW5Uq3xvXrA==
=Y3TK
-----END PGP SIGNATURE-----

--IQgX6T03y4uLyFGC--


