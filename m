Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf04w-0008LO-TO; Fri, 16 Aug 2024 12:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sf04p-0008K4-J4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:45:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sf04m-0003eF-Lu
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:45:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so15294245e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723826717; x=1724431517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WvgsniRMNm+WbdoAwcgJKgrxH4vK43SOaJ12NKEvpmM=;
 b=wncFk/hc0jYa8orQWjjDbmKuWtYeq2OlbYXT8Ayhtx+3zRGvKtH6nu0SyUhxGcJ+dK
 dO70yx6IYp1Q/L/Ws6kueigvXlI8gciCtzxZ+cME7KK814TjWkMcix5s07dDEi/tUBPv
 CkOuhgfKs/NbGOyBQ9SSPcaychXpshzGDG8ZqYTSgKy0Gs5k5IM0+0KT0MlOzEzU3Olh
 dnvhrEz4xAehijfreSNTHGH/oK2ohWOGYz3gV5mNH9yjSuOJd1i+z8PSxSusgiN0kgmG
 1KhosXcIvhMtWtvQQwJBeRthu72QR8VmBNNFv2U393AxUgbfLbR8+/QJvMu4yg0urz1o
 GhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826717; x=1724431517;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WvgsniRMNm+WbdoAwcgJKgrxH4vK43SOaJ12NKEvpmM=;
 b=E8PP+KeCc5qXpka1hRnI8cu8mXeSxEwSsRrEdRNqaFAdtSma7yJxCqwchfrTc6qCi1
 7eyggpHKR2/uEWAkS6jPqMw1FpvADiQmCkHYXAz2/k9BGaW1YpZAwMw3s9E6zwqd8wT6
 nDEBWZZOrQVrohdBXMZ1GD+ClPmnGdvzy6A8dd0LGriAvxbxbOlsWdL6hsnt+uJ0k6Zj
 Zxi69/iPh1wCwjYXkQzUVBbTHFUaQFRJu5YtM6TgFDGd/NgbvAfCk8cbXXbPLXwWtyWY
 pi7mjPwgyveMidoU2fQ6l8+kPXl0213l9w/5PYN77skxLV6nvkkqfc24LGMkxrLBw/R4
 cr6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8j1Xk/SdFiSqZ5Q43LnmyXOlhRdK5xz/fun2l+zLujEPo/BoKkAjXTwa/kpsowFMEtQFVcP69WIo5pcFt7joS6vPt8uE=
X-Gm-Message-State: AOJu0Yx4OTzCXVV84sEGUM6FtLJQ9taJSPB6TTz/Gt48ZVdzt5mzPTlM
 Sl42Wx6i8ysUfMaxBxpRis+wM0SDJYK+JKa/vLyz8q0Q206tO1Bay9UxvMdLEO8=
X-Google-Smtp-Source: AGHT+IE6nGa+j04ds2YAQevEBcKfnweGwi88TZJopmcXGgva4gT0szSFLj/IC1vMaojHI2LtJdHr/g==
X-Received: by 2002:a05:600c:56ce:b0:426:6455:f124 with SMTP id
 5b1f17b1804b1-42aa7afda74mr4391605e9.0.1723826716435; 
 Fri, 16 Aug 2024 09:45:16 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed6507c4sm27240355e9.15.2024.08.16.09.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 09:45:15 -0700 (PDT)
Message-ID: <e190d050-7f63-4f7f-bce5-09b1cecac9aa@linaro.org>
Date: Fri, 16 Aug 2024 18:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 1/2] Revert "hw/riscv/virt.c: imsics DT: add
 '#msi-cells'"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Conor Dooley <conor@kernel.org>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 dbarboza@ventanamicro.com, Anup Patel <apatel@ventanamicro.com>
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-5-ajones@ventanamicro.com>
 <40c7abce-8d1d-4591-ab09-bbfebf1e1657@linaro.org>
Content-Language: en-US
In-Reply-To: <40c7abce-8d1d-4591-ab09-bbfebf1e1657@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/8/24 18:27, Philippe Mathieu-Daudé wrote:
> On 16/8/24 18:07, Andrew Jones wrote:
>> This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.

Ahah sorry I'm not seeing well after a long day in front of the
monitor =)

>> Linux does not properly handle '#msi-cells=<0>' when searching for
>> MSI controllers for PCI devices which results in the devices being
>> unable to use MSIs. A patch for Linux has been sent[1] but until it,
>> or something like it, is merged and in distro kernels we should stop
>> adding the property. It's harmless to stop adding it since the
>> absence of the property and a value of zero for the property mean
>> the same thing according to the DT binding definition.
>>
> 
> This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.
> 
>> Link: 
>> https://lore.kernel.org/all/20240816124957.130017-2-ajones@ventanamicro.com/ # 1
>> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>   hw/riscv/virt.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 9981e0f6c9b9..cef41c150aaf 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -552,7 +552,6 @@ static void create_fdt_one_imsic(RISCVVirtState 
>> *s, hwaddr base_addr,
>>                             FDT_IMSIC_INT_CELLS);
>>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", 
>> NULL, 0);
>>       qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
>> -    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
>>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
>>                        imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
>>       qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
> 


