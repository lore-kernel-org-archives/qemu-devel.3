Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AF2FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJqI-0006Nk-30; Thu, 30 Apr 2026 01:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJqG-0006Nb-Uw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:21:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJqF-0006Ih-Cp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:21:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so2163325e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777526498; x=1778131298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2rO332CAFh7rKoeauTxc8pTMwUBPGstC6T94TCgKw6g=;
 b=l6AG7JvP27lFgp/bGOXBy5Rc9FIfeqXvhkRhRdgjZ6d/k6cCwfYB+o3aA/oClXWR+B
 2C8FiKE2c5rpeIyI2uBz85uP2CjKCnvMkHWaPqiDtCE6nNWN3Z4PrWzvwZXvkzQjzRIC
 T1FFi3E6awMwgRxxhh87UFwjnpEdPkDSqWywb+VBTTNru2p04tiY8CzdvntzN9N8timK
 gJDU5uWn8Vlho5RVb1aXnxXBbmtU/TcigEZEO5riRBM2nRZlfvclsCNJjxDrgELulEsJ
 iLTXKgqtrAofjpmlW7ZG3tL0tTjd/HQtSr1aD8FnoRqkb5PXLKPBwFXpnOGHtwgB6vDL
 aoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526498; x=1778131298;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2rO332CAFh7rKoeauTxc8pTMwUBPGstC6T94TCgKw6g=;
 b=b0lnSkamYMBEtp283W75lRDNF+nyCuhSdh4U1B+kpxihfl2LElYjTpE5y/0PuYn0rI
 2dkrNuPGkdszGV6Yi50YvNgdWfXJ6E/U4VML33080nDqmSH59LNbyh2NpzcdyrdfgyiM
 JTH5Y0o0baRgrPktkxQtdNjra7jVmm6cF38BI6J4COAqnHyBBWgGfFuZEbFFJrlM4JJv
 bvLbwBfWqk9to0MWi9bMiq0o6vFmcGfXYjc39HYTsAXh1mm6wDWNlpKEXqFQU+WoUYC2
 O9P/Ew77hHWR3gzLH9tIN7OcAIaT/uHe8MwHkT/HbhJdpgeR1HoWNcszXaKGjlXXqgGq
 WlzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oiKYk7Q5r6eIh/NkYuxOyo21K3azfV9y2hf55Vg0FgUr/iut+rK1Jg6U3VyVwNhtQvxi9V7SiaL8B@nongnu.org
X-Gm-Message-State: AOJu0Yz2We33hpkhYGZ7RYzsWkbLdP79B5Kq5cksmwgJYcOuGLrx43Tu
 4GJ+Cf0CkASBc7b7nrdNqdJFiTdx4y/UENm6SZTPdfFIDB63/wvTmqW2c/H42imimto=
X-Gm-Gg: AeBDievCIUBUok8IJBWnDQyObmoKsEEKdgY6/4q53lU9gJDpkfTeac4rEcXQqAYmxbA
 kB8H5tuEqY+ijbGHjoN4ApeOHc0izrE8R+tXaLzoDrjPCTnwK7z+OJh3+s1M0p9kGy9x9CAJwub
 sB49nrUGRK/HvkAMq7TviEkL1fmFfo4uv5mnBpIIpg4S0qNQE7oAW2FKRUnklsqlpkzws60fLin
 VqDZ7sksApd4cGuWlR7ZYqq2Q+gIbk8tavQ5eJiFJcRtvMsrCoU+DQX3Kc7MTtrYTA+Kjyp47ee
 ljWB/OTliHVf0ccsYHNLVYgDFtxVUkUxr8tkErJpmJIM8J29jVrnxz0yy9ahsWjF3B7BDhAuKIH
 eOBosuHy5iHj+AflIXdpTOmaA7cb5gzMWO39vSN08jZfUOY0n3m3WGPUREeurb8mp/lUFiSfMeG
 zePX5ytOCmypbhsJHigipQX5mrhHSOfFuC4oiVQwwkNHbkKE8SYMPWuzZ4Fe//DuubaPdrn64z7
 g0+
X-Received: by 2002:a05:600c:8710:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48a844448f9mr23602025e9.10.1777526497735; 
 Wed, 29 Apr 2026 22:21:37 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed69fasm52410255e9.3.2026.04.29.22.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:21:36 -0700 (PDT)
Message-ID: <eae051c5-29fb-4aa6-802b-d157f46fd1a5@linaro.org>
Date: Thu, 30 Apr 2026 07:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/40] fpu: Return struct from parts{64,128}_scalbn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-38-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-38-richard.henderson@linaro.org>
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

On 30/4/26 02:05, Richard Henderson wrote:
> At the same time, export.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h |  3 +++
>   fpu/softfloat-parts.c.inc     | 14 ++++++++------
>   2 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

