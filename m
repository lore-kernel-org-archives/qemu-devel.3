Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F80E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 22:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUvJv-00087A-CQ; Mon, 06 Jan 2025 17:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvJt-00086t-M0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:11:33 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvJs-0008UI-9L
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:11:33 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so9192592f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736201490; x=1736806290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oD+dVdJJtMIi8x6jesUmeXsqYK6igPqynmJRo5qmzjw=;
 b=yqC/2rnC0w9r96qFUwtIa1JIKj3FEZYEFCs3gSouT+GsjvmOE+D4vHkm9nrug/MH2z
 l8DKKiGMtc2ikM3h4rX3vM0IWBE8wzY20XtxSMPDwB9KPWT4ct2c5TyMgx8C1epXmQha
 mE+FEX+8O24fRfZ4Io0ZdAeD/KCwIkhn1zQWdO2NUI/+3pTbM7lxVfugSqKnubi+OnS0
 ChaZoGU5ryvF9EmnpbYnrXORwls9PDjHcnaPFCDvMnd7xn8iST05kMIMImPWXohsALjA
 4212GykDubLNId+YdRl1oVivQLmj4O/KlbkiCInzsQcYd7KA43gPW9+9QxGlYdTXBKR8
 /SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736201490; x=1736806290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oD+dVdJJtMIi8x6jesUmeXsqYK6igPqynmJRo5qmzjw=;
 b=izqdl1/rPYoMjKZ41hxQ3zihgEHY084v6RK8sggX/Zh33HZSi8bNl3gymrRfK7lSnY
 8fWvPI8M3LzEQs+t6UuneUKUzxs+8KKQ87Q0OOrt5FjKatlT9/rFQ0BCOIKN1NuoMx/z
 2lGmR2MJ8Hor/WId4u+eF4NWQFdcVZ0F4Iee1BIm2396D0hwvZUwEBGVYz9aUwuCOPTQ
 Qe8KCGvhEirFcHkbID54g+G5xWBGh/CDx0Ju/CXDOxNRbhSx9rjiARuPKWI9B20bd5ZU
 hG+JJ3YSl7Y2alGD9GBJWHecRbu2fRqCbblbKXt/ZfKZgJyMn8qPk2okb8SQMwLhCeMe
 LUBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO/5I7oFiErkR1AKNZ01MLKswLUuKbfKWRglmog5a2X0ryWAYXlaIkI5dqBYnPMwp5uYblZ4ukPZOt@nongnu.org
X-Gm-Message-State: AOJu0Yzgm9lzVJBsCrAc3MeJHYseg3uOQ08FzGPW5zsh0fCOtjwvxU9X
 CSyMW1+SnlmptFBswO8dNO1+RyEFtJEtN5UDCc2VXjzYsU4y1gY96hXr95GqsR+UKN/M5WXybkl
 VKMU=
X-Gm-Gg: ASbGncuW7hl5fpsZgJfkO20OgTOjGkpky/RMgkt9gUKFZD5qw+gIM57Z43/1ypvcTgw
 Un69Z5/4XOgGnn07hvEntj7wuw7Se44z0/9mI7McAYaUcGV3OYwypYw2kxPH4DqEzDwXA5ZLNZz
 qWzvaPssKaTXCHrd9qj300zm4BV1GYHeEZZbfvlBAw4NwGaB8FoANjK9pZyZikwu7yLpo2lT9v+
 x1xjkW3XkeFZpQSSYGJ/sYQKS6IuzImBkwWIuEAcHAkxd8aHI6iOt9pjlrplwmAJVz9G4jlXavC
 MR0dudw4gqsYOljse/unBK1f
X-Google-Smtp-Source: AGHT+IFksh+QdG9lDjt4E96FaizyXC3Vmf3SlAlQ5Jw6Ee+nIupej3Bl/iNIlBjOcOeffvrY3ixIfg==
X-Received: by 2002:a5d:64ac:0:b0:38a:4df5:a08 with SMTP id
 ffacd0b85a97d-38a7923b959mr661244f8f.22.1736201490082; 
 Mon, 06 Jan 2025 14:11:30 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4bbsm576109755e9.32.2025.01.06.14.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 14:11:28 -0800 (PST)
Message-ID: <5b2a7fc4-411b-4fbd-aee5-b817807c2583@linaro.org>
Date: Mon, 6 Jan 2025 23:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 60/73] tcg: Change have_vec to has_type in tcg_op_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-61-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-61-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Test each vector type, not just lumping them all together.
> Add tests for I32 (always true) and I64 (64-bit hosts).
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 66 ++++++++++++++++++++++++++++++++++++-------------------
>   1 file changed, 43 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


