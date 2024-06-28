Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4702CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFGM-0002pE-LT; Fri, 28 Jun 2024 13:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFGK-0002ns-SU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:19:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFGJ-0002FX-F2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:19:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7067435d376so643591b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719595190; x=1720199990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ow+PDn7mkRF4AdRK1scat+5Q9cS9ze13R92X6OIjh24=;
 b=pOQ3MQGh1F/kwRfBTPit/kjWo2jWk1yMQCNXl2C+gFHRI1u57hz1LscjFDZXSNFEG8
 igfH3Gs5gBQDSXvspDyfSJhTK+dJhZF1awX3zeZ9qHCiZ2yUoJMwQQkoCq3BzExgwGOH
 axbb+Gth64OtWIu3QnzXwy1So7KoXHxUCUXMA6zvKJbZFPBZOrcSLLtvJxK1/RQliXPC
 i6Um6lS40mUTnfjY1KD4aYYXkda8qypmB6C+InrLdyF/8GAonhGsz2exQ54URZAg0IA2
 BNPV5kEX0+DjfSxF/OL0jsLONnOqHfmefmwj6kThmiaHhtGTZezYZaZXistGTQbeAY6O
 1hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595190; x=1720199990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ow+PDn7mkRF4AdRK1scat+5Q9cS9ze13R92X6OIjh24=;
 b=JQ87U50q6vmfVVcyhVMtqy9VxFXzXw4qrPeQ0cpbpLe8B3puVpE/9/bAye02ZJgowr
 l6rLzFTKw8u518j3l1bY/7QGPmm69z6AcqMfeR4LVIvDyJE2RLWBLl8mkAOwI2mQGupr
 +4I/Mmlg2rOsXgSqs/5OqVNtlvbpPo/ebRnBq/ljoeNQE2o4/F7SWFmqEdmkqFnqy2ZL
 aw+CxAUlVlU9nQOZ4HSh7Xj4nc/I9UTT/9AZQxf91wnDaZK/u9wgCpY3IPP1E522fToT
 JGRPFJrG7Nl97Y99OvH1DkU6HQtj0j1G7kyopNFuk3F1amS9LNwGLePg412oou2a/XNj
 C5Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCURCug0Cy10rpLvwMJ5n9rb0FcoLI+1v6gSzMNWuOGkSdP7zPxdb0Eoau4JsnFmze7KQnR5XwI3VWR+UQGbbMvC/fwcifg=
X-Gm-Message-State: AOJu0YwEaGMcI/stHuOlwrbDmo2YK9ErVC58CT9KUHyVW8rqTpk9SbEn
 MbaeQn0rRnOpi0a7mVAdc/Vyte6rA1bICJMNhtijjMMJgCp06YizZGL3mqPfrK0=
X-Google-Smtp-Source: AGHT+IHDQwkjOReF/ty3GORa9FQyGfcCMWql7IqhJtChdNj9/HKTtRHyNfbt04TUB3hEBSMjrQEFqw==
X-Received: by 2002:a05:6a00:1706:b0:6f6:76c8:122c with SMTP id
 d2e1a72fcca58-70852e0d7f8mr3719972b3a.16.1719595189851; 
 Fri, 28 Jun 2024 10:19:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70804893d4csm1867794b3a.185.2024.06.28.10.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:19:49 -0700 (PDT)
Message-ID: <b7a23f47-e363-46a1-a542-2e796c99309e@linaro.org>
Date: Fri, 28 Jun 2024 10:19:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tests/tcg/aarch64: Fix irg operand type
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
 <20240627-tcg-v2-4-1690a813348e@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627-tcg-v2-4-1690a813348e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/27/24 06:58, Akihiko Odaki wrote:
> irg expects 64-bit integers. Passing a 32-bit integer results in
> compilation failure with clang version 18.1.6.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   tests/tcg/aarch64/mte-1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

