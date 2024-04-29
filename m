Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB1AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Okc-0003LC-Nc; Mon, 29 Apr 2024 07:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OkG-0003JG-CR
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:00:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OkE-000791-Pk
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:00:28 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34d16d204f4so521599f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714388424; x=1714993224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zwl9VwpNkqe+4ZMDVF8b6vbFpYsp/f3F2rnAGZt6T8Q=;
 b=Sp4PBI2V7dfZ7sjIZScKjbcgViUuirFTY+QdY5aXTED+aX5qu/p9fVEn1RUficBnLR
 XdFkk8E/+dPS2Dihf1uh7aZjfdYkWa41jk8slYXLyrvUyJ+9lVzwHn0n2k2nKPQ8qtAy
 6cBbLvTEmliD/kNDy++XvEyDz7JJeZTAhwJoQ23IBiDSIpjL0Ft3QelIs1buftiXy9ac
 A07s+1Fkzrv2qLAxhk0ciuHRMR68vLtOxHIZ8HAVksKpQWQOh/CVyKXlV8p79Qo62eCd
 GGbYU+lk0djwVTxeZAAB13rx8mteSj0OQSnE2DSvClo/hY1zYsZK1P5TYIPYzbLsq/xX
 a7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388424; x=1714993224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zwl9VwpNkqe+4ZMDVF8b6vbFpYsp/f3F2rnAGZt6T8Q=;
 b=JDWg2GdR6IpjHS3vb1T8WvGcXbp8PQU32kSmh8KWdsnNDaor+iFd5GfQ5fQ3EWnnWH
 9pFAZvR6WfHUhkaJjowlY0AmaADjMVFmIgIVpdNSmwzwhbvfxGXmWi75bl1LPp89M24X
 b7yDeYTVGQwSjaRiiR/m+IaFEAZCPbJWKukx+Ke69giu06ghCDYcBAXiwGt5GsbH8piN
 2DMJrwCy/+SM+efDtD/F2TgxlRrBufhshjtfZvbixTDbSM1FjlgJ7s4yM61fDAeiZ3Eb
 x6ZGw0kQOlwa3wnEq8jxGFWOGpu37ycyElWa3aVjIPH8IkdDfwzIh7vYKrWrEGmQHPu6
 HQ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeXL/VBfHK6YZha/KmQqOTeY8pFPlIHae/2WCXYWId0mM+9co9zbXRAVJ+G/VufxIMXxTKuyx+bo1RgLosSpWobO0PbnM=
X-Gm-Message-State: AOJu0YwQfys2qD6Un0zqHTUVT8exWq7uH1sDj4L+oaSLvt5l1e2jkiOx
 EKcw57Azb4Pzc/gtKaYHwaGSRrpPkfhg+V7Pqxz1tdwwd5WGFUa2ayphgo0TRtHBvAV1/LSR4bY
 qmls=
X-Google-Smtp-Source: AGHT+IHDqz/i/DHz4gLdxjp8cN9xPHqzztz6NPD+oy97eniyq2zkCAZ75jGoi0O5o6rmKrBSxxfV7Q==
X-Received: by 2002:adf:fe84:0:b0:34c:f0a7:3675 with SMTP id
 l4-20020adffe84000000b0034cf0a73675mr2483117wrr.15.1714388424245; 
 Mon, 29 Apr 2024 04:00:24 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 b7-20020adff907000000b0034b3394f0e1sm18696162wrr.10.2024.04.29.04.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:00:23 -0700 (PDT)
Message-ID: <98245e84-7f18-4a88-a701-9083df9fbb64@linaro.org>
Date: Mon, 29 Apr 2024 13:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] tcg: Pass function pointer to tcg_gen_call*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
 <20240424230224.941028-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424230224.941028-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/4/24 01:02, Richard Henderson wrote:
> For normal helpers, read the function pointer from the
> structure earlier.  For plugins, this will allow the
> function pointer to come from elsewhere.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h             | 21 +++++++++-------
>   include/exec/helper-gen.h.inc | 24 ++++++++++++-------
>   tcg/tcg.c                     | 45 +++++++++++++++++++----------------
>   3 files changed, 52 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


