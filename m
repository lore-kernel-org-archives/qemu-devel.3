Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F1C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 09:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sghdD-00084x-Nr; Wed, 21 Aug 2024 05:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghd5-00084I-J4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:27:50 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghd3-00052M-SL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:27:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so880503266b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724232464; x=1724837264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cys3V/1kApFeBlIFKpt2anbyiLc5DQ1dg+CHX5Og18g=;
 b=oJMyxOXGRvl8R3F1eitagjfhvlyq1IiOE51X7GPdpcSzaP80Pe4llvXVYuXhatUbzr
 Wn+bA8wrTDb2IJVB84aNsms+61d1zk210yz4kdeS4GBcLYDV2iis3hGo4fQOq+mKCkjd
 F8/wgCE2ki3geN+c2YnFAMQxMC1NNlWr1T85p+sKiO4wvO7H9cvCftu0bKQoqwpwwdOP
 NUi7DT14uEsG82waaLg3v6Alf3dchd0qAgBkYJgytGSWKhNnL09nJJF0t37cAb2APsnN
 vvwbjctHXfR/q1fq6xcf8+fz8cDKzIclWCfm7iGTJeRmDtQRTRD7zGtawC3b6kbtERxp
 gGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724232464; x=1724837264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cys3V/1kApFeBlIFKpt2anbyiLc5DQ1dg+CHX5Og18g=;
 b=Luuens3r1jaTk69JBqIwtQFZ4g6sSoYQqwZfTHAb+K+MGgo/obUI2OizUpmWzfPg3K
 VMxApm1QySd2ytycCog7hgi0SBg2xreNf0eppP3IA/ZwDB65AuKiiYLBz8fsL3KecEv2
 xbaQ+W3TdkQYo292ywAwoh6/x/rffvEB07H6vw/IC1GAOzvzOus5hsGrlLmICmmhDDru
 jdWndTIdiHxF6PfmgturkNB9rej0JrmGRLIuL43sjCFw3SkqGtGyVpoBKk7Uf/Jyrazn
 sz218GnS/sEN8MslaerK+Jd8qt9u+sd2P5Zzj1kLMNFKhGOWlVQl6wJ1iYl3ke43oG8h
 4hyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7cRHadmc73c1cOI1W+R9qVDWFA8JqNYx8S9tRs6ipqATbFnN9vZNdhqaySQkztEIS+jT0LqGNaJTs@nongnu.org
X-Gm-Message-State: AOJu0YwJQGb9zOVWs7zWe3lDjowJG1yqxHKLhAiOl3IOn4z0HJNXH+aO
 h2aMGN7duJ6cyn3Sy4+a7XG5dhvTrrLJIksobH5d6xZfclc+gwVAhaUiY1ioBeUFo/uM2hQIHnc
 G9Ww=
X-Google-Smtp-Source: AGHT+IEz+Jpe5XE/njZSbtg0N5da0Qj8d/36N8at9sliCbTM33sM5EQYZPlEb0UBRtDYUN98r5WofQ==
X-Received: by 2002:a17:907:1b1a:b0:a80:f6a9:c311 with SMTP id
 a640c23a62f3a-a866ee68e16mr109818366b.0.1724232463546; 
 Wed, 21 Aug 2024 02:27:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfabasm874206766b.71.2024.08.21.02.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 02:27:43 -0700 (PDT)
Message-ID: <f497422f-50b8-44de-8145-3f5a14576d51@linaro.org>
Date: Wed, 21 Aug 2024 11:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] hw/loongarch: Fix length for lowram in ACPI SRAT
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
References: <20240820-fix-numa-range-v1-1-c5d6b889996f@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240820-fix-numa-range-v1-1-c5d6b889996f@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 20/8/24 20:42, Jiaxun Yang wrote:
> The size of lowram should be "gap" instead of the whole node.
> 
> This is failing kernel's sanity check:
> 
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xffffffff]
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x16fffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x170000000-0x26fffffff]
> [    0.000000] Warning: node 0 [mem 0x00000000-0xffffffff] overlaps with itself [mem 0x80000000-0x16fffffff]
> 
> Fixes: fc100011f38d ("hw/loongarch: Refine acpi srat table for numa memory")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/loongarch/acpi-build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

This is just a warning, so not worth delaying the release IMHO.

