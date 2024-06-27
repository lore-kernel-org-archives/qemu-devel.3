Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA7FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpmR-00024U-GL; Thu, 27 Jun 2024 10:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpmP-00024I-DL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:07:17 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpm8-0003j0-Vw
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:07:17 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c21ba58227so1331943eaf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719497220; x=1720102020;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nuo3oGa7sW4ew3IXvrB1WXnfJy174fcdEXZL3iqFbso=;
 b=aV6umN4A6/0W/e1aJKP/KTUKaZnRibs/bMYnsm/slJVuIVNKNWC/fwojJU/hg2sA8O
 ULWQuzZSzE9T9dhw/x8dhwbvhTEn5+qTD1GLybIn+ITMyybDyIs0ImHhdPEoDXH6u7vK
 K6na6gkzjvDrXQ8aWZH6oOTDrgtcMbGigbuTDAqxKx5Hg3/cx6r+qgJR4+7ljgEGZPTu
 Mpwu2zULwRhMqwrMPeD4k3QHIBI8J/mzsNT55CcbqeVzdYFO1Qp3cU/It/iX1uGYOjzA
 oCUIBy6rwQCSc7lQR0fwsydZC6yttCRYhD24QOrLL3Uajv7TKhoVmSoM0mLJJZXGG+C9
 K+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719497220; x=1720102020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nuo3oGa7sW4ew3IXvrB1WXnfJy174fcdEXZL3iqFbso=;
 b=Nxah7Rm3/sB2bbhEU3AHQuWrU0w68fTNFo0YNKj9uMosXpgILUWipSjKFsFax1Vax7
 4WsRpmy48d2k/uuRKbVKzbdc5CGnLuKPe9kIDri+9zRga/p4jqrKy53OjT34xFVmm2Zr
 G4PJRzTKSqvOYQkq3qoM7dWVQVAi92l3RzoNpb91+P6klV7j/YlIWISzOUmBOb81FvFo
 mhReZJItEW5Spngc7cQpwxhXA/eG0zRAykmcKzn2cU/t1UHkZKIFY+qJ7wK0uYauHYMC
 udv4bH2Zcu78A0fvcgcN4f9FEocVOL1R9Cs/WBcvEs3XYI1BfyyqrQsnxrTaqZRM1WJE
 mZGQ==
X-Gm-Message-State: AOJu0YxyEpmo9UfNAmImcvNbVHtt3eGeUvsHAzcuy4lNmW9K/w1z3kfa
 4mczVyDDbR7WNYdRVQsDEEPNrqGzw52IafvEUIBZ17znmHMQ4ZYRH+sBnjz0DZk=
X-Google-Smtp-Source: AGHT+IGL6WXwMwwBnuhg+DhKcuAXKgHHur/2uAVncPYfMkEpNNJt4zsReHeOhnDUaPjmRRfXJWZ/4g==
X-Received: by 2002:a05:6358:5921:b0:1a6:3b1f:799 with SMTP id
 e5c5f4694b2df-1a63b1f12c0mr368479355d.27.1719497219820; 
 Thu, 27 Jun 2024 07:06:59 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72745d074adsm977559a12.36.2024.06.27.07.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 07:06:59 -0700 (PDT)
Message-ID: <6fb59b79-88d4-44d9-bf57-127d6eada90a@daynix.com>
Date: Thu, 27 Jun 2024 23:06:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] ppc/vof: Fix unaligned FDT property access
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-5-f3cc42302189@daynix.com>
 <efdfa803-775c-4aa2-b7c4-f016dafe9a88@linaro.org>
 <9fdabbde-1ae8-4f78-af20-b4383b7705fc@daynix.com>
 <4b713ad2-1f92-49d1-88b9-6185a1b50062@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4b713ad2-1f92-49d1-88b9-6185a1b50062@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2024/06/27 23:02, Philippe Mathieu-Daudé wrote:
> On 27/6/24 15:12, Akihiko Odaki wrote:
>> On 2024/06/26 21:03, Philippe Mathieu-Daudé wrote:
>>> On 26/6/24 13:06, Akihiko Odaki wrote:
>>>> FDT properties are aligned by 4 bytes, not 8 bytes.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>   hw/ppc/vof.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>>>> index e3b430a81f4f..b5b6514d79fc 100644
>>>> --- a/hw/ppc/vof.c
>>>> +++ b/hw/ppc/vof.c
>>>> @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, 
>>>> GArray *claimed, uint64_t base)
>>>>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>>>>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>>>>       if (sc == 2) {
>>>> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + 
>>>> sizeof(uint32_t) * ac));
>>>> +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
>>>>       } else {
>>>>           mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + 
>>>> sizeof(uint32_t) * ac));
>>>
>>> OK but please keep API uses consistent, so convert other uses please.
>>
>> This is the only unaligned access.
> 
> What I mean with consistent API use is either use the be64_to_cpu and
> be32_to_cpu API, or ldq_be_p and ldl_be_p. A mix of both makes review
> more confusing.

The desired semantics are different in these two cases so I believe it 
is natural to use different APIs; ldq_be_p() for an unaligned 64-bit 
access and be32_to_cpu(*(uint32_t *)) for an aligned 32-bit access.

