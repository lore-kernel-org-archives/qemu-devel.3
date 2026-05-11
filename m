Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6DACD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUBO-0007BV-G6; Mon, 11 May 2026 13:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMUBA-00078b-P3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMUB8-0001eK-Hw
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778519544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8vPGKeTILWxdulCV9+mn4dE0YEdMeuVHU6hmf/NKs0=;
 b=WszjmJaZb2PoW2EDgazb2UUyHMr88rgeIHiQvaLl5Fk8pGE9DgKQ115NRdd1XuIJCeuiKg
 Hr6OHz05+h8mtYeU433pasOUsHX31T9uoTWgk0fxrhJwXWuM5JkSA8iSeKF6LGzToeBV5y
 HUKQOCKn4y4/mwqOgFxmT2ev9v35Fmg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-8pKqByG1N2yO-PdbrkDdTQ-1; Mon,
 11 May 2026 13:12:20 -0400
X-MC-Unique: 8pKqByG1N2yO-PdbrkDdTQ-1
X-Mimecast-MFC-AGG-ID: 8pKqByG1N2yO-PdbrkDdTQ_1778519539
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AECA19560B2; Mon, 11 May 2026 17:12:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B8863002D30; Mon, 11 May 2026 17:12:18 +0000 (UTC)
Date: Mon, 11 May 2026 13:12:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/28] fpu patch queue
Message-ID: <20260511171217.GA532130@fedora>
References: <20260509155544.848204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1HnUanYbcvO/8B9K"
Content-Disposition: inline
In-Reply-To: <20260509155544.848204-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--1HnUanYbcvO/8B9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--1HnUanYbcvO/8B9K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoCDfEACgkQnKSrs4Gr
c8iUnwf/XOFdp6CAKP3hn17LJTPltGKu+uCsbwAohnzfL38lqy4ef2YtDsXd/POa
8a4K8/tCKGkeO/j7VJhGuNl+0Ztq8m3tptCz71WGo3FghXbHefguUicFEiwDOQZF
hpgOQUOjDeRRXUkDX036DbjO4tbecfbR7oRL5MuYPE9sy08Oy09E43iSSYqF08rf
vOVN7a3IDg33BBTqQC0KXC1dlfjkSaHDIC3jaxWVLncw64P98MZ2ng30oQB/v+Uz
cghsWmg93IYqgKTtY7/2islJTzkAFqWnSkLD01UI2OvWWFLQsX6Smv1Lqwi39Vip
oMVsDjChRSCM5GThSKPxT49jV4D+OA==
=xwXx
-----END PGP SIGNATURE-----

--1HnUanYbcvO/8B9K--


