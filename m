Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF2DC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 12:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKcU5-0000Sg-3O; Thu, 29 May 2025 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKcTv-0000Q6-RB
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKcTq-0007ba-TZ
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748522128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRDVRpB8OFZSrpPv4F9sDjcuQCj2wEAeUF+AqcWuAN0=;
 b=VgcNM+2iACEo6D4cGe5moJLa75k4sgwbjAasjm4oQbKAyiezxwl4cqta3jv1z4SH6vfj5s
 shik+omYJ2tfIHdNHsx8X56zeXJG7b1/Q8t3mZmHgLlpbYHuM6yjUjU/9wm7SFC6hH/zme
 s8ScTHsjq1pWQRzcwBvD5GA9qchtHLI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-CiNMwXxuMY-nchBVYIWIgw-1; Thu,
 29 May 2025 08:35:26 -0400
X-MC-Unique: CiNMwXxuMY-nchBVYIWIgw-1
X-Mimecast-MFC-AGG-ID: CiNMwXxuMY-nchBVYIWIgw_1748522126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA26D1800570; Thu, 29 May 2025 12:35:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2247319560A7; Thu, 29 May 2025 12:35:24 +0000 (UTC)
Date: Thu, 29 May 2025 08:35:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] qemu-sparc queue 20250527
Message-ID: <20250529123523.GA55766@fedora>
References: <20250527214605.350903-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vMGh+baLXUDgifjK"
Content-Disposition: inline
In-Reply-To: <20250527214605.350903-1-mark.cave-ayland@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--vMGh+baLXUDgifjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--vMGh+baLXUDgifjK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg4VIsACgkQnKSrs4Gr
c8gZOggApIU0lYnU4EhzfzL4w0e3HJNLKgrJ3Y/D2ZO6Dt+TufokHmm+8esK8pFt
pw7LCDAkpkR0HpldXgYddzDG0axFpBjlB7K8hqDzl81P+ymE5xO+UmqzkCI3f+M6
0jVQmsBvmOeOxqLa9n7nfqSE81sIvnOr/KrIWGJHsDJaeaIoR076+6W2ZfrEhRtj
OOwXdLplCHgpKlLbJ2pxNM3Jwr2J2ojmsyDEfAQ2nZCcFm+3gEHYe04kvB/YIxRN
15Eb6nW4rJjJ0aAcvR1h9nDN8EWwa16xKYD9SYoPRtIN3RSaFf9+kyQcEJot2w0a
dFmHbzspqopA0oQ9GM+zSEoMU6i74g==
=o8Nb
-----END PGP SIGNATURE-----

--vMGh+baLXUDgifjK--


