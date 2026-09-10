Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1C5C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4j72-0000VP-L3; Thu, 10 Sep 2026 14:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4j71-0000VC-Fj; Thu, 10 Sep 2026 14:03:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4j6z-0003Zp-RC; Thu, 10 Sep 2026 14:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789063347; bh=Ves5aQZLP6DlksNwPlCZWs2nfAn0+EPatg+jSlhjxDQ=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=o9Ap0JXRytT03xEpsp/USgCKEVQPuL4C21KQAkRpSuh9TjDG/UIQV0VRoIwxrHyLT
 ZpOZIlqO15rVia2ShGmW7oxKi0NpmzNmSByLaprrh7ItMvBM/mVq6BrgsUsEvo1rf4
 03EslFjh0AKpx0nBUXY+C1RBSdZYUXD/o0J47HF0Ja/Cpc9c3Prpf5v00BwnpBuX5M
 /PlZ64008CelQ9N5OpjQYgVV/aFPo2hzqjrYHUb8i3+PIu+C7VRsaZYvVdZgFIC4cp
 xs4pZJ9hkKifAS1MpgpOuhwtTqhIxun3cFuRPz9gSfZWMiQcym5aIt+Rv23Ods7MYa
 lG/SgcHbQzaYw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE7161D389A;
 Thu, 10 Sep 2026 21:02:27 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4B06C4258B7;
 Thu, 10 Sep 2026 21:02:59 +0300 (MSK)
Message-ID: <ab12c39c-5d5d-4c4a-8486-3072f85c25f6@tls.msk.ru>
Date: Thu, 10 Sep 2026 21:02:59 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PULL 00/12] Misc patches for 2026-09-09
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260909155624.1082893-1-pbonzini@redhat.com>
Content-Language: en-US, ru-RU
Cc: Simon Scherer <scherer.simon89@gmail.com>,
 Andrey Polivoda <apolivodaa433@gmail.com>,
 QEMU Stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
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

On 9/9/26 18:56, Paolo Bonzini wrote:
...> Andrey Polivoda (1):
>        target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, 0xF3

> Simon Scherer (5):
>        target/i386: Fix FXCH to unconditionally clear C1
>        target/i386: clear C1 for all x87 compare instructions
>        target/i386: Update FPU tag word for FXTRACT's old ST(0)
>        target/i386: Update FPU tag word for FSTP
>        target/i386: Update FPU tag word for FXCH

Actually, it looks like this whole lot should be picked up for qemu stable,
is it not?

Thanks,

/mjt

