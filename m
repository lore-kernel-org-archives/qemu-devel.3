Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E254C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 19:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk6FZ-0001fP-0n; Thu, 07 Aug 2025 15:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6FY-0001fB-4M
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6FW-0004vy-HV
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754594761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f70xDyT8u8EinJb0yKmoc7lTU2bRoPIfsbirXyERTo8=;
 b=B/i+4JQ5G8yH5yspxxU8KxQmDxKvBhCN1OJZurRZBdLZyjljmTqW25FKTZGblgrmAoWnuA
 p8d58/B/bOvz/M0kC2dKdTidUB6iUqChg7FlMB+jTYW9WHonS3s5oNvFydHm7+/yBEVWYo
 8kQTqhCz6p1z3eiM1qerl6YHhLyuQ5M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-CDNwwD3UMGe44zNYwcTusQ-1; Thu,
 07 Aug 2025 15:25:55 -0400
X-MC-Unique: CDNwwD3UMGe44zNYwcTusQ-1
X-Mimecast-MFC-AGG-ID: CDNwwD3UMGe44zNYwcTusQ_1754594755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE344180034F; Thu,  7 Aug 2025 19:25:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77E2C180047F; Thu,  7 Aug 2025 19:25:54 +0000 (UTC)
Date: Thu, 7 Aug 2025 15:25:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
	Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v2 2/2] tracetool/format: remove redundent trace-event
 checks
Message-ID: <20250807192553.GE51368@fedora>
References: <20250806150539.2871-1-tanishdesai37@gmail.com>
 <20250806150539.2871-3-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P49XhDMZIv4pHlzz"
Content-Disposition: inline
In-Reply-To: <20250806150539.2871-3-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--P49XhDMZIv4pHlzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 03:05:39PM +0000, Tanish Desai wrote:
> Remove redundent if(check_trace_event) check
> from individual backends.
> Adding CHECK_TRACE_EVENT_GET_STATE in log,syslog,
> dtrace and simple backend.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/ftrace.py | 12 +++++-------
>  scripts/tracetool/backend/log.py    | 10 ++++------
>  scripts/tracetool/backend/simple.py |  9 ++-------
>  scripts/tracetool/backend/syslog.py |  8 ++------
>  4 files changed, 13 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--P49XhDMZIv4pHlzz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiU/cEACgkQnKSrs4Gr
c8jYewf/cmjWufmb3MeWY0Og6GSuNWPpgnX6Fd5iDMy6og+h8tYOlByaLptxm3LT
QFYqLRvBPhtsmRsjUwFZ8mXDPmk0+S71ZanvCEDubayLINhp8LffA/rbyXddBYnC
3VCjiTOnuUVzt7DsaU9Sb2RpYpkDoZikDrA8Hj3f6c0SbRqmbaS+Nfyh68oKYNlN
vaBwI+d5b3B22gAK0tuOyAfz3fswg94HhseQWUV7RTlCfhvfO3er5I2W4U66drsZ
KHUE7AWVC7Oh2M8SJJhDFseX1pi7Z9iuXbYtjvYSUJq/962/MmRHotZGOFbsjk+N
wmqlqHNlpbtJxK9xYQ7Ga2Xo7fVNUg==
=F4Q+
-----END PGP SIGNATURE-----

--P49XhDMZIv4pHlzz--


