Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C84DE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeMp-00047V-Fw; Wed, 08 Jan 2025 17:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeMo-00047M-DW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:17:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeMm-0002ck-N3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:17:34 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385dece873cso157321f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736374651; x=1736979451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=14Pwi8ItYDnHMjbwWLri3vuzRp8rec3z0/+pTBaNDdU=;
 b=M2LkIBDyA/g8CMZmRuVzucMHIa94xDx56gRiwCpaf3e7dQmuDueJePUvPsmB2us+I8
 xyUigUgVPUHZdLaPDBSGKBUWvVdgpw/bak2AsKhzMZvCnP9MYW6FNND/lWHnZylorvj8
 Hl6J3Ny24bWt7/jNWUqLjVyN2mSth6bN51aTshtExjno/eAXOjCYpwPkDK0nUhi5bMEQ
 H4PHkSBUiQF2EmUmLelEzes2gphLBwaSCmmXSXLANY1V6/ltS96OrSv1VGi1qVfCWpuy
 DbqpWDjIWOUb+vcHeCegN+aMlt4AQ5x4k4Ur/9NM00HmwB66+t8KODQ8W4dHwwARfbO9
 DJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736374651; x=1736979451;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=14Pwi8ItYDnHMjbwWLri3vuzRp8rec3z0/+pTBaNDdU=;
 b=DT0JwjBP6+91tPbnMgHm2H4ACKA/UgOWF0ebIqt3HgTMl+CStjg/0teH8nSYBoEfwb
 wTm5TwU91qeH6AXZb1nq1QkiptfR90ZMOb5xAQ5td4BCYLk91NiuW8PbRW1hQjNinsvD
 49UHmhvJ6hk10txua1/1z+RCj4VJ09naOQoHjlInMx8oW90urTZ0GqWaed4VO0JOs5XX
 o0DDZ/24vgK9AxU/xmvAHqbIXk4UpfdRIdCj23ge2b/7O25RzJOW2dp2HPq2LzahSFkX
 cdtDgfTn7d8MmYvD0rC3BoUPF5DgfJNC9jDGAN0W9w9dT1bUnUrP9M93JQ6aQZPnOhHg
 c3cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvxMPoS4qXn8JM8eG+I7PfoBMYtn9j/4JjsNrAoUJpX+gsIxHvZ9MW7K1oBOezmccbRmVEIwE3FmIA@nongnu.org
X-Gm-Message-State: AOJu0Yy5LFNzAyX9bzG5OqcROs/HRMg38wNohrhu9DydnV9Fl0wxtSfr
 scJL4hwxfu2Q6lTWSS6EvvyaH8ntlliclrFOjnTI+WD5JYusHIecnrGxi0Z7tR6enJxPtzBaP3m
 Tcsk=
X-Gm-Gg: ASbGncuwmLxHYJCBrxC34wUXmf/lksWNG870P4Yof7Qbn4aYnuINBy0U67McGjwRlFH
 ekVNwg5kLuppFvnkdJbU6+NpPuCzOaoDd3TovNhW36Bt5FZ+MEh7HBvF2o8tet0NKgf7lNB3yiz
 NbXwdtoteTb+YYlpwNbp0gWBqDC8rHO3Ft05fi6fkmE+wxy8AjjXqWZU2oixsJjne2QaOhVPU04
 SWt1LCUTiP5DW+7U3v12d1/WMeZ9/sFVFg5nZXP7yD9xjRG3ftKwcdRUfpmZYGhSBUnXGdF6MOa
 8iiLxn+HBZnXD0MujD7mxHB4
X-Google-Smtp-Source: AGHT+IEeP9CpPXcbF17Z7z0S4xmxUUa9uODB/DRWueOKtpY9jKKNprpxX/bdTIUEGkPRHPJUls1J3A==
X-Received: by 2002:a05:6000:2c6:b0:385:f847:aa40 with SMTP id
 ffacd0b85a97d-38a8733a209mr3612855f8f.38.1736374650826; 
 Wed, 08 Jan 2025 14:17:30 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38f176sm47055f8f.63.2025.01.08.14.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:17:30 -0800 (PST)
Message-ID: <7be534fe-55fc-4663-a388-efcb035e803a@linaro.org>
Date: Wed, 8 Jan 2025 23:17:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 79/81] tcg: Merge INDEX_op_neg_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-80-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-80-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 7/1/25 09:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 30 ++++++------------------------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 11 +++++------
>   tcg/tci/tcg-target.c.inc |  2 +-
>   6 files changed, 17 insertions(+), 39 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


