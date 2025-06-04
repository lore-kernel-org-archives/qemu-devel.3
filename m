Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FFDC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnKQ-0005mn-Pv; Wed, 04 Jun 2025 08:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMnKH-0005lf-S7
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMnKF-0005zW-Cc
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749040473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+3CJqWUwBQcZJEJRneSyGB+Lre/ILcsyLlGZ4AwCzY=;
 b=fPcDNWLBpEZC4Dt3duv+zjSplQQPTsjwlXnDbWgPD3fl2dO9xPjtI2AOWs7xTo11jYNhzj
 jDXbqSOtXIiRG9Ueb/1GWXFzlB6r+KC4U7qf88JJGbzIoN9L8s46kDEgeoSAFmVM6y24ao
 a+u4o/ne+NXV7eBNzyqw7ZC5jVCeDeo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-cZCFRVhJPnqQ3P8mfyWJ4w-1; Wed,
 04 Jun 2025 08:34:30 -0400
X-MC-Unique: cZCFRVhJPnqQ3P8mfyWJ4w-1
X-Mimecast-MFC-AGG-ID: cZCFRVhJPnqQ3P8mfyWJ4w_1749040469
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C365C1956087; Wed,  4 Jun 2025 12:34:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD22A18003FC; Wed,  4 Jun 2025 12:34:25 +0000 (UTC)
Date: Wed, 4 Jun 2025 14:34:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] iotests: fix 240
Message-ID: <aEA9T6rLy5CgyQ-h@redhat.com>
References: <20250529203147.180338-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529203147.180338-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Am 29.05.2025 um 22:31 hat Stefan Hajnoczi geschrieben:
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

Thanks, applied to the block branch.

Kevin


