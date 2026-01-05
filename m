Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C8C2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 04:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vccDr-0008UW-5U; Sun, 04 Jan 2026 23:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccDp-0008T0-D0
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 23:29:37 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccDn-0006jB-SQ
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 23:29:37 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so193727545ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 20:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767587374; x=1768192174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReBQO6iEVhGHetLBShgz7qNhZiTkVSuU8pAjASl99Ls=;
 b=TsDLTzYvYa/wZSzA8L/lOCOgTOrw5fTGQgxFtT2H8qHYc1NnDyNtFCs52P1ItK1u3Z
 1rE6oXohQZ3pRRvmPS6PDnraDbUR437LgAAXzNTtRKbJnKGSjs9zXh9GEW9umnuc3w/e
 /dzVioOIbsDJW+HoZJJfIdTAf0hT9uw29NW2umnT2KFYcQ59OlVzYJWns35O9Bip9LZ0
 VxvXehlUj20r4k72EI0T2BbnR9TZ/ycxjXzLSaMCcuWrR6M0W3R5GyYO2waZBPxmTQk/
 WB5B1Wj0ixHU1/nz7gF7UrHC+/c2DqgijoX//iS2m9/2eQjDOcZ0KElUC4nCoeBZQq0D
 fsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767587374; x=1768192174;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ReBQO6iEVhGHetLBShgz7qNhZiTkVSuU8pAjASl99Ls=;
 b=GFapryPeaZ0ks8TTuAzqglornzs/D6zW7OkcovDtmzYfv1SdQHhqdEwImdG00fFN28
 +bJxRv2Xptuvu9Ziba6aJ5rHFV60/wUrLpyiDG2XhmvNeK5au0PXakwyilhU8ah2uj5q
 teHlF2hNzeMCtNc6epnDWZl8M0b+nqEOf5aqPaZMvCDrQ3zJd955tuNhTniYqdY55DqA
 I/xNoWAffCqdYl8iZBPBMINbtwECMyCLdZiI99BjJTcP3q2qDS5lItAI0pwTf4J7/fY7
 wpmqNxxCSMoCAqYCrW8pGJ5Dn3cTXi/Sbyyr/6RycghuAr9q8Wcwucz8iX93wG+fV3Cn
 DnVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCpfXkG5BNcMy/OkdvLeRgivbIiPtm3ekVUelQ5T7CmWxFZTyeTqSv/qheNnp0DSRw/0TLywU+5XIG@nongnu.org
X-Gm-Message-State: AOJu0Yzk+h7ebpNpxF+SwhdhaQ5pSc0BpPm94ONrrMIRbeLCzB96SYdv
 jEyPuSwniejp6GmFggAzNzVoQ0K6ZXUYty89KRBigpPvn+F4N2l29gTiNB8Fgmk3fM0=
X-Gm-Gg: AY/fxX4Hhsmd5j69G+5uBRzYfkHz1lr6Gb2NFkpcFv65cJGFWT7d7xL8CZjtkTjvNlF
 PnKeH3f7VQOLkDcBXIfFS1oa2dFzPEyuAD6qsIwopawwVKyt8YzCyHxLjSVDaBs91gaKy2jcW8f
 uZGaIotadFlDHZosPGbH5U5l9Qs66TSk642CoLoIzvjT3u3FJ0U6aElp7N/UWvxnqYdI0D3kR/7
 RHfT4LqVpketp3UoonIXIIjPUsmG6P8E9TOkZ6GQrGd9kWOL6qEolVZkmxHbLbWiLCf5ulWjXqZ
 10S87NLIWKGF45Fu4WjUW7r+ewOk7sI92pKKE1CqYIqzm5Ic+05Ci8O1JiVwIkrvW2hA2j7khJQ
 Fzf1Po7nkiUoxgSpTG7bmLWET+67Czcy+qkAuzSXzaMU7IaqNm+k17Hj8dGK2CTJ5esJ9fp7TNQ
 MNtn82ssoKIahVwC4jU0mf6bjQlUXGqA==
X-Google-Smtp-Source: AGHT+IEmb0iLTHokOIPzVM5WptPSh6UXZkQNTkt8+ASO6Cm8HeU581bQ9oqhLVEtLnmzVhSYsInMcA==
X-Received: by 2002:a17:902:da85:b0:2a1:10f6:3c1 with SMTP id
 d9443c01a7336-2a2f242d304mr453735035ad.26.1767587374235; 
 Sun, 04 Jan 2026 20:29:34 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5e467sm364098505ad.83.2026.01.04.20.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 20:29:33 -0800 (PST)
Message-ID: <00ed6a0a-a058-4289-a515-37678f0843a3@linaro.org>
Date: Mon, 5 Jan 2026 15:29:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/arm: Correctly trap HCR.TID1 registers in v7A
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251231170858.254594-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/1/26 04:08, Peter Maydell wrote:
> In v7A HCR.TID1 is defined to trap for TCMTR, TLBTR, REVIDR and AIDR.
> We incorrectly use an accessfn for REVIDR and AIDR that only traps on
> v8A cores.  Fix this by collapsing access_aa64_tid1() and
> access_aa32_tid1() together and never doing a check for v8 vs v7.
> 
> The accessfn is also used for SMIDR_EL1, which is fine as this
> register is AArch64 only.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 24 +++++++-----------------
>   1 file changed, 7 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

