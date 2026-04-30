Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DA5FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJpZ-0005zT-A6; Thu, 30 Apr 2026 01:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJpX-0005yy-N8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:20:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJpW-00062L-AI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:20:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so263105f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777526453; x=1778131253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+Kq89e2r1MCtW4tFrj9QSerWh+WJBq1H3xQhJenbPo=;
 b=QICENCM+gH8O75Zf1tTsHD7i1gh7w6NdS5CGRMXL05h0cRg7yXpbAiVNK8l2GdVF//
 rfUMCjs5oC06fV1nWTTEZlzqYewOtHRGPjKztQ6IT2eLWTcjLXSWVIkjXY+wIDoegERc
 VjHaSJxwRaE2652TBbOO8JhS0GapUtULdQbcC6sB+0Iool/P3UoUmb038OohwtcKB7aX
 hBfhgCgS4ONk6pDPwFndDEEvhtQ617ljiAVL9rDDzrSEQ9kOaL8w5WBW9WJvAg8AzOEI
 p/yTg5+OpmfMtROYj1kLw3LaikHh/SYbO3IJWjDL3w6MzPLQLrV7AV4ezlT/xOH0/QrP
 oeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526453; x=1778131253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+Kq89e2r1MCtW4tFrj9QSerWh+WJBq1H3xQhJenbPo=;
 b=dHPJY8KXqmz7xG+/epLj40f/VV+rFCqXA/QqhC/F8sjEOiOUGMDRbrHD7kSYmvAlKp
 PsMgnBplK2S8XiVhCmDP5msu85SAuQXxWq8UnZgq3rwu5RGhol3pX4B/bunlB+Zf6WXg
 Nho+fT95EBqS35gbOCiDkcBQV1XoyKbtd5InpnVlnCvqBDnbdfP2W3bd2lROpnms5ikh
 cFnOu5BmQwpu6FOg02qgG+0CJXkUn8sCXRnP9zldCt3TyX9sxA2Rls41pneKuYkVs9kp
 E49qdE3IYY0U0zdl5wwdt5IeT7abvQUvnrjUVLqHdG0ZJ9gIoBcxYhfZwSZ8O1Il/lbL
 hrYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NTEigRNo65mKM9nbEHfhmfWnLrJM3sZWVY2SjbY8GKEXtKKPKIfPy4muUQf1M+YG0TPgrUBC4nvY9@nongnu.org
X-Gm-Message-State: AOJu0Yx0ExHvgwGdnAHiyHCYgvDcY5LoI/nJjTDmUR0dw9oYI44lQEkS
 D0OHNTlFb5HIunmovuDOI5UIRvv+NyyQUZZLT5tifz4DuHdl1PssscaJ+FJv1phr+bFtqHxXNkA
 liqSVzEc=
X-Gm-Gg: AeBDieszk58zcuanXqZKYFsl4nU78ij7liC4uwayB64UY9paHr/xCbuL21UOJtRmP9/
 WwnfsdmO8KWefFpljhZ6OVLuCNeV2ok/P2SeqMV4Fv3k4lTjL7TzVXOhl5GltGuQEjy/HRJgi7B
 7rhxzo/QZQC4HAjuirj0AhFOmTs8e3wiybZqyACzSUVcW8pXCsxuNh+Uwma94JmrloicDfZKSRi
 IH9qfJYNGLhyfqcydOsMNroaW7RfScrzYf1xx5C7ccfDrZHV9bn4vSWImbpC0FaqhYO6AZFCxi2
 scFXFfdWuaGXXBtguJi8c1KvlpnFwg9j7NegQaVmtlkU21+slyX8QmsRA5HKWBFDPkm5owhWIxm
 apTR+i/3lWWbyzrXJoLcQ9pip0rPWYfnhqL6KZ355PAACkvVpK4IfQ4iCdYqcDRb+sOnysBTLXz
 zl6UbiRxMTl/WzAmCIMOh3iSvMI9RyBBBMbKWhxdlF42QXJ37REefuNW6mARewUdUX4lB5M2G+s
 jpX
X-Received: by 2002:a05:6000:40e0:b0:43d:50c:6f18 with SMTP id
 ffacd0b85a97d-4493cc3fdadmr2011855f8f.11.1777526452644; 
 Wed, 29 Apr 2026 22:20:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-448af0fa81esm5226657f8f.19.2026.04.29.22.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:20:52 -0700 (PDT)
Message-ID: <5bbd0759-d172-4430-b771-3ab60d7c55b0@linaro.org>
Date: Thu, 30 Apr 2026 07:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/40] target/s390x: Move
 float{32,64}_s390_divide_to_integer
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 30/4/26 02:05, Richard Henderson wrote:
> Now that we've exposed enough infrastructure, this can be
> implemented in the backend that needs it.
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h       |  11 ---
>   fpu/softfloat.c               | 137 ----------------------------------
>   target/s390x/tcg/fpu_helper.c | 135 +++++++++++++++++++++++++++++++++
>   3 files changed, 135 insertions(+), 148 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

