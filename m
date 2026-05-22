Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E81CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 07:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQK8l-0006Lz-C6; Fri, 22 May 2026 03:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1wQK8k-0006Lq-8j
 for qemu-devel@nongnu.org; Fri, 22 May 2026 03:17:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1wQK8h-0003gE-Ra
 for qemu-devel@nongnu.org; Fri, 22 May 2026 03:17:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so44802555e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1779434264; x=1780039064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yvuCG/7cco7JayFeYJQNnATuNQs5hWie+grnF0aHfDU=;
 b=iFKU7O6ueIMQ1sjn8q9Byhko8H+oL5TBdzmuNjdoq1GDcddu6SVC+awzR3yfcHFqoo
 DPv0uvqj5W2xIQIbE2pYvUlKTKhQBlDDTrmBU/QcvF+0MJkoIA6BCK8qJ7ZXmTTstt+8
 Gk5qLIA4HKX32G7NpngFGfJhKDkg3lMM1lHTMg3/EGmsleWikBTwefnJ5A4hDfkOae0p
 hLGhFtm1biBIYRWG8m7PYXL7WuETsg9Hpqo9Va1bVlvb+GMCGZRFoBuQjRyblb9LuCsE
 Ql5p1rT8igA5za9R0ZZkc4xlXRkqONU3LlG/+9cxx9PBzxaCqdcrnAUUWMUoWPtApdWU
 0XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779434264; x=1780039064;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvuCG/7cco7JayFeYJQNnATuNQs5hWie+grnF0aHfDU=;
 b=mNkCoQ3A2JqJVUwcWzpI3VF/12vdLh1Iga5WYPjzLJrHZfUXCb8VyhaYp/f1bbNyId
 vusM5mZbUsUyYqUlmocHxh4D9rDYdv17Fa0hKYQfkOY/LvuZPipfXjbtkCKZaVYIQAbF
 ujYVaQB3ymot6uPI6/vPtDHr5tZZ69zNh8K6qeJ4whz+kK7IPqK3Z/cRg7emevz/AY2N
 6A69uCLG6pKFC4PKbWq8lGIlMalWVlwMD7ysW4nfNXhFhI+eTJu67fhUHDKBmLWLfsEb
 IZC+2n8iEL6uwavzfwsuaVD2ibOv60HAxJnrkdgaxZ4Ay85g38/fn+SsziIDWba2jwIo
 +r0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8i8icxxapGFXJuMIZlpicc+5w1x7CufEVL0b7evZcunVuuu7irCaKkrr5e7260moBWHdpnS1wsM0qQ@nongnu.org
X-Gm-Message-State: AOJu0YwgDVXK4JOplOaHm2J8mLs4pkQO8Ost57GlBMIct13MZg4xyu3b
 4rC9/Iprtpbvl3AhaiayFs4VF0RROvp2LScd7ww0V5Wwyd0DsO0kGWzi4YZZoGszsV4=
X-Gm-Gg: Acq92OE2XEYUmmfqBxlg/As2woSZfeZluc9FP+3zLdDU5AVtqYac/Kz9hrRivxnjTjA
 wycd/yPK1/4xdIF3XoKLce102qRZzwjbtkXm+iLjjrRUHjhxIYyRdTbXIOk/NrDUVMPzS2lrQsf
 rvP28Tv0jfwZU+JDO8movratctY/M/J3NM80MhqC5vVTX65TxrKRQHRa/Ff7ZpicrLkqVgt+Imb
 e8lqBDRYaEfclOBz+G+TDYWuokcZIb96W0ctwwwthxIn95iZiyg7HD5oYmMZC3IT8FEATmLr7z/
 dzw/8aawtbVoGErh+IxU3T9JaVbkanscYv31gzIwiagEiKvo8py0qWS8XS5S44M7WvSwvtlMbhV
 Js6T1I94nzsJzaoi429P8lfcVbAjhdnjuV8ECMNbKVm1faWV8QZOurULRggsQf7Gxy0Yfsr/lYB
 6/iE1V5pV+S3E0tllq6rz74FbGB8tADbOjUL0hLTRcS4r8LJDgp0dRK307s3sMqCJs0/ssS+9CM
 7lBCPkCAjkxr+/HXk1O/s5QWb+bwr7ijaU0ySB0zaHaCWfmdU5+GLaGBqoviCmWzZE=
