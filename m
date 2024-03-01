Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3DBC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7sl-0000g5-UO; Fri, 01 Mar 2024 13:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rg7sd-0000dz-4Y
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:45:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rg7sZ-0001us-Ld
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709318705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T0PaAYnepFl686An4jdKq5k6YIfj/IH4UyLOD25wD2A=;
 b=TQhxRRWBTk86VyJKoUJno3T/7q5ckxCubK7NCNIlafFRvaRsuU3X5oIwKNdqXntYf6E6MY
 ftTgG89cBF3R+LsmzNJPEDvMSnpufibwk+wBt32J6ug9S4pUyYn4C96QAfdGqLiIhexAXC
 0ST1RffO1eb7adZjosJTGbQpUmgbPCU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Q46gZcIYPIS1BUBF8e2OAA-1; Fri, 01 Mar 2024 13:45:03 -0500
X-MC-Unique: Q46gZcIYPIS1BUBF8e2OAA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56667386cdeso1592026a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709318702; x=1709923502;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0PaAYnepFl686An4jdKq5k6YIfj/IH4UyLOD25wD2A=;
 b=aB4wWGvP8poaCQW0splp0Fvt75OnCActB4KpLvZm1pC0sjJHeNgYaLX1eT4ZGu/h8W
 jV7p2ZgdtrVkp0x07RY8OFaLUiOuhDPEmDYmgfvV22AFpGO1psMzqoGsJwkFxH81ZxdA
 xoEo2HR7GJC8ucb3zROvsO5lpTSjozVfu2ozFREtpV4wnixujuFqfhSkimw8rKD7sIYJ
 82psA/ejjWS1H4ZTdJZEgHZYI3R0PO+F6nPMI/t/ZBySt10bLgxBihy7VSc9KV0MPp6s
 suPM0ngIkBPIwgAho2sztypudUIrMW7s5w/xgyIY2TkueGcwgCdtvkfI7ofiGWgzdCaz
 UNcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpwEF4xbscv7HvH/HaVrFirMU7N0+8YntxZJ1WwUOgukzJns8PSKUq7IeaXJAVOYMINLdbqD5e5e2nLANDP90EbgqThOM=
X-Gm-Message-State: AOJu0YzTB2D933eFJVtK9VZB8l0FlmDWDcrRPP44xKpkR8rmMM3VeQ4q
 wwR8BF4tXJqVcYboROm7eTHfy7z4bsIFIkhzm1DAIxryo1Guwmo1R97mxGIjBDXEjMid8HDG+R6
 vObVczDA296QlPHog8J39DV53M1+P/B9W/o62Pu996RuknKdbmiH3
X-Received: by 2002:a05:6402:28af:b0:566:bfd1:3fe3 with SMTP id
 eg47-20020a05640228af00b00566bfd13fe3mr1894662edb.17.1709318702555; 
 Fri, 01 Mar 2024 10:45:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpYRsjpKxYLi/BUM/4lTJ1eeLWDYmHXTJZRvqRj/9mvPqjwuXgw8qmVGBVyROmdkZ9lUyjIA==
X-Received: by 2002:a05:6402:28af:b0:566:bfd1:3fe3 with SMTP id
 eg47-20020a05640228af00b00566bfd13fe3mr1894642edb.17.1709318702248; 
 Fri, 01 Mar 2024 10:45:02 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 m18-20020aa7c492000000b005662d3418dfsm1781104edq.74.2024.03.01.10.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 10:45:01 -0800 (PST)
Message-ID: <33e7f83b-329f-4cd3-9a8c-6f4436de0616@redhat.com>
Date: Fri, 1 Mar 2024 19:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] libqos/virtio.c: init all elems in
 qvring_indirect_desc_setup()
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20240217192607.32565-1-dbarboza@ventanamicro.com>
 <20240217192607.32565-2-dbarboza@ventanamicro.com>
 <37256c80-5209-4e56-8bc2-28ee59ec42f1@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <37256c80-5209-4e56-8bc2-28ee59ec42f1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/03/2024 16.57, Michael Tokarev wrote:
> 17.02.2024 22:26, Daniel Henrique Barboza:
> 
>> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
>> index 410513225f..4f39124eba 100644
>> --- a/tests/qtest/libqos/virtio.c
>> +++ b/tests/qtest/libqos/virtio.c
>> @@ -280,14 +280,27 @@ QVRingIndirectDesc 
>> *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
>>       indirect->elem = elem;
>>       indirect->desc = guest_alloc(alloc, sizeof(struct vring_desc) * elem);
>> -    for (i = 0; i < elem - 1; ++i) {
>> +    for (i = 0; i < elem; ++i) {
>>           /* indirect->desc[i].addr */
>>           qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
>> -        /* indirect->desc[i].flags */
>> -        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
>> -                       VRING_DESC_F_NEXT);
>> -        /* indirect->desc[i].next */
>> -        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
>> +
>> +        /*
>> +         * If it's not the last element of the ring, set
>> +         * the chain (VRING_DESC_F_NEXT) flag and
>> +         * desc->next. Clear the last element - there's
>> +         * no guarantee that guest_alloc() will do it.
>> +         */
>> +        if (i != elem - 1) {
>> +            /* indirect->desc[i].flags */
>> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
>> +                           VRING_DESC_F_NEXT);
>> +
>> +            /* indirect->desc[i].next */
>> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
>> +        } else {
>> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12, 0);
>> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, 0);
>> +        }
>>       }
> 
> In my view it would be cleaner to add 2 extra function calls after this
> loop for the i==elem-1 case:
> 
>      for (i = 0; i < elem - 1; ++i) {
>          /* indirect->desc[i].addr */
>          qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
>          /* indirect->desc[i].flags */
>          qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
>                         VRING_DESC_F_NEXT);
>          /* indirect->desc[i].next */
>          qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
> 
>      }
> 
>       /* clear last element */
>       qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
>       qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12, 0);
>       qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, 0);
> 
> 
> FWIW, -- it's too late to change it now I think.

Sorry, too late, since the first two patches looked like some good (and 
riscv-independent) libqos fixes, I went ahead and stuck them into my pull 
request today. Feel free to send a follow up patch if it bugs you too much.

  Thomas


