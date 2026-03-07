Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759FFFC9EFD
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyq37-0001zw-3C; Sat, 07 Mar 2026 06:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyq2y-0001x3-9Y
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:42:16 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyq2w-0007yr-4U
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:42:15 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so4730345f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772883732; x=1773488532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s+S/lyeA5fEI/WZQtM3U3h4jFQSLFzZZsja62SNHSeU=;
 b=KVw6JBZ9Yd8nPYc3nkF3Wpr7Xlvmf8n0XG73trIPoEO534M3OsWAxhxiSYLIXZ4woO
 KcZBLdoU7qrQ+bA7qTEo9bqb/lxqzUhv19BXeqnZE2FDXuUuXJdSKVG7LqiO6eDIXCVS
 UxDTHr/CPqw2IM8BC1ftq3I94nPb1AXWiTSkKQhg4ktXZcpbwMijzV8JTS/bRpK6ka73
 oQ6q33CQHVoGr/ePyO7D1SMxC8iwAC8Xm9d3osO9EvvigyQp8mJsmf8N3j/Y9jQOVoF/
 Vwt6Hvw8HHcqZkzqX+MTMk6dsCyEU3RnWk3UdiJkVYV4A+B+qc00T2614OvZkoB8RcWx
 dc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772883732; x=1773488532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+S/lyeA5fEI/WZQtM3U3h4jFQSLFzZZsja62SNHSeU=;
 b=ZqoWSLHplc1Czgytwb4iYTWAWk0pxnW33f/9PnlM4fcBIhPAvi1WZsyplFFHYuKMZf
 veyJbzadZC6SLkm3363ybHrU6gGFQslIfJPuuxROPbD4jPVAn7ppNvLoTX4odDM3gw1C
 gZKGpQv3jVdkot8HXrChxeg7LXwimhKyemsC5x5f9dEqN4Aseax19ZJTZUQ+YV+y+AzZ
 9zEMp+XpubVzm4+urByD+w4U67xFxOmDZtzImlndE3hRMpZI6HByo6rgPswRllAaGj3G
 qjRdLNy0w8Iqws8/UWQ35v9QjcDhmBkT0eRz69h+4We6uQpCvQ73aWkfKHNtnwmFrrch
 IX2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc2QYvWfPPD7DBdoW52Fka9KWSDo6hvjAKoj7rrjtYXcxraNJho7Ztkg3TpvQV49bQzggMR31Xm2BQ@nongnu.org
X-Gm-Message-State: AOJu0Yxyi6hZzJpGK0pelvK2MXZ42VaIKPUFWCGwTnU37qtbpceGxP7r
 yTGvCPLwuAgMFOpAo2OxcejThCCVQt5u9MSptTT1EsZM2sn+FFXmAHluZOocfGVMM7r868Q6s+Z
 u8dLNPQk=
X-Gm-Gg: ATEYQzxAP2LcCykxxNHmvDjOQM+s9OhQzksgFALu3MZBjY1vab5pnUON1xR/+gBzxeo
 K4dOn+94qRpkvaDnhITvDA/CM4YmYzTCC6b72y7UNfH5XQsry856eKc8iA2kHGoVprUGZ1xzhMS
 lgCK1AxqVVH+38EKfsgvXfFm2R9o4gpm+gD347qE9yrYXS/4vWL1usPwAIjd/TN6SKv41vJWzYB
 oLaZvyiBFNPCzIeq9zL5qTa9jAO2Q76R4XAm1o+MY6AntESO9qp/E+IURbcXlRs9RtauVIOcoy4
 o4Vaw6exYBFyXtn9QbUjUzp3KYqpozLPT2C1deWQ511ZVs/Qr63M/G5RbHKXXu6M9whM2sFtL5z
 Xu1ut51cR+n+lLNaPX7u7CQ1igCIc8nXjGI2vrndGlR7bro/TX/nWEzuh7H9FCUFtUmuKlL/Vrb
 ewq4fIWfwEbEOjzkhV8qIo/Q6HvnJoupPZxIkd0yT22wBjOC+cDOzTJcdvEYsuSD6FeQ==
X-Received: by 2002:a05:6000:603:b0:439:b59e:5e69 with SMTP id
 ffacd0b85a97d-439da348049mr8695932f8f.8.1772883732372; 
 Sat, 07 Mar 2026 03:42:12 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad97be5sm11332691f8f.11.2026.03.07.03.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 03:42:11 -0800 (PST)
Message-ID: <815e35dc-fb2c-44a9-aff5-b778005815c6@linaro.org>
Date: Sat, 7 Mar 2026 12:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: remove SME2 stub code
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20260307105009.67242-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307105009.67242-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 11:50, Mohamed Mediouni wrote:
> Releases n and n-1 of macOS are supported. As such, macOS 15.x and 26.x are currently the baseline.
> 
> The QEMU CI still uses a newer SDK, just with an older default target as it's running on a macOS 14 host.
> 
> Note that this on its own doesn't prevent running on macOS 14. It just means that you have to use a newer SDK in order to do so.
> 
> Why do this? Because the stub code broke the x86 build... and it doesn't make much sense to keep it.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c           |  31 ++++++
>   target/arm/hvf/hvf_sme_stubs.h | 172 ---------------------------------
>   target/arm/hvf_arm.h           |  45 ---------
>   3 files changed, 31 insertions(+), 217 deletions(-)
>   delete mode 100644 target/arm/hvf/hvf_sme_stubs.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

