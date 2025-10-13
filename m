Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29455CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ayc-0000x0-9r; Mon, 13 Oct 2025 01:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1v8Ayb-0000wh-C2
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:20:05 -0400
Received: from submarine.notk.org ([62.210.214.84])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1v8AyY-0008Db-2g
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:20:05 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 2A6E414C2DE;
 Mon, 13 Oct 2025 07:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1760332800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRoK7s/Xx0K+rMcGZOWKFLTtF2yVnFs4I0yOHuMdCdk=;
 b=r9UleRpwyKu/pUflZSIsyZmFfT3l5O4vEMGC528ltAuIXKVHWVO5HsjY25dn5Mul7/2Zh8
 pYd0JBgwpqgMsKTdio4DKzsM9bjMilG7V5PJ0jDhSmY6nrGJaQRqGBPgpFbY7xgyofw/T9
 y8fKAgfw6W5sAWrIA1UDKTq+T3jGND2Bm9sU7fLassGfB+T7pp+mQpv2t9wC52v5YGX/xd
 r1Q+ybTjtcoej654oqE1XCRKz54kQSC0BJTiNpYMQgAqntXeR/Z5MJ9z0HqaCjh1ko+ytn
 PTRNxT5VnkUjU7VGEDiRpF+ed6fNhzBFSseK4qgONqSc1VInQ4j5m+8xMaWWmA==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f7b12250;
 Mon, 13 Oct 2025 05:19:54 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:19:39 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH RFC v5 08/12] virtio-serial-bus: add terminal resize
 messages
Message-ID: <aOyL65jhQkW-uljO@codewreck.org>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-8-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250921-console-resize-v5-8-89e3c6727060@gmail.com>
Received-SPF: pass client-ip=62.210.214.84;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek wrote on Sun, Sep 21, 2025 at 01:45:38AM +0200:
> From: Szymon Lukasz <noh4hss@gmail.com>
> 
> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. The virtio spec contains two methods to
> achieve that:
> 
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
> 
> For multiport devices, we use the control virtqueue to send a packet
> containing the terminal size. Note that old versions of the Linux kernel
> used an incorrect order for the fields (rows then cols instead of cols
> then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
> 
> As a result, when using a Linux kernel older than 6.15, the number of rows
> and columns will be swapped.

(subject to this part of the discussion being settled...)

> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> [Filip: swap rows/cols, console-size affects multiport too,
>         size config always updated, use use_multiport, move trace call]
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Dominique Martinet <dominique.martinet@codewreck.org>
Tested-by: Dominique Martinet <dominique.martinet@codewreck.org>

> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 38c949c4f2ce4a117cbfca62f56919711ce392b4..74a747ec6578c958b35e1f9712e5dbed7bca72e8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -37,7 +37,9 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
>  
> -GlobalProperty hw_compat_10_1[] = {};
> +GlobalProperty hw_compat_10_1[] = {
> +    { "virtio-serial-device", "console-size", "off" },

Oh the original patches had this wrong, good catch!

-- 
Dominique Martinet | Asmadeus

