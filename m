Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99B2C47DA9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTZwd-00058I-C9; Fri, 26 Jan 2024 23:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZwb-00057z-0K
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:05:25 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZwZ-0001qd-85
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:05:24 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-595d24ad466so781675eaf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706328322; x=1706933122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BAOsItuQ/gF3bbUxSX4LRTRNpXMVaHIAeAj7sbM1MNk=;
 b=hzOmBU9fgaXylMAI1OXlvee8bwy5+Th3ZLHvxyXGoU9z4Hzo5bbqInZlzGQLLmCPDB
 4qH/mFZBvxumjOnm0zZ8SrjEJg9mWg81SFCZ/d/xhPQUw+h/lTIx/Xlq/tKeV52A5nmz
 N/9c3uevDajP9iO9+UlpeXhqX4i0bpuh82u4EWpk7C0bofiRgK2CkWF1ebVEtxAHhx4w
 7upxwhibo8crHVdTswKvFW3TFYwl/1hkeS7GRjZ7JovlkM8wZeLsuTSTj4N2y/foOYqs
 PWYBZzYYGvbLiKNJ1SFUm0qYoHLbB8cRAszay6mXhdE7FRKe1mQJoOnNVsly2u8C1qPe
 tXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706328322; x=1706933122;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BAOsItuQ/gF3bbUxSX4LRTRNpXMVaHIAeAj7sbM1MNk=;
 b=L88ekj2HkMTJTx8qE9oECvuXNIr9Mlg+buIirqV7Vs8lO9Uh/smph+HTj0+uMuNNXn
 YivzCAy+qetbLA6NspMEvgHCtHth8nBO8rBQl7ceyXRPPRV4paac44TxrLmCxLLhXQWb
 6jAeIdoIhnyKpTxhsif9esU0P+RF5YMQeZUbHCfCkOeyBQBwxqTQ4xOkVf2cUxyOyhJI
 dVjXL9Hk5VdI4Qaw3Bo6gUg+kpYopDCH0XZ34stgA3JeD7Z0cEukCt+rG0jMiriJ9jcL
 DyXpYz+hvzpSWoun8rjErz3mmNaELLbPActkNFwiPZIiq9Qa++qiCeb2EWwor210iQm1
 9oTg==
X-Gm-Message-State: AOJu0Ywb6eaGD52E22wwdPq39wXOtKa213T+WtP7uJ4+RaisLrqeJe8q
 PVuBuwLITSbw4suFQXyUEfXZQci1czFqcmYCHcWncZK1tpXDU3v4Rqy2u7e+iZg=
X-Google-Smtp-Source: AGHT+IG7lUXva4PeItPC2qdP+DgNI0r/XCcoh/53FokkYryN1gw4mNiWW6IvJYRymZN6gv287ooprg==
X-Received: by 2002:a05:6359:4c18:b0:175:5673:2694 with SMTP id
 kj24-20020a0563594c1800b0017556732694mr881216rwc.44.1706328321744; 
 Fri, 26 Jan 2024 20:05:21 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 fa9-20020a056a002d0900b006d98505dacasm1814464pfb.132.2024.01.26.20.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:05:21 -0800 (PST)
Message-ID: <96b28d3c-c35f-42f9-ae43-7b733043a7e5@linaro.org>
Date: Sat, 27 Jan 2024 14:05:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Reinstate "vfp" property on AArch32 CPUs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240126193432.2210558-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126193432.2210558-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/27/24 05:34, Peter Maydell wrote:
> In commit 4315f7c614743 we restructured the logic for creating the
> VFP related properties to avoid testing the aa32_simd_r32 feature on
> AArch64 CPUs.  However in the process we accidentally stopped
> exposing the "vfp" QOM property on AArch32 TCG CPUs.
> 
> This mostly hasn't had any ill effects because not many people want
> to disable VFP, but it wasn't intentional.  Reinstate the property.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 4315f7c614743 ("target/arm: Restructure has_vfp_d32 test")
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2098
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

