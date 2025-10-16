Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBAFCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9R7v-0006jq-7a; Thu, 16 Oct 2025 12:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v9R7t-0006jd-HM; Thu, 16 Oct 2025 12:46:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v9R7n-0008QQ-1K; Thu, 16 Oct 2025 12:46:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 648D515EADE;
 Thu, 16 Oct 2025 19:46:25 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 88C352A2867;
 Thu, 16 Oct 2025 19:46:26 +0300 (MSK)
Message-ID: <12f3164f-291e-4415-b724-299a23dec746@tls.msk.ru>
Date: Thu, 16 Oct 2025 19:46:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reverts needed to get qemu 10.1.1 and 10.0.5 working for me
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
References: <cf07f156-6d93-4631-8f8b-6bdaae488519@roeck-us.net>
Content-Language: en-US, ru-RU
Cc: qemu-stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <cf07f156-6d93-4631-8f8b-6bdaae488519@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[Adding qemu-stable@ to Cc]

On 10/15/25 13:33, Guenter Roeck wrote:
> Hi all,
> 
> I lost track what exactly I reported, so here is a summary of reverts and
> patches I needed to get qemu 10.1.1 and 10.0.5 working for me.

Reported to where?


> ---
> v10.1.1:
> 
> commit b1adefa3cf40df5b1e72c77eab80284831344aba
> Author:     Guenter Roeck <linux@roeck-us.net>
> AuthorDate: Tue Oct 14 15:41:04 2025 -0700
> Commit:     Guenter Roeck <linux@roeck-us.net>
> CommitDate: Tue Oct 14 15:44:23 2025 -0700
> 
>      Revert "scsi-disk: Advertise FUA support by default"
>      
>      This reverts commit 5562e214e82ae4bcb0b642cc52b304bdc78a58c3.
>
>      Triggers
>      
>      [   30.688576] sd 0:2:0:0: [sda] tag#413 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
>      [   30.689126] sd 0:2:0:0: [sda] tag#413 CDB: opcode=0x2a 2a 08 00 00 00 02 00 00 02 00
>      [   30.689431] I/O error, dev sda, sector 2 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 2
>      [   30.689667] Buffer I/O error on dev sda, logical block 1, lost sync page write
>      [   30.690052] EXT4-fs (sda): I/O error while writing superblock
>      mount: mounting /dev/root on / failed: I/O error
>      
>      when trying to boot from megasas/megasas2 on riscv systems, and subsequently
>      hangs in scsi code when trying to shut down.

Do you have a reproducer of this?  At least, I see
ext4 fs is involved, so it's a linux guest, it looks like.
Something else?


> commit 7a7e0ff6552fd5ca60d31d302fde492c7194208b
> Author:     Guenter Roeck <linux@roeck-us.net>
> AuthorDate: Sun Oct 12 20:26:29 2025 -0700
> Commit:     Guenter Roeck <linux@roeck-us.net>
> CommitDate: Sun Oct 12 20:37:24 2025 -0700
> 
>      Revert "hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response"
>      
>      This reverts commit 4474802b0cd59fa14b603b953fa0bc8cc92783c0.
>      
>      The patch seems innocent but causes net-cdc connection failures.

What's the reproducer of this?

And is master branch have the same issue?

Note: this commit id is in 10.0.x stable branch, not in 10.1.x branch
as you reported above.  The commit ID of this change in 10.1.x is
88006572b4, and on master branch it is aaf042299ac.


> commit 193a0b3f3cdbba3605e6c0be6bf81e5ebf54e5ba
> Author:     Guenter Roeck <linux@roeck-us.net>
> AuthorDate: Sun Oct 12 11:31:40 2025 -0700
> Commit:     Guenter Roeck <linux@roeck-us.net>
> CommitDate: Sun Oct 12 11:31:40 2025 -0700
> 
>      Revert "target/sh4: Use MO_ALIGN for system UNALIGN()"
>      
>      This reverts commit eb978e50e42f3439e7a7a104e76aafc81bc4a028.

A problem with this is?  The reproducer is?
> commit a0698826d4a652257d315efc758c6f8f68d52ef1
> Author:     Richard Henderson <richard.henderson@linaro.org>
> AuthorDate: Sat Oct 4 12:24:14 2025 -0700
> Commit:     Guenter Roeck <linux@roeck-us.net>
> CommitDate: Sun Oct 12 11:23:02 2025 -0700
> 
>      accel/tcg: Hoist first page lookup above pointer_wrap
>      
>      For strict alignment targets we registered cpu_pointer_wrap_notreached,
>      but generic code used it before recognizing the alignment exception.
>      Hoist the first page lookup, so that the alignment exception happens first.
>      
>      Cc: qemu-stable@nongnu.org
>      Buglink: https://bugs.debian.org/1112285
>      Fixes: a4027ed7d4be ("target: Use cpu_pointer_wrap_notreached for strict align targets")
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>      Signed-off-by: Guenter Roeck <linux@roeck-us.net>

And what's with this one?   It is queued up for next stable-10.1.

> commit 84762d228175b9c24ec4a7a48420722ec3dfb978
> Author:     Guenter Roeck <linux@roeck-us.net>
> AuthorDate: Sat Oct 4 12:41:40 2025 -0700
> Commit:     Guenter Roeck <linux@roeck-us.net>
> CommitDate: Wed Oct 8 14:58:53 2025 -0700
> 
>      Revert "hw/riscv: Make FDT optional for MPFS"
>      
>      This reverts commit 0c2ca9e4d139acc762325d994614a42dba31be6a.
>      
>      Prevents kernel command line from being accepted.

A reproducer please?

> commit 82421bc6a895d679a6c4a7c0c4570e2f4c644261
> Author:     Guenter Roeck <linux@roeck-us.net>
> AuthorDate: Sat Oct 4 12:41:05 2025 -0700
> Commit:     Guenter Roeck <linux@roeck-us.net>
> CommitDate: Wed Oct 8 14:58:53 2025 -0700
> 
>      Revert "hw/riscv: Allow direct start of kernel for MPFS"
>      
>      This reverts commit 6dd6f11710c713bd21ac67ab93f6db33169c6b4d.
>      
>      Prevents kernel command line from being accepted.

Is it the same as above?  A reproducer please?

There's not enough information provided.  Please give us some
more food to harvest the issues.

/mjt


