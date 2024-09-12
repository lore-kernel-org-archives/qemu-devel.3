Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD7EE57C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socx1-0008Tb-Sz; Thu, 12 Sep 2024 02:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1socwz-0008KZ-QO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:05:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1socwy-0006Hz-4U
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:05:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cba0dc922so3871945e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726121102; x=1726725902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dXnBCnkfutKcpo2PwnmB8MU873hsmF1ZdbdMWg8c3ks=;
 b=w10NChgUXeJy+0nRYzFHO5qg/QcOBG1KU8MTTIAb7zTJTXFGIgEswxic/FQIPIuwDq
 gZ8uuFPYIxjSqhQmrQATyZ5F0lvd8k2zXirQXM/4XYu7ogGMk2YtVKlSozpHsl9kpkOr
 wJOvTZQrkYsZ1PB/28DXKGLGuMj2M8rJpI8HlONVDE16vnjzMezfblYHSdpBHwcAo7To
 46YCPKkrxr8MdkBddnML4uZm/J0K1NnTwcwllv8HklApi5zLKnrurPCmUcqrHpAO7DMU
 iian9sVMFA9IUchooqCqokATp6WFn9iS559qzWfaKfdvNMi+a9mjE6f/5DwMzrjt5hgX
 ybbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121102; x=1726725902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXnBCnkfutKcpo2PwnmB8MU873hsmF1ZdbdMWg8c3ks=;
 b=UvX6pwpQKwQv63QmmaUs/lYInBQLJVuMhVBUfbUaFABUzethzLp3eo9RK52dPk6WrB
 1GlN46miuaHQwcSk99fobKBRACs596tIMJXP+JoJIyJKIWxbvB3Y3d2HglSkeWNbEcwC
 73KqSzImc/pTvipAVX8djEIAlSdE/ArOSDFj413zpheSi9g1s98e84CCNyYN71ajL/Qe
 akhaGiKRyWURodFgsonuRv7Wz6bp+/g81ZieN613ngxI5JjBzJnstcw/sigREqdFBJs4
 ryzFaRsPsf/ApSnjRBTcS5F/BpSH0AS7LEMV+Q79TTBdQq6805ux0e4zREu1wJXtBjGH
 PIpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE3YyVU6jTZ+6kX/ytPyOB2iDGy90xQb0sl2A7gZCQYyp+SklVBCUh9l0Ji7BYtjOn1kTNAxbV0O2n@nongnu.org
X-Gm-Message-State: AOJu0Ywnp7b60looORbBLXWQe1/3s/o82NJc5MXNqSEKVXnNANtZxMsP
 0YKpeHkjRTgI0NotmgfcdZJUUjkEQ82byLfZXrxvYhc5wQrD/y603t5Lt0P5LL8=
X-Google-Smtp-Source: AGHT+IFkKd5u+N8I59yYumHwRGSpDyxrvwYBB3fPgGvMfk32e62KTlsphGnJ2p90IUHHtLxV1RANOw==
X-Received: by 2002:adf:f5ce:0:b0:374:c7d1:2ac0 with SMTP id
 ffacd0b85a97d-378c2d4d5b0mr838134f8f.47.1726121101859; 
 Wed, 11 Sep 2024 23:05:01 -0700 (PDT)
Received: from [192.168.69.100] (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de3d4sm13309794f8f.108.2024.09.11.23.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 23:05:01 -0700 (PDT)
Message-ID: <6f75cf13-c08d-4d90-aa18-e6e4308c7cdc@linaro.org>
Date: Thu, 12 Sep 2024 08:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] tcg/i386: Implement vector TST{EQ, NE} for avx512
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
 <20240911165047.1035764-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240911165047.1035764-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 11/9/24 18:50, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.h     |  2 +-
>   tcg/i386/tcg-target.c.inc | 31 ++++++++++++++++++++++++++++---
>   2 files changed, 29 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


