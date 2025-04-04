Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC8C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XHF-0003BO-AW; Thu, 03 Apr 2025 22:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XHD-0003B0-JA
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:59:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XHB-0007V8-TY
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:59:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso2027567b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743735564; x=1744340364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bLHvGf1XUIrZw3XRDc6LzIxH5fIrITA+KPazkM5+IDk=;
 b=RBfKp8d0ePW3EWfkq93WFlDfu/kO3yOlFXt56mUvl/mudiI+DoDJo9gzQvg+eaDLKI
 6Hft8Zje1d9n9pRbQMcR9gK6qDMyFkXgrvgwKPmTTvpLjqhcAVSYXasaQEOGEh9DKNZR
 C2bNfEcM1lbebQV0y0gGyhfYqv6q94cYIrMuMfrBwNOhjCZJdR7LaaNOUqM1XAbQCaGj
 7jrienp7zXCM7akZqHGL6Wyj3ukY3iSfIL4JKpIU/S6uFmMYEIJobkDA+eceactoGPZd
 +KM5oc7cM3o0MtJ0qFoT0olIEzDypLQKy7ah5f7CgpgR4gdXAVSPCErzQxWV2z7mCkwK
 uEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735564; x=1744340364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bLHvGf1XUIrZw3XRDc6LzIxH5fIrITA+KPazkM5+IDk=;
 b=fzZeANn+S+gwTjOEntoLrRZuyHaEyY5Gd9oTy3Y5HJ9uI66C5KtJTvlSgzpcdTLEXi
 3lQVTHgdndIPPuPEZ8TE6DGMOHx5p9Wlk9LbwtZjc3DnBdbhyE61+0edEAwQ650tjJrK
 RFJc/N9xwfrmqXuStmkbH2eNzIbSCkw+FpsU0XaDWHYVeOni8kaWTPXOIU3b0pjuC3Hk
 W+VPfrHnIqOaOSrSg6qBSuZiwdVOh/hINTM5bCK/djpNO4jdbMIHtZ/mvMmU+eYJ53Kz
 5+SkZkePjo5AZ8RTYk2Yv8asasCPdsZ1cSTlM37RH2ddyK1U4lLh5WaVhyvsuOJ7SqPL
 3u7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2wggIP943rl/dd8JKZUxvKmvWm2FS5g69+IOiG/yvN1PJiDqh7wsFU6ynEsxNxEqvyZzJteDlTSg5@nongnu.org
X-Gm-Message-State: AOJu0Ywvnv7Ih3t3fhAWYCXG5xra/Hu/gVKlaCECLR6nMHW0ZPaS0fzo
 6M137H/DH4k+PihJSwWT8mGPTGc7Z7Q2u9Z/gps3/jPAWiZ9fDy1+Fw0M0enUVw=
X-Gm-Gg: ASbGncv3RwnznUkBPkW+mabGp1sQ8eMcCiONLCNbBEGRp6Y/u9DLozSxCzZL4bBtAnH
 u8pXOWDctiImO/EKxyZFr+8P3U+AouZeOOq9fiUq43SGCrpGBsWuSYkiTLiv6lwvp8RIAvIym3K
 GQvcBduhLudZH06PJ7TvzXt3j8mPZ8sncAi0q2a1VKdFPwM1hJNvk8Keh66VVHutesQNFVfExxs
 3t1KRNkKI1sd2/3e7YXrbzgw8snjbCX+NzdfFi0Gct8C3jBpjNzSuARUoBGYRqZvVaeib0PXGma
 jwzjgjW9LgCrEEIuLtTx1qiVZV/OE+Sa3VIxtGw1+orKk1GhIgi97srJ
X-Google-Smtp-Source: AGHT+IFSPUB87dTHHip0stD/lox9B3tKLa1omxTgmSPKHMffkSU0ztRCJhCVq4LkCLyH72opL8imIg==
X-Received: by 2002:a05:6a00:2186:b0:736:5545:5b84 with SMTP id
 d2e1a72fcca58-739e48cefd7mr2621989b3a.3.1743735564197; 
 Thu, 03 Apr 2025 19:59:24 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97f36b0sm2350996b3a.68.2025.04.03.19.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 19:59:23 -0700 (PDT)
Message-ID: <ca2a87c6-10a3-49fc-9a57-a108f28168ba@linaro.org>
Date: Thu, 3 Apr 2025 23:59:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 3/9] hw/arm/virt: Simplify create_its()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-4-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250403204029.47958-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
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

Hi Phil,

On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
> No need to strstr() check the class name when we can
> use kvm_irqchip_in_kernel().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/virt.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 177e9e0eadb..326986deb16 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -711,21 +711,15 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>   static void create_its(VirtMachineState *vms)
>   {
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> -    const char *itsclass = its_class_name();
>       DeviceState *dev;
>   
> -    if (!strcmp(itsclass, "arm-gicv3-its")) {
> -        if (vmc->no_tcg_its) {
> -            itsclass = NULL;
> -        }
> -    }
> -
> -    if (!itsclass) {
> +    assert(!vmc->no_its);
> +    if (!kvm_irqchip_in_kernel() && vmc->no_tcg_its) {
>           /* Do nothing if not supported */
>           return;
>       }
>   
> -    dev = qdev_new(itsclass);
> +    dev = qdev_new(its_class_name());
>   
>       object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
>                                &error_abort);

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

