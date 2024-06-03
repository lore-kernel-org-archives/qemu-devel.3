Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD91C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBXK-00045f-H0; Mon, 03 Jun 2024 13:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEBXI-00045D-1r
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:31:56 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEBXF-0001Cq-JT
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:31:55 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a626919d19dso835917066b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717435910; x=1718040710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rgB7YIH07ZSI2iJe5vUZwdu+uy2JX1OjRrwkWJ7xJ14=;
 b=pfckXcIUjB+KVftHLx3Gd6XHXnPLCIRkUFqG4tk44DHwOX168M1lhjpgzzEO31D4Ig
 fD+/T78STGW4dutpN1Onc5d3hM0cVUWVps3PViIUXLALDiy4nHG0/+z7faPRoH70963j
 j1KxTjhGuVWbp27GsldM9FQ6qCMJiVOVBYpRz3BUvB9qPkMin4r+04fH9slMH/QDT1wg
 fvDzdUmPgyHrzHkdamVMGlukVmkLu9V1t70BgXz5bjaULwPoAGgGCX0kJ++hYxVi/qFJ
 Tqtyz9onvJ4o4LnbZvrnBkMLbdOZsWjpPXBXMBaZvAu6AS0Qq+oHHvm/0/v+h0VqCLKR
 ZYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717435910; x=1718040710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rgB7YIH07ZSI2iJe5vUZwdu+uy2JX1OjRrwkWJ7xJ14=;
 b=JYrwvvJHsULYVgdCUk6ghcEa1S3KBzVCHKZup505BZ9JPzeTErDVoKjQdyrWHvsXdB
 UremfEAf7hehVrg2i9lxpA+m40FasxZ176M7l3FA+uyMVOoLaq/1Krn+UGDwfagAosuf
 jcGJX3PB5Y2vpd+YiK9kBMK6KlxTxJpriSWgzeluKuZpSKGcV1c+prqSRpsHI54wXnB0
 x+DlAWX4ohB1AX/ZYzwPs+2MHIJBaZcKuExQcXnPOfDIvf0RcOpb0q8/D0u8qmRiahkb
 xvM9MtFAC4KEob6vUI9DM2JUvOcIWfOVxnyYdaKM9d4Pb3imW1QZl0qau/4SzuKRDckQ
 3+Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZvQX1BX0544CMZLckEwawg8q2diOlhYIjgaRKPovJFcvFBCC0+uxOfbnf/usY17O/E1HkGIIaE4azVPQ/U2CLCy2WsEY=
X-Gm-Message-State: AOJu0YwoEqOCOnvgDKmJcHue8MFT9R2EIVEC9WSiVOl+xHpX+Ne4T4hc
 C7cyLfRyQcXtdeqlfF0BHMLUkNUdcniXZSeDnC5TSkaFPmTIFSrqGKxosPz35vU=
X-Google-Smtp-Source: AGHT+IGaeXutsKaVqNnXgxkc/d53vdbs4N50E7JpT9uTRdYgyz9hWTkLKLx1SPFgEyN9P4bh4p3I6A==
X-Received: by 2002:a17:906:3149:b0:a68:e834:e9bb with SMTP id
 a640c23a62f3a-a6954bb5537mr22974866b.35.1717435910487; 
 Mon, 03 Jun 2024 10:31:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ed879eacsm283925366b.99.2024.06.03.10.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 10:31:49 -0700 (PDT)
Message-ID: <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
Date: Mon, 3 Jun 2024 19:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
 <20240602092857-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240602092857-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Michael,

On 2/6/24 15:30, Michael S. Tsirkin wrote:
> On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Zhao,
>>
>> On 12/4/24 10:53, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
>>> the supported CPUs for PC Q35 machine.
>>>
>>> Update maximum CPU numbers for PC Q35 in the document.
>>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>>    docs/system/target-i386-desc.rst.inc | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
>>> index 5ebbcda9db4c..319e540573d3 100644
>>> --- a/docs/system/target-i386-desc.rst.inc
>>> +++ b/docs/system/target-i386-desc.rst.inc
>>> @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
>>>    -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
>>>       hub.
>>> -SMP is supported with up to 255 CPUs.
>>> +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
>>
>> This comment is not accurate since a while, IIUC:
>>
>> Up to q35-2.7: 255
>> q35-2.8: 288
>> q35-8.0+: 1024
>> q35-9.0: 4096
> 
> 
> What are you saying here, Philippe? I don't think compat
> machine types matter enough to bother with more detail.

My point is I find this description confusing w.r.t. how QEMU behaves:

$ qemu-system-i386 -M pc-q35-2.8 -smp 666
qemu-system-i386: Invalid SMP CPUs 666. The max CPUs supported by 
machine 'pc-q35-2.8' is 288

$ qemu-system-i386 -M pc-q35-8.0 -smp 666
qemu-system-i386: Invalid SMP CPUs 666. The max CPUs supported by 
machine 'pc-q35-8.0' is 288

$ qemu-system-i386 -M pc-q35-9.0 -smp 666
Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:447:
qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
Abort trap: 6

I'd rather at least:

"SMP is supported with up to 255 CPUs (and since v9.0: 4096 CPUs for PC 
Q35 machine)."

or:

"SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine 
since v9.0)."

>>>    QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
>>>    VGA BIOS.
> 


