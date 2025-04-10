Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D385C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mQj-0006Gw-7l; Thu, 10 Apr 2025 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u2mQi-0006G1-0f
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u2mQg-0003hp-03
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744270468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YsyFbqG09L5Ldr4f4/T7Jg8k1ScvV4f0qqsSV/0Oo5o=;
 b=HjbTwpVOcSGJjV/sajmB1q8ESXa1e3zHe0v1xyH0MGo430bAURVptdkOHiAps1odNhiYZ+
 6nW2xxeVVD2WR5nwvJUB6Y8GFZWt+1ePuo++HevNFlEmF4kBYSaOZ6TR9/oh/WEDo/81m4
 UWpn7as5rtgBjEX1wUhrVNcEasr5QZY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-oOrj79LvNwWTF6zKqR85Yg-1; Thu, 10 Apr 2025 03:34:25 -0400
X-MC-Unique: oOrj79LvNwWTF6zKqR85Yg-1
X-Mimecast-MFC-AGG-ID: oOrj79LvNwWTF6zKqR85Yg_1744270464
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d6c65dc52so4878575e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 00:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744270464; x=1744875264;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsyFbqG09L5Ldr4f4/T7Jg8k1ScvV4f0qqsSV/0Oo5o=;
 b=Khz8EVvICv23va7Q7q47ahFKEZfzx/f76VJi7h91Yjt+ED8ERPj037uYPby8kSM7ZK
 mT7nCUb3NPkLiYz/ZWJ3YUT7pIHvrG9I0jxRc7UmLHs+8Tq/26qeB0uNWmo617s0KRcT
 3e6z9ex+6/uTxQ6uB7h7GyGNpbseylSQV1xH7cB4CtFSgYeoEB4miVOKbKbY0rvTa+Rz
 FUpUPpFufxGF0/XTYtt5NUduzbGlhtwPFgb6c3MYM8tTEGBAYyk7ZSnX90s3X1t+9/cw
 wr4grEBh7f34q+PxQUGgACaSFhngo3sQ8zRhUdRLPckwT+djhL7w8IUGh60f/KM/+8y8
 543g==
X-Gm-Message-State: AOJu0Yz/0mLQ664KxcM24g/qHi40PmRAteh6ihVA90zmRRjDOdXOl0VK
 sol/re5TTR2Usaz3rDKahyN4FLIBu7vQADwt85V+MvJsZz221G/ro7LF0lmlUfDBfwZ8wo0iJ+3
 tTmp9xstVOZ2OVsHCYp7GdRf0wC1pg4Euel/njST0HA29nl19oc0Z
X-Gm-Gg: ASbGncs0xVXD0V8WYIxvsaEanfej7Sz/GLgPfiYCnlk/E8eJTzdXFujy71l4T3Gb8+O
 /ingw5XX0BUbvOst0DKkmnxlGMy8yv3CcLVtoM6ISNW6P2v+op/Mx2aMDgeekDHuR2s1Zqr2d2X
 OhcP23xja6LcTNKgdqhJCVviR/8Kt0GTP1TE05OLm0aQfzVGJJO/aI+f+uHWU3cqaN7DBK3GUlY
 rZpmXLuM/y2bFGCHTa8L7N9Y1p/Sz8Gs5j4Lkld7858EKXKYwGSbLmEOMvmouUevzKv758LILv1
 y9+Pe3nWvZAjdiZ9LA5U42wm32snaktamGEPW2iq3v9Hgom4zQ==
X-Received: by 2002:a05:600c:4f4e:b0:43d:49eb:9675 with SMTP id
 5b1f17b1804b1-43f2d952964mr14384385e9.22.1744270464224; 
 Thu, 10 Apr 2025 00:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/bjntmfeGJO4LzSjl+I9HhXG+f2A5D9n7ltM3T4PCvw2dlRXjBUx82RvN8jvETE6aKWQjjA==
X-Received: by 2002:a05:600c:4f4e:b0:43d:49eb:9675 with SMTP id
 5b1f17b1804b1-43f2d952964mr14384225e9.22.1744270463887; 
 Thu, 10 Apr 2025 00:34:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d004sm46255435e9.18.2025.04.10.00.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:34:23 -0700 (PDT)
Message-ID: <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
Date: Thu, 10 Apr 2025 09:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
To: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409111801.4c97022f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

+ Corvin

On 4/9/25 19:18, Alex Williamson wrote:
> On Wed, 26 Mar 2025 01:22:39 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> So far, all Intel VGA adapters, including discrete GPUs like A770 and
>> B580, were treated as IGD devices. While this had no functional impact,
>> a error about "unsupported IGD device" will be printed when passthrough
>> Intel discrete GPUs.
>>
>> Since IGD devices must be at "0000:00:02.0", let's check the host PCI
>> address when probing.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>   hw/vfio/igd.c | 23 +++++++++--------------
>>   1 file changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 265fffc2aa..ff250017b0 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -53,6 +53,13 @@
>>    * headless setup is desired, the OpRegion gets in the way of that.
>>    */
>>   
>> +static bool vfio_is_igd(VFIOPCIDevice *vdev)
>> +{
>> +    return vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) &&
>> +           vfio_is_vga(vdev) &&
>> +           vfio_pci_host_match(&vdev->host, "0000:00:02.0");
>> +}
> 
> vfio-pci devices can also be specified via sysfsdev= rather than host=,
> so at a minimum I think we'd need to test against vdev->vbasedev.name,
> as other callers of vfio_pci_host_match do.  For example building a
> local PCIHostDeviceAddress and comparing it to name.  This is also not
> foolproof though if we start taking advantage of devices passed by fd.
> 
> Could we instead rely PCIe capabilities?  A discrete GPU should
> identify as either an endpoint or legacy endpoint and IGD should
> identify as a root complex integrated endpoint, or maybe older versions
> would lack the PCIe capability altogether.

Maintaining a list of PCI IDs for Intel GPU devices as Corvin was
proposing in [1] is not a viable solution ?

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20250206121341.118337-1-corvin.koehne@gmail.com/
  
> Also I think the comments that were dropped below are still valid and
> useful to transfer to this new helper.  I think those are actually
> referring to the guest address of 00:02.0 though, which should maybe be
> a test as well.  Thanks,
> 
> Alex
> 
>> +
>>   /*
>>    * This presumes the device is already known to be an Intel VGA device, so we
>>    * take liberties in which device ID bits match which generation.  This should
>> @@ -427,13 +434,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>       VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
>>       int gen;
>>   
>> -    /*
>> -     * This must be an Intel VGA device at address 00:02.0 for us to even
>> -     * consider enabling legacy mode. Some driver have dependencies on the PCI
>> -     * bus address.
>> -     */
>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev) || nr != 0) {
>> +    if (nr != 0 || !vfio_is_igd(vdev)) {
>>           return;
>>       }
>>   
>> @@ -490,13 +491,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>       bool legacy_mode_enabled = false;
>>       Error *err = NULL;
>>   
>> -    /*
>> -     * This must be an Intel VGA device at address 00:02.0 for us to even
>> -     * consider enabling legacy mode.  The vBIOS has dependencies on the
>> -     * PCI bus address.
>> -     */
>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev)) {
>> +    if (!vfio_is_igd(vdev)) {
>>           return true;
>>       }
>>   
> 


