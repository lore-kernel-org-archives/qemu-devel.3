Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E3E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 08:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTG9y-0000Il-5P; Thu, 02 Jan 2025 03:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTG9w-0000IJ-AA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 03:02:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTG9r-0001dL-J4
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 03:02:24 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4368a293339so73083355e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 00:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735804937; x=1736409737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bhryZLf1EbuooTuy8RwlZFSpnXwVnpUcFGZKdgU+M68=;
 b=P6L+fa090XZaK4/CW0P6dyx3QfIu/0qvIjq/wKwMBoTPr4QafABgm05S+oVFUym2zx
 ugmsblD2g2M0dp6zN5QfJY3bKTpaJ6EFUSQ+47+KKKgBlE2q1c09VmXMslMYehx6V3k9
 GtwTkottvvGh+wtZ97HmBtnhoxo42gIS6+vw9wlJT8LaGSebUJZ51JbvtM0L/hvG4LfN
 s8kfH87yw9brdFx63HoThxeLqiOEvSkiX8nFSs4vaIOy0qkYl3wHOS2kG9wRH7aOyrxz
 atnxskk50CCiAR0e4+lqjn9Zs6jYnlrYc0lszLa4cbHJoRL5CrLt7PH/tyTcYMTUELq0
 3ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735804937; x=1736409737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bhryZLf1EbuooTuy8RwlZFSpnXwVnpUcFGZKdgU+M68=;
 b=lvqxsbq3gJ1YIHW7ZgCqNJPcLQFcsmc+fAULBCDEMobHvSEPvf9GO1LORuTYd5IGGu
 eoLzYyBoW0Q0i26P27UEFZqwyU1dVUVVbweeZoWNhU3wu47npcyhH7IFmM9QuXJxW5La
 VETAImGApreXhaasjvxV6lhWPbP0vbgugGT8zE/xAvTDxvwgMs0h8qznTkyAU5YpXo11
 K3vb1pZIzWaDXeYUvqx3rIJ2yrqnEq6SGIPD2fSs6soNpvXglpuChYZ93a0e2jKNqQkH
 4NEIa3qWlHc12/nXr//ml4wlYt4rOsVdXfnkkkV/qrNMKg//gF6Zf4gRPDV5rZxuI740
 u3LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVguW5WZl/pdhh5Iq1lFDFVwZElcoddiM80s6wr7kYFZVHP78/KRvKuPHX5N3Zqge8XxlgsldYrpdai@nongnu.org
X-Gm-Message-State: AOJu0YwYk3UMP4N14O/1K0I0e82Sk/D5blnf4VuANSyFj86gRawgPzNa
 ZQ21BmYXmCM/6B0R+2SWadkf9+Ihzp4YvI5mjMXMDKAEIqv4dx986efAoVajXcoOOREBgAbh7LV
 lSnc=
X-Gm-Gg: ASbGncsOShtK3I9pq2J1ABah9r8OMofVwFmJkCsvkBhE0hZKV2UNuJRP8SeMoZXNECy
 69EkiP/JhdDLT8V+8P/Cy9EKj556gWCitQk7EH4/PP5Sw4/zFeNeXkuZDG3DdjZ1NxbD8YIOb7C
 8qo71TxG5bVywkGHl+8tDAnYPuY2W9PwC9C9WIBV6tkpTm2obzMt2gZyKG9mSNO667cUW6NPyMQ
 n8pGbGyK5ynQC0xBHuXt3CYGmiwXW1Ilb5MLQlY4AHzE/uHDj2Eu9TINAHIAkWulWcQBigx4mXe
 33rqPsNc8Eszv8GfY/VbD7pO
X-Google-Smtp-Source: AGHT+IH/trRQfJBcFMCDhxP10A/3zS1Ij1aaabrGXPigzwLQQPeI1pV1dZmNoJR3haBRU+9c3uMrDA==
X-Received: by 2002:a05:600c:4f84:b0:434:f7ea:fb44 with SMTP id
 5b1f17b1804b1-43668644255mr375854045e9.14.1735804936859; 
 Thu, 02 Jan 2025 00:02:16 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847714sm37757676f8f.54.2025.01.02.00.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 00:02:15 -0800 (PST)
Message-ID: <6402c02c-03e3-49d9-8afb-0c9350e26bd8@linaro.org>
Date: Thu, 2 Jan 2025 09:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_arm_quanta_gsj: Fix broken test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org
References: <20250102073403.36328-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102073403.36328-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/1/25 08:34, Thomas Huth wrote:
> ASSET_IMAGE needs to be prefixed with "self." ... this bug
> apparently went in unnoticed because the test is not run by
> default.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_arm_quanta_gsj.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


