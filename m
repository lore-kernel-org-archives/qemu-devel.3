Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3DE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlIx-0004hD-Ve; Fri, 03 Jan 2025 12:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTlIv-0004bI-Vy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTlIu-0007oK-Hx
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735924661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p/vX+qGoUOh2uOBNF2DfEKZJnNN2RAYLIZ6HoAVXycg=;
 b=Ztt16PJZmNuWW0sy+QBAKBMs4zQoBSM4Oe2B86ev8By2ZUKdr3Nl063rdFNnFGl1mVqYVP
 vrqBqEqr0M973q3ZXwfZTGDjca+OtUOq1bQc7PjFuXSICL2pC0cLNMH/AKdhrjj9v9YPzS
 EtGlvi+MaQzHSTu7VvI7+SMGhrISXHc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-ob3yVQwuMIaAxgw43MwL6w-1; Fri, 03 Jan 2025 12:17:39 -0500
X-MC-Unique: ob3yVQwuMIaAxgw43MwL6w-1
X-Mimecast-MFC-AGG-ID: ob3yVQwuMIaAxgw43MwL6w
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43651b1ba8aso86421275e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924659; x=1736529459;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p/vX+qGoUOh2uOBNF2DfEKZJnNN2RAYLIZ6HoAVXycg=;
 b=oBtE2na3nDkd0lYaZ8lX1/+GHFjhuSTD2/DGgKjyTzUqq/0LyjgaT1uqfTFWj1cRQx
 FPVDD56DHYqOKTdfmIl/C6CKhB0241C7sQtI5f9q+gdrUvyIBWPKkbSN2A4Ffp4qCdyu
 B7yhhAuNQOYMh3/g94kghlDULYrOsgBtkRFw+1ub9eFXhSaDdPc/BboDluEnAXA/uad/
 uktX8aMf8LI/UOi+MyNvHLVyyMcwUMVPOGkeIkmZnlvvvpjHGudU9kUbIN0xX4Uq/lcZ
 2JZNsVlckiNWdj8iGkh568pCuEcQrqcVlfOMjzP6vjHumdW1NQtXjkjKET2JzEce4ihP
 QqCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLNytCDWvkGj86aKkr+4NS3v+dChWdwduHz/yipnwTSItHtTZZUsvAow8TSVQYMsUKl1vms9OQvx69@nongnu.org
X-Gm-Message-State: AOJu0YwRqHvZkN/W0LXxG3vjkvdhuWP/RQ555WRhIGmmYHfXDGx1dOjp
 xzd9a57yfUG3wqADs+QUEHUsQF/Ps5XeHxPAVV3NN4PToWpXG0Nxd39Y4EzO0jVcw6z5zaiON/5
 HMC54yGno30ezRQr3476IPvM1NCHZAbXnoESi9YcnuUbe98wmEvpk
X-Gm-Gg: ASbGnctyknz9qNR7MqypfJ8/v0szPDAycOufnfCUMDuT6WPnpkc0xXrtbnp3mjE5pj2
 nmVpmJSZJzRm9ipHi4N2R5YFi1X4uxccgpFBtR+j5QKt5hzJY32jjT7jGYkHCUhu9+PEvskeTv2
 sWsy9CieAj2wgXB8T1ydhjXM1cAVARyr0Le2uKnqdX3arXW1gYy1J9bqXpa9GTZVtBj5m37qiFp
 sk7h4WYXaWXbNb81h3bbvP+4WoegLOp8FAypUnc73pjV97pi30Qy+u4OBuV6Ai8ehN+dF47+x8/
 qyD5y2K8vWdZ
X-Received: by 2002:a7b:cb14:0:b0:436:90d4:5f3e with SMTP id
 5b1f17b1804b1-43690d46037mr254978015e9.6.1735924658714; 
 Fri, 03 Jan 2025 09:17:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTnUV11YTFi+k0rQBK3BVe6Xu4qZ51YJR1s5TcBVPyArlXN86moGwI+3GiTZq/ilm9IR+Gjw==
X-Received: by 2002:a7b:cb14:0:b0:436:90d4:5f3e with SMTP id
 5b1f17b1804b1-43690d46037mr254977815e9.6.1735924658329; 
 Fri, 03 Jan 2025 09:17:38 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a3c9sm490473615e9.40.2025.01.03.09.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 09:17:37 -0800 (PST)
Message-ID: <d4d352bf-35f9-413b-a495-8eb8db7da3f2@redhat.com>
Date: Fri, 3 Jan 2025 18:17:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/s390x: Declare loadparm as char[LOADPARM_LEN]
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>
References: <20241120085300.49866-1-philmd@linaro.org>
 <20241120085300.49866-2-philmd@linaro.org>
 <d005f227-cf46-4a62-a152-668030ad7e49@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d005f227-cf46-4a62-a152-668030ad7e49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/12/2024 18.02, Philippe Mathieu-Daudé wrote:
> ping for this single cleanup patch?
> 
> On 20/11/24 09:52, Philippe Mathieu-Daudé wrote:
>> "hw/s390x/ipl/qipl.h" defines loadparm[] length as LOADPARM_LEN,
>> use that instead of the magic '8' value. Use a char type for
>> char buffer.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/s390x/ccw-device.h               | 5 +++--
>>   hw/s390x/ipl.h                      | 2 +-
>>   include/hw/qdev-properties-system.h | 2 +-
>>   include/hw/s390x/s390-virtio-ccw.h  | 3 ++-
>>   hw/core/qdev-properties-system.c    | 8 +++++---
>>   hw/s390x/ipl.c                      | 6 +++---
>>   hw/scsi/scsi-disk.c                 | 2 +-
>>   7 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
>> index 4439feb140..94a9b35714 100644
>> --- a/hw/s390x/ccw-device.h
>> +++ b/hw/s390x/ccw-device.h
>> @@ -15,6 +15,7 @@
>>   #include "hw/qdev-core.h"
>>   #include "hw/s390x/css.h"
>>   #include "hw/s390x/css-bridge.h"
>> +#include "hw/s390x/ipl/qipl.h"
>>   struct CcwDevice {
>>       DeviceState parent_obj;
>> @@ -27,7 +28,7 @@ struct CcwDevice {
>>       /* The actual busid of the virtual subchannel. */
>>       CssDevId subch_id;
>>       /* If set, use this loadparm value when device is boot target */
>> -    uint8_t loadparm[8];
>> +    char loadparm[LOADPARM_LEN];

I'm not sure whether changing the type is such a good idea ... some spots 
that handle loadparm include EBCDIC encoding, and the unsigned type might 
have been used here for a reason? I'd better keep uint8_t unless you've 
double-checked all combinations...

  Thomas


