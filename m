Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A245DCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 09:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNShu-0004aW-FL; Thu, 14 May 2026 05:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNShr-0004a8-Ul
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:50:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNShp-0008Vn-R1
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:50:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so2444025e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778752211; x=1779357011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B2aM7U5bDGxmzNqGjf3QD/Z9PnRjCisJkVZ4DTpwZNA=;
 b=YEDub2VEXGBVfgRs28ebruYzatklj2hPi4rHmhJJ8RJB5CiNHzrSubsJdvOD7qa+xV
 mTxBkZcE0/C7plKqk0M2zepttAOE9ZUwqnl0UM+TWKWW+d/XD7ILJNjx9o+bDeVCZSm6
 FGbgQvEOXh3ZwxWqZqviyHFoa/5y5rZy1CtBtNIRtv3+wfh5N41jfBL9L9KO1Vobwvmx
 IQjrgBfQu+x8JvsWKkrYZdG79GVOARQWllRG+sE6gqFKnqc4fNuHBJpJq/vSPf6EhcJi
 5yANxM4YNIQ3HLLKMCfQT7im7xo/zKY+0W4CjsFOtAJcAgG59fgmzK6yRN2fU1AHxi28
 7U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778752211; x=1779357011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2aM7U5bDGxmzNqGjf3QD/Z9PnRjCisJkVZ4DTpwZNA=;
 b=ZYFBggFMc6Z7du5HY/ZADvoXKIOwBT+i77XW706d9pYmOsNmDZma5sOY8mzTOTc1VB
 3iBC86Hel6tpS4MPMv37hkOrf2zMvRFR3MCqFsr2oqZiAs+fl7XuBUQPazN0cbTAlvOt
 MUWl2VF9gOqYVVYEktG1wo2VsIEYpMpIhpruGDb4QWPwa9i+bLP/FFuTFzTCBbbQL8fY
 QfJDZANZzi0z3GhMnDTqIsVWov9GI1BGHhIBMIe6gP0zjvMFOaZMvxP8I3ut5UePYUv8
 LqDiiXQabFyVyGkgzYrEHaGli2VU09Z7sDKqPVL+mGO2zGWdbDVFxj8GiPr0wzkmOBsp
 UEbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zJtkSKE/uHZMjn7IazH4asX5qbfsxd7iRJhka3+di9z7lF8in1LrnN55mTYAGC+c4A18jzyh6t+C6@nongnu.org
X-Gm-Message-State: AOJu0Yxeel7IsAwfIS6/3Gq/mEWxGky5cqvyRwhssJBMkOfprBubnBHz
 8fnJYD8ckPBL42oTL7ZexSFzAwJSc46wnl80DdiDEpuWGUqZ9VfeH35W3HF3l7DTqq4=
X-Gm-Gg: Acq92OHHbD487s/sXTNAE6WZNj/w01ikqGofsBmAFav7PJMKIlQnGRbrZs5EhV/G7Fy
 bruH2ov4rcGdi9OnRM1M42iYyLe19A/XaiIijd+yZMhATr1tZ6EdVK7IZb5OijWJra+i94M3Z//
 r3cBA9GrrRgwE6+MhzCRA3Iv1LKszIZDUh9sFy10gMG7dWxRhp1c2wkGJWzDxUkRmtIMtn+19b1
 e/sxwqoMrny3dAjEDyU0jgqnR8fLP3G7akwg83ti2+tDAr1Bllayv8FiqIasQgd6DkSYFeE/G8C
 Ugq0m0kX0+eOWFicPVxEZ+kkTK7j/i1zNXPn10A7JLqoq5mlvmP6iUO4r78h+Gkzh/ZoL6sRBeP
 2CjYtT8/Mycl5zk+8n1bFgbtowc/s1DAuWBJNIxAyOaxMyqLgRJGkFe0Zn3Zn+TI/R7PPfK97v+
 UjhSeJ4kYbINxrwaFiamstZOhNci8YEWeNHaUc26RFclHP9j2qQzrXAD1n16QYB4c/+Q==
X-Received: by 2002:a05:600c:c057:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48fe245d443mr3310135e9.2.1778752211372; 
 Thu, 14 May 2026 02:50:11 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64da1absm87778335e9.14.2026.05.14.02.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 02:50:10 -0700 (PDT)
Message-ID: <35642cfe-ef3f-4d5e-ab4a-44c8544120bb@linaro.org>
Date: Thu, 14 May 2026 11:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/35] target/mips: add Octeon LHUX instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-9-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-9-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/5/26 20:22, James Hilliard wrote:
> LHUX performs an indexed unsigned halfword load from base + index and
> zero-extends the result into rd.
> 
> Add the decode entry and reuse the common indexed-load translator with
> MO_UW.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split LHUX out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

