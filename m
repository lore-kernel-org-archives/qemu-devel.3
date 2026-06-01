Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7290DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3CA-0004q3-PC; Mon, 01 Jun 2026 10:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3Bw-0004nj-DU
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3Bt-0005Rm-OJ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780322427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twMFXeWEp3prhifBdqt9VXL5xUwRjegGo4YhkEC6IF8=;
 b=TT8SYAR26RXG92II1HmUx0VyY39KD+Q7G/5/T/Rw1TNw9e6+0b1Jrgn7TvyIagsBesksuj
 ndWncpPm+VO1BFqAXuDMTF0FyHptz5efY9te4t5C4QfE3rvgKzzm17CttUmmn0dEs7ASIU
 Pahe62wXGdnRFXUKA6OF3VebXyEjJVY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-zSutUSiDMcSAGfYdLUjk7w-1; Mon,
 01 Jun 2026 10:00:25 -0400
X-MC-Unique: zSutUSiDMcSAGfYdLUjk7w-1
X-Mimecast-MFC-AGG-ID: zSutUSiDMcSAGfYdLUjk7w_1780322424
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 687061956072; Mon,  1 Jun 2026 14:00:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F148F30001BE; Mon,  1 Jun 2026 14:00:23 +0000 (UTC)
Date: Mon, 1 Jun 2026 10:00:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] tcg patch queue
Message-ID: <20260601140023.GA410588@fedora>
References: <20260529203101.290947-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eTMKLxU7cq3E3N83"
Content-Disposition: inline
In-Reply-To: <20260529203101.290947-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--eTMKLxU7cq3E3N83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--eTMKLxU7cq3E3N83
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodkHYACgkQnKSrs4Gr
c8jn4QgAoAhyTVKtIAuJi944/RBdXEQkqvZriDvO5KbRI1K5XGY55CY6mtUP+ZIi
5b8kNgn+/SOST09+cQQhe+Z4pkB27p6YO3VwWMaiWtEUuXjBiuVzemOivpfYMm77
04AQZRtudx0blBbc9yEORAERN2nnNueBM5RRQEjl87jN8rDMs4YwFgVf+NIO/EQX
jfpy7lKCUf3TN2IpWfLRs4w+x2hsVXQzLE9xci8jZAQEF5mOAlAgFcRGp73LYjV+
l45PodV5W0naI3ESETUogD5FXgo5lJIvKH8t5HBM2i7wVFRD9ajp1BpcvV44I+qk
LkZnYXehxpvteWJYGUtFkYnxuFgN2Q==
=i2kM
-----END PGP SIGNATURE-----

--eTMKLxU7cq3E3N83--


