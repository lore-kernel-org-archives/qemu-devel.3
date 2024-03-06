Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44178C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhijp-0002cv-2K; Tue, 05 Mar 2024 23:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhijm-0002c4-Dx
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:18:39 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhijk-0005ge-VU
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 23:18:38 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e627596554so2185300b3a.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 20:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709698714; x=1710303514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fK4rbnMS4e7wpNWAf3ykzopx7V0lLm+h5DIhfiTUhIE=;
 b=Qc3pUkqsC4OJHebK02bTZ69MH4TuNXMnSQWVUveVCWtGT2fMEPcIBxf5VbDfbEvgpF
 6UOHonWsV4vs8rFAk82Rkm01VmAR6uukWaxOQ6qAdegHsD7ljhBu2Ky4AFEqKQmJe0M2
 q5+qslT6lu+BacFhIPgTxi+qpG19KRCYa4EScQeUzHSMIMh9rHd3yJ/LVZRy/OuvFuST
 OWyZz9fwb+1yfmDXAxexuQZSxG5WcO5s8NW+vKs2eSQutmxz9HfQk9NEbMUfMZae0b3h
 S4le/xNib0/yfJ2a8Srwc97ljC/tjt7u8wMX+wahvsi6j53kCcNZTQw1ZujWdNuUsmkI
 OtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709698714; x=1710303514;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fK4rbnMS4e7wpNWAf3ykzopx7V0lLm+h5DIhfiTUhIE=;
 b=s3TdDdA8YMw2loM05ceVOD19HRo7bMkq/ZDsnaXgY1K2514oXq3XgjBFBcAD5AJdmr
 2XvIXite8PFeGewD6grzjFuX789y1LOEoTubOfQRUJgCZ1q87rhvkVZKLLFznuJ7CmMK
 Nt5UjVzt7VqGh141Wyx/hew2GhQZUz9ENlzHIVtdkQ59XwKdTEPmfrZ4gKzmP0voc9Rv
 w0Ucop/kx+SKuxScGHC5/LVhptgrtz/+uYOg7Z+cxzwjMgcbukjVKSC3WP95vUv47Vp3
 ccpua5BziIPQ0mbU4LTKOEc0fu0BuwoAJD005U7/2ta12oP50NuePbzJ7VaDPIhMBB2M
 267g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHMfWXT4Oz3SRsvlSlScZSaEUTfsX2O1BKAR79LluxM5KWZ3/p8tOmNyrteqlxNMqnw+2Pf9qHIjdXVR5TQGHTBdCoMxA=
X-Gm-Message-State: AOJu0YyxO/f4y9XyvGXvTHsghj2gAA3//VSoQobOpckcwM7UBdhxkfMI
 CXsNWXXSVCziIIA21tav89UDUEgKJtfX5akuRiJKAZTlSBBePZpnyeCmzoQf8mE=
X-Google-Smtp-Source: AGHT+IGK6kDPn9MjozU0IkTmR4wCrt16fnf89wiVH6OkU0DxdXAUpjjqzcrTIhQD5gvO9WzuwqzBAQ==
X-Received: by 2002:a05:6a20:a894:b0:1a1:5779:9e83 with SMTP id
 ca20-20020a056a20a89400b001a157799e83mr2751075pzb.56.1709698713888; 
 Tue, 05 Mar 2024 20:18:33 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 o189-20020a62cdc6000000b006e5597994c8sm10192963pfg.5.2024.03.05.20.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 20:18:33 -0800 (PST)
Message-ID: <c8eb7929-d54a-4ccb-a622-659df8129f2b@linaro.org>
Date: Tue, 5 Mar 2024 18:18:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 19/23] hw/intc/arm_gicv3: Implement NMI interrupt
 prioirty
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240306035721.2333531-1-ruanjinjie@huawei.com>
 <20240306035721.2333531-20-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240306035721.2333531-20-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/5/24 17:57, Jinjie Ruan via wrote:
> If GICD_CTLR_DS bit is zero and the NMI is non-secure, the NMI prioirty
> is higher than 0x80, otherwise it is higher than 0x0. And save NMI
> super prioirty information in hppi.superprio to deliver NMI exception.
> Since both GICR and GICD can deliver NMI, it is both necessary to check
> whether the pending irq is NMI in gicv3_redist_update_noirqset and
> gicv3_update_noirqset. And In irqbetter(), only a non-NMI with the same
> priority and a smaller interrupt number can be preempted but not NMI.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v7:
> - Reorder the irqbetter() code for clarity.
> - Eliminate the has_superprio local variable for gicv3_get_priority().
> - false -> cs->hpplpi.superprio in gicv3_redist_update_noirqset().
> - 0x0 -> false in arm_gicv3_common_reset_hold().
> - Clear superprio in several places for hppi, hpplpi and hppvlpi.
> v6:
> - Put the "extract superprio info" logic into gicv3_get_priority().
> - Update the comment in irqbetter().
> - Reset the cs->hppi.superprio to 0x0.
> - Set hppi.superprio to false for LPI.
> v4:
> - Replace is_nmi with has_superprio to not a mix NMI and superpriority.
> - Update the comment in irqbetter().
> - Extract gicv3_get_priority() to avoid code repeat.
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

