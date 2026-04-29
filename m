Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7B0CD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 16:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI7hB-0006jc-3m; Wed, 29 Apr 2026 12:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7h9-0006ih-A3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7h7-0007F8-Qe
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777479805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DAGBE80q9SqI7ssAboX+DM0YVNqAaIY43irOrJW5o4=;
 b=OfonulCvihKOSTo+Yp5lUCUw0Dv3I9kljqC3TZAQeShhmm5eOd8d43wneYsBW4T2cJ7Wq1
 eieKKeRF8uol/+7qxXVrDoQGwUN9iBXYZybsk7G11rd4GwOXukWfAwZ29jLOI7LFEwMmF3
 NGOYtukKqDIeA04wmK6jKszDyOBs2gI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-w2SGK5QxOFe-ThqRicCL7A-1; Wed,
 29 Apr 2026 12:23:21 -0400
X-MC-Unique: w2SGK5QxOFe-ThqRicCL7A-1
X-Mimecast-MFC-AGG-ID: w2SGK5QxOFe-ThqRicCL7A_1777479799
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CE8418002C6; Wed, 29 Apr 2026 16:23:19 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5B761800480; Wed, 29 Apr 2026 16:23:17 +0000 (UTC)
Date: Wed, 29 Apr 2026 12:23:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/51] riscv-to-apply queue
Message-ID: <20260429162315.GA121017@fedora>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wo6xUR+5Sot3H/cD"
Content-Disposition: inline
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--Wo6xUR+5Sot3H/cD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Wo6xUR+5Sot3H/cD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnyMHMACgkQnKSrs4Gr
c8harwf5AfgV0QW6TuJAh6F+XXIdW3GWsvmrvae5ozQLHIrkuAIfpvY6dvSCy6Jh
Oknyajz55vKOc9YtkXaI7uB32P56PaQtlbXKonWeExZYkX2Vy4XYU/SIZWjm5VIl
tJsLPV4RUGGa7vDaA4G5EO2bC7LXuWf8k7mMZcbnfKix0BzCsFeyUBrwAb42PUSS
/ZjSKeDYsibusY6/rrn0IYZxS/wHcF7YBcBgDiV64SaySqdd2ht7UHfXkv4wKE++
WSCO2N0ODcMjVPUbYeBl10Z8l7l2XjjZisTvZqJd11cMPfXxDteZWWu+sc3RoEPi
nNwdzVcjXR1be0aDXswTZNh5zkOwag==
=ho7Z
-----END PGP SIGNATURE-----

--Wo6xUR+5Sot3H/cD--


