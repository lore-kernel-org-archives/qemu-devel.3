Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51833C0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmqF-0004u6-1O; Tue, 11 Feb 2025 04:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1301cb12a=graf@amazon.de>)
 id 1thmq8-0004t7-Q5; Tue, 11 Feb 2025 04:46:01 -0500
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1301cb12a=graf@amazon.de>)
 id 1thmq6-0003GT-4L; Tue, 11 Feb 2025 04:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739267158; x=1770803158;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gIgkivdNGrQUY80zEqtwZEiGXqOVeupPAvFL7o0aGZU=;
 b=BDbxyDCc2ehpu5hicOC5j8xnYhVGFanQtpp9QQenAA4DRxD99sKnIxvX
 owe53HJ0UjnLuzUr8yvtVJWW0Kd5cB/o9mqsdQNp2XoSDZLurmkYRsWnP
 XPLDT8uSaHIvufmIS6ZpZ/hIiXbqWMylZZX9B+NsMl6tS/xsvTN33qb4W A=;
X-IronPort-AV: E=Sophos;i="6.13,277,1732579200"; d="scan'208";a="797828342"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:45:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:29780]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.246:2525]
 with esmtp (Farcaster)
 id d5b01edc-a8cb-4930-a853-d26f4fca0cae; Tue, 11 Feb 2025 09:45:46 +0000 (UTC)
X-Farcaster-Flow-ID: d5b01edc-a8cb-4930-a853-d26f4fca0cae
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 09:45:45 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Tue, 11 Feb 2025
 09:45:42 +0000
Message-ID: <da0ac9ed-fdca-433e-b793-5423f430a852@amazon.com>
Date: Tue, 11 Feb 2025 10:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/23] hw/uefi: add var-service-core.c
To: Gerd Hoffmann <kraxel@redhat.com>, <qemu-devel@nongnu.org>
CC: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 <qemu-arm@nongnu.org>, Michael Roth <michael.roth@amd.com>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
References: <20250211092324.965440-1-kraxel@redhat.com>
 <20250211092324.965440-10-kraxel@redhat.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20250211092324.965440-10-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=207.171.188.206;
 envelope-from=prvs=1301cb12a=graf@amazon.de; helo=smtp-fw-9106.amazon.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 11.02.25 10:23, Gerd Hoffmann wrote:
> This is the core code for guest <-> host communication.  This accepts
> request messages from the guest, dispatches them to the service called,
> and sends back the response message.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-core.c | 237 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 237 insertions(+)
>   create mode 100644 hw/uefi/var-service-core.c
>
> diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
> new file mode 100644
> index 000000000000..78a668e68fa2
> --- /dev/null
> +++ b/hw/uefi/var-service-core.c
> @@ -0,0 +1,237 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * uefi vars device
> + */
> +#include "qemu/osdep.h"
> +#include "system/dma.h"
> +#include "migration/vmstate.h"
> +
> +#include "hw/uefi/var-service.h"
> +#include "hw/uefi/var-service-api.h"
> +#include "hw/uefi/var-service-edk2.h"
> +
> +#include "trace/trace-hw_uefi.h"
> +
> +static int uefi_vars_pre_load(void *opaque)
> +{
> +    uefi_vars_state *uv = opaque;
> +
> +    uefi_vars_clear_all(uv);
> +    uefi_vars_policies_clear(uv);
> +    g_free(uv->buffer);
> +    return 0;
> +}
> +
> +static int uefi_vars_post_load(void *opaque, int version_id)
> +{
> +    uefi_vars_state *uv = opaque;
> +
> +    uefi_vars_update_storage(uv);
> +    uv->buffer = g_malloc(uv->buf_size);
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_uefi_vars = {
> +    .name = "uefi-vars",
> +    .pre_load = uefi_vars_pre_load,
> +    .post_load = uefi_vars_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT16(sts, uefi_vars_state),
> +        VMSTATE_UINT32(buf_size, uefi_vars_state),
> +        VMSTATE_UINT32(buf_addr_lo, uefi_vars_state),
> +        VMSTATE_UINT32(buf_addr_hi, uefi_vars_state),
> +        VMSTATE_BOOL(end_of_dxe, uefi_vars_state),
> +        VMSTATE_BOOL(ready_to_boot, uefi_vars_state),
> +        VMSTATE_BOOL(exit_boot_service, uefi_vars_state),
> +        VMSTATE_BOOL(policy_locked, uefi_vars_state),
> +        VMSTATE_UINT64(used_storage, uefi_vars_state),
> +        VMSTATE_QTAILQ_V(variables, uefi_vars_state, 0,
> +                         vmstate_uefi_variable, uefi_variable, next),
> +        VMSTATE_QTAILQ_V(var_policies, uefi_vars_state, 0,
> +                         vmstate_uefi_var_policy, uefi_var_policy, next),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv)
> +{
> +    hwaddr    dma;
> +    mm_header *mhdr;
> +    uint64_t  size;
> +    uint32_t  retval;
> +
> +    dma = uv->buf_addr_lo | ((hwaddr)uv->buf_addr_hi << 32);
> +    mhdr = (mm_header *) uv->buffer;
> +
> +    if (!uv->buffer || uv->buf_size < sizeof(*mhdr)) {
> +        return UEFI_VARS_STS_ERR_BAD_BUFFER_SIZE;
> +    }
> +
> +    /* read header */
> +    dma_memory_read(&address_space_memory, dma,
> +                    uv->buffer, sizeof(*mhdr),
> +                    MEMTXATTRS_UNSPECIFIED);


Depending on DMA sounds appealing at first, but can fall apart in corner 
cases. I know of 2 cases where DMA failed for me in the EC2 equivalent 
of this:

1) SEV-SNP. If you want the hypervisor to implement UEFI variable 
services for you, the buffer region must always be in shared state. 
Ensuring that during boot time is tricky but doable. At runtime you no 
longer really have control over the sharability of pages.

2) Mac OS X. MacOS is the only OS I'm aware of that really makes use of 
relocation. They move your physical pages to random locations, give you 
a non-1:1 mapping to that and once you're in real OS land, you have no 
more knowledge at all about the physical location of anything. Maybe you 
can work around that by declaring the buffer region as MMIO space? But 
then it really should be a memory region in the device.


To address the 2 cases above, I ended up implementing a special "PIO 
mode" which does not rely on DMA at all:

https://github.com/aws/uefi/blob/main/edk2-stable202211/0023-edk2-stable202211-ExtVarStore-Add-support-for-PIO-transfer.patch

Also, I'm surprised you cut the variable service off at the SMM boundary 
instead of the RTS callback boundary. Why is that cleaner/better than 
implementing variables completely in QEMU? In the EC2 version, we just 
built a separate variable store implementation that completely replaces 
the edk2 variable store:

https://github.com/aws/uefi/blob/main/edk2-stable202211/0012-edk2-stable202211-nitro-Add-ExtVarStore-for-vmm-based-variable-storage.patch

It would be nice to agree on a single external variable store 
implementation :).


Alex


