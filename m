Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B42E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvSk-00036d-MF; Thu, 09 Jan 2025 11:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVvSi-00035y-8j
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVvSg-0001vv-Gk
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736440364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nXyi1NJIXzolO9gU9BcbESv6lQD8LC53nlhGBC7Npm0=;
 b=KdUJm3MtJaoVa5EuozAwuhHC1tsu9Jq4m4et7CTQsPVx0yskDQ5fvUvtCXjiYXi2non//2
 ibY7aCZc27xgYQ3DACuftG9xxB+Y67nXBr/qKt0GrmVrpagKzWzmvA48x/RJnFNAt2IRIr
 rwRAoHJ7KuZXabzAPUBik5xfm8s8448=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-JgrHdHtRO6GBIrGv6CQk4Q-1; Thu,
 09 Jan 2025 11:32:39 -0500
X-MC-Unique: JgrHdHtRO6GBIrGv6CQk4Q-1
X-Mimecast-MFC-AGG-ID: JgrHdHtRO6GBIrGv6CQk4Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A1B71955DC9; Thu,  9 Jan 2025 16:32:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.220])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FECB19560AF; Thu,  9 Jan 2025 16:32:35 +0000 (UTC)
Date: Thu, 9 Jan 2025 11:32:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PULL 0/6] loongarch-to-apply queue
Message-ID: <20250109163233.GA190846@fedora>
References: <20250109065804.1569654-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="09+vvT5wNQr+TDzD"
Content-Disposition: inline
In-Reply-To: <20250109065804.1569654-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
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


--09+vvT5wNQr+TDzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--09+vvT5wNQr+TDzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd/+iEACgkQnKSrs4Gr
c8jXMgf+NOya4jQpvddBfbneTLRA1ok/Za2ohNcJdhj29olNtqo2B73XCBGmYAI4
BzrdM/r0SPfpDuzkqssr/iD2Kw/rV0KrqsqBY6vg+YfX68dblkKi0YdIbQz0Tsn+
45sxKS5doeWZQGlGPTjSGRsp311XARXES0SkjQsuJeZDw6OcLkgq7F+IvnKIaNge
LjyGkGKTSXzImYJnnts8ZKVAOP6A+D5Uzoz0hsVDIYy6IFf7SlaLydVtKUcZsDWN
Zcm27DUK5N5y++lJc/61F8c/iAR7kTyJ0Qxo4HpMDRCKHf473l73fTbY9IfLeXWv
6OXfCWO3VGz/I+Rjh+2+UZH/TK71fA==
=YG74
-----END PGP SIGNATURE-----

--09+vvT5wNQr+TDzD--


