Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4CBC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaI1-0002lH-Ex; Thu, 13 Feb 2025 09:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiaHp-0002ej-5I
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:33:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiaHn-00082H-0l
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739457230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=09LtHCy73cQW8++wX4PQphkMIVvm64+g9fGBTyLPkDE=;
 b=JWVdZJ5JbmK9tqwUW1IKf5wyn5QxGgAYReiB/TxkEwYDiLGjeOKsFSprkiFC2HxGDSrR0Y
 tMxWnBx/XV9N+ycpudLr+goZowcp4/Nwl8H1bzuE9FNJBO10QufpnL97gYmBokCJHxIkGz
 DGlobMLIR5QJ/w5cLcaB8Jc3+1bT9+s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-hNXFxS7nMKe-HQkUNOTjEA-1; Thu, 13 Feb 2025 09:33:47 -0500
X-MC-Unique: hNXFxS7nMKe-HQkUNOTjEA-1
X-Mimecast-MFC-AGG-ID: hNXFxS7nMKe-HQkUNOTjEA_1739457226
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dc6aad9f8so1035672f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457226; x=1740062026;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09LtHCy73cQW8++wX4PQphkMIVvm64+g9fGBTyLPkDE=;
 b=iha++wa47/VNQyDRAuIYXHligGB8tXZV9KsR5LUYe1CssH5605AmowE8pHOe7a5Vot
 zxTdIr4DianD8JJ2LUD7Rz9mxg2+5Yx0ypGZGnb291yz2eDDFFuOQNIDkUMJL5sYwhD9
 h5Pge36duh7gyAZ1NZF5BSODxg9KKHvKHmqsv/7a0XQjPZ4TXnx+L2fko0Us8j+ZSRBC
 88GsgDOLnvoWoSUS4ALIwOgV8cBMYN02WQboExreoCoJ0+otHSsWa5Lhb99Fg6ZmohPN
 I39oNW89+JKULXryg3FVW16sdUflSvyrCh36rfJUEmj8+sA7WVAO0HgQCxWzq8OvaiTV
 mWdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULzJQkb6Vr7yw6ttyy8L0Kqoi/yAipkxybJsa0qqK4L7/M2aFVbuZKYrtwA4x3BiR39PZmEQFANQjh@nongnu.org
X-Gm-Message-State: AOJu0Yw79qfPxtDcZK72XJIxGuICOpRyCw/nakShiZckfInsu/z+iBS5
 3u1R1wcnTTk/yHUZ2+xrIxeNJIfU37Pxfumh7MROkjfcof+Dq1A7rhwAJkpKwhaDQzT2vPJRd9v
 r7jO2zQEI6FJz2BxoFamvI7rWHywGohXRFrDtmfVVmsYp5dHjCjPW
X-Gm-Gg: ASbGncs9E6Ipa/H86GG7kexIi91+H9g7B6Og0bLl7L4xobY3bujfC8+rMdCh/0MG5eL
 1EHR+k7lypxRglUhdV3RbcDiftvvdRciKZa3xXpL3X1qsMZX1N/vkjus3rmhLUTmkRtg6KSCIfo
 EbHOGKt0YfCK0AcuJvC+B0KA/I9HfocsKCn7Bcz+beYoWv+nkS+E3b2AN+8s1lhEp2Rx3fBAg1h
 6lt6b8aWouWbTws+qnqzzho+kAKxPY0zzH9xpmuU72EZcgujgc1nhfQdNRR5PP3hy06ptZKDfnK
 dnmNJX4GsP4ix4ZJOepdkHR0nQWDb05PJA==
X-Received: by 2002:a5d:64a2:0:b0:38d:b12f:60d1 with SMTP id
 ffacd0b85a97d-38f24f9bac8mr3772803f8f.26.1739457226265; 
 Thu, 13 Feb 2025 06:33:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+NAAJ6chBOjsP8woOR/3J1fEMxeOuacwWlV1I9+2ucD8oftZ4hnRU0M7lkFiroVhCe2r88A==
