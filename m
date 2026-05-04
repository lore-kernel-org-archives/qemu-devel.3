Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A86FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsEv-0006Ke-Jc; Mon, 04 May 2026 08:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsEt-0006KA-7v
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:17:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsEr-0000YN-93
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:17:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so65147715e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777897047; x=1778501847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eh11noYDc/3Az7blVqfxgjOKo9iIpH2UOu7mqbKVHNE=;
 b=GJIrmF8zkCZAxCQeTfq0CdZhnpoGGiioo96n7T2d4YsL9sIfjTs/sFovSdleYA4bSz
 JBfZ6G4nM5Xek2CaJzt5UedbCJObY1HIbSz93KH5sxeY7xRTcjcRZT8bxqLrVxXl6u4j
 AVT5LKvHF6UEPspNb9fyAsWUeVyxD9vgswcCIVT9a9JnyOv4R9Bb+7Svr80eRY0LgicS
 hW9ysT/avq7qjK/mGW9CjI9Y7mDIv0l42zd09FYFG6nqsSEK0PQqXeGUTm9xMJeg9C/7
 0vP003mv0/jJLIpj480dfGOqkVNwhmCiT7JGOgq+wwbJLcU2EjiYWqWB6C1a+gXsuW7K
 FSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897047; x=1778501847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eh11noYDc/3Az7blVqfxgjOKo9iIpH2UOu7mqbKVHNE=;
 b=m/O843Oe3LVo9nQuao5QAIM4bDRuPWf6AqJRTF11mdIOtrBNFB8U1C+LJRaZID8xra
 cSOiTtOHTbY7mv5T4A07f6e5AA26/QeY9ZfXlYCPvY6uy63cQXiRXtUgHuYhHXjU5ZkO
 wxoUWHY57n/3fJsu31ZOedA0V77y27PKUDr/tv1MxHZNPMN3NueAWPQnSx5L/ePewpPA
 mk85AlCnT4fHM9Qsr9Y7bDK72tjMy3nZuuZthxHI1mQ+/5/Qx1HMKaB/tDOMvAZz6VQe
 X+P7AX0h7UPJ6ptGitZFCKyPYZs8W7ZQSEJjE0xKwgAXVQz7DUVGKW+HLVw6gQ9yJaHI
 o1Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LHzH8wY1MxfNMF/gpPewQvZbbFTfVCiCP1RstGpkZbPjD8MFPugnlAayizkeKAGTqS72Umlmm//ck@nongnu.org
X-Gm-Message-State: AOJu0YwhdL9g2JVOhlc4J7LIMTHXy6iJmDGie4C2y+0lHveqgPefWnMh
 Ep1cL5m3rXKVzkl8swCf3CsjlXR2iOuRlYtPFP9pw6qp89lrBY2qyvKu3cgzy0JwL4o=
X-Gm-Gg: AeBDietbLNI1MwxpayghsqwGDoDXCNS4ESW7fmsLxc20tnbgaeGSHtHSHWvqqyPeY/j
 g1l3BGQCtKjM96qnfE2Qw0CW/72b9EFANJKyc+Q95VdGoXh48QvY6tsCdK+akZTsk5D1eRZhSRv
 O90A2hjHKE51kDD5i3gnaPv5OtGWG5xViacHEHRDXyJer7Mg5XofaQJRDXj04LUolVD+c+L5PVJ
 VAxjL7ZecA6YcyLo0HgxLLJpDoWuN6ZRKPxdLJlz8R2OVlHUiIPPt3QYzlzqUfnmp/XnlkJKZZ0
 JYGcHeD3/dhampET5CZDT8fpoaHoZlXA0Sl2JHGjkjUjyMMPIJ3LCmFi/LYQmMWTP/0cj52+/5W
 Au/JBFKMkVZlpGMtrlPf4Q0cOf2LTDIvw65uMGM0oIdAxjfxqC6X5Z3WGenFkx1DK1d9bfY62Mn
 gDNLXvdtDjWqrXtk5MD/bdRass2o0qAJ4/HQoxvSkSwQpz/ARFHn8m2/urRIIa3Casy5cHLB4s6
 Qul
X-Received: by 2002:a05:600c:c0c2:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48a98668f0emr115945535e9.21.1777897047299; 
 Mon, 04 May 2026 05:17:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82308d77sm377542235e9.14.2026.05.04.05.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 05:17:26 -0700 (PDT)
