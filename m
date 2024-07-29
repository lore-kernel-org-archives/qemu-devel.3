Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193FEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQ37-0001L9-BM; Mon, 29 Jul 2024 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQ35-0001Iu-AQ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:04:23 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYQ33-0007KI-Dg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:04:23 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a9e25008aso442580666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722258259; x=1722863059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VWQ4yhCslGD1M636d0irGcgNZDtB9G7Qz/FcrqfY5Mk=;
 b=Uxeq0nf7PYpH3kFhaeu1LwSQWu2TrUbTIjKO0ydH2fEM3fkXybFDKYOoHwvsstQdjR
 paPkPEiuAhyrLyTK874G04x0bMGExnYn09NfRxDcH79eYS+DykNa1tKtJbiKakd/Qn5P
 wNBMnBVKzioN/ORPbna9qFmRnipLSHIKO1cyRpLV37RTQpeZ+rfVLl4K+VjJ7k0lH+Oh
 t44APorTb6mGpZAMDyxTkwA37BItn97ABpiImGZ9SUX2K83G/DYMq/jipua7NgCHgz1W
 vvKSY0/HhtbWpb9T2qh6DrtsCiI6w+FEGTMR2MKxH5ktvbS1FiO0zcxHfonaAtaxRGQx
 lP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722258259; x=1722863059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VWQ4yhCslGD1M636d0irGcgNZDtB9G7Qz/FcrqfY5Mk=;
 b=vk4Z7saHQl1okauElSU2NKNB+d1uNaGfaesyHUK2wDaUmS2OxEhbw2iVBu1+7Qxjhc
 wfJoa9fcCgkgjX2Y6y1oSnGQvPSmjyHXarhpHyqUeZkAxVe0WqyM+bfFp93OIPnwwBTu
 df8OCf1VOgAdITkDokTkSvr+5+QdWx7hKuefePT10jpMWxMoURoA8YA3aSNbp4hvHO6P
 K0SKVIMo3nEt0aiX/eh+1XKehUN9mRVAk9GRGnZ481YXp40k/gVzlZAjRWtWh2itnDJn
 Bj/1nBncdgmyGSInqKMtMsaXtVjk7z5MZY8/ipkJxq2QxSTY+an3lviIniF9qAMArVJ8
 aBCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI6j3ixgIfPrUAHghePUGkpZLFFJWkKiD8PPAR8iLfWzthXgh6U6NeO4j0djugyhWrvGvgg1hRHJAcyhVYzpIuP9UKFQw=
X-Gm-Message-State: AOJu0Yz7/xoV9kg6uFT9fCW3YUhp9gqUDj2qpr0udoxwZOw9+v63Z6yJ
 TyP3jh2lm4EILxTu+pSDHHk/l2dqkDskt1swn7AKNxiqN1iCRf4+KS55+sUezkk=
X-Google-Smtp-Source: AGHT+IES8LSsuJeXp1lCWshHbN6U7fw31mwfny/aldOPl0e+bFlW3TlECnW+/KiAOQJrEcUtYcIVqA==
X-Received: by 2002:a17:906:d551:b0:a7a:a4be:2f9b with SMTP id
 a640c23a62f3a-a7d3ffdbe1dmr602687666b.1.1722258259220; 
 Mon, 29 Jul 2024 06:04:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4f79bsm501019666b.70.2024.07.29.06.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 06:04:18 -0700 (PDT)
Message-ID: <668181a8-938e-4b72-a633-cb8566104db7@linaro.org>
Date: Mon, 29 Jul 2024 15:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/23] tests/functional: Convert the riscv_opensbi
 avocado test into a standalone test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-16-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-16-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 24/7/24 19:52, Thomas Huth wrote:
> The avocado test defined test functions for both, riscv32 and riscv64.
> Since we can run the whole file with multiple targets in the new
> framework, we can now consolidate the functions so we have to only
> define one function per machine now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/riscv_opensbi.py         | 63 --------------------------
>   tests/functional/meson.build           |  8 ++++
>   tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
>   3 files changed, 44 insertions(+), 63 deletions(-)
>   delete mode 100644 tests/avocado/riscv_opensbi.py
>   create mode 100755 tests/functional/test_riscv_opensbi.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


