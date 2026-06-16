Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0917CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXZm-00059J-C5; Tue, 16 Jun 2026 13:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZXZk-00058u-9t
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZXZi-0003IL-E2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781630864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JSK4uo60+R3Ix2N8zrVROUKQ+Lcpf8mdeqDNtzUXFo=;
 b=dJltNmRxF9JyUZSocoao82MDELhNh4/jHp33HQ9LlAFJQpFnXnv/Ac63bMGMBKUCnIMreU
 9cMFHB6oUs7lvEE2gTYqCrlmvbr251Rbti3CvVaAnAqhbMZh7/6dJnbeC011u9OO4kuzmY
 kZ7HcZnYGEr3enhX1mR3yTXhJgqTk+4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-up5YxH8XMACtuU1M-oevLQ-1; Tue,
 16 Jun 2026 13:27:40 -0400
X-MC-Unique: up5YxH8XMACtuU1M-oevLQ-1
X-Mimecast-MFC-AGG-ID: up5YxH8XMACtuU1M-oevLQ_1781630859
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03FE6180AC57; Tue, 16 Jun 2026 17:27:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3F9E3008DCB; Tue, 16 Jun 2026 17:27:36 +0000 (UTC)
Date: Tue, 16 Jun 2026 13:27:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/83] riscv-to-apply queue
Message-ID: <20260616172735.GA558674@fedora>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gmDgmTk7NJ2k6LPU"
Content-Disposition: inline
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--gmDgmTk7NJ2k6LPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--gmDgmTk7NJ2k6LPU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoxh4cACgkQnKSrs4Gr
c8iZFwf/VzxhTrL+T7SyFlu5ML6Cc+da4lpm3MnlfVobrHFOxaQQI5kiNQ8x7zsZ
2wjlFu00MqoLH38tUdk4beE10G3cA/jtzt6HGjju0ZIKipm/2H2y0KrtyQBG3CCl
F6SAhmvxT42ilu+pzgMca9yo4WyHkykorn5ZwoL082LxJIj41G0FGbqRP1/QQAzr
8EtqKOTCLo+FMIvF5AVw+TswWQFytPlKBmJ9ymqZ3XLcoIGtd52YOh7ibC6eh7Zj
PuQsrxDaYnFvMkVn84jC+WEeSkgEenu6aTBnTtKyYpVW71Ayx4AMW6kPeKhwnaYn
dxBwRREb0ekf8f7YqymZirO4AsSrzg==
=rUQh
-----END PGP SIGNATURE-----

--gmDgmTk7NJ2k6LPU--


