Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562E0E95A79
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 12:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaYR2-0000qO-Ua; Tue, 30 Dec 2025 07:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaYQq-0000nY-7B
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 07:02:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaYQm-0007cE-8F
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 07:02:29 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so60848135e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 04:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767096146; x=1767700946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYadU69kzXuhrCiLVUkqEZLXLnWSQK7y1btKKm0nM3s=;
 b=Oo+3SKxZop1LVuEhILNNQWTNn+5IXhxlxnsO15+/MmiExVpo9sTBOK+/ANvbVHPqcC
 Ra1SG3ns1/1wfL04MjL7yDVkuBGtp7g3a9s8lY3i5uVFaH2SPxIJAC7txKjXvbNNf8Rt
 eaXF+EJn+sRHvPKoU12k8m3zpt+ipky2kV/vGDUWwItxQBYRSqy+hT1eC2i2aJ6nORTd
 C3ws/rF+rJ5JnvBw1AQNqL1skUmgNtmWW/T0QInM8XOFZNrOVHvdUHMKFigrrTt5jgbN
 0xGLBPKlZoit1Vw6iWxeUX9AtQlrC80ttRwkmRljdMLuOt7hYHs5kpWlPbnHGrKgnJx4
 JcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767096146; x=1767700946;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OYadU69kzXuhrCiLVUkqEZLXLnWSQK7y1btKKm0nM3s=;
 b=h6jVdr0BE75I0iq6SJKsi0CqFFORRuqfwOQ4VNxXg/EvYkFHq4IHilwzeCWqVJvZC+
 pVh7XF4I0MWFQjwdRdpWpiL9OiJMxY1+oaTLOgA0UsFXYI11u/oS4T9BC9ThTbFwFkBC
 ZRhQ54vkC91oGvXdF6eA3CqBFSwPbAYabFTthG9VHBF5xLj2CTkMpysU4x3U+XW1QrPe
 mLGS2YbwUejsN+s54nXU/wi2okElZcYz+xCv9N7CF7+HJqEBipJYxMQWUPjAq6f+jLed
 PuptoOMLcIdxYVZYFHeBpD+w+o4rtEyByc7xVZIOzHtz27KV8pEI1KwtdNlOjLjGOAHv
 nsHw==
X-Gm-Message-State: AOJu0YwA+OuGsJRHLPWWfWOSN0fIazLcn51MJLTgmw36/GbQo+s8hbJt
 xYH/i5eL5WVaI3BEthsquQqEkhtBj993xwrOkoF+VaVVd9w3h0jPDJmV/47wpUPrN9A=
X-Gm-Gg: AY/fxX44aih18vt9DKTf0Okrs3hvR3Zm2uhwW85fVt/m+IVqfTDDeqX+LdOhrBiZWHA
 QIX99SFhjR6V9xgvswTVNg/6Sk+NCaE6r7CKBsax+bGa2BkKLqVncHWecK027ub75y1OyvvBsCA
 c7ooGBS8y2WB6pyN59lbEhubwSxddDEUz1TlTxHCVECSTmHkkwNhsK5xr6p0/cK0h5z98pItkOw
 B9danhdfxzLCNKuggng4kO6m4njehjPoYmaC++7WY6mpEqY9dWKWwS44j2udGqbhYo1GlgcBYpq
 TEhWrtFxmGdCNUPUtAtqd5A7YCWLf/psQeYzN/5ABOslF9Y+hRmkLJ13h7XOMd7AuTEb5tCaQrv
 AQZnnHQQWF5BzxrJOSq8Y4Q5jeBEOSlCJ9hSOzqMdAvm8/eSqII1wshyNyBh5YBzqCHUz1+DiyA
 H35On53hW0Ml1wTujbPbuPgx5XPQIcLH/HWRVFStTIpMIWZzSaSWXmDA==
