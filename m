Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59970D132A8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uFa-0001Cy-O2; Mon, 04 Nov 2024 05:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uFZ-0001Ci-8Z
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:23:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uFX-00081H-NT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:23:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso32996535e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730715834; x=1731320634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UK3BOn0srHiEgicKGwdWc4VcuHmtUtWt3iN0HtfNJsY=;
 b=wPVR4TrxjRr/8Dxma1blO98Pr7tbrUw04KKKqxBBumhZs1Hrnyw68RmvqTgnNv75dY
 phMUNIu8gxpHFgs8doQGH9PaZSqtVgOmSFDexkIrgqj4aD6ogVLH4CLP++dNy7Tw3erz
 VeQuptQYb6f/k490Kb/mRgsWDpVEh7aYgfUoiq6GAlgOJ/JFZMYeWjl2nEK5dGz6ui5n
 qiSodLLDZ2AI9ZpEMYSPKRvGBtf6MLwNeU3HYAeTunC4p+rcrW/YeaCqysURgzXXwxGs
 O1ftW7vGnYnK1NzR+8W5+TVoQ1RXQe/bdwyReNWFFYqADKrYmrKAmTQTh/FQAyZUKD0j
 0UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730715834; x=1731320634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UK3BOn0srHiEgicKGwdWc4VcuHmtUtWt3iN0HtfNJsY=;
 b=JystHPlFbyC3VDWEAgK62auRzqaLPZ0NcYzkL0Ho6PB5ZGWr9d5zgOYCXYrbiwFh7V
 OylJClwi+rUXKBjMraTHSs9Ruxu/JzhFjrnwNPNjE0/qsygs5SFy2/Yl6P5byCqat19d
 u4adqP4+piZhcvreW2vRjwS5SSJgX7YP1f3nklHJe7m6LcIXn9YOxCdRxwvb0RM6O5PK
 KhpB8hr7txui5VZuQI3bAWoNuIFGyJjsv/E0CMd0n6HXJWQroSnaOJYEhMKF0T7eV8sK
 FLlzmgB1vgOKpGPod3WPBOA618JKbMNAZs7A9rcFQEjVzPgSIT3RjlaVG4LY7/14X3JB
 Pi7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9JA3qSdXW5L26HYAtqf8bf3q9SNq+1DAd1eE5D07EfxVEoce+ilSivmvz8ymP0ULcwdfDdjIQ7cBE@nongnu.org
X-Gm-Message-State: AOJu0YyQW+jGNxcu4JDSylIIIdZKZ6ELvrqjTEQQ6/AnEX01ziArk2/Y
 FPAFmyfmQeGvYjganONH9pBi02H7qlM5T9rgBHzvSKpML9DLZLP8fenFpHhJIKE=
X-Google-Smtp-Source: AGHT+IFs7zB1c8xEWpDcok5sBBcP4Qz8pHMGh6gcxXyT4rWbRjXXza8mjZ0or/u4o7wba7ZDAPzAtA==
X-Received: by 2002:a05:600c:3b86:b0:430:5356:ac92 with SMTP id
 5b1f17b1804b1-4319ac7642emr273102245e9.7.1730715833761; 
 Mon, 04 Nov 2024 02:23:53 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a99d3sm179744005e9.38.2024.11.04.02.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:23:53 -0800 (PST)
Message-ID: <124c839c-6e2e-4377-9d4c-825a2e8bde18@linaro.org>
Date: Mon, 4 Nov 2024 11:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/aspeed_ast27x0: Use bsa.h for PPI definitions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
 <20241101161125.1901394-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241101161125.1901394-2-peter.maydell@linaro.org>
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

On 1/11/24 13:11, Peter Maydell wrote:
> Use the private peripheral interrupt definitions from bsa.h instead
> of defining them locally.
> 
> Note that bsa.h defines these values as INTID values, which are all
> 16 greater than the PPI values that we were previously using.  So we
> refactor the code to use INTID-based values to match that.
> 
> This is the same thing we did in commit d40ab068c07d9 for sbsa-ref.
> It removes the "same constant, different values" confusion where this
> board code and bsa.h both define an ARCH_GIC_MAINT_IRQ, and allows us
> to use symbolic names for the timer interrupt IDs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/aspeed_ast27x0.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


