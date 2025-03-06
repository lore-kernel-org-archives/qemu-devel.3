Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FB2C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 11:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq9LC-0000zN-U7; Thu, 06 Mar 2025 06:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq9L6-0000xE-Ap
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:24:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq9L3-0004u8-85
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:24:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso3156205e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 03:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741260014; x=1741864814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HJNAeTclzrJu/1gidpgIOGQUjYoAhWww8QSzUc7AnBI=;
 b=Z5vP3zHl6mJsSENhc/fTt6yfIn3GTPHwHAoQR+DTARUFCxr7DwBWHGtZcsG9xqWYud
 60DOPDU4CL3DmO3AUOIHPt/z8gAHkYnWlMQ13NMB1jAFVW2NQ0awk+RO7vo9I9MZFIEU
 GyFG3QY2RA/U56ugfqzuoOqhm74FkWxaCyLIdxyqt8lFTDW+csnKF+8gb8M9nFgQuZw8
 Ml6X7nlnK6lCUUF/tg6XWCRkifPE308+/ozKKcIdiCnRz1Dw200zVbqqnzuSm8m5zkCR
 3qBlg1+Y7t6LMyjXvD9M8OAXYPX75cBhfLS1jm/0V9LismqE3PK7+Fpeihq+uYmwheKr
 eCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741260014; x=1741864814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJNAeTclzrJu/1gidpgIOGQUjYoAhWww8QSzUc7AnBI=;
 b=YDA8rM0cGURUhmg1YT4++umMTTzgDx+NE3fD2StRS+AtT1OSTet8E9z8hdjRH0rU2I
 B0GpaCSaau1CF281l5YAb5Kl11iFqiJgxA/1vKREkzj9QGVuwm+zv+idR1AZDOf2P79Q
 QWS4ZuV8K0cAq3hRLBdrtGPWIx+/EKfsNu0QsWWqkl0YnKsSMvo02grIbWeN0MA0DCBp
 WGsxUy7uBlGi5SaKMXghzI9v4LeYV3mQsxvjfgXMW/pq6M9ivL2z3KRupqMQMBSbh9BJ
 P/iGhjdH5OJwuJdZMhiraML6j8VY5VOwsUWAcpfJBCidhQF9DXRAiVQiD17M0+l2LMKJ
 fGNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdaZLF8zcrQGFyJbXdCJ5RhUbNq1sLuv5CwX3V4D8bA4u/tjSktWSzVAgOtAVvXOnU8Kp5acns/+1n@nongnu.org
X-Gm-Message-State: AOJu0YyUfpNt00heEsTsYPY32Ojvl2b9Ve5ZeFOUF9lDs+5dK5V2ds8I
 ug8H46b5WnoOnl4tOcAppuWC435h3fIymJGQFYC/JjUNXxy5xOVyrO8AJRwqqpw=
X-Gm-Gg: ASbGncveNT/rwDyJJeRGJbXFE/7GFdbT4gBBZLJCuLDnuDLizzXdE+0NQjVRppyhi7p
 q3w9+Ea0P/ItJDCWMGIuRPiB6NjZkdsUdT2L8cYIYijkG67/DL4+ikrffvT0wOUgeirtB0mPY5a
 6N4ZGROgPtlHaVaiRkz3IGlzp9IrHdMupM2SPhJnw8aw6wkooi7m+ae5sjCvnxwRyp7hBBfdNga
 C9M8fbtTvflZEvsntebni6KLpIsM98Ot4fGheCSVfMtGp/GJSli7tLvS06SX5W2xquzu1gp7bfq
 OjuruXEmrjoKNikedLdNqp+UtBSzAV0cha7k+HuyDXXvbm94X4TWQyaRUtve6xPi1XGLJB0DQkH
 lfeMLo++Z+b9c
X-Google-Smtp-Source: AGHT+IEoCC8tsEjxdEQouzX7qFk09CshQOPojXc6yMFUl2aCemTYMvQwLZbB01gyQGz7MO/ZKc30UA==
X-Received: by 2002:a05:600c:4ed3:b0:439:a155:549d with SMTP id
 5b1f17b1804b1-43bd295351bmr55436955e9.12.1741260013701; 
 Thu, 06 Mar 2025 03:20:13 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0548sm17558915e9.6.2025.03.06.03.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 03:20:12 -0800 (PST)
Message-ID: <41b5712e-d024-49d1-97db-756a5cbc2129@linaro.org>
Date: Thu, 6 Mar 2025 12:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add docs/devel/testing/functional.rst to the
 functional section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>
References: <20250306105124.702131-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250306105124.702131-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/3/25 11:51, Thomas Huth wrote:
> Add an entry for docs/devel/testing/functional.rst to get notified
> on patches that change this file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


