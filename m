Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBBBE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 22:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsq7G-0001hT-SH; Wed, 18 Feb 2026 17:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsq7E-0001gJ-GE
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:33:53 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsq7C-00012s-O8
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 17:33:52 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70942441ebso174426a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771454029; x=1772058829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sb+8RFm/1UbkPakTLvQ2Y8ca65Z3HvZhiKz/kGmxpbg=;
 b=PPrh8ymDUsj6fwzyn9F0VfZQd0FZgOPvUSW/HShGUad5qoAYy+uegxQHw77XedXX9q
 5erRosEQe5Owi/XC3B9tFTE0QUOXQjsOQuwymUjYbhQzZjJZa91fT9m0XBkRty2pn5mn
 yKiE5iIR1Oq+JY4pvc4fByS2tvk8Y9vUw3NKS/hWVD7T2r38IFPVvceR2QMkezj6BLzv
 NvLJRCxOVzvk14lCiS7lOUVMy4E6iyTMbJwWHp7ozf58I4pBs11atHBNSEiG012vOmDE
 3jMaYwcn0pIaL88PCdmkVeFmmSwkFIWTm5gWVOhB5vuO6woS1dX0CqZAvMI223D5JoBF
 bdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771454029; x=1772058829;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sb+8RFm/1UbkPakTLvQ2Y8ca65Z3HvZhiKz/kGmxpbg=;
 b=SlxZRrluG2NxrUgm+5DEBPQV4WHiOSk7W5UN4m/MvjyocKnzEUatQ6s3LG7RZcynmO
 U8D95BC8zkwu1/w8JPga5fPeQdiz9XfN37JLq1PdgPtiu/YBDblyA86lWq+5ap1hig6z
 Q5kNU9bxKbPYxjbpFA/ReNfU5M1omH2CQFBFm/hqw+hz/Z+nPEtcHgPWk2Yhz4tGblAK
 Uc+1sEE1OJlBmv+ELfx4kpB1n8CjdckQryWy21fcN3kJAanWCSBTOKnYMgjgJu10EAJh
 +WlCYkqKnNrlWO2rLiFKyG0EQ6NjvT97JveEvWPTz2OjQG1ElL8AGcSfl+38tsvO6JhI
 xF4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeC6PlcRkxtja7fhqYXDjzMciJ9d0TTifvfmkssoEYTHf8kVmdkXWMPgtM7PAwUqE6WRXe1xSjUp8o@nongnu.org
X-Gm-Message-State: AOJu0YznQ8TgVkY8btiCEtn5vqmX+rASvGgN0nIhLuoDkbtcp2Foxpcq
 9E3vvWr0x3hzsYrDK3YUt2EAwEDvZJHvokqwNgENgkABX2jScreyYrAJs8gyMRiyGv4=
X-Gm-Gg: AZuq6aJPYZzcMrjyxDAcjpHzX+GWDiRuBm74g0SqqF27j7agiawN1eAFBMhYW3hyqul
 7Rhir5JKOaOM1S0zKJyJOiMN3P9FpQBxyHGlWK8Ms1FKy0nodJSHAMIm7V8Yutyox2Sb6q3U5N7
 ZrbQ0Wqf0XspGskh+68cbOl983hHNpNa1Z98oHWhp6TwgyawqndfhPldExDf04Zo+tT0K7m2dxU
 qh44GPhMCOIx5UiNBi7Qqr9LsaL0wXXFva0xGs2yqKWwWs06zgdRvJJvT4kImxZ7rnWq/tq0FjG
 WFDdgb2k5Vh2EhgCc+kJZ/vTV2r2kX5ZKZtJaVl0wSN6uiDXq0d9ymlyNs4SKTeUKqVwz1VGlYK
 5NriHiqntqO7KxJ2Yk6fckRcN5q71BMRZMMSHdMOIWUAW0/8VT8ouvE18hoCPz6u4RQw0DL3vFh
 jyUhuYnziVl1OJMF30kZDL1q4noajvlziTINRmiZ7peTjGkYtco5X4jfvQwhnzGN50Wmcz
X-Received: by 2002:a17:90a:c2cb:b0:352:fa96:5137 with SMTP id
 98e67ed59e1d1-35844f9b711mr13127634a91.21.1771454029081; 
 Wed, 18 Feb 2026 14:33:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3567e9da8a2sm22958851a91.5.2026.02.18.14.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 14:33:48 -0800 (PST)
