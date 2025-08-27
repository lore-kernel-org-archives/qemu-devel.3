Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA9ACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 19:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urLb5-0003oq-Lc; Wed, 27 Aug 2025 15:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLab-0003ZU-Sa
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1urLaY-0005Kq-Gw
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 15:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756322018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSfKZzVfZaHPDG7BXoYprNfS0rYW/qvZeILoM7Hg25M=;
 b=jA/EQ48DXmewt8nbPTBnAAGuYRG0SZ4mnHB7mzZRlVCW778V64nez8K1eeMjDNZv17ujUH
 L/3Q3R6c9BIriVfpVIb1IPEQ5tadQt582h5gkF3tOf5xHPWDDAd0GN15D2RrISmY5eKi7+
 41yEZp38Cc1zaEnj7vmPtzmbEeTX3Rw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-si066xjzPty3nY6diFwXVQ-1; Wed,
 27 Aug 2025 15:13:34 -0400
X-MC-Unique: si066xjzPty3nY6diFwXVQ-1
X-Mimecast-MFC-AGG-ID: si066xjzPty3nY6diFwXVQ_1756322013
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D3761800285; Wed, 27 Aug 2025 19:13:33 +0000 (UTC)
Received: from localhost (unknown [10.2.17.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01FEA1800447; Wed, 27 Aug 2025 19:13:32 +0000 (UTC)
Date: Wed, 27 Aug 2025 15:13:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH 04/14] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Message-ID: <20250827191331.GC228377@fedora>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4QgI93sxNDbbY9s1"
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-5-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--4QgI93sxNDbbY9s1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 02:26:45PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> Add a new attribute CHECK_TRACE_EVENT_GET_STATE to the backends.
> When present and True, the code generated by the generate function
> is wrapped in a conditional that checks whether the event is enabled;
> this removes the need for repeating the same conditional in multiple
> backends.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/backend/__init__.py | 39 ++++++++++++++++++---------
>  scripts/tracetool/format/h.py         | 11 +++++---
>  2 files changed, 35 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4QgI93sxNDbbY9s1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmivWNsACgkQnKSrs4Gr
c8j2SQgAjsF5DfFDDHrKqbfIaaRW8d/ednZ65gMXIxvNI/7iVWku/QMRnT/IlsX+
P/4I/Ms8In6P79YqCT6aFe6XS5yQNLew34swH/9/Kj8+koFmqkrGgnCmxSsowXPW
ml3CvNqxRwnsbAJJYSMm5kexsl6MVimt6DnofjVOl+28t6/LKsQpQJQmjTXLj1Y7
32yE7FLJGQ5lo+lVo17+DT8okrkrH4UAaXffP+Sy+21AYdr243xo3vi5Gj7IzYVw
yuKBZl9oigUdkzQTJH1NgPanT+ZCmd4k6r3qIGA8tyHZeetOrv0V95OlP9v498ZP
rWSL3lY3GJb8gGdjgAqp5tjxsbu4IA==
=q2Xj
-----END PGP SIGNATURE-----

--4QgI93sxNDbbY9s1--


