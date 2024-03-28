Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97237CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 19:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpvPL-0004ta-54; Thu, 28 Mar 2024 15:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpvPJ-0004sB-Eg
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:27:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpvPH-00021W-SJ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:27:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56bf6591865so2046013a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711654042; x=1712258842; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rZS9XFyOQG2i8hCRjoB5xys4mRT4xfclOc6vBgM/M/Q=;
 b=gMYmi83MCR3YA5gsk+Px+t2a4xS1DuPMj6ZBWoOiabJlaRGeMSxGQluEdQwm7sP4+o
 T88KeheWg8HH0n2mrfxEmDeTwzy6olKsBRU/MmGDXZg6gUloaPUNHt5mT2ehKoyLYrti
 0ZEcNzv+wV8t3IPjdLXmVU1/AhbM6dZIHyBefNx4Ttpvz8DuFaJdPuJgTIpwVBhPKvm6
 TOYgW3ytChX8gLFHNsTbICAER9TZRz+CLM4LVSdB/L94mRh4pgGBtPypSbtxv1cJQ183
 TiGMDqUnsElPKSags3lnxoUAi2jbjIlgr8u/jbRVXPNQcKmkyFauiaIA7grotDGye4yt
 dvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711654042; x=1712258842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZS9XFyOQG2i8hCRjoB5xys4mRT4xfclOc6vBgM/M/Q=;
 b=UjIAsIEL8tsVSRwWo+m7u6ayhdBqGjXldUn+HJFstQjHE2+rktWDduKkEAXuMmqJpD
 TAELYJsxiai8/myUKzpCaBZyriX2rgfGdvhe58XoBk+YMKETXNLLBcMN6gweKzWzqS/j
 cNYNBRTeTw322UWxn/4RJxzZnTDIF9vX8Pj6N0YTtrT0XiELbcLBPyQ0BpI5h3OFTecK
 4EF+nwHVy1u4qxeDedKIjDzjojIvo+7L0eCBVFGOhnT/8I9bHMjSAeLERLtmGhzST4XG
 uGgSFZQ9K7kkw7Ml/+dvBdSO+ohyEXfa07PfBHzS9BBxuJFftHRETAnN/GU4BaqQgEbu
 ZUpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsoXCRP8kGHu/QYhFX81oxHmNUp7Ow/ycZMGRc+3tOROfY7DPzfZcIHC5F0HK6BGkc+tbD3WApZpJjJ28c3Yeu9OiT8uA=
X-Gm-Message-State: AOJu0YwUQLa+CUjR5gHbOSClrhulEnvXF2Lj4GJyeSokbkmA2+5Y9ING
 EQt4sZ7N1vhAUTkTj46F710mlVXbR9XrhAk75ESrHF7GySu1eZ7DuZEOsvdX1rkbFnjY8yY7Aw2
 CJCwchZdXcFmXCp933nr7w7g2KyxyFSdbC9Rjh6xokTn48pNG
X-Google-Smtp-Source: AGHT+IGpMxbdpH7qbU2ZNDqQl6dYaPYELu3rTbekUCYavXLF41VvBMQRSqmvOhdXXM/lRkPOrOfAhzTlyOPzDUSR3EM=
X-Received: by 2002:a50:9b01:0:b0:56b:d9b0:f1c3 with SMTP id
 o1-20020a509b01000000b0056bd9b0f1c3mr142023edi.39.1711654041959; Thu, 28 Mar
 2024 12:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-19-ruanjinjie@huawei.com>
In-Reply-To: <20240325084854.3010562-19-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 19:27:10 +0000
Message-ID: <CAFEAcA80e7j+euG9Fqtx5j-BnGMoK-bGoPrfFqfokJQE-kCcUA@mail.gmail.com>
Subject: Re: [PATCH v10 18/23] hw/intc/arm_gicv3: Handle icv_nmiar1_read() for
 icc_nmiar1_read()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 25 Mar 2024 at 08:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Implement icv_nmiar1_read() for icc_nmiar1_read(), so add definition for
> ICH_LR_EL2.NMI and ICH_AP1R_EL2.NMI bit.
>
> If FEAT_GICv3_NMI is supported, ich_ap_write() should consider ICV_AP1R_EL1.NMI
> bit. In icv_activate_irq() and icv_eoir_write(), the ICV_AP1R_EL1.NMI bit
> should be set or clear according to the Non-maskable property. And the RPR
> priority should also update the NMI bit according to the APR priority NMI bit.
>
> By the way, add gicv3_icv_nmiar1_read trace event.
>
> If the hpp irq is a NMI, the icv iar read should return 1022 and trap for
> NMI again
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v10:
> - Rename ICH_AP1R_EL2_NMI to ICV_AP1R_EL1_NMI.
> - Add ICV_RPR_EL1_NMI definition.
> - Set ICV_RPR_EL1.NMI according to the ICV_AP1R<n>_EL1.NMI in
>   ich_highest_active_virt_prio().
> v9:
> - Correct the INTID_NMI logic.
> v8:
> - Fix an unexpected interrupt bug when sending VNMI by running qemu VM.
> v7:
> - Add Reviewed-by.
> v6:
> - Implement icv_nmiar1_read().
> ---
>  hw/intc/arm_gicv3_cpuif.c | 79 +++++++++++++++++++++++++++++++++------
>  hw/intc/gicv3_internal.h  |  4 ++
>  hw/intc/trace-events      |  1 +
>  3 files changed, 73 insertions(+), 11 deletions(-)

I haven't done a full review of this yet, but it looks like some of
the parts that applied to physical interrupts apply here too, eg
 * don't do the RPR NMI bit handling in ich_highest_active_virt_prio(),
   deal with NMI in the callers
 * in the AP registers, set either NMI or a group-priority bit, not both
 * AP NMI bits are only in the 0 reg, so checking doesn't need to be
   inside the for loop

You'll also need to update hppvi_index() so it accounts for NMIs
when it's finding the highest priority interrupt in the list registers:
compare the HighestPriorityVirtualInterrupt() pseudocode function.

thanks
-- PMM

