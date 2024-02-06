Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E82BC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGwg-00032S-E9; Tue, 06 Feb 2024 03:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rXGwc-000328-7H
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:36:43 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rXGwO-0003ZD-32
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:36:41 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6da4a923b1bso3529827b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707208585; x=1707813385;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XtM2teapT+8H3TtHYJzAZGEad4e2YOvlPlxXSHiZTuw=;
 b=QKRPfmdQxO5+mUNnsTJWnxCCThW6EztBpfXD4OmpJmvepxxe6OuBPSG3T14TACKkse
 rd3nyptyi8dzO2YFHptM7D9/9PsSAl0nErWKO0KX4M+ZpEWccqQqmhPxCMjpOG/Zwrza
 T4rmnMNsX+/9grhfVisQawYtEJSAAlGDl3zhk3CUzKRuaEPXNjtHJgzVFey+PHwAzM8A
 +tUfzWLiVAYCIk3NRgoVdInMQV3s2pj2/A0nOYTJ0axNdcX0yAdVTBTqK0dpu/nP4gr9
 T50McLlc4ETsgo+tKYtm1DzifD+rmWenGwIcB+2OOBBzLRXMcAyaAsbOzU3yn4GvHdfF
 GX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707208585; x=1707813385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XtM2teapT+8H3TtHYJzAZGEad4e2YOvlPlxXSHiZTuw=;
 b=H0cTEXgFITgQPzbEONcXj1nH3K+t7H4Ff1KV/Gt3TDyAzCTmu+plGYw6lbRzXv31kO
 ozBBTqPMWnQXMNxmAExchh2oi9DPiyb/WLI/2tFGFVtB9pRrLbKaq57kBj6ahgHpKEdR
 Qdua653kwaNAqHaI5uJA60jOHqGstVajinTvfzHpNSWALKaRubuRDQPw09CdoF/95W3a
 qsFbrlySWzgRA3LjB9bcNBSFJsqX6H8j61mrNIOS/NuCmxbuGqvfKl8NJvGNBYTm/kOY
 mvtCfULNc6mmRpOx9uWyb4cpFLhmAZ91L9GGoOpapeUSFpY/yf5MuMuB5qPCYq/0ZpRZ
 sRXw==
X-Gm-Message-State: AOJu0Yyy4BT0WyB6wHjGCBPA9ZDf/quVzgKQuGlNtZXp4pfopDQDSCf0
 TsKp+GT0rUJcBibcNE3okmjRX/peW4LWJxNrt7VmoUt1haSL9ji6uMeuWqSkFCw=
X-Google-Smtp-Source: AGHT+IGdtl/gQ/3zR3nzyMJ0HIsDpu8aUDKqugpKyxhQl8lzLCOY330miHo9NCXYJ6QHzRq9+1JM/g==
X-Received: by 2002:a05:6a00:4bb5:b0:6df:f641:8462 with SMTP id
 kt21-20020a056a004bb500b006dff6418462mr1771779pfb.0.1707208585232; 
 Tue, 06 Feb 2024 00:36:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXtHYg5DQHdGPuoRSCBvrGdfykcwhKlAx4+8kUyLVjm2YRH3ZO286PmpD4gwS39xRtCL7ozv1voeOyqt94reFXn3WuhESs0EWlp/q6vfC4M1nyF/bdiwYBqJ3IBmsjBeBUj22g5b2yyqmm6qnPjhc6PnIvpAM4x1FH6OneDQM2JRkhE8rftJ2UfKX5hsrIo22QbwPMTTxUrbT1IVulgHrlBYNQ3a+ElrnRmy0sQFC9N8Q0U2WrKLCD2oi/AS+mK+dtZrHwadJi4/+0MZRugDiyxtgrzImc8mmbJ424aCkmkdat51LaQrbdpS98WA8Ne50XTyXD6luN2osK3WrGDu7dvgsVsUaWht7m9PeJUHeN7F9l4FVD+mGNWErDuql6Zlf2KS+fiEMKxWD6LzDVrGpWpyHNyl4/WlUv+6nWJMPbxSyg5rwKIjaIrrs64PbNMz+u57JsJlVmZkWWSdlyJL0Y=
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a056a00098b00b006e042e15589sm1259676pfg.133.2024.02.06.00.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 00:36:24 -0800 (PST)
Message-ID: <0ce6ef8c-1ea3-4f24-9998-c76ed6016cb4@daynix.com>
Date: Tue, 6 Feb 2024 17:36:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/3] gdbstub and TCG plugin improvements
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240203-riscv-v11-0-a23f4848a628@daynix.com>
 <87bk8xpzyl.fsf@draig.linaro.org>
 <b34c4013-1aca-466e-b94e-55d9802928b3@daynix.com>
 <87zfwhodit.fsf@draig.linaro.org>
 <7fae3d1a-5af2-4557-a2b3-13b911e73382@daynix.com>
 <8734u7gsv0.fsf@draig.linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8734u7gsv0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 2024/02/05 18:31, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/02/03 22:58, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2024/02/03 20:08, Alex Bennée wrote:
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>
>>>>>> This series extracts fixes and refactorings that can be applied
>>>>>> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>>>>>>
>>>>>> The patch "target/riscv: Move MISA limits to class" was replaced with
>>>>>> patch "target/riscv: Move misa_mxl_max to class" since I found instances
>>>>>> may have different misa_ext_mask.
>>>>> As this is re-based on Alistair's riscv-to-apply.next tree I'll wait
>>>>> for
>>>>> this to go through the RiscV trees and then re-base the plugin patches
>>>>> and dropping the merged riscv patches from my tree.
>>>>> In the meantime feel free to review:
>>>>>      Message-Id: <20240122145610.413836-1-alex.bennee@linaro.org>
>>>>>      Date: Mon, 22 Jan 2024 14:55:49 +0000
>>>>>      Subject: [PATCH v3 00/21] plugin updates (register access) for 9.0 (pre-PR?)
>>>>>      From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
>>>>> For:
>>>>>      contrib/plugins: extend execlog to track register changes
>>>>>      gdbstub: expose api to find registers
>>>>> So I can add this to my maintainer omnibus series for the next PR I
>>>>> send.
>>>>
>>>> I added one trivial comment to: "gdbstub: expose api to find registers"
>>>>
>>>> "contrib/plugins: extend execlog to track register changes" depends on
>>>> "plugins: add an API to read registers". The comments for the patch in
>>>> the following email are not addressed yet:
>>>> https://lore.kernel.org/all/4b2156ed-688d-4617-b52d-200413f01156@daynix.com/
>>> I don't think we need to serialise with the BQL as the structures
>>> are
>>> per-CPU (and created on vCPU creation).
>>
>> qemu_plugin_get_registers() has vcpu parameter, which can refer to a
>> different vcpu the caller is on (or the caller may not be in a vcpu
>> context at all).
> 
> It should only be called from the current cpu context. We can either
> assert that or make it implicit like qemu_plugin_insn_disas does.
> However we will need to ensure current_cpu is set before the vcpu_init
> callback.

Then that should be documented and the vcpu_index parameter should be 
deleted.

