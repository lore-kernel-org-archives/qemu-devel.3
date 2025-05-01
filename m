Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FFCC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVsZ-00032x-3k; Thu, 01 May 2025 11:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVsV-0002xV-K2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:31:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVsH-0000BR-P3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:31:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224100e9a5cso14662565ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746113455; x=1746718255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=Ew7MUDzw6ICutm7F+9Z32eXNYLNupjSNNRtC2xrsAkzFsaaF8dvwzw6mDelCfxsxoz
 sxVACzlglx6UWnl3iuHdeopcdpL3iknVoVLHV2ajit6+xngz+2+EVVaG8APLczFJgahI
 uw7aXS8+g9uGOnqZ5KH0GqY/dvJlIZVf9oAZPbcN6qBjOTFLwR0ly5ALYPswnj8s3NvQ
 qx1SS/DXp+WT3DzsaR2NonRs75uvFi3HpXdeTqqOT7Ifi9n3VzbK61UMfHfPnc3pPzzP
 r0ULRyafUockeFODc6TsLEN+AflQNYhKTa4p7F+5IlIWfxhswZOvwnNms5n4yHAyoWYL
 JbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113455; x=1746718255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=l6LDywycjg5zYV2Rr9mPQHUC9i/amgx21lyTf3s7TPB+Vkw20FZnzvyhPc/GQFbLfa
 nbg34wci+O8iS+hV67K3z+1odCFbmslsVkdyyVPl6qkzsczZvHkCgTk+WTwHjp3Vk+rB
 6MGqhebfDlaPpZx6uQNwqLstro09PC/ylnVyeTe49EmCEcSzkHus0q1UWxpCdzZyVKt9
 bHjPlo3r0ia0oEn/EWmxFIeM3daj3vFe7mubDs1hVWbJQ4qSIxJE8QUmeDHD3oL2605r
 hs+0wamn06Q0LvtQ+PwouJL3bLZHtxABk0oxGyjGbMFvukLy/y6H1eilLor6UQMch+je
 d3yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB8y+P0IY0y0UCm8VjxOO8V8ingz4OEjeeYAY+AeLAr5S3ir4YaRbGc0ZyBHoamYO9N8CuPd5zLBLB@nongnu.org
X-Gm-Message-State: AOJu0Yz6M2C+r1Zbc/zDV4D5p6qRSfn7wxpcx2BWWZYn22fwPPYiGiIX
 ZGOYi/he24pR/6J1V7Tu8Dr0edgG6+hGcZKhBDqvNeczQ1ofKYGCy4o7+zQrkCg=
X-Gm-Gg: ASbGncte8hU2X/REnOwH3lA/up3kJH+Yei2ty+Qu2V/MgujlmOKQZpr5NDaA0+sP5nR
 NXW7EV9zjluM3s0zklPqmiGxpdBA4HEjnRNFngu0fpSEquDZ9JhYUKPxiQqZOMXJQ5OYjZ9He3T
 PO5CfwT5jlK+DGvTnChfP7eyNNUgE2BinXvslDKXF5/4PWiBtfc/x9o0ZcNlSyXuFmQXQz0pnes
 08aYrDNs56J9a6IC7Wot5jWLKrz7rwXjNKfR4jiM03Bpv2aLqQTUU9gXp4Gic9uERFdxRc4F5p7
 5U0rUxtrAfB0vsloYDQWrKFjR9wCNkRmI+mr/xfxJdIfin5wFrRMNMho1QQ18DelloctJDNDltQ
 aUJzg39c=
X-Google-Smtp-Source: AGHT+IGzeJ0uKlST6RHLeyXfLwxl9azhIspU6tXs0Mg6AOMGNGmywhrNGTAzy4CllvHWvHp61PdBtQ==
X-Received: by 2002:a17:902:f548:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22e0863efbfmr42799735ad.49.1746113455692; 
 Thu, 01 May 2025 08:30:55 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1f9d4b2622sm750511a12.17.2025.05.01.08.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:30:55 -0700 (PDT)
Message-ID: <d21a3e99-14c2-4eb2-b331-bd39b8374ec6@linaro.org>
Date: Thu, 1 May 2025 08:30:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/33] target/arm/cortex-regs: compile file once
 (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-29-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-29-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

