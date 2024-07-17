Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C6FC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1Yd-0004YS-TI; Wed, 17 Jul 2024 06:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1YY-0004EA-L8
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:06:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1YV-0001NV-Si
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:06:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso49304855e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210796; x=1721815596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWs9JejW3FZ56shDFAkkM7BYfXb8T8koH7owpOUML98=;
 b=e09eHbSlF1V3jguIRp3qx1Eg7JPyEAMBiM0snR07294d7awbzB/zofD+lwTVfoD+67
 FeGDqC5lQgrl4hdRfAvcaliyDkxMYYTbRrn2hcWr5JxjiIUk0qRtRMVLpun0kZkltqPR
 msO4UH0hjEVH+KJawiPmNnjqZdD/Um1Vai0Qiz8FknJcSYoPJJAIgxmtedYK/cijMt86
 pUC005hOTESaP2IsAtLDVkzOa3HrHQZShjF3o9Q/5ZR6s7yA8gRGGN6PajsTF4Xh9siQ
 fxG7DSt+bGEZJUdnQElbOt5btx9iu5yUH6ls9IBxvj5cz55KmxVkhrBRR4DC0FrVfFyQ
 Xyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210796; x=1721815596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWs9JejW3FZ56shDFAkkM7BYfXb8T8koH7owpOUML98=;
 b=QD1zBe73+hhmHq9VmHmH7M5jp+CQFOebFHkt4riWhzGqLRficxEBNKl5sJ6VjTjaFp
 Tb9iFd1a8XslM+PG6mHQM/bcIPO/j94bMsgORcHktbbidlYBxPHIChgcS6vGAeQFwtVb
 akPH8SHIdW4cYNaj1JcC7kYBFMMpQydzjkD5+N8+uBJYWWRzNiukFz/DORM5oNuEkJSS
 ovgWvLCN13Ieve9Yh8RjwDtyCVD2cCzZT0NQVmz7HB3pY6TOrC4/qJsn2gg8Fozpixlx
 N1HEnpb1qSVQ6wTPrGUMosjOiTt6imcbVSysA9nw1R6LMvPxsqyf59dGx2WzCIkpUldj
 Gt6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXifIIEbW8kV+MaCFA31G+qG1vxH3nT6SGVZfyYcVhxRv/VS3DzA6nD0+FoKXqZf1QKtNxEb3Dc52bSA8aaBhWW2O46bJY=
X-Gm-Message-State: AOJu0YxlF6o0Ow3PAtBOPI2+KXsQPh3EeGWcOVICjC0FXobQk1FJBsiK
 +f3IabA5UQFoY96EVfZ+qeRadd43ebcCIe80Q7FEYofJW+XN+GyD0hB7y5IW9FP4rGxYbqPQYGg
 +Q9AxAw==
X-Google-Smtp-Source: AGHT+IFjkHdZLwa5ZlzY+08ISXSzpopV+BRpU4qeyUYZB+7i2GmCQy9JSaUa0Wbw6ln4YPLO9U63Fw==
X-Received: by 2002:a05:600c:1987:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-427c2cfc334mr8405175e9.28.1721210796462; 
 Wed, 17 Jul 2024 03:06:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef57aesm160999995e9.45.2024.07.17.03.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:06:36 -0700 (PDT)
Message-ID: <343303f2-b348-4ad3-aa54-b8bb137f732e@linaro.org>
Date: Wed, 17 Jul 2024 12:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] aspeed: Load eMMC first boot area as a boot rom
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20240717063022.549849-1-clg@redhat.com>
 <20240717063022.549849-3-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717063022.549849-3-clg@redhat.com>
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

On 17/7/24 08:30, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> The first boot area partition (64K) of the eMMC device should contain
> an initial boot loader (u-boot SPL). Load it as a ROM only if an eMMC
> device is available to boot from but no flash device is.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>   hw/arm/aspeed.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


