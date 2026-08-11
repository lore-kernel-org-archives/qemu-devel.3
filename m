Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF19C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtuAU-0004qB-UX; Tue, 11 Aug 2026 17:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtuAQ-0004or-Gt
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtuAP-0006Ip-1R
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786484266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ITpNdiw1+3O6zvBagA9GnrU9EpYYgVjP77ej9AyUl5g=;
 b=f7ZyuWFIxWFRPEiyYUBaT3kjuYo4Ui2Fy5a23mZkZgQ9XVvJNbrPo7jDsyWXdsq8+edsQ9
 QV3C3f8kwFvy4sie+gBYpKBf8MLmZsEa0W6On6B+/owT08Jbi282ykD99csBYXbrCOtjdl
 l029UGgm+cY1zSGPKQGDx3uUeVjkANE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-Rcj6CmA0Om6az3LOzFrO8w-1; Tue,
 11 Aug 2026 17:37:42 -0400
X-MC-Unique: Rcj6CmA0Om6az3LOzFrO8w-1
X-Mimecast-MFC-AGG-ID: Rcj6CmA0Om6az3LOzFrO8w_1786484261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BF7118001CD; Tue, 11 Aug 2026 21:37:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63CA21800346; Tue, 11 Aug 2026 21:37:40 +0000 (UTC)
Date: Tue, 11 Aug 2026 17:37:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, deller@gmx.de,
 Laurent Vivier <laurent@vivier.eu>, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PULL 0/3] Linux user patches
Message-ID: <20260811213739.GA201026@fedora>
References: <20260807132652.9687-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BtZ30yAf3Jejpr2R"
Content-Disposition: inline
In-Reply-To: <20260807132652.9687-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--BtZ30yAf3Jejpr2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2 for any user-visible changes.

--BtZ30yAf3Jejpr2R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7liMACgkQnKSrs4Gr
c8h4SggAhrKkth/sS+tCLv8lLD9TesVCCZEKnNmOEkSF4WNYjfZTYRRfcPxzKU7C
6Nd0rkWo9BFx+/g6yWXU1I6hJzxcPWVxt9YvJ8uWos/P3hqiQHy6QZOQSIspTIgQ
UHWr9j370/ygh+SxJIWUV1J3c0+3ro8HnVf+5dPRewpHupOV+vHVVVyoqbE4hj/5
Itmm1zWjQGQG7LU2ABITjZOZYGz8fFJRCTVk2/mRfuRpL6f9lrjBTbHGA93MC6JX
pF1mmkzKrD8L2xwROAGBolhvZuya3RkoS94Lj8MJ5OTVAaoOOK28q+M5SutN9NZ8
BikiMk6FBkslXOtEde360K2XZ8sw4w==
=efKy
-----END PGP SIGNATURE-----

--BtZ30yAf3Jejpr2R--


