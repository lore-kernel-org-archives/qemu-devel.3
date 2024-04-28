Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897B8C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19GX-0008RA-R0; Sun, 28 Apr 2024 14:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19GU-0008Q4-F6
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:28:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19GT-0001Yu-08
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:28:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed2170d89fso3137298b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714328919; x=1714933719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cGYj0DRbnxEZtlr8NSdwCFzPDZazpXilNgITXywj98g=;
 b=VFACBKCxGMaxuf2Ld4EflWpEinpC4oWGuqGw9sIyyVD3T5LRe5/blEL124EbxEPnRU
 ls88ZHvplMwmIybtLbqkICvxWBtP/bNsylrPUxVEf1PziA5PInfP+0u62wkC+8hV2JIu
 28QbwgZm2nnRLgzrUfc/EZiC0UsTh0LwdJFksAXHpX/dijzFEC5Jqf5YZWENMVNV6MKG
 rN1ll4CFQNuiZ/ScC6vIQjfKIAjCAnwGDUg6E9iUe+Wq9FJWgs8JjQQzXvDGbaDpsY0/
 3RPPWkXnDtOnbCtVUT33T/MX0EdtQSptRVFTY/3FmIDtqkIseOU8TDuN9TdmnwAp4lOr
 1now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714328919; x=1714933719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGYj0DRbnxEZtlr8NSdwCFzPDZazpXilNgITXywj98g=;
 b=vgTbEb0YJJSmQk1ZCVRrjisMPdJiEEaZ2WG6DkHAiKh1Hvv/dFxMbTMuEAj6OWCTHC
 W9t3NVQDhS88nFb5RaHh+VItmKvlhZQV0Iy8QqPmVO5VPVNOAQH127YSakj0n4t1J4fD
 +gwDZURVyvTYDw7kMR/pv3Sl/k+3v4PYBbBgagxnkFbULs2b1eHUA9QtnM8wh1O3wZ9n
 Io34z2s44Bm3T6JYUlcr/ym73RfPVLjMm2azLdF/Z0Oy3kGw4ZsNa2OYuAzYgemsT2tA
 FuUMu84vK2881RqGztoxqRDHeU8UlkyCciGLBGkpdcs08U9PUEfpiQ84o4MriG3EC+Ym
 05ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWijG9PwL1AV+nQM6fLAZuNL9Eh3gZBok4rr3WVWWV9XGulMKt6Kl4Z5q16CjJ11sl4MC3f1h+uHWa1GWcarZ8poVN+eBI=
X-Gm-Message-State: AOJu0YyVd/Qp18tbywyjE2vn+3k/o95GB7E7Roa75oAWv5OL/2p8z1iv
 mGqHvbY+E1KGHLi08LJgSoDh1x5ZB1qsb+Cfznki4bl+XP7v+Aqn6yYEAPjq9sC6V3eM3cDth/Q
 A
X-Google-Smtp-Source: AGHT+IF4wCDIKoITvLoHlIXOddJ/AIvYPqYHOUpDOfmIT3sGq06OgbHNHoGbIjAcOt2PpFTQ2vdiNA==
X-Received: by 2002:a05:6a20:565b:b0:1a8:2cd1:e493 with SMTP id
 is27-20020a056a20565b00b001a82cd1e493mr8687595pzc.29.1714328919605; 
 Sun, 28 Apr 2024 11:28:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a056a00004b00b006e4432027d1sm1923007pfk.142.2024.04.28.11.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:28:39 -0700 (PDT)
Message-ID: <fc5233db-4aab-4a20-8728-da14ee0b6590@linaro.org>
Date: Sun, 28 Apr 2024 11:28:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] exec/cpu: Remove duplicated PAGE_PASSTHROUGH
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> Missed in commit 58771921af ("include/exec: Move PAGE_* macros
> to common header"), PAGE_PASSTHROUGH ended being defined twice.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

