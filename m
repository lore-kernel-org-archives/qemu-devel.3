Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A7C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAB5W-0005Cw-Aa; Fri, 25 Sep 2026 14:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAB5T-0005CA-Py; Fri, 25 Sep 2026 14:56:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAB5R-0006NH-9c; Fri, 25 Sep 2026 14:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790362554; bh=Dl9zBua/Dhfhu/H4rZhUC+Ym7igP10aix80FuF0JV34=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AzF3mue0NIb5YWP3JSEXDtewKc0MjQ/Z9YpLT+rAg7Mw1J57LyYvqqyieaxY5J3If
 Tjn2m0fG9Zr8im8TPOTkfOA5XmL7B+P2PdZZ82PyMSce5T3K/OHmU7wwOTz+GVrYZJ
 E9eSJsp8oWyyYCksz8a7syUYN9R6qjGaIvp+O8gDjXkrMO4TBXRPz8pChncK2ppfrj
 jsk6NIWXBgXpeIkm4YxDbmI9eu54yvN3TySXVpLqUyn/KfCpdaFIxxQNgIQzp2lNEO
 eXoQY1D9yZau58Qho7NTg9x8cXAsmb+7GyVMb9GN9dq1IMQED6hk91Xxxczw7axEJB
 eQsUpGK3q90Dg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7DA931D86C5;
 Fri, 25 Sep 2026 21:55:54 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3901B430D36;
 Fri, 25 Sep 2026 21:55:54 +0300 (MSK)
Message-ID: <89182116-b7e2-4d3a-b1a7-95939de5866c@tls.msk.ru>
Date: Fri, 25 Sep 2026 21:55:54 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 3/3] linux-user/sh4: align the vdso sigreturn trampolines
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260923013700.1505113-1-mattst88@gmail.com>
 <20260923013700.1505113-4-mattst88@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260923013700.1505113-4-mattst88@gmail.com>
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

On 9/23/26 04:37, Matt Turner wrote:
> libunwind's unw_is_signal_frame() reads the trampoline as 32-bit words,
> but __kernel_sigreturn is only 2-byte aligned. Align both trampolines
> to 4 bytes, as the kernel's vsyscall-sigreturn.S does (with .balign 32).
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/sh4/vdso-be.so | Bin 2720 -> 2724 bytes
>   linux-user/sh4/vdso-le.so | Bin 2720 -> 2724 bytes
>   linux-user/sh4/vdso.S     |   2 ++
>   3 files changed, 2 insertions(+)

Shouldn't this one be picked up for 11.1.x stable branch too,
like the other 2 in this series?

Thanks,

/mjt

