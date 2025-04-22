Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0072C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KVa-00058A-0L; Tue, 22 Apr 2025 16:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KVU-00057o-5i
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:46:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KVS-0006JD-Ju
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:46:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2295d78b433so66826655ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745354773; x=1745959573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwluMjcAaaO25955up5WtvDZ49km61K6BhnXMy1boSI=;
 b=AsG4USz2xykRTLQjZYAriEXxRWfTbEy1IP19+58Icg4GDo3RuhaGVjim5Vn7798VgE
 d3N6UwFIFYgQbXWKpeIHCymQvmEzEcJyaMwRKO0kEx/6OwifBYUY/8w2yX8Sd0piAH5q
 VCPOPg/CdeUSWJuQQKOGrvUTK4f/uiVu7UqMoDUoqsBu1yBFjot+yah9ljGGvnuiuRjh
 0SpVmpTCUimwxAOLRZ0VFOSiqHEZCKt8346UKtC+pPm5PwsHXAnav+iQ22mGnZRtc1wi
 zlIqmT4bVxD3IUnpwRWcWrxKDg8A/43Z3mORiVig4x8Ckp1WG2AZyzBfHhA/ajWXlnL9
 6FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745354773; x=1745959573;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwluMjcAaaO25955up5WtvDZ49km61K6BhnXMy1boSI=;
 b=Ri8BYEfcA6kBJ777VFUYA5ck+rA0IwRpRIRPj5fAh3OqY7zMQHCeBF6NPOZZLSbnpd
 oKoVOoZD5LcOCf7ldXHUnyCI1l60Z8yRL69q/uWw5Xhp/1FP0yNEkI1PT3/hGTvxYOyd
 KUIo8a9wvSQD2Kkkygv4ndatZqRXZwFIootpkRLh4g1SZnz19q9gM3B0MoM3MQ36o/0F
 LgEA1tapBK74jD34bF4ADGbpVfZV66Rt4z8aWJ/rrCHA69cT3zurocRTngFesGr6hsU5
 NRCy0rFytp5RRovdxGFnWpsHUQvj/3dpSDTibpWa/teBZYUrkHIHEecbxgcAy5r4B18g
 gh4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrL121vDHWQY+XmvEc6tDjLj+tgd+LS6PlMJ8X85jlriOgbe0kqmuQ8bKPCcGxU+wJR6rHelEHquxa@nongnu.org
X-Gm-Message-State: AOJu0Yxmx47Tpoo7zTQGy7qnXv7XNYgYvI74ZbsIqxEDLAdkhM6MyTzN
 1tVF9stAqqbgzcx9thbbyO91N9Tu+EiFNV2/7fQFHorlfQlyFxuQBBb9UnkFfhQ=
X-Gm-Gg: ASbGncsHq3LR02oNAlQb14JVkS+8RaznemxZhbtrz89Rkd7MVPudV8iqtpyAErvVEcg
 Pd29qySYkCkXu9Uv3o43rgqrVLtVTVhOsAE2mcBRk0TFj3uWCa5lyltm8ZNZOXHKWbyKEk4VBXE
 HnAy7yy5sruoYlS3QGwIidDQ3pWYEt1jwPARI30xe08WDiXqf/wRU1h2KDipNJoHe9OkOx0Xbxx
 2oNGE0Qr8IV+gIknQSUExmoP7oYIjIib9tKKvodfHBepRbkRHlOz6ajtwWW8k8+9Tv0UhuKjv0G
 BpJmRmtJbX3lhcQpMtZM5gJ1rXQPv2YPfzOgKPO5O9Pa0yQLtqeLx6ypdMIlunIt
X-Google-Smtp-Source: AGHT+IHS5AEq0kiEQycoK3MLkQiFyDhW557+4OCgLE1vWmvpsYpDIMfqYKC9fUj2E1p0FI18QjnsBw==
X-Received: by 2002:a17:903:287:b0:223:faf5:c82 with SMTP id
 d9443c01a7336-22c5337a067mr219672625ad.8.1745354773095; 
 Tue, 22 Apr 2025 13:46:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfab289asm9083918b3a.153.2025.04.22.13.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:46:12 -0700 (PDT)
Message-ID: <17170b07-7bbe-4df3-b30f-edd8fc678a4c@linaro.org>
Date: Tue, 22 Apr 2025 13:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 063/147] accel/tcg: Fix argument types of tlb_reset_dirty
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-64-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-64-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/22/25 12:26, Richard Henderson wrote:
> The arguments to tlb_reset_dirty are host pointers.
> The conversion from ram_addr_t was done in the sole
> caller, tlb_reset_dirty_range_all.
> 
> Fixes: e554861766d ("exec: prepare for splitting")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cputlb.h | 2 +-
>   accel/tcg/cputlb.c    | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


