Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2952D1D48C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwML-0002CW-K6; Thu, 08 Jan 2026 15:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwMK-0002C8-7D
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:11:52 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwMI-0000Wx-Ql
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:11:51 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo2532864b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903109; x=1768507909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2RB7GASsOMmfqK5u+GGlqDXm2XCYcHHV298HMxrSmBc=;
 b=qH2EpvWG6SwSgsZylok5hp4SlpyP20LlrDPyb9D8uregbY+nAZRdle5yF7HtJ0BO4C
 8iUzWqpZgGqNxFREghUU9kB6kYhHAopXyJBCmiUk6/wyBmCTOT0l1mrq/eF2pV8PjDRM
 o/I6kVNNSe0yCxD9UATd4QZizaqBxYPqlPFYI8P6Esb83eBDyn3u7tMcm9qJ0SgmQRtu
 Zv515Rbwrqn71tWkh7Id0WaOEKNxdZMcvCQCYhBEBMKeguS9tWuzn4aQO0i+IVIGDWw4
 +F8kpJWno3fSNpIl4Aj3toXLZa5PlVCGvwSP85xjv0vYOoShH5kGrJXtvh7dVaktIrmD
 AtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903109; x=1768507909;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2RB7GASsOMmfqK5u+GGlqDXm2XCYcHHV298HMxrSmBc=;
 b=jH3Pblt5GQ1i7q49vN/cCQAP9eGYrbOvSJUcx22yh28K2awhoO7U5m92JlaRL2t4wf
 mzYWVrXe3V2dLI/r2RwRfZIoNVhpD+X6oZ0Zi6212PMeI+aNe3UI5XmGmkDWl3lz3jRt
 +bvGfzThcrqbEppNGEdstbtxZ/V0mqDHsMhIEN2VF6Z9yd+ex8HIFceL7vjCEpfS1KMd
 b/oNeQYrS7EjlXe+UjrX8o6VQAa5adIgHeIEkkLvTwpSnHi4CUJnkEHnTpJ/r4N0BWv7
 YBS/aQSxPp6bSsW4sKg1HmpOdHMyJ2OvKWZJN5f8M0878pFzetZS9fXvnN1ELuWhtHOC
 W2Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5o8WNQdXcoOjmJZAWmoObNma2ctFFuuI0xG2rlFFoplfPJGnr/UXPicdVUHWlT4VvjVg+1fXQgDLn@nongnu.org
X-Gm-Message-State: AOJu0Yz7c5ntlmTIS7w3KxgiTplS9gFZ7hHd2W6SbLtupD3CUG6rsBKC
 5uM9XnK1dfD3ibTrUsgjvFQLAV2tiQFuu8D9Fk/1zDaOpYverqW9euw0NysmrPVZCcJXpv1NY1W
 6FfaL
X-Gm-Gg: AY/fxX6QQ/xG2UBiazLDvN6FsftCnQStTB66TkMcoDIX9qv+DN2PajA7+krKMgy+YPD
 ZH04iR9B+pema5r1WefaXZIdCsZfbMc2EOYseOH4xc2+fDNVp2VVPVcn6a+wv5NmUXmUt8xDatx
 RgjZn+jn0C4hq+7P92XnPd087XZKhQuHRIXnhCVVV72qwZwH0mjoZ+xbSyK1ERP9gQKULE/89so
 iQS8j2lMmKQtlwaTtUhOKvF12U5yvtpJ0r4jGK0qITqV/Y1J59DtILIo0bF7hn8acjgS+blJT4J
 4a/Ocqlf0mKQSQZx4+sMPkWZTJN4zTdWTyZQ72WB8FDH/BDbyPfxWhqJqgRE3nvp1W3juD4TH81
 rjC4VTDjqxI6gEq8Iyoqwc/7oQ+MugWg4s5Mxfe7AXlFvTL8pejbT6r3h+Xbzm/WBcNdTt7gqEx
 pij2EUo27Mo36E+stXqGMLIAo9gbvssBuoi960Dt/If+GqxqnjaOgvkB2G
X-Google-Smtp-Source: AGHT+IElAWKixqg64Qa1DygCDUBTMIlJwEPI4CuIX6OFHyjVrnrh5zT5ScY/X8gk2ducx+0wLOL8bw==
X-Received: by 2002:a05:6a20:3d0d:b0:371:7f31:17f with SMTP id
 adf61e73a8af0-3898f9e2ddcmr6516442637.77.1767903109224; 
 Thu, 08 Jan 2026 12:11:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28faa9sm8680565a12.2.2026.01.08.12.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:11:48 -0800 (PST)
Message-ID: <1e9a6e30-e5f0-4a00-b153-f2a5f1b771ee@linaro.org>
Date: Thu, 8 Jan 2026 12:11:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/50] meson: Remove cpu == x86 tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> The 32-bit x86 host is no longer supported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure   | 16 +---------------
>   meson.build | 49 ++++++++++---------------------------------------
>   2 files changed, 11 insertions(+), 54 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

