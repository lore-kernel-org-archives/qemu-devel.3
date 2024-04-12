Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF90C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKgh-00070D-2U; Fri, 12 Apr 2024 13:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKgd-0006yq-WF
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:27:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKgc-00036b-En
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:27:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3f6f03594so8537455ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712942857; x=1713547657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmqwLRBdO+Ogm7OZAmZsDA7CdHddyWikipuketaQvl4=;
 b=IoM+cA1INVof5BuZ6mi6DEBUoZG+euaADZnjlQTM7rUJ8Yv7/v0/2j/OX00YNDmXqW
 lgXpYt/IEdfWwBEOwQd9TjFNvX0AfZeGSonglJ21Z5PvDhhHkPfEfacUgC2+Y55RGDzw
 5qS+gKlpVrjWGB7V4AhhRuVCo+YOkjO4veqj86zTSZkYuq5diRbvMzR0GkuP+oI7hYuZ
 OKB7bkpVK8NM01XHwBdND5udE69chzAp7n6uEzgMARIgajD4s7vW/QxlI4nUWTpLulHh
 0uTb9aWLrlYfkRHMxTQUYSax9AYukdLaEjFJ0sJK9FsILyxGE30JTvpXovJy7AeupEVm
 t4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942857; x=1713547657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmqwLRBdO+Ogm7OZAmZsDA7CdHddyWikipuketaQvl4=;
 b=wwNsJlWIAKL1PWBcYoQ0QttI/Xr5nQ0Pzv6mhZYuX9hy4NuIHiPQ/VYR/o6KDC2XvE
 qvC/rIcwhoFmZ5xfQZ8S3C/rDGVdqQEjjeJt/c4/7/8LmLsulNLdnhr6lW3a2pIVnnv5
 K2LAVRblTR6s5DqEiYcQHMlfnCdegGdLWqpqXvwliXWvmv66OShOhM4PTUcZJgSr3XCU
 IooOZhJBxiUNldta4BOYUkALCI0YZDQDc88Yj32E0MLnem393aICxV7Xqa1K4YRKPvSt
 ED96kg5BvDpAj/r+DyejozdBopw3+/NA0msIPNVgZnHPPCVDd1heHNrzkWFaWbjKIqdT
 SOeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhGn6gMQWyVf4Odk47CpCRYCPt6Stg4OZCblLIJMyuQkfEvOvaC3lOtsUvRTMYw6VZvPcHbiYPOjvT7gzCvMas5LY5X7E=
X-Gm-Message-State: AOJu0Yy1PD21mHLbiLKQsV9SlFSHj0KILx7X4IUfLcu4NgWvLtK0BQAa
 T4NaF5Uq8qjvQktTTBNqiyxNabIg2pN4HqhgDwZLstdHI8BGarx9VWroY0o+OuLkOL4jLui0CDo
 F
X-Google-Smtp-Source: AGHT+IFgqTPjJ6tpZwYMPQdLTmVYdK6ncOc/iiDfegO4nvAtjXtWBTIQ9gs1WUZSioHx9L9P/v2MGw==
X-Received: by 2002:a17:902:c40c:b0:1e5:43ed:6311 with SMTP id
 k12-20020a170902c40c00b001e543ed6311mr3559655plk.49.1712942856965; 
 Fri, 12 Apr 2024 10:27:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kw6-20020a170902f90600b001e2c8bc6bebsm3241963plb.81.2024.04.12.10.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:27:36 -0700 (PDT)
Message-ID: <0a685006-ec4a-4c53-9203-b3f5b549a6c8@linaro.org>
Date: Fri, 12 Apr 2024 10:27:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] docs/devel/reset: Update to new API for hold and exit
 phase methods
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240412160809.1260625-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/12/24 09:08, Peter Maydell wrote:
> Update the reset documentation's example code to match the new API
> for the hold and exit phase method APIs where they take a ResetType
> argument.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/devel/reset.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

