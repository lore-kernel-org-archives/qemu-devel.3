Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4719CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 17:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLRRH-0004Ee-Um; Sun, 23 Jun 2024 13:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRRG-0004ES-CV
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:55:42 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLRRE-0005V0-U1
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:55:42 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-70df2135426so2276659a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719165339; x=1719770139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4tsrhthyUkhOcwd24gSQt+uXFRP60pOykWrz/LtUVQ=;
 b=b3RIvtZa6yUale1EuagoNx4cV+ykMi5S2xE2Ch18ohaMOG9ifzuleg5yt0/buAu6z5
 3sBnPUNarQRuG1ruQQXxFgXCO6AQwlDhxitz6Mfq0z9CVPicAAeSYk7cw72C5O2wL0vI
 O/VjHOPUEJhQ0SARzF6VwjUu+54KqnIm+19QvD6M1gbCzBZv1R74Np24x3mGKNzSKNQ3
 Z3IhRiNuL1bHpIVJyGPzjOkQRu3qDeqAVcuIx558D5SJTP/7H0Vxl/gr2rvyTXAQFVNx
 YawUf4VSA9JmdrTlKaW+4O4zMMJoSNVtaLiZ37+2lhtTW372+fQsXWPuxhk8gjm2l9eq
 Xb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165339; x=1719770139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d4tsrhthyUkhOcwd24gSQt+uXFRP60pOykWrz/LtUVQ=;
 b=KKp9Zmsl0L3x0i9sCSyu3Iq09+rYHOFI2dWAJR1RQFeLIPwsHaIPyZnst93bLuKQUQ
 pwssReXXHYE2/n78rLHdMVtq3xMOEVFnsf5uHoWx4FwSqMkW/EWd4pdIq1nx1rIQodhi
 CVEixUiD7GvwYND9mapvbLC4ciTZGjKvigzLwLYYdkwCJKw10UsFNnHb4icf7JWv7VAi
 YERfOQwnKWAtbNeuYwkpKgOF6RMaIJzubzTTFfMnN/tnvHpeO4ziGUWAZdD3FROYTfMM
 cYUp0aDDV89hQZzD7gYULvltqBbcSuARI9bgZjwnQF47l+r6IqUOnpzohNw64yzLjgMR
 Xi9w==
X-Gm-Message-State: AOJu0YyyK0uJdpWkEfXZa4V+km1ziI/fKzffVfhZS0YkcQf6kxmgIhKr
 WGNGsT05CYWsNEB8kTTB7O/CLW2+mHyc5wBMzz7+jS2o7tl2C1v17otfjrVlX2fI0PomjVjbavE
 I
X-Google-Smtp-Source: AGHT+IGjpCd2suCGSiryI+h9Kp6DZjxOJyN/xi62bihuRBLClZ/Q+LCiCEkYN9vUXPO60KdrBFKAXg==
X-Received: by 2002:a05:6a21:99a5:b0:1b4:1176:ea06 with SMTP id
 adf61e73a8af0-1bcf7e36ab1mr2266587637.11.1719165339161; 
 Sun, 23 Jun 2024 10:55:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e55db313sm7138440a91.25.2024.06.23.10.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 10:55:38 -0700 (PDT)
Message-ID: <99682aaf-935a-4986-8832-dd2f2415f4ef@linaro.org>
Date: Sun, 23 Jun 2024 10:55:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo-aarch64: Add OpenBSD support
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZneEh51XKhxgZKpp@humpty.home.comstyle.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZneEh51XKhxgZKpp@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/22/24 19:12, Brad Smith wrote:
> +    if (sysctl(mib, 2, &isar0, &len, NULL, 0) != -1) {
> +      if (ID_AA64ISAR0_ATOMIC(isar0) >= ID_AA64ISAR0_ATOMIC_IMPL)
> +        info |= CPUINFO_LSE;
> +      if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_BASE)
> +        info |= CPUINFO_AES;
> +      if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_PMULL)
> +        info |= CPUINFO_PMULL;
> +    }
> +
> +    mib[0] = CTL_MACHDEP;
> +    mib[1] = CPU_ID_AA64PFR1;
> +    len = sizeof(pfr1);
> +    if (sysctl(mib, 2, &pfr1, &len, NULL, 0) != -1) {
> +      if (ID_AA64PFR1_BT(pfr1) >= ID_AA64PFR1_BT_IMPL)
> +        info |= CPUINFO_BTI;
> +    }

Need braces for all of the if's.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

