Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB44FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHidq-0008O1-Ly; Tue, 28 Apr 2026 09:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHidp-0008Ns-JQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHido-0002Pm-9s
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777383499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ocx8N2mt4WdUmHqCNWykli72Gb/YYk+jAAZJxdbLtG4=;
 b=XBN+hvU9ptjBNiJtoU+nr+SRHenERN0GvkAwD9CnqZeWLIyErTmqPgjb4JgAqfVgByhJDh
 N8kpP6CzPbelRtGSU5G1r6+OhGjHnNlTe9W9Cloaz0aNU97pGQ9Qzng57TSnC/J6nRDg4K
 +ejsnCe229yjC0jy7LK73nxwIzREgAw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-ft_uwsKAPm63BJeenSfOFQ-1; Tue,
 28 Apr 2026 09:38:15 -0400
X-MC-Unique: ft_uwsKAPm63BJeenSfOFQ-1
X-Mimecast-MFC-AGG-ID: ft_uwsKAPm63BJeenSfOFQ_1777383495
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E97201800473; Tue, 28 Apr 2026 13:38:14 +0000 (UTC)
Received: from localhost (unknown [10.44.33.158])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F43D3000C22; Tue, 28 Apr 2026 13:38:13 +0000 (UTC)
Date: Tue, 28 Apr 2026 08:02:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/63] target-arm queue
Message-ID: <20260428120225.GA254530@fedora>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vc6IbBkkWqcbDyNG"
Content-Disposition: inline
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
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


--vc6IbBkkWqcbDyNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--vc6IbBkkWqcbDyNG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnwodEACgkQnKSrs4Gr
c8gLRAgAwYPtw5W72DyPmT6U8BAEKcfPlGlPCEb6UiPld6wLcnSg+1rkCAu/dKhZ
FfkvZZSd85y0gnHB0o1eyMJ/IW43ZfkSa5VkeXp7gqR5tFUTRQqPqRebhxQqK1bq
hfZFINc4CRi10xMOpS1XTfa3M0QsynFmHraO4NSesvKFwqv5lpAY/25T0+0jauoc
8XT0PBv/kUFg4y6KPj8NTvgMTtNPhhaRjHh+BX3ivdqRXgr8PIBiioEPF1jG3Tp1
CjS9eZ5218eK/ddLWoP3gcIAy3Etj72C/O1vepHFP3SeXiROOLZquD0sTLtjvEmd
uNbhNVBCU2HqxHAddyUdJ5cjkMAr4Q==
=WJfO
-----END PGP SIGNATURE-----

--vc6IbBkkWqcbDyNG--


