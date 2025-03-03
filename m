Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FF3C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4gD-0002rS-Et; Mon, 03 Mar 2025 07:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4fo-0002iB-BM
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4ff-0004Vb-NV
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741003998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVLFoQhnn80/7AzjMiFKIBFl944ZJNEs5MACQqM3grU=;
 b=ZXcsfCZduaFXcj878CUaGLMnjXooEs79L4BBlIncZuGwiJQlWvn8I/0+Y571DouICNR+F9
 UmYLHboxuIAeBxfDzVca7Pq/vTOi0z4yd0jDipnhRD3y8qJKGuJnbSdLsp5CihSBmZPTDW
 6IC2YxgMenAJG2B8+MG6eypmKQmijw8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-YSzQx-fQNDOP4Q0AY0nojw-1; Mon,
 03 Mar 2025 07:13:17 -0500
X-MC-Unique: YSzQx-fQNDOP4Q0AY0nojw-1
X-Mimecast-MFC-AGG-ID: YSzQx-fQNDOP4Q0AY0nojw_1741003996
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E2B6180098E; Mon,  3 Mar 2025 12:13:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDE8319560AE; Mon,  3 Mar 2025 12:13:14 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:13:12 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/43] target-arm queue
Message-ID: <20250303121312.GA215722@fedora>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ujyBgLhIoQo6XfiF"
Content-Disposition: inline
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--ujyBgLhIoQo6XfiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--ujyBgLhIoQo6XfiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfFnNgACgkQnKSrs4Gr
c8grsgf+Pq87IBxvQRah/0UY/MIaPYFktD+acU9jXXrVxE1iH5w3yz0wAJibvlRN
uxj/ZFT7T02swcju0mRhiH6832RbDXs+ytnPTzgjGprQeSb+d8VHPgGsrYWuNOPb
WVKrB5RMkUxusVBpxBMEok3vPSqqqtmEcFr7083/0sKnuSLdYm5wpK33aA13wudx
fCT27WWbeM1xdXYpId2BDpU9bt1iKFkWfHmMQEhK1m5obMfqrNb/WI7CU4UzgMyu
ohVfn4yqNJmfrwugtLrEFweFAVdehBXRittsGPiYHoCzCaKJgPO9UskBoq6FjY0S
c95zDHWaT+4bcXN8TZ/9UHm4Uk4JPA==
=8QFt
-----END PGP SIGNATURE-----

--ujyBgLhIoQo6XfiF--


