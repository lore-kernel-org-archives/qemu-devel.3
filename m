Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F971C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 08:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiTFD-00059U-H8; Sat, 11 Jul 2026 04:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wiTFC-00059G-Rz
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 04:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wiTFB-0007CP-24
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 04:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783759168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nRATPXre/QiDPA/V19dth0YLLkbfvn8NCqZUEm32A1k=;
 b=NGoN6cCDUWropHEZe2xAv1UWsTCnn1bQBM9llVSg4gbB6RcNZpYmyr7utc+cpKVB/hrfhS
 /P9SHRXMPz6oeoNYcNyh6263ZTniGErRHFzYEGoWLGarSPEsLpiEclUIumzcarjNEHWh80
 2ye3ZvZhtoXDTZLnyk2lzSW9Pi6u1vI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-ZaZThrVpNTq92oDDMvFDYA-1; Sat,
 11 Jul 2026 04:39:25 -0400
X-MC-Unique: ZaZThrVpNTq92oDDMvFDYA-1
X-Mimecast-MFC-AGG-ID: ZaZThrVpNTq92oDDMvFDYA_1783759164
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9886719560A1; Sat, 11 Jul 2026 08:39:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 038CE3000232; Sat, 11 Jul 2026 08:39:23 +0000 (UTC)
Date: Sat, 11 Jul 2026 10:39:22 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] user patch queue
Message-ID: <20260711083922.GA637744@fedora>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BRQ7ZS4h/ZHqkyVh"
Content-Disposition: inline
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--BRQ7ZS4h/ZHqkyVh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--BRQ7ZS4h/ZHqkyVh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpSATkACgkQnKSrs4Gr
c8gdXQf6A6BtSiGgqWj19tlfQXw6NmRfJP1hzT2Sk9aVz5HdRR4teuBDrr0fMYhj
d1RbK2MTlEYrrhhM5VT+T6GQu9nFisrUQXhASYDZYZ2s4GKW0M73ONuHuWWjNR9d
Dm+O64WsorkX0SL/DdIAPQTaRaD5D1rupWg7UXT8MCzYjpJF+vZ/WiX4kN48lj0X
kQo0Vkmm2aBZC0cg0N4K5oACT+/+01j4mFKSfz3jcYvMFdYcQ5b1CNnkW5KGNuPi
3/RQqXA8iD+Z/Bag+4nCKVrdJFyFdFogp9P7ZdKoFoNUP0FwJAMDCke43Nmgkyef
4ObG463uh8IF99AN86JjAO0Nat4g0g==
=w1p4
-----END PGP SIGNATURE-----

--BRQ7ZS4h/ZHqkyVh--


