Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38020C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 19:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2yJR-0008TL-4E; Fri, 03 May 2024 15:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2yJP-0008Sn-Ah
 for qemu-devel@nongnu.org; Fri, 03 May 2024 15:11:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2yJN-0001cy-GO
 for qemu-devel@nongnu.org; Fri, 03 May 2024 15:11:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41c1b75ca31so395265e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714763471; x=1715368271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c1JfWWB7JBVaKmhOFEi6sZP8e+Xxl/LVo01muHLKDqg=;
 b=VI8omRR5IgcqrX+zJHMPY8zvIAfJdNseuE1FYrE0xVfg2TozZzA4LvDObJumKnaW5E
 WkCNhKbiBJRsOIRLAVf+gYEEExXzEiQRka1xGXCmMP+bfpU9qH4URYqUKMX+dBz3g2zb
 RiDTDZl5j7kg9i/Oa34H+i4OvlJbOnQEI44AJ7R5pNcwdBanzeP7TsIdj5Uikwx71tK+
 w3r5US1amQuO0HeToZzL9tNnro3PFidpDzXlwq7h1Ik7+SRU3VMHFSSODZlWPSUkk4sw
 ZmcC1FVZGuAup/blo6C9CrLIl9Iu5ZswOsKROWxvw2loYZEBgRoZgiypqEpThuWr/LLw
 uMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714763471; x=1715368271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c1JfWWB7JBVaKmhOFEi6sZP8e+Xxl/LVo01muHLKDqg=;
 b=UaMkG8qnnl88bXzXJ9gVun7dO8ms/AA7YBefNA9IhdmkGEUUq6zOvyWDfC5weY+mBi
 pz0P+66cl0zr7+/bfsg0cTb0P341w9Rg1F+5zzNIi9Fsk8BxMhEpF0JuiU7vvi/4bSoE
 EUtuz/FuyKL456GeS3VqgQsso7bX03jednACcxbQn1Dy2Q9h8dwHCWjq1WoygN5IpimJ
 KYgRhJZhAhg3KoudADfK0dSOOilz7uyAaBsBaTvTPeBgcqIp9lc/pclNHxORmslgwLC4
 zPBgmqLSnnzkCBjzrd4L/GaeAGkhlppslQcrobILoYk80oklkw383swR9RDOObxcE5ur
 M0SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaZFsbk3+uqjFQcz1JCZi0YK3rK5M1tze7vVVJHoPeg8iZmVlIVwFTQzDaWjwFW9S6zB1Tn2C4lAUzgTL3wEVwrAlZZGM=
X-Gm-Message-State: AOJu0YyxtV+PMu3sx8+ZdFWzRJwDLY1wLGiOq3DuGeiw4BuXf2+o0s9C
 W95tNvBwaAil8cYjAVnTCBUWN0RXrqUlAqaaHHbfnqhHrv+VHY46rO1bmm8fB+Y=
X-Google-Smtp-Source: AGHT+IEmC4A1KiIxcjITB8ve7bU3/1mKRcepRoNSao/dUGdtioaadCKpRkFbtdfusiRdDDvy9nA/pg==
X-Received: by 2002:a05:600c:1e0b:b0:41a:f936:5326 with SMTP id
 ay11-20020a05600c1e0b00b0041af9365326mr3035763wmb.15.1714763471122; 
 Fri, 03 May 2024 12:11:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a05600c4e4500b0041906397ab7sm6678411wmq.3.2024.05.03.12.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 12:11:10 -0700 (PDT)
Message-ID: <fc03eef5-ab39-4684-b89a-4d690ad4217e@linaro.org>
Date: Fri, 3 May 2024 21:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] target/sparc: Split out do_ms16b
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <20240502165528.244004-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502165528.244004-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 2/5/24 18:55, Richard Henderson wrote:
> The unit operation for fmul8x16 and friends is described in the
> manual as "MS16b".  Split that out for clarity.  Improve rounding
> with an unconditional addition of 0.5 as a fixed-point integer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/vis_helper.c | 78 ++++++++++++---------------------------
>   1 file changed, 24 insertions(+), 54 deletions(-)


> @@ -150,23 +138,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
>   uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
>   {
>       VIS64 s, d;
> -    uint32_t tmp;
>   
>       s.ll = src1;
>       d.ll = src2;
>   
> -#define PMUL(r)                                                         \
> -    tmp = (int32_t)d.VIS_SW64(r) * ((int32_t)s.VIS_SW64(r) >> 8);       \
> -    if ((tmp & 0xff) > 0x7f) {                                          \
> -        tmp += 0x100;                                                   \
> -    }                                                                   \
> -    d.VIS_W64(r) = tmp >> 8;
> -
> -    PMUL(0);
> -    PMUL(1);
> -    PMUL(2);
> -    PMUL(3);
> -#undef PMUL
> +    d.VIS_W64(0) = do_ms16b(s.VIS_SB64(1), d.VIS_SW64(0));

s.VIS_SB64(1) = upper bit, OK.

> +    d.VIS_W64(1) = do_ms16b(s.VIS_SB64(3), d.VIS_SW64(1));
> +    d.VIS_W64(2) = do_ms16b(s.VIS_SB64(5), d.VIS_SW64(2));
> +    d.VIS_W64(3) = do_ms16b(s.VIS_SB64(7), d.VIS_SW64(3));
>   
>       return d.ll;
>   }
> @@ -174,23 +153,14 @@ uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
>   uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
>   {
>       VIS64 s, d;
> -    uint32_t tmp;
>   
>       s.ll = src1;
>       d.ll = src2;
>   
> -#define PMUL(r)                                                         \
> -    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 2));        \
> -    if ((tmp & 0xff) > 0x7f) {                                          \
> -        tmp += 0x100;                                                   \
> -    }                                                                   \
> -    d.VIS_W64(r) = tmp >> 8;
> -
> -    PMUL(0);
> -    PMUL(1);
> -    PMUL(2);
> -    PMUL(3);
> -#undef PMUL
> +    d.VIS_W64(0) = do_ms16b(s.VIS_B64(0), d.VIS_SW64(0));

s.VIS_B64(0) for lower bit, OK.

> +    d.VIS_W64(1) = do_ms16b(s.VIS_B64(2), d.VIS_SW64(1));
> +    d.VIS_W64(2) = do_ms16b(s.VIS_B64(4), d.VIS_SW64(2));
> +    d.VIS_W64(3) = do_ms16b(s.VIS_B64(6), d.VIS_SW64(3));
>   
>       return d.ll;
>   }

Maybe add a comment for high/low bits in fmul8sux16/fmul8ulx16,
as it was not obvious at first. Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


