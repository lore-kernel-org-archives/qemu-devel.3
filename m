Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D20C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 06:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzWSf-0003Az-N1; Wed, 24 Apr 2024 02:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzWSc-00039X-U7
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 02:50:30 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzWSb-0008Nw-2m
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 02:50:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so3834288a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713941427; x=1714546227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REyADsEZG+58lfOSWOvHmqRtQE8gQLDYURoE9CStww4=;
 b=YmvBBl0ON4SNU4yxcggkfpLdnOmih2RR+sTmorM0NMPG3826rWX30xtaG1ZzrKWXbb
 NEi9gID7ilPIs7boxmC8CDF2VLoua0AyDyVi0XD8YWB+iwe4CJp8rbno5sl0+AOmsezy
 QjeJdkXcXB0WMMI2a1zMoediMTtq4w3k3cuo36aLh4pTtM/3qMk48+wTx+XMn/H8RoWY
 f/jGgRoTZf0i14JtWzdaraEG3t9dHkQbR+BdtqpSUn4MuG/RjPcctwmzgdSeZl2SN9Uz
 LP3jDOa2l2dldL+c/24uxbbTbgy07edvXMBAbz6R2qwzwblwA6UJoby3SWyIRS6mD3t2
 t9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713941427; x=1714546227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REyADsEZG+58lfOSWOvHmqRtQE8gQLDYURoE9CStww4=;
 b=j6FPUn4SndjfDgjmNpYsqEV/ZpGFdITWsrzIw96INLkNWNLJfRh0Jim8cfp25oKuvP
 0/CCy/5MhNO8ZfiNCCXaHbfze4YV6PEYnxUUPNpJ9KA3rPgMCL3TwcfR0wOdDk588iQg
 y//xgw4IXLh9rhW5YiPMQnbuD5F+VHJxPerPQT50hzKSZh/Wv5Y3jei3L7bfC264SAiP
 j5pdxW2h1kXcdnIX8KWiEjC/zY63sTadKFmc/51TpSjmMgAuF+PVtNLjcOGGaVsTITYB
 nGkbABr32kn5iGbw0o88nBPmFnQ7x67L10eZ5VPZDk4TDMV/C6AD4MUSh1X/WGZbyUSI
 JLtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe+QYiPxdqidDnUPOei6VEr9byKnTEfN8/6hecXz5rhyc31oRIYgGmjKCmljTa2j9IZEEV2vdnXqVk8cjW6+EQRIWb+cE=
X-Gm-Message-State: AOJu0YwozjaOKLGelFIZAlSOwnt6SEl7RJ+zO/eF0CNQX13zZRCD+PE1
 ktO1d8q0K4q9SKE303EWuSVr871kIDGGFh4jXb1Z4IA+xh1XuqTC49npbOW64r8=
X-Google-Smtp-Source: AGHT+IGmJEa7r2cUb4tsxRPp9IMuon+5G5crGO/gVKncl219+r2f6PfKc42LEU3QT1PY5+IGW+bBqg==
X-Received: by 2002:a05:6a20:564d:b0:1a3:bfce:ec9e with SMTP id
 is13-20020a056a20564d00b001a3bfceec9emr1426715pzc.18.1713941426749; 
 Tue, 23 Apr 2024 23:50:26 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 r13-20020aa79ecd000000b006ed045af796sm10710183pfq.88.2024.04.23.23.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 23:50:26 -0700 (PDT)
Message-ID: <61650624-a62b-4ef8-8ae7-b413f09411b8@linaro.org>
Date: Tue, 23 Apr 2024 23:50:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/26] Migration 20240423 patches
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
References: <20240423223813.3237060-1-peterx@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 4/23/24 15:37, Peter Xu wrote:
> The following changes since commit c25df57ae8f9fe1c72eee2dab37d76d904ac382e:
> 
>    Update version for 9.0.0 release (2024-04-23 14:19:21 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git  tags/migration-20240423-pull-request
> 
> for you to fetch changes up to 2cc637f1ea08d2a1b19fc5b1a30bc609f948de93:
> 
>    migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion `!qemu_in_coroutine()' failed. (2024-04-23 18:36:01 -0400)
> 
> ----------------------------------------------------------------
> Migration pull for 9.1
> 
> - Het's new test cases for "channels"
> - Het's fix for a typo for vsock parsing
> - Cedric's VFIO error report series
> - Cedric's one more patch for dirty-bitmap error reports
> - Zhijian's rdma deprecation patch
> - Yuan's zeropage optimization to fix double faults on anon mem
> - Zhijian's COLO fix on a crash

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


