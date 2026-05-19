Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CE4CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRPb-00073O-PV; Tue, 19 May 2026 16:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPRPX-000705-7E
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPRPV-0006R2-0J
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779223887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xPDEAJ/Huyd5Xm0yGBAJRl+SVu8u5mfmAwhyD48fGuA=;
 b=RoStidRXmcYmTvQeT6CB8dXBUFxdnflxgHemWEYCrAgvEgHI5dBUNb7CSeAFpS3PLXxZAY
 6AUd3T6W+oVdRfAKzpL4SO8RlgvmFJtjGtZJSIqhnNooZb9eHq19u5HCBCpgUKUXw8Hibc
 w48HhHL6yP0gj2Mln7t/8pdO1FtNY3c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-3kYPRnZKOAW2uE4I4Jcaww-1; Tue,
 19 May 2026 16:51:23 -0400
X-MC-Unique: 3kYPRnZKOAW2uE4I4Jcaww-1
X-Mimecast-MFC-AGG-ID: 3kYPRnZKOAW2uE4I4Jcaww_1779223882
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5072F1956089; Tue, 19 May 2026 20:51:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB1F619560A2; Tue, 19 May 2026 20:51:21 +0000 (UTC)
Date: Tue, 19 May 2026 16:51:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PULL 0/4] Linux user next patches
Message-ID: <20260519205118.GA340812@fedora>
References: <20260519140531.11931-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qzaSt4fSggGwhr1R"
Content-Disposition: inline
In-Reply-To: <20260519140531.11931-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--qzaSt4fSggGwhr1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--qzaSt4fSggGwhr1R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMzUYACgkQnKSrs4Gr
c8g9IggAwDHwXJPO3Y+1kCmuL4KI8+ISZQTm/OBsM7UGjrk2Ss4hf4wx8Ri6KtPd
zvCaU9qjnBB+rGrmAc73X06HLS4xgsv1fHLQOdJr2yWz/4ulAUYqSqKOzzLvV5cV
2fF4oEUCziSzI/TCefUZIbBvEG+ig0wFGGAGYjG01sVpMQKUaye+G/PGTP5tiAF3
DTkuxh2eLC+95g5jqLxc9iUtl+w5l2FEpNI5FYldzmsCxvVtmqRLvYe+JTM+sVBD
sjwO1QBkT9xNnN3ifq+B4AjpjWyo1ODV9ecHk8T6ggrlWTKDyAEi6Iy3NvHT/uDf
xjm/lvxmKuiLFvk256+p59NgvjJL/A==
=SpTl
-----END PGP SIGNATURE-----

--qzaSt4fSggGwhr1R--


