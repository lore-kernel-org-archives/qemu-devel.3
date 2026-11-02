Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDA606B0FF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Mc7X0bPx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNv3A-0001iN-RA; Mon, 02 Nov 2026 11:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNv39-0001ha-En
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:38:23 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNv37-0003Hn-E9
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:38:23 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ae57dc1ea9so1500229a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793637499; x=1794242299; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YSvQTuR2l9dBKVN45cido/LRerOtS5i8wukEQ7sI1Kc=;
 b=Mc7X0bPxmDF8Hc/8FsgFtZryLfYOUEflzl41wUKA7CSJiMy9o4kY6NahlTEd170J4R
 Cku84nUKGBT3Q9/3kPg1ONZq+bC1HfYNpOtlvgdvIOAbKDAztK4w0kHOb+JG+YdKUvMB
 RwHZ50oLS3Ki6z47CGfl4cE85sG3lgU+ov5+gFFK+qxAnRamEGzAR4U9u+vZsiopgNw/
 34OTpRieK/NBAVLKSW06vAxmapAS6pwHtpFsB+2mGLADm4o6EoVsHWWnzvgzaMlPVok9
 i0XZ2ncCjyuTPUaOYiS55cfX1fWQ2GLHh0Oa+OVR1DehjBVy0vfXHco2niQeg0CXZ5Zr
 L5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637499; x=1794242299;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YSvQTuR2l9dBKVN45cido/LRerOtS5i8wukEQ7sI1Kc=;
 b=VJ0PqkX2Rp8PkAaGVLQrI1JMtT/E1ittDH0pUaohnpuu3fqThCQp92vJz4DtsBqjlI
 82snUDmeFYqO3hiQ0In12XO5x0JXNYtK4K5dZ+jXuCh7c+Uzzj9BHzDkCOfmPaoPlm6U
 HJQKguJkKJA0nakM7EdAnde+WMXqtIfXEQOvrIezEfJRn0jWajv6h9EvLiX+8Njj8SU/
 /6XBzr+7natxBUv1csOCG7Y9rvltPz0q9fCdG+E+vTk2kOSPzPRDR5Rb5rLvtLaIpxU3
 VJOTRpHUBWEJc9QKvQMbh81QU4F+S0F0ggOjxP1Q9o7/9XeR8OGot2yGAEO2YhggBsYV
 keFw==
X-Forwarded-Encrypted: i=1;
 AKwUvByALaBpVCq7V1eP7d0TKPwWgimA7XyECwUa6jp6AtpvlmmnjEdMC8c1nJuRz/ixTE9jYtMZA6XC1vup@nongnu.org
X-Gm-Message-State: APuU4Z/w9mPTpRYvXre2mlOJsQt0jcjBeSO8XB0gdQgeNskEOwGOx+wJ
 V5XPWNUpwb9JaVQ7RldffzMQ3z9w+u1Lux5+o6cFYqz3EaZuv2K3wJPfyw1Ww2edMAPWZ65iBJL
 mUso/
X-Gm-Gg: AYBFou3AOl3LV49KLFf7mawBT8b+I8meA6bSMoZwyGrZVgQGZB3jl3ShlWVNEKWLIED
 ncGZajkBiE8Ib2Udrpi0paGAgdcBTYFm8Hu26fE9rj/hNL7k9BczsUc0HgKQyQLunFCCOdv8DQh
 iBW5mGtzWD/lX9PgTQWz26T5taMiDPoK3E50H1I21jL1YEgLqCah1OCHz7hSfhVskgIzPCbhk6F
 CxS+/txcumU+sZ/NYlclkwm3w1yLSN0BLSF2qaY7fyKevc65qJEGhtJFIy32huFMXzM8YGrvIPJ
 uPIPOZTqw9S6sSp4MhdS6OOSn7eE5eT6rLa8NTO5K8iZlt0gYMgEsHfl98wLCuD2u9WiHQkbB52
 XAfdAdpXtoco9ycjBSMSG58W0jzA51pH0B7mxMvekVJwvP09/kMeMl4Q9Of2n3AQ8f5MAe8V7UC
 I6AjcMZIg15RrKIz+6OKPTBrEQXXYBkXARkFx5gHVcjwfL7NWmJyMEuITWqjW+Z5Cp7mRLPTeeD
 uEzz3Rgr6fzOqX5qwnHsTNdtkPrx7ZhbZRPT4vu0+jaGZsjrYmXqU41hZPdkSOLKgaer5nyLVHR
 g7w95KZ7gA8XlcJ17pCd4yYhOrtJYqkVZ2u+yQCoV9O9rIdh4OIXbvxc5LwtI9P7RMKg9g==
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id
 98e67ed59e1d1-3ae897e06efmr8197347a91.64.1793637498910; 
 Mon, 02 Nov 2026 08:38:18 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845aa27esm14422256a91.11.2026.11.02.08.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 08:38:18 -0800 (PST)
Message-ID: <9fbd0709-b62f-40fd-a055-5483bea6e83b@linaro.org>
Date: Mon, 2 Nov 2026 08:38:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/47] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 05:35, Peter Maydell wrote:
> Hi; here's the target-arm queue for softfreeze. There are various
> bugfixes and refactorings; the big "new functionality" patchset
> is the reapi4b pci and ethernet support.
> 
> thanks
> -- PMM
> 
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261102
> 
> for you to fetch changes up to 79b27f3d0832c2b0ffa3e1a59f0f2c46fc0cdc3a:
> 
>    target/arm: fix bcm2835 migration issue (2026-11-02 11:41:14 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * raspi4b: Implement PCI and GENET ethernet device
>   * target/arm: Initialize SMCR_EL1.EZT0 for linux-user
>   * hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
>   * target/arm: For linux-user, prioritize PC misalignment fault over insn abort
>   * net/tap: Avoid "close(-1)" in net_init_tap() error path
>   * hvf: arm: save/restore SME state only when SME on
>   * hvf: arm: advertise ID_AA64PFR0_EL1.GIC correctly
>   * target/arm: Refactoring preparatory to ID register configurability
>   * target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1
>   * gicv5: minor cleanups and bugfixes
>   * target/arm: hold bql when SEV sets the event_register
>   * target/arm: fix bcm2835 migration issue

Fails macos builds:

https://gitlab.com/qemu-project/qemu/-/jobs/17671032296#L4708
https://gitlab.com/qemu-project/qemu/-/jobs/17671063089#L4702

> ../target/arm/hvf/hvf.c:1197:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64ISAR2_EL1'
>  1197 |         { HV_FEATURE_REG_ID_AA64ISAR2_EL1, ID_AA64ISAR2_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1198:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64PFR2_EL1'
>  1198 |         { HV_FEATURE_REG_ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1199:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64MMFR3_EL1'
>  1199 |         { HV_FEATURE_REG_ID_AA64MMFR3_EL1, ID_AA64MMFR3_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1200:11: error: use of undeclared identifier 'HV_FEATURE_REG_ID_AA64MMFR4_EL1'
>  1200 |         { HV_FEATURE_REG_ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_IDX },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/arm/hvf/hvf.c:1202:25: error: invalid application of 'sizeof' to an incomplete type 'const struct isar_regs[]'
>  1202 |         for (i = 0; i < ARRAY_SIZE(new_regs); i++) {
>       |                         ^~~~~~~~~~~~~~~~~~~~
> /Users/gitlab/builds/qemu-project/qemu/include/qemu/osdep.h:541:31: note: expanded from macro 'ARRAY_SIZE'
>   541 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>       |                               ^~~
> 5 errors generated.


r~

