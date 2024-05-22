Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA0BC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uST-0007Hy-OU; Wed, 22 May 2024 18:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9uSQ-0007HF-VM
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:29:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9uSP-00050Y-CY
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:29:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ee42b97b32so13722595ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 15:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716416951; x=1717021751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X3320DpBpAiZV53qmmVJnOqv3dYF0y2Xf9kZQr/4Vi8=;
 b=UxhEAVe2mECsWqRDY7GrE0GNxJJdhwnM3nOf9jjvwSCOJ9ZYnshJSz0sVOE4Ulve8I
 M6BTFyal7a+kpqyoLwfDDi4I2jrAdiP+6whnMMVHXpZvS5O5ynwcLkBkcaP8LM0dgKGs
 PcM5oxLowVqz0HCSoFFR8uenlEB1o3R9u84b6OL9M5zrtf3idFwBo+x6Yxw7xGu+KG1N
 Dkh8iAxq4l8BE5B27JXHCnxo7tw3HtVhK7NdTaaQcLSFsfuPTfidy+3idSkoSBX3KYX2
 QQhMNTXL7cN3kkur2REB5yAllv1hj4rT10yAtzmUUyknDg1IZouyE5DNRPCEzT+g/ONS
 fHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716416951; x=1717021751;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X3320DpBpAiZV53qmmVJnOqv3dYF0y2Xf9kZQr/4Vi8=;
 b=uZfHJABnafna29VztDJN7kp1XtLbsG1memYcH4NPuk5ATbb764893GXy0dBclODYDd
 93C5rq/7wcQD8W4csum1qeGuMUzThrVPCb3nd67z35VSHa2CcazB71JvvkY8TmVAiUi2
 Lg49hHPgecHmsbb6jS8oeksIl3HqO8XMmoVwO3x8T4ZKYWX3lN1qWSXAbpzaZchtbJBl
 7UwdrsLx7DAWwXavb5KPbUftQSMyazBpC1IHU/f9m1QheDi9l6gzTPf75Vn/dIIDIM7d
 54+RpHe0eDT/4K0aQR95lUoMY1Ntf4pFNVQqvqwUj4U6eFUF7nIvo6ZQxK1V8xPWj95D
 Mg6w==
X-Gm-Message-State: AOJu0YyvP35LfAiuDQj8oHNSrSO+HjjpnN2dooHQ/DEKruYhLkZnQw3n
 C8CpMP+4TEcOC5j9tTT7PX5seiyqPz16MHHxjSBdabBJDFjBiAygJw32YXsbxxlwHuD42/KyH8y
 E
X-Google-Smtp-Source: AGHT+IHrmk5yOzD3vgbUS4tGl+UnKDJEyPxOZFMJ68uNjexdiFsMjp6AWgrVEpamLHfENgWkEdKOeA==
X-Received: by 2002:a17:903:1c2:b0:1ee:1dbe:74f4 with SMTP id
 d9443c01a7336-1f31c9a4c0emr37416625ad.29.1716416951294; 
 Wed, 22 May 2024 15:29:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2e14b4024sm101029735ad.40.2024.05.22.15.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 15:29:10 -0700 (PDT)
Message-ID: <49b046c7-a446-4acf-9d4c-e01a72f30cd8@linaro.org>
Date: Wed, 22 May 2024 15:29:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RISU 0/4] risugen/arm: Convert to use assembly
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240522212741.297734-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240522212741.297734-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/22/24 14:27, Richard Henderson wrote:
> Minor simplifications as well, which are all the
> easier for emitting assembly instead of binary.
> 
> r~
> 
> Richard Henderson (4):
>    risugen/arm: Convert to use assembly
>    risugen/arm: Fill general regs with 64-bit random data
>    risugen/arm: Switch to thumb mode only once
>    contrib/generate_all: Do not rely on ag
> 
>   contrib/generate_all.sh |   4 +-
>   risugen_arm.pm          | 805 +++++++++++++---------------------------
>   2 files changed, 262 insertions(+), 547 deletions(-)
> 

Oh, meant to say this is based on

20240522034442.140293-1-richard.henderson@linaro.org
("[PATCH RISU v2 0/8] ELF and Sparc64 support")


r~

