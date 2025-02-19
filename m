Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD48C021AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 02:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tka8k-0006W2-W5; Tue, 18 Feb 2025 21:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tka8j-0006Vr-4H
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 21:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tka8h-0000pw-0q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 21:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739933321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+hyHOJmu+kgHqw4dHL4NrOiL7lgM2eaVIBanAIL2xI=;
 b=akomNOjPH9ivfZY27aGPP//o9+V/tma3++HVIxrp8deJA0kC5XSnTTC2+OXkfTxlSrxubN
 Gx9nkmM1s03ojD/3C3vlprgBWhm6eGnJ2CZh/Y9jqE731QwGYTBmHns/F9U16N+juOLbHF
 PhtDLu2IaaJVoOw7kq/YM0fUu2WkaXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-UFYCe-T0O5yHjVYmzkNf3g-1; Tue,
 18 Feb 2025 21:48:36 -0500
X-MC-Unique: UFYCe-T0O5yHjVYmzkNf3g-1
X-Mimecast-MFC-AGG-ID: UFYCe-T0O5yHjVYmzkNf3g_1739933315
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B97521800374; Wed, 19 Feb 2025 02:48:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.53])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBB751800D97; Wed, 19 Feb 2025 02:48:33 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:48:30 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/28] tcg patch queue
Message-ID: <20250219024830.GA44051@fedora>
References: <20250218172426.81706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i4EymOnIvKYsmGTX"
Content-Disposition: inline
In-Reply-To: <20250218172426.81706-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--i4EymOnIvKYsmGTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--i4EymOnIvKYsmGTX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme1Rn4ACgkQnKSrs4Gr
c8jHigf/d2Ktx3QmkHPund1wGfQqz7lH86cA2PR9dBOCICxgCk8WEC3qZ3vrMOtk
KgU873aV+tsyhy1VWDVNuqO5FFZqrrDh+A3R4748KGqxOv3l616X6RLv8nTDvP5x
ANLetWrsbIFRygyVAY7kM/hesXx/aSfXxh+K2Zm0hEs7q3hwDkgJ40XRHkNjL+2C
Xmo1YLrtLx/nL02D8d+OhE26zaJjOi87LAd4T2tXK5DDndeK5EUkz9ic2JsAOgqu
RrPJRkr1HJpaV1kDWBeiIbFnaj6VLJfKCMew8aL1j6OWRKcbVy0rzfBRsfFoLLlC
Y+9Moh8oHEabYVnXAoptO+qcrPXOCg==
=tvwh
-----END PGP SIGNATURE-----

--i4EymOnIvKYsmGTX--


