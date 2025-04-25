Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2815C369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kjk-000682-Gd; Fri, 25 Apr 2025 11:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8Kji-00067D-Jn
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8Kjg-0001mb-Mm
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745593982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AGVsKZC8c4SB+cjsyRJl79uUPdzawbrhFxqeB+czct0=;
 b=YwsyX6ZFaUgZcvvFbZNd/MBTQbcmeDA+gI0vNpbOERgMRcXGoTMJ1zGeTjt7jokCfeRKVw
 Xyy7k4ixkq+/9MixUDki57z3XNUfSkgGi/sHUDqMnbZItDekMU88fb9Va2llcgPINYRO4z
 WLdWVjaIp02ICK7Ysc69Vie+hDIDgz4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-tGKkDuCQPHayiudOeoBUDA-1; Fri,
 25 Apr 2025 11:13:00 -0400
X-MC-Unique: tGKkDuCQPHayiudOeoBUDA-1
X-Mimecast-MFC-AGG-ID: tGKkDuCQPHayiudOeoBUDA_1745593979
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDAF71956077; Fri, 25 Apr 2025 15:12:58 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03A8319560A3; Fri, 25 Apr 2025 15:12:56 +0000 (UTC)
Date: Fri, 25 Apr 2025 17:12:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sunny Zhu <sunnyzhyy@qq.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2] block: Remove unused callback function
 *bdrv_aio_pdiscard
Message-ID: <aAumdnNyLCG-EfFF@redhat.com>
References: <tencent_7140D2E54157D98CF3D9E64B1A007A1A7906@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7140D2E54157D98CF3D9E64B1A007A1A7906@qq.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

Am 21.04.2025 um 20:21 hat Sunny Zhu geschrieben:
> The bytes type in *bdrv_aio_pdiscard should be int64_t rather than int.
> 
> There are no drivers implementing the *bdrv_aio_pdiscard() callback,
> it appears to be an unused function. Therefore, we'll simply remove it
> instead of fixing it.
> 
> Additionally, coroutine-based callbacks are preferred. If someone needs
> to implement bdrv_aio_pdiscard, a coroutine-based version would be
> straightforward to implement.
> 
> Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>

Thanks, applied to the block branch.

Kevin


