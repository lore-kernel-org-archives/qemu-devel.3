Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7DBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOk6W-0003vC-33; Fri, 20 Dec 2024 16:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOk6S-0003tJ-Ke
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOk6Q-0000aS-8Q
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734728403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OiZEyI6oef6OavKWlcGlUnRQNdOcHZE6H6F7fIQw4Uw=;
 b=LoI9N5and08Fcby0q45LbNpjVb5gZURsI15dOolT/pMYicAjhED+YmNV4YBlztyKu9Cu29
 s2nQ+Z6EyG3Qck4wLOHzQLAC6b1FiXjsYJmcE6eml5y+sBx8DfYHeiKVb3o8uW+bZy0TDm
 4IFwrweJQaiMUvm56y9QQtO6T/NEABE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-PsfJ5N3jOPq9zbIyv-JmNw-1; Fri, 20 Dec 2024 16:00:00 -0500
X-MC-Unique: PsfJ5N3jOPq9zbIyv-JmNw-1
X-Mimecast-MFC-AGG-ID: PsfJ5N3jOPq9zbIyv-JmNw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38629a685fdso1115834f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734728399; x=1735333199;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OiZEyI6oef6OavKWlcGlUnRQNdOcHZE6H6F7fIQw4Uw=;
 b=wHibTWkUDQxxEwcug/8wlrGoNF1Baplm/p9p3amVUKcNagOhfzMMnYmpwcdUXSTv7d
 K2sNhoRe71prZe6sRpN3ryNR31O2OpAcDfdiKPdVqsaogbQ1VhsxwPKBT2NPqfhVz24F
 gOWo8gXKC+bMSnl3FSVxLTKqbxTvorB6TC98JXrHp7gSakLQwDEX8UgFacPGEXQUaRz6
 gJfWOnFpJbN6NJn7SEhz5JH1QjguY/kjRB2emY1LZHwmXuYdzuMBHlL8eQ3O74IXV/U/
 W4wGcbvP4Za/CBv0O/UozUo/7hbzTj8Mj/OExMklCVx9FuhKsUvTDaz4UzlpND5sonwv
 GBOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZs8a371Tiye4ZIp3fOm0vWNBrgye6OK60jJSkIpOiWtufOdY7VqIIiYxe5bqKUfPGxhteF39ftfbD@nongnu.org
X-Gm-Message-State: AOJu0YziN8eCVqiCTef4zsfiSKpZI13zqWcWJwe2TJYdipIIaufa37re
 S1vzVj7VDGfA9kZppaqX5eYDLtrl3kTp69D+ljKGyNjWN6vqYZueBgBXylcaNOPW4On3nbZOiaz
 50Pz1P6w1Xeo5GUA3h63+iQJbRaSrYo1HzEZQ/GqODY0kDlkJk3dm
X-Gm-Gg: ASbGncuBIfU/cNtLKXBia9g17uZflZH7zzuD/m9wFyiYC3GsAXkoS0A9j5DNhOnnCph
 LowRd+lj3pLhcmqReaJoxrD/DFb0rgLCtP6rkHqpUXt3VWIzn/s2mAgpT/fiSmeMZ9ivVtupW2i
 A8WUOfxv5HanA+0wUJfZi6XqqoEblsg2A39c9rzMJ4R/HcTA6esDu4dV8hyx2NFdR9iWtAqyEYy
 xxYoXM9nLyzaHpgNwwZ7tB8tczWHisjOAUIzuCCBVZLeXqYU8gU2/nlnes7D6UWeNG//cGo97Ec
 63M4HmnRi+ifsnazUOp2aHVV3cKoNZAwpACZPChs3vl3pK3niJ4dglwz8ENR1i5PxFP1MOvDVBb
 TIlFxfGQE
X-Received: by 2002:a05:6000:1fa5:b0:385:ed16:c91 with SMTP id
 ffacd0b85a97d-38a221faf85mr4173610f8f.24.1734728399009; 
 Fri, 20 Dec 2024 12:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMVm7whMAtZ/dCSR2DGCSeBx1Mv3Tu/SrzBbPthn9OY6zMc6H7nTrBrRdeFXUfYNZymS8W7Q==
X-Received: by 2002:a05:6000:1fa5:b0:385:ed16:c91 with SMTP id
 ffacd0b85a97d-38a221faf85mr4173606f8f.24.1734728398680; 
 Fri, 20 Dec 2024 12:59:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3?
 (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de.
 [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm55365605e9.14.2024.12.20.12.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:59:57 -0800 (PST)
Message-ID: <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
Date: Fri, 20 Dec 2024 21:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: Stefan Zabka <git@zabka.it>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241220195923.314208-1-git@zabka.it>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241220195923.314208-1-git@zabka.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.12.24 20:49, Stefan Zabka wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
> Signed-off-by: Stefan Zabka <git@zabka.it>
> ---
> Addressed initial review by David Hildenbrand
> The other change made more sense to me, so I'd like to write a test
> to verify that an AddressSpace like
> 0x00..0x0F MMIO Device A
> 0x10..0x1F ROM
> 0x20..0x2F MMIO Device B
 > > and a debug write from 0x00-0x2F still writes to MMIO Device B
> and that there isn't an early exit in address_space_rw
> when it encounters a ROM region.

Good point, I suspect that will be problematic.

Maybe address_space_write() should be taught to be able "force write" to 
ROM instead, so it can just handle everything as part of a single loop. 
But that's a bit more churn ...

Building another loop around address_space_write_rom+address_space_write 
looks a bit suboptimal, but maybe it really is the low-hanging fruit here.

> 
> How would I go about doing that?
> ---
>   system/physmem.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a384..623f41ae06 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3573,12 +3573,13 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>           if (l > len)
>               l = len;
>           phys_addr += (addr & ~TARGET_PAGE_MASK);
> -        if (is_write) {
> -            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
> -                                          attrs, buf, l);
> -        } else {
> -            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
> -                                     attrs, buf, l);
> +        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
> +                                   attrs, buf, l, is_write);
> +        if (res != MEMTX_OK && is_write) {
> +            /* Fallback since it might be a ROM region*/
> +            /* TODO verify that this works as expected*/
> +            res = address_space_write_rom(cpu->cpu_ases[asidx].as,
> +                                          phys_addr, attrs, buf, l);
>           }
>           if (res != MEMTX_OK) {
>               return -1;


-- 
Cheers,

David / dhildenb


