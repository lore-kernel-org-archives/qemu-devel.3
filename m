Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23342CA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 08:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulO5E-0001Kp-Eb; Mon, 11 Aug 2025 04:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulO5B-0001J5-Ax
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 04:40:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulO56-0001NY-W5
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 04:40:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b79bddd604so2338160f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754901633; x=1755506433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ffjF7I2ZBv2NWGWQJc47leyaSP9XZxx8N0jxMVN2420=;
 b=t69e0AjTvZDmYfHcIqKgJ9XH0rbkCy02HzA/uNJfKrVl+4czfVIbyn93Mi76WjuTAZ
 omkh/wfgcPb7zyVHmjrBDqiNXrHwhhoW9zweYZ4gQUEx8KpYEYWj5u2xqIJMtll+FLdJ
 FjV0S6UiyxU2tDixNxgdDacqACS7OUcdTVohRvHB87zji7F/jg74MbyoBpaheeFelH8E
 n3sUo0qCxjNEe09JcfH2JEfUA+SJlNqq3YyceTXxp8jUDyHz4F4Ed1h1kJoGtSE6ADlN
 tzr03+zSQ0YUlWVj50nkljQcBaYUnkNwfiOqlDVgIvriO6T2NiE2jPN8LwjGbW8J8JLC
 qhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754901633; x=1755506433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ffjF7I2ZBv2NWGWQJc47leyaSP9XZxx8N0jxMVN2420=;
 b=qqkrdXj2gg2wr61RdY5+4/X7zn6uVzKkWCF0Fn44oeUri8VijpDIaE5GwzGHTkIOom
 Q1+JHMR8RdisO2Cwo6OpsQLLkZewhIqKq24HYl1+3lYPxlM8n/FdsAg8Tu9yOCzqWjym
 aQwysaGZTkVsWKEmQucX85+8Ou5ar6ipwL0/vH4XaLubbj55cZYKEcCfbKt9w1DLuPFx
 bXZQWCBreMQMf66kiz3bZR2tfTb7Xs3DXy+LIzGgm9UZCh7NXl1FgEdhLwUrtz2j+GVW
 FpL2SRh7IJjb2m8PoG0xd6KdD/TI2QAG/DuqPpP/JSZ/jRjXehubpoAThJP3OavVz/HD
 Zp5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvSy54u3ys9uhhqPWBHxyc5m1ggOTL7NFKMc66gu77zh8ZQRY24UVvwrCjvzrgljxC9AfjaIMI3eIY@nongnu.org
X-Gm-Message-State: AOJu0Yz+VYTM16R99cB3MQ8kCLafvlr75X+4EXS0469PYLHSap5nvaNx
 jESN80LhDk+wFxODJ2x/YJSMtGx+woDkVTbyTbK6jXcHDsDhfG4w2Js9mhSg+hV5ECc=
X-Gm-Gg: ASbGnctttF4BRzi0G4LzEK/oDOjcjI6DPQEhnbkTamv8p4QnHy86iGFoFFsuJ+vNAjo
 MdUyitkk0GYgyczD8377eVuW17P02IY/YDoiv1VEgetjwpSNJ5x2kjYabZywqToz2RfApeQ2fmj
 nNEoIpfaoDAXyXrfS6GGa1ah6PyOfOQVXL77izU8yCn9Az8iVZHkS2kCY7/gyG6HIx7GB+2WYVS
 rxAuAlpGBHwsyjDvw7/NQqXd1bek3Ugaf/HDfOBnZiiACiluk8SqrV2lNoBMYqL7nR2JZu1JAf/
 2FSG2SVyS5yqTEMRyS79JXIxdmPWaYqGMuAK4jnApdqLG5AtAi1MgC/RkIJjEHl9kieIDSdcPdx
 mjVEe3eOmsFTsr/nLZHa2YGSiPs0HBFAn3CSke3DPsqT09OQLOLG0p/guYnEwpzDvdw==
X-Google-Smtp-Source: AGHT+IEn/keD64Z17y9MYNcD0QqzOspdSRYW4o82xV3Rbi0I9jAv5eEJs8cJH+BEzcKzfm9xqCpd/A==
X-Received: by 2002:adf:fc8f:0:b0:3b7:99a8:bf6e with SMTP id
 ffacd0b85a97d-3b900b6ac09mr7725190f8f.51.1754901632834; 
 Mon, 11 Aug 2025 01:40:32 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8f5d7deaasm18943913f8f.65.2025.08.11.01.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 01:40:32 -0700 (PDT)
Message-ID: <4dbb1946-9b01-4b66-a0e4-f49bcd19df42@linaro.org>
Date: Mon, 11 Aug 2025 10:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/ppc: Add stub for pnv_chip_find_core()
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-4-philmd@linaro.org>
 <eff37ca7-d977-450e-85e0-ca8e4f6f3d5a@redhat.com>
 <ba766eae-e8e0-436a-ad30-625744b872e4@linaro.org>
 <7a537212-3634-4fe4-b574-b9287c75cb2c@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7a537212-3634-4fe4-b574-b9287c75cb2c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/7/25 20:04, Aditya Gupta wrote:
> Hi Cédric and Philippe,
> 
> 
> On 26/05/25 17:21, Philippe Mathieu-Daudé wrote:
>> On 26/5/25 13:48, Cédric Le Goater wrote:
>>> On 5/26/25 13:23, Philippe Mathieu-Daudé wrote:
>>>> Since commit 9808ce6d5cb, building QEMU configured with
>>>> '--without-default-devices' fails:
>>>>
>>>>    Undefined symbols for architecture arm64:
>>>>      "_pnv_chip_find_core", referenced from:
>>>>          _helper_load_sprd in target_ppc_misc_helper.c.o
>>>>          _helper_store_sprd in target_ppc_misc_helper.c.o
>>>>    ld: symbol(s) not found for architecture arm64
>>>>    clang: error: linker command failed with exit code 1
>>>> > Fix by adding a stub when CONFIG_POWERNV is not available.
>>>
>>> The fix would be to add an abstract handler to implement SPRD accesses
>>> on the PowerNV machine.
> 
> 
> Is this what you meant by an abstract handler ?
> https://github.com/adi-g15-ibm/qemu/ 
> commit/0abac37032a5ef66d64a649ce04f24876bf9007d

I think so.

Avoid using target_ulong if possible (I suppose SPRD only exists on
64-bit CPUs so can be uint64_t).

> 
> 
> The thing done, is just to introduce a function pointer in 
> 'PowerPCCPUClass',
> namely 'handle_sprd_store' and 'handle_sprd_load'
> 
> 
> These will be set in the PNV chip realize path, so now the SPRD code in
> target/ppc, will only call this for PowerNV.
> 
> Separated the powernv specific code, so target/ppc code doesn't depend
> on pnv calls now.
> 
> 
> Not well tested, will try somethings.
> 
> 
> Thanks,
> 
> Aditya Gupta
> 
> 
>>
>> I don't know what "SPRD" is so I'll let someone more familiar with
>> this area do the proper cleanup.
>>
>> Regards,
>>
>> Phil.
>>
>>>
>>> Thanks,
>>>
>>> C.
>>
>>



