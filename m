Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AFAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 13:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfJaf-0001RC-CA; Wed, 28 Feb 2024 08:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfJZp-00016o-KC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:02:27 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfJZn-00027Z-UM
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:02:25 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BA7093F684
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709125338;
 bh=ni2u1AG8RMtTNfLfQmkSAT4tDdbgi7wr6UQOOcXLq0g=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=c7zBY/tHDzTCku/+q8Ivlc3NCi4IvRqr6vyjlObEp3tMl2+ogaMBNUi4Drq2rtnge
 78YcLBx7UEJOPfe7j3PjQrkod9Fgqg2SjXrHn0ZUJHlTTQOppIniIXVL4RdRJjo/uO
 TRODPkg4GYlceSMk8bLy5t4ZMqcisEy6/vE2+kB7fkxMYq5DOrzeDZygUODXlQO4iD
 avWTAHeN7Pp8X1KUnVhJLk6o7r9LXM8ACUnzIoKOPH+B1dIBXrtchwNHOIu7YA2jS8
 7uGknFUjN6T+55InZurrAbjhjmEBTXoyG7U/ZweSD+fcp2dfm+1Cyw0CQF2eZPj7Wo
 gsNx8LjL3jHQA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e40126031so29185425e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 05:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709125338; x=1709730138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ni2u1AG8RMtTNfLfQmkSAT4tDdbgi7wr6UQOOcXLq0g=;
 b=RV3yDZIhwmvQsyBaf/M3k1hw4bX3HwcPRvQYRSy2Q8Q0zbVhRajdE4TKlyi1uzdNqM
 tp25/K2DjGjSHsAyEqcEfQEP0ZskscMoZzX2tEC3TYfDDxxE4v1whf1eJZTzKX8Nflap
 z/dP9/LCtBt7Yr2JlJFCNTTc3plbiLr+TNoxtkrY9pTLsZH2iejBuiT2+70qtr6X5s+Y
 9hQBwRiC/VzCXjdlsl7XaWAFAN1INRo2/5H7tho5lnW1nRPL1ZLCaJeTwzVgcTlGFJtl
 G7vHPuz1rYnpZkDbFMtxGxTv8HmDqveLpeMRUrdmG/kx5QNvik22ZLN2n4fOjLWlhaEC
 B4lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr/JhE51fERS2d0uC4Yag3K6X3o5Y1ywqjl/zCbzJwvBwLatY/824TESA+HbRUjy5SWt0l4b/QiGPooQ0ATlfcOw33YXE=
X-Gm-Message-State: AOJu0YzeVGUISgCeEmYLupSHOb88W0XD2aEvbRWLtlUAZhsf0trK5mFQ
 +RlRMa+5EHEXclrXwSjQlbs+Ex/uAPWndczWe0S2X+34kWQH3pHYOjNGUrHO84YCXZvsaha24GT
 vTNnQntGiRVRPNG3z9j9dxYGmW4tA26PrRo1gZ6G6tz6OHQPPoRM2prHoKwCREwSGSMVR
X-Received: by 2002:a5d:4741:0:b0:33d:63c0:3b7f with SMTP id
 o1-20020a5d4741000000b0033d63c03b7fmr8620057wrs.42.1709125338304; 
 Wed, 28 Feb 2024 05:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG90EZuD3juGYNd9HabvanKfmqbwKW/jaW+nwqFojp/JrtkBpiM1gtv2X7LrhkBMYvnQ9/PiQ==
X-Received: by 2002:a5d:4741:0:b0:33d:63c0:3b7f with SMTP id
 o1-20020a5d4741000000b0033d63c03b7fmr8620029wrs.42.1709125337900; 
 Wed, 28 Feb 2024 05:02:17 -0800 (PST)
Received: from [192.168.123.67] (ip-095-222-037-056.um34.pools.vodafone-ip.de.
 [95.222.37.56]) by smtp.gmail.com with ESMTPSA id
 t4-20020a0560001a4400b0033d06dfcf84sm14325334wry.100.2024.02.28.05.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 05:02:17 -0800 (PST)
Message-ID: <84ddd754-5b54-423a-8383-04b0b47cf051@canonical.com>
Date: Wed, 28 Feb 2024 14:02:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] physmem: avoid bounce buffer too small
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240228124638.55752-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240228124638.55752-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28.02.24 13:46, Heinrich Schuchardt wrote:
> virtqueue_map_desc() is called with values of sz exceeding that may exceed
> TARGET_PAGE_SIZE. sz = 0x2800 has been observed.
> 
> We only support a single bounce buffer. We have to avoid
> virtqueue_map_desc() calling address_space_map() multiple times. Otherwise
> we see an error
> 
>      qemu: virtio: bogus descriptor or out of resources
> 
> Increase the minimum size of the bounce buffer to 0x10000 which matches
> the largest value of TARGET_PAGE_SIZE for all architectures.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   roms/edk2         | 2 +-
>   roms/seabios-hppa | 2 +-
>   system/physmem.c  | 8 ++++++--
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/roms/edk2 b/roms/edk2
> index edc6681206..b8a3eec88c 160000
> --- a/roms/edk2
> +++ b/roms/edk2
> @@ -1 +1 @@
> -Subproject commit edc6681206c1a8791981a2f911d2fb8b3d2f5768
> +Subproject commit b8a3eec88cc74bbfe7fb389d026cc7d1d8a989c8

I have resent v2 of the patch w/o this unrelated change.

> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> index 03774edaad..e4eac85880 160000
> --- a/roms/seabios-hppa
> +++ b/roms/seabios-hppa
> @@ -1 +1 @@
> -Subproject commit 03774edaad3bfae090ac96ca5450353c641637d1
> +Subproject commit e4eac85880e8677f96d8b9e94de9f2eec9c0751f
> diff --git a/system/physmem.c b/system/physmem.c
> index e3ebc19eef..3c82da1c86 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
>               *plen = 0;
>               return NULL;
>           }
> -        /* Avoid unbounded allocations */
> -        l = MIN(l, TARGET_PAGE_SIZE);
> +        /*
> +         * There is only one bounce buffer. The largest occuring value of
> +         * parameter sz of virtqueue_map_desc() must fit into the bounce
> +         * buffer.
> +         */
> +        l = MIN(l, 0x10000);
>           bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
>           bounce.addr = addr;
>           bounce.len = l;


