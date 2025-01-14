Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1859C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkEC-0001gf-4T; Tue, 14 Jan 2025 11:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkE7-0001gO-DJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:57:16 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkE4-0001wE-8E
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:57:14 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e3621518so2902355f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736873829; x=1737478629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+GmVtIr9Yb7bCQHjU0FJMbZiYdYtR4o01Fr+QOYbKng=;
 b=nkTLEI9f+ngeWSLM5uL/5LbH+EtH2K1oRMLy0LcF17JgJhtdPfEjjfUCdQTPI+fgt9
 plmuzJxNShCs3UuIG8rnszG9Z0MsFn74l5YIPXuhYcA6kxYfrDifUjwcZ0V+/eV2D31w
 ZI1+qnKBqCbvSewHxSH8gFsRiKLwZKoDBzPdhClPVv+uMvX5ifneQy9gyss7kZ0TiIDN
 6R8kZjQSs0RGhIx0Ub0yIk4YmzPpCMV6I4EccI/6WhVUnuZSf3tYc/wKKh3jZvNwgooJ
 nZfLOBIpuWVMJGmLnPlPvMcb0+kBgQviUqnMPPHC7d3nXH9CqHVNEkladKaAvKj8mPpf
 x0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873829; x=1737478629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+GmVtIr9Yb7bCQHjU0FJMbZiYdYtR4o01Fr+QOYbKng=;
 b=K8TKSjOED+fKQNAdggIiDou+3tZBZCN1NrEt3fcrKoEMWxBni5kC+vxWKlGpbIPGwt
 S3+m6UIpj8NX7ZXLLJCJYTWNLO+4E9+Gu+z7evbH3tIdDi4AeSxMxc9wJ+W4KfPq9QPs
 nGxD0+L9curXf2OrjcPAbQTREGQqTGUTxa/6PZv8qoHRehY/EBIa0HniL4NjdRADbIHv
 B7wHRpJEB7SOdcBFMMtSPPhxH2qqLAwp7yRDYZAbmO4Syk69nwa1n9fmmAnqHohEruxk
 KBf36OAfz+VkfqF/0X3VSglF9EkT70DzIsmGEBU0QwTWUl3SO+0Cs/KRz1hM2/DeqHG9
 1q9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV64D1hZJ5Boc3rOAq1Pd/YW6IOrc6PL7LNaujIhof+pStkVk+gEBeEXpY7VeENR8FITPukyLVqNgEq@nongnu.org
X-Gm-Message-State: AOJu0Yy8d0hK2mvCn8vWSXwqpkICSLtqZCgkya6jXpZ6bm/0eSTGlik2
 QN4F09RnnZdV2epIurY8e8zofzcowc35RSZs+Gi0Rs5Abz0FtlDT3h/Q1i4gSEE=
X-Gm-Gg: ASbGncvjCGDKS+zTgq3XZkhFZQ3lHbpRIsfU7DDPJMX90WLDBCMVIZCkDubazIf5AkX
 Ijn8gHGz9Ip8ngFIPZfncxOldggzZmvgbz8ndn1RuY1tAjl0DxTxKoyhzJuFvjdXGa1wzEbZN1X
 GU2j51Uio2fDAJOR4dx5lZqFZiDMeHvp3hMeQx7lmYG8W2P8U/sGMor2g1spTdNPCYcp7CTIgP9
 HglNhD82s8sl1DEsh/dTN5NwRiHrH9tT1LIDqHyXjz1apClXiG449cUL3LIOdpPRXurk57OKEJ9
 3a1YeEPVUtf1v6nAADcvtCUA
X-Google-Smtp-Source: AGHT+IFzZkwV/YTjwPLF8uEy0Wt8p5b0BEnIWUQMN6g9vimoxbo/cuiHs2lsP24TOjWKAyKT+cJUkw==
X-Received: by 2002:a05:6000:1848:b0:38a:8b2c:53b0 with SMTP id
 ffacd0b85a97d-38a8b2c5649mr22124680f8f.35.1736873828838; 
 Tue, 14 Jan 2025 08:57:08 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc67sm183719615e9.8.2025.01.14.08.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:57:08 -0800 (PST)
Message-ID: <29b32a6c-3e1c-4a24-9272-13d2c1cb497c@linaro.org>
Date: Tue, 14 Jan 2025 17:57:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/81] tcg: Remove args_ct from TCGOpDef
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-24-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Introduce a new function, opcode_args_ct, to look up the argument
> set for an opcode.  We lose the ability to assert the correctness
> of the map from TCGOpcode to constraint sets at startup, but we can
> still validate at runtime upon lookup.
> 
> Rename process_op_defs to process_constraint_sets, as it now does
> nothing to TCGOpDef.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  1 -
>   tcg/tcg-common.c  |  2 +-
>   tcg/tcg.c         | 82 ++++++++++++++++++++++-------------------------
>   3 files changed, 40 insertions(+), 45 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


