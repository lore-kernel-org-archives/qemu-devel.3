Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AA0C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 15:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFEcp-0006Da-Sq; Thu, 06 Jun 2024 11:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sFEck-0006Cv-6b
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 11:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sFEci-0006fP-N7
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 11:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717686110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMpJt/2rQ+8MPqhWK71l7GkoTe+bNNKZZuDisdap6Js=;
 b=O9Men3M5IIZEeh6mVaZzG7jfxQixxKOUpRXUm0ZnRwyZvLosWmieOmDy4mFUV07vdBJ8Ra
 DO/sKAut/EcmtTC9IccrHx1xIVWNrFa/toyB3zInecbbhiA7MAMl4EEKq01qHfo8vBQO4G
 j6cmlzvm/xn1meLEQ0KxSyxZ3+CSRUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-O4FREMQhPsqqhxbgJBwWcg-1; Thu,
 06 Jun 2024 11:01:47 -0400
X-MC-Unique: O4FREMQhPsqqhxbgJBwWcg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DEA51920C4A; Thu,  6 Jun 2024 15:01:45 +0000 (UTC)
Received: from localhost (unknown [10.39.196.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7826D3001E83; Thu,  6 Jun 2024 15:01:43 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:01:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/s390x: Fix tracing header path in TCG mem_helper.c
Message-ID: <20240606150141.GA198201@fedora.redhat.com>
References: <20240606103026.78448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f7tIJsGXQQU3Blij"
Content-Disposition: inline
In-Reply-To: <20240606103026.78448-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--f7tIJsGXQQU3Blij
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:30:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Commit c9274b6bf0 ("target/s390x: start moving TCG-only code
> to tcg/") moved mem_helper.c, but the trace-events file is
> still in the parent directory, so is the generated trace.h.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
> Ideally we should only use trace events from current directory.

Yes, that would be cleaner. Is it possible to move the relevant trace
events to the trace-events file in target/s390x/tcg/?

> ---
>  target/s390x/tcg/mem_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 6a308c5553..1fb6cbb6cf 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -30,7 +30,7 @@
>  #include "hw/core/tcg-cpu-ops.h"
>  #include "qemu/int128.h"
>  #include "qemu/atomic128.h"
> -#include "trace.h"
> +#include "../trace.h"
> =20
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/s390x/storage-keys.h"
> --=20
> 2.41.0
>=20

--f7tIJsGXQQU3Blij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZhz1UACgkQnKSrs4Gr
c8izIwf/ZAzofPq7WkmKx2k74MbKT1ZSt9SKOa2Gsntr9o9YiXnDqKuRgKTyySKD
5QdSOVrSQmq20eyJ9axFZgv2YiKeLRrCPDQDa1g4GY4QEyEuWzEoTuvdNrCOUnVM
7B2kE0s8Fp2IVIMWmudV7bqa+ejxQTlUyzLPENQTXVx/V5fiSa60rw2j4a1RR6H7
ZwfAkMDvDfNmORKlc/UAWfL1XFuLks+K8AUhZosU1E/vhc7sZmD/zFlFiN7aea/A
XXaH6GsFLkWbkTe0h9ZUV2bs8ReqsYypKyKqrdxycv+vaUvNFF+/GwKKcoBc6hsn
jIh598yrF127vSVxZMSBIRi6qMcxJA==
=kFQd
-----END PGP SIGNATURE-----

--f7tIJsGXQQU3Blij--


