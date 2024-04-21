Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC09FC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rya42-000452-L3; Sun, 21 Apr 2024 12:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya3y-000447-LV
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:29:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya3w-0007YU-VN
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:29:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ed2dc03df6so3233314b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713716947; x=1714321747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NyfnQy3RE7q1hQCupGmQCeese//ndHVvXWIzLeIq5PM=;
 b=I2GZKBpk6m8PjH5j7vVtSg/+7iai3T3rEkzIpoDjZPV+UnW4pmbRpJoMjEpg5oBQ5P
 ADUOFRWJ4CnK9G68FLuPphOmQQY6OqLPKF0m+ug8vscDziMMgmrZs35B8pkOGWIhRN97
 d1WcsxgdYS8W0MP/GlAEvu3sqAYvdRvX1svE/tevto0D8tlcbxA1RElT7j76egFTBsDU
 fdMYw1nJqYG5vampomjz+Z8t8mWbFXjBLhF0HgY6bIHVsv2zLkOUW1VccoF2ZTJy75rf
 0bg6Xz/e2kejSKhC/a4AcOtVWTNw3Fz7lRte4Pc/fyc6Y+V4vg5ui8DJ1K+3b3JPTMX3
 v8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713716947; x=1714321747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyfnQy3RE7q1hQCupGmQCeese//ndHVvXWIzLeIq5PM=;
 b=qcp1hLJ6za+3fCVqwzmk306Bty7Y+qHQ4xZ3u4OPGIl7J8ihdMJMcZ5eOlY15ECZC2
 jMIlVZLTdnQbuQxRs73XJwAosa9YMGNbPAJSQbgBo14YXuJIJZFg/r/SLHTaHD/uY4dA
 ue1s4OmM/9o/kAA4/Qo0YF9uIEG/tFQh/0LX6AszU9dEulonTHt/0NzHDwkNBL/UsCG4
 1gr5iA6UMHFoz334ax1TMaTJ7E9y0hzPKyselJEvAINjwU6uzEbUVD61IWrtSdESq98X
 mlXqu7NoVFfRAsB/kGON6gtv/s810pBNKiidSwiCm6cNrQnq1lPh4Y2uThpdbICRZ4FY
 H+8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDCoF5hNscWj3eFiUvrhW7+tFrIGNgqjfyJ59RPBJIAXZmf+LTu3rrJgU1y0F6tZbW88FKCUH5JqqxCmkNmqB9iPqBaGA=
X-Gm-Message-State: AOJu0YwgNuwqZJMu739NhBlFXfmgth3NiVM1dl9K+XQlieIQ07LiOYx2
 Gy+M2LhpjDmqlYmqk6UFs7mpBRdLQN/K+s+O/3189NKbTAaWNjYeuxFgrBWMEAU=
X-Google-Smtp-Source: AGHT+IGUEDGMuAojfCufYunpafSYxvQZm30nJeqD2YE41fGszRVNuV24xTsW+KklMwVPNV6KuETgZg==
X-Received: by 2002:a05:6a00:9383:b0:6ea:e841:5889 with SMTP id
 ka3-20020a056a00938300b006eae8415889mr11446034pfb.33.1713716946688; 
 Sun, 21 Apr 2024 09:29:06 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 v28-20020a63481c000000b005f7536fbebfsm6004020pga.11.2024.04.21.09.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:29:06 -0700 (PDT)
Message-ID: <ab3c8740-463c-4764-9e8a-9a2676366de2@linaro.org>
Date: Sun, 21 Apr 2024 09:29:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] exec: Have guest_addr_valid() methods take
 abi_ptr/size_t arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> abi_ulong is target specific, replace by abi_ptr which isn't.
> Use size_t for the @len type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index f3c2a3ca74..63186b07e4 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -92,12 +92,12 @@ static inline void *g2h(CPUState *cs, abi_ptr x)
>       return g2h_untagged(cpu_untagged_addr(cs, x));
>   }
>   
> -static inline bool guest_addr_valid_untagged(abi_ulong x)
> +static inline bool guest_addr_valid_untagged(abi_ptr x)
>   {
>       return x <= GUEST_ADDR_MAX;
>   }
>   
> -static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
> +static inline bool guest_range_valid_untagged(abi_ptr start, size_t len)

No, this needs to remain a large type for 64-bit guest on 32-bit host.
(When will that ever die...)


r~

