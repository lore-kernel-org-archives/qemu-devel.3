Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86197D1812E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0O16-0003wy-6r; Mon, 14 Oct 2024 12:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0O10-0003v0-4E
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:33:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0O0y-0000x5-HG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:33:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c9978a221so37922515ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728923627; x=1729528427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=POFVMJnrlK3O2mHGqkmmfGAkdXgO1fN5o5e098lVQ5I=;
 b=xdQSdDvoeyenAIEAsW1477Zq8++O/nL50XVx5XV1VnS6fPCDXPjTJvf3Rd0yJfdgrv
 GNZujWJvmV26o61LFPI2tkiKKG6yD9FAanqUEtA6aMT1DoToi+dJfs1/Mx80iKM3ZoTQ
 Ls1ValoC6mT7y64zdoXLZpRFtGXJKpfCR3MsQspzcNLH62Z/6YKhkVx4sP3VEwUy7nrU
 zG2FoD65lq7DLZ0EHWtsdU444oKQHCjZYz20MBkZFoaHKrZwisyB61jC4LmHLmT2sWKP
 ylGlNYQg4Ysd0QW66e8mwcES1lVo/jvVZutAhooD3yH9pVmiTl6v2epcJwSaDF3JXfAA
 7MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728923627; x=1729528427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=POFVMJnrlK3O2mHGqkmmfGAkdXgO1fN5o5e098lVQ5I=;
 b=FA9IcMBM83/Nhhqpjq3pRSjeM8wsGUhwM4r8IiXTbvjmofqVASCjp81cCDy28ElIZI
 et9fJ47z315WRMtUaKxJ+gtzOEpO2X8uZil8NxXwtjjvyOIaCMbSnLRrEuNpzk+n9ofP
 p1ArwNn2+1/PPdCGDeJRZseR2KhLlN/A0T+6lFrtCrOknJTgX0Ka3eIG99p/diZaCbW3
 Kws5w0TC5boelGtnqu2yIQa3nbszbHaeG/PGgLMHzdvNeatkdIYEMcd3uwHJWs88IFJr
 M68/w1r8mYCgoNMrUDgbn1So0Y/TMDMynb3UGwTkjVFAfpm15Attji9SebXwAvtvEwM0
 yYYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5EPTbZIpKgF7Tgvedpi1e1UVMvggJh1Bk8EVpHLDAgA5ELj0BlhEQkMen286kvhrKxaVJMBrva+bK@nongnu.org
X-Gm-Message-State: AOJu0YzaxlL6BKsPyR0T1MN11Y0xoIkKdEWACLYOnMnb4xX5XXvwEHXP
 HudsHTq3TNDLXa6V1vCwEpGX5cpjEDqACmkEbzttlr/Q8F+gv/BPUJS5Y+MzF/c=
X-Google-Smtp-Source: AGHT+IFOR0QaTwqT242Tju2BFGu3sy29Bd+qaZI546AuAxU+0h7jCKti1eiHFNohsxOwwi9APEmiVg==
X-Received: by 2002:a17:902:e542:b0:20c:5b80:930f with SMTP id
 d9443c01a7336-20ca1429fb7mr155345835ad.12.1728923627023; 
 Mon, 14 Oct 2024 09:33:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8badc805sm67410355ad.40.2024.10.14.09.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 09:33:46 -0700 (PDT)
Message-ID: <a322affd-e3e1-44a7-97bc-d9db2090b000@linaro.org>
Date: Mon, 14 Oct 2024 09:33:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] tests/tcg/aarch64: add system test for FEAT_XS
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
 <20241014-arm-feat-xs-v1-4-42bb714d6b11@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-4-42bb714d6b11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 10/14/24 03:48, Manos Pitsidianakis wrote:
> Add system test to make sure FEAT_XS is enabled for max cpu emulation
> and that QEMU doesn't crash when encountering an NXS instruction
> variant.
> 
> Signed-off-by: Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
> ---
>   tests/tcg/aarch64/system/feat-xs.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

