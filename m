Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB87C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 18:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvR7-0003y4-80; Fri, 31 Jan 2025 13:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvR5-0003xU-Co
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:08:11 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvR3-0007ni-PG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:08:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso16643055e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 10:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738346887; x=1738951687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G3AVK0pDblv3sKq/DkQHirVhosW04Sc/mVNJJ3T2l2g=;
 b=DigHIqbj/zbK3BpdlqiVIx+1N6zhHb0vl15qe8+3NygvXwiSsPiL3ozcqFlc3u/vtv
 TAWEWX4f+/GzPZpF5Pp3/hXEdACofpm6bARADz6g/jPYGfDnyXwOsH4qTM6PGCmyLA1t
 9CeiFbZMa5XTWa2XwWqgdZKZZUCjKEHLw/zmERJjEwC1HRTrO3ir3kKGkJ5t9d/IuKcz
 zmOrW5FtF+DndZ9L3cqevN1MPLXpjnUDW6QafjtsWheKRefh5hoai8KsZD2JIlPAVAD2
 BHfGvHwJqub5tn1iac98aViEFlqiZ3Sfj49EFqC0INbpZr1uwN0aMxZzFLLosd26J0L1
 JsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738346887; x=1738951687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3AVK0pDblv3sKq/DkQHirVhosW04Sc/mVNJJ3T2l2g=;
 b=gpwPVHfBASfX9VGu8FLL8Nv+ikYIZRPil5o+sTS5XNZ7TWasGjIaltXGKvgL/n9Bl0
 IZe6+960P/2YshYlTeATcHa6t5+8wl27lUIGIybx8QPy90dm1rH8Q68umAis3PrmUTcW
 SaYfk5pHfRTZFu0PEcwhhsNR0n561tSt6Fg/wNZYhD5ZLbr8EgcBmD5bkSp3ZMsJhrka
 4QVdoLcvJ7oaHhf3d375nokq7KWbNgpqXRDDNGSiP0oJbvw0cnN5E5yU6Kn/FGcUr3bi
 PLkL5BITgFRdmvWsEfqwnMAN6jICvP42R/VVSb1m1exnvoztXhiGXvXezuZiFv+bifbv
 NmeQ==
X-Gm-Message-State: AOJu0Ywj/Vsukvg3wN6TiedtWvbfwrNMOi9dtJHe+mZDRv10bRcXB/ar
 kARW++8Z9GPFhhRsFa4og41c2DECTlrpQeDwtIR4ZwexFhnQ0RE+m/p89TZV4ESnAZHACwaxxew
 lLQs=
X-Gm-Gg: ASbGncu3+YCZSXvXZw6k4tqXR4pNBMrQbc6Cp9LcQdAOkFS80qaSkjAbMTuoDHKzLyW
 XFnbh+xtMjW9GeloeZU0D/9+CSDMFxFmdyFFH/euJN2bnA5C9lmjlWHp1T+4JAYVGx40/PF5rb4
 iLQkbXJHJHhqn3ohi9jdSkLroExOLRX1UTYN5uOa1rY7hlvgUexZmARfK0yq3D1CWz9pOvNJ9ks
 RRP/jOgi+J9HaiAOOZY17WiukhIn26dAoRhFO4/WzuxQHuaRjxnSfDnZQOezo4cRZ5xVfupbZou
 ONSyEEpuy+KEmRQUSELj2ZKvZYDnzVh4iaiazZnMncVobp9zSHqNKM6EU8U=
X-Google-Smtp-Source: AGHT+IGuJO3WEEVLjaNGS9gK/cK9idSxNhwbD2FcnU23ZTkdJ9O5vUNFd5FdvBj9D+5Vt0HNBQPL4Q==
X-Received: by 2002:adf:f382:0:b0:38a:41a3:218 with SMTP id
 ffacd0b85a97d-38c51e92ab1mr7803738f8f.36.1738346887048; 
 Fri, 31 Jan 2025 10:08:07 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b576csm5334252f8f.63.2025.01.31.10.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 10:08:06 -0800 (PST)
Message-ID: <7847f974-6316-41bd-9ea2-6d062f0b34bb@linaro.org>
Date: Fri, 31 Jan 2025 19:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] hw/mips/loongson3: Remove uses of &first_cpu
 global
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
References: <20250115232952.31166-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
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

On 16/1/25 00:29, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (11):
>    hw/mips/loongson3_virt: Factor generic_cpu_reset() out
>    hw/mips/loongson3_virt: Invert vCPU creation order to remove
>      &first_cpu
>    hw/mips/loongson3_virt: Have fw_conf_init() access local loaderparams
>    hw/mips/loongson3_virt: Pass CPU argument to get_cpu_freq_hz()
>    hw/mips/loongson3_bootp: Include missing headers
>    hw/mips/loongson3: Propagate cpu_count to init_loongson_params()
>    hw/mips/loongson3_virt: Propagate cpu_count to init_boot_param()
>    hw/mips/loongson3_bootp: Propagate processor_id to init_cpu_info()
>    hw/mips/loongson3_virt: Propagate processor_id to
>      init_loongson_params()
>    hw/mips/loongson3_virt: Propagate %processor_id to init_boot_param()
>    hw/mips/loongson3_bootp: Move to common_ss[]

Series queued, thanks.

