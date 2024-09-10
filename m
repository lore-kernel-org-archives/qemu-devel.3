Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00254ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snurR-0007aX-71; Tue, 10 Sep 2024 03:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snurO-0007U5-5Y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:00:22 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snurM-0007y8-IE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:00:21 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso472247666b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725951619; x=1726556419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DO7YlwvMlC4jDj1Ww/Ttr0hNeLNP5z6IyC3oV1OXmUc=;
 b=zstkFVneB7czUFR+pAcdRxs8iY/yqRf4t0zyuV0Je2ir6FzRwT8Wct8Mg16+aoBs0D
 DQROkRLpHbA9OQ0MW1cXmW+nKwtjdjVs7NmdoRWYq4jKh0cDb4lmlh01Lopr/dvyAi7K
 r0CTY8Si2tSXU/RtDsoxDKBM7MWXgtwJ40GUOGegrW6n7wGNaF2s/UDvO5pFon35vYnk
 9EqWKmlsWczjr0CnKQhyZv1CVE7Rtgx4xjbPSb8VTp6BxDWZoyn/ay2Wl1AJKZ6f2MmG
 VGE8pIyIdTmoxidXUihYWBC0ul7cMYUsUVpdGIi+GH6DeuhlleFoZ0jpSNe3FaZNmtwB
 W2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725951619; x=1726556419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DO7YlwvMlC4jDj1Ww/Ttr0hNeLNP5z6IyC3oV1OXmUc=;
 b=tQbRytAEWDyTHJq/sQU88xVfz9hyWcJ8110LExtU28d/gUU+1cOWhB061rTBhe8b3E
 cGAKz/LKVv7xi6f7A8qd0CowZuullSwCBpWKr+qIDGe9GCOQ5g54oom6MKGWB5KODqTm
 2a+kYMcQYyKvB9bwb7rM1brB7eI73Mripu2a0OGMo10vOn5T01FwFLygwKDyjDeCZ/lI
 LsN9WC0hgDPWsU2vH1c5/UgALkuKckiVPJM/vXX0AP6xQP8juZTWvH/UKuIJ9YdoLlCB
 Cck54cB/uGyqpTzns/PAr7EbLFayXKn5ZlojHPm+OYfeVFRXaU5cSR3AcQ1JmuPwm2ze
 atPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfhvjrZKMZ2N/aRvs6cF3m7cZNgGT9+MQecx2ZITUVMMR/2oppZSYpA1+YKKN5CcqGC7T6vSsZfL31@nongnu.org
X-Gm-Message-State: AOJu0YwqKg+kHduupFOLyTWbYxGMwBoNmSeVFJotk9PvFHCMbWTG7XU4
 V4gAUWp3sKJOP9N11YJDVNjlaz3lmjAxbcUUvZ23zJ7bqiyvBUeQ1DSudTZUmXY=
X-Google-Smtp-Source: AGHT+IFcipWbS18cnJ18OAmSsyU1BCyQ5PWAbv/FTnyjxJXmGBZc74xF+tDzMOSdGu3iDUHyEs1Plw==
X-Received: by 2002:a17:907:25c8:b0:a86:89ea:ee6c with SMTP id
 a640c23a62f3a-a8a88667d31mr1074656466b.30.1725951618646; 
 Tue, 10 Sep 2024 00:00:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25045afesm439005766b.0.2024.09.10.00.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:00:18 -0700 (PDT)
Message-ID: <024f5acd-0cb3-4bbe-8cb1-dbadc1e1e570@linaro.org>
Date: Tue, 10 Sep 2024 09:00:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] tcg/optimize: Fold movcond with true and false
 values identical
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240908022632.459477-1-richard.henderson@linaro.org>
 <20240908022632.459477-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240908022632.459477-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 8/9/24 04:26, Richard Henderson wrote:
> Fold "x = cond ? y : y" to "x = y".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


