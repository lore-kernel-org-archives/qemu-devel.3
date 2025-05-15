Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCB8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 22:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGQ04-0003GL-Ie; Sat, 17 May 2025 18:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ03-0003GA-BP
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ01-0006iA-RG
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747520839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dASGr+D4KDOT+57VsSxbazahqXjp3JCZ8q0Yhy0cuOw=;
 b=OjOX+ckgy+emL3WYiVIOI0HqhjxlXClueo+MWu/CY//vr4GK2GNdh0SzJKA7n5gOsXfJ0x
 KEDQtSGU4F51IhCxrZ7wqVED8exyhv3ifcTPWkHx1L+juayD8H33dOU08Ukp54nd+cfFaB
 eMmQM4mM6sogOkWGu584IQb3j/sg5O8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-cK3hE8HXNj-E2kB_8jQ57A-1; Sat,
 17 May 2025 18:27:17 -0400
X-MC-Unique: cK3hE8HXNj-E2kB_8jQ57A-1
X-Mimecast-MFC-AGG-ID: cK3hE8HXNj-E2kB_8jQ57A_1747520837
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BD3A180087A
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 22:27:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46D4819560AA; Sat, 17 May 2025 22:27:09 +0000 (UTC)
Date: Thu, 15 May 2025 17:52:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/13] s390x obsolete machine removal & misc fixes
Message-ID: <20250515215255.GA423577@fedora>
References: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rr8f/IcWtmN1Fkdp"
Content-Disposition: inline
In-Reply-To: <20250514112733.456644-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Rr8f/IcWtmN1Fkdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--Rr8f/IcWtmN1Fkdp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgmYjcACgkQnKSrs4Gr
c8hHlwgAhRQgxn3qJ2ioF3g+54s5PqL/kq3jFxqs0uXUG9VJ9aemgh0HCmIEXkVz
fDZfwoBRNFKqkHlTBXa3NXJG3CSOjHu1FrV6exwHJN0E+miLCSHe3I6KoEuzXTLr
XBjxB6CM++Pyy1Rc71y0PFAJnEPw08kINcK9Z6UItkP5XHUyNM8NJ6MDz2WyFfdr
IE8fCqwa+z8Eirh8pKguXTPuPJ45qUqwKM0Yq7MBg/5CzJyrcJaX54esEWeb9sg6
uKflvHMGhuV0sSrwWY7lVCQxqGr6IpvmkfCH3NoI9UYk3u6FHuQa9bhjbFVpE+vq
NNQsx2b4FtKyK+nkxjAO90V6yFUgtQ==
=MRRY
-----END PGP SIGNATURE-----

--Rr8f/IcWtmN1Fkdp--


