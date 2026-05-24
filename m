Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A228BCD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 19:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wREI2-0001Ze-ID; Sun, 24 May 2026 15:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wREHw-0001YL-BM
 for qemu-devel@nongnu.org; Sun, 24 May 2026 15:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wREHu-0006MK-Oz
 for qemu-devel@nongnu.org; Sun, 24 May 2026 15:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779650102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mGgK6l1XhbZp0Ye7Ai0RkeOwJaiUamuTsLi00uYevtA=;
 b=FUW79y2R+7OzNpTXtFLr7Qw8uvi97gZ5o2EUNjImohIAl0zASz8N+NKpO4ZZtQRnDIPcGb
 jZogcXZcAFjUrojUZO4GJCyfwn7AYO+Gr/5+IWxVWgAcozNllt/93u7lW+eKoCnp3ZhLxn
 C8tSRHNWV78O8yItoP0D3epTh36UREg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-J175LwzNPeCJRc-noixu6g-1; Sun,
 24 May 2026 15:14:58 -0400
X-MC-Unique: J175LwzNPeCJRc-noixu6g-1
X-Mimecast-MFC-AGG-ID: J175LwzNPeCJRc-noixu6g_1779650097
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A482195608C; Sun, 24 May 2026 19:14:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64F481800352; Sun, 24 May 2026 19:14:56 +0000 (UTC)
Date: Sun, 24 May 2026 15:14:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/3] Docs update for 2026-05-22
Message-ID: <20260524191420.GA1497674@fedora>
References: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oR8ptnmXVEAqpM1u"
Content-Disposition: inline
In-Reply-To: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--oR8ptnmXVEAqpM1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--oR8ptnmXVEAqpM1u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoTTgwACgkQnKSrs4Gr
c8jcXQf+Id5tWYhxxRCs31bpCIxi07whdyifWP2ZWEn5fX1eemh4G2viNdmp1yGN
X0pyhpY0a2+t/K+1PQ8bpgpjiqEeKZxCw6AHZ0F8a2Msf61eB1LWmUA0/L1VkW6V
YXTcrCSmyf9JLDmuY/xFSyMHuHTbTjCAAdCAGXjnBFf6yyCcs5TyEBfu9zadKo0t
MORHwSchU6HJ04iaWNjQG1hCxmhO10hal+194Ma9CgFGEpd42KfWtNBidTV1nPf8
uOnopBBaDBcKAwaeOGzQPUCHjWbfKuiiABeNxS9+HPi+d/nsI+svopwS1mVKgVS2
EAQjN9EoPfYgvbGb1XQzWsx+8Z35pQ==
=s4Ej
-----END PGP SIGNATURE-----

--oR8ptnmXVEAqpM1u--


