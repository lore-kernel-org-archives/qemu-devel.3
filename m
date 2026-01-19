Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD065C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 02:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vheYG-0008DJ-8Q; Sun, 18 Jan 2026 20:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vheYB-0008BE-FQ
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:59:27 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vheY8-0000xk-14
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:59:26 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f47610542so1870735b3a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 17:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768787962; x=1769392762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ejEpgVMEKEP4ZTgg/wQBUipcq6PgSyPt+DJ0DGSJB0o=;
 b=D29AoEcpLsosegHzDVY4Nn78SNj60SjNeDfxVWaqKY3y3q3ksgh0oIBrif9gG/1sjP
 eL2P7FEjBdlys3teMejSvyTqyApuf19poz70LhTzCtYfKaZWKHzDdtzVSBm7w5XekaMq
 IGbIeZeOynhtbkGMqLTamLRkH0y9mAnSptkRvXXtj30cd5zIOYKOCcQR6iXED2qvLxiA
 7kd0ERlyl0KrZRsQbuophnAnOLGYUEWYBVCZLNk9igjadGp9ZC9tMmE2UDH5yH160Yz6
 5xSmcTXkSwQDY8qSuah0R9CySlz4Tgoqgz0s6hIzPmyVbUeqOpAKacqPmBRxDU5yQaxj
 hjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768787962; x=1769392762;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejEpgVMEKEP4ZTgg/wQBUipcq6PgSyPt+DJ0DGSJB0o=;
 b=aR46mkc1CtpU79enwGjVyksqqZVOSTqk6UVH2wazQ5qFKiYqLETZQ2CRr6s0USYkz1
 w3As1IaS/Mhu99FvL5Lg3kc2X5frTL0ZV+HsAcldGI/WoLOd8Dr0CF39aV+WBWR5h8e0
 heGrhk5+g/ZUDr1Wc1Q3YX00J4qiBCznPnz8rmqGfnnLDC+ZpTAW8GLdEkjpKjqVficO
 WAvqyicyTuePMqjemoD8awCKRDoSder8/Q+xl6pIhAS7d9Owr9UrDrjj38lhbcofgpWK
 GzpG8LpQX54RpPG1oWjpBOD28odzUHcXeHfyMdmW5tWIswyDoEWhVl3etGpqhNcHbY5w
 2GiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6oXKu1ZdHNEDtyzWILcdnIFVjlM4BVlv/heTkSVljpzXNd9aiqpQiUv3/gmxlGtTarruziyqtaYFU@nongnu.org
X-Gm-Message-State: AOJu0YzJS7Vf7I8Vh6+539mp7GDBIG15JnZ/t8BggpIkflppRq1pvk1t
 BnJkTwPEpvuYI6rG4C6EmXe+aLs8VOsjrZgmGN43Grl88jGUBLfvMv/m7qTAsxQAOsM=
X-Gm-Gg: AY/fxX5izbW/yFx+hJ2ngE8eEN2KIbRhs+tGGtohibVHUGNWjkZ0F5iVvpItZlJ//ao
 aLWNUEhswCHRXVsSz4kC8Xsv3YGC2xliyZryQsLV+MBGdns/iNyTeEtjeldkCLPRgjIFYO41mEl
 t0lo0JqVTZ1r0LZyKFvxhTO/FGPnbYVwBpHzDDz37pnyi4y01VKIdSxSmypXArIXaTTcLAD/5ZY
 lasesmslM5UC/aNvymsvCogitw4w1J44ZAlVhNdQL7ZAxpq5I7I0qKIsaUOVMB8mY22Pb5KZUtF
 8FoJ80B6b18fTBiNYP9eRQlDlVnFjUHjed+JDnfCkzQ1rKQEb6qFSyBSFznQQmw1A8UMJIYH331
 KJnVHIn7Dc/UBpDHatGrhhSjt6zB7dkgTIqUGiYywLuJQDj38nOEUGYTdqyHYgntl50VMtaG/Rm
 f8+YlkwVZOSm5PSzPVr9w84CBbG95+97k3vTa5SRIpalk+HUxAWdYKdMrJPl7N9LTGqGE=
