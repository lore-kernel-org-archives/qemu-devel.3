Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4253ED1CA21
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 04:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8BBW-0001le-2A; Mon, 04 Nov 2024 23:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8BBU-0001lV-JH
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 23:28:52 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8BBS-0004vA-Pu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 23:28:52 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso4453009b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 20:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730780929; x=1731385729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R7XFhbZEA7kKMuhA4Hczjj38g7HQvUvqrflWk6dcvY0=;
 b=hI+geKHnYLlYHDzt5FBIrTbUbuQUsdVgBTC7bhCXj3iDttBfPWpve74+sv0fH/hTmQ
 RXs+6+uknQdGzuPPI5XnN5+LsPRignz4kexoYFOiULVkHqBU3PMxEi4+0wPSS+TZMEj8
 GPI2RlVJIBSONAQaeVcr46BA8u6zagk9L7b3iDjuvtz7lR/Wp4PLb1VMxzkDlyTCVgzP
 6b2Ntg3TcsnDyBmElKZw650DvUQQuVYb5xdl+gVcRx3mXtLzsxOoFQsi9oP1zCzPMFaI
 gYe4WGvv30deeaFuyyvtUPFC42JRueIblJczbVaQvMOxC2+23vVblvUpldbeBrat8FzF
 waTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730780929; x=1731385729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R7XFhbZEA7kKMuhA4Hczjj38g7HQvUvqrflWk6dcvY0=;
 b=oZKbCmUBD7Tydfy5H0NxVzcRmRDhtGCNi2L1BqfzH4HebwN7KNv6TwM/PLk4nDUBbG
 Y+iuVCxd9vWt01xtT1CZRL+/WuvHIkiyHPFgZsINWM0az5ryjrZG3l5tCw6ECeYxrAXp
 WE4Cd4z6nDKbu4v7Bcc4gXaYSOzGG/lufulOkP2R2v8fin+DocYOn+kcxNV7IpE68HSN
 SAN8y/wJwEvMrk91kJw/v3wlV5bSj7LCAjSIY/l/yrX9ksP3dBxvVLawXa6RltV3X3eB
 59cKsRthfQNP99KoBZ/cI1Mj6LCAv0VADn6V3TxlbxkwzaReEAX3XDfyaCqyjRuXDUXD
 j3Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmxhcZeTIf2+yVa/bDMR5ZSHtz5EjoOIllhX2lLoSBrkpKn0EQOaK5IkMva9ljEdThtHjgaYgKLqJk@nongnu.org
X-Gm-Message-State: AOJu0YyaSqYS5x5QAYmiApKAdNlata0/sqoLXtMGLfMaN1+c6Ew2O5Qw
 YDmUuo3mU+ubEX67KAZTzOwDIDMSxixA25Nz7iyVohh2SbsSPFdk1meFsi8/Pc0=
X-Google-Smtp-Source: AGHT+IH02JVPyqilzdAa6zvFzFZkraoJnDeYiLumSc2ASTVo9zqwxs05K0Pp8l8dbLFXKCRS25P5kg==
X-Received: by 2002:a05:6a20:7f86:b0:1db:ee36:8fb4 with SMTP id
 adf61e73a8af0-1dbee368fd4mr3766719637.3.1730780929013; 
 Mon, 04 Nov 2024 20:28:49 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb699sm8527394b3a.167.2024.11.04.20.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 20:28:48 -0800 (PST)
Message-ID: <e9dec598-1ee3-4cf8-b6c9-f9fe07b48d79@linaro.org>
Date: Mon, 4 Nov 2024 20:28:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to get args passed to binary
To: Demin Han <demin.han@starfivetech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
References: <ZQZPR01MB1057EB3713C55BC9F53ADE5785572@ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn>
 <ec546d66-0ecb-4294-b8c6-a7f2c2a6e534@linaro.org>
 <ZQ0PR01MB106322463E0A1A23E750901285522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
 <5fe9698a-33e2-467a-a1e3-111946dbe960@linaro.org>
 <ZQ0PR01MB10634725F7B08B6684EEB36685522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
 <dbd64940-c21f-44d2-9ba1-0bdf25f5391a@linaro.org>
 <ZQ0PR01MB106328C5544D5AD7E3C00A2585522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZQ0PR01MB106328C5544D5AD7E3C00A2585522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 11/4/24 19:53, Demin Han wrote:
>>
>> It seems that you already have a wrapper script (qemu-risv64.sh). You can
>> replace it and read command line from $@, which contains the command
>> passed to it.
> 
>>>> In the case of llvm-test-suite, you can set TEST_SUITE_RUN_UNDER to a
>>>> wrapper adding a specific plugin, its options, and generating the log
>>>> filename as expected.
>>>
>>> We cant set TEST_SUITE_RUN_UNDER="qemu-riscv64 --plugin
>> /xxx/libxxx.so -L xxx".
>>> We have no any information about binary under test even binary name.
>>> We can get binary name in plugin using qemu_plugin_path_to_binary, but
>> can't solve the issue mentioned in commit msg.
>>>
>>
>> If you pass a script instead, calling the same command, you can get access to
>> command line by reading the content of $@.
>>
> 
> Thanks.
> I think this can work.
> Add a arg to plugin and pass the parsed $@ to it.
> 

It would be the most flexible, as you can do any pre/post transformation 
on input/output. It should provide exactly what you are looking for, 
instead of doing complex output in C in your plugin.

> Regards,
> Demin

Let us know if you found a satisfying solution.

Regards,
Pierrick

