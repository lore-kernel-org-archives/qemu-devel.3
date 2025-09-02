Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF893CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 14:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRdT-0005pq-Et; Tue, 02 Sep 2025 10:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utRdG-0005ii-Ii
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 10:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1utRd8-00040T-US
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 10:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756821893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=27FljAt8ZgnHBaHsGm/oVGEpRbHzo1W6WqsKJicY7Co=;
 b=aZRNpmEffNh7VyuLicfOzndX96E1de7zJL2bCjqINuYXOk99CdUtjcskHc1WCB5lpZkKzM
 UJBgOVtYhUhnWQTIvyUbomkCR2MJQYRKt+e7i4yXbp8jd1BbxiN2hxHhqBPToTV+9L5+x4
 yewC2HTVs9zAoXHeEzjxyVnn4HNc+ZQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-EHE_RY8AN6K6UBR2AsQ1aQ-1; Tue,
 02 Sep 2025 10:04:47 -0400
X-MC-Unique: EHE_RY8AN6K6UBR2AsQ1aQ-1
X-Mimecast-MFC-AGG-ID: EHE_RY8AN6K6UBR2AsQ1aQ_1756821885
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CC4A18009C7; Tue,  2 Sep 2025 14:04:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F47F19560B4; Tue,  2 Sep 2025 14:04:44 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:04:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/3] docs/devel/style: Mention alloca() family API is
 forbidden
Message-ID: <20250902140443.GD80770@fedora>
References: <20250901132626.28639-1-philmd@linaro.org>
 <20250901132626.28639-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BiY07yRuXfrm8PrN"
Content-Disposition: inline
In-Reply-To: <20250901132626.28639-4-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--BiY07yRuXfrm8PrN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 03:26:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Suggested-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  docs/devel/style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BiY07yRuXfrm8PrN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi2+XsACgkQnKSrs4Gr
c8iAwQf/e8ZkuM4Kmn7cSoCj+cUMi2jtFYQWeKJq0Y7z/9BLtCqV4pNVCJUKcLpv
9D3937e+5nMqErDCuQuGC0JT7T+NIC0TiO5CwKSgSJG/e+S8J/btrOE09mAVnS0i
pbXGPSWQHxgoM3tDIB56vRfwWBP12VcF55grM+UmCHKupVaAgVKt2A8S8HmbEYgL
wpSS1vIG4Ya3xLfaZjWs2cJka206MzLv9GeDkxw+Jc6jojFgfn0R2oCVzsyFU76Q
ldfVimbD5pNZkfjhfOnn4INZxl1aGi+Lt96RPZpzAOzKz97CfCPd3L00KrdOIBYp
cXJcOTMsF3f/iX5ShnKS3EyWDJHoaA==
=SKK2
-----END PGP SIGNATURE-----

--BiY07yRuXfrm8PrN--


