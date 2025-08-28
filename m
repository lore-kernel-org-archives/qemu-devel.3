Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C324CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIT-0007Yp-Vd; Thu, 28 Aug 2025 13:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1urdrc-0002eF-Ig
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1urdra-00014g-7I
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756392265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RGHBPU+lcJo189CbJtshkPrbtOEHMe1Xxjnbkb5lhso=;
 b=GAXg2g8YOhSiRe9xv+jzOM1V1yUQ0f1BKueCHg+7R6xmFeQG2JTpAiErohhzBbnxzyB589
 d98O3GsLlq/whb5RtJI9F3DHoiy4Ab396gD9SGrTm2uog2RuNjAAmFLmZWtvHQOp3Wep/F
 WpZHnJiwdrUcMl4KL/NCLQH+PrynZQ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-sPlFbFC_P1qDfizSc_5KRg-1; Thu,
 28 Aug 2025 10:43:06 -0400
X-MC-Unique: sPlFbFC_P1qDfizSc_5KRg-1
X-Mimecast-MFC-AGG-ID: sPlFbFC_P1qDfizSc_5KRg_1756392185
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEBE4180034F; Thu, 28 Aug 2025 14:43:04 +0000 (UTC)
Received: from fedora (unknown [10.44.32.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B25E730001A7; Thu, 28 Aug 2025 14:43:01 +0000 (UTC)
Date: Thu, 28 Aug 2025 16:42:58 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 0/2] hw/mips: Remove mipssim machine and mipsnet device
Message-ID: <aLBq8uo--L5qK30z@fedora>
References: <20250828143800.49842-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HGWPRM29bkXxGMUL"
Content-Disposition: inline
In-Reply-To: <20250828143800.49842-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--HGWPRM29bkXxGMUL
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Thursday in 2025, Philippe Mathieu-Daud=E9 wrote:
>mipssim machine (single user of  mipsnet device) is
>deprecated since v10.0; remove for 10.2.
>
>Philippe Mathieu-Daud=E9 (2):
>  hw/mips: Remove mipssim machine
>  hw/net: Remove mipsnet device model
>
> MAINTAINERS                             |   6 -
> docs/about/deprecated.rst               |  12 -
> docs/about/removed-features.rst         |   5 +
> docs/system/target-mips.rst             |  11 -
> configs/devices/mips-softmmu/common.mak |   1 -
> hw/mips/mipssim.c                       | 249 --------------------
> hw/net/mipsnet.c                        | 297 ------------------------
> hw/mips/Kconfig                         |   7 -
> hw/mips/meson.build                     |   1 -
> hw/net/Kconfig                          |   3 -
> hw/net/meson.build                      |   1 -
> hw/net/trace-events                     |   7 -
> 12 files changed, 5 insertions(+), 595 deletions(-)
> delete mode 100644 hw/mips/mipssim.c
> delete mode 100644 hw/net/mipsnet.c
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--HGWPRM29bkXxGMUL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCaLBq8gAKCRAU0rOr/y4P
vDGfAQDEw2xJFLiAQCF9cnmNiaUhsHHcpgWSQPNRa/iTonsijQD/QadQN4x5KB3z
cvgQ5+Z8XhJkwiCRtgmKaWzDgyzzrw4=
=aKYJ
-----END PGP SIGNATURE-----

--HGWPRM29bkXxGMUL--


