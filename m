Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F961C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbqLv-000164-Cy; Wed, 07 Aug 2024 19:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbqLq-0000tO-Ej
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:45:55 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbqLn-0000nh-M1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:45:54 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb55418470so387507a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723074348; x=1723679148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzhhrLK0XdnbzATMGQGKUJim0EgBLCGpBiUO6HMNPKk=;
 b=Drf5goodNHFHZbPG8P7G6GGGIF+44bCjz9Ae3LsH+2HULg881XfZ0f9xwm18KNzEoj
 c80Q7EbDd0pUEpf7z3AeJXi8eosv+mt1eH/OqDc4iL2t02I9zFV6FN0vwk1cbcyBVfF/
 XSaCJ8ra1qJWyg8L+4yq1Cf273AmFtFHVRevXQopafe+D367UiF5L/PiXXZYbZPfYpss
 aOH52hZJtgRC28Rx4jdlwSLqBH3q/MIAxKoVsS35rbiXfFmHbBnrY9u091pjQjZR3JOK
 TkVTK22/2g442PL2ug8xOVDuVL1aJgxmDA4Cuy9/xIO+tPdZ7sS5IKDZFtBghDZ+lWux
 rlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723074348; x=1723679148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzhhrLK0XdnbzATMGQGKUJim0EgBLCGpBiUO6HMNPKk=;
 b=IQgSaS74Corq9JHWMdluE7Xt2aBNOCCH5xYuLMg1RN2HNTOV8C+vgSZqngue7nuW7Q
 mVuAUMZl8xJYAmLDBNe7C/XiHyl3sfMC/l+v3++jRfl8Fpa1CooJYhKAJsFM0+VOsAfz
 TfZvc/R1/lqvUWtc5ESirKY1vGkFcmkFvu8l+V2boBNL2ueABo6djx2Z/KB/DwAohK2G
 xyYmuSPOiD44xVHQMAh0RPkJRqWrGV2yZodK9Dgoh+h+8NxktUOZOhv5ntsctVBtyeE1
 gr/s3cgURj1vZf+6fc0HN11B5lmFNNFmkC2OIK6bSj6pfBPB2a5CT0TwBbXWmrSwRzPM
 wZzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW1p+nENY0vL59/OY3kHavrBPMGCQXzC57E1cW5fFmJ/OQ7AhQPo2STpPobNLmdaZL8AqnDfdyEhE8UfOmB+mwJ929WcA=
X-Gm-Message-State: AOJu0YzXZlXRuRnJb6rUQ0bZxrQAeS2hhuSwoQtP4I/T5VL50jpeP4wy
 46ZUDMkK/juny2rKlUzvG19fKKAs5/ReaLUmTCHE33kvq5hMSdiDkh8fVYTkflmsfu6ceHqJFxp
 3GAA=
X-Google-Smtp-Source: AGHT+IEj6wN+n/mCyEXYVK0hnmPSyVsvtzE2xF7O/7uGpZeGqBKalmPRmYPrbqjAwFt7cp6EGV/B0Q==
X-Received: by 2002:a17:90a:bc8a:b0:2cf:2ab6:a157 with SMTP id
 98e67ed59e1d1-2d1c33a6c53mr215383a91.12.1723074348024; 
 Wed, 07 Aug 2024 16:45:48 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b374c708sm2176872a91.49.2024.08.07.16.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 16:45:47 -0700 (PDT)
Message-ID: <25e341ab-2f94-4768-a927-255962ed3f76@linaro.org>
Date: Thu, 8 Aug 2024 09:45:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 4/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Chalapathi V <chalapathi.v@linux.ibm.com>
References: <20240807202804.56038-1-philmd@linaro.org>
 <20240807202804.56038-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807202804.56038-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/8/24 06:28, Philippe Mathieu-Daudé wrote:
> From: Chalapathi V<chalapathi.v@linux.ibm.com>
> 
> In this commit the following coverity scan defect has been fixed
> CID 1558831:  Resource leaks  (RESOURCE_LEAK)
>    Variable "rsp_payload" going out of scope leaks the storage it
>    points to.
> 
> Fixes: Coverity CID 1558831
> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> Fixes: b4cb930e40 ("hw/ssi: Extend SPI model")
> [PMD: Rebased on previous commit (returning earlier)]
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ssi/pnv_spi.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

