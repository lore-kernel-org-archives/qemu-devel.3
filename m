Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA91C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 14:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5nvm-0000S0-RX; Sat, 11 May 2024 10:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nDj-0000ti-Vc; Sat, 11 May 2024 09:57:04 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nDi-0000ms-7p; Sat, 11 May 2024 09:57:03 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so1932551a12.0; 
 Sat, 11 May 2024 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715435819; x=1716040619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDrnFcVRDzK+cNEm/hFW0dMPsHOdiHRlsR+16xPp51U=;
 b=QycALdzo/X2X7Xs5Dxlr4MehkXIsd6jb0HvpKPkEv97nOUW5BI6fdEra8CQNG+2cE+
 iEGb/YpwpPxxuz2YBA5frgIcjsf9vgj0bsPXLUqbVLGo5o0GPCjiJPnAqwgxIRPk4VgQ
 iQpvBDM+exXbbaJC2/FgAXCUlkiFL1p6vFkNhPPuKpLsl/QhnVyqK1eavGArVujEUT9m
 uFan37BjFKSG4H5gr54OjzpNiHqRLt7uDzJirOPTZqgqRluDug51srDGW1YbQgJZr15q
 ys67SsztjMq0KJQXSxc+2oPFGwT2egKhrbPeUqct17gqrSrbAYuonoMQNSDANVq8H4gA
 es1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715435819; x=1716040619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hDrnFcVRDzK+cNEm/hFW0dMPsHOdiHRlsR+16xPp51U=;
 b=GLhWHHhs8eZZDKiauUdZN4vP7q1aTs0eTaj5rV9V4ytp/gCbwwleXwZuVGZ1Ds1/mn
 oUvq2zw6GeLoT/73h8BhSTE0u8jkbBR+FoWXSOvKmDjlBb7/k0+5l/lRV5CSQQ+fYz2Q
 yOV3p5NRWAlNN0D4aC1O6Pw/qVXmj1u+7Ylua0TCcpvUXdryllPsUuWsnRLp/YH043sr
 m5pSp7pUQMxTEq9LiP1kyOh3UxAZZMiYg01rG96yjSRryBQEPg1TUZ3lgNVASOYHzhtF
 Sbhr75werxhjdu/HknkU1YhLcR+eGzWtviVOdkJOqXH4m1mchqoxqvEL05K087CVBL0D
 ZdHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPaZkDUBn7YDBkZvVfwGgzMFYzGsiItgqEJ+4RErzRwGMjZRwGtaOvIqSN3j6h1AmtXUYxLyyQmuQ6rcJC5qZlSoThjeg4ddH2wf1hVIbKU9mgbWTNVxTXef7Dwg==
X-Gm-Message-State: AOJu0YzJznJ6xrfQsZi9reAOM1UscO0HxXOtYQyus/TxyiGg/oypHaoi
 +3mNqNR5qKRfn3dIrQqZEuwGly/nVbq9h+oy3kdbQhsdaiCYBdqL
X-Google-Smtp-Source: AGHT+IGEIxnco0ep15Sh8sVVe0uLI81fCtFJWdDlRxNvfsqQdOiRMJ41JjrRXhqY6ZpnlMulhOzZhw==
X-Received: by 2002:a05:6a20:5602:b0:1af:957a:75fb with SMTP id
 adf61e73a8af0-1afde1b7e87mr5836839637.41.1715435819440; 
 Sat, 11 May 2024 06:56:59 -0700 (PDT)
Received: from [192.168.0.120] ([114.95.238.28])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c2562f8sm48883165ad.285.2024.05.11.06.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 06:56:59 -0700 (PDT)
Message-ID: <b732f7bd-53d2-4c66-9821-a5bd589f6c56@gmail.com>
Date: Sat, 11 May 2024 21:56:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
Content-Language: en-US
From: liwei <liwei1518@gmail.com>
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=liwei1518@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 May 2024 10:42:28 -0400
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


On 2024/5/11 18:10, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Hi,
>
> It looks like Pointer Masking spec has reached v1.0 and been frozen,
> rebasing on riscv-to-apply.next branch and resubmitting patches.

Hi, any change from v0.8 to v1.0?

Regards,

Weiwei Li

>
> Thanks.
>
> [v8]:
> Rebasing patches on current qemu branch and resubmitting them.
>
>
> [v7]:
> I'm terribly sorry, but previous rebase went wrong and somehow I missed it.
> This time I double-checked rebased version.
> This patch series is properly rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> [v6]:
> This patch series is rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> [v5]:
> This patch series targets Zjpm v0.8 extension.
> The spec itself could be found here: https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
> This patch series is updated after the suggested comments:
> - add "x-" to the extension names to indicate experimental
>
> [v4]:
> Patch series updated after the suggested comments:
> - removed J-letter extension as it's unused
> - renamed and fixed function to detect if address should be sign-extended
> - zeroed unused context variables and moved computation logic to another patch
> - bumped pointer masking version_id and minimum_version_id by 1
>
> [v3]:
> There patches are updated after Richard's comments:
> - moved new tb flags to the end
> - used tcg_gen_(s)extract to get the final address
> - properly handle CONFIG_USER_ONLY
>
> [v2]:
> As per Richard's suggestion I made pmm field part of tb_flags.
> It allowed to get rid of global variable to store pmlen.
> Also it allowed to simplify all the machinery around it.
>
> [v1]:
> It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
> Compared to the original implementation with explicit base and mask CSRs, we now only have
> several fixed options for number of masked bits which are set using existing CSRs.
> The changes have been tested with handwritten assembly tests and LLVM HWASAN
> test suite.
>
> Alexey Baturo (6):
>    target/riscv: Remove obsolete pointer masking  extension code.
>    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
>      of Zjpm v0.8
>    target/riscv: Add helper functions to calculate current number of
>      masked bits for pointer masking
>    target/riscv: Add pointer masking tb flags
>    target/riscv: Update address modify functions to take into account
>      pointer masking
>    target/riscv: Enable updates for pointer masking variables and thus
>      enable pointer masking extension
>
>   target/riscv/cpu.c           |  21 +--
>   target/riscv/cpu.h           |  46 +++--
>   target/riscv/cpu_bits.h      |  90 +---------
>   target/riscv/cpu_cfg.h       |   3 +
>   target/riscv/cpu_helper.c    |  97 +++++-----
>   target/riscv/csr.c           | 337 ++---------------------------------
>   target/riscv/machine.c       |  20 +--
>   target/riscv/pmp.c           |  13 +-
>   target/riscv/pmp.h           |  11 +-
>   target/riscv/tcg/tcg-cpu.c   |   5 +-
>   target/riscv/translate.c     |  46 ++---
>   target/riscv/vector_helper.c |  15 +-
>   12 files changed, 158 insertions(+), 546 deletions(-)
>

