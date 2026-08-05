Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C26C55184
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrPuz-0003oH-Rt; Tue, 04 Aug 2026 20:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPux-0003eQ-Qo
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPuw-0003is-CW
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785891333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hG1Ws64sqmPDty7V/yw9WF/lV+OfWbj3rQ8d5ay0hnM=;
 b=T9W5jRTVd5plurSflBNf3GnuAbSSpT2Zpw7LsgvILXL16nP0c1OqclcebNnCjsNHDa0Ih5
 4je43wJ6JB1wPQDawInpyUN/b8wvittRRezSp/mqcD90/Ag859K0WlLjPXdDZa+pNIy59r
 1pKEtlYx/hfju3rqm744HslkolQnaqw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-JvmOBfoXOk-pmG7n87280Q-1; Tue,
 04 Aug 2026 20:55:27 -0400
X-MC-Unique: JvmOBfoXOk-pmG7n87280Q-1
X-Mimecast-MFC-AGG-ID: JvmOBfoXOk-pmG7n87280Q_1785891326
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2047F195604F; Wed,  5 Aug 2026 00:55:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E128180044F; Wed,  5 Aug 2026 00:55:25 +0000 (UTC)
Date: Tue, 4 Aug 2026 20:55:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL v4 00/17] Block layer patches
Message-ID: <20260805005524.GA582323@fedora>
References: <20260804150848.256125-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5J50SoNeZ6krtM9/"
Content-Disposition: inline
In-Reply-To: <20260804150848.256125-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--5J50SoNeZ6krtM9/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--5J50SoNeZ6krtM9/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyifwACgkQnKSrs4Gr
c8gqlAf+KAInBw2JqklUg6bdyr22yNYp3m/0KQRwn8NunH9uI7rn80X268j5qZw3
tTiMjXjX7QeE66Eiw64F4hl40TKEhBjvlO1ET4yU2Uoq1S8vP7kmLAcqQSMA/5bF
TKXoRdImWtARHrsoYYINK8eCIA0NJFT/dws1J7PEKpsgg7z1xKrw4Mp25n/tD+c4
faYgNSwv8r6SnLQWApHkzzUEO0c29D9cgJ+6ajHUeL5o3yfbWLYnUCGJz9y7V8LC
BLQGz6+dynatmF7blI7RdcaXSU3pVGIhRtriW0dX3fiLdQA2N9+icky5D6U/DI3U
a9NRlsW9geZ/RnFzJd3kuwrOdXrA8w==
=/yo6
-----END PGP SIGNATURE-----

--5J50SoNeZ6krtM9/--


