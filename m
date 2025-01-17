Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A092C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYrsD-00010Z-Ed; Fri, 17 Jan 2025 14:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYrsC-00010K-5M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYrsA-0007p8-Pj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737141553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfCwiFJj3u394vTIRSH9hg+nxoM7N8fYFLLuERP+gCk=;
 b=KwpQ4rIH15Tdj2N/gFzMYQFiL618vKtn2Pzh7sbcu3xHegY3alB50TlcQ8U9cMNiS7nW+N
 IXlMZXYjhztvlBEf/f6HPSEOUv4EqLytgpZ7GTCFlGMoFyNkHuyIoHyiMJZ63VtbAjEalx
 V2nTxIBtPj3zT3z8gcJWz1gK8pbAGW0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-VD2UMyRQNVmQ6KyXlLMmlQ-1; Fri,
 17 Jan 2025 14:19:09 -0500
X-MC-Unique: VD2UMyRQNVmQ6KyXlLMmlQ-1
X-Mimecast-MFC-AGG-ID: VD2UMyRQNVmQ6KyXlLMmlQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27C641956059
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 19:19:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F48819560A3; Fri, 17 Jan 2025 19:19:08 +0000 (UTC)
Date: Fri, 17 Jan 2025 13:57:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/38] Rust, i386 patches for 2024-01-10
Message-ID: <20250117185750.GA401960@fedora>
References: <20250117085212.1044392-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K3UoVEyq2QflOSTf"
Content-Disposition: inline
In-Reply-To: <20250117085212.1044392-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--K3UoVEyq2QflOSTf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--K3UoVEyq2QflOSTf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeKqC4ACgkQnKSrs4Gr
c8jZGQf/egnltuRm41iUfyOUY/8/xEt/YVe2m7Yl2lzbe7F5RaH0VHzeYinxb57g
/R12x6H1Z6HdQQ6iMdXiT2p3csj5/gqXr1VbBfukkIfJiJSRPeWpGLS+zALjsdYE
JDrgzlgzxGbBNzJZETt8RSEDd5/GcRzg4E0CcrZXvyiFTW5X6zVlAWY2RGODRqfO
tgWZa3xofjb7yBdDKRUYUuwrqiMZoCSruoguATIcnP4KHuHibtcirY0Rcfay4lHE
VA9GgeCVgpFmN3lXH8/hsvEOd0rcUxLt9bUUaoaKgM3eQk6n2N/tG5hdyLq9oFeM
G2NiAxKqqHwPZIP/3icCbZe/D2DOgQ==
=adQZ
-----END PGP SIGNATURE-----

--K3UoVEyq2QflOSTf--


