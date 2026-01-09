Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C30D277C2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLJG-0000QD-Ln; Fri, 09 Jan 2026 17:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLJC-0000Q2-Fy
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:50:18 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLJA-0007JM-Vq
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:50:18 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29f30233d8aso33266155ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767999014; x=1768603814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0jwvZnE7hr3/vJVVN0dD8ZqYo4m5RG9Zk9Y+669h6Vo=;
 b=W+iWcfLaL13BhjqvqGLszGkqcowb5ilrUczt428E27m/5FtTFezVHZijiqzlGJJOQu
 FYsio80qC4so4pqbRv61r8+xKg7BYQ6yewkE8H4JEHEMJ8YoJdfx01OVDgrZOSup2rOv
 h3EUP8NwoGne4N2UijKh0MR7b5iRDKKZ7zOqJbVEHw62FE9mi8ToyRjyeGg2XvaqpKdy
 zxuUR3BdDgZg1bO4SC0NxP9sr+ZxWiBSiJbKcpjm9o50+pGzx3WwN7LV51kt6YLDELTv
 1oD50vAeD1DE7oqCsVBqZV0iery9NCILw2h0stuBAP+VddcRYnnvzu41JFXCWkPmhiZ4
 VWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767999014; x=1768603814;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jwvZnE7hr3/vJVVN0dD8ZqYo4m5RG9Zk9Y+669h6Vo=;
 b=ioiDSFzpClikYsOA+FF6eOoN3o2zgOW5VtYih724hdBVHUIvcDKvz4fsINazKca0Zk
 xI8vapk7d7CHKJXFJ786bmwLHHR7z4hthTTlRvHH8hOjWrTFLSO68UKrcIzDd6R7mDYJ
 wc12Qlx6tpIOkrlMrHqrpAmvSJBaTa06niskMreVpBJNx74FR5cy/iLbVVQfLKrSqdq9
 r7lTQq2Ni80hfwfpLZBfm901E+j7/5v0UXPdY+tggcnYQ7X3wNpWYKavXkeInsff6gu5
 MJBrxHu6//dypyec1XF+f5StHpIYSOqFtDrwCwXc74NWBN8ZGuGj9+Z1M+VAENP024KK
 mEFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfOe0b607x+bTG4dj4zlgNQT3TZqyaI+Lbeaisgc2pbKI+CC2v9BYJqB8UaDvvdD5/pzlCRknLnZlZ@nongnu.org
X-Gm-Message-State: AOJu0YwXHoHjPbh7ikiyOxwNFYow9KTHU27QM/+KyGZ5F3qI8YHISm4f
 Jq797BrIZjcD+F6TMRdSEWek4of5vYRaH1+LGMtoiyZZUSJpYt0zQGiL1k0NkPUObgE=
X-Gm-Gg: AY/fxX6tg9ws1CK2PECe5nXidpeoSzx89EIfdfKFFYU4c2s+tsnsqzLQsVAXAA4yEyx
 B6XXKCqOaWfGijUWf6LvMq1M1nU9qvpu7wi9KzG3jm/QlFry1bKSZZL1Ct4tRhFVKZ1IaHcdnBP
 PIEKdMavwbjJNlV7qrGN22+7TTPAT66F1BFvg4qivFs960ew2e7BsMcY9bCvxLUqte3uE1V6xlR
 8IRtUnumX1ANuzrf0zxM5AAzDeTmR3dsnLxoSUj93snkr/+mgM3e5IPVViXs/4pS9xLNC2NS0Im
 J8cC7B2qKOuTjm6cEqXp+8K50YXQVx0jSK5hBna2IRgWvmAkWACGEM+8+N7Vy3PDpxQh+XviFba
 ay6bce98Otn2lpJdYQmvKLTHxlmHgqjxc5oI16PKwjpaMqVooXVOPsE03ZPM/hncNj8CMUVfoZl
 1vaa4fIYSSKikCycRDopOsbkmCUg==
X-Google-Smtp-Source: AGHT+IFAkDG6ZxbwnWwZ5Cg6Vy9QUVa1KYAA56vMRY9A/Kt/3wWYnJ1V4ehRjNZjmt0DylkacaKv5g==
X-Received: by 2002:a17:902:ecc5:b0:294:f6b4:9a42 with SMTP id
 d9443c01a7336-2a3ee43315fmr90445055ad.9.1767999014127; 
 Fri, 09 Jan 2026 14:50:14 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49299sm112199855ad.42.2026.01.09.14.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:50:13 -0800 (PST)
Message-ID: <5fc9d07c-cd22-45c0-bb5e-8bf93d20f112@linaro.org>
Date: Sat, 10 Jan 2026 09:50:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/29] target/arm/tcg/translate.c: remove MO_TE usage
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-27-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-27-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> dc->be_data is already set just above in the same function:
> ```
>      dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
> ```
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index ec4358ba402..55b89817cb1 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6327,7 +6327,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>   
>       if (arm_feature(env, ARM_FEATURE_M)) {
>           dc->vfp_enabled = 1;
> -        dc->be_data = MO_TE;
>           dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
>           dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
>           dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);

Whoops, yes indeed.

Cc: qemu-stable@nongnu.org
Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

