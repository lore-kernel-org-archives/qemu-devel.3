Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D19E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuQt-0000vu-PW; Thu, 12 Dec 2024 20:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQc-0000nO-O6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQT-0003DV-S4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734053105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cUT2lCbV+mVWonr0FQo0GU105YX5Dsk+7EY6xFs1zOA=;
 b=immZHkYAm9zVsrpAho0W064hsblVRWzichkHIrfh207tG1YV7/mqtAW5ke0PpGInsdc3UA
 LiIOD4o2NCwOc0ZYkA0np9U36XE5SU0295zxxA74uGt2Em69gKaVQj1yxOy4rKTC0tCqfE
 K1HbIMjNO5FIzrIi0kH8qwNII9jrM+c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-L-YOSmZINLWNBt7lIaEIKg-1; Thu,
 12 Dec 2024 20:25:03 -0500
X-MC-Unique: L-YOSmZINLWNBt7lIaEIKg-1
X-Mimecast-MFC-AGG-ID: L-YOSmZINLWNBt7lIaEIKg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB58D19560B2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 01:25:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 126061955F40; Fri, 13 Dec 2024 01:25:01 +0000 (UTC)
Date: Thu, 12 Dec 2024 20:21:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/49] rust, QOM, kvm changes for 2024-12-11
Message-ID: <20241213012104.GA395433@fedora>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A6YIpAhnzZmqPLRW"
Content-Disposition: inline
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--A6YIpAhnzZmqPLRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--A6YIpAhnzZmqPLRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdbjAAACgkQnKSrs4Gr
c8iTygf/YunEuzEGtLpK13HWWcgyXC3BR9vjHGGMIbbph4BDaiUuMurJ4SwqynRk
VdC9kkcrc4TCUCn9YSD1gw+8kqNJDNha/LizZhI9njAiR7n4N0DCDhg9dg9kXfKd
wV/Di/psm+93dnBanr6MEEdpKIhdYbYKQwxGoegzR03rW/Q/2u+6zn2hEFdUCnbn
QH0oQOfB6YfdLLYdhKAku+/vAl4xzJxk+5W4xINiTiEKZwAkZlLlxcQ7kLvO8eqH
geWPCWzEkDGKt4dPUydu511SbeaJfzhS8cu53mQPJxBue2CIgLV1pjgWujseIGs+
Oh6JsZ2AYCmc9IAVDuQiw1zGcNLDFA==
=C3Sw
-----END PGP SIGNATURE-----

--A6YIpAhnzZmqPLRW--


