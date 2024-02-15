Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B173C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahJ9-0007Jh-9L; Thu, 15 Feb 2024 14:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahJ0-00079Z-OM
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:22:00 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahIy-0003Y4-CE
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:21:58 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so9202965ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708024915; x=1708629715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UY7ZIf0XDjrnf+8+6JSkNWrbZN8oo6G4+Ro1fQYUmfA=;
 b=U62x2R+06cEDg1fZ1Lg/62MXgfosS2OXEEPuoGqgrxc/zhJkplcwKFw2bTh3x/dqdH
 dLiLd//z9dKFq25iSrUQcHw8vH+yW6XB5xgdAfgeL2dRDPeMXo6PoBewx66jqPPknmT+
 e1qxqgvP7NZE6QQ1hnDVXaqixfHDXNIvZlt07vrM8eea3rUnyLgDqkQzA0DST/oExsXE
 5ngAOX/+C8BomwZcoRZ8T4hHsuHI91zTm4WS/JuoGlm6qP3/bM47s7BrmEJ8TnMPVPqH
 xzHRy6gKTEx5lUDDk1GEuAlJ8CcuuVnj3Jf1XlMhLYBV/0fNIaYhuIg3SAt4yG6W3QFM
 X2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708024915; x=1708629715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UY7ZIf0XDjrnf+8+6JSkNWrbZN8oo6G4+Ro1fQYUmfA=;
 b=J3iMQucps0vqhoXWG7Z3GJ2BfjuICUqYFuA/E6MoVPzDu8v3k441Unb57OLlDbz774
 sIEv+TT3wHW7keRRLayJnCSO2Zl9afPqepZS5diJhTcACz5Y5mmwg2BzCCllLfn4f+MD
 ECb5Zi3e741mXnGvDHZYCFt5Z0KJrMXiE+umzL7LoOoOglLlrMHvgdiskIQEVFx80EhF
 MRgh4t/e4fwPrZfijm1lgw76LpDhvw8JT8oADzdL6X/KBXie7pe0lTqnU8WUBDDhnbdI
 EbyYcC1jXxNga6dYYpP3yg1aNahOO/+5A5GWx8e7wP7nhLXjsVXmrGnltr5Zt1UMLWI0
 O0JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHg2oRDbdFnSmTk7DhTvHC+PH6gJn12dkoSPkr1q+YJXnYLUEfwRQRP+p+6ktad0UZ92tDqfIDh09gnfKSTuTxsmgWOO0=
X-Gm-Message-State: AOJu0Yxz/jx8LIgvuCwLUQsE0zxHkQfErHx32imQb2qo4MUVNv2gjDVm
 rQw02BrguUvsJ2B2sEMP7vvjyXFmGC6O76OaK6kOF8ykWbOln/c9nNVr20tbmgo=
X-Google-Smtp-Source: AGHT+IFw54TZjgPqy+YK1TuVeDyWvVczSr1maCRfAB1E7aSihqnEwQcuPRhVPo72Li7BLP2bY6iHuA==
X-Received: by 2002:a17:902:780e:b0:1db:2caa:6c5e with SMTP id
 p14-20020a170902780e00b001db2caa6c5emr6968338pll.3.1708024914987; 
 Thu, 15 Feb 2024 11:21:54 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 l14-20020a170903244e00b001d92a2b258esm1613209pls.118.2024.02.15.11.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 11:21:54 -0800 (PST)
Message-ID: <cde1076c-d4bc-4e2f-9319-9eb37d24eef5@linaro.org>
Date: Thu, 15 Feb 2024 09:21:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/15/24 05:01, Jonathan Cameron wrote:
> -static bool ptw_translate(PTETranslate *inout, hwaddr addr)
> +static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)

You do not need to pass in 'ra' here...

>       flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
> -                              inout->ptw_idx, true, &inout->haddr, &full, 0);
> +                              inout->ptw_idx, true, &inout->haddr, &full, ra);

... because this                                 ^^^^
indicates a non-fault probe.
A return address is only required for a faulting probe to raise an exception.

> -static inline uint32_t ptw_ldl(const PTETranslate *in)
> +static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
>  {
>      if (likely(in->haddr)) {
>          return ldl_p(in->haddr);
>      }
> -    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
> +    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
>  }

However the loads do require 'ra' for the io_recompile, as you saw from the backtrace.


r~

