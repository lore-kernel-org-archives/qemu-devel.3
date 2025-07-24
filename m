Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB5AC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 14:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uewgt-0003S5-NV; Thu, 24 Jul 2025 10:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uewgr-0003QI-GS
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uewgn-0006VT-RI
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753366370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RJ6x6Di70KxJg+FPlhfQ75cLOQEAIdXnYRremL/hvI=;
 b=InKLfbji8YKU4doWHt/Y9qpNSpaHCed/PaRTK+VBjyKeOgQWZjpt7+5Wt2KjTHnwAd45wA
 C/PTK+BlWOkt2SEBJ9uim74+3tn5Ijmwnye0Bn7PbXmJpwxmh0UKsOjdvhslG+F1I2EMIW
 KyH/eWCyD3E0dhNS0kzKOgUe/ch+PJw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-_QKFZQDpOPmW9khVS89FBQ-1; Thu,
 24 Jul 2025 10:12:46 -0400
X-MC-Unique: _QKFZQDpOPmW9khVS89FBQ-1
X-Mimecast-MFC-AGG-ID: _QKFZQDpOPmW9khVS89FBQ_1753366366
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0F6119560AE; Thu, 24 Jul 2025 14:12:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46580300018D; Thu, 24 Jul 2025 14:12:45 +0000 (UTC)
Date: Thu, 24 Jul 2025 10:12:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] log: make '-msg timestamp=on' apply to all qemu_log usage
Message-ID: <20250724141243.GA95708@fedora>
References: <20250721185452.3016488-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PJE0//JTr7M/CeAs"
Content-Disposition: inline
In-Reply-To: <20250721185452.3016488-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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


--PJE0//JTr7M/CeAs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 07:54:52PM +0100, Daniel P. Berrang=E9 wrote:
> Currently the tracing 'log' back emits special code to add timestamps
> to trace points sent via qemu_log(). This current impl is a bad design
> for a number of reasons.
>=20
>  * It changes the QEMU headers, such that 'error-report.h' content
>    is visible to all files using tracing, but only when the 'log'
>    backend is enabled. This has led to build failure bugs as devs
>    rarely test without the (default) 'log' backend enabled, and
>    CI can't cover every scenario for every trace backend.
>=20
>  * It bloats the trace points definitions which are inlined into
>    every probe location due to repeated inlining of timestamp
>    formatting code, adding MBs of overhead to QEMU.
>=20
>  * The tracing subsystem should not be treated any differently
>    from other users of qemu_log. They all would benefit from
>    having timestamps present.
>=20
>  * The timestamp emitted with the tracepoints is in a needlessly
>    different format to that used by error_report() in response
>    to '-msg timestamp=3Don'.
>=20
> This fixes all these issues simply by moving timestamp formatting
> into qemu_log, using the same approach as for error_report.
>=20
> The code before:
>=20
>   static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * cr=
eds, const char * filename, const char * path)
>   {
>       if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu=
_loglevel_mask(LOG_TRACE)) {
>           if (message_with_timestamp) {
>               struct timeval _now;
>               gettimeofday(&_now, NULL);
>               qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS cr=
eds path creds=3D%p filename=3D%s path=3D%s" "\n",
>                        qemu_get_thread_id(),
>                        (size_t)_now.tv_sec, (size_t)_now.tv_usec
>                        , creds, filename, path);
>           } else {
>               qemu_log("qcrypto_tls_creds_get_path " "TLS creds path cred=
s=3D%p filename=3D%s path=3D%s" "\n", creds, filename, path);
>           }
>       }
>   }
>=20
> and after:
>=20
>   static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * cr=
eds, const char * filename, const char * path)
>   {
>       if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu=
_loglevel_mask(LOG_TRACE)) {
>           qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=3D=
%p filename=3D%s path=3D%s" "\n", creds, filename, path);
>       }
>   }
>=20
> The log and error messages before:
>=20
>   $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=3Dtls0,d=
ir=3D$HOME/tls -msg timestamp=3Don
>   2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 lo=
ad creds=3D0x55d925bd9490 dir=3D/var/home/berrange/tls
>   2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path cre=
ds=3D0x55d925bd9490 filename=3Dca-cert.pem path=3D<none>
>   2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access creden=
tials /var/home/berrange/tls/ca-cert.pem: No such file or directory
>=20
> and after:
>=20
>   $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=3Dtls0,d=
ir=3D$HOME/tls -msg timestamp=3Don
>   2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 =
load creds=3D0x55bf5bf12380 dir=3D/var/home/berrange/tls
>   2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path c=
reds=3D0x55bf5bf12380 filename=3Dca-cert.pem path=3D<none>
>   2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access creden=
tials /var/home/berrange/tls/ca-cert.pem: No such file or directory
>=20
> The binary size before:
>=20
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
>   $ strip qemu-system-x86_64
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64
>=20
> and after:
>=20
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
>   $ strip qemu-system-x86_64
>   $ ls -alh qemu-system-x86_64
>   -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  scripts/tracetool/backend/log.py | 14 +-------------
>  util/log.c                       | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 14 deletions(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--PJE0//JTr7M/CeAs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiCP1sACgkQnKSrs4Gr
c8g0ZggAmIpsIsNeefBVqWMbE9qgLjVLK+EI5QZB+a1Ptklb4y6qaYLEpNqdR/DR
f8mEALA7q9TvvxtySxFPHTH/5eIyZipcQW/jiHBm/dQuirfuyYJYcFYueBGJEOO9
+xJ/dBZibEzNdhQ8+gmp1s/lsIbWJ2gQ0el+eFfa1mODJpSneanHi6aa4ba0KwFh
cRvxJLk0q7I3xlL6hycxk0XjsEbBIfHOEf5HjOuOFXJt3MsrKW9VSp7rqCrgArtV
pgkQMRVnNOzrw1J02S/sMuefR5eLfLSBDwG4qA0dHS0Hkzn+95hZSQ5fF8UwWMjW
xfGG9Hm3V9GnWBt+c/KtUB+jlqTnBQ==
=TwXQ
-----END PGP SIGNATURE-----

--PJE0//JTr7M/CeAs--


