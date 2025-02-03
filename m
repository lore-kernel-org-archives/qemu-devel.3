Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD3BC02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf2Vm-0006jK-Hq; Mon, 03 Feb 2025 14:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf2Vk-0006iy-W1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf2Vj-0002rt-Fo
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738612413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1uCKYju7+hNbHT22oBt/7x3bUWwi5a87qdOd0gI/do0=;
 b=V3CO5qrkU/CLqB8VXzRgzgAhonb8CeoK503byIartstzsfOJufTQvgLk8LqswFzKc9nal4
 gPaDfEB4uQPZFMcfKNp8SnZDQzfpmQiJDUEbhxZWtTTtvWZKmzAWiKo/icwqNU8U5oLCFz
 H1svqoN0/iAIbjzdRD52NaYzQ0Khz7A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-xTQaMQGPOa24cXbXifgV6Q-1; Mon,
 03 Feb 2025 14:53:30 -0500
X-MC-Unique: xTQaMQGPOa24cXbXifgV6Q-1
X-Mimecast-MFC-AGG-ID: xTQaMQGPOa24cXbXifgV6Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8ABB1955F79; Mon,  3 Feb 2025 19:53:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.73])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6EC81956095; Mon,  3 Feb 2025 19:53:22 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:53:19 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, 
 Wen Congyang <wencongyang2@huawei.com>, John Snow <jsnow@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] block: remove unused BLOCK_OP_TYPE_DATAPLANE
Message-ID: <2uddqladnu54zon2zzxhwkcdnspq3pnsasmvxeirnbinn5l4kr@3d2mvyjy52kp>
References: <20250203182529.269066-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203182529.269066-1-stefanha@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 03, 2025 at 01:25:29PM -0500, Stefan Hajnoczi wrote:
> BLOCK_OP_TYPE_DATAPLANE prevents BlockDriverState from being used by
> virtio-blk/virtio-scsi with IOThread. Commit b112a65c52aa ("block:
> declare blockjobs and dataplane friends!") eliminated the main reason
> for this blocker in 2014.

Wow, that's a long time.

> 
> Nowadays the block layer supports I/O from multiple AioContexts, so
> there is even less reason to block IOThread users. Any legitimate
> reasons related to interference would probably also apply to
> non-IOThread users.
> 
> The only remaining users are bdrv_op_unblock(BLOCK_OP_TYPE_DATAPLANE)
> calls after bdrv_op_block_all(). If we remove BLOCK_OP_TYPE_DATAPLANE
> their behavior doesn't change.
> 
> Existing bdrv_op_block_all() callers that don't explicitly unblock
> BLOCK_OP_TYPE_DATAPLANE seem to do so simply because no one bothered to
> rather than because it is necessary to keep BLOCK_OP_TYPE_DATAPLANE
> blocked.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/block-common.h | 1 -
>  block/replication.c          | 1 -
>  blockjob.c                   | 2 --
>  hw/block/virtio-blk.c        | 9 ---------
>  hw/scsi/virtio-scsi.c        | 3 ---
>  5 files changed, 16 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


