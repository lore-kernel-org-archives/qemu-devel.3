Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEBEE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHZS-0000wb-VY; Fri, 10 Jan 2025 11:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHZQ-0000vw-Ro
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:09:12 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHZP-0005Zn-9w
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:09:12 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso16715205e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736525349; x=1737130149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kt/AvsVl5/ytpsm1lv8DW0pfgyMUih2tc8vKUxhOvnQ=;
 b=vd/qLpCuDvNOZXRjcCwTK1qfb1xHhjgygegClpByJRIm5/6TGOPDRwv9S0/jzYIqao
 OpHiN/7eFiKLGPVt5aVQRpgEJaFMwlCzkqQ1yyt0nJ7xdsrO5GCicEbGoJpyEpw6IGzY
 kvwsbazF8hgGK6AXP2maCTrEHBsbtCqcNoIKD9AaRLhsyJN9Mf/sTjzA2SztutssBopo
 43qyy4khAGmk4j6Irwd3JvShXiS3J1Sc/x7OdZW1pGvlM3PF/7sCk+jvp0Z47ZDpg+78
 DM1vfNDfKfgdduz7bkB61LtD6GiIsvBP0q1HL4cR/c8GVvVVPFCv1ZZetiWtckVBRwLc
 M1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525349; x=1737130149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kt/AvsVl5/ytpsm1lv8DW0pfgyMUih2tc8vKUxhOvnQ=;
 b=lEpB9O0FllRJPd8uoYFqovbqRJH7eEbohSQ4z2d3OE4+0RSwJ7so382hhcxFVO/Wt5
 usnESRTgC9yTa4Wtre+/v1qCW4zCOUm9KbtMFFZcu48hqfbXzm5jtb6lRWrLDm8X5dg+
 4CsCl20JnWyeuYKnASgbPE1aIpE87gGPANY2/8z6G7/g1ErpPnmPuf9uSzhVvqXr/HlV
 wTMfOUtBMD2Rpl7alB4aux9Bkp/J/YwFPQT4t47kxEQSUnsNTY02pKrT5wL21YpS73nf
 Rn2SsfONnY3M3InpEiYsUt8hVtTLEuDf+UCIiXxDCkyxQmzLAuhs/Q2ob5zLQrRI/CAh
 Vs7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyTZEfptWx0EGMCdmcbMQ/Xa5BGtWNt4vFbaoVyeH5ca6ng5YlnS/JL9mSasVKmfYUPRloEdJuEmnb@nongnu.org
X-Gm-Message-State: AOJu0YzJ8ZgTjZQNVwWTT7p0YAccA7K57VI4Oasex95qCPARIX89hbdt
 WelurhmaZEQLg8DThH2K5yoZ5cgdI0CBUgvxBHccMoK11FUzJ73wdATbgBL55Bk=
X-Gm-Gg: ASbGncvZGpu1FWRuW80Yan01B6ZUJDfVxvSLPO50TWVFiYm2WkgY1B1wDmS4w1NJG4a
 0mCdzKqnToblRxoFS/U9HBSfXuq6aRg0ukDeVTrMrLXCZ+ded3WjYsIWD3xk+sWUYpbI3V/SSNK
 W6InnUhAowH+3GDA3VLYwbsvqHjo6alzHnX6Ar50sgearnq9SkT8kf2favDe0SvSi24sDy/Ue1E
 F6vckywg9HyUPQBhIwaAOMjw7y1//IHAB951XwQrw7uu9LIj/+lVk44m3JD6wrcfgg0D9pSW4jP
 FJ05SuYQp49ms3lnDDaE0SZ1
X-Google-Smtp-Source: AGHT+IF6AtkExIRd7D73j9V3MSR58Atg/hCsxrQZvMmCGif69/BnN6poVgqb7fH6KuU5u/Th1DhXPg==
X-Received: by 2002:a05:600c:1e1b:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-436e2686279mr108136255e9.7.1736525349491; 
 Fri, 10 Jan 2025 08:09:09 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8faa5sm57733455e9.1.2025.01.10.08.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:09:08 -0800 (PST)
Message-ID: <4344c965-ec42-4159-83c3-84ccd290fa2c@linaro.org>
Date: Fri, 10 Jan 2025 17:09:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] ppc/ppc405: Remove cache handling instructions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-8-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110141800.1587589-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/1/25 15:17, Cédric Le Goater wrote:
> Since the 405 CPU family was phased out, these instructions have no
> users anymore.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   target/ppc/cpu.h       |  6 +-----
>   target/ppc/translate.c | 11 -----------
>   2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 504924f10561..f83f01a62a12 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2234,9 +2234,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
>   #define SPR_L3CR              (0x3FA)
>   #define SPR_750_TDCH          (0x3FA)
>   #define SPR_IABR2             (0x3FA)
> -#define SPR_40x_DCCR          (0x3FA)
>   #define SPR_ICTC              (0x3FB)
> -#define SPR_40x_ICCR          (0x3FB)
>   #define SPR_THRM1             (0x3FC)
>   #define SPR_403_PBL1          (0x3FC)
>   #define SPR_SP                (0x3FD)

Belong to patch #3?


