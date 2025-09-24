Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C518BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Wqx-00086c-Ag; Wed, 24 Sep 2025 17:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Wqv-00085z-W0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:16:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Wqt-0003fG-Jp
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:16:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-78100be28easo131613b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758748595; x=1759353395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7l5OkWQHHBC1ibrlJ4GGeymVbrOVOaCD3M0iStUu8M=;
 b=SHEmIyG14H12YPNA38Lz8uie1Kasuf34d2igbh8DxOacGOi5hRHJK38z4Zevh75Szk
 /mgJ586QVjTskWCZSU5ILBDFbURA8xgWub6ay2fn+SFjSwCVCJAff0FiT5bptJMPb4tM
 VBjIwe6RzBc0DLNxuQeZTZv46+bVq42SJENSc+pSuPzpeji4xNrKFXZkx0q8lNAECSYU
 7jPBQn4FXpqxRrGw8f76EqGAWfNqIvbZJfLX6i9Yl764ws3q6QzdmOvPbJOeQW9TwlwZ
 LwnLriKx05pWa00bZY6YYDTAPXthAH80i1YWout2Z31vYFu09r07HcMElUloknxgJdFK
 D/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758748595; x=1759353395;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x7l5OkWQHHBC1ibrlJ4GGeymVbrOVOaCD3M0iStUu8M=;
 b=j9VkDTw0mrhtiLbVmdAAyDaaV3q6cKMYbBTVitmVauMhqVeo3e1FeXEaISdqrMCW1Z
 vFB+/9VSAcnsOmWIK4rKA6IEa0Z7Hf8XOVJlSrrDdCboeMDuLG6nj1vAUV1o6BLHmiHS
 +9IiFtcxtcDhCuPcbpYsfK0wFI85ZubCsjf4ycu7plsMRDz9HWDBZBFYk0j30Bs0VWon
 nCIBAal2rco8I2S3nyPgsER79+RrlRLvvFqYtWdC0YDKB+BcRscj2as2GW5ezYkVI3F/
 JXm3uKAwJjDEwUO0HRbiI+cxNQEHarwj3/0rKU0B87AnCoMKO/FJQY5RBBxPpxbx95Fv
 kp8g==
X-Gm-Message-State: AOJu0YwpHCek9C6Xa2h8Hdb1CM+uevVv9aGpD0jE1SFyHwYQJpjhfu+H
 PvWdgI6a9EQQPr89V5BeNtBcU62KXyFJXWVQA7iO+CGEUApc63Q7n+Pu4lHtidFX3l0NvSp0ROJ
 tUEME
X-Gm-Gg: ASbGncufr8araBKtlxhrGGsamLq6Ug9yelSCexbvq6fSU4JuiO3U/hgxOMeAhRRuWq7
 +Ck2m3kdP1JN2K6MNm8D9PKdELmdMnrSFowwngFESjECmBDS80C1dLlTGIj0J5L1PIx2NOqICxC
 fxzhAEUZrOX0fEYY5WcMTMAZzc65/hBmN9pLuGcCCQ4DRKH5VYu+J9Awi1rOoJlN4Lr5Kad1EY6
 LzqzNSZBoVsGIQPXRPBaAIys2pO4P1mk7PxLHEqXxP4DHZTi+/0+KuJ/8vXoHUJAVWCpExBfWQO
 7q9NulN0uDkBHhVaAlnFkls7o5W0cuDOF6S46KagG9CJYT/jp53rAbGG7BHsawXGSQ0Mf1AY/vd
 RzUfpxRMGEVZD40Dblzm4vee5V+YNoUvu4Xv/
X-Google-Smtp-Source: AGHT+IHOSJWtv1tjVwxORWrQ4KuHuxz1fyyxA8/L+tVBS1nV9ACAIZtjg+RN6t54T6amxuqSk5dLIQ==
X-Received: by 2002:a05:6a20:3946:b0:249:3006:7573 with SMTP id
 adf61e73a8af0-2e7be8095f2mr1307947637.5.1758748595119; 
 Wed, 24 Sep 2025 14:16:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7810238e6fasm4270b3a.1.2025.09.24.14.16.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 14:16:34 -0700 (PDT)
Message-ID: <806850bc-32aa-44db-ad89-3d25ad263132@linaro.org>
Date: Wed, 24 Sep 2025 14:16:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] misc patch queue (tcg, linux-user, sparc)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250924190106.7089-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/24/25 12:00, Richard Henderson wrote:
> The following changes since commit ab8008b231e758e03c87c1c483c03afdd9c02e19:
> 
>    Merge tag 'pull-9p-20250918' ofhttps://github.com/cschoenebeck/qemu into staging (2025-09-19 12:21:35 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20250924
> 
> for you to fetch changes up to f6f7fdd68e6fbfafae828e504de544b5659bc4bd:
> 
>    accel/tcg: Remove cpu_loop_exit_restore() stub (2025-09-24 10:29:43 -0700)
> 
> ----------------------------------------------------------------
> hw/pci-host/{dino,astro}: Don't call pci_register_root_bus() in init
> target/sparc: Loosen various decode for v7
> linux-user: Add syscall dispatch support
> tcg/optimize: Fix folding of vector bitsel
> include/hw/core/cpu: Introduce MMUIdxMap
> include/hw/core/cpu: Introduce cpu_tlb_fast
> include/hw/core/cpu: Invert the indexing into CPUTLBDescFast
> accel/tcg: Remove dead mmap_unlock() call in invalidate_phys_page_range
> accel/tcg: Remove cpu_loop_exit_restore() stub
> accel/tcg: Properly unlink a TB linked to itself
> accel/tcg: Introduce and use tb_flush__exclusive_or_serial


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

