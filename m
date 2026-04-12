Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E5E937EE
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBygR-0007X0-Qs; Sun, 12 Apr 2026 13:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBygK-0007VZ-L3
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:33:14 -0400
Received: from 6.mo533.mail-out.ovh.net ([54.36.140.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBygF-0001cK-F0
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:33:12 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4ftyL763yqz5wm9;
 Sun, 12 Apr 2026 17:33:03 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 12 Apr 2026 17:33:03 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.192])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4ftyL73LMdz7tnt; Sun, 12 Apr 2026 17:33:03 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id CD25212E3A38;
 Sun, 12 Apr 2026 17:33:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002995574aa-565f-46a6-9f3a-9b736cc0e228,
 24D929EF98A9C54707A36CFD348010E9E2578269) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ec62abcb-7602-470a-b7a8-1ce9bf8c5edd@kaod.org>
Date: Sun, 12 Apr 2026 19:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/13] hw/usb/hcd-ehci: Add descriptor address offset
 property
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-12-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260311072614.1095587-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 15514619242805111819
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEPMX1bRCzlt49bZiVnBr4A1XTg1uYapD+4fT26wGhzK4wa0XjaEgwvH5msL5rxptT8zBShlchhdSYrcUTdoix+NH04mOfyJoDde6DJshjG1oCR+Hd550n1p0gjc9p2YagPuXb2Nm5HbS1QyocJi9Eaf6BzgS1cyzw87oH3eETWLGiI7caJVYe61ldp7nCJq445zFhGXH5tJ6dn9uktXVbnBc2hz2qa+h8KCeBj5xgWSOH+QHjKzKuj+GZX+xhF6AzU8/WlWEG4BNxzkk6L+cVVyfJ5gYVy/cPxx70rVMRyw6kgG2c5Qs4JjfJT7z4D5ExIp4tfu7XbwRKs1DpA9qGQm6VoNlMlFnU9ukwzo3jwqnPfFAFFB3WTHi8SDs7MzPDsKUMBY1f/1JZZqz1sOn/+QSpacU4UXzehdCaVUk21gM5UQnt3r3itON0WG/rxPCljI2tP5nGrgxuQ0lo96Ay/Zd6f9U+2ialg7F0jL+loUhaF2uAfOA27vCEsLNdaCdd2zjeK/ZT5OEHlvIMxKyKRAbNlRNt7HfJKl65yChn8R+ZE0JZErJd9HWwuRrJDm6qCH7nfU6BRgeh9o3KLDMnQuY2WBbtxgB9v4oeBms5iPiezH33Oqq2+LrTWegaUjdPdTobPnbOQnv+KtpjQvuizT1LreY4L2C3dPkbIeSg7qA
DKIM-Signature: a=rsa-sha256; bh=vs6Cx3UpmLgjsIibMBBcjTlsS0O0JHeYE7FdUWKsKoY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776015184; v=1;
 b=Mq+KXhm8A0kTuaXJBT+zl0yqQ8+3WfgGpLDyp0Uxke2TqkRYwVqfsA/yp6ErFVtAj7thxo9Q
 IhF/wDn7L9/3+HVBo/UhS5AUY78xEX4cfCvamzVpGVjytWQw675QFye4qzCni+ZAuJlQoq1hR8q
 nFUdww9RicsJYeNSXSn/QbSXsjVKBATQCZwOmwuhkvIwuZb4l2uW82OOM042x86KcWdVIAlSxZB
 CDsyjwleJCq4YzNGqmA2McJuJtB1DaVJBKoftIJhhmGxjjiVDrbzLWrXkqzyb6m8c7LUCIdp1WE
 KhMGP4h/tJpWFWngSZcAkzOFtgdXgZZfBdq+Foq1ExQ4A==
Received-SPF: pass client-ip=54.36.140.181; envelope-from=clg@kaod.org;
 helo=6.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/11/26 08:26, Jamin Lin wrote:
> When 64-bit addressing is supported, the Linux EHCI driver programs the
> segment register to zero. See ehci_run function:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c
> 
> The driver comment also notes that descriptor structures allocated from
> the DMA pool use segment zero semantics.
> 
> Descriptor memory is allocated using the DMA API. The platform driver
> configures a 64-bit DMA mask so memory can be allocated above 4GB.
> See ehci_platform_probe function:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platform.c
> 
> On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.
> As a result, descriptor addresses constructed directly from the guest
> EHCI registers do not match the actual system address used by the
> controller when fetching queue heads (QH) and queue element transfer
> descriptors (qTD).
> 
> Introduce a descriptor-addr-offset property so platforms can provide an
> address offset applied when constructing descriptor addresses. This
> allows systems where DRAM resides above 4GB to correctly access EHCI
> descriptors while keeping the default behavior unchanged for existing
> machines.

I am a bit confused. QEMU should not adapt to what Linux actually does.

It seems Linux has a workaround for buggy 64bit HW and relies on the
HW to present bus addresses (remapped by HW ?) to devices.

So the "descriptor-addr-offset" property sort-of simulates the DMA
address translation that would exist in real hardware.

How does the AST2700 SoC works ?

Thanks,

C.

> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h        | 1 +
>   hw/usb/hcd-ehci-pci.c    | 2 ++
>   hw/usb/hcd-ehci-sysbus.c | 2 ++
>   hw/usb/hcd-ehci.c        | 1 +
>   4 files changed, 6 insertions(+)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index a11d4179cd..6593480028 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -279,6 +279,7 @@ struct EHCIState {
>       /* properties */
>       uint32_t maxframes;
>       bool caps_64bit_addr;
> +    uint64_t descriptor_addr_offset;
>   
>       /*
>        *  EHCI spec version 1.0 Section 2.3
> diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
> index 2ea8549db9..115d05ede0 100644
> --- a/hw/usb/hcd-ehci-pci.c
> +++ b/hw/usb/hcd-ehci-pci.c
> @@ -139,6 +139,8 @@ static const Property ehci_pci_properties[] = {
>       DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),
>       DEFINE_PROP_BOOL("caps-64bit-addr", EHCIPCIState, ehci.caps_64bit_addr,
>                        false),
> +    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCIPCIState,
> +                       ehci.descriptor_addr_offset, 0),
>   };
>   
>   static const VMStateDescription vmstate_ehci_pci = {
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index 61215e9f3d..df138fb339 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -36,6 +36,8 @@ static const Property ehci_sysbus_properties[] = {
>                        false),
>       DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_addr,
>                        false),
> +    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCISysBusState,
> +                       ehci.descriptor_addr_offset, 0),
>   };
>   
>   static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index d9d1ac2d28..cdb53be4ae 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -155,6 +155,7 @@ static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)
>           addr |= (uint64_t)s->ctrldssegment << 32;
>       }
>   
> +    addr += s->descriptor_addr_offset;
>       return addr;
>   }
>   


