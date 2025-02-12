Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93289C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKw2-0006co-R1; Wed, 12 Feb 2025 17:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKw0-0006ca-CA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:10:20 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKvy-0005r3-G9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:10:20 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f7f03d856so3007805ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739398216; x=1740003016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNGE7w+fa+18fpeYIfM0mgByYdafJ9bwWmhCUivhbFA=;
 b=cCJuH6s7z03cHuhoyhKui3Ki94ONwud5i9drqVRHzik6QqYZB0t24P2la14DjkMjwY
 lKoqMhdf8qi8CCo2C3fkGxD+ILuMbAGhUBn+Y9FX9qwR22Yz8o2Hf/XurLJl02pjwGbk
 S7UbnGRaPTd+8yZlPtQNRaT4W3PJ2r/KqngxeosEg6LN34C42NFzCT6J0s60PirEViKF
 EslUlAf4hiXE81+sbbTeMMkGvmnx+MIff69h8++wQOG1UIB+Q9bM4vjczjUosWHBCvsl
 Qn6aKh4Ig3+qwfCjz5gLaWnEm5doMu1ApUrL598iE73T6IgdXfRQHk1aXyJnKrufL/yz
 OVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739398216; x=1740003016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNGE7w+fa+18fpeYIfM0mgByYdafJ9bwWmhCUivhbFA=;
 b=lP2VDxTtTzuwEoMKj5sGzmxrxyx/zUcimguOTAiDTeDdl03A4IQJga3S9IA7/LucMY
 3tOj068zhvgmEK63veLJlfjAIdayLL3JsvCFGU1TPrtS/Pkv18NcdnLiKY2W3rRzaVUh
 CXE6plgSZffLKxfUURbIoy40TVNjs6xDNA/KZcX4WHM6ZdUX9rfHjS+cYi2OX3/ATcPK
 /0oVCSvxKmDcGxvMlCgoJb41XaNvIPTyf+H6UtUVBdEvfrppDpgXE33uNXxnXTsvVWr9
 p7fwCFMPjmIj5m6EPPBSUingmnoiPPn8/cEWibSeYiOrkA7mqBjcBveztYvR6jBf25eq
 B7vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU09bzVgUUsmhGnB0MWbEXJ4qDVcUENaAbeL9GBnbH6uXY0ld4VEfiVmm8XzZAz216fuqnmvkJrQ5Fp@nongnu.org
X-Gm-Message-State: AOJu0Yz5yk3c2Qbl1KHtyy14bU+Qub/WDUCnXvoWsHA8j6mfj/PqWM+c
 8nRe8xAuf+eK+YBbGAJnreIIC8su/8fFXbIp7q5gNd7g/cBSm3HwGQJfp0rWW5VRN7g8QzfG77M
 n
X-Gm-Gg: ASbGncv0Gb8URAndpOeW7cCBa4uITa4jUpAb6tG2KmERIUZsS9cvGtva+esWth+ezsk
 22/TdtS2KvOIzu3awlMijL+gtxg59j3oRtOk8b1dqgqZSA+8dOmPLr+sA+6b+xA1HMyvcasmDcy
 v+P9nM90bSC+ro7gJjQDVMV3tLolbac6Ur492B6+vaLbHKttdvqLbe4NfR+ZZFwfsFVS7dwcaUE
 pHP8A3xAgC2pYLzOAZwENFTySmvVhRDgeP1mFE5v4N9m7QSsEm219HoV1EwBJciWLjvVQLg7xuj
 r4MxJzl6NMrlxO6+oNf3sa3KTtDJpa9Wdsk5c4o6HfH1yOE3z/6LC2c=
X-Google-Smtp-Source: AGHT+IE/SJ/fzw5pXlbIH7h4mQ07swBAT6h4Ly4oVpAHciAW+DQYQSmNrIx/hGzd7NtVjMLfy+Y00w==
X-Received: by 2002:a05:6a21:33a5:b0:1e1:c4e4:8898 with SMTP id
 adf61e73a8af0-1ee6b1e6070mr2423238637.0.1739398216632; 
 Wed, 12 Feb 2025 14:10:16 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51aee5067sm9902150a12.33.2025.02.12.14.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 14:10:16 -0800 (PST)
Message-ID: <09a344ad-76b1-40ba-9231-6fb5d9236028@linaro.org>
Date: Wed, 12 Feb 2025 14:10:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/19] hw: Constify various TypeInfo and associated
 structures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250212213249.45574-1-philmd@linaro.org>
 <20250212213249.45574-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212213249.45574-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/12/25 13:32, Philippe Mathieu-Daudé wrote:
> Constify various TypeInfo structures.
> 
> When they are generated from an array, also constify the array.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/e1000.c             | 12 ++++++------
>   hw/rtc/m48t59-isa.c        | 22 +++++++++++-----------
>   hw/rtc/m48t59.c            | 22 +++++++++++-----------
>   hw/scsi/megasas.c          | 16 ++++++++--------
>   hw/usb/hcd-ehci-pci.c      | 20 ++++++++++----------
>   hw/usb/hcd-uhci.c          | 20 ++++++++++----------
>   hw/usb/vt82c686-uhci-pci.c |  6 +++---
>   7 files changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index cba4999e6d0..4436c2ce0cc 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1766,12 +1766,12 @@ static void e1000_register_types(void)
>       type_register_static(&e1000_base_info);
>       for (i = 0; i < ARRAY_SIZE(e1000_devices); i++) {
>           const E1000Info *info = &e1000_devices[i];
> -        TypeInfo type_info = {};
> -
> -        type_info.name = info->name;
> -        type_info.parent = TYPE_E1000_BASE;
> -        type_info.class_data = info;
> -        type_info.class_init = e1000_class_init;
> +        const TypeInfo type_info = {
> +            .name       = info->name,
> +            .parent     = TYPE_E1000_BASE,
> +            .class_data = info,
> +            .class_init = e1000_class_init,
> +        };
>   
>           type_register_static(&type_info);
>       }
> diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
> index 9e2f6563a0a..152208d931e 100644
> --- a/hw/rtc/m48t59-isa.c
> +++ b/hw/rtc/m48t59-isa.c
> @@ -51,7 +51,7 @@ struct M48txxISADeviceClass {
>       M48txxInfo info;
>   };
>   
> -static M48txxInfo m48txx_isa_info[] = {
> +static const M48txxInfo m48txx_isa_info[] = {

I wouldn't mix constifying TypeInfo with constifying class_data.


r~

