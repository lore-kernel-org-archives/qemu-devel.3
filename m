Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13194C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruDVe-0003fi-Vv; Tue, 09 Apr 2024 11:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruDVW-0003cv-J8
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:35:36 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruDVS-0004zG-Q3
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:35:32 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d700beb60bso93562001fa.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712676929; x=1713281729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OeeAPICL8R+yBspVq6BzSd8N58Dj0IAo6K/hutB7eN0=;
 b=vKZ4yqLGR8Co7o/3TjMjT4VmCJ+Ifs9NVFGKCXP8gHlsLxirxi0pUjnhC3B1wuqS4/
 XYpUFYrfTDGTic8u2ojIXSZgtmgbPh9bjQPpryhkWKyHgUqYWXCzfPmm/YPBjfXvralW
 amyHhBE0S3eZ5D6k/M3iLJ9c+jgKg9rRfod09trhXjd8I/HG0tpqIbQCmcMbLFuf0OSi
 /+zjGx9XWAQb5Y0PUsbazV7Mu6tcMFYWa9doCc43L6DgU3BFcKn8aGenfS8353fVwPUT
 6B1TKoJGGbRPd05iRWXeNRWO7uVJ7Xib80KquGtpeqL49JWnEPD7JOy37ZXfnA4VdInj
 c7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712676929; x=1713281729;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OeeAPICL8R+yBspVq6BzSd8N58Dj0IAo6K/hutB7eN0=;
 b=mVzsBjBAckF15N0g5DkzewJEBKUmTMEey7amgyYj5ceJitZVi/6CJgWU9hNkE8Box+
 bqWVAeJFIuA8tgPVVaWsAlzIKHdnea0aT53zUcoYtsXDYc4bzfaXpoykMTnu5nd0VcqM
 9I+CiT7DJbO84JWlIjED/oQ0dBkzZzTk4VzMyaGGtYH3UNBL/yku+xijk+uIY9pcX2uz
 W/bUKWLBvRCxfRqXU9RI11uE9QZG9G5vz5UPgjlUlt9Z5trdqFIHFMyIIx42UsH6e6Zb
 hWFvCmxjDMfff3cYCBIpgvoclPtt1pyniq4oUU6qWt8u3XPnEHmH9jeKKQJDNDcq3C1m
 YSvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTuEo+1p5563PAnpu/Cmz7fpR26jzFWLFbZTIjpJ74KmS0kaKrX392bK/lRnn3f3z1Le4fcPDMWVx3R4Ch8GtH8IQPOhw=
X-Gm-Message-State: AOJu0YxdXpQE9MnxFpVd6IIBKPhbqfvJ7tymyaeInm3ry76yxmBYPmqa
 LX/NbbRHk03JF4q9m+LjNv0m8H41or+XUviyEO33AjrFCf5D0+4YEuZQeGpE9ds=
X-Google-Smtp-Source: AGHT+IGZsx1aWFDclNk3NLBmvuCdpsruZL+HDyRkQmlMFrslWsG9SGUrFKQS/oq7822kndbo2m+ggQ==
X-Received: by 2002:a2e:9782:0:b0:2d6:ba1e:a54a with SMTP id
 y2-20020a2e9782000000b002d6ba1ea54amr143445lji.51.1712676927822; 
 Tue, 09 Apr 2024 08:35:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 ov7-20020a170906fc0700b00a4e44f724e8sm5777048ejb.186.2024.04.09.08.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 08:35:27 -0700 (PDT)
Message-ID: <f0665213-89f5-400c-b91c-3088fe36e64b@linaro.org>
Date: Tue, 9 Apr 2024 17:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] linux-user: Fix waitid return of siginfo_t and
 rusage
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405220034.5128-1-richard.henderson@linaro.org>
Content-Language: en-US
Cc: Alex Fan <alex.fan.q@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405220034.5128-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 6/4/24 00:00, Richard Henderson wrote:
> The copy back to siginfo_t should be conditional only on arg3,
> not the specific values that might have been written.
> The copy back to rusage was missing entirely.
> 

Signed-off-by: Alex Fan <alex.fan.q@gmail.com>

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2262
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Alex Fan <alex.fan.q@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   linux-user/syscall.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)


