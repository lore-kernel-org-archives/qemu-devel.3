Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB0C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58R3-0004P4-6D; Thu, 09 May 2024 14:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58Qz-0004In-PF
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58Qx-0005Lh-TM
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715279039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=buP4gxnAy6spxp4Uhj5hpXyQ+WyJme2dmgJ2I4lcDr0=;
 b=fNCdJMLpsnqcy0KHX8VTWvvTev+kBOeHb7W3+SzHb5+zfVwWQHOioiXt0RWY4XvrFudwTw
 wz7UMyfstdX8J85c3VxrDD3K3vM41WplQ/US1+zOdD/4i1Co/P7hRzn4pArX0gz+e8enVu
 7qQiVw1T3ZlEcBftP7v7+4q5c4wddQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-w0diAoRDMWiXWRNRKhfDDg-1; Thu, 09 May 2024 14:23:56 -0400
X-MC-Unique: w0diAoRDMWiXWRNRKhfDDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 662A6185A78E;
 Thu,  9 May 2024 18:23:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D77A14215A0A;
 Thu,  9 May 2024 18:23:54 +0000 (UTC)
Date: Thu, 9 May 2024 14:23:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 2/9] block/raw: add persistent reservation in/out driver
Message-ID: <20240509182353.GD515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-3-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="32XG4NKhborEfAQn"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-3-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--32XG4NKhborEfAQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:22PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations for raw driver.
> The following methods are implemented: bdrv_co_pr_read_keys,
> bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
> bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  block/raw-format.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--32XG4NKhborEfAQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9FLkACgkQnKSrs4Gr
c8imFgf9HLjmjnCs/bUgvs7HhG4aps1ggcp3aoNSZUFYONa3YoNy1L4/wvysLt5R
dyJqxU3XleMVl6d2jhEwrIeBHopfY26IUTmpKa9++raL9Yct3JLvI49PvX7bVzN+
lmQCyGELMuri9q3wv0PDV4/DjZhDTQO2wjNWeQHQQjoVicXw+Fea+HOi/3Ah+xRs
2RVqPA/G8IlRId9cKEge2kBneTo5PEbABOI+FT28Si4FCHjvjqcfmyOh1Rclbf11
2IEkOwWSFwI0jwc2RVbVtnSxZ1XoJ+Lmtxg1IBQpAuZ1GK5ceooYxOb/fzQBUH46
nIIB+NAXDl+VlGVxksSSiPlgRFJCQw==
=zmjw
-----END PGP SIGNATURE-----

--32XG4NKhborEfAQn--


