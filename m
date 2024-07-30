Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED42C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 07:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYh3c-00013i-7C; Tue, 30 Jul 2024 03:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYh3X-000115-Fo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:14:00 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYh3U-00007G-Ii
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:13:59 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f035ae1083so56222381fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722323634; x=1722928434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jT6uKrdmKTDFk8SMNWCFqWwYL5UPEiOleM02gWFTC8g=;
 b=OAmMmVAC0C5e6cxaaRZ6DvjyV6CvwiWP4Clw+Gy3oklPVUy2DEqixQKD7DJ4bvq2QG
 FIR6AvYHv8HfukgD1YZzEKJMLsycXpMWAQCJGZ0p6CxHuxgI+I1A/2cwSfkubAnLfbPg
 Cj9cnjoqD/b7YojPHTpXUjp5DbEGkSI/bCipeIAFbhq8W9iYmYXU7adGNbFgTQLPE1du
 iyrU4vI0I5rOwjv+kFJMbMaXEV94BN6ikPTY+nBJro2FrX1MoRjAyC911IrV1sXsYDeT
 pi1X+G26y/1S+XRTDvo8qfHEA4juK+cw89x6OjPwA0TDYUtSO0If3+V6inzEPkgAOQ8E
 mMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722323634; x=1722928434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jT6uKrdmKTDFk8SMNWCFqWwYL5UPEiOleM02gWFTC8g=;
 b=ByysF2dZgpYvt5srdts1fnEyD+C3zAIswD3dj0ZlJkjEh7qUTf2UMgqOxKfquvIR6r
 aNozcCeFBE3JoKA99DF/bkd+dty2OaVtLAIUuAhZqtLRBbRb8K+OhGSfHJ/1TtOCsLd2
 4dQWnAnvIOfnldX+gwMEydhnGE159eb7U1E2K3guId4jFs7/L6BaBntQ/DKKZ49KPKu9
 4RmLB/w31+ln4pyDDQv1txFTBV6kTHnNnOwC9wBM9Rk5pIhtDWCsLVHdfv3GPGqo6RC7
 4gHa1ylJ6NMCFbU4FS2cbhWKeAFmBt9S5nscikfj/J1KCnvxK/Sr4G9G31mUm05rxwAl
 IfQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFiEHn9ZbaRFYGajpN70W+SnJ6WeuOvfa8TzeUE7ZoMvsBtWNvfPg5Nmz+uW8NvkJ0+YfNOGqvYdfYkgBTK3GAo2FpCSM=
X-Gm-Message-State: AOJu0YzzPd0BMe5Lg9wV8bY7VFCLd/9vDTBx/u330nyvPJDHUnn+5Cml
 Y2mLWpLbNF2Hnwnj/W5sJ+/BLrS3PpkRbhiBZlZHk9UFlTuUsl6gqu7NVsjyZ7A=
X-Google-Smtp-Source: AGHT+IHE//bc+iZ0w4mjer5GvULNSaa5YgoBlEezNQlpg4UWqR7WJOzOH+bXAEISoTC/bsWkZkhBDQ==
X-Received: by 2002:a2e:b52a:0:b0:2ef:243b:6dce with SMTP id
 38308e7fff4ca-2f12edfb5aemr57832541fa.10.1722323634209; 
 Tue, 30 Jul 2024 00:13:54 -0700 (PDT)
Received: from [192.168.38.175] (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d9b30sm13956224f8f.40.2024.07.30.00.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 00:13:53 -0700 (PDT)
Message-ID: <05446d09-d5f1-4a6a-a816-ed9c28f6e82c@linaro.org>
Date: Tue, 30 Jul 2024 09:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] exec/ioport: Add portio_list_set_address()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20240114123911.4877-1-shentey@gmail.com>
 <20240114123911.4877-6-shentey@gmail.com>
 <f5f5dfca-d60b-4b0d-add9-e41b42bd4ce2@linaro.org>
 <C0822DF6-EA81-48BB-9102-887E66441EF2@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <C0822DF6-EA81-48BB-9102-887E66441EF2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 29/7/24 23:07, Bernhard Beschow wrote:
> 
> 
> Am 29. Juli 2024 09:26:19 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 14/1/24 13:39, Bernhard Beschow wrote:
>>> Some SuperI/O devices such as the VIA south bridges or the PC87312 controller
>>> are able to relocate their SuperI/O functions. Add a convenience function for
>>> implementing this in the VIA south bridges.
>>>
>>> This convenience function relies on previous simplifications in exec/ioport
>>> which avoids some duplicate synchronization of I/O port base addresses. The
>>> naming of the function is inspired by its memory_region_set_address() pendant.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>>    docs/devel/migration.rst |  5 +++--
>>>    include/exec/ioport.h    |  2 ++
>>>    system/ioport.c          | 19 +++++++++++++++++++
>>>    3 files changed, 24 insertions(+), 2 deletions(-)
>>
>>
>>> +void portio_list_set_address(PortioList *piolist, uint32_t addr)
>>> +{
>>> +    MemoryRegionPortioList *mrpio;
>>> +    unsigned i, j;
>>> +
>>
>>        memory_region_transaction_begin();
>>
>>> +    for (i = 0; i < piolist->nr; ++i) {
>>> +        mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
>>
>> Should we check mrpio->mr is disabled before changing its base address?
> 
> Isn't that the responsibility of the guest? What should we do if the check fails?

What says the datasheet? At least we should log a GUEST_ERROR here.

> 
>>
>>> +        memory_region_set_address(&mrpio->mr,
>>> +                                  mrpio->mr.addr - piolist->addr + addr);
>>> +        for (j = 0; mrpio->ports[j].size; ++j) {
>>> +            mrpio->ports[j].offset += addr - piolist->addr;
>>> +        }
>>
>>           memory_region_transaction_commit();
>>
>>> +    }
>>> +
>>> +    piolist->addr = addr;
>>> +}
>>> +
>>>    static void memory_region_portio_list_finalize(Object *obj)
>>>    {
>>>        MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
>>


