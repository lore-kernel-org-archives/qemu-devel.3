Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A3FD41D50
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiPF-0001EX-C5; Thu, 11 Dec 2025 10:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiOr-0000wV-4G
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:16:18 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiOp-0002Tv-HE
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:16:12 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c75fc222c3so110716a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765466170; x=1766070970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BT/8dCuDOI878dHLm1mn0WEOHvavhruJtyOKrOz/p34=;
 b=d4Olh2SOGhwmyLyphIFxqwEp0iF2gp4bU9ug7iGG5Ex7SYxuCTuQc7mrbwPl/OwgoL
 Z0ZhVVOpIRNyVzgSFDAsBMZmXEWgjM2zm61rP0rfRneRxHFhxIFE+xL/UNiVe1D3w1cN
 RO2aUFjMatOSpgDkRUJGPoH0PXZx4oc4hyPrTyw6VF6OvuJPBW34JqTePQuFguE+CNU+
 3puJ9yU5WQvZUwpwQeEtEHho4lcdUfTuKnf5SuqP1bSpMBYoqmietB90L0Mw3hoBD9l2
 mXmZzF0vAEV3Wj9V7/Sm4vrmnGTW43wbv4BjBMLQ4P8LL6CP8Gwe8gbx99Jsc7RdwYzW
 xwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765466170; x=1766070970;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BT/8dCuDOI878dHLm1mn0WEOHvavhruJtyOKrOz/p34=;
 b=iyMGS4c0etruOTEbFS4DhoYZIJaWfuhdcEP0Do4411b0L1XGZkjQXMvd4z3LXkm7qT
 vH5Fa2DyXv/IrthauwOTVDm5Xw8Hs4NjWzL7QrLiyDHdansBZSLOyd26YRy4jRjXf85H
 JdWe3yMN3+1cAhXLZbDvUx31E0KFYT/EUUocOh2eg8ap+/ocT4bXCwnqYc7A8DAIG0RW
 9Mb2w1GeYXU3qO4+y6LTZQM6SZg1BfmAfCMwS97lF9zpyyrspuft7UOWOFqrp5I0IYoV
 Ew5Z00whNsA4BnQ8ohe1p2HL6lVoufeVRY0S/WZPycyLN/IbDCpTSQYPbL/CqYUwuUZG
 Ua2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtGXshy/YkuWJip2c1C7qV3MlKITiZ/R+9AqurMFBRaRkFcJwHKyWI74XNT5oztg/Fv/SL72RsJa7o@nongnu.org
X-Gm-Message-State: AOJu0YwetgQr0s3wk19WrEnMoB0oOl2cy7bBgcrKvevSsuyZBMjJUrsU
 P5ERQFNxRkVT8PyYzRG7dyVuGpZTlrLTxrRcdVvUnH1Yr3mRn3ai7wp7P3mPz7z778I=
X-Gm-Gg: AY/fxX5OmoG+FUQ6G9lfRQkdjGf/3Lkh2/p5IxNsI2BioEG034uT1BJAV6bjyQH0Dhc
 sUWlxbKdKyaZPxiy0qLPeK8zRTIohN4WP5SRSwt+dI8vGqzNwLv29+fY6DxgIXPhbugI6MI/h1y
 NilnKtAkA7A5l0ORMt5U3SlnieuAvzMhhjpWOs+eVvIrP6gqV1jPJqrHq7VZ6tNoW9g0ddfXU2w
 Macd1Fug8FG5sPMa1wDx0ROytIYUbStXgMfUCXjK0j7y03hbfaM/f1JP/brU67ZYUT42o7L22t0
 /4lme/l7hOzGFf1hoMOJ+r4fU6iWVGwaRlOhbnSGijnMlb6I0aNlT72Teozgm7dclUDyQVFuEPZ
 eNUUZKeppmkPO9K2KNVlEgbuykJLHz3/LBwVj5Ncq0yKM3sQNSox32Uhc4oTzI8t1CWEJAdrDit
 fmcxiGtRMVxsVj/fbbTZo1u1khGRa4qCiu2aLdq+jNR0+5IG1V4N6uXU2dtDuouYm0
X-Google-Smtp-Source: AGHT+IEU7VvkrNIK2pvDmXMVj73XD/2hVBGdwL1loHSEfVaILG1PfPLOIbMf1QhGehh4xP1U/aATcQ==
X-Received: by 2002:a05:6830:2685:b0:7c7:5f8c:71a3 with SMTP id
 46e09a7af769-7cacebbaa89mr3717158a34.2.1765466169953; 
 Thu, 11 Dec 2025 07:16:09 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb325df5sm1560689a34.24.2025.12.11.07.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:16:09 -0800 (PST)
Message-ID: <14cfddac-5284-4fc4-8fe2-19249d52240c@linaro.org>
Date: Thu, 11 Dec 2025 09:16:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/hppa: Define PA[20|1X] physical address space
 size
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
 <20251209-phys_addr-v1-2-c387f3e72d77@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251209-phys_addr-v1-2-c387f3e72d77@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/9/25 07:56, Anton Johansson wrote:
> When converting virtual to physical addresses,
> TARGET_PHYS_ADDR_SPACE_BITS is used under PA-RISC 2.0, and an explicit
> cast to uint32_t is used under PA-RISC 1.X.  Replace the former with a
> more specific macro limited to mem_helper.c, and make the latter
> conversion explicit by defining the size of the physical address space
> for PA-RISC 1.X.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/mem_helper.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


