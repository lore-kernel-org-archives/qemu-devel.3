Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5468ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 18:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Yf8-0001jU-Fh; Wed, 08 Oct 2025 14:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6Yf6-0001jJ-Ap
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6Yev-0000K2-5q
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759947179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMSmvRZScVRTJV/S2LQPdugoY6PlXkAyHCiPNXsA3jw=;
 b=Rvw/zNY32UOuhtCbzmbhBZZV4PxmAlp/+ki0GuwcWu6vKfVBsQ3WaJ6mrGbM/eBorKqOlf
 bftO/8sbrcEQ4qqeq+0f5S6J7f8dU3db1CUxOr7mW25p2i+V3CfKqNafBdO1X7eR6bnOSZ
 3GUrDX0eQnIaBV/7eVnzhUSFOm6ubK8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-IIl7qZPhMeK5dUpZBcuixA-1; Wed,
 08 Oct 2025 14:12:55 -0400
X-MC-Unique: IIl7qZPhMeK5dUpZBcuixA-1
X-Mimecast-MFC-AGG-ID: IIl7qZPhMeK5dUpZBcuixA_1759947174
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99C9E180057A; Wed,  8 Oct 2025 18:12:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16A5C19560BA; Wed,  8 Oct 2025 18:12:53 +0000 (UTC)
Date: Wed, 8 Oct 2025 14:12:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 6/6] tracetool: add typing checks to "make -C python check"
Message-ID: <20251008181252.GG181748@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0rOxspD2+hsfg9xF"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-7-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--0rOxspD2+hsfg9xF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 08:35:45AM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  python/tests/tracetool-mypy.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100755 python/tests/tracetool-mypy.sh

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0rOxspD2+hsfg9xF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjmqaQACgkQnKSrs4Gr
c8jJ0wf9GrYqLPsAmSiJCMU/Souz0qfggn3zUbKVvmAO41YjGQP8kHLj1x/mkBUG
St7MdV0z5gSCMARI25gM1GEoHunVSRiy6+u3M0yXto40ePsPdAwRUjFmcBmGZ1Cl
ykC7foecSpwbP1lX6IXATWP1WK3pYvHfLyRi7u83xXEVoZkXOfs3o+8xfSV5WccY
Cv8sckCYV2HwwF1C0TeHi7numDWviu5RqTCDtbKfyalGw/uEj9dSGtoswJxUIQ4y
j6+b+6CR/lILU0m5aSwVBAq1ih0hBN6el7XrzqNAHTaz4uCZz0fKxnccVnNJpbkG
FbOJDGwyzEJq06kMRtxet+uk7RvJgg==
=KP6K
-----END PGP SIGNATURE-----

--0rOxspD2+hsfg9xF--


