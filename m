Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223AAC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAj-00040J-1G; Tue, 08 Jul 2025 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDbe-0001Kp-It
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:04:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDbN-0003Ke-5u
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:03:45 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-606b58241c9so7637447a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001368; x=1752606168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OqYTuCNiZiX8zi1SLZHeCYNVHaveo99iC222kPTZLq8=;
 b=J4DHQK5Cc5/6/oitI8zMj36LklvE9itBfgsAYb2LdYHWZKeMD5n9mNZm64byyCsVCg
 ad9W2hH0sW2I08M+uDyS6NsqQtJe7p8+g+N8p3wBgOVp+5GyF3oaerjSkKAffAgJeDZK
 geJuL7yWuf5N6Tp9Tm4MF4tigMxIjvD/7vLcoyu7X9WzqZD96P5w8LH7mbw9iVEB17bs
 hxIUXeBxuWwuA+lK7xHcmgAoeDZVhffLA9fq2qpAfPznDMh2WP+3XaSPpyL8iErVwdL0
 lMvlwv6NbKbRZVOs8++1P8f5zzhOLsPZFiEOJt9PfocM/5GCFrMBusZ8l50A0U+vHvdS
 4pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001368; x=1752606168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OqYTuCNiZiX8zi1SLZHeCYNVHaveo99iC222kPTZLq8=;
 b=X6r1IpbS/Z5sjil8SEAlvVCx2sh5Y+uQjE9VatWAACOl23vKIbL6UHciZGVn2rSmxH
 y5ZeTumzoSgi3XFAunJ2qGX5nvU1j/O9klVLs5NWdqSyEhG21dZidY63mgngeNMacvAK
 1+r365nZOBzsENaYI7wwtQrxdeUHlyF3RhZ2B4f67a3GC/6DXDdmszglo3GCAdGdD2aB
 5rCTBMqzy+b2zl/9wLvy5SJmnn9nCM/vV5uuE9MS4uOMwhQZiQLndV4OJXe2Of3NB+JM
 bdhVBQStHDi81iJkejnL2V4NN12djl2OxSh9h1f3Mnrb4KgNP6/44YVRincV3ph78K+V
 pbwg==
X-Gm-Message-State: AOJu0Yz4oe1HNww6n5hFzpLpif9QiE4EM/TY3rqGAJ5zy4WrCjxFzUXT
 RFTWpDZpMEEVn+uATRrNIqHIwexPrw446NeWT5lily+aW+7eP0ndCO9OmB0yApNDSF2YbwxvaMx
 31xlH
X-Gm-Gg: ASbGncv63eFveZFMPYb3LggiDRztIjqqER9uq9yvXbTgxp6CCZ/KgnRIvKDCVptS4cV
 xrVhAgvIEv1cAxV3gfTP4pIcsjWKxYSndWSdRX14nocynVPKvxapYbwBOc9IdHUUTNjq4kB85yk
 3zMQkdVPd/lLkaBJvSFQ8IrNr4kCtHjNAJ27P52dVO69YuM7Sxb4wD40idpMjVRCpeyQUPkjF5C
 0B0s+jVL4l5C9i/PbihCkJqYSWk1GDVcG1IU4VrjO9yN9uZuZdjZTuc6RxFWvr4EyWWUubIGlcm
 bhNjTPQJxEFFqGauqF1iJyOfGq5eL4fpdj1f4eNIt6wn3unG3yTvBN7AJGGU/uMoeKY8sYppn0m
 Dv/YAqIdu0jJpFvARUluVhUdIeftyf1vnohs4b9jX
X-Google-Smtp-Source: AGHT+IGwaihnAEepD74IpnE32Ml4CpQq7yS6bPmQPjzCJbQ999fIFyIc9hoif/JyG0smPFOTL0s0cg==
X-Received: by 2002:a05:6000:2583:b0:3a4:e629:6504 with SMTP id
 ffacd0b85a97d-3b49703925amr13885616f8f.49.1751994670877; 
 Tue, 08 Jul 2025 10:11:10 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cdb381a6sm19420795e9.1.2025.07.08.10.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:11:10 -0700 (PDT)
Message-ID: <b56156da-c323-4eb2-9d0d-739e69769f14@linaro.org>
Date: Tue, 8 Jul 2025 19:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v6 00/14] target-info: Add more API for
 VirtIO cleanups & introduce ARM macros
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
References: <20250707172009.3884-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/7/25 19:19, Philippe Mathieu-Daudé wrote:
> Rather than re-spinning the whole "single-binary: Make hw/arm/
> common" series, restrict to the API additions, but include
> examples of their usefulness (hundreds of virtio objects
> removed from default Linux build).
> Time passed since I context-switched out of this work so I'm
> not sure the DEFINE_MACHINE_WITH_INTERFACES() implementation
> is in the form Zoltan asked.
> 
> Philippe Mathieu-Daudé (14):
>    target/qmp: Use target_cpu_type()
>    qemu/target-info: Factor target_arch() out
>    qemu/target-info: Add %target_arch field to TargetInfo
>    qemu/target-info: Introduce target_base_arch()
>    qemu/target-info: Add target_endian_mode()
>    qemu: Convert target_words_bigendian() to TargetInfo API
>    gdbstub/helpers: Replace TARGET_BIG_ENDIAN -> target_big_endian()
>    qemu: Declare all load/store helpert in 'qemu/bswap.h'
>    hw/virtio: Build various files once

Sorry, I cut this branch incorrectly, I should have posted only up
to here, as the rest isn't required. I'll respin for clarity.

>    hw/core/null-machine: Define machine as generic QOM type
>    hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
>    hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
>    hw/boards: Introduce DEFINE_MACHINE_WITH_INTERFACES() macro
>    hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64() macros


