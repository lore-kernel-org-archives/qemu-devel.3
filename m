Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB4BC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMeE-0005uR-8y; Mon, 29 Jul 2024 05:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMeC-0005tI-Oh
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:26:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMeB-0001NJ-1q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:26:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3685a5e7d3cso1402281f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722245185; x=1722849985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aJQglsc/9ThcINvqQpIx6rtAKMkjXGdOWU36BfwkRcQ=;
 b=TAZwAwYTN/louTNS5embtw9m2zHCZdd7f86v3okKKIswV2r0+t9xAegd6VF/Wpbq76
 MZZJUceXrC+bjyHmaY1BASyau/CgJMCbpU0c7gyDZOwYouYVrSavta2Db0Xi2hvjzwwv
 s/aDte7ijY3ZoE5+jGJ7Zg5cd3W9pxKAQxd/oJurG3McsmW7CnArxiC2ZJz+W+tDuXLu
 BYQgB4uIvMyTNnBfu0NWskzC0MxJF3m9RT/IAHfYBgpx/766MbUn4DFIYtCGf0wGYTj1
 s5t4njEc+dcrqh86pzNQ15kRDw7MJQylI3pxlLbhCCpWhuR8KA+/icaRE3MwQU0sk1ES
 AVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722245185; x=1722849985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aJQglsc/9ThcINvqQpIx6rtAKMkjXGdOWU36BfwkRcQ=;
 b=w/ASRuUGU8c0YnrwTrXWXpglF+B8kYeZnE7QBBwmiVQBoO71M6JlHyTDh1U0Uh0bhq
 IHQ3uuTdsWDwghi1xNKtSqajChLWyh/wpsYCF36l5uWEVKKqy0xwweYzgSk6sNjWAjx8
 Rgg6T7VK4smRtjY6gmwYbVVdmMi17OUCsvXsEUV4bLuEOp3oNQ/F0B/YKmeeVoKjGkFo
 NeXpURUJae1Ny3gO7ceakeHQV6scqs2Ob3XkpdM225IYG0vNjp3enqbo2xA0pIteah4Y
 Yuqd1ZMz9Dond1qi1AgJzgAnF+F8bZgA9k9MFqbv39MHvk1brGWkv8CS+Ty116T0KY7N
 2aEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU73lsocZ8TnXULRFHhLvf5soaG11Sed+V4RntGyJCR23A1NEUJfSGfXID/DO8qxcsuBg4IrjGk9RSjDQwZr7X+uaX7X9k=
X-Gm-Message-State: AOJu0Yz9p/GpHwSF9rltx0SQh3ckXMKnUNhP5DezT0UXtbGjLbxxPiti
 pxu/tYs+Xx3KNguQneSgTEaeqsklMdnbd3wAp9k09d2pfviFB4JVuJQFosTzJEU=
X-Google-Smtp-Source: AGHT+IH7Jxl4egsm44aKzPKE0aLRG0ZvDNhAZufHKs58sOQRPIFCkfK9Yg0oOoHoJlDXQJo4YHOe7g==
X-Received: by 2002:adf:f292:0:b0:366:ec2f:dbd3 with SMTP id
 ffacd0b85a97d-36b5d353bcbmr4110803f8f.47.1722245184746; 
 Mon, 29 Jul 2024 02:26:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42813e5067dsm81026115e9.16.2024.07.29.02.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 02:26:24 -0700 (PDT)
Message-ID: <f5f5dfca-d60b-4b0d-add9-e41b42bd4ce2@linaro.org>
Date: Mon, 29 Jul 2024 11:26:19 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240114123911.4877-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 14/1/24 13:39, Bernhard Beschow wrote:
> Some SuperI/O devices such as the VIA south bridges or the PC87312 controller
> are able to relocate their SuperI/O functions. Add a convenience function for
> implementing this in the VIA south bridges.
> 
> This convenience function relies on previous simplifications in exec/ioport
> which avoids some duplicate synchronization of I/O port base addresses. The
> naming of the function is inspired by its memory_region_set_address() pendant.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   docs/devel/migration.rst |  5 +++--
>   include/exec/ioport.h    |  2 ++
>   system/ioport.c          | 19 +++++++++++++++++++
>   3 files changed, 24 insertions(+), 2 deletions(-)


> +void portio_list_set_address(PortioList *piolist, uint32_t addr)
> +{
> +    MemoryRegionPortioList *mrpio;
> +    unsigned i, j;
> +

        memory_region_transaction_begin();

> +    for (i = 0; i < piolist->nr; ++i) {
> +        mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);

Should we check mrpio->mr is disabled before changing its base address?

> +        memory_region_set_address(&mrpio->mr,
> +                                  mrpio->mr.addr - piolist->addr + addr);
> +        for (j = 0; mrpio->ports[j].size; ++j) {
> +            mrpio->ports[j].offset += addr - piolist->addr;
> +        }

           memory_region_transaction_commit();

> +    }
> +
> +    piolist->addr = addr;
> +}
> +
>   static void memory_region_portio_list_finalize(Object *obj)
>   {
>       MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);


