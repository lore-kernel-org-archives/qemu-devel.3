Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034C4C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvRv-000235-Cx; Mon, 05 Feb 2024 04:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1rWvRt-00022I-Ew
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1rWvRd-0004Dv-A3
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707125955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERmY7qem4Q2D4/HV/GjHiOsfvOcjqwjHtU5TyWyW89g=;
 b=Pv52N9suuBbf+N0ojnc1KCIfT9nAcWg4cP1qio5VGviH08MweznEeRanSG5H2WFDwMhzSZ
 b3a8hrssKNvJfVXSFI6ERtJoj1sD8ZWOdm78MQtoA3vMDyrrxflvmlEn8nm+cH9YDur/U0
 dRwCUX0uLNvTxwpOIEji1o4gl526P4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511--6PHku0oNJ-7EFzFrWH70Q-1; Mon, 05 Feb 2024 04:38:04 -0500
X-MC-Unique: -6PHku0oNJ-7EFzFrWH70Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDF4B83514B;
 Mon,  5 Feb 2024 09:38:03 +0000 (UTC)
Received: from fedora (unknown [10.45.226.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF0B5012;
 Mon,  5 Feb 2024 09:38:02 +0000 (UTC)
Date: Mon, 5 Feb 2024 10:37:59 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 devel@lists.libvirt.org, eblake@redhat.com
Subject: Re: [PATCH 4/4] qapi/char: Deprecate backend type "memory"
Message-ID: <ZcCsdw6entrmSDr4@fedora>
References: <20240203080228.2766159-1-armbru@redhat.com>
 <20240203080228.2766159-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="14xzESOV8s6/ww9D"
Content-Disposition: inline
In-Reply-To: <20240203080228.2766159-5-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--14xzESOV8s6/ww9D
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Saturday in 2024, Markus Armbruster wrote:
>It's an alias for "ringbuf" we kept for backward compatibility; see
>commit 3a1da42eb35 (qapi: Rename ChardevBackend member "memory" to
>"ringbuf").  Deprecation is long overdue.
>
>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>---
> docs/about/deprecated.rst | 8 ++++++++
> qapi/char.json            | 8 +++++---
> 2 files changed, 13 insertions(+), 3 deletions(-)
>
>diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>index d4492b9460..ae1a520c26 100644
>--- a/docs/about/deprecated.rst
>+++ b/docs/about/deprecated.rst
>@@ -371,6 +371,14 @@ Specifying the iSCSI password in plain text on the co=
mmand line using the
> used instead, to refer to a ``--object secret...`` instance that provides
> a password via a file, or encrypted.
>
>+Character device options
>+''''''''''''''''''''''''
>+
>+Backend ``memory`` (since 9.0)
>+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>+
>+``memory`` is a deprecated synonym for ``ringbuf``.
>+

For libvirt:
Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

(We don't support either of those)

Jano

--14xzESOV8s6/ww9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCZcCscwAKCRAU0rOr/y4P
vGLOAP4yGZSR53HAIfAcO2ySMePRe+xYVWObeUD7q7kj7PzKpwEAomsCD47nupu8
lYYTufZ8dCpszZ0rTu6jCa/Z4d9pPwo=
=1F9E
-----END PGP SIGNATURE-----

--14xzESOV8s6/ww9D--


