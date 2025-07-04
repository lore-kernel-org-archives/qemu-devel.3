Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4741C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXka7-0006Uu-HS; Fri, 04 Jul 2025 13:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXkZx-0006Si-LS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXkZv-0001Cy-UO
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751651522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhCvaswYaI3IyVJazryZx/c95nPjoP1rT81DeQEkY44=;
 b=cku4FTdb0GmPt7F3CVgKfk2d3jOphQzJLbJPkYJbmkCs5srAP8Ud5ss8/q428nqkOt/fHg
 zPYoX9Nl9tOi18fc2DhWC/Gt7k+aRM3cxIlafmIztzOwPFgDzcvv5mwe+6T7B30mKNADKR
 Oohmxq6uSlQ17NaK+IgmJmTHKQMiybY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-IKRI7flCMcGui1OpnHQfHA-1; Fri,
 04 Jul 2025 13:51:59 -0400
X-MC-Unique: IKRI7flCMcGui1OpnHQfHA-1
X-Mimecast-MFC-AGG-ID: IKRI7flCMcGui1OpnHQfHA_1751651518
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3778D1955F38; Fri,  4 Jul 2025 17:51:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 767C419560A7; Fri,  4 Jul 2025 17:51:57 +0000 (UTC)
Date: Fri, 4 Jul 2025 13:50:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/40] riscv-to-apply queue
Message-ID: <20250704175004.GA95199@fedora>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DrEBP1NlKD3lIu7G"
Content-Disposition: inline
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--DrEBP1NlKD3lIu7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--DrEBP1NlKD3lIu7G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhoFEwACgkQnKSrs4Gr
c8i+IggAptFZNi4+PzJRFFVNf9eHFnZx+AF6wkslqB4x7yE/drW6pZW3fP15kR2u
fCTBy/tC9LLouZwkCZW5qWkjNC3VfYsJ/3e9c17RM1+otlQpdzFGdfR6u26iShyN
6aEhH0ZjCVBQ39NPUo8vEN9GS+YnGWa/g2JMFdwnERVSUOOryevbdpcfjeRJKSSf
tnrjXepCcP5s9k1oWVfKlKat49O1mTl5+P/OkvySm36DJCLVx8pGIJOFEaZ+anyN
TNfD3t6AMnyvVpBIWI9+WU7ypHCpQR4sZsCmAZGmkYCmeCe/jPkVKQ9V6lh0Vw+y
JLN3wFwESk/YGO9awFyB5VcpZtWRCg==
=l68W
-----END PGP SIGNATURE-----

--DrEBP1NlKD3lIu7G--


