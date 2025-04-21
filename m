Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9DDC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 15:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6sg8-0000gC-Rh; Mon, 21 Apr 2025 11:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u6sg6-0000fh-F8
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u6sg4-0001Ix-Go
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 11:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745247797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ly3Mm+tnjygBZzcZWH1yRadMam6qz5grfXxneq7fb+4=;
 b=Od3rA48TOUc+5d0YkLAy/Mr9qiv4u7A4gk6rfIy6Q8kLZFG1vDjXDzWkf8I6B4kNoKtP7f
 rzCegnCAZ+hnu4Mj0e7GGmACMC04fXBPL4fGW3x+fVb8N4O8MgCv2IAxpShWZHo51+xbbn
 EeDD/IIzXHqdw6POJS66G2+lqRR1M4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-rdApaweMO4CTZXs8R5V_5g-1; Mon,
 21 Apr 2025 11:03:13 -0400
X-MC-Unique: rdApaweMO4CTZXs8R5V_5g-1
X-Mimecast-MFC-AGG-ID: rdApaweMO4CTZXs8R5V_5g_1745247793
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD4DB1800264; Mon, 21 Apr 2025 15:03:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 036AD180087B; Mon, 21 Apr 2025 15:03:10 +0000 (UTC)
Date: Mon, 21 Apr 2025 10:03:08 -0500
From: Eric Blake <eblake@redhat.com>
To: Sunny Zhu <sunnyzhyy@qq.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com
Subject: Re: [PATCH] =?utf-8?Q?block=EF=BC=9A_chang?= =?utf-8?Q?e?= type of
 bytes from int to int64_t for *bdrv_aio_pdiscard
Message-ID: <cxsasg7qiopbpwu24a6f2hponb2lv6ut5ylhcpeyagi6g6k2m5@w2c6mwuqi5ik>
References: <tencent_8649D99B33E6E6665A0EFA05B97592D70106@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_8649D99B33E6E6665A0EFA05B97592D70106@qq.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 21, 2025 at 12:19:14AM +0800, Sunny Zhu wrote:
> Keep it consistent with *bdrv_co_pdiscard.
> 
> Currently, there is no BlockDriver implemented the bdrv_aio_pdiscard() function,
> so we don’t need to make any adaptations either.

If there are no drivers implementing the callback, then why have it?
I think we have been moving towards more coroutine-based callbacks and
away from the aio callbacks; if so, should we instead be deleting this
callback as stale code?

> 
> Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>
> ---
>  include/block/block_int-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index ebb4e56a50..4bf422d733 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -507,7 +507,7 @@ struct BlockDriver {
>          BlockDriverState *bs, BlockCompletionFunc *cb, void *opaque);
>  
>      BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_pdiscard)(
> -        BlockDriverState *bs, int64_t offset, int bytes,
> +        BlockDriverState *bs, int64_t offset, int64_t bytes,
>          BlockCompletionFunc *cb, void *opaque);
>  
>      int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_readv)(BlockDriverState *bs,
> -- 
> 2.43.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


