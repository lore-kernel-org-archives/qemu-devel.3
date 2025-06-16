Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B95AC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2m5-0003z5-SR; Mon, 16 Jun 2025 01:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uR2m0-0003xz-G8
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uR2ly-000053-Qt
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750053164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOfaEfhJ/48hisRsb95ucnEsFMeLGglLJnApf87mZaY=;
 b=O/BaJhWqyFu5ANsu7VOAkNqo+z5d86XtGwqHPy8uKb3NKILhTEe0tFDMGcAPWwBJgnZjbc
 y8S7aV35By7khd5qMT1xTrzN6V0/s2yBAy02nCl+turnCZ8guvghm0Sy99dSo5E5EEVQd7
 wypBC2cM2NVmGCjk/SJZXXII7Y0QEAY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-2Xkm3D3CN--S2BJCTbGCWQ-1; Mon, 16 Jun 2025 01:52:41 -0400
X-MC-Unique: 2Xkm3D3CN--S2BJCTbGCWQ-1
X-Mimecast-MFC-AGG-ID: 2Xkm3D3CN--S2BJCTbGCWQ_1750053161
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23632fd6248so36907365ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750053161; x=1750657961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UOfaEfhJ/48hisRsb95ucnEsFMeLGglLJnApf87mZaY=;
 b=TFLKMt6z9aQJTmKeYprc5fpLnREz4LTY3YhJ4EHOKLCTotqlRV9yLtvZS1dOsazc56
 H0GXw5zOCvTRundgKa803L43H6iI2DvzcvExtBh1hNdcuJlgQ1T76uspvKTb1P6M2fo/
 aoZNaPoeOkb4uHu46bnPDSQhsQZ0qFoFjJYlsqBQrPEcezGKZ1q0Zj7iSKFR1Por2KBm
 Se5BSceOuoPJUsHCTKTs/aEr13apPXwfUELdlKOL6cnrBeAoMM0wYfZRbSwXRhQ4+Zyj
 ubiPD9Sw0lE7SisiUNtxj8IJC7eM+T/wOc/gTBr3MzeOPTqFE7t6ffwdPGNxjpmGqBNj
 HCVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxGW/8Stz8kJaOBbX94CKeyqBwvG2yIDazZPd7qo44s4a2WXNOmyrq/IsTdWRSAsmUns+5e0Pu3SKm@nongnu.org
X-Gm-Message-State: AOJu0YyO35Yzli/vUDeLzKgRBFg5vPQkTwmOjlSIuG32ifhnlqjDQfXK
 qzO5Pt/j/lWyyArFJVrPxcPlDU7Z0uob0KN8dCaNP0y621fSXhm9EiIfGb0ROD1vkw9UPC9mM4n
 FQSQvuaQMI0RyKO/y+vrJR6uMrNWMHsX50y74K7XW9aSWw8fcXfcCPuds
X-Gm-Gg: ASbGncvmDaoMof9CFO6Bhf8Nci1r2WxAidkPC8xGBQeoVSfoqi9dSIVDr1gn9OjFd8X
 IQxP781n8AS1L+GxW62nQWqr0RCjFTMkbjq7IKEmHNxA+i40NCy+CWkUD7ALRr6Qg9IRmJ4t0kU
 U+1OliS3gJwRVU2ZdWoGq9OPZFg4xU7EVezM6oXfrGozsDk0OzEJ/OVOGBg0DKHmTKrSIYgTMFY
 Y8gxy3F0Csd1lxo674HL48gMxeWS3YzGYSEQcSEmZd87W+VrYExmdUvjqKFgdh+aqjBmUfBKcU/
 ax/ZmsBl6RMkPulyyue//3Ip/w==
X-Received: by 2002:a17:902:e745:b0:235:27b6:a897 with SMTP id
 d9443c01a7336-2366b3c5ad3mr119165525ad.34.1750053160727; 
 Sun, 15 Jun 2025 22:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcCqN0JOoUZEV+XLY4tHb5VqY3sQfc0X6tgO1SyZjB7u4tKyqurk1qDLAEJRo4JCBv8kixpQ==
X-Received: by 2002:a17:902:e745:b0:235:27b6:a897 with SMTP id
 d9443c01a7336-2366b3c5ad3mr119165265ad.34.1750053160305; 
 Sun, 15 Jun 2025 22:52:40 -0700 (PDT)
Received: from [10.72.116.52] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c1b6d56bsm8722799a91.46.2025.06.15.22.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:52:39 -0700 (PDT)
Message-ID: <d3674d9d-b147-4094-b2aa-27d73d237907@redhat.com>
Date: Mon, 16 Jun 2025 13:52:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ramfb: Add property to control if load the romfile
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eauger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250609073408.2083831-1-shahuang@redhat.com>
 <20250609073408.2083831-2-shahuang@redhat.com> <aEakP3rDTyBqDXA5@redhat.com>
 <dli36wx3pe5we6xg5w7c3vyxifnfctovurucrci75kec3qk2y2@2dweacwekfcl>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <dli36wx3pe5we6xg5w7c3vyxifnfctovurucrci75kec3qk2y2@2dweacwekfcl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gerd, Daniel,

Sorry for the late reply.

On 6/10/25 2:47 PM, Gerd Hoffmann wrote:
>    Hi,
> 
>> $ qemu-system-aarch64  -machine virt -cpu max -device ati-vga
>> qemu-system-aarch64: -device ati-vga: failed to find romfile "vgabios-ati.bin"
>> $ qemu-system-aarch64  -machine virt -cpu max -device cirrus-vga
>> qemu-system-aarch64: -device cirrus-vga: failed to find romfile "vgabios-cirrus.bin"
>> $ qemu-system-aarch64  -machine virt -cpu max -device VGA
>> qemu-system-aarch64: -device VGA: failed to find romfile "vgabios-stdvga.bin"
>>
>> Perhaps some of these devices are non-functional for other
>> reasons ?
> 
> Anything with pci memory bars is problematic on arm (which is one of the
> reasons why ramfb exists in the first place).
> 
>> None the less if the device is built for non-x86 targets, and
>> the ROM files contain x86-only code that is to be executed by
>> SeaBIOS only, then conceptually this fix should apply to all
>> devices use a VGA BIOS ROM, not just ramfb.
> 
> Note that non-x86 drivers for some of these devices exist, we have at
> least roms/QemuMacDrivers which includes a driver for (IIRC) stdvga.
> 
> The ipxe roms are x86-only too btw.  We could make them multi-arch at
> least for EFI platforms, but given that edk2 ships a virtio-net driver
> and the recently added EFI archs (aarch64, riscv64, loongarch64) are all
> younger than virtio-net there is little reason to do so.
> 
>> If we're introducing a property to control this usage, then
>> we should fix all devices at once, so we don't need to add
>> separate properties for other devices in future.
> 
> All pci devices already have a romfile property.  So for most devices
> this is a matter of setting this property via machine compat properties.
> 
> ramfb is a bit different here because it is not a PCI device, so we
> can't control things with the existing property and need a new one.

So I guess I don't need to add property to all these devices and keep 
the current code is fine?

Thanks,
Shaoqin

> 
> take care,
>    Gerd
> 

-- 
Shaoqin


