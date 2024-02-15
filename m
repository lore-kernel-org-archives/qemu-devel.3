Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DD1C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 07:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raVox-0002u9-0O; Thu, 15 Feb 2024 02:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVok-0002sh-5M
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:05:59 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVoe-0002u8-TX
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:05:54 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a3d5e77cfbeso99475866b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707980751; x=1708585551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MauyxcePfJj3YOlYKshR6Vvib9BaZ9515wf3wdU5bqo=;
 b=Wl2bkNbtqjcLPsA2GbwWcoJkkDSIr3mVGGkZ2Wv2KErywmxV8/z0m52zVtBpQGmu3d
 O6t68N5p99zu0L4AIjC5sTr0en1Y5h6xZXthHJAy+xpvgnrJTgUQl5E2jR0qiKqKVwbz
 CwPj6h+8gOQpdiol3Mbiv+gjrwCKttVadjVNKpnS9Lk7vXUgzWUtbhNz+GNDDmfLvSqb
 fKWYq/rY4BWNXA+OaCwX23vD6TZSsljEACuWSduOzaJ9zDdlmGDNAZ3Z4IsIHwSK8Tyc
 ppHxum1gsPKakbsNvkLxUGEBEAvaTvJRKKZmSm4zjDASvW3faddkMBcW6JeKiDm6FNvE
 hujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707980751; x=1708585551;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MauyxcePfJj3YOlYKshR6Vvib9BaZ9515wf3wdU5bqo=;
 b=iYAl0MnamU77102F3RkP+u4RH4xOV4W1lKpzlAtSfokI6BBhTNjcazUiVVT08BN1my
 cQXDVdcs7mWZhR3xvgp2m4VJwSgSv8P0zs02f0h5viYC1FRrXESoBmhBEXnk+8fH/hkA
 V/0pJOOZZ7lTD9w4IGzfONahJGK/OzfS5zxRJWvaNBr4DgLhY9U0RVuyOBDdSzun98EQ
 aGhnqINtLYthKZvmPAWQyHY/TWuk70Mro2YCZlNgBOOOAvDhatGPY8ujNa9d8kK9BDwB
 PLzpyzBeFXuAwPRAHrFGTtEkjj+qfzy7jhOldMO+10fG3rEy6Y+sl0CLaQ59CeBYEFel
 uAfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/QAxudrbgNTkRsb4cV0ng1niQijJALXwbKgUYQw39I1FMdXhmHaG8IBI7asCJfNHsLaaxJzyWAwMUw1xfN78qAlgZLII=
X-Gm-Message-State: AOJu0YwlrIoDLhoqnHKlro492vu+9zjR3h6XIiARdUpX9PaLjtvyIBaz
 ELMqxnDo483xBsspYV+By5xzOo0EQwaV7QJg7z2ny53tECyedwKaBwQN2sWrhwM=
X-Google-Smtp-Source: AGHT+IEZtpXdWa4i4Tdnqx4cnGiSL+Zt9vjPAkVMO/v/hG0njssaW+r/0q3wpXpKG7TWK81witZuHA==
X-Received: by 2002:a17:907:7e86:b0:a3d:6c76:bbc7 with SMTP id
 qb6-20020a1709077e8600b00a3d6c76bbc7mr2765858ejc.21.1707980751591; 
 Wed, 14 Feb 2024 23:05:51 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 vk5-20020a170907cbc500b00a3d60daaa72sm253766ejc.41.2024.02.14.23.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:05:51 -0800 (PST)
Message-ID: <57151544-520c-4f7f-bf5f-ffd8cdfc4029@linaro.org>
Date: Thu, 15 Feb 2024 08:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/36] linux-user: Use do_munmap for target_mmap failure
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215062018.795056-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 15/2/24 07:20, Richard Henderson wrote:
> For the cases for which the host mmap succeeds, but does
> not yield the desired address, use do_munmap to restore
> the reserved_va memory reservation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


