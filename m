Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB33F5A8C6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEvoF-0000S4-2q; Mon, 20 Apr 2026 17:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wEvoA-0000QH-2a; Mon, 20 Apr 2026 17:05:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wEvo7-0003PW-3A; Mon, 20 Apr 2026 17:05:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9BC6596961;
 Mon, 20 Apr 2026 23:05:21 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 2xn6xil5UJJB; Mon, 20 Apr 2026 23:05:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CA6C359695B; Mon, 20 Apr 2026 23:05:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C8D8659695F;
 Mon, 20 Apr 2026 23:05:19 +0200 (CEST)
Date: Mon, 20 Apr 2026 23:05:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
cc: "open list:amigaone" <qemu-ppc@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/ppc: remove duplicate include
In-Reply-To: <20260420164058.335872-1-osama.abdelkader@gmail.com>
Message-ID: <0587ebb7-06fc-5b96-bbfd-37d86475d718@eik.bme.hu>
References: <20260420164058.335872-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 20 Apr 2026, Osama Abdelkader wrote:
> hw/ppc/ppc.h is included twice
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Indeed, once is enough. Also cc'ing qemu-trivial list.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/ppc/amigaone.c | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 8074713fbe..9fba5ca03a 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -20,7 +20,6 @@
> #include "hw/isa/vt82c686.h"
> #include "hw/ide/pci.h"
> #include "hw/i2c/smbus_eeprom.h"
> -#include "hw/ppc/ppc.h"
> #include "exec/cpu-common.h"
> #include "system/block-backend.h"
> #include "system/qtest.h"
>

