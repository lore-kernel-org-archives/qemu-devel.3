Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E175EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 07:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfx6G-0008Gm-Ok; Mon, 19 Aug 2024 03:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfx5t-00084a-69
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 03:46:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfx5r-0004oW-8T
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 03:46:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so2323918a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724053581; x=1724658381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8e+Xml/Ti7w84vAijRxFB6v/4CA1+Lqu9qtHPHGSPLg=;
 b=RZ7/SsLtyAWXP4sb3btSrfhMvBBx/eFtjVX+d7E6kUqzV4z0yFpy/NAPsyAxOf902F
 hDqh5o7q4yGqymPWbgWl5jYq/Hzg5zfxuZlblBGi2AcutFg569xQ58woxuBP4WeHrCQk
 5VtycpNU9tdUyVHl9SQnzr2V/eH364r4IL/1DC/f8kNjI2l8GJM478WTe9zufem3F1m4
 xqxUPo/mv3yubawKWjUBC3iK3/Kc8vihvnPTRo8G3oKAjg/xAh73X0YJxcBrcfJePx5d
 hIB8x6HoM2hwDcAJMTXRky0v+GzEy6n5XIYR/t6jDf/0Ra62Nki8INTy5G7dhlt0uxfy
 TnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724053581; x=1724658381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8e+Xml/Ti7w84vAijRxFB6v/4CA1+Lqu9qtHPHGSPLg=;
 b=rCRYF9b4TOm2A0nynNBCqfSjUp5j9CkEjVv46Ps+jSGoorvq7u8x23m34KFLHGfaf8
 txPhWkXBsFcXuyXRA8pKjX0MVC6o4klx6or9Vbqhzz941REWCV7vZgmh7dXDQk8dim/9
 mlClhT+Lst2oBnR4fZhtDyis8Xg5NC0u4cuFqPzhqXp3guUEKKa+OFKRO7sLCh5Rjeeo
 mpdbTApsjGH/wat04eS8IqoAckOyPnhUGsBteUd0D2Cwk5eqjxsRE4++WoH8GhT/Jme8
 0uN15Au5U8cUxc0ZeHzXUis+vSBHfR+q1jl2KzjtxxYnBgu2XemQ31yaIp/4cWnRP/xe
 nNxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ2fJI0TlT4lNcXF1LwT50m6rN5mjD6Yp6SbbadFwS+zzVuwLfZtY9LTHByMBi+qtLDZZq7bf/FrVsZ1k0PDt5jQYZxQQ=
X-Gm-Message-State: AOJu0Yx8oXCjNjTfeNhKMKLPYnGc9zq/cAYL30kS4XoY0p9kTfD6Ix89
 XkpfgpdOKioboKsN+kPSUtZBkbNBkZJzs8SnoOHj1S/oKf9cDltMI9zDhC7e2bQ=
X-Google-Smtp-Source: AGHT+IFZuauh5rl1Uf2rbOs7Vk6s5iiIxuAQYFg49JJxPkDwECN/3BK7yoSb6OD4kq7fnBt7Hw55Fg==
X-Received: by 2002:a05:6a21:e86:b0:1c4:dfa7:d3ce with SMTP id
 adf61e73a8af0-1c904f8e603mr8393245637.17.1724053580944; 
 Mon, 19 Aug 2024 00:46:20 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2b65a9csm6545131a91.3.2024.08.19.00.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 00:46:20 -0700 (PDT)
Message-ID: <693115c5-3aab-4b31-9f29-e9d0ec47590c@linaro.org>
Date: Mon, 19 Aug 2024 17:46:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20240819044344.2939218-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240819044344.2939218-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/19/24 14:43, Alistair Francis wrote:
> The following changes since commit 2eefd4fcec4b8fe41ceee2a8f00cdec1fe81b75c:
> 
>    Merge tag 'pull-maintainer-9.1-rc3-160824-1' ofhttps://gitlab.com/stsquad/qemu into staging (2024-08-17 16:46:45 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240819-1
> 
> for you to fetch changes up to 6df664f87c738788891f3bda701e63e23a0dbbc2:
> 
>    Revert "hw/riscv/virt.c: imsics DT: add '#msi-cells'" (2024-08-19 14:34:49 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 9.1
> 
> This reverts a commit adding `#msi-cells=<0>` to the virt machine
> as that commit results in PCI devices unable to us MSIs. Even though
> it's a kernel bug, we don't want to break existing users.
> 
> * Revert adding #msi-cells to virt machine

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

