Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFCEC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 13:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCeeZ-0002xE-6w; Wed, 07 May 2025 09:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCeeV-0002wm-6j
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCeeT-00013a-51
 for qemu-devel@nongnu.org; Wed, 07 May 2025 09:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746623849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TlIuvzcrYlkrRBvDYUvlcYpSvxQF+KhtAH454Igf3XE=;
 b=CKiLoGGPqsLRmiefus3Ho3wXa0sHFw05zb28vYTWbHJEVPRNOCxccaQHhEajWCBG6EF4Cq
 RCaXs2qclgtcH1F6bNZGyX9W4HYhndT/AHHJwUS310A3kp8HGj2hjgjtRDWSgDTExhZYZw
 zWLW2ZsExv1ctaNvYDKoev4B5zlJJrI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-yIPfYLM4P0eq2EIRV6oz2Q-1; Wed,
 07 May 2025 09:17:27 -0400
X-MC-Unique: yIPfYLM4P0eq2EIRV6oz2Q-1
X-Mimecast-MFC-AGG-ID: yIPfYLM4P0eq2EIRV6oz2Q_1746623846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1214F18007E1; Wed,  7 May 2025 13:17:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.163])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B767180049D; Wed,  7 May 2025 13:17:25 +0000 (UTC)
Date: Wed, 7 May 2025 09:17:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/59] tcg patch queue
Message-ID: <20250507131724.GA10883@fedora>
References: <20250505195001.3479169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ywgYgNBBCLVrzbrJ"
Content-Disposition: inline
In-Reply-To: <20250505195001.3479169-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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


--ywgYgNBBCLVrzbrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--ywgYgNBBCLVrzbrJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgbXWMACgkQnKSrs4Gr
c8gPIgf+NpRo8K4JoXof3MWFzMotsiSxpgpZEGZyLaBOdv+cxOl9p/C9PkxYVUnh
gio5e9iBSWxstf8Qhk0jhqgAE99AKt2TxZm9va9QNXGgMdfnArceXfEuD83c/7Bn
eLJG5bm+8dpNAdrfzT0SZVY4EXICzgdYTjglTE9VBX/uewe3jKtxXsJLdMFUlY6S
pWG5a+HsKjOVsCroMZie+kN2AHZUY7+w7vqY9FBeXMs88adDgBIpugzBveD3SzZI
YY7C+Znhh+jnC6mgY9FQg5yuVYvMx/QeN6UpaZ90f330of7ptyqairLxTPAqocQW
ng1sEdnZwldIKq1DLevd2AdtViU9hA==
=iIRN
-----END PGP SIGNATURE-----

--ywgYgNBBCLVrzbrJ--


