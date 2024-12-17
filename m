Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73D8E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 00:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNL2c-0001Af-BB; Mon, 16 Dec 2024 19:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNL2J-00016c-Og
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 19:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNL2G-0002qU-W4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 19:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734393718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brIx0lSIwKt/2zwFLVzZCU8TiAjSUsa4apteBL5iu0M=;
 b=gaQQWYf99zjLIQrqRvXHL9A7rnlCq5qNzvh/QBmznFI61o+Kq14e3NF+ynT8vNehQUTh63
 Z0R04ZjlpBS/fy3bHnpbR6MvFaEdbjcHXqep1zcwfZAoNgjE34AwHk6qC+qjKGt5+z2m3R
 EUNzDYKLcbT/27SsprV+GUy1AJXmoQQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-pEq_zDehNoav03zSM3wcWA-1; Mon,
 16 Dec 2024 19:01:52 -0500
X-MC-Unique: pEq_zDehNoav03zSM3wcWA-1
X-Mimecast-MFC-AGG-ID: pEq_zDehNoav03zSM3wcWA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A93E919560AF; Tue, 17 Dec 2024 00:01:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F99A19560A2; Tue, 17 Dec 2024 00:01:44 +0000 (UTC)
Date: Mon, 16 Dec 2024 19:01:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/7] Firmware 20241216 patches
Message-ID: <20241217000134.GA558883@fedora>
References: <20241216105053.246204-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3eteY7/QztfdIEne"
Content-Disposition: inline
In-Reply-To: <20241216105053.246204-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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


--3eteY7/QztfdIEne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--3eteY7/QztfdIEne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdgv14ACgkQnKSrs4Gr
c8hq2wf5AQAMyqXjN4D/xNEeqk32m123K2garzkFmkALIJfuQUxDYzipcz/qa2+c
FOyLuWlkP2UUlAVmy04Txs2vHNKlQu1fjJTBNWBXM09JawCD66NXvJ0+j79AY5Y8
y4YMDuOFwfviosSRr19+QmkwfE9gpLcWglqDLGRD5dTO3uBqiwPFquD8CfmriQQm
LSrzDAc7wXldUxQwmjf3GIiOLKF2Rcyb4Nkk/lVl6TstcnBrerfzCJ1LbYHeyCY+
aH/5OpagBv35LjKT/E+vGY3ontW59IEwLne4mKK5SXAkB0l2YFxYn6by3OwKfpKQ
cpGs5IBWaYzVZ9YsBJQaoDuo5WUgbQ==
=vU7Z
-----END PGP SIGNATURE-----

--3eteY7/QztfdIEne--


