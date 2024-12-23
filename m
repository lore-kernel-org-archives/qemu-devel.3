Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C979E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 16:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPlL4-0002VL-9L; Mon, 23 Dec 2024 11:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPlL2-0002UL-6x
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 11:31:24 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPlL0-0004hz-Fb
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 11:31:23 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so29240955e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734971481; x=1735576281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OshU39fkw/Sq2aeDKqOUJz1CZscFEKzAYLrz4W4krFo=;
 b=cMcepyjMhtCFrcdlOArVbKhtpd4eMf9/wgdTuSKhayjy9In3fhjRHia+u9VxKe7yuL
 LCo7q9xP5qI4wcN07FCFy4KxiBe05XPQnlzTwQQZM1K3obN7FOWrVsbkZH7viDeal6tA
 sT8thf4gb6XHQPnj6gVWcT3pskVVycSfQyVOJru52DZ+CZe0+K5luUbe7GyyERpRMPiQ
 rMF9fabqa3i9SQU9avZ00PrSz58vyBV9JsUu88qzhfwwN12xKxiPSsG9VoUqQGgk6v/Z
 2X8Akmwb9EhRJHhhRhe9zA1TzY/r5YOuo8nJjGN47YFV9DR3Tu+/KO4hhXNJ0mDyoEF4
 hoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734971481; x=1735576281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OshU39fkw/Sq2aeDKqOUJz1CZscFEKzAYLrz4W4krFo=;
 b=jfwsWygdaq5/qZKG/Xm5rmAP5aVQ67FsJpahFAEPtPM0yysjyzrCCct5itDYj9V2V9
 29oB8zUM//wgWVJA+itirJdM38ms/uhuOGpTy0cMJL5K4wHjoUOojxA21Pse/sxYN6wq
 tBcbBeXLn3sjgUqATdRoZKGA911FIgLsoNwiCZ5pNoCe0ULeIIT6+jIGY7NhNekdy8Ey
 LecKOG1wmlZcR+OIKIAjTJioWoiqkSnUjqWnOqbTyLZ8PW53PXa7lNqHJy1jihbAj0hQ
 pIIddwOgdBz91HMHmGvt1V5v0MhYySAror6vIi/tM7UkGbAFQBIGqFU3dWQk/ZWXacPO
 r3nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuJH2wE5BTb6U/i4vHbBXpjVsP9BsGnpK1aRagYqYv+4J1hb/1F2Ckvp7QMceutE/RdEMHiNMaJiGM@nongnu.org
X-Gm-Message-State: AOJu0YxMoH4QfALxM4c3ytex0pHbEdFYM6Bhd4q+qjh3N9VJZNblMaf8
 yYsPx1jjPe+DGR4082MspqBhP6TOzWNfEII/8QGZvuOJgB4355FaaI0ZWbcgPrI=
X-Gm-Gg: ASbGnctKbLT/RyaE3fuzefuOHAolxLj/nw46KQCuO1ojSEYI4B3NGciev11br8wAjvO
 m9ezqGQD6YaCLvTAOc4H8q0A86LtXXsaoh1E0K+PU9AJZ7BuVWeWRiBezJSQQt+NMie1COS2k6V
 rZvmmFyJkAQR3Nl9gg1XEN7/+wNHHr2Xeytcf2BONaom9CBvExVHtwftCE/es496clcU1JA+DoN
 7fVxcZKsEa5iBXbSPdekl0Kqa+ErRFltUT5vtJcG6pEZoR5GDzJbu/wy60crdxrP1QXDevs4awO
 PI6SPaBdEXwhLSZ1NtM=
X-Google-Smtp-Source: AGHT+IG1O7g1q8OehghG1lbFKR03xFEFgsFyh3YCsv/O3RkwdCZ9RJfP2OnOnwOeHiq2PD/pGbBjyA==
X-Received: by 2002:a05:600c:3ca4:b0:434:fe4b:be18 with SMTP id
 5b1f17b1804b1-436686468fcmr121973355e9.18.1734971480838; 
 Mon, 23 Dec 2024 08:31:20 -0800 (PST)
Received: from [10.89.88.213] (51.171.88.92.rev.sfr.net. [92.88.171.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0145csm175489215e9.15.2024.12.23.08.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 08:31:20 -0800 (PST)
Message-ID: <ba0226c1-1680-4f28-b575-c708a6aa82c5@linaro.org>
Date: Mon, 23 Dec 2024 17:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 09/15] gpex: Allow more than 4 legacy IRQs
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
References: <20241218202036.80064-1-phil@philjordan.eu>
 <20241218202036.80064-10-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218202036.80064-10-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 18/12/24 21:20, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Some boards such as vmapple don't do real legacy PCI IRQ swizzling.
> Instead, they just keep allocating more board IRQ lines for each new
> legacy IRQ. Let's support that mode by giving instantiators a new
> "nr_irqs" property they can use to support more than 4 legacy IRQ lines.
> In this mode, GPEX will export more IRQ lines, one for each device.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> 
> v4:
> 
>   * Turned pair of IRQ arrays into array of structs.
>   * Simplified swizzling logic selection.
> 
> v12:
> 
>   * Fixed uses of deleted GPEX_NUM_IRQS constant that have been
>     added to QEMU since this patch was originally written.
> 
>   hw/arm/sbsa-ref.c          |  2 +-
>   hw/arm/virt.c              |  2 +-
>   hw/i386/microvm.c          |  2 +-
>   hw/loongarch/virt.c        | 12 +++++------
>   hw/mips/loongson3_virt.c   |  2 +-
>   hw/openrisc/virt.c         | 12 +++++------
>   hw/pci-host/gpex.c         | 43 ++++++++++++++++++++++++++++++--------
>   hw/riscv/virt.c            | 12 +++++------
>   hw/xen/xen-pvh-common.c    |  2 +-
>   hw/xtensa/virt.c           |  2 +-
>   include/hw/pci-host/gpex.h |  7 +++----
>   11 files changed, 61 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