X-Google-Smtp-Source: AGHT+IF9n+Efuju3g8ISPRq0T5hkhsxE9Ty9bZuxZWmXqal9FkZlbnGOi84H8QBnLDctw99K57dFVQ==
X-Received: by 2002:a05:600c:3f19:b0:479:3a2a:94e7 with SMTP id
 5b1f17b1804b1-47d195495c9mr354478635e9.10.1767096145877; 
 Tue, 30 Dec 2025 04:02:25 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324e9ba877sm68199603f8f.0.2025.12.30.04.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Dec 2025 04:02:25 -0800 (PST)
Message-ID: <b81fec3d-022a-4b40-8b65-fc0904b88dab@linaro.org>
Date: Tue, 30 Dec 2025 13:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] system/memory: Extract 'qemu/memory_ldst_unaligned.h'
 header
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-3-philmd@linaro.org>
 <ffcf5368-9b35-d1c8-16ba-6b517e056469@eik.bme.hu>
 <0102f50b-0778-4a32-9bab-a4786a7b1b92@linaro.org>
In-Reply-To: <0102f50b-0778-4a32-9bab-a4786a7b1b92@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 28/12/25 21:04, Philippe Mathieu-Daudé wrote:
> Hi Zoltan,
> 
> On 28/12/25 17:46, BALATON Zoltan wrote:
>> On Sun, 28 Dec 2025, Philippe Mathieu-Daudé wrote:
>>> Unaligned memcpy API is buried within 'qemu/bswap.h',
>>> supposed to be related to endianness swapping. Extract
>>> to a new header to clarify.
>>>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> include/qemu/bswap.h                 | 62 +------------------------
>>> include/qemu/memory_ldst_unaligned.h | 67 ++++++++++++++++++++++++++++
>>> accel/tcg/translator.c               |  1 +
>>> hw/display/ati_2d.c                  |  1 +
>>> hw/display/sm501.c                   |  2 +-
>>> hw/remote/vfio-user-obj.c            |  1 +
>>> hw/vmapple/virtio-blk.c              |  1 +
>>> net/checksum.c                       |  1 +
>>> ui/vnc-enc-tight.c                   |  1 +
>>> util/bufferiszero.c                  |  2 +-
>>> 10 files changed, 76 insertions(+), 63 deletions(-)
>>> create mode 100644 include/qemu/memory_ldst_unaligned.h
>>>
>>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>>> index b77ea955de5..e8b944988c3 100644
>>> --- a/include/qemu/bswap.h
>>> +++ b/include/qemu/bswap.h
>>> @@ -1,6 +1,7 @@
>>> #ifndef BSWAP_H
>>> #define BSWAP_H
>>>
>>> +#include "qemu/memory_ldst_unaligned.h"
>>
>> If it's included here do users need to also include it separately or 
>> if so should some of those users lose bswap.h include now instead of 
>> including both this header and bswap.h? I think it's simpler to only 
>> include it here and let users get it through bswap.h unless you review 
>> and remove now unnecessary bswap.h includes from places that only need 
>> this hearder but I don't know if that's worth the effort.
> 
> bswap API users have to include <qemu/bswap.h>,
> users of ld/st_unaligned() one have to include <qemu/ 
> memory_ldst_unaligned.h>.

Let me try again.

Users of the ld/st_unaligned() API have to include
<qemu/ldst_unaligned.h>; if they don't use <qemu/bswap.h>
then first it is pointless to include it, but furthermore
it saves few compilation cycles for the unused inlined
bswap functions.

Users of the bswap() API have to include <qemu/bswap.h>
(which indirectly includes <qemu/ldst_unaligned.h>, but
this is irrelevant).

Users of both the bswap() and ld/st_unaligned() APIs have
to include both <qemu/bswap.h> AND <qemu/ldst_unaligned.h>,
even if it is indirectly included. That makes the use of
APIs more explicit in the source file, and furthermore it
avoids code churn when indirect headers are reworked.

For recent examples see commits 34bcd8f4ff9 ("hw/int/loongarch:
Include missing 'system/memory.h' header") or fdda97b47e6
("hw/arm/virt-acpi-build: Include missing 'cpu.h' header").

Is it clearer?

Regards,

Phil.

