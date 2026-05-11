Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15FBCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRWU-0001LA-6W; Mon, 11 May 2026 10:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRWA-0001Hc-CZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRW8-0002ez-6u
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778509314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tM1jT0I+GdeQdzJLLgJDl5V/TNnlPrjujzWXN3oXx5g=;
 b=D20PC6fxjCY7dpmDY1hWxHruuFw4afxcSyHi7sjAHvlRi2Wv/vdogpsN4AQgRx9R7nrlCV
 LcaJcbh6HnLZGCxyPn1swIlN42DqPDRLstMkgU5/VEl0O7Xzg0om4PwutE6a/vzgWiCnMA
 21V6qWvvfzj6ntsv16dtayuDQimI8mo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-59gqcZWXMCGB6JOuwcVMyg-1; Mon,
 11 May 2026 10:21:51 -0400
X-MC-Unique: 59gqcZWXMCGB6JOuwcVMyg-1
X-Mimecast-MFC-AGG-ID: 59gqcZWXMCGB6JOuwcVMyg_1778509309
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60350195608C; Mon, 11 May 2026 14:21:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA5EC30001BE; Mon, 11 May 2026 14:21:48 +0000 (UTC)
Date: Mon, 11 May 2026 10:21:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] loongarch-next queue
Message-ID: <20260511142147.GA520579@fedora>
References: <20260508022801.2637558-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sQH9a3IQERNEPNqI"
Content-Disposition: inline
In-Reply-To: <20260508022801.2637558-1-gaosong@loongson.cn>
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


--sQH9a3IQERNEPNqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--sQH9a3IQERNEPNqI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoB5fsACgkQnKSrs4Gr
c8gfnggAix3JVQwxPWWDI0QCstbuimwjFO0MAr3saEs/YpKOzMT5mDxRWLhGAScU
jKx3NDjUqx3tbWrNusDU86jtaPFtsDMw9QrXTJ6zI9j5BA272EMG+P9bWsUq19fQ
bd+P/diYLA2w6FaQ+hsGPffGZrkxJ+Oi8k76yC+BEXb4dzos3ShQM9otojiJPR+T
62v4ix6Dylec27pkFl5GIRZS/D9qBeovzEPdoRYSdbuGDtNAnzUOgp7EMLVxrY/h
yv77DbAAO+IpwjV2CAOUEj8piAtRz1wY9D0mDzkrRNijT1a9PJRxw+OdoBvhkW6m
wyNqkFxOuevV+Iojbxl9SVYIrF28fw==
=jTS/
-----END PGP SIGNATURE-----

--sQH9a3IQERNEPNqI--


