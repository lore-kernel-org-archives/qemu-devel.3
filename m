Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DC2F33835
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2RK7-00066n-VP; Tue, 17 Mar 2026 06:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2RK5-00066R-A5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:06:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2RK3-0006OX-US
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:06:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-485409ab264so3817165e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773742006; x=1774346806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kAXTf2igaVy3+OJ6+/gB87MwNPjzSb9TwapPHUL27MU=;
 b=jVKd24vmQ728wjRT0swzJdWgHDOdcrskxOPf92B0y0h2FLtEZTuBtVcJQci8koU38y
 2v8zpeowQCd1j7rxofzeHNEvrbN88X8i6kCr4RfrV6nggewjbU127bK7oEeggL9R7SkV
 oq/nqPgsuwhz9dkOK48fAtoR0ItyCy+tG7oAhu/MUi3+TsNxbc4+RHhXsLlY13S/Uetz
 tvsCqBQeRjrR0xDNm3+RdtcMIfhncnkGY9B7papQVbfBLxK/QFPiT1bzNS5LVyhqjkRF
 UJJSn5iM5Uf41E1yfjXJdg9hFpd1OJlGGn+acvIxH3nxX5B5Dhd6r1WkTNyG7G9sXyPF
 VUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773742006; x=1774346806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAXTf2igaVy3+OJ6+/gB87MwNPjzSb9TwapPHUL27MU=;
 b=OU4dVJvMSP+SEFLO/nndt4Biv6JctYdLsvIagLlKzPhbGSGuRsrVvGgvwCbwxOP6nm
 hgNe4g02FWMYeZz0zPBPNwFO/kB3Og9mTo3KjsL/oAc8fSbtSSiahC66NRyHh6BA4Qjs
 zOWVzHVQ82+gzoK3slZH7lhCIW8SdrY30By7VMBYb9SvnX+MkyzDlz2jlKu4yb7tlQkJ
 CwtD8HP0AggtcRUsQ/M0HWqHyK4xaie18CitKfzIZbk9t4/4WoEsTfwIWqsGmKujHGTo
 nQSP09i2fmsalr6SJvqgxCH5mvHxIuqTBzaUZRHQMWIHGBO7KDNsFFuHZcNvSFrD44sn
 yvhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiGmpHqqCX9UKQPgYcHcbJ1L+EsGRlguy0QirJXgYjiXnumVkrST7LTQuCxiYWBZQk7hD7VG5UoZQg@nongnu.org
X-Gm-Message-State: AOJu0YxGT9h72bFNj8SJDMRTBy8MtCsBhLdp+ZpzkhLvqp2UglBIDW2P
 cW7nGedcgk5ApwblyyJT/nIGjgy5HPR5nl2fX9HlB6HsaLXoXgEtUUDZYXuF8tlDwH4=
X-Gm-Gg: ATEYQzz/SfgvA4+qJISM2jgaMGItG9KuouSFEJWt4frRIhq2EXloQVYcxPGh4cgB+Sf
 HITC70HrRVWjaLeyiHqpWyyRTWRx/ZUFLjbbMCdk5Oe2a+s9TR2thCrk4tC18hudfBg8G3EgvLx
 cdS5fBKo07zyNdZ7XRDmLHhfApCLSxNDsOeyYqdykwm1kTEBkMLbiPTC2o2pwVuqJAFqz64wr+S
 HUQLWNGTfkOcsnbxkd1A7Yk0gDclfk7AGQdmT6Df7QP069nekSvD81HmakawiRAIMt9/Yaa/km8
 Q80bchd21zKqqD2UWeShIKYMa28bYLfEejxggpNfMajsIAryCFFQaguzGJcS8VoQnfawIK6z82/
 Df6sTz6r5IvFSy9ux+Q0wtB8nhPVuyzHiciEC+L41fF6QumuNRhspOm+JFrh/1fcIl889VVDbUG
 F+TMgqz48V5g9WGnzmdrqA4Vhr7iAHbIYMOdZh45hUakyiw+pXXJgYvQKwYQKGegYtwQ==
X-Received: by 2002:a05:600c:1383:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4856eac2e70mr43939445e9.8.1773742006129; 
 Tue, 17 Mar 2026 03:06:46 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48634a7ac93sm33264365e9.2.2026.03.17.03.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 03:06:44 -0700 (PDT)
Message-ID: <2ad9cffa-f87b-4939-a0bc-04f4f30a0e09@linaro.org>
Date: Tue, 17 Mar 2026 11:06:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ati-vga: Avoid warning about sign extension
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <0cc6620e1d15af6ef465e2322dce6d4c79ad0793.1773618848.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0cc6620e1d15af6ef465e2322dce6d4c79ad0793.1773618848.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 16/3/26 01:05, BALATON Zoltan wrote:
> Coverity reports possible sign extension error (CID 1645615) when
> reading DEFAULT_SC_BOTTOM_RIGHT register. It cannot happen because the
> values are limited when writing the register but change the code to
> match other similar registers and to avoid this warning.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/ati.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

