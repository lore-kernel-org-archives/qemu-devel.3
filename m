Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294CDCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18nJ-0000mU-AI; Tue, 23 Sep 2025 15:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18nF-0000kM-Sz
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18nD-0008Up-Rq
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758656114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNH1VzqHcMIgq7gX9/G8zt0MXBmbRk0h0n8ksBlNWNY=;
 b=C18Zoh4qfzxZ6S7qfv0xt5gRksxbgWp+4cS3MLe6wjzHjVSqNxHdC3QjG7OoOZfWAyjbsW
 RdzuKaKVdly1QuO40s/0kc/9FIuGzlR+9aFT6/RGEtMZPt+3u0tnV82Pz+XAbHdAJ9sRhV
 oCYgzkhkgbBGUOOOkp69ftlo1U6ti1w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-VnMqvAvfMWWWmmNi1MqyIg-1; Tue,
 23 Sep 2025 15:35:08 -0400
X-MC-Unique: VnMqvAvfMWWWmmNi1MqyIg-1
X-Mimecast-MFC-AGG-ID: VnMqvAvfMWWWmmNi1MqyIg_1758656106
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1FCB1956053; Tue, 23 Sep 2025 19:35:06 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EEC91955F19; Tue, 23 Sep 2025 19:35:05 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:35:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 12/16] tracetool/simple: add Rust support
Message-ID: <20250923193504.GO509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6Qxq3Vl7FdcjN3f5"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-13-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


--6Qxq3Vl7FdcjN3f5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:32PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/backend/simple.py |  7 +++++
>  tests/tracetool/simple.rs           | 40 +++++++++++++++++++++++++++++
>  tests/tracetool/tracetool-test.py   |  2 ++
>  3 files changed, 49 insertions(+)
>  create mode 100644 tests/tracetool/simple.rs

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6Qxq3Vl7FdcjN3f5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS9mgACgkQnKSrs4Gr
c8jXXgf/ZY2KWS9vARLF3e3IcpuoEKYGr1rGCG4HUsS4RqpxY8PxtAYPdT3k4c3b
i526vcuj+8SbrfwbSKoUVsFbXJyhW8TWfcgb2k8tInccFnYsLemGpI45ttEmCv3S
SgJBoPOrBud3XnpM9YMZj7ptFidmSmdbEH4jkBAUi/3E6XFCStvBAIDGimgA+B9B
e5oSYLOSaOqT5eP+L+uoZpP/he95Y4ekqIsWqX6Na0ILdnBQpAtpwyERRWlfZhMT
GBMdhuj3MMJ68rSQuwKL2434t2LpefllLd0quiHErGD/CY4YTJ19iUxoX6VHmQlv
QSJHuDyF2rHCw9NbzT4/Okp926vY/g==
=L3yK
-----END PGP SIGNATURE-----

--6Qxq3Vl7FdcjN3f5--


