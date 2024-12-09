Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79190E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgHC-0003RR-CE; Mon, 09 Dec 2024 11:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgH9-0003R1-AZ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:06:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgH7-000144-Nf
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:06:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434f0432089so16980955e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733760380; x=1734365180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xTid1ezXvclufks7HA6Zw64cJtMCdpx5xBWXMFHjhhI=;
 b=DP8znSlLHWplBHrtrs201WX5zTD8YfMNf2n9ZABeau+2fxxjLmHHAMYqQj16rSCDme
 tfkkUQxZwLXMt3mqpmiqkTMNRe+E+L+oLdnl5gdnAD4R9zJ19l4+nKKO+J9nuXME536u
 iX6JRvfp9PbWoK/NXgKTjRmcP/UGLEiNokPWhUQEuVj/sXjCfj3ORhKZrzGtYUFUYqMU
 dmigQzxV1BrKKRiHwGiatFhjleocveq1PWJc/BhuQerltt5ZK+CujIitEnfTmSCJLYwS
 IAZGLfb6YA7vdAWhRwMWi5vcok3nSjQwAmWeQIUGMKBGAxekVkG9P1U2RRvjKWhOqoEs
 UnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760380; x=1734365180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTid1ezXvclufks7HA6Zw64cJtMCdpx5xBWXMFHjhhI=;
 b=LLkQFGMNidoPJF33yGatVPUbdWvuRLr84ABWzTNGIns3mzPYBsZIBo/SBxOXW+KMky
 8Eoz9PHjYMh4eDxlBClefh0T38Kzw9eh6olbShCbbCix5OBa5y5UABDxPy+P1OXzBw5d
 HmbSVZdXgPIeg4OvSZ5ZgPpIaeXYyDOWQaXFE0reSdaL7JaoWRtRL3GRwpBAoQ/IkAFi
 OpUEZROKR98NgN75zKt5Z0wB0i2k3sHO37J6dhd5cVcVUGnYgUwqSCHNzlyjU2KdXSep
 RkplAs3VcFObKp+EZTgJD2i2FmLlBNxI3P/fXehh7V4E2C9lCiRLKj6HryKndO3SdhMV
 paDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd3dOBPlz0DLo73oMCI1KJ+DlbmosipumerP6/o8A8Y3TZp1HXvar60d6elqlv1HlC2BVWbjjbY4pY@nongnu.org
X-Gm-Message-State: AOJu0YyIoU8SorrND6aCajQkoFJeL1KwkWmp1QPzCqF56dC9IrQzX7dz
 xqVb7xnKUaLrDtGNb3oMU3KutkC8CTfecF6kBy0JGNjbP6C9pAgin/TQwxrjtMY=
X-Gm-Gg: ASbGncv9zMNFKRpCUEtDjpSc0Ei/pfch/Gw3CKYXYv0mQd1hN438jlcW/1rNYUt1DIg
 vu+6sxIS2J1EWM9KplmaKUw3Ij7j+1kZBULBEBlOfPWtOHlnPfYCXuSB10H6kIDDwz/kIyD/0Fd
 p12FCWcBwq7LJiVllg5fJe55DcYuMQ+n39QTSjIzX6UkcsITmil8DcPyZUq/q63EQb9UaBtlePm
 nQPn9bCLfIPGypFvbEoemHyU5Jc5aqmxUr6x7r8K31GtnYowiYdIMJJu/Z/FR1Pp6WvOMqFZwlM
 I2adN5MqPwYk0LGmqghXAsBQvILyTnOT
X-Google-Smtp-Source: AGHT+IHW6ZMgGrpxCJ/91BMx0xE5EESCNs9DtBAAxd3uaXG4tBt2vK6ROtUgX8lK3IxwfNscQgcZeg==
X-Received: by 2002:a05:600c:3491:b0:434:f3d8:62d0 with SMTP id
 5b1f17b1804b1-434f3d866b3mr51209355e9.3.1733760379728; 
 Mon, 09 Dec 2024 08:06:19 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f5800218sm34681225e9.1.2024.12.09.08.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:06:18 -0800 (PST)
Message-ID: <64f7b7b5-5dc6-4e66-9c30-dc26ef851baf@linaro.org>
Date: Mon, 9 Dec 2024 17:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] softfloat: Add float{16,32,64}_muladd_scalbn
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241208224844.570491-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/12/24 23:48, Richard Henderson wrote:
> We currently have a flag, float_muladd_halve_result, to scale
> the result by 2**-1.  Extend this to handle arbitrary scaling.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h   |  6 ++++
>   fpu/softfloat.c           | 58 ++++++++++++++++++++++-----------------
>   fpu/softfloat-parts.c.inc |  7 +++--
>   3 files changed, 44 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