X-Received: by 2002:a05:600c:46cb:b0:48e:6db3:ff33 with SMTP id
 5b1f17b1804b1-490426add7dmr27403655e9.14.1779434264009; 
 Fri, 22 May 2026 00:17:44 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc?
 (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de.
 [2003:fa:af26:200:51a:ef03:a698:a1fc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a198sm22242525e9.10.2026.05.22.00.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 00:17:43 -0700 (PDT)
Message-ID: <372572eb-6b38-48c2-b83f-4da6622a8cc1@grsecurity.net>
Date: Fri, 22 May 2026 09:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
From: Mathias Krause <minipli@grsecurity.net>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260327175210.369113-1-pbonzini@redhat.com>
 <fd49804a-c223-435f-a88b-c2183b391459@grsecurity.net>
Content-Language: en-US, de-DE
Autocrypt: addr=minipli@grsecurity.net; keydata=
 xsDNBF4u6F8BDAC1kCIyATzlCiDBMrbHoxLywJSUJT9pTbH9MIQIUW8K1m2Ney7a0MTKWQXp
 64/YTQNzekOmta1eZFQ3jqv+iSzfPR/xrDrOKSPrw710nVLC8WL993DrCfG9tm4z3faBPHjp
 zfXBIOuVxObXqhFGvH12vUAAgbPvCp9wwynS1QD6RNUNjnnAxh3SNMxLJbMofyyq5bWK/FVX
 897HLrg9bs12d9b48DkzAQYxcRUNfL9VZlKq1fRbMY9jAhXTV6lcgKxGEJAVqXqOxN8DgZdU
 aj7sMH8GKf3zqYLDvndTDgqqmQe/RF/hAYO+pg7yY1UXpXRlVWcWP7swp8OnfwcJ+PiuNc7E
 gyK2QEY3z5luqFfyQ7308bsawvQcFjiwg+0aPgWawJ422WG8bILV5ylC8y6xqYUeSKv/KTM1
 4zq2vq3Wow63Cd/qyWo6S4IVaEdfdGKVkUFn6FihJD/GxnDJkYJThwBYJpFAqJLj7FtDEiFz
 LXAkv0VBedKwHeBaOAVH6QEAEQEAAc0nTWF0aGlhcyBLcmF1c2UgPG1pbmlwbGlAZ3JzZWN1
 cml0eS5uZXQ+wsERBBMBCgA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEd7J359B9
 wKgGsB94J4hPxYYBGYYFAmBbH/cCGQEACgkQJ4hPxYYBGYaX/gv/WYhaehD88XjpEO+yC6x7
 bNWQbk7ea+m82fU2x/x6A9L4DN/BXIxqlONzk3ehvW3wt1hcHeF43q1M/z6IthtxSRi059RO
 SarzX3xfXC1pc5YMgCozgE0VRkxH4KXcijLyFFjanXe0HzlnmpIJB6zTT2jgI70q0FvbRpgc
 rs3VKSFb+yud17KSSN/ir1W2LZPK6er6actK03L92A+jaw+F8fJ9kJZfhWDbXNtEE0+94bMa
 cdDWTaZfy6XJviO3ymVe3vBnSDakVE0HwLyIKvfAEok+YzuSYm1Nbd2T0UxgSUZHYlrUUH0y
 tVxjEFyA+iJRSdm0rbAvzpwau5FOgxRQDa9GXH6ie6/ke2EuZc3STNS6EBciJm1qJ7xb2DTf
 SNyOiWdvop+eQZoznJJte931pxkRaGwV+JXDM10jGTfyV7KT9751xdn6b6QjQANTgNnGP3qs
 TO5oU3KukRHgDcivzp6CWb0X/WtKy0Y/54bTJvI0e5KsAz/0iwH19IB0vpYLzsDNBF4u6F8B
 DADwcu4TPgD5aRHLuyGtNUdhP9fqhXxUBA7MMeQIY1kLYshkleBpuOpgTO/ikkQiFdg13yIv
 q69q/feicsjaveIEe7hUI9lbWcB9HKgVXW3SCLXBMjhCGCNLsWQsw26gRxDy62UXRCTCT3iR
 qHP82dxPdNwXuOFG7IzoGBMm3vZbBeKn0pYYWz2MbTeyRHn+ZubNHqM0cv5gh0FWsQxrg1ss
 pnhcd+qgoynfuWAhrPD2YtNB7s1Vyfk3OzmL7DkSDI4+SzS56cnl9Q4mmnsVh9eyae74pv5w
 kJXy3grazD1lLp+Fq60Iilc09FtWKOg/2JlGD6ZreSnECLrawMPTnHQZEIBHx/VLsoyCFMmO
 5P6gU0a9sQWG3F2MLwjnQ5yDPS4IRvLB0aCu+zRfx6mz1zYbcVToVxQqWsz2HTqlP2ZE5cdy
 BGrQZUkKkNH7oQYXAQyZh42WJo6UFesaRAPc3KCOCFAsDXz19cc9l6uvHnSo/OAazf/RKtTE
 0xGB6mQN34UAEQEAAcLA9gQYAQoAIAIbDBYhBHeyd+fQfcCoBrAfeCeIT8WGARmGBQJeORkW
 AAoJECeIT8WGARmGXtgL/jM4NXaPxaIptPG6XnVWxhAocjk4GyoUx14nhqxHmFi84DmHUpMz
 8P0AEACQ8eJb3MwfkGIiauoBLGMX2NroXcBQTi8gwT/4u4Gsmtv6P27Isn0hrY7hu7AfgvnK
 owfBV796EQo4i26ZgfSPng6w7hzCR+6V2ypdzdW8xXZlvA1D+gLHr1VGFA/ZCXvVcN1lQvIo
 S9yXo17bgy+/Xxi2YZGXf9AZ9C+g/EvPgmKrUPuKi7ATNqloBaN7S2UBJH6nhv618bsPgPqR
 SV11brVF8s5yMiG67WsogYl/gC2XCj5qDVjQhs1uGgSc9LLVdiKHaTMuft5gSR9hS5sMb/cL
 zz3lozuC5nsm1nIbY62mR25Kikx7N6uL7TAZQWazURzVRe1xq2MqcF+18JTDdjzn53PEbg7L
 VeNDGqQ5lJk+rATW2VAy8zasP2/aqCPmSjlCogC6vgCot9mj+lmMkRUxspxCHDEms13K41tH
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <fd49804a-c223-435f-a88b-c2183b391459@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 22.04.26 10:52, Mathias Krause wrote:
> On 27.03.26 18:52, Paolo Bonzini wrote:
>> Queued, thanks.
> 
> Ping! Is that queue visible somewhere on the Interwebs?

Alex, can you please pick up this patch and route it via the gdbstub
tree? Paolo said, he queued it but it never appeared in QEMU upstream
nor in his tree at https://gitlab.com/bonzini/qemu.git. He doesn't
respond to requests either.

> 
> Should the patch be backported to 11.x to avoid the confusion related to
> CR4.CET I had?

That would still be relevant, imho. Dunno how to handle that.

Thanks,
Mathias

