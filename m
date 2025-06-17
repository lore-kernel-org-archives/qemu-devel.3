Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CA9C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 18:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRbAy-00080f-9e; Tue, 17 Jun 2025 14:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uRbAv-00080I-TR
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uRbAt-0006QO-NQ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750185405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zr1u2DFR54fB6AxtMCfL1bu08GxukSknrG/RCOyAjYE=;
 b=i/BezCKACqu4O8+ngVdpnLJMkTXLf2w7yVIkBw38rhSkWFSkPNyW4hUfGSDGCzzGtOudDa
 c44y8ieiq5fymc5K0D4r8YlLyXTHwOothLwciLhrcAlCWesbrX+sP02Y2J00dmjOfkOZrp
 EVKlbkOsCb6zZ9oXoLiVdfnosDLDC3I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-_WFrZLf6O8i8c6ktxgmoDg-1; Tue,
 17 Jun 2025 14:36:41 -0400
X-MC-Unique: _WFrZLf6O8i8c6ktxgmoDg-1
X-Mimecast-MFC-AGG-ID: _WFrZLf6O8i8c6ktxgmoDg_1750185398
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C6EE18089B4; Tue, 17 Jun 2025 18:36:37 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.43])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6101B1956094; Tue, 17 Jun 2025 18:36:32 +0000 (UTC)
Date: Tue, 17 Jun 2025 13:36:29 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, 
 vsementsov@yandex-team.ru, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it
Subject: Re: [PATCH 1/4] block/graph-lock: fix typo in comment
Message-ID: <eetgc37e3t4stv7vgbjkmu5l2flm4x7i3wsybxr4xd35zb53g7@t2cywplfzqyo>
References: <20250604120717.458445-1-f.ebner@proxmox.com>
 <20250604120717.458445-2-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604120717.458445-2-f.ebner@proxmox.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

On Wed, Jun 04, 2025 at 02:07:14PM +0200, Fiona Ebner wrote:
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  include/block/graph-lock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
> index 2c26c72108..67c8d04867 100644
> --- a/include/block/graph-lock.h
> +++ b/include/block/graph-lock.h
> @@ -169,7 +169,7 @@ bdrv_graph_rdunlock_main_loop(void);
>  /*
>   * assert_bdrv_graph_readable:
>   * Make sure that the reader is either the main loop,
> - * or there is at least a reader helding the rdlock.
> + * or there is at least a reader holding the rdlock.
>   * In this way an incoming writer is aware of the read and waits.
>   */
>  void GRAPH_RDLOCK assert_bdrv_graph_readable(void);
> -- 
> 2.39.5
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