X-Received: by 2002:a5d:64a2:0:b0:38d:b12f:60d1 with SMTP id
 ffacd0b85a97d-38f24f9bac8mr3772758f8f.26.1739457225808; 
 Thu, 13 Feb 2025 06:33:45 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4158sm2048386f8f.3.2025.02.13.06.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:33:45 -0800 (PST)
Message-ID: <babd30e7-0434-436a-852b-7ff1599d3944@redhat.com>
Date: Thu, 13 Feb 2025 15:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
 <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
 <6e707c7f-b94c-47ef-83ab-795605e27963@linaro.org>
 <a3608e43-79ce-403d-8ba7-6735fde66759@linaro.org>
 <e1436061-a840-0942-2c2c-4f49bfb932b8@eik.bme.hu>
 <672045c1-9b09-4b7b-9bed-fa990129ce2c@linaro.org>
 <fb7045a4-20f6-a52d-5531-2410fc803bb4@eik.bme.hu>
 <0f7ea6d6-8476-4ba6-9d4f-eeb76aed04fa@redhat.com>
 <9e121e62-8e6e-61d6-dbfb-4dfda469acc5@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9e121e62-8e6e-61d6-dbfb-4dfda469acc5@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 13/02/2025 14.59, BALATON Zoltan wrote:
> On Thu, 13 Feb 2025, Thomas Huth wrote:
>> On 12/02/2025 23.34, BALATON Zoltan wrote:
[...]
>>> So then can the behaviour of NATIVE_ENDIAN be changed to look at the 
>>> machine endianness instead of replacing it with a constant?
>>
>> No, that does not work. First, the machine knows about its devices, but a 
>> device should not know about the wiring of the global machine (just like 
>> in real life).
> 
> That means all devices should be either big or little endian and there 
> should be no native endian ones. Why do we have those then?

Some device can indeed be either big or little endian - think of devices 
that are synthesized in an FPGA for example. But in most cases, it rather 
depends on the bus wiring. Anyway, we need a config knob to allow either the 
one or the other endianness for certain devices.

> That's why this 
> endianness property should either be removed from ops and only attached to 
> it when added to a machine if needed or kept to show which machines it can 
> be attached to: only big, little or both endian which is what it seems to be 
> doing now.

Again, devices should not know about machines, not the other way round. So 
the device should offer a config switch (property) and the machine should 
set it to the value that it needs.

>> Second, imagine a board with e.g. a big endian main CPU and a little 
>> endian service processor - how should a device know the right endianness 
>> here?
> 
> How would that work with this series? So the proposed solution is to double 
> the devices now marked as NATIVE_ENDIAN to have a big and a little endian 
> variant for them so the board can choose?

This is not doubling the devices. It just introduces a config property to 
let the machine switch the endianness.

> That does not exist in real as you 
> wrote, there's only one device so then this is probably not the right way to 
> model it.

Some devices can exist in both, big and little endian variants. We could of 
course create two devices for this, but that's nonsense if it can simply be 
handled by a property instead.

>>> Or would that be too much overhead? If always looking up the endianness 
>>> is not wanted could the ops declaration keep NATIVE_ENDIAN 
>>
>> IMHO we should get rid of NATIVE_ENDIAN completely since there is no 
>> "native" endian in multi-CPU boards.
> 
> If we say NATIVE_ENDIAN means that the device can be attached to either big 
> or little endian machine then we can keep this constant but when adding the 
> ops to a memory region the board has to then decide which endianness it is 
> and replace it with either big or little. Then we don't need two versions of 
> the same device and NATIVE_ENDIAN means that the device can be used in both 
> machines.

Well, it's currently the devices that are calling memory_region_init_io().
And since memory_region_init_io() does not copy the MemoryRegionOps struct,
we need two implementations right now for this, one for big and one for 
little endian. So I think Philippe's series here is fine. But feel free to 
suggest clean up patches on top if you think that the 
memory_region_init_io() needs to be handled differently in QEMU everywhere.

  Thomas


