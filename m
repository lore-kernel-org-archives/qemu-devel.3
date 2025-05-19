Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DDEC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH4Hc-0008DJ-Tt; Mon, 19 May 2025 13:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uH4Ha-0008Cc-Qo
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:28:10 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uH4HY-0003Uc-Mm
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:28:10 -0400
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso3992661a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747675687; x=1748280487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=p5m79CSNlAwWcMLcQdoYqDsBKuXSD0HuLxlUAQ/OYLc=;
 b=Z/pJXFt6elf3YxYV7k2k0PkXGKHBtVFneCfj8qpX4e0OUghAnsJAv32WOuO+9xXNEp
 wOO6LDtQ9P6AsChmNMi57xI5ySDYPfDmBhCNRl0Iw8Q5jv8+ftpauFL9/Dam+NXmQbBR
 8Q9FtEBNE9aKnIOUOMCX914CKU5y61CA6uRfx6ekLBnlFlrRPip/dfllnU+yUhQwa6N5
 q3IKCiBazMaZTIeTkrHLjTQlwOj75WyRPBrmEuK8ATKMjBnHS4EXUIwoH8YPJwGvKkwb
 c7TiPq80SYlQvHtmJVGy+PK5QWnS1+TRVs/3jLK6N8Roy1p5pbyCLuCZWOyMYiacLOho
 N9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747675687; x=1748280487;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5m79CSNlAwWcMLcQdoYqDsBKuXSD0HuLxlUAQ/OYLc=;
 b=rm1ERZy07EK2CfgMzLJLsztfEDBUEs+yQSuw7lluJzUAdgbx6+HalXBv2+cmaeLPeu
 eFpZxEMaGkWA1ItzHTyFvBzBFlDHyOct4oOYYJLsjf5kV1JT3HzHa8rjU3ld9Xm7P1Pq
 Uc8QBKAbxLJIoh9cjCWlj5XFbopOae1kunenqLzrkB0Nix7i1lpTSc2kxT3HeMxqYZSD
 t47nw667b6r73z2HjwAq+l+NHiNmEL8PwoATTIyw/AcHzyQ6oSZWAyWs+IZzXmZWfr9g
 Gvo4o2Bo8aggpDfJEUHvmh+SZIRrQdYYvK9CA/qrfKYc7/npiX4vsjj/NjXxrEKDFT66
 QzCw==
X-Gm-Message-State: AOJu0Yys5Z0KDkPuEK0cNj8/Dbu8xa9b6y/G1L8ndtEHmw8mSGB2rOWl
 Abhqkrv/aiwU8MON4juMykn9O1fzz5GE3gCB0t8hg0gOe1HglvsFy0AF5nyYbZBdTwAr
X-Gm-Gg: ASbGncvkDe83lLAoT/SnMbUCEdzGSUU5iqOMqvaLH1gmwYOq01C7euB8JBtX9vl1z7u
 Lmnl440nJMcbPLB1L7krDTPmIVoOHgtyFG+D+SY3BTl0hCO8iF7xTkvhcFH2ZOjVhkL/utC/up6
 1KqZnK3qUjaS5NVRulvsE7udskljdvYWxhAPz4ermzUkfOVJeGbdOS9R96bCNJmomi6MGR+3bVx
 tnj0MQc1l0EVbB7vbb4UOXjPsxMMOSmAA9J0KQoEBYu4FPOLscKPGFdSwiIhQP0Nc255i7AZBZT
 g6SebHjHdz7N5xnsRM8l45UCGtZ5uDa7tcQeNi0sVXFznw1d4biSqjV8aD8=
X-Google-Smtp-Source: AGHT+IENiEa7s70yRCJmRTamHjbgL5XMh2zjoHyK+Sfjas4g0bcnTf8crige/m6Rm9NsrhK18yVwYg==
X-Received: by 2002:a17:90b:4b82:b0:2ff:7b28:a51a with SMTP id
 98e67ed59e1d1-30e8314db35mr23939904a91.17.1747675686633; 
 Mon, 19 May 2025 10:28:06 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e7b4dda42sm7047916a91.35.2025.05.19.10.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 10:28:06 -0700 (PDT)
Message-ID: <5de0e6b8-7c05-4e20-b828-93442c670eca@gmail.com>
Date: Tue, 20 May 2025 01:28:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Support non-boot gpus
To: Alex Williamson <alex.williamson@redhat.com>, Qwinci <qwinci222@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250519150837.23146-3-qwinci222@gmail.com>
 <20250519111527.6cafd01a.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <20250519111527.6cafd01a.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1041.google.com
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

On 5/20/25 01:15, Alex Williamson wrote:
> [Please Cc maintainers - added here]
> 
> On Mon, 19 May 2025 18:08:39 +0300
> Qwinci <qwinci222@gmail.com> wrote:
> 
>> Change the IGD detection logic to also accept gpus with
>> PCI_CLASS_DISPLAY_OTHER class which is used if the igpu is not
>> set as the primary boot gpu.
>>
>> Signed-off-by: Qwinci <qwinci222@gmail.com>
>> ---
>>  hw/vfio/igd.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index e7952d15a0..1ddfcc2c17 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -454,6 +454,16 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
>>  #define IGD_GGC_MMIO_OFFSET     0x108040
>>  #define IGD_BDSM_MMIO_OFFSET    0x1080C0
>>  
>> +static bool is_igd(VFIOPCIDevice *vdev) {
>> +    if (vfio_is_vga(vdev)) {
>> +        return true;
>> +    }
>> +
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
>> +    return class == PCI_CLASS_DISPLAY_OTHER;
>> +}
> 
> But the function isn't detecting IGD, it's detecting VGA or DISPLAY
> class devices.  So it's misnamed and we might want a new
> vfio_is_display() and if necessary a wrapper for both that tests
> vfio_is_vga_or_display(), or maybe a vfio_is_base_display() if we want
> to test only the base class.

+1, matching the base class is enough here I think.

> More importantly maybe, sure there might be IGD as non-primary
> configurations, but are the quirks still relevant to those devices?
> Which ones?  Thanks,
> 
> Alex

Actually this is what I've worked on for a while. Only the OpRegion
quirk is needed in this configuration, Windows driver requires it.
Additionally, legacy mode should be disabled when IGD is non-primary as
VGA ranges are not routed to IGD.

It also requires a more recent version kernel (6.15+) [1] for OpRegion
support on IGD as non-primary graphics.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=41112160ca87d6b5280813ef61f1c35bb9ee2f82

Thanks,
Moeko

>>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>  {
>>      VFIOQuirk *ggc_quirk, *bdsm_quirk;
>> @@ -461,7 +471,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>      int gen;
>>  
>>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev) || nr != 0) {
>> +        !is_igd(vdev) || nr != 0) {
>>          return;
>>      }
>>  
>> @@ -519,7 +529,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>      Error *err = NULL;
>>  
>>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev)) {
>> +        !is_igd(vdev)) {
>>          return true;
>>      }
>>  
>> @@ -685,7 +695,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>      int gen;
>>  
>>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev)) {
>> +        !is_igd(vdev)) {
>>          return true;
>>      }
>>  
> 

