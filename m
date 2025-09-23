Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7859ECAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18MG-0004jU-68; Tue, 23 Sep 2025 15:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18Lm-0004SK-O4
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18Ll-00050G-6S
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758654412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4wIwVyTfAHz5VzUvMmK3We811ZhsTFm5hflhxZ1hMOI=;
 b=UoOv64tYl6Fg+GxwYW/9zedkEOUEt+0B6XQasZv3RIWJ8oFG/nJkG/fyqg9xxF3DuZlDp3
 ApmT77XaW3Sfu+GeOhZ6P2MKfCovk01y2jTsH1CuI+2puWRCNirTc8RNMrlZptb7XKd02A
 2H/8H5uA24bzUzoBrBUY7YwZAMirigw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-SlUTlC8aOgWqs2Gi50UVcw-1; Tue,
 23 Sep 2025 15:06:46 -0400
X-MC-Unique: SlUTlC8aOgWqs2Gi50UVcw-1
X-Mimecast-MFC-AGG-ID: SlUTlC8aOgWqs2Gi50UVcw_1758654405
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0923180057A; Tue, 23 Sep 2025 19:06:45 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 348881800451; Tue, 23 Sep 2025 19:06:45 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:06:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 04/16] tracetool: add SPDX headers
Message-ID: <20250923190644.GK509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wcJ2w7uL3S8Cr6iP"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-5-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--wcJ2w7uL3S8Cr6iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2025 at 01:25:24PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py                | 2 ++
>  scripts/tracetool/backend/__init__.py        | 2 ++
>  scripts/tracetool/backend/dtrace.py          | 2 ++
>  scripts/tracetool/backend/ftrace.py          | 2 ++
>  scripts/tracetool/backend/log.py             | 2 ++
>  scripts/tracetool/backend/simple.py          | 2 ++
>  scripts/tracetool/backend/syslog.py          | 2 ++
>  scripts/tracetool/backend/ust.py             | 2 ++
>  scripts/tracetool/format/__init__.py         | 2 ++
>  scripts/tracetool/format/c.py                | 2 ++
>  scripts/tracetool/format/d.py                | 2 ++
>  scripts/tracetool/format/h.py                | 2 ++
>  scripts/tracetool/format/log_stap.py         | 2 ++
>  scripts/tracetool/format/simpletrace_stap.py | 2 ++
>  scripts/tracetool/format/stap.py             | 2 ++
>  scripts/tracetool/format/ust_events_c.py     | 2 ++
>  scripts/tracetool/format/ust_events_h.py     | 2 ++
>  17 files changed, 34 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wcJ2w7uL3S8Cr6iP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS78MACgkQnKSrs4Gr
c8iguwf/XAhqhiiFJj1ejYvDGz2bEQDl0xqGUlXrDVKMyWZiamTTKxQLylrxv7Jf
paymQa4841XY6sWPX+UnR41I/zVzDz6kgKZ+LToWEf8nIQ6PQQrSyuvUGfPYTinN
bMN7LRxCXtFtFhlj6bTIgOSxbbbxnswyRD+BfLqsEyRfHL0AsqIC+ajVgXjSUk8h
DPIVQLnC58kYG3lKbUC3iBPxg5NC9ekLSptRk+NbbrGSgCuwt7V27Q8GMCbbPGvv
XVZrBo50/LLkftdB12OtDnDG8pc0qLRbLLzMBrTNQ6KWf5f1pJykcE9W0KIlAyO8
A+/opXPGT0yDnSq820ZsGe561t+oTQ==
=0gvv
-----END PGP SIGNATURE-----

--wcJ2w7uL3S8Cr6iP--


