Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09429E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 17:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP3ep-0008Fj-Rw; Sat, 21 Dec 2024 12:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tP3eo-0008FW-7T
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 12:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tP3em-00040E-UP
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 12:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734803571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtyboEOubh+u3cVlHtkYg5sM+g4sc1AEW0UvUD65ARM=;
 b=Eb/goguTfBJWwu4WERCQq5+zUbmVWBBFvgkZjsLW50blQBx3GVRreVR2ifqi4wELTsPF9A
 vAQjVtetgPE2c8GBfjDcaC99+L0xaVf19TJiZXyuux4JBLk6BJz2UE/uclIbwow5pH6e8V
 QPi+dzJmmCc4HSQ1mMdUZw60RorPtsk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-zR_yRuJ6Pqeu5L621M1bGg-1; Sat,
 21 Dec 2024 12:52:48 -0500
X-MC-Unique: zR_yRuJ6Pqeu5L621M1bGg-1
X-Mimecast-MFC-AGG-ID: zR_yRuJ6Pqeu5L621M1bGg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A572195608C; Sat, 21 Dec 2024 17:52:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54EB51956088; Sat, 21 Dec 2024 17:52:46 +0000 (UTC)
Date: Sat, 21 Dec 2024 12:51:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL v2 00/39] riscv-to-apply queue
Message-ID: <20241221175106.GA857515@fedora>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="afQdIuUWW8P90qz7"
Content-Disposition: inline
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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


--afQdIuUWW8P90qz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--afQdIuUWW8P90qz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdnAAoACgkQnKSrs4Gr
c8hM1Qf+P8mIwmm0E/RkBsEVfUPY5/zKprhvlGWkHENDaVGWwUUf+FEP1NNn0g0Z
9tJGbce92b2omP6HsuB0sj/17iiaqGTTrpQ3yIrmfU/5XDfmxq7SYXUKgTXTGSMm
P7rzhjcLWKT7pVxQhy0LRZLn7K2PrTrb4YHeH/RT5VMUCfg2d936hLtC0SRPmEXk
11WBEskxOJV++wffyQA/IxRoIduz6cl6B+iphskc9d0P9ifVRW8LOT1WhVyoRGfo
igq4UpBJFU34CmYqykJZo/RD56zf3VVo4zA2RIO+RlHQ2ijHcch04LjeSOPegVqa
Pe5RCGXFgOhNhrA4HnKSZ6rMrDvngA==
=oIXU
-----END PGP SIGNATURE-----

--afQdIuUWW8P90qz7--


