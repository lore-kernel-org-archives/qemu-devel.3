Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7175C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOh0-0006do-EK; Mon, 12 May 2025 04:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEOgt-0006dO-Hm
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEOgr-0001LP-5o
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747039152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FWMDKjPU12juYDRaZmbc9Elzl/N8VDhozI0R09W4HJs=;
 b=OTgdwZgEkTZ/ZtftGxJvg8o9UqooFjDrdlZ50S+zMKPeB7jGjFBbxhNt1gBpoVIZIly0dS
 tpYnl3Qy1grHnUU9Ch+93Lly/noa1ahvfpw77bBp1FRLSjYqA5HwbsVjSHGJ/HNKfSBybT
 MHv9h3CDJC/WwRj7lkjWFbTYNsJaKX0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Ahb9nEM0OnWZKG9SzTVNPw-1; Mon, 12 May 2025 04:39:09 -0400
X-MC-Unique: Ahb9nEM0OnWZKG9SzTVNPw-1
X-Mimecast-MFC-AGG-ID: Ahb9nEM0OnWZKG9SzTVNPw_1747039148
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442e0e6eb84so8723735e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039148; x=1747643948;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FWMDKjPU12juYDRaZmbc9Elzl/N8VDhozI0R09W4HJs=;
 b=AKJnzVj08MmXg5zA0YVhCX25Unyz0x1Dogw+3ey+hgI0Zx7sQZvXcvEY7J/qeCbCSe
 V3tiThhl70zOizkpVmr0z/YqT6ZSnsDltCrqOm8VlV0WtXHQfEv6Y8gYmrpY2Y+bOiu8
 swydoo9zzApoP/+Vpqz8N1xRXVuffJJlo7mywvQvwLYTc96KKAm2e9GNquEQSDy/UODm
 7tvuIdMcW2S8r+NZoQfjNQkBbyOQRQbP01cnvh6lRgtyU/IadCac/v3PdS/KP7lxd2m2
 0vnmK0PgxiDBmqtSPb9HyX39hhRt3XoiVaCyEF5+SnL5g35yU+R3B+UCVixhEr+3lhK/
 eNzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+gR7rsi8+e9W3isB1LvdhgkEYP3LJVEe/lgS2GovHehu+u+sSZV01BA/z9DCT9smzxkXGGuyZDF28@nongnu.org
X-Gm-Message-State: AOJu0Yz7em0Cv296YygbP7mhF98ja8QMWCPG1oDlU4+huDqAIL3KmlYG
 N8K49TCPCgu4zO4HhhUpX8at3Ch9pRAqrVUCo0kkjRmnMm+6Dml23IPMBGFaLV4B0NdKdlfiRPe
 gFxoEv8CbXFy0izw7lez/UokQr5D5o/vo6hLC+ov4Y5RR6yAhXAxo
X-Gm-Gg: ASbGnctv726yhdILcWaE0gxBkpS/BjBI3PgkH2Y8F5XMhEN0O38Q2oXZatPMQGrsPJP
 Xcz/w/zvpTRcPzIdP/sEZ3t9lGn9nXdeCg6R9Y9hEJElW/h85OvaSItiCN/OYLZu+yulMrTsDct
 9mihp3PMPuJg6NXWODnWylWwaMXZGtuy9ZNIlWNAfx1r29/m6tYcK8BytaxLWv7z+Tpz/4yZ/9F
 6zLvLYBilJIgRovUTQ2Jt5m6Fxm6myW823tBfFuFgly8LNqcjlvA7jVjMHlk4YYxWuCmod68EqD
 rmqspXWNuNJPc3OndZxTkxi9wBXex0M4HahBovRQyzpD6Xmf7jAr
X-Received: by 2002:a05:600c:1d07:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-442d6d37079mr113525495e9.10.1747039147710; 
 Mon, 12 May 2025 01:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOpp4B27fuj4YXCMKWUeKgCA4oaN/cYLR6MsH6VYbiPGjIxkAnQaHUoHVEreB5tQNcSu5RPQ==
X-Received: by 2002:a05:600c:1d07:b0:440:6852:5b31 with SMTP id
 5b1f17b1804b1-442d6d37079mr113525075e9.10.1747039147266; 
 Mon, 12 May 2025 01:39:07 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bef4sm162258055e9.24.2025.05.12.01.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 01:39:06 -0700 (PDT)
Message-ID: <639736dc-0d07-43d2-b0ca-928b1452313e@redhat.com>
Date: Mon, 12 May 2025 10:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20250506143905.4961-1-philmd@linaro.org>
 <4d3d7964-2ff0-4e62-9949-bc3df4018e31@redhat.com>
 <6597f440-2c26-4051-a6bf-73f46c6a8020@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6597f440-2c26-4051-a6bf-73f46c6a8020@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/05/2025 10.32, Philippe Mathieu-Daudé wrote:
> On 9/5/25 15:30, Thomas Huth wrote:
>> On 06/05/2025 16.38, Philippe Mathieu-Daudé wrote:
>>> (series reviewed)
>>>
>>> Since v2:
>>> - Removed qtest in test-x86-cpuid-compat.c
>>>
>>> Since v1:
>>> - Fixed issues noticed by Thomas
>>>
>>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>>> as deprecated two releases ago, and are older than 6 years,
>>> so according to our support policy we can remove them.
>>>
>>> This series only includes the 2.4 and 2.5 machines removal,
>>> as it is a big enough number of LoC removed. Rest will
>>> follow. Highlight is the legacy fw_cfg API removal :)
>>
>>   Hi Philippe,
>>
>> I just gave this series a try, but it fails in at least two spots.
>>
>> First, you missed this:
>>
>> diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
>> --- a/hw/block/fdc-isa.c
>> +++ b/hw/block/fdc-isa.c
>> @@ -112,7 +112,6 @@ static void isabus_fdc_realize(DeviceState *dev, Error 
>> **errp)
>>       }
>>
>>       qdev_set_legacy_instance_id(dev, isa->iobase, 2);
>> -    qdev_prop_set_enum(dev, "fallback", FLOPPY_DRIVE_TYPE_288);
> 
> This should be:
> 
>   +      fdctrl->fallback = FLOPPY_DRIVE_TYPE_288;
> 
>>
>>       fdctrl_realize_common(dev, fdctrl, &err);
>>       if (err != NULL) {
>>
>> Second, bios-tables-test now complains about a mismatch in the ACPI tables 
>> somewhere...
> 
> I can not reproduce that (tested on macOS and Linux).

Maybe it was just a side-effect of my removal of the qdev_prop_set_enum(dev, 
"fallback", ...) line from the code ... if "make check" now works fine, then 
never mind!

  Thomas


