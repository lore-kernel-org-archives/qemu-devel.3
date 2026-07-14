Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05663C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjtTN-0002wC-0B; Wed, 15 Jul 2026 02:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTL-0002vo-6H
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTJ-0003sU-So
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784098317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wBLt9GgmbRVAwe8BE9no1NtbqfO4/fNjKjnSBriRPRA=;
 b=gjy/sbPNgdfQhYmVnrMhSfkkWyX3o0xZsW1RaHzwh0G1yjG0HJYQ1mrVXMQbEneJUawO2j
 7+vKuw3MDRbQePb8SSF9UuDjmJUKUm4XRR5XVS9RHrtU+o2CRp+y8UhNmWmGGz3C490N08
 KlB9nHBZboDrbkrm5G/gdIiWnAj1alw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-ip1-zAryPPqtrRc6SETl5Q-1; Wed,
 15 Jul 2026 02:51:53 -0400
X-MC-Unique: ip1-zAryPPqtrRc6SETl5Q-1
X-Mimecast-MFC-AGG-ID: ip1-zAryPPqtrRc6SETl5Q_1784098312
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B9FD195605B; Wed, 15 Jul 2026 06:51:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF1CB18004AD; Wed, 15 Jul 2026 06:51:51 +0000 (UTC)
Date: Tue, 14 Jul 2026 20:23:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/3] Plugins update for 2026-07-13
Message-ID: <20260714192339.GA706304@fedora>
References: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1mwaJ5dlhQMS20yD"
Content-Disposition: inline
In-Reply-To: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--1mwaJ5dlhQMS20yD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--1mwaJ5dlhQMS20yD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpWjLsACgkQnKSrs4Gr
c8jl8wf9HwvHcURMKth/Q0E2Pi8hYvBd7mvgIypZWxMHgBo9aTtzW2enfzvP7DQr
RrralvzMJ8QKXCQBXPNfbjbV2w/rUHs22v2/iCTRjPdOlY4UeVGNpMSsPtrV215x
nR0NseyvDJn0H+jRHmgIFe60h8gHep+t6V++rZE/f5ATefxQrJzOIKaucU2jgPFk
knRlmwiP4j1EEKor22gdgHYeUomdjnCm0yDVkrxFrwMOaHtIiwDEKU4u/52MHMR/
Zo5c50iAKpwIG/47idoOZH6d0aAJWk79g4NuVFdjJldyfIQ1lp0dnMV80Ozd4oCj
t9Cfu3MRYSZJz9/sdUHyOD/kdf+6xg==
=qvvM
-----END PGP SIGNATURE-----

--1mwaJ5dlhQMS20yD--


