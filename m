Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D2FC02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 22:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYY4c-0003yE-Cs; Thu, 16 Jan 2025 17:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYY4U-0003xC-3w
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYY4S-0004Iy-JM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737065435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwnAYuxlx5xf1B60NkwIWRxNP2pvyGw7Xgb6WsElQI8=;
 b=e8DYzoiRBzKgWr1xAXKjxAK/2Fel+U+CcRz3roOTZz92KCZ5CQ+s7RxCbA6zgVvky+VOHR
 bQ2SrqUqfqQsZBamMjlLjaigfIQXgvidIPUHCUBwIIF0jiZh5vCeQ5WrS7OrdImm7ogcci
 vKI1n6dxEI+cEWjc/eC+AthQolp7Rxs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-3FO4xjfuMo6kxm7o9chN-A-1; Thu,
 16 Jan 2025 17:10:26 -0500
X-MC-Unique: 3FO4xjfuMo6kxm7o9chN-A-1
X-Mimecast-MFC-AGG-ID: 3FO4xjfuMo6kxm7o9chN-A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 109501956083; Thu, 16 Jan 2025 22:10:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.180])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 191C6195608A; Thu, 16 Jan 2025 22:10:22 +0000 (UTC)
Date: Thu, 16 Jan 2025 17:10:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PULL 0/8] loongarch-to-apply queue
Message-ID: <20250116221021.GA378400@fedora>
References: <20250116021710.251648-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OqRtuwazz0qaMS8V"
Content-Disposition: inline
In-Reply-To: <20250116021710.251648-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
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


--OqRtuwazz0qaMS8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--OqRtuwazz0qaMS8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeJg8wACgkQnKSrs4Gr
c8jk6AgApBILBwY5I2cYKP7GNxbn9XmYxoCRrAoRLak3UdPFbe3IaS7ngwLFbqxV
26NKNgxEiGj0iujDhFds2R4/sgoEZeEmuuSV2YOjVdUyX7+EfNQiDGx93ToN272D
9f6ksqhaNPx2DAGLu8KqKfoBBJLhrBzVY6/1zG0xt38cT+MA/0pJ+FpUj5DLD/Xp
xlgcp8sfoBcDd3qwqNAYLR7ig+OslwNpYDJwuQhWmVp9M1eJAfjU1no6Sss37VEG
qtDgEE5jSVrmu4SxgeWmluEWBD2hxxaMIk2qtXwsJ68FsNUrDolCZg/sYwnTTv9y
zcfsCozpt+I5riRbmy0yjFxfc+7yXw==
=d7jO
-----END PGP SIGNATURE-----

--OqRtuwazz0qaMS8V--


