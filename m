Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E41C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpS7-0000vb-GX; Tue, 30 Jul 2024 12:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYpS5-0000on-Hx
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:11:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYpS4-0001h0-0o
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:11:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so2489552f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355910; x=1722960710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGVjxE3gClbn9G4bc2SRyH8pNBOp9pu1Zu8P0PAEYZ8=;
 b=JSWByG29sw+tz+UZmGi1CkD9wHyInrhUiQGwdgthEvIZ0FdHqk7J8bq7dKsi2BnxxP
 zwc1tA/HRIeJCGjtv+thEMiLrZ43JNGz+bVE22oWFfpE8HGzYoInS4FhVTAZfLG7/KAx
 dzEojUtBT4VsM5n8Jx6aRYr7fD96kntqDVHD+20SEVblKCOdTJN7cRV42DFYu7rqwOUZ
 W5RY81bmHYCsouy010oNC00z6drWophXPrwFEJUebm2Dq6x1oS+N/pYA/k5KJAJpgtgm
 dnev2cH2kZMTJQduv2oSnmYdmste5jU985E1q7QerE1izL1Az2n7ADW1ZzUZzPj8Mc6X
 pgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355910; x=1722960710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGVjxE3gClbn9G4bc2SRyH8pNBOp9pu1Zu8P0PAEYZ8=;
 b=qMr28vvrnCEc4RBzKUmK52+Ha0Z8A+ZhhrzK6kIQJhDufJVagYxVH8hF3P70Mxmjys
 wcnaA2FBneu2BJpUJGKy3c/Yf543iOcR3FGh7Ua1r7sWpKq8uvKKDrV0uLa0Y6SPKJ9b
 UJfTOMBcLHFYdVN4uybtuidZxkLZuyQs51tBfbRqbRODBFCmoWbOmdlYACfcWDovuEe1
 /Yji47SaWRCe5qyLqKMVnQnqq/msn7sdnyhO+bgZlx+avMXnyJQSfxyMa/LmV3+LXKPJ
 Q7Fq1ayPxwhq3dutLME8yHgtDD+1u8Xt5c3e5yphsEGkFlppZXLM04WVVCHIFQ5h6XJa
 oNiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI9kVvyw75zj5fSluujqWKjhHZUXF/cILoCMsKEhVadAoxjyDOOkpLckiXzZjugfTQVOWxDggD8/RFrN4L8teitHURTfs=
X-Gm-Message-State: AOJu0Yz1Ek/UXzvEMyvbzvPEawYO34lZe/DmMRYX2p4lPKmJmzWA7e7F
 1CnRfXIUJ/opCMeFT2H5X9sJpe8XjVvi9nJtyxzJJRz4cTtvSgi/MRAObsntYpE=
X-Google-Smtp-Source: AGHT+IG3CsJ96UPqchU2LjNx9EWaxndQ2/9KSR0oRyQ/TM+hbn6Pbk/vd+JeyO/C0JMBk+0YcPrKEg==
X-Received: by 2002:adf:e045:0:b0:369:c6ec:27d5 with SMTP id
 ffacd0b85a97d-36b5cf24914mr7126475f8f.30.1722355910007; 
 Tue, 30 Jul 2024 09:11:50 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428079448d0sm208847495e9.21.2024.07.30.09.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 09:11:49 -0700 (PDT)
Message-ID: <6484b673-454f-461e-ac58-b0058612602a@linaro.org>
Date: Tue, 30 Jul 2024 18:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] net/tap: Factorize fd closing after forking
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
 <20240730122437.1749603-4-cleger@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730122437.1749603-4-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/7/24 14:24, Clément Léger wrote:
> The same code is used twice to actually close all open file descriptors
> after forking. Factorize it in a single place.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   net/tap.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


