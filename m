Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C384D30CC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 20:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfl53-0000Fa-BI; Tue, 13 Jan 2026 15:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfl40-0005yq-TX
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:32:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfl3y-0004tx-Ug
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:32:28 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so50946955e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 12:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768336345; x=1768941145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LhRJDoFmRDZVPE8OD9IIhsoEFAYAa3qABh/VF9RI9T4=;
 b=UUMSbdW2rc2s3r/3NBNLNyDlVT3stij77I2ol3Urfup1lQjQ2Hy/zyFH/DC5Q8h8DX
 MTPZuC1elxqVm/a9qrLS77uO+xyWi9jM3mI66BIE3GIB7K5Ay0UZEIoi7K/EQSNWHWEb
 WOK7GoWpoEGGYV+QZDWOHgaXyPzi57EUPd5HAhOot3tbTl3kogX1npleh19X3X3BI64g
 Sas+p3BOfImhM/kONPZ1X1Bw4pQ7ZmvY2aRfej8uViL14JJGqdoqpwgBDchMq5nI97Q4
 W499kpUzcpClFf5VjigUHTMBXFLpL+6oFNUJfIrt+GpvKPQpjmtYbzwUR9i7KNm1VjGB
 xD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768336345; x=1768941145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhRJDoFmRDZVPE8OD9IIhsoEFAYAa3qABh/VF9RI9T4=;
 b=DudEbtP72E6S5lriSl3z+kP1nD7IH1ewI+RawwVvTRRwH5oHDwnK1xm1l4J+6j5uig
 ZJ2MvUU+Q7RNLHmv4xIUUWmDhjNwQs4ebdGjzoK1q3AcmNLHb1W5CaLgtIFJ3uI2pmV5
 l2Jp6dmCj3tfwayG394dfzQfUzsi+I0QEUW9py+p79u1Z0OkFYCkkU2G1hGi11/5pGJ4
 k/vmNBcK3emMu1VXk7K4h0szG3NA/4CxHSFlWAFy4RAudP0NNOJPyRcOYxjBIEETs+pQ
 9b4UdXRGFrBbRm2zan6V8RVAdVObA3AWSHs5CDz2uqjm3B4rCul0JU/Qc/ipXuYoUUkB
 mPXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMt0qHyDGRVFOgLSYLWFQPQQgrBqamlNtEVfbLZat/EM0BSvYzZ5ppcesO/qQDJAi/PA0PJvbgzBAl@nongnu.org
X-Gm-Message-State: AOJu0Yz6zZ3EH0o+HrmgOF/SAgiFVUztX2+OLmvTU2t26Y0q1N2sCRaC
 bq1x+CPJ9O27RKXhpnNckahrPHWHCmsNVF3kmMfskSR0FUf79+zv495fcjvbWk5EgM8=
X-Gm-Gg: AY/fxX7wAt4XvE0ptYKO6oOK+7mzyaV5sEXhWfX6bSWl3f89vZhoolErIn8eGdVo18V
 leUJuJ2nTq8cVCAPybnf4XPRz+Nz+bJZKmDRJ3eVxaOeMXPVjBntTwkQg+1xsR8tVuHzA90YUAg
 6bwxnW4ZGdiyABxrWRkhx3mAL3nORTHQrF+A2Rv3ZKEnJb5tGdUg2JwjetfWXPEC4M3Hl7YBBya
 IOgkM98dsb5hotceUMpOZJfe9r2qBrFPBCF1YsWY2iHx3nzIivAqoWnfIb/uC/9893bQzJWqgFZ
 OvVISJoT8yuJr2JUQ7K2pjIfIVGUtcwO+CTXCX9OzIehX47TsuCPwcw+joFcEFVtRghh0rEB23x
 fo8TpTkZ9nRyc0YNL31zEh9hgYaqooCmlytS/6L/7/qlYdlrl39n1yQgAfAontY6P5hXgfvV6+Y
 BUWH1+IgTfY+CNgHn6EjR5SB09R8j6kJrf4TEl9bQJoQQQ87V1vPu/KQ==
X-Received: by 2002:a05:600c:4e0f:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47ee32fcef4mr5469145e9.9.1768336344798; 
 Tue, 13 Jan 2026 12:32:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda93feb3sm54760725e9.13.2026.01.13.12.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 12:32:24 -0800 (PST)
Message-ID: <f313dcf0-fa18-47c6-89af-1f9f8a101ae4@linaro.org>
Date: Tue, 13 Jan 2026 21:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/aarch64/target_fcntl.h: add missing
 TARGET_O_LARGEFILE definition
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, alex.bennee@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/1/26 20:40, Pierrick Bouvier wrote:
> This caused a failure with program using openat2, where O_LARGEFILE was
> replaced by O_NOFOLLOW.
> This issue is only visible when QEMU is compiled with musl libc, where
> O_LARGEFILE is different from 0 (vs glibc).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3262
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   linux-user/aarch64/target_fcntl.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


