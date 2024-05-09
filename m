Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B8AC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58p6-0006nc-Hi; Thu, 09 May 2024 14:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58p4-0006mp-Nz
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58p1-0004u0-Ip
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715280531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJ2aFHH+Y8quF0d9YiyNhY6wg0Un/pbM+PlhjyNKvgI=;
 b=aXuyzPWdoo+1sE9dkWGrwwUT1AN7nDoeXTH9FpSD3gjw/8JhY/KvxggUfm4+63eAdcHOId
 kxb3Qw9XcbXmcV+ULjgq2g5Pv0YmJXKrQkmLYIzwjN6vQMm95q7s5GeEy6w52hIBTd8Y0A
 quA68Ge0u7pohB5Mh4nPRdlxpQ03/Q4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-3QUcu692P8u7RBD8W434hA-1; Thu, 09 May 2024 14:48:46 -0400
X-MC-Unique: 3QUcu692P8u7RBD8W434hA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9209857A85;
 Thu,  9 May 2024 18:48:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E451148BB5;
 Thu,  9 May 2024 18:48:44 +0000 (UTC)
Date: Thu, 9 May 2024 14:48:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 7/9] hw/nvme: add helper functions for converting
 reservation types
Message-ID: <20240509184843.GI515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-8-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w6UHe7CRbEp6v3rg"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-8-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--w6UHe7CRbEp6v3rg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:27PM +0800, Changqi Lu wrote:
> This commit introduces two helper functions
> that facilitate the conversion between the
> reservation types used in the NVME protocol
> and those used in the block layer.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/nvme.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--w6UHe7CRbEp6v3rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9GosACgkQnKSrs4Gr
c8gAzAgApt3jM5Tx6Gp7ZrgJqE3cqb2+cvlnq48TrpWHFd7jB1SrRDfvL/7nWMe8
Wa26noUVsMWm/U9zvj+BH7bs+S/iXbdjieL2l0hddsWFEOXApyThjbatG8IrUF70
SJqvelhJIU6VVeS/NjVAkRIiqA27zd2SvjGvpVEFUz99Z+vt7XQTbbR5pigJdSd6
eBpMWQg/LeWU2Us9TGXl4Rx2P+3kBinhfKAF+eLA3/4dsrgiaNH07hO4LoeHxJRv
248Mw4XRUSr8Z43mtBK6jnz5/pjO6GRHkXpnlvDb84cH3U4AnoX0czFf1+gWHYN6
3Bh2Gdx8BTnq+Y6BvmnmYp6R9gJJdw==
=WqnX
-----END PGP SIGNATURE-----

--w6UHe7CRbEp6v3rg--


