Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7BCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXKn-000666-4A; Thu, 01 Aug 2024 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXKf-0005mN-81
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXKT-0005ds-Ph
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722524575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Lo+uGDIcyD7W0t4MDXDii2PLkA0SFngkBQWIS2XHb8=;
 b=XlNo8D7hLnmQkDD13okV7o3GKuXoFys4TBockR9CS03myWveynaaLKruOgG8gc1Hl0uFgW
 KevlJgmbInpTuVVcbSBh/JW8grbZ8F71kT5hEsf/bdnEpVssVjlkd4nzEreMrfqrUBhnTT
 eOIvMnGJUc6Q7LI9Z99ezxn/nXaoSUs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-nTKgrokuNSSmSPYf6Hp6fg-1; Thu, 01 Aug 2024 11:02:51 -0400
X-MC-Unique: nTKgrokuNSSmSPYf6Hp6fg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef23969070so81574351fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524570; x=1723129370;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Lo+uGDIcyD7W0t4MDXDii2PLkA0SFngkBQWIS2XHb8=;
 b=n8l3d/5ANVwDuktyHkpMWnvQcmqmTznhceTEW2PrJCGjTAKCostVV+4NBCssd4o+hK
 jO5/qb7AzRKvDdogkFJNInvTHRBOOL51rZ7n/rRwG4clSEDprclo9kPEqTyxBPIIU05E
 /AXqtgDyLpBBD8MgTxvVEmw5W2b96RslQCm7HV8D5nGRwMj8x4iPlIvBTPLWbaFasDAi
 uUaNJaMtFsWpieZrWZUS71koklWizf8X5VJAlHEpGxiyldISeU0bR/YJlvs+gH7ZZNpU
 73gQDzhOuTBJt31yrhjAs+G67uBM3G5SD4KcvlNvcFto1RI/rckO06y2Od6SxILvBcXS
 CH/g==
X-Gm-Message-State: AOJu0YyLVt/tE1Lt9wJ9KEoj7hZINaV4kEubDRhl+c4aRzZpKvtEd96N
 uw96tHSil6SqvUCRkh+qVDMErOtsbYWETy6kTgrRtc+q8FcIRkAlU9Wfhou5O9NDmlW8rwdG4Px
 1Mk4VRgM278s+dUgKPyeyL5LIgFtpP/u8GupIb3YlCStqzeObLGb3
X-Received: by 2002:a2e:8703:0:b0:2ef:1b1b:7f42 with SMTP id
 38308e7fff4ca-2f15ab2a580mr4857811fa.36.1722524569968; 
 Thu, 01 Aug 2024 08:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt7Z5lfoAg+BK1GDJ0NXZLTHsCNUWCr+4kl0JGmr7vAmjEPeh8ZF41DZm20A9ArgGebZU1zg==
X-Received: by 2002:a2e:8703:0:b0:2ef:1b1b:7f42 with SMTP id
 38308e7fff4ca-2f15ab2a580mr4856941fa.36.1722524568957; 
 Thu, 01 Aug 2024 08:02:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad9079bsm904803366b.166.2024.08.01.08.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:02:47 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:02:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH-for-9.1 v2 2/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Message-ID: <20240801105917-mutt-send-email-mst@kernel.org>
References: <20240801145630.52680-1-philmd@linaro.org>
 <20240801145630.52680-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801145630.52680-3-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 04:56:30PM +0200, Philippe Mathieu-Daudé wrote:
> When booting Linux we see:
> 
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>   pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>   pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>   pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
>   pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
> 
> This is due to missing base address register write mask.
> Add it to get:
> 
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>   pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>   pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>   pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>   pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
>   pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
>   pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
>   pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
>   pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
>   pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000007]
> 
> Mention the datasheet referenced. Remove the "Malta assumptions ahead"
> comment since the reset values from the datasheet are used.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/pci-host/gt64120.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index b68d647753..344baf55db 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -1224,6 +1224,13 @@ static void gt64120_pci_reset_hold(Object *obj, ResetType type)
>                   PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
>      pci_config_set_prog_interface(d->config, 0);
>  
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001);
> +
>      pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
>      pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);


if you are tweaking wmask, I think migration will fail.
So you have to make this depend on machine property, and
put in compat machinery.

> -- 
> 2.45.2


