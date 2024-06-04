Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3543FC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 11:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sESTu-0007US-0h; Tue, 04 Jun 2024 07:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sESTr-0007Tl-IU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:37:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sESTp-0002Bn-CA
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:37:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4214f803606so4692165e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717501047; x=1718105847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MUX998iWCChjlGS6B+TkMOROy9BE7bQaY/bIWZqEfX8=;
 b=V0YbT79pf6EFrS11wCR3nVaxUmTrJSup2b/D/Olo3xEMpfwUznRFyqJcPh1yLLo90X
 3QW9oLWqMQJUOCNcsmM2nx0Gq0O/TG8zPcaLrwPIcVyfMWtr/xK4AjEbcWQ07DcdA41x
 4gtZpGjWfB1L2QEO8PDGKH5aNGB71aydaYToMT1+2Moaasudk8nv02rwbjCB48bjDH6W
 TzNWTNo6WWz0pkmM1HSukXb5GnDqfnX37LqTMcoVqpQua2ezEcJwYBFI8eC5jePkL1V6
 aMLIdnupML8fmeLkYzZ6yUm6/53RO+HD6y4mBqgEe74ERZwiLaytoazsu1CellOnyszY
 b8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717501047; x=1718105847;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUX998iWCChjlGS6B+TkMOROy9BE7bQaY/bIWZqEfX8=;
 b=nT2grlyzg60LwLaekIBqhAi0Yp1+19qcipV6i5NcCaGmLFMskURpxQ7QB/IFBs6Yc3
 njTa17CWdz5wFfmZgqhxJKgIrPtRisjHLk9T7HJq5nHPX5dLep5A81u1mxDm4UX3OUPe
 8vC4kph2Vnv1VBp1NQ4bcMhx9z7eNVigSlzK1dT/6/FRT1J/Snmo7ph4zjPkewjt5qNI
 BYsvMidK7ZGb9byKtL/1WL/CoeO2IyGeyBetKOoahIYmXf5TVBvzu0FzYG8WS4qaSs/1
 g/WXa5cncQmsPNDxx3DQ0z22z1fHKmMcX4nwb3D7Yt+eabApBGWwoVUkyCh6HVBV6L49
 FX+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+XMUntC9n8rRYpn4lgQhxa8hnQqjmpRMauJKHBcD4Z6F77R5TWKd7eOsvticGUNSszcy+YvyUxeEYvLETBNHr/wMrkfw=
X-Gm-Message-State: AOJu0Ywsiw3RbhPSkEb7Hr/x8lU/+YttnOfpYKitc4AM+YoDfrLpgosP
 I7O2USP7BI+OKQ4lahKFSIge4telNd+K4D62+6ii7aVqttuAM+b5BOZ+1b9wSYE=
X-Google-Smtp-Source: AGHT+IF2Tr3sSu9+ocFAcxF4QiovorIIE3+tMBZ1sqj7V93IpdF8kX8X1BO42mqNYMQo9TfA1mT9oA==
X-Received: by 2002:a05:600c:35d3:b0:421:3979:8c56 with SMTP id
 5b1f17b1804b1-42139798e83mr53305905e9.40.1717501047290; 
 Tue, 04 Jun 2024 04:37:27 -0700 (PDT)
Received: from [192.168.234.175] (103.red-88-29-104.staticip.rima-tde.net.
 [88.29.104.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42127062f0dsm179683975e9.17.2024.06.04.04.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 04:37:26 -0700 (PDT)
Message-ID: <99810a53-eaf1-4997-8b05-17c63ca933e1@linaro.org>
Date: Tue, 4 Jun 2024 13:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?B?Wmhpd2VpIEppYW5nICjlp5zmmbrkvJ8p?= <jiangzw@tecorigin.com>
Cc: qemu-riscv@nongnu.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, fabian.thomas@cispa.de,
 Bin Meng <bmeng.cn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240514023910.301766-1-alistair.francis@wdc.com>
 <14e88990-963c-45ef-bf51-662d54857c6e@ventanamicro.com>
 <CAKmqyKP5dwLnvuXDbJkDV=CCGAsoVuyES7m+NB=7KceFEHoKzQ@mail.gmail.com>
 <681cf91c-dec7-44ab-91a3-efb6decc98e1@linaro.org>
Content-Language: en-US
In-Reply-To: <681cf91c-dec7-44ab-91a3-efb6decc98e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 4/6/24 10:32, Philippe Mathieu-Daudé wrote:
> On 16/5/24 07:09, Alistair Francis wrote:
>> On Tue, May 14, 2024 at 7:11 PM Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>>
>>>
>>> On 5/13/24 23:39, Alistair Francis wrote:
>>>> When running the instruction
>>>>
>>>> ```
>>>>       cbo.flush 0(x0)
>>>> ```
>>>>
>>>> QEMU would segfault.
>>>>
>>>> The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
>>>> allocated.
>>>>
>>>> In order to fix this let's use the existing get_address()
>>>> helper. This also has the benefit of performing pointer mask
>>>> calculations on the address specified in rs1.
>>>>
>>>> The pointer masking specificiation specifically states:
>>>>
>>>> """
>>>> Cache Management Operations: All instructions in Zicbom, Zicbop and 
>>>> Zicboz
>>>> """
>>>>
>>>> So this is the correct behaviour and we previously have been 
>>>> incorrectly
>>>> not masking the address.
>>>>
>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>> Reported-by: Fabian Thomas <fabian.thomas@cispa.de>
>>>> Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
> 
> Reported-by: Zhiwei Jiang (姜智伟) <jiangzw@tecorigin.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Too late since merged as commit c5eb8d6336 ("target/riscv: rvzicbo:
Fixup CBO extension register calculation") but Cc Zhiwei Jiang to
notify it is now fixed.

>>>> ---
>>>
>>> LGTM but I wonder if this is the same fix as this one sent by Phil a 
>>> month
>>> ago or so:
>>>
>>> https://lore.kernel.org/qemu-riscv/20240419110514.69697-1-philmd@linaro.org/
>>> ("[PATCH] target/riscv: Use get_address() to get address with Zicbom 
>>> extensions")
>>
>> It is the same fix!
>>
>> I somehow missed that patch at the time. Sorry Philippe!
>>
>> I'm going to merge this one as it includes the details about pointer
>> masking, which I think is useful as that's why we are using
>> get_address() instead of get_gpr()
> 
> Fine by me :)
> 
>> Alistair
>>
>>>
>>>
>>> Thanks,
>>>
>>> Daniel
>>>
>>>>    target/riscv/insn_trans/trans_rvzicbo.c.inc | 16 ++++++++++++----
>>>>    1 file changed, 12 insertions(+), 4 deletions(-)
> 


