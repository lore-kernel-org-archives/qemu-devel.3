Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D05C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg31s-00071R-Ri; Fri, 01 Mar 2024 08:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg31r-00070k-8m
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:34:23 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg31p-00033r-Is
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 08:34:23 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d26227d508so23282531fa.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709300059; x=1709904859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NcOOQEf4RQ21EnD8rQbI8K9F9TSGs2RrcAlO5RlDB2U=;
 b=gnq0vQd9m6gzK6k2iFRRCmJkAeK69N3Scy1akwxt8MRe9sJbsF8FIKvm4q3xDfPRTB
 Ep+iFkuwSWP7tPLOH08GsS8vqJ2qEdWIAE4OveOFxvaPvOIpk3q+0qKN8B+sUYqmTLhi
 TpD0Z6IkhxyuQPyn77bofoEMhWA746S6Ww10sLki2Dpk6SUs1tMS1T50HAlj5ZvI2zD4
 1LMyO0ywIQUoURur6iADR2RXAocMmQLJbYRS2acYyYtea11IEvDVLBi3UbU14r6ho6hN
 mUMu2t7QiI0zKVcHARH4kOjneG6OB44uRdZdDU7fj5J4M0W+PwEaqUtbsyPEivFxzWc0
 HtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709300059; x=1709904859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NcOOQEf4RQ21EnD8rQbI8K9F9TSGs2RrcAlO5RlDB2U=;
 b=CDJYXCHV0JK83CrZfoU2PJBi5zU+6aGOf4cAymaWzdbqEgcRQNN0knwHDK0sa59zed
 QR3zZs8KirRB3VyygaWH+cKMlSDUrkB3rFX3ovuVTYEx7Kutjy7+rHWbZwn10lzeEFOt
 xL2aWsff8l4GNUZNpwZdg4yWpVYG4/fuqhzXpjXD5jN0S5JqdpYxKXneeTmx2QGPTlaM
 lZI3I857G83gBysjWS9uxYxs+PGwoaDYWrMEqSv2uhiP1jtNJ3cOIM6mDahSlP8MyQqz
 Apg9shma5buNrXvRcH1bBHLH/4FyRYlBXF424Y1G8+sKEbdASK2V56Nf5qOb/TFLCwYm
 DGyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlOqDEe64sE1rmAUO25lwVqa1b6C8EriPqkM9XKnKFeEZOh5ytXC3aDWMA9hxp03B7XyrkErqJRtxDUHiQjTnxuAm5o5I=
X-Gm-Message-State: AOJu0Ywpunl9ukBDpuCu55ykhnPX4H+TX9Nb3ZkUOJEa3eEs922R2/R6
 6BnuwbbV1SEsLEYwYzn5TDKF3G+5lQ7lKf9jW2UoRyhrm+/DEkRXuNMIEA62Ts8=
X-Google-Smtp-Source: AGHT+IGWht+0XYri57mzGdC0b8C7gJTRkBWDE/ZlzOWIKXFL0rnCdy4sA2CaXAwCwMst7p9yOUdRfg==
X-Received: by 2002:ac2:5f06:0:b0:512:9af5:d083 with SMTP id
 6-20020ac25f06000000b005129af5d083mr1146976lfq.60.1709300059432; 
 Fri, 01 Mar 2024 05:34:19 -0800 (PST)
Received: from [192.168.128.175] (232.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.232]) by smtp.gmail.com with ESMTPSA id
 25-20020ac25f19000000b005130fb1509bsm623595lfq.262.2024.03.01.05.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 05:34:19 -0800 (PST)
Message-ID: <0f4ac1e9-dbe2-4b33-bb83-d549c065a865@linaro.org>
Date: Fri, 1 Mar 2024 14:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] linux-user: Add strace for shmat
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru,
 iii@linux.ibm.com
References: <20240228202518.33180-1-richard.henderson@linaro.org>
 <20240228202518.33180-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240228202518.33180-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 28/2/24 21:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/strace.c    | 23 +++++++++++++++++++++++
>   linux-user/strace.list |  2 +-
>   2 files changed, 24 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


