Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2224FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNjK-0007Zi-EA; Tue, 06 Feb 2024 10:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNjJ-0007ZZ-Jw
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:51:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNjH-0002H3-U2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:51:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40ff0799f56so2877735e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707234681; x=1707839481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jEIoz4GIdS+kb7tAy+PpdBq8+9Sq+1vwfU6QHkEZUKo=;
 b=ncav86VLA2Rf0b+o8vGIv2IdgSs9Xpcft1HoRBM6gimf3VghPcj7dycScPxa/ZHr+C
 8p45+a0tFMkilVKGVRZAPjNhu1KW9NWgT8XLnrlhSMpO+eENpp1diD7l6FX3G1+BENKv
 F8l8vjaKHk1taxlrpniMTSRdONYuGE3yCEpaHrelrtL+kYg5/uRrFd4Wj9Vw6cDiLw3W
 LtUf6V0kw+8YnEMe8qBYYVug+RIua/2RtlQ8KPnGbTKkfY+O4W/jKXHUtCwomqe8Ga3o
 tSeEwOQiodS+zmrrWnxKyDD3cWpVTRJ3n5U5q4f1lBf9kj3OwTFCq2EUJjApxjx8NClb
 aCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707234681; x=1707839481;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jEIoz4GIdS+kb7tAy+PpdBq8+9Sq+1vwfU6QHkEZUKo=;
 b=vYiYcc8vUCg95AgPFVPOLjar+aKyNsWSJ2CFEmkdEfKttkZtk7q6cT/x8e9d3xGm2A
 UiUrDuyWO/61Akcpibgt2fm5KA97QGmSDv+hOUhQvHhhbzjgY75wzOW3XQg+u0dFF5K9
 qgf0MEg+K4wY2hEWr+vJMaUlQMYHJh3ih2221bvESkpqWN3WBoGvmowvtO5LHrsdAxSm
 ibacljAirsnN1gcN4fuIwf2S62ObB5BYAXcXOqCkehFD18Hg0BW7d9Ouu2Judnv4M24w
 K2ErTXUfEWvOwZDiPy1tBvKixA873PfDf7ewaiW7FxVh7ZKQcCBWoNZqSoxC3iK2OoqE
 aEXw==
X-Gm-Message-State: AOJu0YzfAMNXgpnA3BuXM4v6OCfH3PqfqbGkQRXkwtgYczer4OFtNfmZ
 5zJe5cerSK+gHwosBigu0snktZbpR9fy8kq6XpCUYvJPk1ox8YR7OHebSSbMD5TSHffb1isMUG5
 x
X-Google-Smtp-Source: AGHT+IHq370tA5pRKPTRwA4rCea2sMJvkQI1DDG3OvLqFMjjzro+mmqXaItcyGgcpLSsy9lGQP0JYQ==
X-Received: by 2002:a05:600c:314e:b0:40f:df20:3bc5 with SMTP id
 h14-20020a05600c314e00b0040fdf203bc5mr2953169wmo.2.1707234680703; 
 Tue, 06 Feb 2024 07:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWtvVrt2lbF5YSD3030K1PsRk7bQiMgJbd3Ucjp8vg+7mXT7wfS8yF7aPSGlbQD8yspRPZBSKxlF0hw16cQaai3c0GG6jg=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a5d4dc9000000b0033b483d1abcsm1620571wru.53.2024.02.06.07.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:51:20 -0800 (PST)
Message-ID: <b59bc0ab-cb6e-4aaf-a6aa-d9e82cf1ba0a@linaro.org>
Date: Tue, 6 Feb 2024 16:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/tc58128: Don't emit deprecation warning under
 qtest
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240206154151.155620-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206154151.155620-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 6/2/24 16:41, Peter Maydell wrote:
> Suppress the deprecation warning when we're running under qtest,
> to avoid "make check" including warning messages in its output.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/block/tc58128.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



