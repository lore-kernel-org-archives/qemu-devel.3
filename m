Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0FDC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWd7-0005UQ-7y; Tue, 20 Feb 2024 15:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWd5-0005Tg-Nv
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:22:15 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWd3-0008IR-83
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:22:15 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1db6e0996ceso43665525ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708460532; x=1709065332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUVmSc2R9xawkZPYrE0PtPf9cLztRLyt8j5XJwpeuL4=;
 b=lT3lENIVlOwBASWqLhL7/AgDUMDLhgt9zfR3/hN5EYfVs+22ekZ1QaaPEHZmldvg+3
 FPJ4xH2OJXtcJY/V9wZpI+ygMZe2yt2fdhUrrzv/7dR3aJ2rGTXwkSkNlUTv5RK2OnkY
 rvGePR4u4Sz93WlMZI7lJQ77KpVJHnOgbAMxZIile0SWFFGV+8lOJCNOdJwzh9XjT5pQ
 NFQ8E4TyQoxPEJwmE5loJDlVzRpcLawWH7aFT2kRYd8x4vL181TQeeF0KGdVwcl/ZX+x
 e+Can2W7iTjsYwFsXy4bo3yY8Met3XVqke8j/TXxbUpo0m7VH6Nzt8diu/GKJ7B6Atcu
 1Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708460532; x=1709065332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUVmSc2R9xawkZPYrE0PtPf9cLztRLyt8j5XJwpeuL4=;
 b=DTu1tGZE+q2AoqKagq+OwQz8JfU7zmKIasrBpJBD9KdW8qKEA/UBJy06jPorixAF2/
 k8klxf6n8K3nT3GisuOob47ve+qjGRFktnWu9NQrewA/d+y+UTiKSRXoP2Zg/DjFtCxs
 7YiCIQPXaoaoHPV1600ab7xHKq5T50XD5+uGRmfcTbFgtQRNQhHt5w0T8gj7EXx0gC2H
 fS+NOehlcvGOgLbBfVqQdZk4Mnyi0KHCO1LWYEqHezXDWwjS/NiZwIGrC1nzzdNAaU/i
 nQvbJ9aadho9+5v09UeuNR8aKc+Jkhvq4sE1nf8q6lCDzSZNf36dt5IWvckltS7WfrH/
 Pw9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1HB9Dbhjj6a+JT4qMOB3oAKx0oWD0sMnBpvC/xiCgthQE7lxbnKVdfcCvtFTYsHbF4X8lou2L0u9Z6+l2uK3T+eJ5wmI=
X-Gm-Message-State: AOJu0YwrN1xphoWCi1Y89if8jfraq8a87uILj/t3Gllw0FYPPQ9B7IgH
 WV9HqJNcCdLeOyL9O5yzj12swT9qlu5V+ScxqfA1U9ipfBzpEBrvbHutbUTJqijB8e9cidbd3s3
 r
X-Google-Smtp-Source: AGHT+IH9sgEWcOGURNt2laqCsZ3Ig2VOuOnMmNPASKOzyJBSOZVveHNWf/pXpWYdY15xoKCVVjY4zg==
X-Received: by 2002:a17:902:7846:b0:1dc:3e:2721 with SMTP id
 e6-20020a170902784600b001dc003e2721mr3745857pln.52.1708460531839; 
 Tue, 20 Feb 2024 12:22:11 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902e9c600b001db45b65e13sm6580544plk.279.2024.02.20.12.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:22:11 -0800 (PST)
Message-ID: <2dbadbf5-3e2a-4bcb-8e45-f80885e37dfc@linaro.org>
Date: Tue, 20 Feb 2024 10:22:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] target/riscv: Clear vstart_qe_zero flag
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
 <20240220192607.141880-6-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220192607.141880-6-dbarboza@ventanamicro.com>
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

On 2/20/24 09:26, Daniel Henrique Barboza wrote:
> From: Ivan Klokov <ivan.klokov@syntacore.com>
> 
> The vstart_qe_zero flag is set at the beginning of the translation
> phase from the env->vstart variable. During the execution phase, some
> instructions may change env->vstart, but the flag remains the same as
> at the start of the block. With some combinations of instructions this
> causes an illegal instruction exception. This patch simultaneously
> updates flag and env->vstart and to avoid inconsistency.

It does not update env->vstart.  With the commit message fixed,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

