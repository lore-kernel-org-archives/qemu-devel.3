Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18L9-00048o-I2; Tue, 23 Sep 2025 15:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18L8-00048f-ED
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18L7-0004xt-1U
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758654371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tRbFUSzFBI+qPIDWI2aUbtY69YtQcqiHBjgwbbnsgI=;
 b=gV80VLWLmajd2W7VHGIZL3ydq0QXs6TLQsoysTkmC3ImZRjsohlz6OpkVidGWL1Cx+tePn
 lOSQwWr0BT/8UfdRNf9azWPyudG8HtQz89J673eWQ0DWJDDmXs2IsQAhCJJA073XEEKzwB
 PriaWO/UPPlXkYl58Z2nmWcWak0IEcM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-qNx-YlcLP_6810EEUeluEQ-1; Tue,
 23 Sep 2025 15:06:07 -0400
X-MC-Unique: qNx-YlcLP_6810EEUeluEQ-1
X-Mimecast-MFC-AGG-ID: qNx-YlcLP_6810EEUeluEQ_1758654366
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 744D018002CC; Tue, 23 Sep 2025 19:06:03 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 996501800446; Tue, 23 Sep 2025 19:06:02 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:06:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 13/16] log: change qemu_loglevel to unsigned
Message-ID: <20250923190601.GG509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MHhzXeq3wkVegLf2"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-14-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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


--MHhzXeq3wkVegLf2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:33PM +0200, Paolo Bonzini wrote:
> Bindgen makes the LOG_* constants unsigned, even if they are defined as
> (1 << 15):
>=20
>    pub const LOG_TRACE: u32 =3D 32768;
>=20
> Make them unsigned in C as well through the BIT() macro, and also change
> the type of the variable that they are used with.
>=20
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/log-for-trace.h |  4 ++--
>  include/qemu/log.h           | 44 ++++++++++++++++++------------------
>  util/log.c                   |  2 +-
>  rust/util/src/log.rs         |  2 +-
>  4 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MHhzXeq3wkVegLf2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS75kACgkQnKSrs4Gr
c8hzOAf9GjnIFPFd/2BE0YQwbikQZw2M+tXHVhnM0LOc8K5c1Gj69sBv7XqBInp5
mrqbRMb1Cr3/juxyqkKIR3po3XurBSlQkUoD6kAeZQyex8OZN+VTkD8sMS0qbUyH
kKnf8ttKTwAvV2Sip8J2feEUAM+IQdqZbEfZ5cW6Gl1xZ41ZHKQ9CwRbHDIVwRc+
1gIWpm2CaSHCMkjcyUh3CQre3ENviW/QlvxFvho6dT9g+UUthxqRC1nlN+MHs9yl
bXkodKaywmqZx7c4pfBA+Wj8RWiuiwPnL1Vqe+sbXijhis4jEsM7iBHAXQBuo2rz
swvDvgB0PcQiqs1ToGnTC/qu/jW02w==
=Jb4K
-----END PGP SIGNATURE-----

--MHhzXeq3wkVegLf2--


