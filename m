Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D65AC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 16:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIW3a-0005ns-Eg; Sat, 15 Jun 2024 12:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIW3T-0005mW-TT
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 12:15:04 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIW3Q-0003Nj-Ss
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 12:15:02 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-375f5c3ddb1so102785ab.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718468099; x=1719072899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmZmhZo0M9kwv5imz4/FYm0rlWhY7o4OQBi4TdqYFI8=;
 b=bSEO/M94JxbgFI044d+n6LxlJduwrqMThQJk2NtaPmSS+F+FrYercRf+u+/hr5oZol
 p9dGD9D4JyEHoY2CRu2Er+hQy5LGW7gfIiLezlncYUrOu1lM4CFH1JT3q97Vktju4MPP
 JekJTuZmw+GJF6CDFWP8K9EYxhOoQkVJ8cycPFuT2+wciDLq6k03HHu1uHEhiFTdco/6
 5PatXfREaG7xDjQzDzUHMkKsH2CT21u9mnXd0qsUd32QI2v/zHLUkKd50Kt8XpzJ46sQ
 sEe+GPNvhmUfxpyc/pglIVnUX3NhxjyJQ5unF5e5+44yLj928zt+e4zPdZgmbk8U8rDQ
 XiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718468099; x=1719072899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DmZmhZo0M9kwv5imz4/FYm0rlWhY7o4OQBi4TdqYFI8=;
 b=hJUzLbdrpnYZ5TjEO2iPUXrBPVcHdUXuISTPxhe1tdNgdeVuhAn963u1sTDAobVLJ2
 Oob++/iy3xkxT8r1U9qG3/hF4pFZC1d473PseZjB8m5tEzN+j6gI6N+SCfjo2+TAeav4
 uErQWVrX11ELKvIMP0ZDtugNvwiOEKjET9BJoOrZcL1w1o/lQpTtXt6Hsr+0pUtPCwnl
 fxS7ZqODdcR7NgLxoY+dZJdK13OJRznwqM8kxPS6L8rtoJWq6RxdqUc3aTo2zPKeemyS
 txBtPF+4le3YiQFXsl0W2Q9TYV6p4Q315UwSTcC4tJ9PMapzJDwgUhKNWJWxpv9Kd8lr
 0qUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq7k+Q6GbVlCBW7J9s1IpyQWw2EJ7VmJdGYJN5v+KqkCUjR3zsWt+9XbcT7naIM+59mVneo87KSOE8s4LJapL4u88QASs=
X-Gm-Message-State: AOJu0Yy+qADze+HtIjHC92EJJgQrv5lAMoIlJjxUqhhHG8U0U2w5gzeq
 uPyxU8ch1wrHKvcq48EO0ztBTcOoL/ZH0+ywi1VdYwV5UoTl2ygKbbpM4dv7dEQ=
X-Google-Smtp-Source: AGHT+IHfmiozO8W1bpN21Zd6EDgAK3E0Q/AqAe1t0CKg97Dv/08dmXsJg9z/HHht4zGhxI1DsEcytw==
X-Received: by 2002:a05:6e02:1c4c:b0:375:8a51:6c65 with SMTP id
 e9e14a558f8ab-375e0e2554fmr63295935ab.13.1718468099377; 
 Sat, 15 Jun 2024 09:14:59 -0700 (PDT)
Received: from [192.168.74.236] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb71715sm5010305b3a.175.2024.06.15.09.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jun 2024 09:14:58 -0700 (PDT)
Message-ID: <828dc03b-1e7e-40f6-80fd-0f5d56f362bd@linaro.org>
Date: Sat, 15 Jun 2024 09:14:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240614072620.1262053-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240614072620.1262053-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
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

On 6/14/24 00:26, Cédric Le Goater wrote:
> The following changes since commit 046a64b9801343e2e89eef10c7a48eec8d8c0d4f:
> 
>    Merge tag 'pull-request-2024-06-12' of https://gitlab.com/thuth/qemu into staging (2024-06-13 07:51:58 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20240614
> 
> for you to fetch changes up to d9f6311f5393da897e73be8a29c261125d0c1ac2:
> 
>    MAINTAINERS: Add reviewers for ASPEED BMCs (2024-06-14 07:36:09 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Add AST2700 support

Fails freebsd testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7106081732

I'm not sure off hand why this wouldn't also fail on Linux...


r~

