Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A03C2A062
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 15:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcPgA-0000gD-Ok; Sun, 04 Jan 2026 10:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcPg7-0000g2-Oz
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 10:05:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcPg6-0007Bp-8O
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 10:05:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so104914285e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 07:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767539156; x=1768143956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PNrK1QkDmBxXNOa1hK84RT5Tp7Nd/aMgQ6rgj8dz+Tw=;
 b=uGJ38ImwhLparu2Ep+sXzm1KJXbdNU2qn2ZbXbWrTMNFrIwfzVfRjit9o+wP4z30q5
 nIEAH+BRdhGTD8Pjvy5hiEuCkTNC/L5o8Ke7A4zXeFrGvgpgDxH0jGsTc2VO7rVNckKz
 QHE0l2cBGT8bSmqgEBUYHzLnYDliM98ygAjcdlOT+lHVWYN7c84kbcZWHqaRpDIXcUvg
 GgfxfPhKhBmHpTzBdL5ZA0PGdL+Iwudx1O3b3sgppFuXKfj5BDmby183cOJ6/c/LxRTO
 lHidNCQJqdx5NQOhTqQbPLrQbaAgPEAQKU9i2GFZCxHBgP75QwA33sNwgzHblG1n52RV
 qgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767539156; x=1768143956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNrK1QkDmBxXNOa1hK84RT5Tp7Nd/aMgQ6rgj8dz+Tw=;
 b=BCLS91tFxs2p9U3ZyYbFM2S1je4nMvtIIbrFjmZHKbPOSPlUUuybMpQr8qJ8QmONUm
 Mmk0e7rYPqA9dy310ZQR/cU3gZ7q6SmhHclg1+HSsMDcnqFgyuMhATKelXu2Y0+iKY8l
 i52PHfICHACCH6zbdfGIoozWoW/hLvk0y7txomRyBIFpqECGcwAZmHs+c2V6iOFWN1hi
 xlSvYUicxI1OjiMMOGPAJ6Em0G0FQj5OhPB62qUN10Yz6MWRxuFaE9bZxzHVgEqD2eut
 TiptgmE4s4kSn+zVFGXs6k+HOYppD1s9tYs9EvOvM3zV8FgmNHHhf2OvPvXc34euSSo3
 OUzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9EjI+cawQFwSnhRSFKaP7+EPDwySJ4AsxwTKiaBJ4pi3FuEF0hH9SQvXje/UIvTKhhF7fukHr6jIZ@nongnu.org
X-Gm-Message-State: AOJu0YzSau162/pecEHFsoXnzZDJxY4+P8vsYntgMIAZ9tqRCnAZL1AE
 L1TJKMR/0a6nlaB2Cb5mciCsAye53P+cjLXruE5pjQ1l1q/48cQx+UbkUBUlWEQn3nK9U8mESFk
 a3Akc0rM=
X-Gm-Gg: AY/fxX4YpcS+o648SrvjbPIwsF9Oelp/VTnDWD5wqbsoxmSVH/2z3V3C2JXBFoZvAUg
 MjjAJqv+BpdFP2Rs9WoUU6pblWPRJGIUUKHEEcWq1hl2JiMqbH+RO3e+DsVhkHpCFlzNiVfKeYb
 gaoLzquwhimhP8d9KUBUg/euHQMiXbDcE1kGWP5JRGCwGd0QIAGt8an3xD+w7cmpLgQ3pIPEOvf
 +s3l7FqtraTj7b+1woYxT6KmN0IQCWXu0oRSZRWl5QDoAFBQ4OGV3FbaQjRIpSt0HPWwV9uDlTg
 ZL9TQOd7eqgKFn4VV6oP824XxKpYrlqzGBlueCUOd666gb4khgTyPo7Rw1mg//PkPxUxZC48aOH
 vWHYnMf3ePNkysER77uV6zfr2w3D/BQGlueSbVbMdiQdTvW5oQ/7fdMleGbhjgjRV7xsoVdFwMn
 2URdkeX7LWRk0azRTj9ifoV3I/Uhz52BrGoB0P1Gy5np3mAes7xM4x99OQLnhLl2vJ
X-Google-Smtp-Source: AGHT+IGFZNmsGktLASND2xiElwJgyA34alcuf5Uww4yn2NbHIJNeMC7LyoVTYOzrM1OscY0rLKqjYg==
X-Received: by 2002:a05:600c:8b11:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-47d2d273515mr582537645e9.19.1767539155696; 
 Sun, 04 Jan 2026 07:05:55 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d34472dsm101438915e9.13.2026.01.04.07.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 07:05:55 -0800 (PST)
Message-ID: <5d3bb3d2-03ce-4101-a05b-625445f84dad@linaro.org>
Date: Sun, 4 Jan 2026 16:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/loongarch: Add detailed information with
 CPU Product ID
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260104022905.2120787-1-maobibo@loongson.cn>
 <20260104022905.2120787-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260104022905.2120787-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 4/1/26 03:29, Bibo Mao wrote:
> CPUCFG0 is LoongArch CPU Product ID, it is a combination of Vendor ID,
> Series ID and Product ID, here is the layout:
>   +-------------+----------------+------------+----------------+
>   | Reserved    | Vendor  ID     | Series ID  |  Product ID    |
>   +-------------+----------------+------------+----------------+
>    31         24 23            16 15        12 11              0
> 
> Here adds detailed information with CPUCFG0, it is convenient to add
> such information with host or LA664 CPU type in future.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 12 ++++++++++--
>   target/loongarch/cpu.h | 10 +++++++++-
>   2 files changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


