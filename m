Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB39C3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 11:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3vXh-0000bJ-Bf; Sun, 13 Apr 2025 07:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u3vXY-0000Y7-7h
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 07:30:20 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u3vXW-0003DA-3P
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 07:30:19 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2264aefc45dso49667015ad.0
 for <qemu-devel@nongnu.org>; Sun, 13 Apr 2025 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744543816; x=1745148616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lv7TgfyJEBdBrMaoFW42HxSBbUgJkVc3QVfwlKZ5KJM=;
 b=LMxO0ccRcIwLrUIqPUbfCN1wqLtJiZ1xwwgl0tstey7Vh56q3pBYXFkad9tMlH9v2w
 kFWOtkoHnZiLiqpusTLk0duJ/c29/J0F8v6atPsmHtU7DZm1NVdTU8Fpa4M6wmMjUZef
 0ZDIXTE+I+nCW6xyEAw+VKNhfSAbuO0vHTPAjze5pNjqKD1K1klW1JYQ0C2D8SCixw9l
 S69saMq53L/m/2vGufSOsINSNcloQ4mfR2La3RcgvVI5IY9ZCojlWacT3KtVchrxHu1D
 0n+TtSZymhtc0viGhqK9XzB13h0qVaDl6XOtvSqeqK5GVen+AxNH1gosXAc5sJ62Wc7F
 Gdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744543816; x=1745148616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lv7TgfyJEBdBrMaoFW42HxSBbUgJkVc3QVfwlKZ5KJM=;
 b=Hi5WDP9kGyKB7dj6/kr4XuEX3ax4y0QG5UyBNlUCzujU3uIDcO0AVtnOJdIWwZ7poz
 X7n/Cx7JMTqAZVq+cN8MdyFmr8rPdEv6uZfJSH4NkPonsWlkRu7YCoNoPFvcKJN6nljX
 zmVkY3D4L3+L6CkN7ZHDfc1JQJXek1QlkSQ+oFOMEhr0yxXyNCx8dtTF+Vll6rJ/U/81
 TMp0uZQN+VBrbSz/ApD9O9oPhIXFwTiFhlccRPbuq95sWgmyoq8wvT8r7wE8LBw8maVV
 wDOjte/sUtlSnCPpFjGO+95ztyp1Gsj2/QsAZEZTJsWe4r0qwWWBRnEy3Wciq9jCQ2Mj
 nzkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHT2kpeVeWdTpEAg+0uZng2s0d0UwRRz//RLzA7C9iL4Heq+WNsNT91eowB0uj9O8iDDpEh2LDgCOI@nongnu.org
X-Gm-Message-State: AOJu0YxpJy/OZ9ZPISr3QQzSiGF6JB7/gx52VUaVuLk1jUhxDm2aK+bE
 O0fsKkdHW4j+Jt7xXP6/4L4hgBI0Ar+qGQQ+qYxyXJRx/m8LtqY=
X-Gm-Gg: ASbGncvWXfDH39Y9cQmDkrR/XGbevKzuXODfeUdstiTVAgv46jUt6/zCj4OoSCj2JH8
 q2OhokB/ad6F73s/pfsfOLT+qmQ7R8gClL9Aa0SHfckNvK1R9Kc7rPgGPhU9sR1ThThEofgyhzS
 GIceZghXSMzG7IraflzsBDhBIgGZOr1i8PbEhzSdU8QAj3FfcoJXlCRqbEjm2Id+y6qI/+5MTE1
 zwNVJsg3Cjy7165OPDiev86+T9s7yYbF45HlFYwSuW32Y7tWYWonc3Hu7w9XrXMJlG9fcW+kDJe
 pfEq47aIuBK/80/S8LMMSPPsdEivp2ZtjZeKi2Yd8Y+MfQ==
X-Google-Smtp-Source: AGHT+IEZEN71iz4f6668VdJfD/HtnTyo0Bzmj2p+4crgJAO11x8QziKcBeFYv2rcqZ9Vb1aR25KFPg==
X-Received: by 2002:a17:903:1b2f:b0:21d:dfae:300c with SMTP id
 d9443c01a7336-22bea4953d3mr137363505ad.3.1744543816270; 
 Sun, 13 Apr 2025 04:30:16 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21949cfsm4784134b3a.29.2025.04.13.04.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Apr 2025 04:30:15 -0700 (PDT)
Message-ID: <50fe6263-2459-4e49-a6f3-a1166a0846f1@gmail.com>
Date: Sun, 13 Apr 2025 19:30:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250409111801.4c97022f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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

On 4/10/25 01:18, Alex Williamson wrote:
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
>>  hw/vfio/igd.c | 23 +++++++++--------------
>>  1 file changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 265fffc2aa..ff250017b0 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -53,6 +53,13 @@
>>   * headless setup is desired, the OpRegion gets in the way of that.
>>   */
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

Sorry for my late reply. Yes `vfio_pci_host_match` does not work for
sysfsdev of fd, I will drop this change.

> Could we instead rely PCIe capabilities?  A discrete GPU should
> identify as either an endpoint or legacy endpoint and IGD should
> identify as a root complex integrated endpoint, or maybe older versions
> would lack the PCIe capability altogether.

Older generations seems do not have PCIe capabilities in their config
space, like the sandy bridge spec [1] does not mention it. I don't have
a sandy bridge box for now to verify it :(

> Also I think the comments that were dropped below are still valid and
> useful to transfer to this new helper.  I think those are actually
> referring to the guest address of 00:02.0 though, which should maybe be
> a test as well.  Thanks,
> 
> Alex

Guest address of 00:02.0 is not mandatory, newer drivers does not depend
on the address (probably thanks to the discrete GPU, they removed these
hardcode). Though putting it at guest 00:02.0 is still recommended.
I would prefer not making this a limit.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/3rd-gen-core-desktop-vol-2-datasheet.pdf

Thanks,
Moeko

>> +
>>  /*
>>   * This presumes the device is already known to be an Intel VGA device, so we
>>   * take liberties in which device ID bits match which generation.  This should
>> @@ -427,13 +434,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>      VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
>>      int gen;
>>  
>> -    /*
>> -     * This must be an Intel VGA device at address 00:02.0 for us to even
>> -     * consider enabling legacy mode. Some driver have dependencies on the PCI
>> -     * bus address.
>> -     */
>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev) || nr != 0) {
>> +    if (nr != 0 || !vfio_is_igd(vdev)) {
>>          return;
>>      }
>>  
>> @@ -490,13 +491,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>      bool legacy_mode_enabled = false;
>>      Error *err = NULL;
>>  
>> -    /*
>> -     * This must be an Intel VGA device at address 00:02.0 for us to even
>> -     * consider enabling legacy mode.  The vBIOS has dependencies on the
>> -     * PCI bus address.
>> -     */
>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev)) {
>> +    if (!vfio_is_igd(vdev)) {
>>          return true;
>>      }
>>  
> 

