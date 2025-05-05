Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD30C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsMF-00067N-4x; Mon, 05 May 2025 05:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBsMC-00066s-O6
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBsMA-0003hy-OC
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746438205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sP81zsT/RNSG8ANhqUBnaYmRGZAXZNzC428xVjzVw84=;
 b=DcV/l3fdqcD5ukFJWB4T/YDQGV3Ag2ey/qPaKGB/TIbDd16zsTNVPlBdrO7jWJSl/uV/Yw
 FQna4cRvM3lAHuf2FLAM5FV4Pum4k90OwTRKDGZkHbtrK0FNG1k6fwXnk8j1J9enYCcN+e
 uupuQM0xjR52bU92FHHF+XmHvMAhH6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-J3rVhgc3NCKd63oqmXxxkQ-1; Mon, 05 May 2025 05:43:24 -0400
X-MC-Unique: J3rVhgc3NCKd63oqmXxxkQ-1
X-Mimecast-MFC-AGG-ID: J3rVhgc3NCKd63oqmXxxkQ_1746438203
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so24367055e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746438203; x=1747043003;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sP81zsT/RNSG8ANhqUBnaYmRGZAXZNzC428xVjzVw84=;
 b=SnB7aehg3elOFTy92HLAFN0Lu9YB16/3JJO/k8PKbYBlTlqMaCxd0UbagS21uaolgD
 HnAWlEsB7iiox8D/rLlfimICgMSe3cSmya1JRP+mrecGndixA8zO0ffTT/06llOUyrqV
 fy9zRDbH/TLklhC5/JZkOw7mCnkAPJu4aAqpef1AUek09rMq+B5xOf/nZCc6q5k/h3Bs
 SlUVVgVaO75AT0ztPfVNDxUE6kas7qQDah7wVP5JqKkphMx0t4AMggf0eKMTyLBhW3nG
 JVtiYkWzLu+jNxzKzj63HiisPoZYcHLMPKtV4UnBmslBMmGgRS0D0D/Fypu01GVM4VuM
 H4Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpLn+xQjiJ2yzogSBKKHV1t8sMRZreMjEXxNbbIucCs/qsx+Q9jKm5lyTbxksn+ShEMH6H9lhNZ5WJ@nongnu.org
X-Gm-Message-State: AOJu0YxrSIs7wyrDeijTrbGL5WDzaV1eSavKlvxmgySdO+Etop0cbLVy
 nocuOmCEVoKQE4z4OFui9xt+Se2vebY031lPzfiTp3B7er2FKV2Zu1dnH9kYIB7Y98ZNZZQkYaO
 B0Y3uWwygDDWBqh0ZqS7uqxtV0erKStMY0tnKu6flz8zQK8qSrRjVUzJ++a4L
X-Gm-Gg: ASbGnct0VrC690+pjjUifPWRlCAbqT/9HzvpXnJb1fKajOb2zIxID+EDkgLZTPHx0qt
 DWNnnjRaWY4O4N/7nAcgj7W4t4It8QusEPSOgGFA7jnH4Nn/pt+KdQ1ZClZkJJWz7yJu+cIrIBX
 cGn6EYYSXdD0VROl9MooJOU35j5nEL+FEVgmgZgcmaJkYWBf3H1WiaCgRPQ36Vv9MScMz2976oh
 0ptIERKhMkuKWbhiJOB7kvw26Kp/oLkZyKJMf4nun50bFuPM79Wow58sPNkfPq7EckaYvuW+4VS
 pHcfCyfoAwf0IeOhxWuwaToXZiAgeBF9wHXIkV0ItXB3R7K97g==
X-Received: by 2002:a05:600c:1e1f:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-441c48bca2dmr64706365e9.12.1746438202945; 
 Mon, 05 May 2025 02:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ3GUXpiJthmDDDEQF60H/IjLSe5hJPj5F98GAzGsXNvWmiqXVgd61P2IgLlpYdux2MWtKFA==
X-Received: by 2002:a05:600c:1e1f:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-441c48bca2dmr64706105e9.12.1746438202560; 
 Mon, 05 May 2025 02:43:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm125931625e9.20.2025.05.05.02.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:43:22 -0700 (PDT)
Message-ID: <ead3ea8e-4ce3-405f-9702-21e4f1331faf@redhat.com>
Date: Mon, 5 May 2025 11:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] aspeed queue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250505090635.778785-1-clg@redhat.com>
 <3031f1d7-b842-4fee-adde-89a9e824ee57@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3031f1d7-b842-4fee-adde-89a9e824ee57@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/5/25 11:35, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> On 5/5/25 11:06, Cédric Le Goater wrote:
>> The following changes since commit e578dcc7e1590b20a84036afe5bdfa8d23a6048e:
>>
>>    pc-bios: Add AST27x0 vBootrom (2025-05-02 09:47:14 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/legoater/qemu/ tags/pull-aspeed-20250505
>>
>> for you to fetch changes up to f32ef57f7de98ec36da52b0a13bd5d18ac4bd583:
>>
>>    docs: Add support for ast2700fc machine (2025-05-05 09:42:16 +0200)
>>
>> ----------------------------------------------------------------
>> aspeed queue:
>>
>> * Fixed AST2700 SPI model issues
>> * Updated SDK images
>> * Added FW support to the AST2700 EVB machines
>> * Introduced an AST27x0 multi-SoC machine
>>
>> ----------------------------------------------------------------
>> Jamin Lin (12):
>>        tests/functional/aspeed: Update test ASPEED SDK v09.06 for AST2500
>>        tests/functional/aspeed: Update test ASPEED SDK v09.06 for AST2600
>>        tests/functional/aspeed: Update test ASPEED SDK v03.00 for AST1030
>>        hw/arm/aspeed_ast27x0: Rename variable sram_name to name in ast2700 realize
>>        tests/functional/aspeed: Move I2C test into shared helper for AST2700 reuse
>>        tests/functional/aspeed: Update test ASPEED SDK v09.06
>>        tests/functional/aspeed: extract boot and login sequence into helper function
>>        hw/arm/aspeed_ast27x0 Introduce vbootrom memory region
>>        hw/arm/aspeed: Add support for loading vbootrom image via "-bios"
>>        tests/functional/aspeed: Add to test vbootrom for AST2700
>>        docs/system/arm/aspeed: move AST2700 content to new section
>>        docs/system/arm/aspeed: Support vbootrom for AST2700
>>
>> Joe Komlodi (1):
>>        hw/ssi/aspeed_smc: Allow 64-bit wide flash accesses
>>
>> Steven Lee (9):
>>        aspeed: ast27x0: Map unimplemented devices in SoC memory
>>        aspeed: ast27x0: Correct hex notation for device addresses
>>        hw/intc/aspeed: Add support for AST2700 SSP INTC
>>        hw/intc/aspeed: Add support for AST2700 TSP INTC
>>        hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1 SSP SoC
>>        hw/arm/aspeed_ast27x0-tsp: Introduce AST27x0 A1 TSP SoC
>>        hw/arm: Introduce ASPEED AST2700 A1 full core machine
>>        tests/function/aspeed: Add functional test for ast2700fc
>>        docs: Add support for ast2700fc machine
>>
>> Troy Lee (1):
>>        hw/arm: ast27x0: Wire up EHCI controllers
> 
> If you ever have to send a v2, please remove the 'Change-Id:' tags.
> 

This is a Gerrit trailer AFAICT.

Why ? is it breaking some tool ? Can't we keep such reference ? If so,
I'd rather fix checkpatch.pl.

Thanks,

C.





