Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF31CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkw3-0007Gm-EQ; Wed, 24 Apr 2024 18:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzkw1-0007GP-Mv
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:17:49 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzkw0-0002UF-7e
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:17:49 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a4df5d83c7so331018a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713997066; x=1714601866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPBnV6KSF0TYFLS4dHFyBK0BgyiaFG7LTVeC+UZDNPc=;
 b=hV2T1hQ2m8gxTG0O0Y1mkBkDVrR3/eYC6FQrr+xosR4HoxPu2Z7GOI85TTqfxBSLkw
 vsqdZlYxStEz3kwi0cISlJuBeV57Jkp1n46Acc3p27vA48X196fTQ8Jko+EJf0W3vw+g
 FXiTxDD29QfolL73X2/M5JOqCLIP6U6PWnFX3/3bc2fB62JNhu4FuSmXxLq2hkbWBUq1
 muh96j3wdiFs7p0LwEl0gr6gyDjjUUFlGtvGGMp85N5e+6DO8z15unqyPbzq2PUl9wcv
 57QgQAOI081zIHfGwvXNComXxMINLeXtuXjH1VY5e9YTaBEk4jwWwL1as5INlKMDjtgf
 UCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713997066; x=1714601866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPBnV6KSF0TYFLS4dHFyBK0BgyiaFG7LTVeC+UZDNPc=;
 b=ho/vQaHnQySMRtGnkI8iy3XEwmm4QHTLuDhWge7dYjiEgW3mh61aceG2UTcYWcI2bK
 E0TI34cjoNGNXXIzi/Al52QnO8JRMHpbJeP9J4s9EJ1gL4BwPNmRSckNCCK8uG2sS6ZK
 5DmJh2IPG6Jcc6A47exhcpYfETIvfoVOQuI0TUrdcRQj295FhME4J+ZEI6c64DLeSkcW
 19eJc5tDhgQhq/CnrhOVffg5JZcD502ZHxqCGbiAwiMX6px3q9YanQrplUpeYM9JDzw6
 DKq+KHGNybLcTjohAz1JC0kE53M+O0Lve22cqxavrg/SGXlbcVEBtfSpCojl8qELNNle
 tIMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWftCMECRaPaEVyd8EjM4eO2Y0KHIAvJwrcxZDM+zcucadoBtC7pYJG5+WLNLNociGfqGhFwcyhJsMJUml9sM8km2tyVM4=
X-Gm-Message-State: AOJu0Yy1ieVdgW3aj8ygyAzDp1y7lJJmTJY6E6n/nMBs028QZCjhJoVn
 qQxfsxfHrO9WTnyz4KFqc/F9J2l4jJj4a0NI/NzkFvaF6/M/tAXy7NSZ76Kx8TC4jdEJ09ci4Yv
 L
X-Google-Smtp-Source: AGHT+IF6j7OyWaLKHG0Y5IUMFCajUY3JkkMnQ90dVS5aBuEtyaSYTxVDnCcZ7+1DJp3tdlpMM299Tw==
X-Received: by 2002:a17:90a:ce03:b0:2a2:7992:fbf5 with SMTP id
 f3-20020a17090ace0300b002a27992fbf5mr3903029pju.48.1713997066647; 
 Wed, 24 Apr 2024 15:17:46 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a17090ada0200b002abbea7239esm11673100pjv.6.2024.04.24.15.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 15:17:46 -0700 (PDT)
Message-ID: <917cab32-bb33-4ecb-808d-92b630b87a70@linaro.org>
Date: Wed, 24 Apr 2024 15:17:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch/cpu.c: typo fix: expection
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-tivial@nongnu.org, Song Gao <gaosong@loongson.cn>
References: <20240424202106.1465526-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424202106.1465526-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 4/24/24 13:21, Michael Tokarev wrote:
> Fixes: 1590154ee437 ("target/loongarch: Fix qemu-system-loongarch64 assert failed with the option '-d int'")
> Signed-off-by: Michael Tokarev<mjt@tls.msk.ru>
> ---
>   target/loongarch/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