Message-ID: <93c5afa3-baf8-4548-881d-d25a46e14daa@linaro.org>
Date: Wed, 18 Feb 2026 14:33:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/virtio: add virtio_vdev_is_{modern, legacy}
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <20260212234602.338131-2-pierrick.bouvier@linaro.org>
 <02b667c5-da6a-4829-87f1-4b9ebc53d5a4@linaro.org>
 <332a3290-9ebe-404f-8b49-d09a83bd47cb@linaro.org>
 <df5cca4c-4ea5-4284-8504-61854573435b@linaro.org>
 <2fd7fa8d-ab3e-2051-7aae-ef676ff1eb35@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <2fd7fa8d-ab3e-2051-7aae-ef676ff1eb35@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/18/26 2:28 PM, BALATON Zoltan wrote:
> On Wed, 18 Feb 2026, Pierrick Bouvier wrote:
>> On 2/18/26 2:17 PM, Pierrick Bouvier wrote:
>>> On 2/18/26 1:00 PM, Philippe Mathieu-Daudé wrote:
>>>> On 13/2/26 00:46, Pierrick Bouvier wrote:
>>>>> This simplifies code compared to having
>>>>> virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
>>>>> !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>>      include/hw/virtio/virtio-access.h |  3 +--
>>>>>      include/hw/virtio/virtio.h        | 12 +++++++++++-
>>>>>      hw/net/virtio-net.c               |  2 +-
>>>>>      hw/virtio/vhost.c                 |  2 +-
>>>>>      hw/virtio/virtio-pci.c            |  2 +-
>>>>>      hw/virtio/virtio.c                | 16 ++++++++--------
>>>>>      6 files changed, 23 insertions(+), 14 deletions(-)
>>>>
>>>>
>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>>> index 27cd98d2fe1..8f1e4323599 100644
>>>>> --- a/include/hw/virtio/virtio.h
>>>>> +++ b/include/hw/virtio/virtio.h
>>>>> @@ -468,9 +468,19 @@ static inline bool
>>>>> virtio_host_has_feature(VirtIODevice *vdev,
>>>>>          return virtio_has_feature(vdev->host_features, fbit);
>>>>>      }
>>>>>      +static inline bool virtio_vdev_is_modern(const VirtIODevice *vdev)
>>>>> +{
>>>>> +    return virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
>>>>> +}
>>>>> +
>>>>> +static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
>>>>> +{
>>>>> +    return !virtio_vdev_is_modern(vdev);
>>>>> +}
>>>>
>>>> With retrospective, mentioning 'modern' was a mistake IMHO. But I
>>>> understand it was simpler to add 'modern' code without updating the
>>>> 'legacy' code base. Today I'd rather have 'legacy' explicit in function
>>>> names, everything else being the normal / current / modern version,
>>>> without having to clarify it.
>>>>
>>>
>>> Agree.
>>>
>>>> Thus back to this series I'd rather not introduce virtio_vdev_is_modern
>>>> and use !virtio_vdev_is_legacy instead.
>>>
>>> Sounds good. I feel it's still easier and clearer to read than
>>> "!has_feature(1.0)". But as said in my previous answer to Zoltan, I
>>> don't mind this patch too much, only 3rd one really matter.
>>
>> s/!has_feature(1.0)/has_feature(1.0), thus showing I've been confused once
>> more :).
> 
> The has_feature(1.0) is more specific though. What if 1.0 becomes legacy
> too? Then modern and legacy is more confusing than testing for a specific
> feature. I still think not touching this would be the easiest as the
> introduced legacy/modern does not seem to make it much clearer.
>

As you can find in official Virtio spec, "legacy" is not a random name 
or something I personally chose, it's the official term for pre 1.0 
devices/interfaces.

https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-60001

```
1.3.1 Legacy Interface: Terminology

Legacy Interface
is an interface specified by an earlier draft of this specification 
(before 1.0)

Legacy Device
is a device implemented before this specification was released, and 
implementing a legacy interface on the host side
```

So even if VirtIO 2.0 comes out one day, they will have to define or 
change term accordingly.

Your comments are welcome also on patch 3 by the way.

> Regards,
> BALATON Zoltan


