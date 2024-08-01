Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7025C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYZb-0003TN-HM; Thu, 01 Aug 2024 12:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYZY-0003IY-O7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:22:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYZW-0000yr-OU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:22:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so45732935e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722529349; x=1723134149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VKxKe5XGa1FNb/cv84uBGczizt3FzNxoy1nifSip7bQ=;
 b=ZJXyUwe6exCTd5xq+d+ba2hViAXr8p9QeYu5B5JUMZbO4wpjT6wTei8ox3axuA2RoH
 0kHyfzGHxrq+4tQV9Qw/B9Upxlezfz326rk0Zqk4b2hE4BhcJ7F8sXZ37iD9uTDwXsNd
 Sn600cA++HiCe7fZaBHx6UgiVs1XLlipkzncvBiezDkPdt6//ooyf2Lpg7laoQf6zlh4
 UBIWPGemmDyjwmdfVY6arS6meZdDV/FtQS6GMalcc+wLrhK3yM4ecG2BaeAPPydfIN+l
 Qx04IBmqAQCAq7PqEUMxqVWrCdcsOrr0ml9omrSD5tVVIunSPcAWZGag5HSJ/HeSUwiH
 Bfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722529349; x=1723134149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VKxKe5XGa1FNb/cv84uBGczizt3FzNxoy1nifSip7bQ=;
 b=OymVRJWDXpU1y7ZiIDF1ratJNpJYl1ODEP+uleaa3ZWBGyAyvrX7tD15n1Pq4QVbTh
 Ti5YyLeLOV31e0TjjjlKsRRV5UorZPVQqSTz8Gp3wcqfaWOW4XPbT0kpOpZrkFZ0mCSp
 ZwMoHeyEiOFW5or7fmPpHmM9pCBI4F7z4Vwv8zqMCL+Z2vlJ/h/UZZ7v+WKuxvJYz9+8
 E5GZlQirjkcLQ0cIehQ6wieyF9VWlkqdq+dIYGO90TXEMWWi5mNvpmxhzXcZSm8Lcxsc
 IHQRxyFc5oZ/POuPqZEqyhsCvtkff+tFJZmwhmfszdoJdLeZWPHFU2gsEPFhzppPefTN
 110A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVabgK4V3uCANt2122toLgMXNXnNEO0tED/IIbFdnotucvlm5FEKDq2CdmNaxBFYCvhsNDVcjTWOykOTKdedXXC701ZkI8=
X-Gm-Message-State: AOJu0Yw6xaMFgGGr9z5T/pTwp81lQ96eGhJxZX5KYmHnkcCtL6q9IY+Q
 7d3O5bBzqTyZtcaKXuOVsuaAnxlFPVwFX1HUijr+/IpqfBX5ZrzgainPAe6tV/Py9u+GcZKOU09
 XU3U=
X-Google-Smtp-Source: AGHT+IFH3/YAgTsKNl52+32wIvyttkAcXypa1YyRCtNhCqjJJQoCmOHNQVGKPSDXbGG4cgyYXze3Fw==
X-Received: by 2002:a05:600c:5787:b0:426:602d:a243 with SMTP id
 5b1f17b1804b1-428e6b04a2dmr3148985e9.16.1722529348888; 
 Thu, 01 Aug 2024 09:22:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e9cd14sm2013635e9.45.2024.08.01.09.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:22:28 -0700 (PDT)
Message-ID: <f85ad95c-9c33-4a89-99ab-48cdac84bee4@linaro.org>
Date: Thu, 1 Aug 2024 18:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/24] tests/functional: Add a function for extracting
 files from an archive
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-12-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-12-berrange@redhat.com>
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Some Avocado-based tests use the "archive" module from avocado.utils
> to extract files from an archive. To be able to use these tests
> without Avocado, we have to provide our own function for extracting
> files. Fortunately, there is already the tarfile module that will
> provide us with this functionality, so let's just add a nice wrapper
> function around that.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/utils.py | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 tests/functional/qemu_test/utils.py

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


