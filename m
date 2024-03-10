Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7FAC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 07:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjDlS-0006CA-RJ; Sun, 10 Mar 2024 03:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDlP-00067V-LQ
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:38:32 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDlO-0007jk-AN
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:38:31 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-221a4f9557dso1454937fac.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 23:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710056307; x=1710661107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6TCgbNYQpuO+Dsqw18a9VTRlG0kaLjLAMqEEdqRkfE=;
 b=aKZ1kzwW3wubLTIpqe2Lp5fN74YIfsU0w/PxVnnFI2vkoc6YiVmkhG99wAQM6AysHA
 QK+qUq4zyVXCAKs2daaSoVJ/GqbEVkAoEU401I8QKIVZa/9SvxNSCJ42lIGEZhUDT2sG
 M/qbHw5gUM1ZXrqjuGYzDI+VsmZYyteUaFIpzqUZMze7u6KHTzOWQNWglt8fY8njYYVP
 c4oorhoZ2VJEV+FU51PynV4TostAzo5lU7rXSVUPTGfgjazEzSx7BI4v6MY/Y5fM5CG/
 EfKwV6jsQFUAmfBuaGhfn0gHyAL8MHTTf3y9NRR0tBdon0mi5pxumd7A0v47zIoMWK/e
 GCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710056307; x=1710661107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6TCgbNYQpuO+Dsqw18a9VTRlG0kaLjLAMqEEdqRkfE=;
 b=wpuCC2x9ilR8ottVojXVUeXf5TLnA7fjqd3DpUe5Td0w+X9XovwNXrOIjUpJ+rYJTA
 7eOniF+uBkhHyevA40Gw1iBeM+jJPq91OEOvDfBYsdv4dmkbmD0RcRg1KQY5aqcyXKHt
 ZCdRTWLCDf04OAz4hkRCFFv8bqUxyG8U82U3l+TCPI6HK3BlzmStJjT+N5SSqPPANP4u
 2msZs2Ui+KDESKav2jl2FewubyBSQ3poDXq3DcMGt/Fvf4zWLncul3n0BHw3jo2Rwnfz
 6GK1O9yEjEJE5ER6GDsHo6HCnZxJ9gD1Y0ZOKlW+WF91EXWFKpVdymbPVqHjtsETpyV/
 xwTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxObmNGddBomus5QbnvhHOgHWPEye08Di8vAp+s/hx5gGI6rlSJDZXb9/geUkvifMbCANa1KEWS8Tn6jvquopwPL1xdWk=
X-Gm-Message-State: AOJu0YwTSLQf0Pq83NIdGoLwt6CNdoJHH0B/geiIzYH7/C965UMj957y
 JBslGs5Dk6Qag38quP+bXXg/G0AYnmlXDU1BU8fcAiYMWVBYEwaBM6mXTmH5+DY=
X-Google-Smtp-Source: AGHT+IGWiMp32gWz+WN7OSLa9lZqKkN7qDiA5xIlMOkDts+8ns9caRDiVO9oTT9lR2fMc/7KUzBShw==
X-Received: by 2002:a05:6870:5250:b0:221:45a1:b72a with SMTP id
 o16-20020a056870525000b0022145a1b72amr3786573oai.35.1710056307417; 
 Sat, 09 Mar 2024 23:38:27 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 e30-20020a63745e000000b005dc832ed816sm2211455pgn.59.2024.03.09.23.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 23:38:26 -0800 (PST)
Message-ID: <88e5ceca-1036-4579-99f4-4fcea748d8a4@linaro.org>
Date: Sat, 9 Mar 2024 21:38:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/10] target/riscv/vector_helper.c: do vstart=0 after
 updating tail
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-4-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240309204347.174251-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/9/24 10:43, Daniel Henrique Barboza wrote:
> vext_vv_rm_1() and vext_vv_rm_2() are setting vstart = 0 before their
> respective callers (vext_vv_rm_2 and  vext_vx_rm_2) update the tail
> elements.
> 
> This is benign now, but we'll convert the tail updates to use
> vext_set_tail_elems_1s(), and this function is sensitive to vstart
> changes. Do vstart = 0 after vext_set_elems_1s() now to make the
> conversion easier.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

