Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D20CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbOA-0002Xt-EJ; Mon, 08 Jun 2026 10:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWbNv-0002R3-Md
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWbNt-0007fb-4R
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780930523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7T/NfWiietIVW+ipAKXO6ZTIKkHlqaSWK0tMihLJ7k=;
 b=Ewr2FRy7pcnMSHw0BY2jywSawpuHusbRbPPMvSZb2mWgM0DEuNJcL6G28nIzCndIBEuSEw
 IkUX1FqoBwPIyZlBMOS3fwXeiDFWq2HIGLHcHtl/jd8tssk2y7IfuYS+1dE4Fg6YAsqRzO
 WzL2186uij2jQ5VV58kQ+FAWYTVqk6Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-L_hsQEWhPrigIcxGgrYpOA-1; Mon,
 08 Jun 2026 10:55:21 -0400
X-MC-Unique: L_hsQEWhPrigIcxGgrYpOA-1
X-Mimecast-MFC-AGG-ID: L_hsQEWhPrigIcxGgrYpOA_1780930520
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4039A1800847; Mon,  8 Jun 2026 14:55:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 723831800347; Mon,  8 Jun 2026 14:55:19 +0000 (UTC)
Date: Mon, 8 Jun 2026 10:55:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/37] aspeed queue
Message-ID: <20260608145518.GA482972@fedora>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RzjutbiXnipWWCTV"
Content-Disposition: inline
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--RzjutbiXnipWWCTV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--RzjutbiXnipWWCTV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmom19YACgkQnKSrs4Gr
c8iAaQgAmFJCQpNcgnUDJhiqWVE1sEPYzVw6T7DOhB/th+v6atHyDpX2Lx5WhNP2
/YNpSdgyqZ11BniiunPXzF2LvJ7UrQOSN3ZeLbo5PlpbON2TcqDFutEK9TafGKjI
JxScTUzw6A9uEAjnlHNF9CnXD8cTS9/5whFXwECC4KRolAl4yFAfb3hnh+WNZt7e
Wjx/JHNFiIvbHYVc8LHx/Ior3F+3XLTV/LIPZ73VBfAA8lcqPQsmzYbSHwZbFVya
c3oaqpapiymSVdTARBinTBX5L136Jpv7M5/arXHvru4Pv9Gl54Tt0HDgpIQGNtbP
qmSQCzSv83XGdZz/LjN/WH41mIp2dQ==
=SwOw
-----END PGP SIGNATURE-----

--RzjutbiXnipWWCTV--


