Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2D9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xjw-0000Jm-BK; Fri, 03 May 2024 14:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xjt-0000JX-BY
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:34:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xjr-0003qn-Sq
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:34:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34b64b7728cso7115166f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714761269; x=1715366069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t7mwyIS/tLkougACvUm/mYcGwemuurrs8ksIMZY8S5Q=;
 b=AJxg+zqji6kncAJypvoHPCFumrDmZhvP5HkV8fwidIdRTSV/UEuyQNe4csDzGspuTv
 rRr4VTiuz/6OerqMFIkGH92F/c6iwyU8do8KbIuYRHYNX8/Qx7fuaz3piuGsCI5DT2Vk
 aw5xZzj6G1qgTjP0vNlgLKJOwBw7y4OKd/aHT1XL/ZSTt/Im04TxaMhr6S6pHTwXQKBM
 y3tLJQPhl9zAWaIx8ohLDf7spg4+Q61UChaDS3lRDrGFYQsiLbN53ts/0MOoieE29iYT
 dKf9eNhT8kOVdu5qlGnl8IDz4QLrB3IKoZ3E1tZ4xPeVINbIUQrR534GfITdsSIUW+VE
 6hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714761269; x=1715366069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t7mwyIS/tLkougACvUm/mYcGwemuurrs8ksIMZY8S5Q=;
 b=phyci/qRSeQp/lwG+OxKLrtUIa16Y0EJ4XAi1131BQB3oMBDALAM92wIBHICuJVCu3
 f3jXZY42iLKb42MdChHJvnM9ltIoZZJSPrX/O9gBm9sOSeQisd6TQ5in5gv9/X5C5rLl
 4shi3IyvtCjV+Hm3iRapB2BMebMEWUzcTcmrEdlRPkQpC1cCQK7hwz60VKlfYj4tywX4
 RHxsswAjiGICalkNWwrKoS2Yj31nV5KOamSnUrEQACy2sBW1jr5mrKvdtWfzM8jh1EcR
 g03YLM9s7DMqAR4wextV5AH4UQ2Xv20vnnnGlfSc6R7uk/bzQ+ttxaxytmRGOX7tm7WU
 RMGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDmc8lNbbXRq6/0UD/mW19xTqeLlfNrcsO8wOLdCFaZcbaNBVo2SsfWy+HJzdxpQ+980s6mbkqUNFBUkvvgydkOon76Hc=
X-Gm-Message-State: AOJu0YzdN7N2rVoTv7xQPDcjfqqFDl74noGCAzCrRGVwPgnIPW9iNmT1
 oYdOZz/luFVWFHaRtb/MaIjyHIm53kdlPwvMiXWeqNEr7TtCdVeBFvACDL0On9o=
X-Google-Smtp-Source: AGHT+IE+PmVM0KxF+j8wX254ySorc4ELLTs7us+ZTpCcy2o4ErixR9hi4CdeQ7GNL8R9cbF6VViqog==
X-Received: by 2002:a05:6000:1379:b0:34d:7dee:649c with SMTP id
 q25-20020a056000137900b0034d7dee649cmr2725865wrz.13.1714761269544; 
 Fri, 03 May 2024 11:34:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0034de3098980sm4368944wrx.97.2024.05.03.11.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 11:34:28 -0700 (PDT)
Message-ID: <634679eb-eeff-4e7f-8341-0d1bc4129366@linaro.org>
Date: Fri, 3 May 2024 20:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] target/sparc: Fix FEXPAND
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <20240502165528.244004-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502165528.244004-3-richard.henderson@linaro.org>
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

On 2/5/24 18:55, Richard Henderson wrote:
> This is a 2-operand instruction, not 3-operand.
> Worse, we took the source from the wrong operand.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  2 +-
>   target/sparc/insns.decode |  2 +-
>   target/sparc/translate.c  | 20 +++++++++++++++++++-
>   target/sparc/vis_helper.c |  6 +++---
>   4 files changed, 24 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


