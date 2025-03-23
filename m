Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC1DC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhlF-0002xY-1Z; Mon, 24 Mar 2025 09:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkd-0002t9-LS
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhka-0007XD-97
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hdaAXwkVpc+e3DjsV11aCwViY1TvgwnAjS6IVuAqSUg=;
 b=g4b3ybPoP87he2prpfxwK71XfJl9G4aIwFubc/Om+Q/tX4EaNv203O7kIGs3xvPK4Bp07c
 CeMfe6HvrV7cRuABegx5jaGB+7UsBStX//TEs+tp6F8LF7zM9y+mc9byNkIGwEbftdcsDj
 NbD+cZZBF1851n4Jjwo6vVbhP+8DCu4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-05ar8HDINm-ba53Qy0oQ5A-1; Mon,
 24 Mar 2025 09:21:51 -0400
X-MC-Unique: 05ar8HDINm-ba53Qy0oQ5A-1
X-Mimecast-MFC-AGG-ID: 05ar8HDINm-ba53Qy0oQ5A_1742822510
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DE919560BC
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:21:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D699F1955BC1; Mon, 24 Mar 2025 13:21:49 +0000 (UTC)
Date: Sun, 23 Mar 2025 18:30:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/24] Mostly Rust changes for QEMU 10.0
Message-ID: <20250323223002.GA41923@fedora>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRhtFQSb4aBlMVU6"
Content-Disposition: inline
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--jRhtFQSb4aBlMVU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--jRhtFQSb4aBlMVU6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfgi2oACgkQnKSrs4Gr
c8iwrwf/cTkuLUqzJC1wzTorPFv/pATzIuo6zri//JLYPPCvDuTe5p30gZdCDMdr
9pMi81clNQf1DpKvqCIA96YZ9GKq/qpG3lQY7JF5jBxTMwEMQ4PmQNBuTkIVWv7H
FIaJMxMbery86nonCGAO9YXpbeJDl/tCMpJtOgBEUso3IGaZbWfjdesZjxu0L0zG
K3KpRrqu4OGQFl9ttw1o2k4APIyX5/mMyqHXzFaopCESB9H0Iuv23X9MEEzrYSHP
0MxZlaLaP3bDXbY03DjjwGLGuPvoktzr1Uv6mAdwCkhZK8w4fiiw1LAtkftUxFg0
YMt+Be+Ou55HxnUBEal1KqnEUfKm8Q==
=5T17
-----END PGP SIGNATURE-----

--jRhtFQSb4aBlMVU6--


