Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A96FC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYhR-0004Cc-S0; Thu, 13 Feb 2025 07:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYhJ-0004BA-0Q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:52:05 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYhH-0007Ws-1K
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:52:04 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38de17a5fc9so463599f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739451121; x=1740055921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0i4z+5lKYQ7qoSQK45p6oql43J7nhZHMAKcVcBea9go=;
 b=ZQw4JK5kL6uXy3o0uvJKylMZIzGzmlyMpnFwJidrfV4BeW1Mq+npTYERv2uFNMzU/6
 dJzXwTseMcbUWsvxQx75SyhRXaixDVPRKWjRznridobaK0cTPjHu3/GN9o8jtlEkVaLo
 rOzWhOX51z/iFqVUMLPDKOX4Lgftr3Y7YHydXfmYAA9Bs6QOu0BooOqSZ0IOSBsUxUof
 5NEhXEZYjCRbGtY2FSEMIJg3D7HRRbpBcsGb3aVLFht3dXoMM/avcyfYp7sOHQSLAuTJ
 NWwLxQxBwYmqoj9UmvnIjkwQAhUkiai+87zmHwP4rpRuL0mNytUpHwQBIF1d5CBMoD03
 Ptkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739451121; x=1740055921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0i4z+5lKYQ7qoSQK45p6oql43J7nhZHMAKcVcBea9go=;
 b=GVPyXKjvoGmcF200B7eqr8rJVb+sAnx8QV0y8PIGh37Zx+ienG0Bj/u8DFv0ccI5Y4
 oolvHYEQwLpzd/hEaba/oQdIRMCrVzL5ajkG01k+I4Z7FEn44TTZDAALTviXZit1BlRC
 359NxO9K3FuSazFhxZR2yxUohS85Uo+KR5aojFxASGA4EnIX6ygpVL2bymrXZglzLGrK
 nZUjVULL/IHZWkK2LcHiXpgE0qYJq3NFJnZYUGSn6CmhVs/zhzpovDN6L+ENlPrl5tXV
 5b1GjumNViqF2moToD2CtZPuz5IgCIYE9twehV0UE7GmacdmzWHofxoiHy/WaVI/+sQO
 3nFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwRBuPoX9lWwblJURfuAv1YllCopu0x0DaQGp5Uvs8ogQwlmwwGG7e7KzsGMoC6zpmyF6VNSWR+Gu/@nongnu.org
X-Gm-Message-State: AOJu0YwSLypiXsU4vwA5CBly4dR6vIeqKZ0Dxt6yoBgJMAbG2rjqQXxR
 5pw02tE5HOgGSbNkj7WatlsS48qPfBrkY7poA0ZCVCe8yUB2D1Zi4dXcpAoad+0=
X-Gm-Gg: ASbGncsWotUr8dXQGxkCSvAehxPELwim79MuLuTWNKZ7fFrEAxJb07zGxOmoIhvTGiA
 lFb1kOgPOPyokMR6qGEzhTagCauBDhPUDWK7ps3oHhmfKJukf2zHQgRtss4xWMVwDqXsCodkxE2
 sq2dnZyrQ9MAbO5NvQ/nyXakpqvhRu6WMAVX+gLCKgXiesaNwFW0NZbQDjdHmSuS+JOEWvvIijN
 hulXRlfz9EpgzjFGcEdbKH9Uv5Upfz+lUPqFvyfCdzXw1SKwwW2OW2KDSZpfpHCUU6QP0PptUD2
 ED/mG1UYS0+zRzUZXcaNHVWwrmsZD7z77YBmk302t60cUMk=
X-Google-Smtp-Source: AGHT+IEfpdEIKPEUHZV3Ffd3AYenGSTPqUx2WNFL9BOlHaZIFncXPh4Fi9pGBMxCcXKtSQ8LS55J4g==
X-Received: by 2002:a05:6000:1fae:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-38f244d64b2mr3146284f8f.7.1739451120680; 
 Thu, 13 Feb 2025 04:52:00 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439618a98f9sm16986885e9.39.2025.02.13.04.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:52:00 -0800 (PST)
Message-ID: <40962db9-e868-420d-b4ce-aff12baad3cf@linaro.org>
Date: Thu, 13 Feb 2025 13:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/microblaze: Drop DisasContext.r0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <20250212220155.1147144-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212220155.1147144-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/2/25 23:01, Richard Henderson wrote:
> Return a constant 0 from reg_for_read, and a new
> temporary from reg_for_write.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


