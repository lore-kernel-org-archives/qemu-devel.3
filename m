Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A943C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 22:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGQ07-0003HT-AP; Sat, 17 May 2025 18:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ05-0003Gc-BR
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ03-0006ig-V0
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747520843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYZP8kgQZ4l0h8rGyQbSWJRmcEGPsD7OznAEd+HcrA0=;
 b=LFciz4nVn2dAptN0SJlkofbYVgoJkXImfG2Dma8mazQ9MAusB7oR9NcO6cp/WndSehooZy
 7lJQmhVyc4weV7ly06ZoKsm1Mk1nNanFkjwTqxCxoNAGHsbFckTbsfBgPRCuOQelrOqRnb
 VVbjJ7d09M/gV0bhL6jpcQ56p6/r2+c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-vOqQrhJrPwePimg-aB7DAw-1; Sat,
 17 May 2025 18:27:19 -0400
X-MC-Unique: vOqQrhJrPwePimg-aB7DAw-1
X-Mimecast-MFC-AGG-ID: vOqQrhJrPwePimg-aB7DAw_1747520838
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 660891956080; Sat, 17 May 2025 22:27:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9731119560AB; Sat, 17 May 2025 22:27:12 +0000 (UTC)
Date: Thu, 15 May 2025 17:53:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/27] virtio,pci,pc: fixes, features
Message-ID: <20250515215303.GA423606@fedora>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eQ4e/zMsR79EYVUU"
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--eQ4e/zMsR79EYVUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--eQ4e/zMsR79EYVUU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgmYj8ACgkQnKSrs4Gr
c8iweAf/RQCl2IRFATP8SqEBjTlyal53rJSWNP2iJF17Sl+AWoOE0OAeckwB8ZOW
xVKcDSru7Izcrj5JeMC1MNDcoL0M+XB49DMXo1laLEYG5BuFYgHLfpc5M7wz9qQR
FD83JtfbsjkxURvG3zdqCmPbE5cX999wXVTR0rFpI4WQOIPAI6cidf/+FnHa/wHj
Ma4tzs1/AQwYAL0PX6r/kdAG5bA6C5j0UOUUnIei6tKj7q7weE/fRNzzhNb7M0/C
7bYTuZgmACgDIFIySDHt7AmLIV+KCMLTjlMfx5xol0DgYDYmCYIg04qS6JfyCpVS
uKEyxTq1n9Hgn9oCMppiZlcgukkMdQ==
=BJub
-----END PGP SIGNATURE-----

--eQ4e/zMsR79EYVUU--


