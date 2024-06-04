Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1ABC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJQQ-0006kZ-Fn; Mon, 03 Jun 2024 21:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEJQP-0006jl-HK
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:57:21 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEJQL-0004WX-Qq
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 21:57:21 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-794ab13bb88so33039385a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717466237; x=1718071037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B/lFT36PutvwPXHDUp2hg1G8h6qJNOMSob5RR41OOsM=;
 b=jBbJatliFMPR/JH/zzZSuaCaJhmSQuJu5GrKzLrfOOr/S6XWwU8llRe8uuQd/GfbwD
 tDuf60NPihooJTRUGSzTuOypdkDvTSwl0hwGS93A462fal0JyaT3IKU1/we68TWNixAs
 FPjnJ5VceM4j/QUlXeP9IVgOAdgshl9B7pZKYmCK3dgaDzDLFxZsigKJGGXyYgEh15fl
 65yuMOOvampKepqUa5mB/mfuIasa7x3NBAltpZ2QzASJE+mN2l3TVJYGVjMhXU98Px9x
 K/dROJ8F6449+QJTArbsgxxxWU8OOeo+D4EV64jGdyWX5m9tB887BGJv8EXIw7Ahnfqc
 7YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717466237; x=1718071037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B/lFT36PutvwPXHDUp2hg1G8h6qJNOMSob5RR41OOsM=;
 b=g+AEIzfNWblDInAdQbocDYlHD4P1BPIDqsJmiObr0aQEf072k5Iyc2dOXmch7hT76i
 pr951CjAE8IcUWJE56JoQe28o8XLlACMi0gv+pKThACOo4iKmaaNyvNx5C7uiaXAWiV1
 VlukVPRdqARJjqdqD10MWPD88A6tfhsn0AmB9NBfa8sKu04H9aV052zhl1ta4qafm/lt
 AvDC64bs5LwWccg7EnzViI13howXHDlRuXal0ceMN6bXOM6OKUOYM8P9z7Og0p32l9Yd
 21p467b/kR+/Z+lrVCQgO4sSKjhsHg3m/viHlzTqXZfuPgvBtCJ/eQPdTa/AB3kIozhT
 PFZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeDQ3uG+b/QfIN3THbXASlfGXCGBle5rS9DgiquMLFsnnYj3Qo2UVDix5+VOx614XjfcHO3aI3ckjE6fWmVJ0BpbPFvvQ=
X-Gm-Message-State: AOJu0YzeS0qjAE0Sq6t6nuQyvGxt19PgO+lGcF8ByoNdP5Hy6HTybXwH
 JMHY3TMOhp5n1l5K0afvfePzkym0Jls2qluQAKBRraBGdE0SGiASuwfM6eWhwRo=
X-Google-Smtp-Source: AGHT+IEYH+ZDJuRbX5ig48d3I5/XOOFQpR+UtdLomyQajAJJlnjaGePTUAVnFJF/WqHRC+LVPZUCKQ==
X-Received: by 2002:a05:620a:22a7:b0:794:f9df:2cd8 with SMTP id
 af79cd13be357-794f9df313bmr877266785a.48.1717466236821; 
 Mon, 03 Jun 2024 18:57:16 -0700 (PDT)
Received: from [192.168.223.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f318857csm326393285a.122.2024.06.03.18.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 18:57:16 -0700 (PDT)
Message-ID: <e5c934e6-6b5a-4fcc-95a5-02b1257d31ad@linaro.org>
Date: Mon, 3 Jun 2024 20:57:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] docs/ci: clean-up references for consistency
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
 <20240603175328.3823123-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240603175328.3823123-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 12:53, Alex Bennée wrote:
> Document we have split up build-environment by distro and update the
> references that exist in the code base to be correct.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<20240529160934.982373-7-alex.bennee@linaro.org>
> ---
>   docs/devel/ci-runners.rst.inc                       | 13 ++++++-------
>   .../custom-runners/ubuntu-22.04-aarch32.yml         |  2 +-
>   .../custom-runners/ubuntu-22.04-aarch64.yml         |  2 +-
>   .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml  |  2 +-
>   scripts/ci/setup/{ => ubuntu}/build-environment.yml |  0
>   5 files changed, 9 insertions(+), 10 deletions(-)
>   rename scripts/ci/setup/{ => ubuntu}/build-environment.yml (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

