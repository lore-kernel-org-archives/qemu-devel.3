Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1A3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Whw-000489-GN; Mon, 29 Apr 2024 15:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Whq-00047l-MV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:30:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Who-0008H3-Kj
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:30:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6edc61d0ff6so4900167b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714419027; x=1715023827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vxaA6KznYViUA+FbtZpsDTlbJBXxSDLetttNQ+KMPds=;
 b=CgEdyv8U7+uoVS0sn0S0ZlvQQOVbFvB4RypE8VkRG140brtyWM21hNh2/eHlwKsbl9
 E+3THCH5GhDtqfnQlmeAZwwmyOTisjbLIj3L8/TWQiD/HTLBjeOwhy91bMqVYgFUT/2p
 sVLQUiX68cq3TX2e9Kc+vWYWPRgCe8NvRecSoG76rovNuk2Il3BqrY61h7sARNGiaWv+
 fUHE+W3ptUg3EaC4jx28azbz9+GUwQipv3Ccvuf2nkX1K6vLuh5r2inVTBA8nQqQSCu1
 7k7qLDD8vRM4gJM2II5XLaXN7YkdkRzZIM1sT7csNLIPEX4F0/XhnKiq8UhaiAw56Gl5
 7JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714419027; x=1715023827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vxaA6KznYViUA+FbtZpsDTlbJBXxSDLetttNQ+KMPds=;
 b=wGC04Gq1RR4xYEgMIfeF+xVhQ1AEGqeJft/RtCWN+agAKisCQOi+1dORePjdUletXU
 kcjuT5NokCCfmYzNGEds3VBsZ2NB0nZt/3LJKgjAWY2R5iFYzM/H9u7o4MMvO5oVA5W3
 OH+LvmkhP9wDsNqe9XypkKMOJN1hcgiqHw/kxhoalq4n7N2TlJPE4ZbXhg8/uEe/eGyL
 HTJaPTlw3yfnPg7mWHuFodJ429reUCcdgcmLfH5lgf3RJBQ2sAsLY/H4IxbvOl314Cee
 kQu77uGYp7jhZNeXgbsaTi8zzKuG9Kw1+0rz92c0z/Of0rz7W/08kXLQmZMhlcygE+L9
 zpZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgXBL9vQ5/e0hYHWoNXixQw0zkGo7ciG3s40t6efd2hlSimdAA7GZy3TgnSY3IrxRvJoNiyipfaBGjsiJosDGdZ/RBhgs=
X-Gm-Message-State: AOJu0Yzd+1U3LqUHLF8Gkvy8Phd/y0XNEZ+wpxmA6u8eEu3lDbq9UCNL
 +uhZC2O5JipDGmLFhfOWbDZTAxnYKovms179JUQ8BfcllWmY9V2Cnl1SWfdOMI4=
X-Google-Smtp-Source: AGHT+IFNrOoDD1CkL5CUZC4XoBAqJ6tg0Z60/q1gz5fSO5lXLEgclbVPc6vA2L0zyYdbrl6HUSZ0gg==
X-Received: by 2002:a05:6a20:6a24:b0:1a3:6fbb:e31f with SMTP id
 p36-20020a056a206a2400b001a36fbbe31fmr14623777pzk.4.1714419026951; 
 Mon, 29 Apr 2024 12:30:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056a00114900b006eaaaf5e0a8sm19579811pfm.71.2024.04.29.12.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 12:30:26 -0700 (PDT)
Message-ID: <07ac0307-3ab9-41d0-9f16-35e37d8e488c@linaro.org>
Date: Mon, 29 Apr 2024 12:30:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] accel/tcg: Move @tcg_cflags from CPUState to TCG
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-23-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> @tcg_cflags is specific to TCG accelerator, move it to
> its AccelCPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h | 2 ++
>   include/hw/core/cpu.h  | 4 +---
>   accel/tcg/cpu-exec.c   | 6 +++---
>   linux-user/main.c      | 2 +-
>   4 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

