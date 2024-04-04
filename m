Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6311CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNyB-00028y-Im; Thu, 04 Apr 2024 10:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNy9-000209-C9
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:21:33 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNy7-0003PH-O0
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:21:33 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516bf5a145aso1312348e87.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240488; x=1712845288; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WO/NuWFFNyzaoF4v9nBBIhI6WakE7Vuqi8ZmgoCCCls=;
 b=gOceKg33C8uJvx3+Fe6H7BOFSE+behkAdNYO6Q1G6kIK7fdJiQdj5209nFwW+MA5ru
 Vu6J2MdR14eaZLKaIzobyjy1FBvVxk/HJa82sVjK9aLo0VOTaMF1yUjMbuHWL6rkWkmw
 HcU0Bl3cjqhifzjEuaUYrl8wm4aR/sQ4Y86meLwGHJSPikC9KvsJrbbTRix2BGySEKip
 6jEKg3Hmlp46/OmwH3BkwNTqIfScFfiUIzOsZEUl26DX/kp7CCoLMbsjXJvPO3INZ7mG
 9INkt3o+weDQV+VC4Bi5TCZTyt8P8px9jywWyxkRvj5iBozw83FMJnKKEMtZToM1h4Qp
 qYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240488; x=1712845288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WO/NuWFFNyzaoF4v9nBBIhI6WakE7Vuqi8ZmgoCCCls=;
 b=rKfFZdLbGjSvIDlcTv/evuQBx+EWlOVVLnxdnzCHpkNTz23UR9ftJW+CbLwGp3qXcN
 A9HLQySvEg1rkQoNeJlsTgw7IEN+Yj+d4ZH8tK5E64JanyY4SUshToPa1nD+iRVhjLCs
 8+iDI30S1kDgoDB7D4mdmLuog9dGi9MIddfBWi0fIsh/3980eTE0sGyq+H90l63wj3zX
 Ll8qUuxC8WDIVTJFqX8zeFjYKCF+QydzjbK95AQOhkuQcVorFIDiwc3uZTilkF5WCLiD
 0bTiifsCUQZyJvvX0jGQmuQHOCjxTFKFSCyTMOGASQV7b5DbQeyZpgUmwVF0U61ILdhO
 /6Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAprZxakSPfGBm8Q1pTBJuVz9rpfNAKzPAx+dxtvqJ13RbLCOQ9DXumSwlcKmFqEEXcnbITU0Wt3dgFqTHi+4GzGK8YIg=
X-Gm-Message-State: AOJu0YyLmim5lsmALARCEoVN0Iwfw7vho2YBbMK8l2iL+VGXA9Mg/8dn
 lq12xoYDgxLK0+O/lPPvVP3lmNOrklgSRLSMXaV9XdamS5lny7vmx1n2E9q/BSNPYJuJOOxFb1/
 8ZENfdUISlQsOnIfINAnJyZhPJAl5FIdjeqLPkg==
X-Google-Smtp-Source: AGHT+IEHbkKMtiPTjkdkrmACoLRaakska1/Ctcyg+1MGMyY3KxQPpSpBBiQE0HZVPY9o2KPEh0/sX7JoSy5t+Tm2iXM=
X-Received: by 2002:a19:640a:0:b0:516:a77a:9a7b with SMTP id
 y10-20020a19640a000000b00516a77a9a7bmr1760127lfb.52.1712240488290; Thu, 04
 Apr 2024 07:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-13-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-13-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:21:17 +0100
Message-ID: <CAFEAcA816o+7mUCKXPUf2akejw-MPP_N9PgBQWiHL4ZNRkqYqQ@mail.gmail.com>
Subject: Re: [PATCH v12 12/23] target/arm: Handle NMI in
 arm_cpu_do_interrupt_aarch64()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
> with superpriority is always IRQ, never FIQ, so the NMI exception trap entry
> behave like IRQ. And VINMI(vIRQ with Superpriority) can be raised from the
> GIC or come from the hcrx_el2.HCRX_VINMI bit, VFNMI(vFIQ with Superpriority)
> come from the hcrx_el2.HCRX_VFNMI bit.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

