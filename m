Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3308D29C5D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuYM-0003kJ-IF; Mon, 19 Jan 2026 14:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhuY1-0003fG-QZ
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhuXz-00088l-Ov
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768849457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8aJb/07z0tMj9R2kpuEKP4EmyMzUHF/QY09sNDIQwog=;
 b=CNopljMUeeVHfl0mwMxxlUsiSBibk+l80HbBY0g0F5Pd5sBBGDoGXVvrUJB5JhP4uqJN+U
 h7LQL0QCO+PBpkvoUw7+xmZ/C89QpQhnGJcwH91BPRw+5f0Q0aPe6a4bt/oG2OsBm6x+a/
 RCLRL1/iohSW+v42PN9ntiZzlTiMHC4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-owqu9-vRMXeseAxhRaQZHQ-1; Mon,
 19 Jan 2026 14:04:16 -0500
X-MC-Unique: owqu9-vRMXeseAxhRaQZHQ-1
X-Mimecast-MFC-AGG-ID: owqu9-vRMXeseAxhRaQZHQ_1768849455
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3090195422D; Mon, 19 Jan 2026 19:04:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E63A1800993; Mon, 19 Jan 2026 19:04:14 +0000 (UTC)
Date: Mon, 19 Jan 2026 14:04:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] tests/tracetool: Honor the Python interpreter that
 "configure" detected
Message-ID: <20260119190413.GB834718@fedora>
References: <20260115155318.37823-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4JrmfGCgP7/O/JiO"
Content-Disposition: inline
In-Reply-To: <20260115155318.37823-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--4JrmfGCgP7/O/JiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 04:53:18PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> The tracetool tests currently fail if the host installation does not
> have a "python3" binary (and you compiled QEMU by selecting a different
> one during the "configure" step). This happens because tracetool-test.py
> executes scripts/tracetool.py directly, so that this script is run via
> its shebang line. To fix the issue, use the same Python interpreter to
> run scripts/tracetool.py as we are using to run the tracetool-test.py
> script.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use sys.executable instead of passing the Python interpreter around
>      via a PYTHON environment variable.
>=20
>  tests/tracetool/tracetool-test.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--4JrmfGCgP7/O/JiO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlugC0ACgkQnKSrs4Gr
c8hehgf/VTnPWnKgjmi0dLZE0SsmvcVkqwC04FRb/nVW+UCc31eEmSvtWYte3KPc
sCx+TFXKnQO1+GP80mZwTeKGX8fxleABU3xjHX/O/RlZmwDryGKXgEinVtj4qDl2
wd9KVTqfXIMZM5hezemBXDWxGQRlBEmhVBlCyU8PmO81o3qrIzmYsCbh83X6txvH
FiNWAbBvUgS9Dup74LdZs1NyNnTKWnMfMSqHsDDT5ye9maH5XDQ6thmH+SwtIwiz
Md4gkmJ2uVXNhH8/3i/9pdqGhW06iV7IpQqeuUYd0g5C1Hbmim+9rzyn0aq4Hwil
E+rH9ltE4eBYG76NqrYDMYVjIM97mw==
=FcNq
-----END PGP SIGNATURE-----

--4JrmfGCgP7/O/JiO--


