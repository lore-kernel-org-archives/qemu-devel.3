Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129B0C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QL5-0007rj-IT; Mon, 28 Apr 2025 11:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9QL2-0007hG-JB
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:24:08 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9QKx-0000Mn-FU
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:24:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so4211600b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745853841; x=1746458641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ifqLD+l1lDCElfgy5RhVvpVYiko9KXNuoV98UZB4c3c=;
 b=Z6lPnDCXoZx/8lGP/zt8n5iQqJJ2bIZ2o2DzLWQXAzd5XkJZqrlFN7v5omaQgrHvRX
 M6JhUy5+GqGu56IRO240mBN8aIYMC2wOn80myh+sk7IDM+B5eWxZSCT/u24pUj+TFZHn
 qchRR7xyWtS1u9twKp3CzPEOwhQCykn3yP7L2kMX0UK0WuGEU76VrNpDt+Vy2OACOWAa
 hKS3tRwuy1jylTQCeeseptCf982/hhDZdOO+6YLgH/i3a3M0NT6zBNR230LYvz0SKdec
 Bijj+AxEdkBGQ+Z2B8K7TR8yHChmPEGdT7m/Qod88c2RKh7gAG7p5CZUTVNe/cqctYY4
 jrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745853841; x=1746458641;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifqLD+l1lDCElfgy5RhVvpVYiko9KXNuoV98UZB4c3c=;
 b=LPstZwDk/xdM5rYPocqKd/+lQLKqXwPUnGfGWgXP398LbLj3YTvrZScfxedZJqEjFN
 F1+PabVrDIrQccoLPnpZRR+Ha51E6xbRvrkwDKjJ1oXy/xUS640gh5JQY3K1gLUw3WGo
 ii47mI1lM4GrB0kDV81reCskEyCuMCUb6992pR8d6tLdiwSA4ULlLHjc58aErOuWsIbt
 7HprZzw1FkNaq8MSRklPTeJoxpOG10N12M80PFbnKKjHZGs4mc+SQeFsaVG03bqx+tVE
 SM/wN3P1tkTd2GxF9siOeRvqRGpgdrSgDpcNEQYCeL6R4iQw1DUXZUUaD5zOkLdIuLne
 FbGA==
X-Gm-Message-State: AOJu0YzBGJ2GiF6xC6SA3ygq1iPwIykuxfy/KStBHfMPosBJaEL8kZTK
 m/Pc5J9XV2Zzbno3ngPmUpRUQ5agLU62MiIkaAL3MPWMipqLdb4=
X-Gm-Gg: ASbGnctqLjnMb1doqu06xiXoISaT9Q9VBzMwxfDgkCN0t9IbQ26zjS/46DcwyzFWzwr
 qHdfu1Eblu03q0QOrS7QFt2WoRCfj9HM9alH5RuGEkb2hHW2OwJ8P4UH4iuiA9IxvBh+IA+T9Th
 eQ/TmynPMYE9B4mbQmctsvPZMnQ3/Q+Dj9wt+DGb2pFqt5S26arIV8WF9gHcys9w+bmL/jwhCpJ
 aBGSHrGJGQRNnikFlph3mk2mMEjuifTnOdNVg5e1lJvcoi2aNyX8im+/LKL4+l3Da8aKZH6m5vx
 gyl89pRUC+X7dO/qFz4I7OmkppTLbFVhtg6lF6Wbqla0f5o=
X-Google-Smtp-Source: AGHT+IHXjdrD/xQuWMFQaWPX7oW4DLQOKgnX9Y/NAQXewsgzUQTR9+2gCBWXCKX0AIDc0m+zEaCVSw==
X-Received: by 2002:a05:6a00:2406:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-73fc7c4b1a4mr16856660b3a.0.1745853841315; 
 Mon, 28 Apr 2025 08:24:01 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9ff1dsm8126388b3a.153.2025.04.28.08.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:24:01 -0700 (PDT)
Message-ID: <75e6afe0-545a-4f1e-b03b-eb6e3451892d@gmail.com>
Date: Mon, 28 Apr 2025 23:23:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] vfio/igd: Detect IGD device by OpRegion
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-4-tomitamoeko@gmail.com>
 <0da35fa206f66ecd2d3a94b4c79f462284547164.camel@beckhoff.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <0da35fa206f66ecd2d3a94b4c79f462284547164.camel@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/23/25 14:54, Corvin Köhne wrote:
> On Tue, 2025-04-22 at 00:31 +0800, Tomita Moeko wrote:
>> ﻿CAUTION: External Email!!
>> There is currently no straightforward way to distinguish if a Intel
>> graphics device is IGD or discrete GPU. However, only IGD devices expose
>> OpRegion. Use the presence of VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION
>> to identify IGD devices.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 26 ++++++++++++++++++--------
>>  1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 36316e50ea..7a7c7735c1 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -479,6 +479,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int
>> nr)
>>  
>>  static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>  {
>> +    g_autofree struct vfio_region_info *opregion = NULL;
>>      int ret, gen;
>>      uint64_t gms_size;
>>      uint64_t *bdsm_size;
>> @@ -486,16 +487,20 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
>> *vdev, Error **errp)
>>      bool legacy_mode_enabled = false;
>>      Error *err = NULL;
>>  
>> -    /*
>> -     * This must be an Intel VGA device at address 00:02.0 for us to even
>> -     * consider enabling legacy mode.  The vBIOS has dependencies on the
>> -     * PCI bus address.
>> -     */
> 
> Why do you remove this comment? Yes, the comment is not correct. Some OS driver
> and the UEFI GOP depend on address 00:02.0 too. Wouldn't it be better to improve
> the comment instead of removing it? This restriction looks a bit odd and IMO a
> comment would help future reader to understand it easier. 

The restriction is documented in doc/igd-assign.txt, keeping the comment here
seems misleading IMO. That's why I decided to remove it here.


>>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>          !vfio_is_vga(vdev)) {
>>          return true;
>>      }
>>  
>> +    /* IGD device always comes with OpRegion */
>> +    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
>> +                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>> +                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
>> +    if (ret) {
>> +        return true;
>> +    }
>> +    info_report("OpRegion detected on Intel display %x.", vdev->device_id);
>> +
>>      /*
>>       * IGD is not a standard, they like to change their specs often.  We
>>       * only attempt to support back to SandBridge and we hope that newer
>> @@ -570,9 +575,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
>> *vdev, Error **errp)
>>      }
>>  
>>      /* Setup OpRegion access */
>> -    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
>> -        !vfio_pci_igd_setup_opregion(vdev, errp)) {
>> -        goto error;
>> +    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
>> +        if (vdev->pdev.qdev.hotplugged) {
>> +            error_setg(errp, "OpRegion is not supported on hotplugged
>> device");
>> +            goto error;
>> +        }
>> +        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>> +            goto error;
>> +        }
> 
> How is this part related to "Detect IGD device by OpRegion"?

As Alex suggested, this part will be refactored in v2.

Thanks,
Moeko

>>      }
>>  
>>      /* Setup LPC bridge / Host bridge PCI IDs */
> 


