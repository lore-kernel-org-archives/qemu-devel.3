Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4594C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 15:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIUaS-0006TM-Nv; Fri, 23 May 2025 11:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uIUaR-0006Sa-46
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uIUaP-0000r1-As
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748015126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2GuPQgBj7FQ20R9GC9RPc5kXTHJLTycgG5LJ5cOEqw=;
 b=HZBVmHgcLcJcwOUKadJHrT0VYPqRhv6I4jrSK26Ip0At8Aakavl8FNCKyVDFBPOkqqSw5F
 kBwfOqNz/w25qDPqFskWw4w+sptl+kg4Ps5m6e4dgi4dOJTeo3d5oBh1gPMYmHan5a+OUS
 7CG3DlyqWbuTvZQvvwmNBTUEwmMk9EA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-ymBrF6r9M3mQVWZwJWiZnw-1; Fri,
 23 May 2025 11:45:25 -0400
X-MC-Unique: ymBrF6r9M3mQVWZwJWiZnw-1
X-Mimecast-MFC-AGG-ID: ymBrF6r9M3mQVWZwJWiZnw_1748015124
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BD3D1955DB3; Fri, 23 May 2025 15:45:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84DF430001A1; Fri, 23 May 2025 15:45:23 +0000 (UTC)
Date: Fri, 23 May 2025 09:21:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 00/23] Misc VNC, I/O, Crypto & checkpatch fixes
Message-ID: <20250523132121.GA13454@fedora>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1/UHU4NLGBPtEMTX"
Content-Disposition: inline
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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


--1/UHU4NLGBPtEMTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--1/UHU4NLGBPtEMTX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgwdlAACgkQnKSrs4Gr
c8j4DAf+N7vn9g+rZpichMxCsAuAfk/H9XhKN+ZN2I+j+88DJNSit931oc5XtNzl
aJJFbyJp/6eol6Jt1kGnR/jzexHyBNjntBd3P5zC/HVlqIrXxSwSQDwV717JXVD9
uI1lYUzK8MreAprYN4XSYYgtBceJ0pZD1ICMvQknX924nwik34rumDEykLqhUHUt
cCihPMQyJmH7Gc7+3mXr25c5DoZ61d9aUnQqDTWjKE0yru+2OEr0dZsc6D8bxyms
1bPS/WEuN9RhVovsfQ3El/gYzIHq3Fg+mfArT8QOcPULjEEccDmw+0Y2i93QnzCh
K9AkO4dYA9f+Kr+RnZ+XeQ7KqdAFgw==
=VghY
-----END PGP SIGNATURE-----

--1/UHU4NLGBPtEMTX--