Message-ID: <65f928c1-50f0-448f-bd5e-6edcf3b2e5fd@linaro.org>
Date: Mon, 4 May 2026 14:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <20260504025342.1452605-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260504025342.1452605-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/5/26 04:53, Jamin Lin wrote:
> Change internal EHCI descriptor addresses from uint32_t to uint64_t.
> 
> The following fields are updated:
> - EHCIPacket::qtdaddr
> - EHCIQueue::{qhaddr, qtdaddr}
> - EHCIState::{a_fetch_addr, p_fetch_addr}
> 
> Update get_dwords() and put_dwords() to take 64-bit addresses and
> propagate the type change through the descriptor traversal paths.
> 
> Adjust NLPTR_GET() to operate on 64-bit values:
> 
>      #define NLPTR_GET(x) ((x) & ~0x1fULL)
> 
> so that link pointer masking works correctly when descriptor
> addresses exceed 32-bit space. The previous mask (0xffffffe0)
> implicitly truncated addresses to 32 bits.
> 
> This patch does not change the on-wire descriptor layout yet.
> It only removes the internal 32-bit address limit and prepares
> for later patches that will add full 64-bit QH/qTD/iTD/siTD support.
> 
> Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to
> use uint64_t for the address argument and print it with PRIx64. This
> ensures full 64-bit addresses are shown in trace output and improves
> debugging of queue heads and transfer descriptors.
> 
> Migration compatibility:
> 
> To preserve backward migration compatibility, keep the legacy 32-bit
> fetch address fields (a_fetch_addr_32, p_fetch_addr_32) alongside the
> new 64-bit fields.
> 
> Migration format is selected using a machine compat property
> "x-migrate-fetch-addr-64bit":
> 
> - Old machine types migrate 32-bit fetch addresses
> - New machine types migrate full 64-bit fetch addresses
> 
> This is implemented using VMSTATE_UINT32_TEST() and
> VMSTATE_UINT64_TEST() so that only the appropriate format is migrated.
> 
> In pre_save, the 32-bit shadow fields are populated when migrating
> to old machine types. In post_load, the 32-bit values are restored
> into the 64-bit fields when loading old migration streams.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h   | 17 +++++++----
>   hw/core/machine.c   |  5 +++-
>   hw/usb/hcd-ehci.c   | 72 ++++++++++++++++++++++++++++++++-------------
>   hw/usb/trace-events | 24 +++++++--------
>   4 files changed, 78 insertions(+), 40 deletions(-)


> @@ -256,6 +256,7 @@ struct EHCIState {
>   
>       /* properties */
>       uint32_t maxframes;
> +    bool migrate_fetch_addr_64bit;
>   
>       /*
>        *  EHCI spec version 1.0 Section 2.3
> @@ -294,8 +295,10 @@ struct EHCIState {
>       EHCIQueueHead pqueues;
>   
>       /* which address to look at next */
> -    uint32_t a_fetch_addr;
> -    uint32_t p_fetch_addr;
> +    uint32_t a_fetch_addr_32;
> +    uint32_t p_fetch_addr_32;

Technically '?_fetch_addr_32' aren't "which address to look at next"
anymore, but simple migration helpers. Could be worth adding a comment?
And rename including 'migrat{e,ion}'? Can be cleared on top.

> +    uint64_t a_fetch_addr;
> +    uint64_t p_fetch_addr;
>   
>       USBPacket ipacket;
>       QEMUSGList isgl;
> @@ -308,7 +311,9 @@ struct EHCIState {
>   };
>   
>   #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \
> -    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)
> +    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \
> +    DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
> +                     ehci.migrate_fetch_addr_64bit, true)
>   
>   extern const VMStateDescription vmstate_ehci;
>   
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1b661fd36a..54336da294 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,7 +39,10 @@
>   #include "hw/acpi/generic_event_device.h"
>   #include "qemu/audio.h"
>   
> -GlobalProperty hw_compat_11_0[] = {};
> +GlobalProperty hw_compat_11_0[] = {
> +    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +};
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);

Good.

> +static bool ehci_fetch_addr_64_needed(void *opaque, int version_id)
> +{
> +    EHCIState *s = opaque;
> +
> +    return s->migrate_fetch_addr_64bit;
> +}
> +
> +static bool ehci_fetch_addr_32_needed(void *opaque, int version_id)
> +{
> +    return !ehci_fetch_addr_64_needed(opaque, version_id);
> +}
> +
>   static int usb_ehci_pre_save(void *opaque)
>   {
>       EHCIState *ehci = opaque;
> @@ -2424,6 +2438,11 @@ static int usb_ehci_pre_save(void *opaque)
>       ehci->last_run_ns -= (ehci->frindex - new_frindex) * UFRAME_TIMER_NS;
>       ehci->frindex = new_frindex;
>   
> +    if (!ehci->migrate_fetch_addr_64bit) {
> +        ehci->a_fetch_addr_32 = ehci->a_fetch_addr;
> +        ehci->p_fetch_addr_32 = ehci->p_fetch_addr;
> +    }
> +
>       return 0;
>   }
>   
> @@ -2444,6 +2463,11 @@ static int usb_ehci_post_load(void *opaque, int version_id)
>           }
>       }
>   
> +    if (!s->migrate_fetch_addr_64bit) {
> +        s->a_fetch_addr = s->a_fetch_addr_32;
> +        s->p_fetch_addr = s->p_fetch_addr_32;
> +    }
> +
>       return 0;
>   }
>   
> @@ -2504,8 +2528,14 @@ const VMStateDescription vmstate_ehci = {
>           /* schedule state */
>           VMSTATE_UINT32(astate, EHCIState),
>           VMSTATE_UINT32(pstate, EHCIState),
> -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
> -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
> +        VMSTATE_UINT32_TEST(a_fetch_addr_32, EHCIState,
> +                            ehci_fetch_addr_32_needed),
> +        VMSTATE_UINT32_TEST(p_fetch_addr_32, EHCIState,
> +                            ehci_fetch_addr_32_needed),
> +        VMSTATE_UINT64_TEST(a_fetch_addr, EHCIState,
> +                            ehci_fetch_addr_64_needed),
> +        VMSTATE_UINT64_TEST(p_fetch_addr, EHCIState,
> +                            ehci_fetch_addr_64_needed),

Hmmmm. I didn't review all previous versions, for my own education, why
don't we use VMSTATE_UINT64_V() here? Did you test (pre-11 <-> this
series) migration? My understanding was we need to maintain the stream
size to avoid mismatch.

>           VMSTATE_END_OF_LIST()
>       }
>   };


