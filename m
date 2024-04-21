Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D39C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rya2a-0003CU-6j; Sun, 21 Apr 2024 12:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya2Y-00038O-7Y
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:27:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rya2V-0007Ls-4a
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:27:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so26238975ad.1
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713716857; x=1714321657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iOyaZMyPq29jL5oW2CX6HwsQxIE37ZSna4tob0e+Je0=;
 b=Lqu8WbsfbY8S5FY1jHZqpKbt9D8s0wIeais0fyXzXkx3SMH/B5nmHA/drswn8Sp8yx
 6qFDOJUYi/jN7AKNecrdK0CUTFAnFpVpngL6tl0MYdhPi9BARtwsdt6NYpyxlheQpBfn
 TV8Z0MhDk6JFuh12U8vVSS/Tuw8GMNf5ppnaU2My8Ob68qQqaGGB2COyycTdc6FsZR8J
 QoBouAUg+LeQaTg/YGoRyMMrsEpTP0Kw+n5IfkcuJayBIn3jIhVcWHNIse07wnSzUQlS
 O8MN8D4Cl42Lr7wGQTt9mnjOCLZ4CejXeqTJ1GRldvG7TUybI3Sc4VhfksHqVLgtdbjT
 pxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713716857; x=1714321657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iOyaZMyPq29jL5oW2CX6HwsQxIE37ZSna4tob0e+Je0=;
 b=ifYdJI4WqSWPkn5RKzOR5vBJoSgMbYnHHxnyFFdRzY16f7WPQheCUS+aDDKSGj2TSh
 jPSMmK1KDC1RqORxWnjVYhTn7LbgaJZRxxYbK4VGjCDFonECQUmkGVuYjINT2ErA02im
 1S1i+DleMDn9abLNq84CQNYGn6xzVF7NXCavJAPwZNDadVWqk4i3LkqerC02BGIQpV4o
 xD1kox60nSOKc5XAgv9faJa/kPr0D8e7Njd+Tkrr2wQbQP245G4g4GFQHoNw4k/tYXCD
 yjavfCl9rhzZsxdJLI0UaoK8yLP5RVCEcjhZQAOYoM/QzmqHfzQ3yajDmnTikVCHRB2m
 /16A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjQzgy3AZxn4auhSzTgLSOnmqO0cKP6LPdp8RneGVjQ5UKPc3HYczvzjnXOY6QfpkUjxglldm2c++3hjIhwqixZ0AIcR8=
X-Gm-Message-State: AOJu0YzmU1svrEQ9j230yilqpPkl5ZT+OjVC7flDYNJ9alDCkekNFrOq
 2fBtoHRIs9D/yFxw9eBxVtmGqsHDCpV67QCCEGm0UxqMbCjgY59cFEuPNbpybwc=
X-Google-Smtp-Source: AGHT+IFLfblF3YJSb+MSCnS69JplAb8izxUGFPdTcHajHejz8H+1RJSmXq+nZOkAxb+BHxcxL1/zMw==
X-Received: by 2002:a17:902:d481:b0:1e7:d3e3:a927 with SMTP id
 c1-20020a170902d48100b001e7d3e3a927mr10974124plg.31.1713716857100; 
 Sun, 21 Apr 2024 09:27:37 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 jf22-20020a170903269600b001e2a408df30sm6477996plb.273.2024.04.21.09.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:27:36 -0700 (PDT)
Message-ID: <0868f8be-1b48-4d1b-91e7-f4085e9055b2@linaro.org>
Date: Sun, 21 Apr 2024 09:27:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] exec: Restrict 'cpu_ldst.h' to TCG accelerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> "exec/cpu_ldst.h" is specific to TCG, do not allow its
> inclusion from other accelerators.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

