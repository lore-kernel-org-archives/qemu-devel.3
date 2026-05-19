Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E39CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJkH-000313-Ij; Tue, 19 May 2026 08:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPJjo-0002vt-J5
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPJjm-0002DW-Be
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779194392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xU4mUWAlexcwA+GX69eJvJ7LgLD191u99rk5n2YbY9k=;
 b=DawoSCfrWsbb4hD73zLU6Ku2EYy64DVuZKgZt1Wi8wOuTjVovgvTByfxMqF/2R+oiKwxI3
 jnEmT/tOrGV+MFqBxD16hrAH+AR8Ei+goL+yA0JYx2ipbpD7ySr8d8hU78IkAOvSSPjzBC
 uJzvLFuDqw9l7FKRyCImdIWmDX6EVgw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-YRhMiFc7OPCtK9gedUIQ8w-1; Tue,
 19 May 2026 08:39:48 -0400
X-MC-Unique: YRhMiFc7OPCtK9gedUIQ8w-1
X-Mimecast-MFC-AGG-ID: YRhMiFc7OPCtK9gedUIQ8w_1779194387
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A95301956080; Tue, 19 May 2026 12:39:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1280D19560A2; Tue, 19 May 2026 12:39:45 +0000 (UTC)
Date: Tue, 19 May 2026 08:39:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 0/5] hw/nvme queue
Message-ID: <20260519123944.GA106707@fedora>
References: <20260518120748.14831-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZxbWF7JftBU/7iHT"
Content-Disposition: inline
In-Reply-To: <20260518120748.14831-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--ZxbWF7JftBU/7iHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ZxbWF7JftBU/7iHT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMWhAACgkQnKSrs4Gr
c8gmWwf7BWvjGPMshnN5Vd2hlIenuZ44IUCBeIvkccsdf6CpEId1GPP6rn0hiqza
L8PK3e9kmExV1sIRvsaPZSUD98VXOieM/lGvykrsP+W3+Gfg/6ts4pycUJav/tR4
zXDB9hr9fJ1lOFmlOJwbBX3IkqqWs8V/VL0VlTWTRf7FiWxems2YkK8lvJGekgu/
dJMe/ZElXp3x9cIjge8LTIk6FN/JaGcIOg46JLoQ4dJUaJ7yiUwb3MQSZaTOoeZz
hm6oKCj0JECOvht7UPAQBRMbzoXg7RQ7JzduFQYwq/V2cbQAy5S1hQovHO3IJdyQ
nDl3+O/lY3ti4VgcuNyxDG/Tnoysrw==
=3+AZ
-----END PGP SIGNATURE-----

--ZxbWF7JftBU/7iHT--


