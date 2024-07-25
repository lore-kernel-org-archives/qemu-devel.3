Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4223C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 19:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX4Z0-00072o-CT; Thu, 25 Jul 2024 15:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sX4Yu-00071E-Ki
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 15:55:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sX4Ys-00023Q-86
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 15:55:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-427d8f1f363so9923565e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721937334; x=1722542134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2yKmR5zSIeR74NPpZ0XO6cSntL2gdPFBrgOaHXBJvI=;
 b=mRyeUswGtslIJofEvGqe0uPLW7/0Xl2ItBCPcEKQGDonQn9NZWEE5hiyFR/E/upzCy
 8HS+4lSPnkVggQQG30FBOzS2gRawc8dYLnmJebMAIcZNPmZPNn3CMLEIe77DvJQeAfK5
 lEfhwVRnDh3EdO4MvDUuRTfPhsWeVNyOqxoisWqXX+1eZ7qKY4N86sePNO28403GuTPY
 T/nRFAcnlSKgNNVVAGREsAWCDtznLU/MoP6ws99S1dHON4JTcfG42aZ0S2RQ43W5PN7J
 RbpDcAdV+3UKGt3kHPnS2Mi5PKaMxr4zpHabd5AV58qQcHEtbOVBOLFZa0Rf31C12vz0
 RUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721937334; x=1722542134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e2yKmR5zSIeR74NPpZ0XO6cSntL2gdPFBrgOaHXBJvI=;
 b=iQ8YIZdhaGahDXBulcNvqmr6nUddO8fmJyjMlhQrYvFNfxjPcRgSvNzwtJ1ygaWqEt
 OoPDaynz91mkM+Z31xzGClFYV4NHsx8Nfm1aRnaRl5q6mAo7ECDsH7D2xG9xi+b8tUsw
 WeyKRa2DDFaNzcp8tgKMWwHYYmKLGjiHpqHiuSxIyVN7DAcx8eEQy/uFDWghmaWdyDYl
 DpQVsoDiMy4GFB4nQ2jXNObEjs9xT7Y9htJt9z6D7I+KdLx5qU2xjnBAFAnb7jMPaTW/
 yOTH0RJolPV0TnLrZrtPJIEPDwHX3VdywBmzMIZwqN+fjuc9EOLSo/bE6AdXBrBgn5oa
 mRPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEqwmCyKjvcmT0pd4B+8ymj694l+pm2zgMXGjBUV3FxIz3ur1YYBNqvn3ULvckuSAioxtEFJyOs7P9SxuWXUWummuZ92I=
X-Gm-Message-State: AOJu0YwhdLeAvyZfxSluc+AbOv9MdJSzhteCzcRU9WgvKeDQhArZDpzS
 M4i9qhVG5gdfsHwipHWfS+6UBXSf2ukkkbjcjBcnQndu3thjTT6aBV/41WVc5rVjKHJMmt1cYHP
 p+NU=
X-Google-Smtp-Source: AGHT+IG01xvrtMDIuNH7b3psmVCmygASwFRyGV48D7VwXPQ8F5dOw+vz42UZxlaPETAp/iASJr8HTw==
X-Received: by 2002:a05:600c:5487:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-42806be7443mr22549405e9.31.1721937333811; 
 Thu, 25 Jul 2024 12:55:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805749f46sm48480755e9.22.2024.07.25.12.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 12:55:33 -0700 (PDT)
Message-ID: <3723cd77-e617-4278-9922-b67f690c08ba@linaro.org>
Date: Thu, 25 Jul 2024 21:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/cache.c: Remove redundant check of
 l2_access
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240725164851.1930964-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240725164851.1930964-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 25/7/24 18:48, Peter Maydell wrote:
> In append_stats_line(), we have an expression
>     l2_access ? l2_miss_rate : 0.0
> But this is inside an if (l2_access && l2_misses) { ... } block,
> so Coverity points out that the false part of the ?: is dead code.
> 
> Remove the unnecessary test.
> 
> Resolves: Coverity CID 1522458
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   contrib/plugins/cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


