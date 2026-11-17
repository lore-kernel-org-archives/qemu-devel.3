Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACE606A33A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWOUunSn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNZZ-00009G-Tn; Tue, 17 Nov 2026 13:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xTNZN-00008b-PP
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xTNZK-0002Io-1M
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794938767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UFxEddnRduTVMaavKJtp2auH6d09ds1oBcPU55jI9E=;
 b=YWOUunSnHJAQKOsK0bC2mNvlNbu6Fu4ufgx4Cj0Xsx1/hdxe9k7+mP3e1kPcqCV7OdH8ov
 BtUjL8D+4762glgxFWpFasKOcrDfegNag0OpWPiynvDEamzWPqHjwShtGtndNhBvt1vB81
 h6BAeIq2Wvx1sUiAXdOIB5+7wUfXpXE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-xQYCKA3fO3eVInrsk-Psgg-1; Tue,
 17 Nov 2026 13:06:04 -0500
X-MC-Unique: xQYCKA3fO3eVInrsk-Psgg-1
X-Mimecast-MFC-AGG-ID: xQYCKA3fO3eVInrsk-Psgg_1794938763
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96F7E1955BDB; Tue, 17 Nov 2026 18:06:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA55E1801976; Tue, 17 Nov 2026 18:06:01 +0000 (UTC)
Date: Tue, 17 Nov 2026 13:06:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 bea1e@proton.me, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/4] nbd: Add iotest exposing previous CVE fix
Message-ID: <20261117180601.GA391996@shajnocz.csb>
References: <20261113223742.2546619-6-eblake@redhat.com>
 <20261113223742.2546619-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113223742.2546619-10-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 04:34:52PM -0600, Eric Blake wrote:
> Feifan Qian posted a sample script generated with the help of AI that
> created a known-broken NBD server that intentionally replies to a
> structured read with only a subset of bytes, to expose the leak of
> heap data from qemu as an NBD client into an emulated IDE drive. Take
> the idea of that test, but simplify it into a qemu-io test (much
> lighter-weight NBD client, and easier access to see what bytes the NBD
> client code is passing on) that more closely resembles paradigms in my
> recent nbd-robustness iotest.  Also, expand the test to cover multiple
> scenarios: in addition to the original test demonstrating a prefix of
> 20 bytes with unwritten tail, I expanded it to cover out-of-order
> replies, a hole-only reply, and a completely empty reply.
> 
> Reported-by: Feifan Qian <bea1e@proton.me>
> Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/3815
> AI-used-for: tests

QEMU's current AI policy forbids AI-generated code.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  .../tests/nbd-structured-read-gaps            | 215 ++++++++++++++++++
>  .../tests/nbd-structured-read-gaps.out        |   5 +
>  2 files changed, 220 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/nbd-structured-read-gaps
>  create mode 100644 tests/qemu-iotests/tests/nbd-structured-read-gaps.out
> 
> diff --git a/tests/qemu-iotests/tests/nbd-structured-read-gaps b/tests/qemu-iotests/tests/nbd-structured-read-gaps
> new file mode 100755
> index 00000000000..9f8b3b8b20b
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/nbd-structured-read-gaps
> @@ -0,0 +1,215 @@
> +#!/usr/bin/env python3
> +# group: rw quick

Does this run in CI without the "auto" group?


