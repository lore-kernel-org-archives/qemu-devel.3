Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D032C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 18:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhXY2-0002iv-1r; Sun, 18 Jan 2026 13:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXXi-0002ct-N1
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:30:30 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXXf-0001AX-Fl
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:30:30 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso23309475e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 10:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768761025; x=1769365825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y3kjaLezNnpKwPZQ/8PJAks1rY7mZjKFrRn/FzE56TM=;
 b=uMGPQ4xKwarJrYNqifUV4Djdxx15YYk0bQFN1mAi8xz7tjMJqAyQEjSO1NSA3qYOsG
 Da0s0HeCtaj2YyaKBbRrMBUSIfyu1BreDb5xo/r32CYWCtmTdeQYYOYfb0OWlT6vb8n3
 tYn+duUFHGaLtdq1fmfJekfT4uUiDS0P1H07NKPouC0eaw/NwPatSNlOgVTDRdhPLNcR
 uOsqcZdXHUaJ5/AhkPiYAwpiqVd8OFYCORRgs+z7l4dDR7RGipJVx4dGF2Ibi/ZihSE7
 1d7B7F2hLPdn1Pj/G/GBKMV+swNSPCWaXzoq6I0KH4i9MPijbV3pRinRB+jV8eFofFux
 0Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768761025; x=1769365825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3kjaLezNnpKwPZQ/8PJAks1rY7mZjKFrRn/FzE56TM=;
 b=ZE6NAg9vZL+30l2GWXZ/ogiLIvKi0WKWjcBDLfPRjMredEAah/oCouK4NHUe8wzD1n
 8YgUW28CJK1GkmqxoSMREl7Dx1X7a/JcS3Y1dy+t0PMUS/KF2nPIZuUxVFUvvsvCr4Pj
 UbHKrD2O+qe0P8fYWu+7nOqYOnbg+RU2o6pkV+noerm+hFIeQikLZZY7O5gF2Oowg6up
 CFvh9TFdjYoJY7ia2mew6IlRCozvi46e+nBHxHayJm1xit//Q/3OvRkNTHKtNMptmE3m
 DfH/CwT5SNx1T6TKg6YniFzKdGmZfPDOaVjObg3CRnV9EeD/S1UKp3mXZGTwouKPi6QA
 K5Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/5FMmbMtHlKw3y4mfK/iw9IcPPxis8Hl7yM8GIgtuwq49ZUBSvnZgEmTtdUrEuvqOZb0fvEBS7FFs@nongnu.org
X-Gm-Message-State: AOJu0Yy4MeujmNXCBcUqWX80jlnhcWqNTAw2Al3BruucpagqTNuOfPpN
 bGfzaOG1RlVGYjmWRu3o4RgCP8EMbCJem63Nn+sGG/zQyYonlm45t+2oQxpg03ogreg=
X-Gm-Gg: AY/fxX4cTAE92JEGaMDpYsSiJWz534LoewKEwHpqEMVuvn5c9sLalAvFtz64+DRS8ve
 NR7vzpN1ynhxtA8KOuxKLS5IrJNF/uLAbIXAp0wA/EVv9SL7FrEP6XSVQwSqP+yEHz7SgKQn3lW
 U9ImQGsrBNzvaMtuMsADOF2FJj8Ie4pUe/iSzvm8RUv8ekQ+xqfLo6rVCr7IHR+jcxY+EQKJ+Ir
 8qobv4Z614ORyL3FvfkPDKuE92EGBb3QW1XSqk7yTr7R0jQ/WT/moXb+2pUsg9QTxcDtxJsK1ZM
 iC+Lg/uhbYQI/ZWCTy7J9tK3mhN7reqaTL8ajXE+29qrk0qRTnGyBs6GUejgVCrsIgJ8Wb51npP
 DWbj5cxX4KKfJmzuThKhcBSPWVsNGDhx/EFSX4Lx44IB/3t46vuMXBJjv3qqEZF35GkmFSrt/SG
 dfsfXkzTijfjjTuD3f8ZLqHro1axQ/lVz+a7dwTj8COl4Ah2/Vd4dzpQ==
X-Received: by 2002:a05:600c:6749:b0:47d:333d:99c with SMTP id
 5b1f17b1804b1-4801e68adc6mr94730305e9.18.1768761024782; 
 Sun, 18 Jan 2026 10:30:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm62343215e9.11.2026.01.18.10.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 10:30:24 -0800 (PST)
Message-ID: <d8359c17-0e7d-43eb-ae61-08564e58bc9c@linaro.org>
Date: Sun, 18 Jan 2026 19:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] plugins: define plugin API symbols as extern "C"
 when compiling in C++
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-5-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260102214724.4128196-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 2/1/26 22:47, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

