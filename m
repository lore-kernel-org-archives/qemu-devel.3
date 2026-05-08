Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E43FCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHop-0002mG-6l; Fri, 08 May 2026 05:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHok-0002m2-S8
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHoi-0007Gv-Mz
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso20313395e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233698; x=1778838498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W+pab/0wiO0zcogUTuVs/k5f34Oc1r/swAVwbem5EFA=;
 b=Y2aWwFlqp1jJhz2UPEk/giG5qcNJVlRS/sh5Ij4He8Vv1BEMjqW0OE6GdfLWSO1FvA
 MwAZ7V4CeiTetVB3JXSrkDNSqCxKZ9PZoxuSx29k+WH3SK+3sCsAR3r4lVgfq0UxnpdY
 k6wkJkgmatKJWWgQk/KCNJWLtUvUEqJLox+0+2Jp6Ny6RUvMDN2TqscXwDESz3efWLzJ
 PktUFk96L9wgB0BtJ+iC51TOGilyfOeJnK0vPVZIdMAD7B6wLC/GaSDHb2X4BiEcElQL
 gNAzDYUuJWEYZzKP270UWJij4iRTevSa1rPem79KJD5guSBVH+j7BtcwrIwtzmIbHc/t
 qoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233698; x=1778838498;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+pab/0wiO0zcogUTuVs/k5f34Oc1r/swAVwbem5EFA=;
 b=WtCCePZQpDTeBsl4lRvDT7jGuTGPZ3VQO8FXVM8UPs7csnAnUJAC25Px5UAf4x/wx0
 /X/kaF5/VLKwfZgJlhHA5fkbj1hJnHpZ0cb98uAyrcS8OCwOWtK4hF7drJymy2cSkdc0
 SohvGvej3BFX+KY2uL/HMV9oxyyeYoLQ4DK2Aq4DoxLA6XmTfqZd8PmcwtD9XnVXumWM
 Ibd1ct288C8KXj0YCfBGrTBCWGEDsdJ1TiYp/1RcdE1b4LFpexuDqm7V4yVkRDvV9+VT
 Fo/C/CJiz/+r2S9TnoqGPEhBPtwGQsItJ0hpsLZX4SvvSTVol1gNWNd+b4LwjJS7ML18
 Gj+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fGPE0NIBxdjig8719teJvIwptDwvg0Hw9wXylSa9miLCP4d6BHFq2RtoWcM4buldJsWK/u2M7KQpi@nongnu.org
X-Gm-Message-State: AOJu0YyX5pL4RhDHOkzJhANkdbXgXTCZFbXM3KVfWy1W/rbLtPntQ+NJ
 mAMcc5J6IrLRFOVqpCnJBxBGuBGW/D7BZimEoOcUI1geiU/hskhAuZXbUKyUgvaJLls=
X-Gm-Gg: AeBDieu71m/O7nTuFBt1Rgj/8n2i5YBtvbd1RrxlsiX09u3nnh9W4+UYS5a2f81/aHp
 i8+xT6G2TCBU1aOvr5NmuIo9p9FItdqnAN3F/3WS2jUYEqtEqW3tJK2eFJt6r+06acAtS+xvC6Q
 V7zK1YXviKvF1tQ3fiL2EgD8efbm5dQTmnHOubKFyDZTT+QVqzzeK8lR/vbEdRYF5VEE9b7BiCl
 k7Il5JMc+M8p6DadixTKjrUwQFVcG56vLYSrAF55tZgavpLNDF+4Z9aTqgFSgOVD8ODLuq6vlrf
 lqioXMAoV/CZAFIYRXQdAY2BOy5LrbdVvsv66/nfkuo7Sg26/Th0sEouuZ8s0NwoL/dOfDkHafn
 pbfPSPe/kJTwTahV0u9B4kfg7fyokjgxUgqmRN/g3B7R9ZCo9Oztiy2GU2PVyxNSbH0W6JIlygl
 tFy17Z8g/PcXhIw+ae8uJKa7N33mIT+Z9NVjmh1fG69f5MWedapvqP2WwBJYLycf29
X-Received: by 2002:a05:600c:4755:b0:48a:58ae:992f with SMTP id
 5b1f17b1804b1-48e51f2e8cfmr182744575e9.16.1778233697204; 
 Fri, 08 May 2026 02:48:17 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e642ee666sm19941555e9.2.2026.05.08.02.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:48:16 -0700 (PDT)
Message-ID: <c0676f5a-0df1-4b73-9011-f1ed327c37e6@linaro.org>
Date: Fri, 8 May 2026 11:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] fpu: Use get_floatx80_behaviour everywhere
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h        | 10 ++++++----
>   fpu/softfloat.c                |  2 +-
>   fpu/softfloat-parts.c.inc      |  4 ++--
>   fpu/softfloat-specialize.c.inc |  2 +-
>   4 files changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

