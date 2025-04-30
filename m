Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4BBC369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5VQ-0006F2-8K; Wed, 30 Apr 2025 07:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA5VM-00069R-89; Wed, 30 Apr 2025 07:21:32 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA5VK-0000sD-8Y; Wed, 30 Apr 2025 07:21:31 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B7D4055D249;
 Wed, 30 Apr 2025 13:21:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id f4HzFrEgjLAX; Wed, 30 Apr 2025 13:21:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B917555D245; Wed, 30 Apr 2025 13:21:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B74DF745683;
 Wed, 30 Apr 2025 13:21:26 +0200 (CEST)
Date: Wed, 30 Apr 2025 13:21:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v3] ppc/vof: Make nextprop behave more like Open Firmware
In-Reply-To: <20250423101931.A0A6B55D23A@zero.eik.bme.hu>
Message-ID: <cacfd877-8a93-1a1f-21c6-43743cc1bfc4@eik.bme.hu>
References: <20250423101931.A0A6B55D23A@zero.eik.bme.hu>
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

On Wed, 23 Apr 2025, BALATON Zoltan wrote:
> The FDT does not normally store name properties but reconstructs it
> from path but Open Firmware specification says each node should at
> least have this property. This is correctly handled in getprop but
> nextprop should also return it even if not present as a property.
>
> Explicit name properties are still allowed because they are needed
> e.g. on the root node that guests expect to have specific names as
> seen on real machines instead of being empty so sometimes the node
> name may need to be overriden. For example on pegasos MorphOS checks
> the name of "/" and expects to find bplan,Pegasos2 which is how it
> identifies the machine.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v3:
> Keep phandle properties
> Changed commit message

Ping?

Regards,
BALATON Zoltan

> v2:
> Fixed a typo in commit message
> Simplified loop to get next property name
>
> hw/ppc/vof.c | 50 +++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index 09cb77de93..10bafd011e 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -353,34 +353,50 @@ static uint32_t vof_nextprop(const void *fdt, uint32_t phandle,
> {
>     int offset, nodeoff = fdt_node_offset_by_phandle(fdt, phandle);
>     char prev[OF_PROPNAME_LEN_MAX + 1];
> -    const char *tmp;
> +    const char *tmp = NULL;
> +    bool match = false;
>
>     if (readstr(prevaddr, prev, sizeof(prev))) {
>         return PROM_ERROR;
>     }
> -
> -    fdt_for_each_property_offset(offset, fdt, nodeoff) {
> -        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> -            return 0;
> +    /*
> +     * "name" may or may not be present in fdt but we should still return it.
> +     * Do that first and then skip it if seen later.
> +     */
> +    if (prev[0] == '\0') {
> +        tmp = "name";
> +    } else {
> +        if (strcmp(prev, "name") == 0) {
> +            prev[0] = '\0';
>         }
> -        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
> -            if (prev[0] != '\0') {
> -                offset = fdt_next_property_offset(fdt, offset);
> -                if (offset < 0) {
> -                    return 0;
> -                }
> -            }
> +        fdt_for_each_property_offset(offset, fdt, nodeoff) {
>             if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
>                 return 0;
>             }
> -
> -            if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
> -                return PROM_ERROR;
> +            if (strcmp(tmp, "name") == 0) {
> +                continue;
> +            }
> +            if (match) {
> +                break;
>             }
> -            return 1;
> +            if (strcmp(prev, tmp) == 0) {
> +                match = true;
> +                continue;
> +            }
> +            if (prev[0] == '\0') {
> +                break;
> +            }
> +        }
> +        if (offset < 0) {
> +            return 0;
>         }
>     }
> -
> +    if (tmp) {
> +        if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
> +            return PROM_ERROR;
> +        }
> +        return 1;
> +    }
>     return 0;
> }
>
>

