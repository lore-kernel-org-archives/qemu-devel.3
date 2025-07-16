Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D067DC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1W9-00017X-IQ; Wed, 16 Jul 2025 08:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1QF-0005QL-6d
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1QA-000808-RO
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7wvPAWio+bZb0Et/mER4AzCw2kIOr4AdWMBBgRMMBCw=;
 b=OraLASx4ge4anAuOd7dBJrLxU8YeECssloRMIwe+kTvbE0/5lWtatWCvWe0J/fexq868ei
 XEQkaC3/wXW8v7/hWhCbO83HkmiyEFOqid1/f/whqfg3/buO4XFWK4+B1AESif2gR4AzNw
 cfRVrPtkcPTpExhhdMl3CFKe/XQ4EPM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-Omdd6ESyMQCIOgvN_5xrxw-1; Wed,
 16 Jul 2025 08:39:33 -0400
X-MC-Unique: Omdd6ESyMQCIOgvN_5xrxw-1
X-Mimecast-MFC-AGG-ID: Omdd6ESyMQCIOgvN_5xrxw_1752669573
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DC061800D9C; Wed, 16 Jul 2025 12:39:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC6BC1954213; Wed, 16 Jul 2025 12:39:31 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:39:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/97] virtio,pci,pc: features, fixes, tests
Message-ID: <20250716123928.GA328013@fedora>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wkyWkmhoSL/ImJEZ"
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--wkyWkmhoSL/ImJEZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--wkyWkmhoSL/ImJEZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3nYAACgkQnKSrs4Gr
c8giPAgAqJnULMBA3o9h6nSNTOK5gVGSz3gP7XY7oZ6wE9N8X3t1XalhmbStaSqj
wY9jsOi+sK8Ws1f7zdbhJFMgWSdeC00T4DoX+0i//KNUhZZZaiL5l6gsRZFLavi1
+v77lUDAl9IKrsPIvaMLLEKAgfseQZ/RuSGtXNzN6MJLQRR0XswiRgTPtqhMpoQM
bU6dwACJ2Da+mIBcIEInCpdM9ochc2k/Q1Zszmjxu2cbYxeGYllWDEql4eroT409
MDZz2TXPsESILYiU0ExLVKVS+ShN1vgvQ+XHzfcAj0es9qAWYmzZjEwhwtQOex6s
wlqgAEDcPPNlWI7Xfy47cPk80CBfUw==
=wEJl
-----END PGP SIGNATURE-----

--wkyWkmhoSL/ImJEZ--


