Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE51C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQqr-0002kl-Tn; Tue, 05 Mar 2024 04:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rhQqm-0002kL-Rj
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:12:41 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rhQql-0006Jr-2S
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:12:40 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29aa8c4710bso3942990a91.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709629956; x=1710234756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/pDk8Gm8AhWT6NHV+YcJyeYchsigYf2/QZjCjOGo8M=;
 b=nqsD7QrTG8XrZm7e/mMhyfGKOm2uecT/awS6ik4H+qja5b/4KDyj1Jz36ATjzO/A5w
 s7qWpTh3/idcKX+QDu5nDjR/9X1unm8q97TyIb0UMKvZWBr/VWe+SCh4IH47Lu6ZL+mL
 a/vvLvI8ttE4GOI+kIav+P8uQrzKBtcqotKKtqTcCxroEqtCKkQAOZlrQ0Z9OL3kd34z
 Q/jIP32XbJ2SEg+YwERvqcxsFIfs7K9z28MCPoCnTmUmt+ECV6tTCQ1VGEA614iiedmd
 CZaMNfIBOK0fxXpevsIUtDEkUHTOpayxSML5npiNqWR4mNZl1sTtfptcL7FMMQ5lyU6I
 HG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629956; x=1710234756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/pDk8Gm8AhWT6NHV+YcJyeYchsigYf2/QZjCjOGo8M=;
 b=QIJqmIv/fysby8W6leLb16vewTRdNGND8NeETud4LUW2en6MYAYneZZP/Cft2IJDbl
 j87PMk24Zx8GDfQt/5mLcNe5pQrrq0p0eHVsLmnfSy8Ba/ilQTQKUnCKtinZkjv7ETkM
 7FEynWz/GJLbGQM9wI0tkKM6CA81MuV4yluoeGEawSdy9KBnMxIAXGS8/aCt7LTpZUeQ
 F33EPz+LlqZeh5clbopjoZ+osewsrESoIfITsha8FSNIXQDw+7/JTbZvq5maRNy4O8n5
 OzwJu323Sz+mYaOCk3dF2FLOo6BhdeVuY6wGl6Iz1FcqSpzUn5+7bGT4PR7fWlUm2uhr
 lkog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWx5rltHX8UMLUduM+aUDNb7FVJVPg+vNYAwT1bO0vkK2uXjp3cmoyYuHEbXk1VfIXUO9E0rpZFGNJ6zMFZfgaTgjZaVI=
X-Gm-Message-State: AOJu0YwH7rt1dCBg5Jnmd1Ui1JMyuJAHeGMxJ5pigMjNGpqugG1TBL7c
 cc7bWhrT+7eCjAXrbijpvaJur3kZmIHHEWH4PQWCMHy74n/RyJfvf2cN4f84hljxCA==
X-Google-Smtp-Source: AGHT+IHDqGOopUUL5J+oT3eimnL3Zz+IDeQPt93YSbPFoSuQt7fYsDIzVtBARVjI2Em2LoewMqR25g==
X-Received: by 2002:a17:90a:a113:b0:29a:9dd1:d45b with SMTP id
 s19-20020a17090aa11300b0029a9dd1d45bmr2501600pjp.3.1709629955863; 
 Tue, 05 Mar 2024 01:12:35 -0800 (PST)
Received: from [192.168.0.115] ([14.191.95.87])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a17090a440700b002990cc5afe8sm9171782pjg.42.2024.03.05.01.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 01:12:35 -0800 (PST)
Message-ID: <50c2e720-454b-49bb-acb8-696e86695dc6@gmail.com>
Date: Tue, 5 Mar 2024 16:12:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/apic: fix memory leak
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240304224133.267640-1-pbonzini@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20240304224133.267640-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/5/24 05:41, Paolo Bonzini wrote:
> deliver_bitmask is allocated on the heap in apic_deliver(), but there
> are many paths in the function that return before the corresponding
> g_free() is reached.  Fix this by switching to g_autofree and, while at
> it, also switch to g_new.  Do the same in apic_deliver_irq() as well
> for consistency.
> 
> Fixes: b5ee0468e9d ("apic: add support for x2APIC mode", 2024-02-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/intc/apic.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index 1d887d66b86..4186c57b34c 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -291,14 +291,13 @@ static void apic_deliver_irq(uint32_t dest, uint8_t dest_mode,
>                                uint8_t delivery_mode, uint8_t vector_num,
>                                uint8_t trigger_mode)
>   {
> -    uint32_t *deliver_bitmask = g_malloc(max_apic_words * sizeof(uint32_t));
> +    g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
>   
>       trace_apic_deliver_irq(dest, dest_mode, delivery_mode, vector_num,
>                              trigger_mode);
>   
>       apic_get_delivery_bitmask(deliver_bitmask, dest, dest_mode);
>       apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
> -    g_free(deliver_bitmask);
>   }
>   
>   bool is_x2apic_mode(DeviceState *dev)
> @@ -662,7 +661,7 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
>       APICCommonState *s = APIC(dev);
>       APICCommonState *apic_iter;
>       uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
> -    uint32_t *deliver_bitmask = g_malloc(deliver_bitmask_size);
> +    g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
>       uint32_t current_apic_id;
>   
>       if (is_x2apic_mode(dev)) {
> @@ -708,7 +707,6 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
>       }
>   
>       apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
> -    g_free(deliver_bitmask);
>   }
>   
>   static bool apic_check_pic(APICCommonState *s)

Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>

Thanks,
Quang Minh.

