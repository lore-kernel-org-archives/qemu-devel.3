Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A47FC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 06:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZmhw-0005Pl-4b; Tue, 13 Feb 2024 01:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZmhu-0005PE-73
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:55:54 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZmhs-0004S2-Mg
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:55:53 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33cdedb40c4so37023f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 22:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707807351; x=1708412151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qDA115RBNnbaoapaA3ctGFVN7qT4fmp/58Rp9s8Cipo=;
 b=xiKoTcMsyg690AudgoOrFOGTMzWe7SSvaT/gDxqCq68HDxuVCtdpeX0DIXcTa5Wo7r
 /ioTGBicgwvbU6VtrjSjoefI2Hu9HK8xzFt+ezwm49heHRaArJsHJOxXjk3zcoBxE9TC
 MZ8rOnOCRHkOeYuXBUSjSo89kFvDkPklWK1P7mjCrCrJBcw8UkKGeXe093jLnxLuIbs2
 fQZIRTXFSQHRClPThgJtB52VZd0H23owxz1Vsm+cSa1do+VN/qR1BAL50Gy29jjTZX+1
 ixsm3lGFR7xvgGD16mwH23vbIQXVw5oJW2NjVok/4nOUbGxQLJLeDb8dldhLtHfv2TVB
 +9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707807351; x=1708412151;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qDA115RBNnbaoapaA3ctGFVN7qT4fmp/58Rp9s8Cipo=;
 b=ZHnyU8ciPEzdaEsDDiikoSkH5y7/N4FJT/p460RMAa2P6b51QU0stBx45mc5eJCn0e
 mUuh1UCcyJ44Oo0EmuCEkqieVISxZlmJnW93JpoCTYcFAcfo/ukfjRhtc/H3JcCI5vq3
 Cj8RZ9iSFm3nOy8IRtElqBTlAWMERaU3iY9odBazUSUt6duJNpvHJtoZnzbLwPPjrgJ5
 Sz8oz7f0a/Nlu87AIuWbxJoZYjnvvA0sfLJ4wzI8gVQpiFkBBcUgGqbzvusYN1epq5X/
 EgLcGi2eUZMsfdJ9EyUnLppHYxxwl7PlVVmLD1BOF9lEeOIV+BgKRkTQNmlDN6MhKem1
 gPMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOdSvfTFGE5ORHU9JU06Ui1VMg6i+9ig69eNBbK97IOt/kIFITOdV8QWBF3P8NM/zTYcTXkGHsEEzuBEg77ej9OWISZS4=
X-Gm-Message-State: AOJu0Yw+RHHdOSFcbYbKcjjSXUT4AloRN+cEE/edyAz0+rFUXh0HSxyX
 +U7fLTzifxx0kLau1b3JoUKHrxEFu2SUjvGNkK1FFQu3UVZkvkUsYNFL90jj6zXrEKI9f3/biZx
 U
X-Google-Smtp-Source: AGHT+IGkOiOZsHXLUDz+nAjkXQBDTS55StqrtiSpcY+aed9EzTMCif6T1EEBSZA5wlAs/wISJuWFoQ==
X-Received: by 2002:adf:f1cf:0:b0:33b:3b00:520d with SMTP id
 z15-20020adff1cf000000b0033b3b00520dmr5945528wro.51.1707807350893; 
 Mon, 12 Feb 2024 22:55:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWcM++vrU7h9PoCNUJVkxq29yWM0l02ky1knR6TRU208g/SF/N+Gg2zWqV9X0VK76Qgy8ikfZoE5ZlOxv7v/89+7K3YJr6/FJai1PW1KRUlvNNNcGEYrtDy+/G6elqZ
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a5d595b000000b0033b80a0d002sm5338566wri.57.2024.02.12.22.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 22:55:50 -0800 (PST)
Message-ID: <4c4fda8b-2a0d-46c8-b965-49a4e6533634@linaro.org>
Date: Tue, 13 Feb 2024 07:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Move memory_ldst.c.inc to system
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240209000505.B07D04E6049@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240209000505.B07D04E6049@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 9/2/24 01:05, BALATON Zoltan wrote:
> This file is only used by system/physmem.c so move them together.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   memory_ldst.c.inc => system/memory_ldst.c.inc | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename memory_ldst.c.inc => system/memory_ldst.c.inc (100%)
> 
> diff --git a/memory_ldst.c.inc b/system/memory_ldst.c.inc
> similarity index 100%
> rename from memory_ldst.c.inc
> rename to system/memory_ldst.c.inc

Patched queued, thanks.


