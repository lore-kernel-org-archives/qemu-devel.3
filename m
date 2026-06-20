Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B38CDB46B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 13:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waw9n-0000M2-5Y; Sat, 20 Jun 2026 09:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waw9g-0000LE-JU
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 09:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waw9f-0007ZU-Ah
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 09:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781963678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFqTnjWUrOsUauEKaiY/KdLrZIQf/63N7QHq3InDHI4=;
 b=hAKVL0CXzTCCPSktikB3znXB6KM+bkEbLXQkn2ZGgJS9gj77BPp2VdC/gp9aWnpK3mwJx3
 uZVKjttTJevNXOQnEvzRjW9ImWGyscZnOiMjyTP1Jt2OTAhAa8C8HyoBDrxSU/X+b6HxEu
 en6Y+KtdmJhUsm380rYaqAkc3/yuH6U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-5ZpwF0E7NsOuaopmwytKfg-1; Sat,
 20 Jun 2026 09:54:35 -0400
X-MC-Unique: 5ZpwF0E7NsOuaopmwytKfg-1
X-Mimecast-MFC-AGG-ID: 5ZpwF0E7NsOuaopmwytKfg_1781963674
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC644195608C; Sat, 20 Jun 2026 13:54:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29D1518005B0; Sat, 20 Jun 2026 13:54:33 +0000 (UTC)
Date: Sat, 20 Jun 2026 08:40:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] Plugins update for 2026-06-18
Message-ID: <20260620124048.GA74461@fedora>
References: <20260618234749.1659878-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i4qOSGbBBo9Byaxe"
Content-Disposition: inline
In-Reply-To: <20260618234749.1659878-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--i4qOSGbBBo9Byaxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--i4qOSGbBBo9Byaxe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo2ilAACgkQnKSrs4Gr
c8jgNwgAti2yirrRpk8atndK6OIul3VwXFvH4Ff3EyhkRTzrnis2qeCH3iQEAAJA
JXax5qIf8+juL/STUTzo5s91txxOoYyETRbZw82xYLCf9F8Npnoa3khbDxwF0YF0
e8wTolq9b6e+88fumvhDOfSWgtUhctL29htM5bS7gXLfGdQEcWffouUBhykQEbbp
wTYP5S2t81xGZYtBN54azo4HZhZJtEs2wJGfqmMq2M8SmDfDncCIyMLS7wRQCq8A
3iPaCOc5QbE/IDCUCT3m928g+rqQca+WN5WG2pXoPTAUvvuve4AE2jTSZYEqn9fH
r1YUdCHlTv3izBxnZJc17RG1/XVwyA==
=j6rA
-----END PGP SIGNATURE-----

--i4qOSGbBBo9Byaxe--


