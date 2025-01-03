Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59CFE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlfh-0004g2-KU; Fri, 03 Jan 2025 12:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tTlfZ-0004fG-Sc
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tTlfS-0006iJ-Sa
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735926058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFTckocCLRcqwgQmBcIBHr4k5p8+41AtD3VJt5MsTX8=;
 b=ePb2pzKpxzOygsPZ+I10iIM0w5pILl7G9OPyVCr8k6+4J6fJpdTDAqyN8P0oGBI0HJrQA0
 0MMpe22VM6SgP3VTgaz9peW6Qlz7jkcX2/tEp21GHoW5iGd1Nyt/LZ8XCVWv3x76jXuF0C
 n3/2R//h/8nST4Z8QV2wqoN97awQtcs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-FCurZKa7MryfcjoUNNOXaQ-1; Fri,
 03 Jan 2025 12:40:55 -0500
X-MC-Unique: FCurZKa7MryfcjoUNNOXaQ-1
X-Mimecast-MFC-AGG-ID: FCurZKa7MryfcjoUNNOXaQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BC871955F54; Fri,  3 Jan 2025 17:40:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.169])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21F403000197; Fri,  3 Jan 2025 17:40:52 +0000 (UTC)
Date: Fri, 3 Jan 2025 12:40:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] QTest patches for 2025-01-02
Message-ID: <20250103174031.GA1248553@fedora>
References: <20250102220629.11351-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gXa+xjREEYId1Hpo"
Content-Disposition: inline
In-Reply-To: <20250102220629.11351-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--gXa+xjREEYId1Hpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--gXa+xjREEYId1Hpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd4IQ8ACgkQnKSrs4Gr
c8hUbAgArs/nz5SWL8u8taWSAaAm6x/ApXfcNp+axUbPWDtXgGb2WqODNTKMKVqT
C/LTCP9xlhec7lA0ubj5j3lpI9OAPQQr7jHRGZZ9QJJaCzhYbvjqrwB+blLBMrwq
uSGAaFOVxDo/adt2t5TeKDtMod2C6o6NQfotCIx4tQC0EqVqYCs1LMx96jVelS6E
a/mjMvCjPJoGwnd9DYIEJ+wkCFcH5YdLzFU5KUXdnm1TDraLuYOI3/jS9GayBOOI
6UOah3wxFWDtV11dxtfF7JUPotBy4YbxQHEtNkcgIXLadsXJszRDkbueAayU8zIM
jRi+4ayCYaY16gMISz4CXxsgTJGzBg==
=G8k+
-----END PGP SIGNATURE-----

--gXa+xjREEYId1Hpo--


