Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9758FC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 17:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9SkY-00068n-Ou; Mon, 28 Apr 2025 13:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9Sk5-0005Jq-B2
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9Sk3-0001ea-CO
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745863086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4LmmFmhfD8NdyO7b4fv31LDDU7zNVTPX+2ynL0KCDuc=;
 b=h9JXsS3nQyRgjtgy4PAYwi3I2x5BhlruWOypKdWJF0/qHMxlUBs15bIfqnTsmcHLtsyceM
 wWqBYKY6fm2i8uF6QU3JUCAppN5TWr9woz0WPOpJdxtLXWn1nda8vBTB90/xDUpAiehLz3
 Jehy41nhYzFwQ8F8AEI6Gfbbe1U3Nv4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-EL2A-btGOh2Z3GDC_PHiaA-1; Mon,
 28 Apr 2025 13:58:02 -0400
X-MC-Unique: EL2A-btGOh2Z3GDC_PHiaA-1
X-Mimecast-MFC-AGG-ID: EL2A-btGOh2Z3GDC_PHiaA_1745863081
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D03D1800876; Mon, 28 Apr 2025 17:58:01 +0000 (UTC)
Received: from localhost (unknown [10.2.17.24])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D333B30001A2; Mon, 28 Apr 2025 17:58:00 +0000 (UTC)
Date: Mon, 28 Apr 2025 13:57:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 000/159] tcg patch queue
Message-ID: <20250428175759.GA634522@fedora>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MYBx2PTtMAGWzkmj"
Content-Disposition: inline
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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


--MYBx2PTtMAGWzkmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard,
Please take a look at this CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9849960705

It might be related to this pull request, so I have dropped it from the
staging tree for now.

Thanks,
Stefan

--MYBx2PTtMAGWzkmj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgPwacACgkQnKSrs4Gr
c8guqwf9HIBu86sl7M/4tZstk1x2eiQ5GDw8clxw5Jwr8m1N6Qp6ooGwpsHfolv/
SpMMKqVAtRpyucf681r/3QyFTlDCl6vde/RUZWfxYWV2gLs28HKCawYznPj1vrLv
xytTr4V5cks8qIJE1+yqO5GVToz/f8BoE7/RDJNb1fQpRsfZeqrCIfZh+kcS1hwz
fuk1uCJOptF6b/SIwrJPIx5CeYOOv4aw08sfj4rTCxaFUGAM9f661l+Sj730UFvP
Fcla4GAcpw5XgaZy6r5s6PjukBWj4WrBpAeuWo200I7sz0OK4vi9bldU5lfnPM4I
7zFIlPZ9oAjYLibIUAntUyeYrpHN/Q==
=sUH+
-----END PGP SIGNATURE-----

--MYBx2PTtMAGWzkmj--


