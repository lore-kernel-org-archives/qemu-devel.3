Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252D4C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXka7-0006Uz-He; Fri, 04 Jul 2025 13:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXkZx-0006Sk-P3
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXkZu-0001BH-3L
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751651517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjiK6kaE1qtFz4diZUL/mN2Os1v4hiX8AjdvH4UbaGw=;
 b=dMJBQoSrLr9gnsEERFID/VfFqWmXyBufMTgnSYbXJ8qiyceQQmaOaJvuop77KvmVwEC2m7
 ngrPHDT7RHq51PtHKdV+Ps+AOQXuv3R4qDussofw2/sIhI7ElgGU2KFPoMFk5affc600RU
 fIbS3LxKPSPvYBuI8kY6PKcAYMzyLLc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-KxFCN1PLNOKSI5s-6X8V7Q-1; Fri,
 04 Jul 2025 13:51:53 -0400
X-MC-Unique: KxFCN1PLNOKSI5s-6X8V7Q-1
X-Mimecast-MFC-AGG-ID: KxFCN1PLNOKSI5s-6X8V7Q_1751651512
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C729D1956048
 for <qemu-devel@nongnu.org>; Fri,  4 Jul 2025 17:51:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C86F195E753; Fri,  4 Jul 2025 17:51:51 +0000 (UTC)
Date: Fri, 4 Jul 2025 13:49:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/27] vfio queue
Message-ID: <20250704174946.GA95142@fedora>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gX+GdZYnB9BwA8dt"
Content-Disposition: inline
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--gX+GdZYnB9BwA8dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--gX+GdZYnB9BwA8dt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhoFDoACgkQnKSrs4Gr
c8hG0ggAmIJT5bHXhi6/ipdYpnwts0NznYPJZFDCAEFeF1F9BbpcBV5i+b1YJ6Z5
bQuMJJuk/XcSCYZseTjr7BKT9YdskzPvMbzxc4PekPnGWSyhM2lBg5kvf5bXjSFh
qphlE7YSuKWRJXXP7ly+S8boBfXvkF56+mZ1YoWQYo2PlFsPOwj58m6T7PTI8zLt
HaeUrACF4mclzpO8v2Yr9ODmk5qkFKzAtWojSl24ACpzgGfQ3ENp973sulJIJAAq
Drokhb25vM+rX3lsh14vtdkN4NaiY/F57ft7TvMCUf/8BVduzF9IRGJqXY+46JsO
C9VDbYBOvXtiloTJ277FGsg4Qe3vhA==
=9OT0
-----END PGP SIGNATURE-----

--gX+GdZYnB9BwA8dt--


