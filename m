Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE4C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 18:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udvIv-0007zw-RG; Mon, 21 Jul 2025 14:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIu-0007yi-8g
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIr-0005EO-EO
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753122716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wTvPAVsJ9QkWS5xYlE+mCtGQD1PM8ccq5tQytE8XGdw=;
 b=alwe8+jRR/lbLR1IRIMuEF74ra33Fm1h61lqziZ8S4/ANls6xv44VMhLUn7RcdWpfA3SD6
 6q3MTSazAdPNtvsj7J5WP6kJ6xkOyxpDoP7jjKMhUIvfZAoTj7CBU8I2/jwe5y3hNNVWDU
 HyzKV8fVHZe5ZYGZGqnSrGPdOjCDwU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-yz_0J_MSNgWDtphACLWU7g-1; Mon,
 21 Jul 2025 14:31:53 -0400
X-MC-Unique: yz_0J_MSNgWDtphACLWU7g-1
X-Mimecast-MFC-AGG-ID: yz_0J_MSNgWDtphACLWU7g_1753122711
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E50A19560AA; Mon, 21 Jul 2025 18:31:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B179219560A3; Mon, 21 Jul 2025 18:31:49 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:31:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PULL 0/3] Display 20250718 patches
Message-ID: <20250721183148.GA78037@fedora>
References: <20250718194349.65771-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OdrFdkD7PGLosqMK"
Content-Disposition: inline
In-Reply-To: <20250718194349.65771-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--OdrFdkD7PGLosqMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--OdrFdkD7PGLosqMK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+h5QACgkQnKSrs4Gr
c8gH8ggAoxWwB3W04TvW02BmX5+Kv1PQAJozRCs/WykOBbBsUbdyKHb30MrrtOXI
UPx8mjN/eAtFPoOkZSz7XJMI3dIBLetgvPpq+aM5clzizm6KdNuCUYG56YY3ZOh7
o6SQ61fWdFpKhaB1Hjil3DOHWWoZz807hKw72RUZkPgn4Gx0Ol6V2TRKxLWM2z3w
8/rS2TvVUPycgV1ajFl3ECzslmtqR0bSKULFnWxIym+fLvMzYoATHV6ZHX3YI5LV
V+A4LK8E9hSFGiPRN6WzNya6RJ1NN7Fq31poyPyfTNveW0oOgqWdBlPPJ5q9i7BO
wTS25WFeLUcKslWlE2pmChFd2aF5yw==
=8RXp
-----END PGP SIGNATURE-----

--OdrFdkD7PGLosqMK--


