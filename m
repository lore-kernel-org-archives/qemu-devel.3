Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A69C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMovW-0005jV-Cb; Thu, 27 Jun 2024 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMovV-0005ir-EI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:12:37 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMovS-0006GQ-F6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:12:37 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-375d22e537cso19219635ab.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719493953; x=1720098753;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0LeyfgeJd1unmyJKZLnXvJEnydjYwJJY0u0SHj/hQ40=;
 b=NnAeBz+Jj56MKKTQ9cRd6mOkV3nZxNt1xwnBfWjPQeuLf6vUzZXBhTZO/utEFlyfUc
 WJUW3y3VBwf0esoR4LWKJTY8Dw2UWpVQl+2jWS3gUyv+0MGfYvunIntK7r+7GBMi6qkC
 HmZEqgVvEdMgTQpkmNft13F3uhJGqDLHQncAFFV1WU/E8slX5dlqFoImD9iwMQx/e6Ot
 Nmu7/tyAu2FcVXRR9CYDgsU75nTWmThKTotWvOZfDXHRLxS39239NQ/PslWk372woug2
 iouARVn45TQHLkOtTGYX7PAfU/lTSXWgb98CLVrE5QBEda/X0sD5t93g7kZgFZVZh0Nr
 PEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719493953; x=1720098753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LeyfgeJd1unmyJKZLnXvJEnydjYwJJY0u0SHj/hQ40=;
 b=o6USJnK6P4OYUkL3ERT526rbT3Q52tYLhFsozrURXgYhKTDp4AAWBFUbFUSCqfcfRW
 mISBztE6X02B1WfSsUYrvoZxkk9caVV2fB0YxQuTNeOnsR2Ga5UIkY/6OrM0Cp3o0jkc
 Xy5cgyduC8G8Dl9Oqob/my2COUGSTjjMK9/1mf1yopsSnMW5e68dq+p3ml4eV61Xq4cV
 gZ14JK8BpnZpngFNaHyqaxp+BzArsoLsn/2yojObYvdAsBojfFWAuED2Xmc3BfYWk/dY
 lQ+fvTOSu5JDc2lQwV5hZMWX62KQNFpdEuoQhXCkrYWKVtlCKOfqIOxWgaBgYivkHjhu
 dxxQ==
X-Gm-Message-State: AOJu0Yz5lCFw0+SikkRE7MseEAAdzVe8EZpiZHUnYr+e98qIKrSHSx0v
 wZ49IwSwYynerioAyhRMUcjsIIJfE3bqWPyfrDhPVc5vI1GL6N0sBCwhVRVCJ+I=
X-Google-Smtp-Source: AGHT+IFTH6liPzo0kG3TQoRz9UkzK8QCxs96idhCqrv2iKsSwCQy9bYAG+hBgrwc5WPpAB5thKEFxg==
X-Received: by 2002:a05:6e02:1a8d:b0:374:a159:ea67 with SMTP id
 e9e14a558f8ab-3763f682ea4mr201450885ab.25.1719493953082; 
 Thu, 27 Jun 2024 06:12:33 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72745d06743sm918168a12.33.2024.06.27.06.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:12:32 -0700 (PDT)
Message-ID: <9fdabbde-1ae8-4f78-af20-b4383b7705fc@daynix.com>
Date: Thu, 27 Jun 2024 22:12:26 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <efdfa803-775c-4aa2-b7c4-f016dafe9a88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/26 21:03, Philippe Mathieu-Daudé wrote:
> On 26/6/24 13:06, Akihiko Odaki wrote:
>> FDT properties are aligned by 4 bytes, not 8 bytes.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/ppc/vof.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>> index e3b430a81f4f..b5b6514d79fc 100644
>> --- a/hw/ppc/vof.c
>> +++ b/hw/ppc/vof.c
>> @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, 
>> GArray *claimed, uint64_t base)
>>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>>       if (sc == 2) {
>> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + 
>> sizeof(uint32_t) * ac));
>> +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
>>       } else {
>>           mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + 
>> sizeof(uint32_t) * ac));
> 
> OK but please keep API uses consistent, so convert other uses please.

This is the only unaligned access.

