Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FA1CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 19:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urLZU-0002et-92; Wed, 27 Aug 2025 15:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLZS-0002eS-NM
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLZJ-00059L-II
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756321940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i3vDzTcRRmhCvYWr0jBKEoR1Wxy/jTOJ9KlFs0J3Lw0=;
 b=eWQMWBhF+uY3bKYOqgpxQWParNszO3MlmoY0OleHM2GaWnl1F0I+OHV+HYFj5KLLGXSAjE
 bYSHAiVKUpSbFRpEFDpTJug8cVb3IEChAYRSX00eIUIS3tq3C9JrFm6JQY3qhIe1fs2C28
 jAyLPJqHv68DMPcSf34ZnZXBWsKZtxQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-rFvR6QHZPwCssc5OYdH_7w-1; Wed,
 27 Aug 2025 15:12:14 -0400
X-MC-Unique: rFvR6QHZPwCssc5OYdH_7w-1
X-Mimecast-MFC-AGG-ID: rFvR6QHZPwCssc5OYdH_7w_1756321933
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3953A1800561; Wed, 27 Aug 2025 19:12:12 +0000 (UTC)
Received: from localhost (unknown [10.2.17.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 818B2180035C; Wed, 27 Aug 2025 19:12:11 +0000 (UTC)
Date: Wed, 27 Aug 2025 15:12:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints
 to ftrace.c
Message-ID: <20250827191210.GB228377@fedora>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="30H5WjGP5pKJZuxI"
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--30H5WjGP5pKJZuxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 02:26:44PM +0200, Paolo Bonzini wrote:
> This simplifies the Python code and reduces the size of the tracepoints.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tracetool/ftrace.h            | 28 ++++++----------------------
>  trace/ftrace.h                      |  1 +
>  trace/ftrace.c                      | 15 +++++++++++++++
>  scripts/tracetool/backend/ftrace.py | 12 ++----------
>  4 files changed, 24 insertions(+), 32 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--30H5WjGP5pKJZuxI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmivWIoACgkQnKSrs4Gr
c8hokgf+NxPRQnQAroRIXLcvSoqybYJoXDd5cYCi+AveOb8AIXbrgY07IanRStoz
nvAELqC3AkxEzYHNW5CZSr+EOZZ+c6LWO1o092EQ7Rmbd5i2VMWkAJ7LaBI5MSna
cdH9xWJf3l9rQNnauZL4V7nB95NoWVh6xphubT0yQGt7NilFQ/aJVS183gQ7vEsv
tkuQF2Q+9wzzpMlF5nserBsjhfzrRebTlKNpJ27+ReNfAzMJW6czpyTxdj19uHFH
DZzNc3bOuoLeUftG0Pw1pLOS8xGt30CAUpntYvi+l8SIzw9tUKafYWhqyZOiLfqI
wAcsPePkRrxg4Ib8P6binO3KLh6Jxw==
=5V30
-----END PGP SIGNATURE-----

--30H5WjGP5pKJZuxI--


