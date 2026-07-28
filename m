Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08293C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogBn-0000hl-I4; Tue, 28 Jul 2026 07:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogBl-0000h2-Re
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogBk-000234-94
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785238895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YjqPs8LgDlBXLAMTTzunk+CQQzIem0UUVzRZUtGqqUA=;
 b=OeU+vENvD4yAdhm2t9IG93JGdahgfMxaVlDEjB+XuHWdNutWjCQeUWnoUw4OqFf8kBpU9l
 /0RwymwcYLWicWtezkd+3mHynqeoL+0fgeOfYy2l595N4epw+cDBp/WoPeL/6BSTheM5Yx
 sojAQCqieIMH6th/HYeOM2GyexAA/8k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-a24XUYUzOmyYRXU-IsQzwg-1; Tue,
 28 Jul 2026 07:41:31 -0400
X-MC-Unique: a24XUYUzOmyYRXU-IsQzwg-1
X-Mimecast-MFC-AGG-ID: a24XUYUzOmyYRXU-IsQzwg_1785238891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85AB418002A2; Tue, 28 Jul 2026 11:41:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.73])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DC5A195608D; Tue, 28 Jul 2026 11:41:28 +0000 (UTC)
Date: Tue, 28 Jul 2026 07:41:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/1] aspeed queue
Message-ID: <20260728114127.GA1015940@fedora>
References: <20260727053611.1388339-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zbIKEKsL4UF/2oqJ"
Content-Disposition: inline
In-Reply-To: <20260727053611.1388339-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--zbIKEKsL4UF/2oqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--zbIKEKsL4UF/2oqJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpolWcACgkQnKSrs4Gr
c8jRjgf+PKWOlPM/VbgVkuQsiNvZjsLqqyVK0Zh24+QQkJ0ME8/bm+gK5pRe3jm5
RzMapInnVH029W9OkkVQl6qQ/AqMvWZW9tqz82vzox1/8UeVJJs34/20/aESZeFM
B2va3Ya8VkKKcooxHNIZvHIgyzQq+c2KhBvY3QJs9EskQyJL/tZG/i06iRYqvL8m
fpud4ayIV+D3sn3DR+soy4jwvu+k9SUAjyIz710SStW85cR0rtpL3QnYcvPXDcJn
ZIezByVRilA0rUmdlgdcWx6WI+7gXIzSOQz6vruIq3gc+HE15w8ll+u77/nCepSx
RxF9YLrCrmvRBFxyQiYqMlTycZFuxQ==
=kOZe
-----END PGP SIGNATURE-----

--zbIKEKsL4UF/2oqJ--


