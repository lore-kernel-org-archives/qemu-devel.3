Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E006ACDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcSPR-0006aA-Lz; Wed, 24 Jun 2026 14:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcSPP-0006Zc-PD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcSPL-0007Iq-Um
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782325986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3xrubiWTngs3MyfoNj0+ZTAfjvRCzIQ2nG0VZTOA4w=;
 b=TfWTh+0/xfMf1puqcHwcGqHtXcD+Qk478ru0JKgDzA7WoKtw0NCNW+rkmDs2C4BWNcBmU7
 aO8PFL8bPaKt/iIpu9gC8LgxapcHyXEBdU0Flvx8DUikrEK0WH+/makBDzPGATDyxwTb8O
 BfpN0aCL0VIYQyggWUS/MuxQOtVhyDI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-BHrhk21NONaYBjJKuyWGzA-1; Wed,
 24 Jun 2026 14:33:03 -0400
X-MC-Unique: BHrhk21NONaYBjJKuyWGzA-1
X-Mimecast-MFC-AGG-ID: BHrhk21NONaYBjJKuyWGzA_1782325982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 610DA19560B6; Wed, 24 Jun 2026 18:33:01 +0000 (UTC)
Received: from localhost (unknown [10.2.17.97])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53D0F18004D4; Wed, 24 Jun 2026 18:33:00 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:10:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 03/17] iothread: tracking iothread users with holder
 name
Message-ID: <20260624171008.GB109308@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-4-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R0or62Y5v5OcCZIq"
Content-Disposition: inline
In-Reply-To: <20260624070851.13342-4-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--R0or62Y5v5OcCZIq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 03:08:37PM +0800, Zhang Chen wrote:
> @@ -70,6 +71,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
>  AioContext *iothread_get_aio_context(IOThread *iothread);
> +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> +                                             const IOThreadHolder *holder);
> +void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);

There should be doc comments for these new APIs. One constraint that
should be documented is that these APIs are not thread-safe and must be
called under the Big QEMU Lock (BQL) (this is necessary both to avoid
holders list race conditions and because object_unref() can invoke
finalize callbacks that expect to run under the BQL).

--R0or62Y5v5OcCZIq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo8D3AACgkQnKSrs4Gr
c8jJRwf/ReNKln/YmXbh5LxJfQWq5C/8Z6zK6Ka+QwC+XQnJ38+uSWW9RHIeeeJ+
YGsXCNIjU22dTD2Hbqk80yK75okReWvyt32mAUBHyfMniiR5ml4FlYYlr0TaLcP7
ZfHL40hS/NDTzAF7NtONw9MsS1gBcsVSMn4wZoqQeAZjCcwassPhtFSv2jv3tpWr
nkDkezUrMgehyHEFbfsusRWsbJ03GY/BsD4IwBRDniz7d1W5qjU/4pnEDiFx5buT
IUU7H6XBJJVmFlLjkBFrTzQXNiVx6M9wbGDwVDF/U5uXC4x7ESuJKtOFRyVMx6IK
sYmCp8i5fJ2iFWYZIridkBmdgtjtCg==
=P1Ry
-----END PGP SIGNATURE-----

--R0or62Y5v5OcCZIq--


