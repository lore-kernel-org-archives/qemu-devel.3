Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D2DC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkaE-0006YM-1M; Fri, 04 Jul 2025 13:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXkaA-0006Vp-KX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uXka3-0001Ej-69
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751651527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xFhpMFHEAnz9ZT+smbfHgthh9LzYHygMnQIVJ8eKnEI=;
 b=SAbuneJcWX8W5ytSGiteVUrc4RYhw7UBHHvfUtf26xDafX2lqeYshU1hot5UOfTRp55iJX
 h72pVvg0N9Iyb7pFAj4UjIzCB5hfCfIK/QWCm1KfKN63My/wkqSMhzxfblkff7hUNKQino
 lxMz09NSRmSKgCn5LHKf/8LNgRpkWmU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-XLOUogwtPdWo6D-e7jHr-g-1; Fri,
 04 Jul 2025 13:51:56 -0400
X-MC-Unique: XLOUogwtPdWo6D-e7jHr-g-1
X-Mimecast-MFC-AGG-ID: XLOUogwtPdWo6D-e7jHr-g_1751651515
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70DBB18002E4; Fri,  4 Jul 2025 17:51:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFB111956087; Fri,  4 Jul 2025 17:51:54 +0000 (UTC)
Date: Fri, 4 Jul 2025 13:49:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/31] Accelerators patches for 2025-07-04
Message-ID: <20250704174956.GA95170@fedora>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hQwWzc3rdRmrfFox"
Content-Disposition: inline
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--hQwWzc3rdRmrfFox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--hQwWzc3rdRmrfFox
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhoFEMACgkQnKSrs4Gr
c8jCSQf8Df+Ktj/WCUcLLwPWZzBSpeRqgu9rZcmV0eCfoZaAWIsQwuDyPGEP2Tmv
B3MJ+R8bN+aFzIc5Bo1EvKHniIUBer/FaNdYzGgYutgsKcYeFbAqapoY5+Uz1vSB
pX+KFco4X4aYGeafOhFS+4txfcrpG+378A3LhrHmUIlqxogsJJAOT5LjZjSfYBsW
NjZy/3fLMx5ycqAyJMh2+MFZNt84AX/H0KeizcqNTxrb47zie07HigXRLoRWrORO
GEVc9FL7l6ZIyjP2l/NEUKw0e12UJKgVduF1pzFNu+3nZ4IAb2d/tb2CCUIIXbgp
6hFInakR4N5A3X/gk6NEVmBvNGu+Zg==
=Wk5d
-----END PGP SIGNATURE-----

--hQwWzc3rdRmrfFox--


