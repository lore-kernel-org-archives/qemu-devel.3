Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EF6D1715E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36RJ-0005ql-5W; Tue, 22 Oct 2024 00:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36RG-0005qR-OS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:24:10 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36RF-0005db-A2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:24:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e56750bb0dso2406911a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729571048; x=1730175848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=udF0ztqIpxPzSV/EnWwWwqcBYJUx9H9orbqpOAQzft0=;
 b=g0j1ErpRYNPuOpImRavYWRVA19mOSEtdf7VJ2q0RvGU2vJK7lJsgeEwqZTaXnWOuwt
 DyEW+Qf6+1glTTO5VOZjuJ+HPXXdpyrAY8nGJ9YkOyR/k75PQLNp0v2qKSBBJRpugeGB
 r6eG+xRH+tQW3nk+t7LEBNctMqfGy18GwlTMJ1AHY+4tePKstk/IC5A0Qf2sO33EsrGH
 HwCjqUPoPmx+Z9cNCgMmwMcutg9FZeDaR+xbqx772bVQEGvsVk52j2P4jIR3jE7a2ZrP
 O/EDG3wz9J8ZJC7ig6lKCaAmF4ZmLDH4srHrPjm/Lp3mB8wDG9eE3JN/3FOV1wtBDU6V
 wq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729571048; x=1730175848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=udF0ztqIpxPzSV/EnWwWwqcBYJUx9H9orbqpOAQzft0=;
 b=TTOGKsRP8lwBa3vV/Tr4hiJE0Wt8jXSWSAAHl+cp0rJRDagyhih8XGHtQQoI6ykg5d
 fhTj6ik7NJDlgZSFH5Wv/dlW+i8mZRHSPGyknBBfKW7yYG3phHLoWChBInV8x8ZAm9KJ
 6m8CCFM+GRtxHsdaoAgdwiaXzPe6spd8K+E/7QVq6MDFdUjTCnxUgvRd+xBAn0YYZB/F
 xSxT6wFSI1Mk6N1UCkpUu348uCetK2J9wiBY72ow41zvZrBlqbwma6wBAOsAW5BpxWkI
 0ritLvar/KRYFdtHNtuwNg7IFF0RCcdT6UdpV7ottgbBjSZPDR/qXkIhXyiPhOg5D4TZ
 x9Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9XJZ2XypGf56t7FZnEm92jLWKQXWF+aogkxEbSGpQZyKMHu459jfNvbfUsmeTW7Opx5K2czryEdbb@nongnu.org
X-Gm-Message-State: AOJu0Yw39+fLpkweF5+yi9eFS1rY+JSLUyxskIZMQ8nl5CrvEQDbFNN/
 yZoC6pLoP0Y+rE+ls1zFqCIZoP5VX7wtVLSOy5F4UcxL/atSXIlCio3eG0cyNK0=
X-Google-Smtp-Source: AGHT+IHJ6HIIVYO8+qNGH0NvP38SUOy65xHa5xDo9Ws2pP/rOiWDX6yMl22wPzvzDUAWnkoSvQNH/g==
X-Received: by 2002:a17:90a:9c8:b0:2d3:c9bb:9cd7 with SMTP id
 98e67ed59e1d1-2e5619f6ca6mr16553657a91.36.1729571047875; 
 Mon, 21 Oct 2024 21:24:07 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad4ed83dsm4870093a91.35.2024.10.21.21.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:24:07 -0700 (PDT)
Message-ID: <d20e3944-7ba4-4b7b-a14d-d4135ed413af@linaro.org>
Date: Tue, 22 Oct 2024 01:24:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: enable afalg tests in fedora system test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20241021170236.1443887-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241021170236.1443887-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1033.google.com
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

On 21/10/24 14:02, Daniel P. Berrangé wrote:
> The AF_ALG crypto integration for Linux is not being tested in
> any CI scenario. It always requires an explicit configure time
> flag to be passed to turn it on. The Fedora system test is
> arbitrarily picked as the place to test it.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



