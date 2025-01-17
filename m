Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0083C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYraF-0002CV-D5; Fri, 17 Jan 2025 14:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYra1-00029X-03
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYrZz-0005Hz-Bu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737140425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9Q095ncfrQw4FxQkDUGmgmKecj9SzWw/10eWEy99RXw=;
 b=OwWACPFMB65INLCvwIMzVvTTu9KLWQHdBPBPGJNuabP8juAkH/0Fjhi4eXA7lyybutNb3Y
 GMJ1pzXUsdpDDp4rTJocdFoHuJfbDmr9HGMORRlHUKabVhVVGMRSwBqTC4GUM0j9d8GJET
 OsG+24kEVls1AyK2dG3mebPCHkiss28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-FQWiB6LfMEanB9oy1jGhvw-1; Fri, 17 Jan 2025 14:00:21 -0500
X-MC-Unique: FQWiB6LfMEanB9oy1jGhvw-1
X-Mimecast-MFC-AGG-ID: FQWiB6LfMEanB9oy1jGhvw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so1103919f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737140411; x=1737745211;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Q095ncfrQw4FxQkDUGmgmKecj9SzWw/10eWEy99RXw=;
 b=aLWulkQEPUdrmEkmDaYyj/26aLWx6Y60mGBMurudvsJy1VEvBkW00KqULWgasqNpqc
 Gbm5gN7CKmoXdKLfzsaW1k367YWbc4JWJ2STn7t1wblUki843wCFZB7nstgs6Eq6Jxns
 /VYDiVhG3943pEM+oc7do6inRGesae63ZsQOO558lcUei+UX/nONi7gXyM1EURby9vjp
 Ht0h3H+1OFjZM2wI4EHk1Ql4HYL+Hh/8q3HF/M4BpwR/eYSp6lIA9Asza7aSJSzdnT4a
 DO5eBCuMQ6d+HTmtgRj38u5l61D7yIe8Yz4L4cOQETRIiYsrwcyyCTozHQwoF0/D0kuR
 2Bzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5eGCUTFv8nXZgvLAgsdSDDXtvDWkBzgv9QJeSHbhqZO9NMrp6ScavSIaNYNlmx93a08VZV7tj4uGj@nongnu.org
X-Gm-Message-State: AOJu0Yzn3CWPb4UDH2AjBKnsij0nv1Afh4u5ed/7mH7cFLmv/msXZxKy
 COCbp8RYOXFmm5kGUUJiFqMEe/bGXGKqrpsDZrCbFbsWGTG52G+skk/sc2lJQdo4kYZ4svjpDDC
 IxG7Es9mxzXyb1sxGXL7r8cePhHnieWXHTiLPEnEO0zOTUcX5t70U
X-Gm-Gg: ASbGncsWeB7dQl/y+XpkaLaIAjiopKVMIfGYA7+xnAZzgu8GpaDRSDibIhYwbl7KzMU
 yZB6HO9OWesJxd7jKqtBKY++nNtPn4PIHU7MhyJShrjGaT1F/noNy8KkD/b7f+chyswv2WissgP
 pDQw7oWiCcKoe9fruDyNKKREKx6V4eoX67O7hFIraXoB2cwvCBRK+Q0I3vL+Yn96TOqP+QA/M2k
 0o79yOLV2PHMx0TKSmfz8UhHOlI7Z/8XEeUfak3ZNqbuE+EFVe10gSaGxP9yLB6qcnpvQI4rLQh
 A44EYONlar7q
X-Received: by 2002:a05:6000:178e:b0:385:fd24:3303 with SMTP id
 ffacd0b85a97d-38bf55c5f54mr4102324f8f.0.1737140410738; 
 Fri, 17 Jan 2025 11:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVD9PUOhOc8fiUsFVxTKw0mWt9XXQp/YeyyKpXUeXF+cCCkik6ORlwxDUTN1Xd4GogkRTdeA==
X-Received: by 2002:a05:6000:178e:b0:385:fd24:3303 with SMTP id
 ffacd0b85a97d-38bf55c5f54mr4102295f8f.0.1737140410360; 
 Fri, 17 Jan 2025 11:00:10 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322aa40sm3184051f8f.45.2025.01.17.11.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 11:00:09 -0800 (PST)
Message-ID: <3f7407e8-7fe7-407b-9110-651f3f13ab8f@redhat.com>
Date: Fri, 17 Jan 2025 20:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-9-philmd@linaro.org>
 <75e7805f-1ffa-421d-9415-5132131d80a7@redhat.com>
 <293b6780-17e6-4cee-a141-55022a9a75c2@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <293b6780-17e6-4cee-a141-55022a9a75c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/01/2025 17.41, Philippe Mathieu-Daudé wrote:
> On 17/1/25 09:58, Thomas Huth wrote:
>> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>>> E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
>>> via the 'extra_mac_registers=off' property. We removed all
>>> machines using that array, lets remove all the code around
>>> E1000_FLAG_MAC.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/net/e1000.c | 63 +++++++++-----------------------------------------
>>>   1 file changed, 11 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
>>> index 3d0b2277039..14d2133cd80 100644
>>> --- a/hw/net/e1000.c
>>> +++ b/hw/net/e1000.c
>>> @@ -127,10 +127,8 @@ struct E1000State_st {
>>>       QEMUTimer *flush_queue_timer;
>>>   /* Compatibility flags for migration to/from qemu 1.3.0 and older */
>>> -#define E1000_FLAG_MAC_BIT 2
>>>   #define E1000_FLAG_TSO_BIT 3
>>>   #define E1000_FLAG_VET_BIT 4
>>> -#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
>>>   #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>>>   #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
>>> @@ -1218,46 +1216,17 @@ enum { MAC_ACCESS_PARTIAL = 1, 
>>> MAC_ACCESS_FLAG_NEEDED = 2 };
>>>    * n - flag needed
>>>    * p - partially implenented */
>>>   static const uint8_t mac_reg_access[0x8000] = {
>>> -    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
>>> -    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
>>> -    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
>>> -    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
>>> -    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
>>> -    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
>>> -    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
>>> -    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
>>> -    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
>>> -    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
>>> -    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
>>> -    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
>>> -    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
>>> -    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
>>> -    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
>>> -    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
>>> -    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
>>> -    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
>>> -    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
>>> -    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
>>> -    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
>>> -    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
>>> -    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
>>> -    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
>>> -    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
>>> -    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
>>> -    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
>>> -    [BPTC]    = markflag(MAC),
>>
>> I think this is wrong. All those registers should still be marked with 
>> MAC_ACCESS_FLAG_NEEDED, shouldn't they?
> 
> I followed Paolo's removal in commit fa4ec9ffda7
> ("e1000: remove old compatibility code"):
> 
> -    [RDTR]    = markflag(MIT),    [TADV]    = markflag(MIT),
> -    [RADV]    = markflag(MIT),    [ITR]     = markflag(MIT),
> 
> Is it the same problem?

Oops, sorry, I think I got confused by that MAC_ACCESS_FLAG_NEEDED logic in 
e1000_mmio_read() and e1000_mmio_write() ... after reading it more 
carefully, I think it is ok what you did here.

But maybe you could even remove the markflag macro and 
MAC_ACCESS_FLAG_NEEDED now completely?

  Thomas


