Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60F5F8E4AD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDccA-0007zy-L7; Fri, 17 Apr 2026 02:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcc9-0007zL-2E
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:23:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcc7-00065q-BH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:23:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so1644115e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776407017; x=1777011817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TSAFGKcWXwWRumwKLaW02KedM46CTeUlkHFKmLPuTmM=;
 b=h+cQ+4LZzsdt0oyUii7TyvFD2T2IBgpqePTk08brvKcsio7fxNpTh38sV84VgIacG4
 4K96cm2wYV4FFCDD0H7t1UPEJ3rJj54l0/dUAxETfz2NoCMR5B6S7OGM52MjQwQ/XZnE
 DjZPc3BfTzpZsm97eduCWKyD23jWpXHtTiGxduhJSbkLAGhNgdqe435cN2SPUEFJixsO
 ORbAcwC5GxEgavbjtaxSFa84g5NUWKQdN2GZt/No4ljPE2r5NdMTETBUXSjAh0XmYsm5
 8NbLYMzmvGyau3Z+sKT0xcrzzwfNE+zqQNHWRFrUBMvhGbTKZADSuzjTEYvePq52jXNw
 7UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776407017; x=1777011817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TSAFGKcWXwWRumwKLaW02KedM46CTeUlkHFKmLPuTmM=;
 b=HerFdc9ICovOF3rKSic0+TshO3AIDLVeUhIyU/sodxHYFJXh07k0DD1SEdCnKEKAUm
 CrqGNRfL0b2ktm1+AFC+7YdqNOLbx4cgE+WuAUaH84k5FDCTyhlgRWPBnSPBRGC3nExd
 HVoPDg1CQ/XGVBjXf/QXcWKv59npxnen56CKK6QpjwXGJJkAr/djq6UIunjU6F9RH1wS
 /EjwIV4U05aC15sEceQwwZ8x17mUv0Ug1oMFBjl3d25brSGhLokxDogCT6cShVeoHafv
 9nnl7cqeur54iWVuhJI53v/fs0l7KH+wPpb2OTYYjI4vS6yQcPdQhb+bvoI+P3jUPnUM
 DIxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0dsKuITRMmVrLcT7wg9aHAmSCYOGJdXCOBZTKShE/3TkMDJtLDDONxMnC6Qwk6kpcNHBiwISDBwV4@nongnu.org
X-Gm-Message-State: AOJu0YxfqTuB49+oFM9XWtANtsH8hXbTi4q6HlNfnGSrmaDzrNw/JFPG
 6+v6fcRdoJlc7pFks8798dWZYLEBO9Yv8igSABM0XbxOuB9jLi+tMVqcokb5mshTCKU=
X-Gm-Gg: AeBDies4Ei8YvmSO3kTFfHeMg5qpnLF/2fY9Nir5QcN3fBCS+vf5jiVv4achehsL5TX
 Rc0FqotBp9I0tVOA821Z/ft6r2uhx/A0XdZy2zfg4hAxvUWT6KIX760RP5y1t70vMde5kdzFgyD
 kcYX4h3cdHxl5SJUsa6WRO/XLyMtLxN1ZVFR4E2oAWGbFtNn02Bore9xD0k3hajRB44DKjY0fEP
 z4Kzo+U6vV3bH5JOb0t2wlUzz+qBK5JnAN5pujUTXbBSExkHWqkhBjN9/SAbN9/bCpRhmbKOGs/
 me6/AyL9AcG+A9MSJzz4sFzMTxdl1VplGknETgxBAdGiGEGXtjNd4sQLV+QWobQVp6mFRw1hu9C
 VPrWdFaibj/TNr+CU9FBfhp9nF/YGxn2yJsFwA1Khj8BtoePAi1t+905B91PLX8fme+E5yjQT/1
 d6Hyau+rfQqMR7ihdeW1K8nFlyWeSjeVYgdf91mXDTOIMsJMM0kqsATDHVY3Op6F3DU/mdAxsKg
 MBZ
X-Received: by 2002:a05:600c:1385:b0:488:c085:22ad with SMTP id
 5b1f17b1804b1-488fb78a39dmr18859905e9.29.1776407017459; 
 Thu, 16 Apr 2026 23:23:37 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46898sm1833867f8f.27.2026.04.16.23.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:23:36 -0700 (PDT)
Message-ID: <6b535f08-8ee8-4227-9dfb-3d4914d825bf@linaro.org>
Date: Fri, 17 Apr 2026 08:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-14-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-14-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 16/4/26 03:49, Jamin Lin wrote:
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
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h        | 1 +
>   hw/usb/hcd-ehci-pci.c    | 2 ++
>   hw/usb/hcd-ehci-sysbus.c | 2 ++
>   hw/usb/hcd-ehci.c        | 7 ++++++-
>   4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 6406f536e8..05d8db4a5d 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -264,6 +264,7 @@ struct EHCIState {
>       /* properties */
>       uint32_t maxframes;
>       bool caps_64bit_addr;
> +    uint64_t descriptor_addr_offset;

I note OHCI uses "dma_addr_t dma_offset;" here.

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

I note OHCI uses DEFINE_PROP_DMAADDR() here. Single use, maybe better
remove it and stick to uint64_t as you use.


Could we have a DEFINE_EHCI_COMMON_PROPERTIES() macro for common
entries instead, such DEFINE_SDHCI_COMMON_PROPERTIES()?

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



