Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC8BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0yx-00079r-7h; Mon, 22 Jul 2024 17:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0yu-0006xM-5j
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:54:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0yr-00066M-KX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:54:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso31857025e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721685244; x=1722290044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M/iTTKXzDIaEIagjYDsG6FTWs9ak/8rwN6KBnSlAIEI=;
 b=YX47j+v8ciobVNDunHU3PyU3pCd0PF3SavARUMHNBA67Kl1qyvPeEymCGfy4LboSIn
 KYexzqtTJEd7lPrwoycaAoI0c5XHE6InuBnyIkO2i/urGPnaTezaLtm4pIJp1ejjogvo
 wcRGId0Q/IMWWLDVd4Y7OuC2ZzLTv+AmOBqNMN0ka00eHLtT5pzzz+qmFt2tnEaGBx6y
 pQe+DfSzfeIPe3H5xmxDPlYhLNTAzk5Ya5Kp/F0ZioNyop0tFWWywld0lxej9xSzUua/
 VA13cBh2+Cv9t5hCfHnstc6YaoW9E4F+WDfb0QaT5nJ3I/8TJj+3Fyv7RHI+mfYwyqCo
 adLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721685244; x=1722290044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M/iTTKXzDIaEIagjYDsG6FTWs9ak/8rwN6KBnSlAIEI=;
 b=gj97I3msU0Y3Ug8lD5g7gNV5zhIm0J/12yPYs4HRj2atw54TpNU6brzy1wbmjGSqVw
 JyFR4iHijAqbl2hXgXs5Efr7sqv5W9OuEYa3Qd2+JmQG4KajqsnsWP+8k/GkLW8KZ7bL
 46V2jktB2hXLcULXUjOnVUyJiATzVtIli7hcguTZzu4vCTZZ6X4HvbKJ/V5mQNrdproM
 D7Q7MfuNFHG+z8Qs/2Hx0lMp2C8tbmtf1HnYV5aWk3wUUcCLDOsy6hMI5KbOhh9sRuAc
 Jp500vJ8OZdRbKuolE5GzBKPJg2X5v1yyfGB9NHjIvrUjoYCHDRpt/LHfgbittWCI6IC
 Oxvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYYwjZflayJnXv0peHnt5qe29uovzZFbdyNSDgWNpvrZhYOW5nuax94sDtfdD5AzeurkaPOSj1E9IAZkQN2gHhT3kWUNE=
X-Gm-Message-State: AOJu0YwxLLQQlXnyPFQBfqNtGXftOjWU1pWR6bxVon982bcMhv5z7dTE
 jETzW2Dx3nVN9WJ0LL/A4fyLJsEZplirq4DtROFE8DuqpP4G2AqfPTH43vt3cmL21sbB/yMC+Dn
 T
X-Google-Smtp-Source: AGHT+IG3sgD7emGUChZ4LGh+2+fZFNsfchMeWEQLnO0WmQ/uHpKimSC8KBCfkjHjYZUHy4xhIuvaxA==
X-Received: by 2002:adf:ee41:0:b0:368:7883:d14a with SMTP id
 ffacd0b85a97d-369bae51e87mr4401659f8f.33.1721685243648; 
 Mon, 22 Jul 2024 14:54:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced78sm9677669f8f.74.2024.07.22.14.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:54:03 -0700 (PDT)
Message-ID: <f3c9d0c0-1cfd-46c8-8524-cffbe5180d3f@linaro.org>
Date: Mon, 22 Jul 2024 23:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] bsd-user: Add aarch64 build to tree
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-15-imp@bsdimp.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722214313.89503-15-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Warner,

On 22/7/24 23:43, Warner Losh wrote:
> Add the aarch64 bsd-user fragments needed to build the new aarch64 code.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   configs/targets/aarch64-bsd-user.mak | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 configs/targets/aarch64-bsd-user.mak

Can we build aarch64 on Cirrus-CI? (not clear on
https://cirrus-ci.org/guide/FreeBSD/). If so, could you add
a follow-up patch to build that on our CI, patching
.gitlab-ci.d/cirrus.yml?

Regards,

Phil.

