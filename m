Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECC2C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiT2-0007qr-Bf; Fri, 17 Jan 2025 04:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiT0-0007qP-G4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiSy-0002EN-QO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737105394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9zeOcIV+Fb7bQ6HKEMYpcJ0xHGKXHrqmHKbomeSVPKU=;
 b=dqvMRvSx6JXOGJiMEz6MxCaFtu3lstkZJIrtGwd35cqz2RxdGdAkX2qsWBgaO0vD3BuNey
 8mb4rgczKoa3y5vwnWyMtbzy7m1GbqtJS4T+9QfrA8o/RSABthWYj0Hhi8JiArubqKO4f2
 xXSpNrYk0l+TrZPEbClRUPHfyny8hMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-PE23tBjONWGdTYxhDKAnmg-1; Fri, 17 Jan 2025 04:16:33 -0500
X-MC-Unique: PE23tBjONWGdTYxhDKAnmg-1
X-Mimecast-MFC-AGG-ID: PE23tBjONWGdTYxhDKAnmg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so9007265e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737105392; x=1737710192;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9zeOcIV+Fb7bQ6HKEMYpcJ0xHGKXHrqmHKbomeSVPKU=;
 b=Y00eRDOfEawEy2/eBz10eRIrXyENibGSr7gTD+/R2PqR3wdfKtjpatJgYD2vgSz60A
 qt0HZlh0GQgh032LLEXbAb26Uy7lYFT/I3AB3JxUjeNFTg9oeobfxRRNE7HmSUlxnZTs
 bicHDFA2qeTAi6xtM783AR5figsxAWj4Dz/L7EHnsajVueEtUqS5AeMwz2zcS7jFdzuU
 wtyAurSCkQKtdAfPwGC7TK771O2FvKFDM7CyL9cwB0qGDH+mA5fHYj3MA6vgPx24O1QP
 Kyix7YWmDr0EySU4XIddjU5KWC7vIZ4Q+EjRHg6AvdbOvgL8v/TOeHOMflsHdCSCC4W0
 xWZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXShn7ABmITqreKKQ3BPryi/mqdKEv4vn8Rq9iEwJwlVGOGYUpflQERXLC2W3Aph5MxNVXiCIfeqzqx@nongnu.org
X-Gm-Message-State: AOJu0Yx65ae0n6HGQvORvymSym3czpNHVEge+xjUAMZbOomeQWR6/a4d
 UdXCBGQrDKoOdBVn/G93thxJymLtchzgpskZPmczBXCJMMbGuMvbOMf3HHELTFHiG/8n6phlKJ4
 RAR/PrsAuQYRQu6ZnInX7/+BqBxjDJOSUTZSPj434ArmPczlTeWLj
X-Gm-Gg: ASbGncsqYsXfMrvRg+f3AZz5yg59NFk86a1lykn6PN2gpZJMnHlXGuKSgo+YPVitiDu
 yFm8ssxofcJSvC9z3KMzrzqup5UDEN93CnjYr59zmbNee3wbxnH6CldgbyIsZRbHbwcp8XW+lwb
 r4kleztMK2mKR/T8yhFRqdYF35t6gtr05/IaGyag5b9EltCEx08mzjCiwIrkYcukgQZdTp2G5zG
 +798N5s2mUyMhDuOp4a/MTdQKAW+LTwd9ildt2nGBj/wbm7m3JRDpkLpzYZLfjrlKYUp/BLGxSp
 dP2zMlkClo/W
X-Received: by 2002:a05:600c:4e08:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438912d5426mr20397935e9.0.1737105392349; 
 Fri, 17 Jan 2025 01:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpqyGXuBODQwx9bDlpvDRwaTvOa4sw4VeAyXKzlpQIwtY5QeFNPUCjTYde2kZttUNATROZWA==
X-Received: by 2002:a05:600c:4e08:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438912d5426mr20397575e9.0.1737105391977; 
 Fri, 17 Jan 2025 01:16:31 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046bab0sm26118325e9.38.2025.01.17.01.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:16:31 -0800 (PST)
Message-ID: <00cc3b9d-7bf3-430c-abc9-d7dcaed25c59@redhat.com>
Date: Fri, 17 Jan 2025 10:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-17-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115232247.30364-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
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

On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
> PVSCSI_COMPAT_OLD_PCI_CONFIGURATION was only used by the
> hw_compat_2_5[] array, via the 'x-old-pci-configuration=on'
> property. We removed all machines using that array, lets remove
> all the code around PVSCSI_COMPAT_OLD_PCI_CONFIGURATION.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/vmw_pvscsi.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index f07e377cb88..8c793b4188d 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -69,17 +69,11 @@ OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
>   
>   
>   /* Compatibility flags for migration */
> -#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT 0
> -#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION \
> -    (1 << PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT)
>   #define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
>   #define PVSCSI_COMPAT_DISABLE_PCIE \
>       (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
>   
> -#define PVSCSI_USE_OLD_PCI_CONFIGURATION(s) \
> -    ((s)->compat_flags & PVSCSI_COMPAT_OLD_PCI_CONFIGURATION)
> -#define PVSCSI_MSI_OFFSET(s) \
> -    (PVSCSI_USE_OLD_PCI_CONFIGURATION(s) ? 0x50 : 0x7c)
> +#define PVSCSI_MSI_OFFSET    (0x7c)
>   #define PVSCSI_EXP_EP_OFFSET (0x40)
>   
>   typedef struct PVSCSIRingInfo {
> @@ -1110,7 +1104,7 @@ pvscsi_init_msi(PVSCSIState *s)
>       int res;
>       PCIDevice *d = PCI_DEVICE(s);
>   
> -    res = msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
> +    res = msi_init(d, PVSCSI_MSI_OFFSET, PVSCSI_MSIX_NUM_VECTORS,
>                      PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK, NULL);
>       if (res < 0) {
>           trace_pvscsi_init_msi_fail(res);
> @@ -1298,8 +1292,6 @@ static const VMStateDescription vmstate_pvscsi = {
>   
>   static const Property pvscsi_properties[] = {
>       DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
> -    DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
> -                    PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
>       DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
>                       PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
>   };

Does this compile? I think you missed a spot that uses 
PVSCSI_USE_OLD_PCI_CONFIGURATION in pvscsi_realizefn() ?

  Thomas


