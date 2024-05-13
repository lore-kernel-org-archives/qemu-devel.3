Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546CCC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6V9n-00072P-Ty; Mon, 13 May 2024 08:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6V9h-00071p-R4; Mon, 13 May 2024 08:51:49 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6V9f-0007ms-75; Mon, 13 May 2024 08:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715604701; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=4IjVqM3HKxz6mRMNzkOFjvIXzeUnDgbPlT2AcsSA838=;
 b=aOAMOtRnymzKjvIek55IGEE5esKhA6WBPGwVn+INg7wZ7VyfqDiY9e7PbLJYmC46dOKvFigZc5pTCLjh5ZPhCs1fizDxBLqM82fOL/soNc3Nrtmn7j+FZAHvH8/rwmBPgowlDGjGLW1NO6erQyYnVb0SdSEnwNKHnlD3RiU6KOw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033022160150;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W6QUbBq_1715604698; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6QUbBq_1715604698) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 20:51:39 +0800
Message-ID: <4df0c96c-a5cc-43a4-8046-7a72932d972f@linux.alibaba.com>
Date: Mon, 13 May 2024 20:50:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/5/11 18:10, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Hi,
>
> It looks like Pointer Masking spec has reached v1.0 and been frozen,

I think one big feature that this patch set missing is lack of pointer 
masking about the hypervisor load/store instructions.

Zhiwei

> rebasing on riscv-to-apply.next branch and resubmitting patches.
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

