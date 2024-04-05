Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389EDCD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj7G-0000R2-10; Fri, 05 Apr 2024 08:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj7A-0000MO-Eb
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:56:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj77-0001PN-HE
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:56:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4162e91f6abso4553495e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321772; x=1712926572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CiZRtKc6uJ5AuVUILAhlvltvhXq6I6pShSMPctTWEgE=;
 b=RnKIfQqB32kgLgT5Ii9NVhyyaZqv3sFW5UsdtFr0hxTARAGJoAep9RZPvkw1MYXtRf
 JqBuTETzOK/k0OAJ4VcFFhCcptAgYr1HjFlX+A+MGTKeogDhtP/m99g/3WvFamsFhJbF
 ruIeKAxmP5eWyc0CuUMUOO00tucD4Uk2ED6b236yYcgGr3RtsBqWCkfasCUe4vq/2j3B
 hNAv3sc632rqPLy0r1WimxaoFgQMayJid6TNrVTqtP4W9lSulpXzL62pmQ24uxnRC1X2
 HyHzNqDYfMhFXaIYOflCACjKkg1RGqYkBNh3ZuvMsdxKq1RW5PFfgEH+DAQdMPa9S1AV
 5PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321772; x=1712926572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CiZRtKc6uJ5AuVUILAhlvltvhXq6I6pShSMPctTWEgE=;
 b=aBmWVeVGm+CxHgfB8SJQwLv/tW6rSFTGxJWjl/tw+4RydwNwxAKJZ0nAN5dDEA6pFd
 SyOQp9gv3AI7ulTEuUuGh5o2aL3iVMfUMqDaYwpIs5o0oCMt9ECsM+63k1hal06B+G++
 GTdVYUmq1g0/6za/Shyb666tGaWJE+0PraZHrxThCFCAbL/x8w9IOSpj6ZiLuR5yljQD
 eXkEo+cMH5e6WLxmbzT7NJUHty7CuSHBToQCj7qrFY+AxsdfrJYjGlNNUu1LsAI3NeQG
 Cmr/j75d1WjV+E0Biym2wkd1MJaKcmvPo7JjLInvXJEoTZ6ZqugcMBqaJUO1F83Hn6DF
 lLlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgLKL1FwpFBuClybXiu27ca5Uprkk1aL8dZdzqpyvZi8e8AEJxG1P9zAQT1nXxXU9oU34uiBEsIWYEScCCnleCg11gexI=
X-Gm-Message-State: AOJu0Yw61APRPEFw9Z+0GALoxEMPIMAUOknODiR5kFwTWsFKZ2D+51Q8
 jXO8fFrM3Pakjt1Fv8tgzlNIdpQGNswfaqQNZ3s+TJtxbNFP8ZeadK+mrMY40ng=
X-Google-Smtp-Source: AGHT+IGw2REZWlYtwQJr73b7kSqSEHmjzOp6ujLhEJ8HEYWu/NeXZBnEZ8tNQOfU/3v7q6Ay7X9QqQ==
X-Received: by 2002:a05:600c:a42:b0:413:38c6:2c7a with SMTP id
 c2-20020a05600c0a4200b0041338c62c7amr1151066wmq.22.1712321771673; 
 Fri, 05 Apr 2024 05:56:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 ju8-20020a05600c56c800b00416253a0dbdsm6227450wmb.36.2024.04.05.05.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:56:11 -0700 (PDT)
Message-ID: <ff3bdcaa-1da9-4b84-aa8f-7c23bb5a26d2@linaro.org>
Date: Fri, 5 Apr 2024 14:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/32] target/xtensa: Use translator_ldub in
 xtensa_insn_len
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-32-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/xtensa/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


