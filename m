Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE05CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbaF-0003qy-LZ; Tue, 19 Mar 2024 11:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmbaE-0003qc-E4
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:40:58 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmbaC-0004Wa-VU
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:40:58 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-222ba2a19bdso1742167fac.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710862855; x=1711467655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cptbcDRdwDDZRyUio5HkEBYIV0GY23oMsOket/3lj5Y=;
 b=W1EVLmoOX8KlqASDvT3JWlHYSYa9LS7KSfAwblbNvvPdbJ/rBCk1Fi+BPkeNyHqHPw
 q4tAEfXZmAJp9w9f4foXiP9QbXTHWgKrAxb0LjIMLaMob3XmIHP/2dqkk+6pseGRF6zy
 k79ktP3eIk0VNCyD0zbo13PA2tAJ3bOaWqfafGkNISzuzqFGwX45MOnMYNpQlL0iaPRv
 5DwS9Ovh4YL/7eC9BhmUFyEejXJopk/OLynQfu574LFfK/YviNBqYc+7CVcAw1RDxAyQ
 fM++/uGvU3jtpEWUAoZEpppP+sqjUV270AQs9JdFEgRmgvywOc4sv7N1GZtRWVE9R3Zy
 3LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710862855; x=1711467655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cptbcDRdwDDZRyUio5HkEBYIV0GY23oMsOket/3lj5Y=;
 b=rjFuleWvTqyGmCzvF0f1WRmELoteiIFubh7uV0RPdm9J3bPjUx7Eyxvl1u6QcSjx3p
 uBzpWaNjPrRZs1QCxAozRtbjkjUSFriFugrRTwJcS7JbSU4blR7ssskZD4TkQlmXwxTp
 9yEqSK60qcgH+uRaQ14fVGVaDI6eVFM4FcBIaqWv+y6vJrX7ZM/I9YNk9NUB1Znecxp9
 YwHVeEBbk/JYw44/ovRNytWN0WALWaVCl9v7rmLPFzcbP8BtO35RWUX7zBeSJ9H1GKLW
 TuXCrW/fnZZZ0un+/dX23Dy1lUIL7gMF0jZKeeWX1awz3i0z8gDDD+nNAC4xcwiAeHRc
 Luqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK5ybngDBAuwHWL8Tp1ZeZb8TOYL0omA6smudhV8YZOP4aIqIjNYfl3iEclgI2xcDdybxxjPHcZ6fybAnw+FAd1epqPb0=
X-Gm-Message-State: AOJu0YwYBhZEE1e+Qz5xQv7vAIaL30X0MUsVwLd7zh7S9SnXnhDEefN2
 fgLsl5l7nXA+jH40xdRN2poY/Yy7CRxseS60ULsGeJzk2pllWntMHYiqkjvSa60=
X-Google-Smtp-Source: AGHT+IHGgRPpG89phpiK8Wfa+3/RDlLwLdpbWxPosX3v3uvcN6GAB1HhsiFEIt3yMQADECPf7K6dYA==
X-Received: by 2002:a05:6870:238f:b0:220:d080:ff68 with SMTP id
 e15-20020a056870238f00b00220d080ff68mr16570875oap.44.1710862855589; 
 Tue, 19 Mar 2024 08:40:55 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g20-20020a63dd54000000b005ce998b9391sm9146581pgj.67.2024.03.19.08.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 08:40:55 -0700 (PDT)
Message-ID: <74470370-9fd1-4342-b8d7-c2252f14dae7@linaro.org>
Date: Tue, 19 Mar 2024 05:40:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore/helper: Use correct string format in
 cpu_tlb_fill()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240319051413.6956-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240319051413.6956-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 3/18/24 19:14, Philippe Mathieu-Daudé wrote:
> 'address' got converted from target_ulong to vaddr in commit
> 68d6eee73c ("target/tricore: Convert to CPUClass::tlb_fill").
> Use the corresponding format string to avoid casting.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

