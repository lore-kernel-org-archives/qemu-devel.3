Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1FDC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2NV-0001bk-Ei; Thu, 06 Feb 2025 08:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tg2NT-0001b5-FD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:57:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tg2NS-0006G2-1n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738850229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM55rJnlW0KfBWwmNwRGshhYG2LoNYfdkcXgz4DdSAs=;
 b=XP+DKL3ONEm0LPiPVn7qvTty++/XCXSvO3sm/N0VY8oHBXmowQFOVF0ulFxitjWHjN8jac
 5ecIFFZnIPWCovC6Tm+thnpsSDINpipmb7UQ2yEULJXsuf47ZiJP4KVYdQfM89cfg1ED8H
 dE5JGfmVCnjLkq5XdGZS39UWOI3A0J8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-KBTNeyb8MpugFP1pizxyxg-1; Thu,
 06 Feb 2025 08:57:04 -0500
X-MC-Unique: KBTNeyb8MpugFP1pizxyxg-1
X-Mimecast-MFC-AGG-ID: KBTNeyb8MpugFP1pizxyxg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E767185FBD6; Thu,  6 Feb 2025 13:56:47 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E09281956052; Thu,  6 Feb 2025 13:56:42 +0000 (UTC)
Date: Thu, 6 Feb 2025 14:56:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Wen Congyang <wencongyang2@huawei.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] block: remove unused BLOCK_OP_TYPE_DATAPLANE
Message-ID: <Z6S_mA0kRs1OFget@redhat.com>
References: <20250203182529.269066-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203182529.269066-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 03.02.2025 um 19:25 hat Stefan Hajnoczi geschrieben:
> BLOCK_OP_TYPE_DATAPLANE prevents BlockDriverState from being used by
> virtio-blk/virtio-scsi with IOThread. Commit b112a65c52aa ("block:
> declare blockjobs and dataplane friends!") eliminated the main reason
> for this blocker in 2014.
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

Thanks, applied to the block branch.

I've actually had pretty much the same patch lying around for.. *checks*
five years, but never sent it because I intended it to be part of a more
general op blocker removal series. I don't think we actually rely on any
of them any more, but proving it was still hard when I tried.

One additional part my patch had is removing blk_op_is_blocked() because
it's now unused. I'll send this as a separate patch.

Kevin


