Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422D4EB594B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzWH-0000k6-S4; Tue, 10 Feb 2026 20:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpzWG-0000iz-O4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 20:59:56 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpzWF-000618-7k
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 20:59:56 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35658757f68so987914a91.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 17:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770775193; x=1771379993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ldu/4FPF3xMugIctQiX4FLAowyJrcP53zm+psLSxBG0=;
 b=CuhnpYx2hXw/rWA9Of1s2QH22pXyREcl3HHHj38/A0hYBdW1XmhnIUHALEW6ixH9oe
 38aD/rL9jaU/lR1wFugnY4bX4CUwcAGVBPbbvA+p1ntmrffgO1bt2jt5PLKyq+ZnZHAN
 wGKudtpZ5eMboyB+gmmoYlOOsKiIADhe9SlNWpHH1pU7JNh3kmzgKwgom5CgIdQ7FH8t
 XmjoG7sRttWBEePocJDAMUgL/zh0FEsbnleDScVs9ITVY6pjDoa5TV9bGbClkypJJSgy
 U4ECvhgc0+/JGvZmICQfh7T4LbUXg2E6giig2cnOHoJGOP6sWXvtOLwD3MteB3+znSq8
 /tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770775193; x=1771379993;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ldu/4FPF3xMugIctQiX4FLAowyJrcP53zm+psLSxBG0=;
 b=OYa9i9fThxS9/Syivpspg/iWnxW5aw1D7NStcD40So6QT+8wWHjGVlmnNRaSlNRboA
 h0Zz/CsSvngxHPOL3NCaL5jpIoAy3bdGCdjd/BIb6gHZpGFOU0Ogtm64Mr76jduGTYvt
 MWHHGWaQ45ms0veVuPC6/3XKb3hhT2JUauVZpR6+uizIOHETc+WeqHAZcrrXm7/7p3CH
 kD5B95u1Js5Je1RKOredIWNbwYSVSkK01FskA584PkneihkMzXfmNo2639Zw7DyOARxw
 XrSK4CdvO7zYSdkhH2Dae2KYM4t/jo2/2CDxONHAiDBnh2jSQUGFsWt3TvZPfoaEGN4a
 Pv5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbt4glJBpuHpEaATieofkZGhSsOUiXNBQnLFZqC5sTvDzCzV2Evw7SMjAGHsG3fPFqJBr1t0V424D/@nongnu.org
X-Gm-Message-State: AOJu0Yy7cNlRu5nvBgNGqg/3VGRKm2Pon771A0TiBNNqTsFERW5g4fGP
 6dJJtJ6NFYaSlAJuTezxmJRnt3wz8czdQSAcI2Roustl2Vx+CftW5vDj4GPRX1vkj7g=
X-Gm-Gg: AZuq6aKAsrNDH4JyNEhr2viWuF6H90+5qYrd4JkMXXCEAdj6OBeweJo0VIdyZ4Jn+iu
 FxXKINlIE+nMMhc41XkeofKLiAKAZj+pcIB6rzFxq89QXbleOjouzNjNTg4y9YllX1Tu3YJ3Xo7
 aENJiigfxQqFgyM9bMrJgHi+jLlbFPQOA2PqSjFp0xPiyGvHxWsM9DWavag1eq2av0k9lD8bwzf
 Pn0qniyAh74PCPG55I/r/3L+RFznz9dMo64CHu92baIFTfxXkkbeb1LxkdPo8KotgbPlwE8PM/8
 ONDKx8+cmDimgC0pVfo3ZNv550715s4uW16/reqmO9W9T+YTdQVxNK6NCG6D2Go+3tsNirwhwqT
 4rmAWimQPOK3cN5J9ZChlq7+TKP55x8Tkll2p4CF36uhwM9TDA7G/nOb0RHbbDm7NbYrPUE48P7
 o8wZHgTlKvmfbSrS04yvEMU4m2a2/F9cX/2Dx15FNm/1oGhgSlGx6lOSGBeoKgl3pAEUR5we73G
 ndkNAVSgYnb9A==
X-Received: by 2002:a17:90b:3d0e:b0:34e:63c1:4a08 with SMTP id
 98e67ed59e1d1-3567b09995dmr1097121a91.20.1770775193108; 
 Tue, 10 Feb 2026 17:59:53 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f8f8:2c3b:9605:55a0?
 ([2001:8003:e109:dd00:f8f8:2c3b:9605:55a0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-356629314fbsm4148540a91.0.2026.02.10.17.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 17:59:52 -0800 (PST)
Message-ID: <8bc64219-138b-45d7-b07c-bf627c2151e8@linaro.org>
Date: Wed, 11 Feb 2026 11:59:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] hw/riscv: Fix IOMMU PAS capability to 56 bits
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 palmer@dabbelt.com, alistair.francis@wdc.com, pbonzini@redhat.com,
 gaosong@loongson.cn, maobibo@loongson.cn, deller@gmx.de
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
 <20260210-phys_addr-v4-7-725a589e83c8@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210-phys_addr-v4-7-725a589e83c8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 2/10/26 21:33, Anton Johansson wrote:
> Replaces the only remaining use of TARGET_PHYS_ADDR_SPACE_BITS for RISCV
> with the fixed size of the riscv64 physical address space.
> 
> Better would be to somehow determine if a 32-bit or 64-bit cpu is
> running and set accordingly, but I'm not sure how that would be done
> from the device instance init function. This field is unused anyway.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/riscv-iommu.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b46b337375..c3d48541b7 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2453,9 +2453,15 @@ static void riscv_iommu_instance_init(Object *obj)
>       /* Enable translation debug interface */
>       s->cap = RISCV_IOMMU_CAP_DBG;
>   
> -    /* Report QEMU target physical address space limits */
> -    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> -                       TARGET_PHYS_ADDR_SPACE_BITS);
> +    /*
> +     * Report QEMU target physical address space limits.
> +     *
> +     * Currently set to the riscv64 limit of 56 bits (44 bit PPN),
> +     * riscv32 would use 34 bits (22 bit PPN).
> +     *
> +     * This field is currently unused.
> +     */
> +    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, 56);

Probably better to make this a property.

The iommu object already has a number of them, set by virt_machine_init, and that function 
already has a handle on the cpus being instantiated.


r~

