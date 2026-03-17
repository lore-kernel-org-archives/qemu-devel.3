Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90736FD874D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TCw-0002iw-Sr; Tue, 17 Mar 2026 08:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T9a-0000Pa-TR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:04:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T9Z-0001ZN-9P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:04:06 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b4d734678so540870f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773749043; x=1774353843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hxek9CocehZdmLp7IhxuYRyRHSF2IBXEaBEP678jAAs=;
 b=cHYfhO8OSWOONiWbuR61OWPm4EJzB1puTvPDns2DpU6bUZeLeHoN1PyqjQ10J54afY
 M5OOMm4Lm8VIClKctCX70IlIwrEjzfObb5b+1jqlzxBlxmrZHraaJ6zR+ctwlCAbwF7m
 a2aPr0z0+8X3cgE7Eqc0LP5o3HnTh1EBDOehQblLBrlkrXQ49OyPUa+ZXQySeTTNeYfw
 3egsuTeREP3E4B/BpPgIwEyZiGg4I6Qy8y4sWwDoQNMDflkQmkLiWMU+3iQjD4XyDVNm
 7GNH3FBmpvCIqz0lYXg/rINwXYVLUMarsrcfgs0TPGkJR1P3fPvF4HVhafPAqj3dVbKL
 I2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773749043; x=1774353843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hxek9CocehZdmLp7IhxuYRyRHSF2IBXEaBEP678jAAs=;
 b=gyWDZDXE16Enu6Xh6drqBw/xXHHM73zfTAiJIdpuNcy3dOjPGZhjK/filawZ+Ld0ab
 qgbBXzeqm2X2WO2SvYOsDFY3x8kZIWRd5p3ft3Ul8ZgWb0hqvWx63ew5ZaU64pkKkRUw
 2EH3oPZX4axtbBoaFnCwBZKT8j2Dtjm8XM8ZwzFkSQwEGSIH358hUGGsowRGoRCuCEwS
 W/GkDD/1/Yqucl6zSRu13loeQapXNL5IdUuRcsA/6OdX0/x8vC6zhgaJh/4SDLo1QhXA
 kQPRRskYIBV+16+Ae3xXHD5RRlmE2IHCBN/eQhr0YuO48FpDdWNwXkQJxRffhz+EpV24
 YSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLl1N7+xxWMEjvZ9CALZ9UWn7F4xXF7fFH9lV1k4lX+ZwTrQ0IH5D8dNf5gMBGqJ2cd/TZ3YyOg+iX@nongnu.org
X-Gm-Message-State: AOJu0YxeGkTTsmllCaXp9Sxc5MJotl4GZuAT3q+OdRSegwgJ/AoWaNtX
 5+PxhCG5BfLszZsNAFT5jxqUvxIhcrteDJ2Wmy3TdTUj2tolw3GU3bSEd5Su537w054=
X-Gm-Gg: ATEYQzyiHG+9pP05l/bvH4gc6ikdIdvMzHwHMImfiwY6pL5J8axiAmAyadbEznaDuna
 VZVryzoAxN9vq5HObe122i8gMPQrKdBM8BdpyoKeBw5sSVYeWd4SDHyV/ly7mGtJPEoSOmBTvmu
 m/ogfHc4VBPxL6uSHMLlalHozSc+WQ15gQ2BTgykXFA5Q7V6Y6CrEI/evfRZj6HvY0AgV8IXLXA
 S+mXg8AhTmWHuvkPE8WDagNZ0RW5MTqfArHdz1Qj0MPxIvhwHb1UcHcvO0GppDJmMfR5V6wxQrV
 RZsjzDjbQWrnewpYLY3Pt1vyxq5wc0BOOElPAU7QE7B/yVq4P/eZi1jOc7IrwVCsKnUzfkUHnZy
 Z+v6CXL/ipcpS69UF33hfLB3/+D7u+U/mCrHXt6VHM17uMeEifio1bECwW67x9q/bSv5XtSvOlv
 lKrQS5Bwh1yspZNEpCjcSROYyPDcShK+9UD1YRjiYjxVPUbpW+R1HZvBKZ64AzvFrIWw==
X-Received: by 2002:a05:600c:2284:b0:485:3f58:d9f with SMTP id
 5b1f17b1804b1-4855670c0a0mr199811375e9.30.1773749043358; 
 Tue, 17 Mar 2026 05:04:03 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4857f49d327sm15762205e9.11.2026.03.17.05.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 05:04:02 -0700 (PDT)
Message-ID: <a851c223-7273-4627-947e-01846926730e@linaro.org>
Date: Tue, 17 Mar 2026 13:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/arm-cpu-features: Fix thinko in
 g_strdup_printf() call
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260317111121.2062455-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317111121.2062455-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 17/3/26 12:11, Peter Maydell wrote:
> In commit 62272f9f8891 we changed some uses of fixed char arrays
> to call g_strdup_printf() instead. In one place I made a silly
> error where in changing
>    sprintf(name, "fmt string", ...)
> to
>    name = g_strdup_printf("fmt string", ...)
> I forgot to delete "name" from the argument list.
> 
> Luckily Coverity spotted this (as CID 1645771) because at this
> point "name" is NULL and passing g_strdup_printf() a NULL first
> argument is not valid.
> 
> We didn't notice the mistake in testing or CI because this bit of
> code is only run if on an AArch64 host with KVM and SVE available.
> 
> Correct the error by removing the stray function argument.
> 
> Fixes: 62272f9f8891 ("tests/qtest/arm-cpu-features: Use g_strdup_printf() instead of char arrays")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/arm-cpu-features.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

