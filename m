Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ACCC9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhe29-0007ZM-Q4; Sun, 18 Jan 2026 20:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhe23-0007PZ-Dh
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:26:15 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhe21-0004lH-V4
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:26:15 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso1708363b3a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 17:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768785972; x=1769390772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wap4gVhHL2+7+mwYV5ngCK8AUXAeJIsk5rEv9j56blo=;
 b=hyBvxdniquuwVnusilcCwmJG5xa3eyNAjAoysULUMprIlVvHYyz08Ki9klsMTWWaEf
 Qc17fSmyzVrEV6oLERBWk+X9wrC2CRASgbMn0YSZifnTa90k0nwyk4xKi+CncCtdrMEc
 jOvwdXr77ExVeXKsUyznAmbUkC6XRB7SLVQ3HWXEZ62JYpLJLP7YJ4rhG8ro417G5gP1
 cvaK8J8Cr8eR4qgxvlPz+0l+UD1c+D5IKXG2Lhh0l3j1He23bp2+YoVVJXb/11KVn2W1
 BC3xL27kFJrQTjeKy8N0d7VH5ZllGj18NNPDkRvmL4/wcYmHe6TPaF8kx3fb8KFrLRnY
 kQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785972; x=1769390772;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wap4gVhHL2+7+mwYV5ngCK8AUXAeJIsk5rEv9j56blo=;
 b=G5a/FgaZJHwq6THg+JyPN4PF0s9ThrT7SFsZV11/YQKBvRrN5eAm7i7e160LKjKPxC
 2uU31AN5J3CmcT5kODr0sDjpI2A6Sp1r6jiu3DIl+0miGHqAdFghVDOAm9UKOTHXIDPw
 2+3zvdjRCjZd11DdChiJnF5Kza9H3ezGnMDJSPFUlQ7GY9zP7kPA7hcf2LKD/rNBlSED
 axOQ356rM4lUcBmOiDCr7++My22n1B7LK1/QmE+YR68oy5uViN/yrNRZ/ISqVbMGKhYO
 JcpNe4Z89Daj4La2GJP2mXZz4450PKxa0bqUfQHAGT3yJOJBYQfxEfDNBYceLcOeYDDX
 w3Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv+2ASk2Mq3oxjKHAm4+zr6E2+PQfS6d220bgcd2LFLESoYUUVt/N15OH1ryq2vZMO2/LcThT4yk+m@nongnu.org
X-Gm-Message-State: AOJu0Yy5uuhvjK8yvbHyBnlA6+eIqNPOf1WSjTyKsFK4ouHZsSNpSVmf
 gffago2CZ8gqdh3TbxBDgI1bzW2SYFd8zuJ4aI3nBvJhm0r53BXmw9slnTQEpq96ll0=
X-Gm-Gg: AY/fxX4gJtj6d/xc7VD9bRlvyAG2i6TjaIPGaadbtvskpfK0TnMo/w34yn8h0VH4HU3
 hFt+kveqYExk+aJf1DJYzL4LJAB+jDuuAq53EjutUtuHLV4dN3ags1d8GqSzFu6r7bI/frVZzfe
 laUicN1ahEfNsGYrkz8vQ8hyhiJ5r/FGxcDBB/hz7XSqcWiWhhZ8SG8O0FXMjArxWXJiuGyV9pP
 9S/6hGAAUVRZucncuPx/avJ1TnRkbkYMUCRdDdqJTB7bUpsZOKB2uqjlvXNiz9YIezodGUAkq0B
 EUxDTq7YZkDhVQcihVXGsqahtiw0RSj1xV77N3knSruBDlm29YGh/ORlSMmsbMSvZCVCLOp+HVt
 xUg0BOiaTf9aRWC3LMVM3vCXUv4M2ggh9jV+5EQnQr5IUt7Gmqq+yzcePbojX+g+ZcncUKeHUVw
 YyS5XsWUkTqYIZAFDKR2Xf/59qOBb+4A==
X-Received: by 2002:a05:6a00:408c:b0:7e8:4471:ae66 with SMTP id
 d2e1a72fcca58-81fa1861292mr6808333b3a.50.1768785971696; 
 Sun, 18 Jan 2026 17:26:11 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12911c2sm7411341b3a.46.2026.01.18.17.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 17:26:11 -0800 (PST)
Message-ID: <905bd70b-1a98-46f3-84b3-16430f6a287d@linaro.org>
Date: Mon, 19 Jan 2026 12:26:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 6/7] meson.build: do not check for epoll.h
 (CONFIG_EPOLL)
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260113130008.910240-1-mjt@tls.msk.ru>
 <20260113130008.910240-10-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113130008.910240-10-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/14/26 00:00, Michael Tokarev wrote:
> The only place where we used CONFIG_EPOLL was linux-user,
> which now enables it unconditionally.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   meson.build | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 6ea49c6fc0..f8b4f06049 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2617,7 +2617,6 @@ config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
>   config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
>   
>   # has_header
> -config_host_data.set('CONFIG_EPOLL', cc.has_header('sys/epoll.h'))
>   config_host_data.set('CONFIG_LINUX_MAGIC_H', cc.has_header('linux/magic.h'))
>   valgrind = false
>   if get_option('valgrind').allowed()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

