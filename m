Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AEAD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSrk4-0003GB-Gz; Tue, 09 Dec 2025 02:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrk2-0003Cu-Sl
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:02:34 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrk1-0007DK-Bs
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:02:34 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so2432891f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 23:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765263751; x=1765868551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NNcfyAcCwyGfRTgag78NaDpFRKLCoxinAHUTJgJ0dHg=;
 b=QibcLav7Rco3nAvpkhhxqVgYUsCzsBVpgYl/8J2KNCfHkaB7hp8BykDwQ0f2Oe8j1C
 Y8T+VCQVTqRI8//RcAl0NRFf0I0pdecQC717a+l/JgwVE0ZIVNYPdNin/zkXf7QUttzM
 +cPNoVk1AFymXDtB37YNHJ0sCDuJat0A431RVYxwenWhUFrC22Nbn08qCs7NA2cQL7iU
 6bXn+sHPdKGHyO7SlQPeN6syLP79z/iFoD3lrMrZ+AY6u3kh9A/tRfyLMXhQuq1t6aag
 Wq75h95yOy5X3X5PsJdj+W2HJXJZCAOlZ3Dmvgs9XswezsX9Y1EZfvDWIKQ/fsNykCG6
 FuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765263751; x=1765868551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NNcfyAcCwyGfRTgag78NaDpFRKLCoxinAHUTJgJ0dHg=;
 b=jl+mO8ZXED1d26WUEtSMUgrOFq62Bd0D0vl+hhshHM2PDfyyJai0KbMzydk9KTD7zu
 2xlsMOhI1v8hWAfK4n31lFif2ILmaaa7RnxMq+eV1cH6ijZEcKOCeRtSFx3cz18oU1EX
 OkXQ92Zi1gFYA/l+5TIJEzZ09QAyL45k1HZdV9TJamO+PSAwBmoOP9Zl9PkDYAvI7Jij
 tZ7p7+ztOA2p8hE1teF7tIkObIwUla57OC/GCoaDI88MolBTPY/PTEHi+Wep85Sr+/qc
 LFhKuB/Dv0wFXdM2gtuJyz1jVfUF7GbVti2dBpt0YgnlC3PmDaIqdCZ5mIIcCQKIc62N
 qdgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN/5NWECQeSu62U/kA5Pp1nrwP3Rjp8FMX+cSlS4kzP7EttHU46Yf+NJ+26paO5DwWQHsLx9jy6uxe@nongnu.org
X-Gm-Message-State: AOJu0YxslI4yuAC6Lhbzh0flNnZejINfBvWpKE9GlDHs31x2yYGLp0xX
 5EueKg2xhQNg7GeQ9xhIbZxu/ZJLKGsjVhyAunITty5hKq+HMRJrNkXVAg0yal188wM=
X-Gm-Gg: ASbGnctbLg2CCqt2ioyj3mvMfRZwdcCuvM69w8RwW0hKg7tB3zRx5njh6Gx5QG1duDb
 Cyxu4yjeya5wXL3olgCJWu2mA0ZW0/V2BneL/COesfmMJNF/x7TVmfQqPcar5vzX5hMAxUSgD9Q
 jGI+psgeUOnxbLE1f8O2kqysFToitqkawsEdDMiij1qbF7CFFHFa8qdy81Swrc5RPOWNARBvDwb
 miJSF/9r7jbyzoaKv/zYVhG/ZpdIsUIrciwGdnIcfCNowOrSml8PGWvKji2sSMxzfJspAOiqlcX
 MYolrGFY5Vx0KSdQc+rwNeJRDsFLTqBIkDF2BJoxIx5wKDmvbfCDknwJ6yWTfY7/aIfs60gzNXH
 Dgpmq02gG/OOsebKEUhSNkTGnqK4PpZqaplkSnNWCRaoZ+SiDtbOk32YSMMgRyO4scb9wUl9kf2
 1ebxRjLC8vcTkPH8OuQxZOjJE9TN4m95EsAE48bbGmEAy8eE6siJCA4Q==
X-Google-Smtp-Source: AGHT+IGCWGtpNkrUKdhh1UWFBi3QTG9AdKqms5CQFV6lqW1HzxSQeXgI7NEnjfmJKkajOPcN6DvhVw==
X-Received: by 2002:a05:6000:400a:b0:3e7:6424:1b47 with SMTP id
 ffacd0b85a97d-42fa08e5cd4mr568543f8f.6.1765263750629; 
 Mon, 08 Dec 2025 23:02:30 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee5bsm29870451f8f.16.2025.12.08.23.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 23:02:30 -0800 (PST)
Message-ID: <cda3b299-3de2-4124-9205-228698c29c00@linaro.org>
Date: Tue, 9 Dec 2025 08:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "target/arm: Re-use arm_is_psci_call() in HVF"
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>
References: <20251205151115.2035930-1-alex.bennee@linaro.org>
 <20251205151115.2035930-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251205151115.2035930-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 5/12/25 16:11, Alex Bennée wrote:
> This breaks a pure HVF (--disable-tcg) build because the fallback stub
> will always report false.

I guess I never posted the patch that moves arm_is_psci_call() from
tcg/ subfolder... Odd.

> 
> This reverts commit 4695daacc068cd0aa9a91c0063c4f2a9ec9b7ba1.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


