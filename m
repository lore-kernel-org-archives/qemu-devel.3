Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343F1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOx97-000410-7g; Mon, 18 May 2026 08:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wOx8o-0003wU-5C
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wOx8m-0004oy-Pu
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779107531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwdOOi13j1pB+fS90iq4rLcAKamyS/B6P4b2VG43UME=;
 b=is0a1gTMdHUYlusw2kR1VUciOjf5Kooa4ryD1ATUbSmQtZ3KZZorlUYXJB9aoYHFYssrKU
 Z0W+1f2hMvG6ZyE3MD9rpw89FOLV1+mQ/jt3V5YvLUZTQbymdmhHz7pZUXkbvGp0S941hj
 fuzHW35tBIaIXhsoJkawABa2D9eXLAQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Ffo9PMYKNZaYKF40NWiafg-1; Mon,
 18 May 2026 08:32:07 -0400
X-MC-Unique: Ffo9PMYKNZaYKF40NWiafg-1
X-Mimecast-MFC-AGG-ID: Ffo9PMYKNZaYKF40NWiafg_1779107526
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D3B018002C8; Mon, 18 May 2026 12:32:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4DB7180034E; Mon, 18 May 2026 12:32:05 +0000 (UTC)
Date: Sat, 16 May 2026 19:25:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, stefanha@redhat.com
Subject: Re: [PULL 0/1] virtio: Add vhost-user-rtc and vhost-user-rtc-pci
Message-ID: <20260516232530.GA39178@fedora>
References: <20260515132315.520678-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DiMbzpiEEVbZVhWF"
Content-Disposition: inline
In-Reply-To: <20260515132315.520678-1-manos.pitsidianakis@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--DiMbzpiEEVbZVhWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--DiMbzpiEEVbZVhWF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoI/OoACgkQnKSrs4Gr
c8itzQf+JIdOMmw04D58gRC9rX9ERNgsluUaEWz05Aie/k7fjyY0K//thS0TaF6y
ACpXsikZuug1Y3x6yIfs+Wg83aTFLODkZh4vucnnZN+Xz67aU4yuibgzVcR81mAB
0zFYY6PbmsGXXKiwl8ALPLcSvDwAWit8MQeLO/XnwNwbCNQ5/5F5gYYpr5KL4TXi
fzN5bICnAY/Hi5iGlaTxyeFE5ouAV8RyA4CxpsGbnkMEMHrR281ln5QXOHMe2YOb
BZuctCKeN5i2E1ZxeLLb0eHzhm/0KESU2ixVKyNtDsPrTlH2L1ToYYwewBRH5zfF
dAIhQyTfwnZwdbFk4VdBWyyz3blxZQ==
=/Vv8
-----END PGP SIGNATURE-----

--DiMbzpiEEVbZVhWF--


