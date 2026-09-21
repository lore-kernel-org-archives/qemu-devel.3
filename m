Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF4BC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8XvE-0008G9-3J; Mon, 21 Sep 2026 02:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x8XvB-0008FC-E0; Mon, 21 Sep 2026 02:54:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x8Xv8-0000rq-V7; Mon, 21 Sep 2026 02:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789973611; bh=j7IFDWTTGnuAz35k/ubT7zpIHJsC0779GTanXvpXXyw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nGpKkT2/xabiiF/I835dI3F23iGz67tOInDI1rIYpohAeRH6Ni0msnnuasQUuxHot
 7ptejRtmajiyzVMna/WEUzL9swr/w3URh0iGBhMPvOZGslZ4FCD1mArdC4l7XM+X4n
 smVSeafeJhuAHNodDMxuIvEYRP4BNRUQSY9dc7RqVVHzUTAlXCUK3QKHz4Kcs6l2Ks
 fSOzmT2MMOLunv0tbEsGK92g0T4KkC3sSSgoPcsZMMAgIgTscNef9r5zGvD3o0dftP
 RHqtvlaSYXXyuPTbsyNClXFC1b6CP1mLIyqjtcTAVY1OqpWmK0I5fIzf/V8qfjeWT3
 tUIUUex++aJjg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7EBBE1D6CD4;
 Mon, 21 Sep 2026 09:53:31 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E548342D5A8;
 Mon, 21 Sep 2026 09:54:23 +0300 (MSK)
Message-ID: <a30acccc-448b-4bfb-8071-5c337a40b7f6@tls.msk.ru>
Date: Mon, 21 Sep 2026 09:54:23 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PULL 0/4] Linux user patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260918202947.5322-1-deller@kernel.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260918202947.5322-1-deller@kernel.org>
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

On 9/18/26 23:29, Helge Deller wrote:

> linux-user patches for mlock syscall and loongarch64 and riscv fixes
> 
> Add support for the mlock syscall, and some fixes for loongarch64 and riscv.
> 
> ----------------------------------------------------------------
> 
> Michael Morrell (1):
>    linux-user: implement mlock2(2) syscall
> 
> SignKirigami (1):
>    linux-user/loongarch64: Detect vector stores in host_signal_write()
> 
> wangyang (2):
>    linux-user/riscv: honor zicntr=false for base counterCSRs
>    linux-user/riscv: invalidate reservations after stores
> 
>   .../include/host/loongarch64/host-signal.h    |  6 +++
>   linux-user/riscv/target_cpu.h                 |  2 +
>   linux-user/syscall.c                          |  9 +++++
>   linux-user/syscall_defs.h                     |  4 ++
>   target/riscv/cpu.c                            |  3 ++
>   target/riscv/cpu.h                            |  3 ++
>   target/riscv/helper.h                         |  5 +++
>   target/riscv/tcg/csr.c                        | 11 ++++--
>   target/riscv/tcg/insn_trans/trans_rva.c.inc   | 24 ++++++++++++
>   target/riscv/tcg/insn_trans/trans_rvi.c.inc   | 11 ++++++
>   .../riscv/tcg/insn_trans/trans_rvzawrs.c.inc  |  3 ++
>   target/riscv/tcg/op_helper.c                  | 35 +++++++++++++++++
>   target/riscv/tcg/translate.c                  | 38 +++++++++++++++++++
>   13 files changed, 150 insertions(+), 4 deletions(-)
I'm picking up this whole pull request for 11.1.x stable series, and
3 out of 4 changes for 10.0.x and 11.0.x series:

     linux-user: implement mlock2(2) syscall
     linux-user/riscv: honor zicntr=false for base counterCSRs
     linux-user/loongarch64: Detect vector stores in host_signal_write()

Please let me know if I should not.

The "invalidate reservations" change requires quite some tweaking
for older releases, so I'm skipping it for now.  Please tell me if
I should try harder and pick it up for older series too.

Thanks,

/mjt

