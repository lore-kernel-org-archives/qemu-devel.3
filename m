Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED11C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 17:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7eMS-0005SF-EQ; Wed, 23 Apr 2025 13:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7eML-0005Qb-3N
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u7eMH-0005Am-Qn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745431084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIw1ZP5E/xatwUMv5Cwq/2YVMB0ah2CPKstfvdnOyEw=;
 b=Yi9TD+AQPGfd9pztXzEu++IIGDewp9k0BAHKyrgEtiVvi6KN0cuAe05dzi/SNkIVcqBoJb
 g2ojCs6xX9GzfU78Utp6bU7YLRUZyoWuF6IopRG+EM+DKHEXAbb9RW4r/NMjIYAIT5iuQp
 ehMsWOi66yTg4WGeab4ZuktGIkdhKYc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-gj6fhudCM9iDGx2nVL0E7g-1; Wed,
 23 Apr 2025 13:58:02 -0400
X-MC-Unique: gj6fhudCM9iDGx2nVL0E7g-1
X-Mimecast-MFC-AGG-ID: gj6fhudCM9iDGx2nVL0E7g_1745431081
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5B6B1956086; Wed, 23 Apr 2025 17:58:00 +0000 (UTC)
Received: from localhost (dhcp-2-16-89.telco5g.eng.rdu2.redhat.com
 [10.2.16.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FAE719560A3; Wed, 23 Apr 2025 17:57:58 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:57:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 00/29] Machine types, s390x, functional tests and Avocado
 removal
Message-ID: <20250423175756.GA353648@fedora>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B4zGZyiptx51fk2P"
Content-Disposition: inline
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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


--B4zGZyiptx51fk2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--B4zGZyiptx51fk2P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgJKiQACgkQnKSrs4Gr
c8ip+Af8D4WHPvPpiNlcXl5m2c0paidoFM5BjKrzWyNE7L8FNYlgXrCtpcAzq9fi
FU1y17piCR3ma7zJGSvm7oQB2nmSZKS9+718SiPRPDihhGYoCmcfYP69nskLhn8Z
D7Mf4VDPF4Yks6sKJDtI98b8hJ9oe9bZedizShlyw4Enxb3FwX0d9Ry+9SWbDAuP
vbMm9Hyyz5f0mEW/YFQOv8UHTvW1mgcSjSYeid5ZYFcCopUBbx4xE/mpVt/XDp4d
uG7iDbPAGrvs4DJzbQUtEGBU3yU9IJcObb2FfxHLq3jq1gXH/pNXgiYRabboYbve
KtlWXEx1g8PZ8+iVoc/sHej9X+zTaQ==
=X3xZ
-----END PGP SIGNATURE-----

--B4zGZyiptx51fk2P--


