Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A40C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kWU-0007cf-Vf; Fri, 04 Apr 2025 13:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWS-0007b5-MI
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWR-0005Cb-4D
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743786482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OElD+krLtMsbvhdE43U353lbBhr0u9U2oMfp1QpDYP8=;
 b=FUByfYt6gfesj+VI7n7gf/W4bQSM5SRxFF4ob/KY1EnS66WlR/ChzGIbQusbvaQGQ30vE9
 NJOgQl6JV1c8uRV4HPJcEhUHwvjPU2XAogD2N9JOBYqqq9KLIQ/IPlv7wMB562wcJ2Tbmr
 ghJxDLg+Bv5KIu0z776b5BXys9zONuk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-IbSjsiLKMYunRWtv1qpNSA-1; Fri,
 04 Apr 2025 13:07:58 -0400
X-MC-Unique: IbSjsiLKMYunRWtv1qpNSA-1
X-Mimecast-MFC-AGG-ID: IbSjsiLKMYunRWtv1qpNSA_1743786478
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD16719560B7; Fri,  4 Apr 2025 17:07:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49DAB1955BC2; Fri,  4 Apr 2025 17:07:56 +0000 (UTC)
Date: Fri, 4 Apr 2025 13:07:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/2] virtio,pc: fixes
Message-ID: <20250404170755.GA378925@fedora>
References: <cover.1743715021.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="g5R9ChSU49FaLTLZ"
Content-Disposition: inline
In-Reply-To: <cover.1743715021.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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


--g5R9ChSU49FaLTLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--g5R9ChSU49FaLTLZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfwEesACgkQnKSrs4Gr
c8g7MwgAsyrheXAAF8+58Jd56qZS62LIwpZugMAV+OvRDxznTDI7lLrVQoBqxdt+
rJjfymjgaPShAJRh8p0BjfMruZs3CBlsrp6oPJaXxNGp7DqnpQieXqfPbWfIkilt
11U4EGSPi8WATTWteALsVK/uBUUz2wINg892VnClIPuuK9+kFDNvsO3IkXOijnxr
A6uMDINst/uWmYGDECRpMSFhUhwK9yyY23NUKElHXspr0pHaceiWD886zgjd7HxY
nG4N0BCW9CtbmTL5RwZJ727DQSa24lEs22Mg8RHr1FggfqV7hW8aHxhF00Dg0ZjR
STqKGAPQtCT2PDiruRyf+H0LBLEzNA==
=uTvF
-----END PGP SIGNATURE-----

--g5R9ChSU49FaLTLZ--


