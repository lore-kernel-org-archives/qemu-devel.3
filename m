Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03AFE7C706
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMGY-0003yk-IX; Mon, 09 Feb 2026 03:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpMGS-0003y7-4G
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:05:00 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpMGP-0000iw-Ro
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:04:59 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82458495219so754947b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 00:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770624296; x=1771229096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tP4RYqfiP6rN0Uc8nWBk10u2u2yh7XFnRI/i0pEIOk=;
 b=vSaGODOE0knOrPLwXm2MAZPWxbv5QugHYTVv40bD90GwhBtJ3w4CwWadp8pD0ecVB1
 sOQyHSp38GjZ4qaUa21ijy1oBaGqNiE3zSu1fjDHfF/Llus36OfUQ+MqBKzxwiRbYOWt
 jLVPg6asJd4kREAcRzGw1pcivupeJNEf51/TPUcogvJ/WwgO7CUj8iOuMQTCsoPferWS
 xPHbCG3X70Ht+L1hNWUJhoGP/sgWI5WGp5go9LGBrvpjlcsB3SNIgrTKstdymSqFPLjD
 fbaW4oCAPrWg0nPGqPrVTACnNsFBW2YkeRRUGCAjF7AeGIkWlLXIKH8bzcIYWypgT0ng
 Qc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770624296; x=1771229096;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tP4RYqfiP6rN0Uc8nWBk10u2u2yh7XFnRI/i0pEIOk=;
 b=S78GWdiJTUhADCKxL6CC9oAC7nuQzYtjwJk4ain+LBYNZKprg1wRLSKE3B1zMCgB9+
 CsJxBYHeXigUJ0b44ia4+ioMRJlkYzkM8cguNLOUb+wST5ELfBmf0rX+R+OBrKz6IpVL
 qVEvpo27HoFci2qiVGwakUAHpqxzBhRmjjnid6nLQSvM88II9gj9M6ddvGUTjePT53Io
 j/Yiu1b0XANJZydWHOkn3M34XQYZ7rXxlGuafr+Ff1wuUuFFJKAw+3X0CrJlsdGJkWGO
 /pCAmQk4QCt31IrGtIrDPER74pQb8bDeqP6PKUfCGuUDPJNNLiATl663bhusQv1hi/Qy
 r3JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2OWv3Ozff9KJRQlqy6edbfknIa6jfIhgCQTxLGmEBV80q9CRr3w47jL9c1ZTEZ/WCgHU2wkSLTVZB@nongnu.org
X-Gm-Message-State: AOJu0Ywnflf+DHbjNibmZ5brMiCAPPY4UJG5pNIuC7NkVahgN6jgNGud
 T3bXYBeffZqVkToxB1nDxdHO+h9CM2xWk4+kou7uL73Ak0tFPTmFxAsZr8BqzhQZY1U=
X-Gm-Gg: AZuq6aLYisjvayha7O4H9V621QKCAUvbZuKPiWgglzxvSmc8fMGU/q2BtbXOu5e1hTH
 D0n1gmoJAYNy4rBe/kFMrkSpoSB5Gf8oAv+hnSWgpy2LZgYgUVFQsWxRtHgq0WpR7U/a0yjUw2c
 C55Xa6Yej6gQabGJo7h4zo0DKvqoncZE/7odnKdLgOtHnhqdvVM5R52R5tIHtB3TjiwYl+EMMfF
 eViZstCP373UoL2GUka+HWhsW/UKtYcvhaI+FoK6XqxYmoM3uQZ3y2btIkLVwXP+EEu+eYUXwDh
 NhfwXza8QbPDVq1H5nwxxpb/EnBto8DIS482N48SqJ76KL58k2Txg6nsKjcPmUiwFIr8yIiFnN2
 agMp1KiYhv2PHk51BsSSX0hEETAbhHgoyKQNkfPRu0IUf5QrVnaf6yYWHwYCrLyOyOeUDG6N17w
 lkyxlL0mS02jI5cO5gMR2hU/iSLjr1eROyvOqNrOOqw0dcjYtXH99YDmiA
X-Received: by 2002:a05:6a00:71c2:b0:823:b1f:892e with SMTP id
 d2e1a72fcca58-824416e1501mr6510369b3a.43.1770624295821; 
 Mon, 09 Feb 2026 00:04:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824416952e4sm9397801b3a.21.2026.02.09.00.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 00:04:55 -0800 (PST)
Message-ID: <701835b4-3bfa-4f8b-b788-f6d1779bf48e@linaro.org>
Date: Mon, 9 Feb 2026 00:04:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] include/hw/virtio/virtio-access.h: simplify
 virtio_access_is_big_endian
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-6-pierrick.bouvier@linaro.org>
 <31906e49-62b2-47a3-9cda-cd90d5e29f4a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <31906e49-62b2-47a3-9cda-cd90d5e29f4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/8/26 9:19 PM, Richard Henderson wrote:
> On 2/7/26 08:19, Pierrick Bouvier wrote:
>> virtio_is_big_endian already checks for VIRTIO_F_VERSION_1 feature, so
>> this is redundant with big_endian_code.
>> Also, clarify why we explicitly check for ppc64 and arm arch.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/hw/virtio/virtio-access.h | 17 ++++++-----------
>>    1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
>> index 1bea3445979..9aed3d1da4f 100644
>> --- a/include/hw/virtio/virtio-access.h
>> +++ b/include/hw/virtio/virtio-access.h
>> @@ -22,21 +22,16 @@
>>    #include "hw/virtio/virtio.h"
>>    #include "hw/virtio/virtio-bus.h"
>>    
>> +static inline bool legacy_virtio_is_biendian(void)
>> +{
>> +    return target_ppc64() || target_base_arm();
>> +}
>> +
>>    static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>>    {
>> -    if (target_ppc64() || target_base_arm()) {
>> +    if (target_big_endian() || legacy_virtio_is_biendian()) {
>>            return virtio_is_big_endian(vdev);
>>        }
> 
> This now calls the hook for all big-endian, not just bi-endian.
> I don't think you need to change anything here...
>

If I'm correct, that's what original code was doing:

#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
     return virtio_is_big_endian(vdev);
#elif TARGET_BIG_ENDIAN
     /* duplicated code for virtio_is_big_endian(vdev) */
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
         return false;
     }
     return true;
#else
     return false;

 From what I understand, legacy virtio devices follow host endianness 
(thus considering all big-endian arch), while virtio >= 1.0 devices are 
always little endian.

What did I miss to consider it should only be called for bi-endian arch?

The bi-endian part was specifically introduced for a regression that was 
found (see c02d7030c3c538312c7f464cb79b72c29a20df74).
But it seems it's quite duplicating what TARGET_BIG_ENDIAN is doing, and 
I'm not sure why both were never unified, thus the current patch and 
proposal. That said, there seems to be a lot of history around this 
specific function, so I would be happy to hear any detail I might have 
missed.

Regards,
Pierrick