X-Received: by 2002:a05:6a00:3ccd:b0:81b:afba:506b with SMTP id
 d2e1a72fcca58-81f9f68ff51mr8686259b3a.14.1768787961666; 
 Sun, 18 Jan 2026 17:59:21 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa10a03ffsm7536078b3a.6.2026.01.18.17.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 17:59:21 -0800 (PST)
Message-ID: <dfb3afd3-af50-4a14-afe4-fddd8adc5040@linaro.org>
Date: Sun, 18 Jan 2026 17:59:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
 <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
 <0458a52c-b86b-43e8-84f6-ec75b012a9a2@epfl.ch>
 <3d9c9fbe-711c-4be1-84f6-5fa3cc18d2a8@linaro.org>
 <9c71b7dc-ec43-4726-a868-c1c3a3ce3ba1@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <9c71b7dc-ec43-4726-a868-c1c3a3ce3ba1@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/17/26 9:51 AM, Florian Hofhammer wrote:
> On 16/01/2026 22:39, Pierrick Bouvier wrote:
> 
>> For sake of consistency, we should make this use the same interface than
>> {read,write}_memory_vaddr, minus the len param.
>> bool qemu_plugin_read_memory_vaddr(uint64_t addr,
>>                                     GByteArray *data, size_t len);
>> bool qemu_plugin_write_memory_vaddr(uint64_t addr,
>>                                     GByteArray *data);
>>
>> So it would be:
>> bool qemu_plugin_read_register(uint64_t addr, GByteArray *data);
>> bool qemu_plugin_write_register(uint64_t addr, GByteArray *data);
>>
>> This is better and unambiguous, as no one needs a documentation to know what a bool return is, and data already holds the size information.
> 
> Sounds like a good idea. This would break existing plugins though, is
> this acceptable? (Asking purely out of curiosity, as I'm not familiar
> yet with the processes and policies around breaking changes in QEMU
> development :))
>

As long as we bump QEMU_PLUGIN_VERSION, this is acceptable.
Of course, the series will need to modify existing plugins to use the 
new signature.
It's a bit tricky as the bool can be implicitly converted to an integer, 
but it's worth fixing this for coherency sake with read/memory vaddr.

>> As well, writing this, I realized that existing write_register is broken by design: we never check the size of data array (except > 1) and blindly an arbitrary amount of memory from it, which is wrong.
>> Even though the doc mentions it, we should just fix it, detect when size < reg_size, and return false.
>>
>> This comes from the fact gdb_write_register itself has no notion of size and trust the pointer. so it would need another refactor also. And while at it, change gdb_{read,write}_register definition to return bool also.
> 
> gdb_read_register already takes a GByteArray, it would make sense to
> also use GByteArray for gdb_write_register instead of a uint8_t* and use
> the size of the array for sanity checks.
> However, I'm not sure changing the return value to bool for those
> internal functions makes sense, as other parts of the codebase rely on
> the size information. E.g., handle_write_all_regs() in gdbstub/gdbstub.c
> relies on the size returned by gdb_write_register() to know how far to
> offset into the packet data it received from GDB, as GDB does not send
> register size information when writing multiple registers via a 'G'
> packet (just a flat byte stream with the register values concatenated).
>

I don't want to put the burden on you to cleanup all this kind of stuff, 
so you can simply let the gdbstub refactoring out of this, and fix API 
plugin only.

>> I think it pushes a lot of changes just for a simple comment change, so I would understand if you don't want to do this whole refactoring beyond plugins interface. I can pick it up, or let you work on it if you have time/interest. Feel free to let us know.
> 
> I'd be happy to handle this!
>

Thanks for volunteering!

> Best regards,
> Florian


