Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79B7CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 23:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulyYU-0003Td-KS; Tue, 12 Aug 2025 19:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulyYK-0003QN-HU
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulyY8-0007fm-2p
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755041817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAw0z+p7G4SIaULTAENj5LZSbiqa7xWsLnZNCJ9Qjzs=;
 b=BSN6qUWJYAbxz1V7EAkCdZ6A2QOU5juFIWtLCxyqt8JUWrhJHCf6fkrbZx6hKodVNk+U6K
 /VKIRqowFDACRPwm/HxWZUxtCqvXX8pezXmfhQfjbH42yLJl48onCOJKljsokcJfsgKFsT
 DrXCF+hct7weiJj+63fVT0hfhsjUSLU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-fGwSp85VNxy_TF36zZ9AqQ-1; Tue,
 12 Aug 2025 19:36:55 -0400
X-MC-Unique: fGwSp85VNxy_TF36zZ9AqQ-1
X-Mimecast-MFC-AGG-ID: fGwSp85VNxy_TF36zZ9AqQ_1755041814
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6D0318003FC; Tue, 12 Aug 2025 23:36:54 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E581019560AB; Tue, 12 Aug 2025 23:36:53 +0000 (UTC)
Date: Tue, 12 Aug 2025 19:36:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] Patches for QEMU 10.1.0-rc3
Message-ID: <20250812233652.GA131506@fedora>
References: <20250812195901.305895-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NupbWM2yFlxwB/9l"
Content-Disposition: inline
In-Reply-To: <20250812195901.305895-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--NupbWM2yFlxwB/9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--NupbWM2yFlxwB/9l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmib0BQACgkQnKSrs4Gr
c8ishwf6AzZU+rGkdMiVPPt+QfhMOsWWS//fXTRXuwrU5f6QNXuKaGlDOnV45ENx
3WP2qQsISvTcFwk0ihMAEa/J5uFmxezYcUmsIFsVFZx7TTU2CosADoUQkmrDfnpv
VIOpoXPUk7KvHXWpex2+d59xc4gvPkUTvWTEA7lq+t8wp4LZK9+0XbKlD1+84iL6
5kn+FAoCjqDoYpHjsxqUbCMnz4zu6K0vlCANXXOUCJ5rUftOFJBC79HRoK8UNn4x
GIZm6BKdt9pFCnyhAtggG+8iHm7fvVspkBw30yOZC6sNTt1D+zz6LK7LVkwXr8yT
xwHz8GqMS6NG7UNxAvEwmTtaFpvM/w==
=O0GK
-----END PGP SIGNATURE-----

--NupbWM2yFlxwB/9l--


