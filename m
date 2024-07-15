Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F1DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIkb-0000M3-12; Mon, 15 Jul 2024 06:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIkZ-0000Ee-Bx
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:16:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIkV-0003jF-HX
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:16:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266f344091so29587785e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038562; x=1721643362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gBoXw474cZVG0t4JzbNBGYVZw7NPLwpf9qGY3HhsKNU=;
 b=K7cNz/mcN8IHsBDw3+kIfn9oOTmS97lh4f+/cHeTneNQoBcyp0YdfodKa28hNkksMN
 H6VNLOXG0UoCQ1cXfcS8S0oN9neNU1qalEwYntOagLvcDHUGhTv5n4ndqKUhkOSZ16fV
 n8RoGLLL5W9wncUTSiDeQeoVx2KdQB7nG1pt/WE93xBwLahbGBBsSeVF/lrLPGAjvsuH
 9KV+m5EtCOk/+dXi4bmaWNIVUj8JnNUI0x7iG2z2my1VxvRorH41eBCN1jpBC8a45mgz
 VZSnqANlV4iw23HYD0KzF+2NHDteaWj5BMCK12cJLjfLoMtLRuQa/Tnv2QD1jhth3Vst
 QS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038562; x=1721643362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gBoXw474cZVG0t4JzbNBGYVZw7NPLwpf9qGY3HhsKNU=;
 b=dxZZ4TkK1t/YwlJGu3JMMSSXgYBWvYBP2YPlL4o0I0bCzlSgrlDNnaQn3S7ruIjQ44
 GIgS67yM/NMIpS0JaS3WVRKeqoDOH3x5PswDIirF3nie34mOFVagQbbPae/wprew4Zih
 gjlmKvmU6wNd74GP/qe5jbfdm46RL9Nd2KPj/YgqCUPFSS9GlD2JS+n81xH/ICHeqeCL
 kSU5Pm4L/KZusqBXNibMwMCP8O+q0rWJ8Jl4WhB/hJ0HlzHdgu+3vinRvG2ws6mDNxFz
 ynwrvUPTziQTrgb276uOjgtfQrg0GRPC0Am2+trkdQHnHOFD8ib5p9Yu1t5Vkh+c4X60
 Pi7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlAEuwgp3ZtSvlLIIPWGWNgnQ1Mb6Jq+5Uxef5l1P4tghydFmFk5LgLKg5nwKZVNh2tLZulwKgL4kvkc7YVowx79TZEPA=
X-Gm-Message-State: AOJu0Yw++l0UAkypSOCFa6uXSjiFcktnKl9W/G4LM+ayTMNpUH1K7xTd
 yNjy1bXsYEmEarRrrEoBYGZ/f1JxvZ6WpI+8NRpwkJvWDqKHMN3aFsrfZo7OoVc=
X-Google-Smtp-Source: AGHT+IErbDHMGpb1KHVkt5cPfGYd1J4dXPMFqG/ROO25Tnw25BZH1jJSYrktOdllQpxSb1z7NmqGEg==
X-Received: by 2002:a5d:64ea:0:b0:367:99fd:d7af with SMTP id
 ffacd0b85a97d-367cea46bdfmr13524757f8f.12.1721038561712; 
 Mon, 15 Jul 2024 03:16:01 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3b2bsm5905233f8f.20.2024.07.15.03.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 03:16:01 -0700 (PDT)
Message-ID: <d265e18e-6ef4-4199-aa0b-9dbdfd8367da@linaro.org>
Date: Mon, 15 Jul 2024 12:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] hw/intc/loongson_ipi: Fix for LoongArch
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20240627125819.62779-1-philmd@linaro.org>
 <05b70832-b1a6-4a6b-87f6-373f02fbbb4e@linaro.org>
 <7cdc52b8-27e3-7580-a7a6-9cc77dee41d5@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7cdc52b8-27e3-7580-a7a6-9cc77dee41d5@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 15/7/24 12:08, maobibo wrote:
> 
> 
> On 2024/7/15 下午5:57, Philippe Mathieu-Daudé wrote:
>> On 27/6/24 14:58, Philippe Mathieu-Daudé wrote:
>>> v2:
>>> - Only skip mmio-related code in loongson_ipi_realize()
>>>
>>> Jiaxun Yang (1):
>>>    hw/intc/loongson_ipi: Gate MMIO regions creation with property
>>>
>>>   include/hw/intc/loongson_ipi.h |  1 +
>>>   hw/intc/loongson_ipi.c         | 16 ++++++++++------
>>>   hw/mips/loongson3_virt.c       |  1 +
>>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>>
>>
>> ping?
> Hi Philippe,
> 
> It is only temporary fix, in the long term we hope that interrupt 
> controller emulation is similar with other architectures in directory
> hw/intc/, and we post the patch at website:
> 
> https://lore.kernel.org/qemu-devel/20240704033802.3838618-1-maobibo@loongson.cn/

I missed that, thanks for pointing the series.


