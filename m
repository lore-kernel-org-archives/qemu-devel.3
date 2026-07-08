Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8CAC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNQy-0008HG-B6; Wed, 08 Jul 2026 04:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQf-0007wS-QS
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQc-0003ce-WF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fp5tbgIYgDcyy3U1vdZnbW/U0laPICSvyijg/4jrrE=;
 b=gS0gqUYR2b97QvZi0vYIftkfaen1A7tFp8qVKHJ8DthJfM0YNRQ+eAw0g72yUiA/vOEsiR
 h9pBhzuaIhiwNkXknZatSlultZCa3fpiS96Wl6DC2HlRltnhxhpEZRLocrJ2XCzasR1zqe
 LjOJjjNJvyxeJb2BzsqsRc+3Ap3x0zE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-FqCSC6mFMeC9DG2HjQWD3g-1; Wed,
 08 Jul 2026 04:14:42 -0400
X-MC-Unique: FqCSC6mFMeC9DG2HjQWD3g-1
X-Mimecast-MFC-AGG-ID: FqCSC6mFMeC9DG2HjQWD3g_1783498481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E77291955DC2; Wed,  8 Jul 2026 08:14:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4196C1955F43; Wed,  8 Jul 2026 08:14:38 +0000 (UTC)
Date: Wed, 8 Jul 2026 07:53:47 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, maobibo@loongson.cn, lixianglai@loongson.cn
Subject: Re: [PULL 0/8] loongarch queue
Message-ID: <20260708055347.GA553601@fedora>
References: <20260707123226.25918-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FcvFvVgfd3Ovja2P"
Content-Disposition: inline
In-Reply-To: <20260707123226.25918-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--FcvFvVgfd3Ovja2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--FcvFvVgfd3Ovja2P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpN5esACgkQnKSrs4Gr
c8jUaAf+M2m5zTfZ25ObVi3W8XpMnSAmXTiz2q4jDiEO3TqCuqccxk+e6ZYD5zKa
BUhcvwEMJUrPO1X25BRNxQx1BfP2QAAA3pw9IcAAQYnPay4Pcm1IUaf3WQJKELTP
e/VjKnhYnblIP5ZbLyqyfeV9lJ1N8bpqLsVFi9MxesD/clYizeVj/QxD2EgWA7D7
MZK3qt+slpLFGY8ZnpMAWjqORuv4BU5S9zJKC3sC14t15Ca4snC96WcglS5J346f
mnHftdyKfnRta8fjBT49MFdLQWGdxMKjvgouomZOZFNSNWPbXCi4ZQUfXqrsRadx
3GXSjCupzeoe+6v69WSId3My8qKzmA==
=f+zJ
-----END PGP SIGNATURE-----

--FcvFvVgfd3Ovja2P--


