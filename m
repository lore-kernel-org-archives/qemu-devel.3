Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2978C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTP5-00084G-T4; Fri, 08 Aug 2025 16:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ukTP3-00083I-9r
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ukTP1-0006Se-H9
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754683761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Y4JRj4tfIscxxb+wAvASuzU+/B4SZ/oPZY8W5Z8uHY=;
 b=XHgYhnX8XgEyrIixJ7sq1Na1+XgDmWqI2XXQQblTJVMhT3lpV/7YYaIScOr3Qhl/IgfhH9
 XIzCZlQLeV7QWRb4mwshS3jOQyw12pbB2nFsQCzC3ewH/Yoa8DLlwVLZ1cDpY9drV0XlH2
 4+FFfZwhV7wOjhJSxM9d2S4I2uXvUmc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-sPGS5-6zOryBocoCzqqQdQ-1; Fri,
 08 Aug 2025 16:09:18 -0400
X-MC-Unique: sPGS5-6zOryBocoCzqqQdQ-1
X-Mimecast-MFC-AGG-ID: sPGS5-6zOryBocoCzqqQdQ_1754683757
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B123180028C; Fri,  8 Aug 2025 20:09:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.42])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A06623001455; Fri,  8 Aug 2025 20:09:15 +0000 (UTC)
Date: Fri, 8 Aug 2025 16:06:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, qemu-stable@nongnu.org
Subject: Re: [PULL 0/1] loongarch bug fix for 10.1
Message-ID: <20250808200629.GA164863@fedora>
References: <20250808011157.375125-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TcRFlPMSM5JLSKOE"
Content-Disposition: inline
In-Reply-To: <20250808011157.375125-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--TcRFlPMSM5JLSKOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--TcRFlPMSM5JLSKOE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiWWMUACgkQnKSrs4Gr
c8jKQwgAgiLzxhN+yBm2z70mVC+v+41AG0WYpEUTcfPcqc5y83VuX0WdrBUeHLPP
MNZAWYdmsSjE4ONnUgC08YBKRNO2TbpT1b7p7aal+N0W7AM6Fjkvf5VQHQEz/wGX
T//6jpT8JoZkswdM3rkM2tcGriRA0whYrNK7D4/fnmRJUY5f5XKJ55OeapZlG5OV
eliAvm4kw67/gghZx90ytVahxrq9f+Wf2a1CNta9OcuHy7x/alGPSL2ipnLgjILO
fIgt/+bR5KpknQ0UvGhvbQ32ve+FNrQG1H8IYMgbQye1IjPZFWtni1aUlnWgDvtT
7vQhz4jAjkztnFb+2MwN7Uce36gwsQ==
=9YJZ
-----END PGP SIGNATURE-----

--TcRFlPMSM5JLSKOE--


