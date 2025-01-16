Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B4FC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 21:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYXBW-00068b-GK; Thu, 16 Jan 2025 16:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYXBJ-00067Z-RD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:13:38 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYXBH-0000kp-I6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:13:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso14820585e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737062012; x=1737666812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FX/GjRhWW16iXaOYBDgPEwHErSqJ7l6E9oyhycYmQKs=;
 b=EKpmsU53cBxg6ZEZrZLembHe0UhLbbKmJiJhqGXVULVHRtMmvC0lt4COFq16RO0Kbd
 OwkJppoI5k+sWnou6Zj8GfF9fTObkdQ0IKckXvoanm3TxrNBjAU2jN8iR60Vg3R7Avwz
 DnZB4zHF//0JfpUpadjQGaKkcRRM4WbdOu2frfc6H9033BU3uR2WyQpNWRkLNIYmGZ+Y
 jBbXwvfT41U8vD519QAmBOYkjM7GKadAXUzNg3Rw80/I9LZkRbEqfTbJ0BtI/fpv8FV/
 xYOLyTCZUo14vJ419Jjzk4jCQkynnjYSSsURpc0gZR8MfWrPoHhh3jynGk1uBEg8932Z
 xnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737062012; x=1737666812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FX/GjRhWW16iXaOYBDgPEwHErSqJ7l6E9oyhycYmQKs=;
 b=QkRq26h8nMuVeUN/leHA3gjEmeIjxWqNY7dUGqNgTNNQC17kAi/nWo9j04wiHxpYCE
 oJ3z2VmA9r7B03FSc2r6SI3S/SnDPcfCvJ78rOTyxY6VKUHeMXh3au7uf7gz7zgx2ACD
 7bvv2ViiF9Ycr/ULi2xbbr8X7lIjHHLol302T7lZDerOdgHLKoQ0TaWsZZhY+c9ZTLKm
 2zSHK6eBWlTxKtvwfEiSyuhjVLH6D+szBJMGk85TPXfC+DpFPPoHZYDOOD4shxZpxmcj
 wWhav0sL+o+MatBL2prwp2Ggnh6BN/1PcriPVxRe0KOhplPH5oW4UZ6yUBHvnlddBMSP
 S6GA==
X-Gm-Message-State: AOJu0Ywgy9cZdZ77eeevsmsGD6Gnn27o0uLVI3B6/vJnMTtpOmPEEBLS
 7R5zU6k1xt79Zbud7ZRoIvFc3bgHKWxhjQCNCryoPHQXsbZdHRfGoKLW4k+DJJHgv1ZjGHHsmqR
 Utd0=
X-Gm-Gg: ASbGncvNV/1CarE5nNYbrxKa49X1ee9hmqJMU0gO3X+knrh+wmXhduxczGWwuOd1dgN
 joKQ27MQ3hvcOVOC/LZcTcbQ8PT2YUsi/yGDKgNCWf2vu9ZAcoSBrM3GH9FAGU9YoOXNfezQ9dp
 khPvWqi2GXMISsj5buL201mqAdikGDEk1lIUt7061fT+FIR9kWW3k86Ta1zfV6Jj6CXTXSIHT3D
 Opjnt1jXbIcLomdYLRg6bsA4GOOVYmPVujkaga7yHgD2IdpQOYx26g39zL2amzLsDknaWa4vbYT
 07/7t3fPCnHqsmGqXRwrUUhc
X-Google-Smtp-Source: AGHT+IGv8cMXYBB5nkSqxaBQ8Yn8y8NlKpZtctF+lDdHXyru4204P++iK+PNujAuRSTmtum9h6G/ww==
X-Received: by 2002:a05:600c:3ba7:b0:435:172:5052 with SMTP id
 5b1f17b1804b1-438913becb8mr1640905e9.1.1737062012447; 
 Thu, 16 Jan 2025 13:13:32 -0800 (PST)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890408447sm10775385e9.1.2025.01.16.13.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 13:13:31 -0800 (PST)
Message-ID: <823a0892-e9d9-4d26-b862-83ffd60c2ad1@linaro.org>
Date: Thu, 16 Jan 2025 22:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to virt-2.12
 machines
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Peter,

On 16/1/25 15:59, Philippe Mathieu-Daudé wrote:
> The versioned 'virt' machines up to 2.12 been marked as deprecated
> two releases ago, and are older than 6 years, so according to our
> support policy we can remove them. Remove associated dead code.

> Philippe Mathieu-Daudé (13):
>    hw/arm/virt: Remove deprecated virt-2.6 machine
>    hw/arm/virt: Remove VirtMachineClass::no_pmu field
>    hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
>    hw/arm/virt: Remove deprecated virt-2.7 machine
>    hw/arm/virt: Remove VirtMachineClass::no_its field
>    hw/arm/virt: Remove deprecated virt-2.8 machine
>    hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
>      field
>    hw/arm/virt: Remove deprecated virt-2.9 machine
>    hw/arm/virt: Remove deprecated virt-2.10 machine
>    hw/arm/virt: Remove deprecated virt-2.11 machine
>    hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
>    hw/arm/virt: Remove deprecated virt-2.12 machine
>    hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field

Please ignore this (reviewed) series for now. I'll rebase it and
repost after the 10.0 release.

Thanks,

Phil.

