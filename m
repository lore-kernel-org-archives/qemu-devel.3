Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1812A106FD7F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 05:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vPZ-0001D3-Gs; Fri, 13 Mar 2026 01:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0vPX-0001BO-Uv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:50:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0vPW-0007Jb-BC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:50:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a871daa98fso14136465ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 22:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773381009; x=1773985809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UC5ZH5TfbZj7+oqDmTuUWb1sTEyjaSwZHi98KMaHkcc=;
 b=TIvWhl2Do+SZWCQTyUKmPtGu3Hkf/VxHmCCECrqk/fnD1CW1E8LK+qQi+cHoelZz+v
 N5oTz2eg+kjxJbY2gWbJ1TOzJlKVn0YPK7LJlJe3fCGYHddRZv6NVBzAeKipTp4EbUr9
 9e3nuzSroMP1kHbX5jd/38LSyS7Th8Xz7mzyoaSe1A/RzXsk3jVhkkm+u9yUzFrMGogw
 1eeE9TbyQVk5X/8hF3ym9iZMfrc3RmrNiNTUOtrMvtt3VdRGiBLHBximpyh5LFwAENdb
 OEeTvEKAieX8zNBRbLI0WL0BZ1YEYthhWAahqJxYeyuUb1vkNBiE6NdK6XHbHl9W/ZM4
 zfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773381009; x=1773985809;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UC5ZH5TfbZj7+oqDmTuUWb1sTEyjaSwZHi98KMaHkcc=;
 b=m4GjsR1rEqosyJUmLa72UdUk0ECINsz1Wp+g0wh6FERREPf4qyZr6cxsQszEPahbjj
 mleFHRXeu1OjAdfZ4LTmZI2pw7s4rY33/N5OMSO39+qJdbgaiF1fr5RziHYwD42RuLC/
 0mz/N09hcEwrVCGXTl7DJaZ6NsqJAUDOv7fNoRz6qpXJ94aBjLYp4TbwhanVTikvE5JJ
 mUXk+CmGdRMtiHdYDyLootA+ykCbUjxxKXyxCGugELtxYbEoEjHKN7W+avkXD7Ajur6b
 Yzkab7zmMVxeUTvyF9n4A684Z51vd+hBPVmSMN1pZbOZ8/5nS2/luRIFPJ14iwQf2fJI
 PKIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqOSbhYZHUVu346kJ+WE1UCaHYzaVnXezvDCNS1DiSAHeGhOUQoK6vPLAVRpFqmq44AQgZ9Y2SUF0O@nongnu.org
X-Gm-Message-State: AOJu0Yyo+f2vvwhJnZaLttZTU3KbnLU1AKM15f987pkFLM3hN00+Zf0J
 U3rbpLjQL/2465gzlzuLV+ct1lrb+psc1bLe4c/NpQWlDaKaMEzjhtTJ+n/zxUQqXx4=
X-Gm-Gg: ATEYQzxxA+ZVZ0NHYKU5Yem0A/Es7HX2or7BAnKtPKHOnAjKplTGMQcrdo/g2DLTpN9
 x5wufDy0GGRX/f6NvINGjFQDXOyJfAGfcCMYTm23tGL+irDXXNPHIcUaZv5VDXNuWrmwtXPFCoE
 DuAdWUgBG9BVpZM0RKg5dYELXqk1aNZhXegYaWb3k5q6gQFq/2HeKmZxOIWqL8sxcaM71+aShZ/
 pf95nlAEHhcsrM/O/1SvBP76gI8Zztk9VkJHl+4nVhbj/4Ny3B0sjuQiNpn2zpdEuxSJmWjG29B
 LxxRXNQSeZohyQfu3XDL9CoTTf1sqxL4n6MK3DYEjCFbxyg0nm35ZrV342Ikn+mmgkqBGrO4XEg
 RJxwbjqu71LXqO7ViPm/JfxVWwBnhTaFr/Qy7Ski1WklJ88LavC7bfbGx6Lpo9BsBexp4YDKiwG
 j9e1C24a2YaDdioAPymR8s2YN0HadDCXpy/ujKq7ays8bviCAyM3KavWRYE5DqGlO4ydlk8eLsz
 sUJmW4=
X-Received: by 2002:a17:903:94d:b0:2ae:80a3:ca7d with SMTP id
 d9443c01a7336-2aecac4a0d2mr19834555ad.39.1773381008656; 
 Thu, 12 Mar 2026 22:50:08 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece8363b4sm9409085ad.76.2026.03.12.22.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 22:50:08 -0700 (PDT)
Message-ID: <eb9c8369-8e31-489b-9c3a-93a7edf3a77c@linaro.org>
Date: Thu, 12 Mar 2026 22:50:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/vfio/ap.c: use full path for target specific header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-7-pierrick.bouvier@linaro.org>
 <ce1c675e-97a3-456e-8301-ab5b0f087b16@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <ce1c675e-97a3-456e-8301-ab5b0f087b16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/12/26 8:26 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/26 23:44, Pierrick Bouvier wrote:
>> In addition, we fix target/s390x/kvm/kvm_s390x.h cpu-qom include also.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/s390x/kvm/kvm_s390x.h | 2 +-
>>    hw/vfio/ap.c                 | 2 +-
>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
>> index 649dae5948a..7b1cce3e60d 100644
>> --- a/target/s390x/kvm/kvm_s390x.h
>> +++ b/target/s390x/kvm/kvm_s390x.h
>> @@ -10,7 +10,7 @@
>>    #ifndef KVM_S390X_H
>>    #define KVM_S390X_H
>>    
>> -#include "cpu-qom.h"
>> +#include "target/s390x/cpu-qom.h"
> 
> Yeah, I've been tempted to do that globally with a script, then remove
> the various '-Itarget/foo/' from CPPFLAGs, but not a priority.
>

Crossed my mind in the past also. But it's probably easier to do that on 
a per need basis, like here.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


