Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15BAC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 21:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKkZi-0006RC-4B; Thu, 29 May 2025 17:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKkZg-0006Qf-Qn
 for qemu-devel@nongnu.org; Thu, 29 May 2025 17:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKkZf-0004yA-FY
 for qemu-devel@nongnu.org; Thu, 29 May 2025 17:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748553242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1eciExN+SEUePgb1+Fe6TEcezsfA8dek2Tob4bfSBUE=;
 b=PljFCXjQwCNUciQGd8PbSQYZIwcdBWgnSeqkok8fpNNqoFN2kG+1hgpwA4P8I5OEoIi7YC
 fTRq9T/RUZgbSigw6v5WcRBwoEJaUWRYuvPFfcvL7ayHerX/qGov26nj/s01G8MSOZM6I/
 OFkkvb+7XDl725TFgR+kBWX3ipcRqfg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-8q5t1UE4Oq-UMHsPKy3mrw-1; Thu,
 29 May 2025 17:13:59 -0400
X-MC-Unique: 8q5t1UE4Oq-UMHsPKy3mrw-1
X-Mimecast-MFC-AGG-ID: 8q5t1UE4Oq-UMHsPKy3mrw_1748553238
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73EFC1956089; Thu, 29 May 2025 21:13:58 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 704BA1954185; Thu, 29 May 2025 21:13:56 +0000 (UTC)
Date: Thu, 29 May 2025 16:13:53 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] iotests: fix 240
Message-ID: <nzzp3vvg2ev6m3dc3wgg4hpgcog5pvwxrtafnvo5ybe35yyvh3@xsxbjwydngpd>
References: <20250529203147.180338-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529203147.180338-1-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 29, 2025 at 04:31:47PM -0400, Stefan Hajnoczi wrote:
> Commit 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
> removed the limitation that virtio-scsi devices must successfully set
> the AioContext on their BlockBackends. This was made possible thanks to
> the QEMU multi-queue block layer.
> 
> This change broke qemu-iotests 240, which checks that adding a
> virtio-scsi device with a drive that is already in another AioContext
> will fail.
> 
> Update the test to take the relaxed behavior into account. I considered
> removing this test case entirely, but the code coverage still seems
> valuable.
> 
> Fixes: 2e8e18c2e463 ("virtio-scsi: add iothread-vq-mapping parameter")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/240     | 2 --
>  tests/qemu-iotests/240.out | 4 +---
>  2 files changed, 1 insertion(+), 5 deletions(-)

This one has been annoying me - thanks!

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


