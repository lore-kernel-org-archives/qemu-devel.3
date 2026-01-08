Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31985D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwF3-0005rB-2B; Thu, 08 Jan 2026 15:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwEt-0005gN-3U
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:04:11 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwEq-0007GG-V8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:04:10 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-bc4b952cc9dso1703959a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902647; x=1768507447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QPG2tyQK+5rN3V2tF3uxAgiVPsBjUV/hvNBEvwv8D7I=;
 b=qwDpkBGDcpv8vgtGuwTHqioO4GT3sxPJtMjV5Tj4H7e94BjnNO8BWLtgvfKbbgtSKb
 gRfj/UDpvbLmvqbLMvrFCjbShWVjLUG+WBbef6+B/aWPncu10bUsa4egIh2smEH6p2vp
 uCCFn9LApFXYuAe8HNPcWmrbyDKpC2FCiV+Nd6qaSLzmq9TQUEyvjYl068qz9oQkofbE
 Pp7CSlXORTCBUDqunOS5BCmGTmhLXqEqafTX6Ut5ReIwNV7t+x3tRufb3gt7QyBfqvzZ
 8ABgAt72Kkq3Kz8ZIGl5N2HwWI4d5I1UWEui3TVMKQBK71lOwXml95+mGvSI58lzS1ZH
 hnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902647; x=1768507447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QPG2tyQK+5rN3V2tF3uxAgiVPsBjUV/hvNBEvwv8D7I=;
 b=XKdrIdIqP/2RJBhzmqMnHf59X8R3XEG6kJz/VGWVjW3Zl1+Wb43ZSWRLYzdHYYAeFY
 35STw5gohE8KbQxLceiyRBvQwPWMD+EjaUlfnZxxsXck00mrm3lXV8zTtD9hLi4RmwPm
 EFeJ0BnBMzyCUJd7E+p7ba+DKy+B0+FplufgEq3l48N+5D7McMI64emBiFeBOG+6197C
 oNYeZOhvXFdG4KP/ey4juW3YrA6vbxZJZC9XuEQmZ2uv0acTRgOFZrfDDU5uMM78yuA4
 xGCryTMMvv5Ef8m0FR3z71C2o+5m3vgaEBv7kSha4mrTuOgm1lcAydvVb5x4c6dZzw/W
 mCzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkyQ6FfwY/YMiWwqSB4mN7IOerGvYbgsDTLuLr8FmeKouGR1F7wLO47FuOcKslMN8zcDlBHgZReddF@nongnu.org
X-Gm-Message-State: AOJu0Yzyx4c9mB+LWhPcVd36o/FHDWADrR3WoltsG5TB77syGugYmRX4
 b4VoZG4ByjTlln4bA2rPcqfH5mAkOYxz2gV4XV7c1M/e0uMvDZrV2Fw7FplL66eiXYci+mokXcs
 kvCz6Qo0=
X-Gm-Gg: AY/fxX5a909ivcctazgfsUlJCTevyqSX4SXut2GCRxOplTIc2GZkqxrnvxOx9DNxCt0
 sLtaTVLUlJ3bryqJC+gpe1UjSDzAJO9t2LDJb0KAXF9rYF8FmaahH8qSOBc0jz4zcmIlYavAWfr
 V6xKa5jZd0R4Enp2LvPQonxaxweJoNvmlT/48Jle98gvucALX8vJYg5vXdacAJA8dpNN5BzYSQy
 DLjWG6qBUkcfS7NRHpzFLcbh598LUI7HWOtcpZlWmx6CBbbGLiqWnj3Ngi1k2el0SyScI5iVSgZ
 YNHd2VywonBKJRYX6TqwEOcBlqHDNor+l6Cy4zRNyRAMXtHovjgequ+ZHsaPTXvF2+azexm6iuU
 AK1hHSAt4eWJ8V+PCCfuTM3KtKEo5Cwncy4/NlZbHnMPS+3inKC5wiFADii/rYRYr/g9kndFPVB
 Ru5d0I0lL3w6nW5XHwSlWV/kEHIgRimCUPrfvherCrWr+8/gTr3pIXRBvC
X-Google-Smtp-Source: AGHT+IEWW4B9WbYBWVIhVhWkyiEwUd0LCFA186+cJRVN/mpRfdkxKevvzIlhIz+Rky2ph0K1ko0nBw==
X-Received: by 2002:a17:903:291:b0:2a0:afeb:fbb2 with SMTP id
 d9443c01a7336-2a3ee4f5a79mr62208465ad.60.1767902647235; 
 Thu, 08 Jan 2026 12:04:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88e968sm8716117a91.9.2026.01.08.12.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:04:06 -0800 (PST)
Message-ID: <b60ca17e-aef7-446e-9aec-8d9e8eba208e@linaro.org>
Date: Thu, 8 Jan 2026 12:04:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/50] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x544.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> The target test is TARGET_I386, not __i386__.
> 
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/syscall_defs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

