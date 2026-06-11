Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB68ACD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 23:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXp9P-0006Tf-Pu; Thu, 11 Jun 2026 19:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wXp9O-0006T3-F6; Thu, 11 Jun 2026 19:49:30 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wXp9N-0000Yd-2w; Thu, 11 Jun 2026 19:49:30 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C8806020C;
 Thu, 11 Jun 2026 23:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4FD1F000E9;
 Thu, 11 Jun 2026 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781221767;
 bh=COu1STdPoAgWwePNwAMSL8H8wAoa0DtVhQIwj56eFfA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=ObWR2lY656T+7jOhksGXZZM3/WxiY0R2GKdAh4eGZ8P9VNLMPidtVn8Hs6ecSpWf6
 I5AzWCBxnFNlWRqJf9foqp7+t/WivUXLIW4oFharWGnwqRYBzc8zYmPDHAspmdKIem
 Mdxk4gBd+LrJufjJiyuARi9M5POqVV/LjNjs8y2Uhk8ZJZK0tsyCa+eV4xA/g8IBDd
 axxouFyO17/gBUPq6/c9bq7gfMeSC+ApUgxW6MWbLbAqYWv6SibvD+sl6P7Zz4z0v8
 8h7PhGd7T10mOuvubhRC8wVe5twMzfySGGb+gx9eNTUgJwWYLRRFoVILkyJC52FKBC
 Mk77Hc6uXoIiA==
Date: Thu, 11 Jun 2026 16:49:25 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 3/8] 9pfs/xen: implement msize_limit callback
In-Reply-To: <7f592f8cdeeea8b91998363ad9599dfb1f2b3108.1779916560.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.22.394.2606111638240.368315@ubuntu-linux-20-04-desktop>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
 <7f592f8cdeeea8b91998363ad9599dfb1f2b3108.1779916560.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=sstabellini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 27 May 2026, Christian Schoenebeck wrote:
> Add and implement the msize_limit callback for the Xen transport.
> 
> The limit is calculated using XEN_FLEX_RING_SIZE() based on the
> negotiated ring_order. For the theoretical maximum ring_order of 9,
> this results in a maximum 'msize' of 1048576 bytes (1 MiB).
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/xen-9p-backend.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index ca0fff5fa9..94654022fe 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -250,12 +250,19 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
>      qemu_bh_schedule(ring->bh);
>  }
>  
> +static size_t xen_9p_msize_limit(V9fsState *s)
> +{
> +    Xen9pfsDev *xen_9pfs = container_of(s, Xen9pfsDev, state);
> +    return XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
> +}

This is correct as a computation. But there are multiple rings with
potentially different ring_orders (although I have never seen it in
practice.)

So I think something like this would be better:

---
size_t limit = XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
for (i = 1; i < xen_9pfs->num_rings; i++) {
    limit = MIN(limit, XEN_FLEX_RING_SIZE(xen_9pfs->rings[i].ring_order));
}
return limit; 


>  static const V9fsTransport xen_9p_transport = {
>      .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
>      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
>      .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
>      .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
>      .push_and_notify = xen_9pfs_push_and_notify,
> +    .msize_limit = xen_9p_msize_limit,
>  };
>  
>  static int xen_9pfs_init(struct XenLegacyDevice *xendev)


