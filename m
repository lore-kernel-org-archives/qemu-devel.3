Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7AAC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmXP-0001Ed-TS; Tue, 30 Jan 2024 06:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmXN-000152-9z
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:44:21 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmXL-0007b0-QX
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:44:21 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a35e65df2d8so213125666b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706615058; x=1707219858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=38vZLVE5LLM+k6uuuX2x+pXQ0WmZImqryq5Q84MBTas=;
 b=kXD7l7iAhuiut4ZolrakzeJW1k/WpM3KIRgKjGAr0YrjjhP9sqvzFFPJWkYEp4d+HK
 WeC8dagfdtajz11RD4vRVv2nX9dTctuagSxj7baHsGbm14rx/ebpdtSApQGieYWaeg9u
 07+eit03jrJD4ESYuTzAsZjTwnboRjxmBRqMRham4wlusTVcK/O2kztw1YQdNwttG27S
 a3ZJlohq2v9F4QAx7dEHk3MIEceggzcyeIbWT9zIx+V8jTuQUOFMchFN0u+M+2Ec0QWm
 HKnyvuCJJZhFTpSGCJdRJMjjgPZoWMYFbcZzRtawJ7FW6TtywyJst1th0QVf6UtwmeOC
 +ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706615058; x=1707219858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38vZLVE5LLM+k6uuuX2x+pXQ0WmZImqryq5Q84MBTas=;
 b=e1ZZ9RnPcbOE2/OolmwjZ1IYZb1OLdGiY3+Z/82rT5/6igD5yxj+C1ygE1+76ExF+d
 UjtH37Mq3tsAQ/wj4Vgzb53bwh0OsGDnOdyvx4EXgVYZ6rm4AED/gem9BOFVbONtPnd9
 aOhGNxO+bmFrACwO5pIh0cHgMDUEsTxWED0/Dbl6rMmbKDrRk6Vz6aJMeUCz6pfkJv02
 07e+URQrT5s+KmLGQie++pqEH5ic7YDXBSPmlQxcgplctxUMpEhE/ZeB4AGlQL4EWthg
 rRy3/N7pxNmT4fPhEKXkUfTiIxBeBI0QO2AQqorHjo9cw/jOPYQdk2ti9JUy72FW4jPM
 YvoA==
X-Gm-Message-State: AOJu0Yz0+3iWD8nvc7e6P0DBvKgfur7rp/zTpCiqzmTiI8Q8sDpiCkTP
 PnIpQBPQG81VZCKS6KFfrxX6ucDM0+qF7khoXQ4XL8rP/6IOoPNHXCzov/hinv4=
X-Google-Smtp-Source: AGHT+IFUo8Cp7fBtA/SO+mErjg/9m310v8s3OzBWvxmhkhNuLuKaeuJHcVbgQegxis1r2LAgxCV8Ow==
X-Received: by 2002:a17:906:2796:b0:a35:e40a:6d1d with SMTP id
 j22-20020a170906279600b00a35e40a6d1dmr2400245ejc.21.1706615058279; 
 Tue, 30 Jan 2024 03:44:18 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 hd10-20020a170907968a00b00a35cd148c7esm1865132ejc.212.2024.01.30.03.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:44:17 -0800 (PST)
Message-ID: <48e8b880-1e74-4265-a98d-d52345ebc801@linaro.org>
Date: Tue, 30 Jan 2024 12:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] target/sparc: implement asr17 feature for smp
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-6-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-6-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 16/1/24 14:02, Clément Chigot wrote:
> This allows the guest program to know its cpu id.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.c    | 16 ++++++++++++++++
>   target/sparc/helper.h    |  1 +
>   target/sparc/translate.c | 13 +++----------
>   3 files changed, 20 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


