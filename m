Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF259C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riLC8-0004cl-RM; Thu, 07 Mar 2024 16:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riLC7-0004cc-V5
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:22:27 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riLC5-0004RH-UO
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:22:27 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dcb3e6ff3fso11308045ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709846539; x=1710451339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wGUsKF4y5YTqqomprYWPwjS7fOmdDMLHrxcPqD7bPjo=;
 b=EqkPrecRtH8cj+rtpdD7gv1R0OM0EFmuEWoRay5iq57cvmqIwbwJVF9xUW5X6WyFHM
 EYeRrWhI4JCCNwTFcxeHSFJYGxxTQ0znusnuu+Ekf+FXfWZwzhSqT8YAzx8fTk6aZwQ4
 UNICYJZFP7OgskyNGMj8dmTXfeZ4Z+f3RBRzt1X/RiDHZC/W5Wu+1m9dlmTW6YFQ8GgY
 QFgJB4+LChW2sAIDuPNaiSsI29jw61y0Gu5+w2UTrXFD3QTHoEjShDNTkC/wb/Be6h6w
 NbW+TVApMkOYGl5OeAG27MzrynTypwX/XGcecbX8rc1AmdDQP87gKawfpx+l5xrivWZ7
 uXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709846539; x=1710451339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wGUsKF4y5YTqqomprYWPwjS7fOmdDMLHrxcPqD7bPjo=;
 b=CjNO5U/LL/sjR6I0dRYl7TtZWkgncjabXFOXS460sgw8OIbd1EIsHJt5FXb5sCtJ8y
 jP35Hh3X6cnuBEsUKYmFNfahCGSAgAumH6sdVt/NwyhFnJ8NH/l71x4z+H2Lwo8vR2Tz
 RWYDH7IxKy7upqZT8nO2/gFHYkr1kJ0xuzBkVX74fbQaI69d8RA6kqeiiAqTk4JN+Ajp
 pzl1exA+JMdj70Cn+wLRVtMiFymPtucziB1qZUBIhWOT3QQSbb4KhpImfN6Ne2gf00jD
 zXqXdMyLp4QMeey6wKTxD/x7ypTOi0t0E5K4UOJVn3dFe0Ph46nObwsjrrKqHipyr0Z+
 LGCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ9JcxIUu7H1XbhL71pt6Uchs2oRGFyGBa/pDGTyaFG8i78xOkCPmCj0MeGA9OQSRyVjTQ6FO44Q8XY4zG6yq/UtlZt2M=
X-Gm-Message-State: AOJu0YytD2IOT2ONIdBMfWDwuv8TkkOjxuGK/sdOZuCbTNesJ09FnA2j
 ZnQYC4wPTLZ68tn/NovHNpl1dgk0+8OJGsynE0QcTj7lVhFBjnL25M+SBo9ajUo=
X-Google-Smtp-Source: AGHT+IEVaEXjGf9T68pvPrsaIGinDH+m7BYCpDUPcav6jdtrDgLI1HJUeWgdNT3X7OJEoX81fAGX9Q==
X-Received: by 2002:a17:902:7282:b0:1db:cbff:f7d6 with SMTP id
 d2-20020a170902728200b001dbcbfff7d6mr8530031pll.44.1709846539617; 
 Thu, 07 Mar 2024 13:22:19 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 e8-20020a170902784800b001dcc7795524sm15334251pln.24.2024.03.07.13.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:22:19 -0800 (PST)
Message-ID: <79771813-9b46-4459-b286-e9ddb4549f83@linaro.org>
Date: Thu, 7 Mar 2024 11:22:15 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/sparc/cpu: Rename the CPU models with a "+" in
 their names
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-2-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307174334.130407-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/7/24 07:43, Thomas Huth wrote:
> +    /* Fix up legacy names with '+' in it */
> +    if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV+"))) {
> +        g_free(typename);
> +        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IVp"));
> +    } else if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi+"))) {
> +        g_free(typename);
> +        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIip"));
> +    }
> +

Legacy names don't include dashes.


r~

