Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D64C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX4fo-0002cs-Fm; Wed, 02 Jul 2025 17:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4fn-0002cB-4g
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:07:19 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4fl-0000jX-Gg
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:07:18 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso8424628a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751490429; x=1752095229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HOWcTeAXAyKUUtDU9lx7fPCNqB99gaOZBTwjUQVVV/M=;
 b=nSRytDyrgRTLDvpHUDf9FNrhFB8Afqf6gkGQlzbRG83DVw8BpSP5ZGyG6bX112I1LB
 xb6xX+uih0byE5tnImFpVRoMgpU4vM9KHeRuTbY0GK+bkDUgf7ApIvXnlAypu8oQ3lJm
 EBEeclhzXBeooj26Ym6fGdJYlgAnl7ky8beTkuokOdoJvJhZJwkxobELYnxql0qnshJe
 uNAQPxiG6HEUnOPdKSNXYkdExNYYJvlEvpYeZAmRPPPjPR9M64Jjsz8ZNFnJqC/heSHf
 HOmK+TrwgkZM3zVBYwfBkLsQ11Cf9cOtgWnlgWVn1YWQGHAt35mU4sDje0Zg+GyKk7Cw
 5h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751490429; x=1752095229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HOWcTeAXAyKUUtDU9lx7fPCNqB99gaOZBTwjUQVVV/M=;
 b=HZkiyBhuH2Fxuw+O4tzbRfsW7HirRzSmFSGP9yQvSmsVIlbTqjH5FcroK0cDgnGdUt
 Axobcz4LW4ijEqYhTYzHtpEwKcjAyVQzBtGNmiAWDDOTA4BoVWFRBRA4ZEP2zhCiBvxt
 XGJwXJdto8jUJo5tNgF0ftTW6psbbCNguom+9wBmbO6vlAQcxnexqEc+GRfxwCyM7xDa
 YfKe5DxT33Oy31rt5S1ZSiwSGTRYcelBBt1MOr/NE6GAJUX395jLEKhViLb/z6YPmVAr
 xINI/n0kv4kNyeSGlre0IUdmtjL4ISAGMcJO23O9fK3w4UL1ma4HfwqwFG9uMiss3F9n
 VL2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+y71/5UDxU+CVvOLzcFtcccP1E6fDN67UUaEc93C2iIe1wnVaLbaYbdFuTeJLLTzfHKmkvWlBG2j0@nongnu.org
X-Gm-Message-State: AOJu0YzrQ2iH2Nq1I1mRRd3AIFyg0+unCGbkd9P+zCHUMYufWrViYF4i
 TQL1fFQvXzgWP5SnciqTEuVTv1Axsli551B6Y6eC2Yllo1z6Dw9tNFSlaIfcWZOSWOM=
X-Gm-Gg: ASbGncugahggj3Q32H9TCxSdE5v8w36qZ5q8Afr75+U8cJszUu7/XfaQfo4kZex4QSG
 3cILop6sGkYhWx2gI6VZgzQNoNeBYL+i9t5hNewzKFeEgwObydI4c6t4ShZ/w8x8eyagzxxhVDY
 HhEYWCcpyiETqYm5Kx4fHjtgt5pnE5W/wLYxweZzvOuj5ntrgaFgBvD7DTE0z/MroXlHdaG//Mv
 RhbHiw5VnhHOmbuAXUUFY1xeFD1dVSl4beApz5+ffCG4rmHmVVeelNzA6BnG65G4aEQZjYIDQ6Q
 4kbmIBCROAeupYROrw+CmfEnDd1hXSFT/f2LJVwADSOTmHjDLQdKQe7rBAeDK0b9oLW5w7GLe5m
 45Bt9AZuPEA==
X-Google-Smtp-Source: AGHT+IHhF51Spg7mZhY99JAUWDKgonpZxsqwLa18lG5KQOSOuEIGTwzabk58pnBycgy4K+iS0GLcGw==
X-Received: by 2002:a17:90b:51c3:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-31a90be20e3mr5450780a91.23.1751490428948; 
 Wed, 02 Jul 2025 14:07:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9cd1ff17sm567572a91.49.2025.07.02.14.07.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:07:08 -0700 (PDT)
Message-ID: <c82bbddc-bbab-47c0-a201-ab2e0b307046@linaro.org>
Date: Wed, 2 Jul 2025 14:07:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 63/65] accel/tcg: Factor rr_cpu_exec() out
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-64-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-64-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
> Altough we aren't going to re-use rr_cpu_exec(), factor
> it out to have RR implementation matches with MTTCG one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


