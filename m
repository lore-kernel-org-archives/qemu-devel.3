Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA033C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsczV-0006rN-0E; Sat, 08 Aug 2026 05:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wsczS-0006qX-SW; Sat, 08 Aug 2026 05:05:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wsczP-0004yd-VJ; Sat, 08 Aug 2026 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786179903; bh=Q43xD9dK/bjHiOVr5Hbh/YFCcP9bejsZBDmjOo5Sjl0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Zhpe1DeQOgdYtIX3sltqwe1ZUUXNGFsGFs2RZvSekyNfnS2TlUafAgy9NVy5GrKkE
 Pt1ADWVQSlvefPGpHSAGRBOuBlUKHfd5hQMHjgJFIAf1yCzdDGQbxouhr22clEJsH3
 sFBYowUDcsBPrBo4ZhWVk3rQpgczmYRH2lFeY623WKfp+T4d/AXjMH9abAsKQUBccj
 SHrjgc933bNgn9HqdkkcvT7XpBw2tQY4P5wZc1POVq3Nams9KRYu3HoK3zIM+fu65O
 Kz2AUMR4+nKQU3NHB+i9W5ZivCzQSfYq3YNNLUIlkl05GpFD/j2r2+Lkb6xiFEcqFU
 s5sEjhFtl/mgQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B7CF31C9363;
 Sat, 08 Aug 2026 12:05:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 62D12404E3A;
 Sat, 08 Aug 2026 12:05:06 +0300 (MSK)
Message-ID: <3ad150e9-5a6b-43e5-9122-f2ec34090d76@tls.msk.ru>
Date: Sat, 8 Aug 2026 12:04:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] qapi: Fix some command blocked for too long
To: zoudongjie <zoudongjie@huawei.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, alex.chen@huawei.com, chenjianfei3@huawei.com,
 eric.fangyi@huawei.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com,
 luolongmin@huawei.com, mujinsheng@huawei.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, renxuming@huawei.com, stefanha@redhat.com,
 suxiaodong1@huawei.com, wangjian161@huawei.com, wangyan122@huawei.com,
 yebiaoxiang@huawei.com, zhuyangyang14@huawei.com
References: <20250401130300.1457584-1-zoudongjie@huawei.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20250401130300.1457584-1-zoudongjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 4/1/25 16:02, zoudongjie via wrote:
> From: Zhu Yangyang <zhuyangyang14@huawei.com>
> 
> QMP may will be blocked for a long time on bdrv_drained_begin() when a
> network disk is configured and the network failure is just about to occur.
> 
> In theory, any command may be blocked if it calls bdrv_drained_begin().
> 
> This series add a timeout parameter for qmp_block_set_io_throttle() and
> qmp_block_resize() to control their execution duration.

Hi!

Has this (oldish) patchset been abandoned/lost somehow?

Thanks,

/mjt

> Changelog
> v4 ---
>    1. Corrected the added version of the timeout parameter from 10.0 to 10.1
>    2. Add a patch to add the timeout parameter for qmp_block_resize().
> 
> v3 ---
>    Unify AIO_WAIT_WHILE_{TIMEOUT/INTERNAL} by replacing AIO_WAIT_WHILE_INTERNAL() with
>    AIO_WAIT_WHILE_TIMEOUT(..., 0).
> 
> v2 ---
>    1. Support 0 in BDRV_POLL_WHILE_TIMEOUT(), 0 means infinite.
>    2. Use uint64_t timeout_ns instead of int64 timeout to name variables.
>    3. Use timer_pending() to check for expiry instead of explicitly checking
>       against the deadline for BDRV_POLL_WHILE_TIMEOUT().
>    4. Add documentation for bdrv_drained_begin_timeout(), note that bdrv_drained_end()
>       must be called when -ETIMEDOUT is returned.
>    5. Add a timeout parameter to the qmp_block_set_io_throttle() instead of hardcoding
>       the timeout, and the default value is 0, mean an infinite timeout.
> 
> v1 patch link:
> https://lore.kernel.org/qemu-devel/20250308101618.721954-1-zoudongjie@huawei.com/
> 
> 
> Zhu Yangyang (3):
>    io/block: Refactoring the bdrv_drained_begin() function and implement
>      a timeout mechanism.
>    qapi/throttle: add timeout parameter for qmp_block_set_io_throttle()
>    qapi/resize: add timeout parameter for qmp_block_resize()
> 
>   block/block-backend.c                       | 14 ++++-
>   block/io.c                                  | 58 +++++++++++++++++----
>   block/monitor/block-hmp-cmds.c              |  2 +-
>   block/qapi-system.c                         | 10 +++-
>   blockdev.c                                  | 16 +++++-
>   include/block/aio-wait.h                    | 47 ++++++++++++-----
>   include/block/block-io.h                    | 22 +++++++-
>   include/system/block-backend-global-state.h |  1 +
>   qapi/block-core.json                        | 11 +++-
>   util/aio-wait.c                             |  5 ++
>   10 files changed, 155 insertions(+), 31 deletions(-)
> 


