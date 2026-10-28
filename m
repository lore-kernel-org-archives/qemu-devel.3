Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97B60A2608
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ExzQmKfU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9ew-0007id-3B; Wed, 28 Oct 2026 15:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xM9ei-0007ho-Eh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xM9ef-000815-U6
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793216987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0cMEy+KelTuBn0HTkPgUzAp7/VJRkU49VWsN961/YE=;
 b=ExzQmKfU0WKFPinkZFomZFOCZBqu0LLuOV+zyaVjVgBHLAUZAMkqKIz2rSEbUz26Vbn78i
 UFfLP2QwjfaLqwekgodCblLbw+nTGH61CUa6VEdccwzmIY0wTWSeRhhgwK8K+GappQ9/+W
 O69JMOnuLFHt9uB7yyRn9K8rf/svbqQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-Z3cEvb9OOzS8owORdBfPMg-1; Wed,
 28 Oct 2026 15:49:44 -0400
X-MC-Unique: Z3cEvb9OOzS8owORdBfPMg-1
X-Mimecast-MFC-AGG-ID: Z3cEvb9OOzS8owORdBfPMg_1793216983
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 578E2195605E; Wed, 28 Oct 2026 19:49:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6F201800586; Wed, 28 Oct 2026 19:49:42 +0000 (UTC)
Date: Wed, 28 Oct 2026 15:49:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, afaria@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] file-posix: Add 'accept-read-only-device' option
Message-ID: <20261028194941.GA1346282@shajnocz.csb>
References: <20261028171057.139326-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028171057.139326-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 06:10:55PM +0100, Kevin Wolf wrote:
> Kevin Wolf (2):
>   file-posix: Add 'accept-read-only-device' option
>   iotests: Add loop-accept-ro-dev test
> 
>  qapi/block-core.json                          | 19 +++-
>  block/file-posix.c                            | 23 ++++-
>  tests/qemu-iotests/tests/loop-accept-ro-dev   | 87 +++++++++++++++++++
>  .../qemu-iotests/tests/loop-accept-ro-dev.out | 19 ++++
>  4 files changed, 144 insertions(+), 4 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/loop-accept-ro-dev
>  create mode 100644 tests/qemu-iotests/tests/loop-accept-ro-dev.out
> 
> -- 
> 2.56.0
> 

Modulo Eric's comment about /dev/loop1 being hardcoded in the test
output:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


