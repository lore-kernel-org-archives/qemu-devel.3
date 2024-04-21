Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryaBE-0006ri-ML; Sun, 21 Apr 2024 12:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaBC-0006qg-Pe
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:36:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaBA-0000cm-5e
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:36:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso32681525ad.2
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713717395; x=1714322195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nkXglo0SDqCy5Sv7qTCxjByr3WjPttpM3Agj+6LK07c=;
 b=LYP5M05UJsvkbThLwUQx2PukrdYMnxSvNOh3tZwlg652ja3RovoYrx1wlPb7s5S0ia
 ZL++Td8gv51a+pBkuS7/xo33aVtJeWcV/MJ8HWlNx+gNdOtjnYgtKGBGn3YMQiahGhO7
 tZXZaw2VFsOSH64YKsiGqFgCRtU5rxPAODzPnTdSpE7+euKBEtxE7lJvQFRQttLlzEf0
 rgqhsN5YbTQN7+ncuEpvT4T14sl+cBNuIwDg3VufVFZHE4J44FTodACbOPMI6Or1w9Jg
 4DapRcevo0IHbohZVlEdaqMAivDamgmom4lfVjt7FRtLcc4NowGRyyILTgRLMYArEl1i
 aiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717395; x=1714322195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nkXglo0SDqCy5Sv7qTCxjByr3WjPttpM3Agj+6LK07c=;
 b=iN+P1thTivJI/YT1VtfyDHT7FOYrgV8grvAi1DY2jWgp6QXngi/CphJqOeca885/AH
 /ZwjM/HJEmGBhtQHcFmBCLX3XqY3WsNGqLBPyXSXmOy6j20jiCgPE7BVyFGikqT+w4CQ
 FNtSMgyCwJkDSld3GZeKZjRK45lTLU2yKAFBCQpmre/evnb4qfMxplaN+bEiuT4YPQ6M
 SvLvlXM7b/4e1G943vPoVsUti2atPj3l7XIe2hlhTeawD0hIA9IUVNpFcKBh4yqqeDWU
 dMjVz2LjerYVTlRLemgOs19xNu7kan9eyUV+854sJIa/7qIv7bqy6mDyqqCFnWo1zJ8s
 Yf6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZOZy9PBKPayOkCP/HQE2APVIuO7cIYj1cUxmazgrT/mnzCp6CWGnfmHEUHASwais71Ds6A5/+ogKMZA/1mg5rMOJM6jM=
X-Gm-Message-State: AOJu0Yzu/Ju6a4b4R4Y0AVcWkUVTp0lh3m0RcqKCaCaRv0XeJfdQ4mN7
 nece6kKHBKQy6Tt4zB2TVb7U1wcsHx/vkH6o5fvY3FwdAidnFQEWONrcG4Kss+0=
X-Google-Smtp-Source: AGHT+IGXt7Sa27+S5/L2k57srA4K09RsQxja6IL9SAbabgU+eQP9G+Ydc70B+4gH5g13DhBKS1Ov/w==
X-Received: by 2002:a17:902:b607:b0:1e3:dbb4:2c90 with SMTP id
 b7-20020a170902b60700b001e3dbb42c90mr8167330pls.64.1713717394813; 
 Sun, 21 Apr 2024 09:36:34 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a170902e89000b001e8ab6b927asm5279578plg.39.2024.04.21.09.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:36:34 -0700 (PDT)
Message-ID: <bc5d2dda-7826-49b4-b567-c9fb3b387da4@linaro.org>
Date: Sun, 21 Apr 2024 09:36:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] exec: Reduce tlb_set_dirty() declaration scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> tlb_set_dirty() is only used in accel/tcg/cputlb.c,
> where it is defined. Declare it statically, removing
> the stub.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/exec-all.h | 1 -
>   accel/stubs/tcg-stub.c  | 4 ----
>   accel/tcg/cputlb.c      | 2 +-
>   3 files changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

