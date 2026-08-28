Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF7FC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzqdv-0003Mo-AW; Fri, 28 Aug 2026 03:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzqdt-0003MJ-Kx; Fri, 28 Aug 2026 03:04:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzqdr-0000gC-5K; Fri, 28 Aug 2026 03:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787900674; bh=5Zo2nHE/4QKMw3elm5onMRr6EVtx/g68Ag16h7MO5cc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YLyxNZJq39N48ssOiap3ClRl67vRc3lOtD3EwvC69VBAPsIxyN/LkapABlzl/3efx
 qfbFVKl/m+FyNpEWPzdnorQQoubX4sWdVXwGjXFVtdXheAhhcSmOAGODR4zjqMH4gn
 C0TrWZvOp9/VwMnfNj7r53gjYxZbrqgutxB+2fn+qpZEQhAyyZ1FVcTUKE5qhiyxyP
 TNDlFoJ+rOhFeDcAXHEDA8dBWvQo5g1K6OhsAJk4frLLSOEScjFrDBxr+NMZCjVUGL
 M/n9CWLVVsBFdl2/SmXdbZftc/fepoUbhkiHJA38UAPoh0pe8J6vP5Yy5XhH8GsDTg
 P9njSIeBnQDuQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 567961CF51C;
 Fri, 28 Aug 2026 10:04:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 82DF6419A33;
 Fri, 28 Aug 2026 10:04:38 +0300 (MSK)
Message-ID: <a630b631-8b51-4b8e-af87-1c0de546ea8b@tls.msk.ru>
Date: Fri, 28 Aug 2026 10:04:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/2] target/riscv: Fix riscv64 KVM migration
To: Xie Bo <xb@ultrarisc.com>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com
References: <20260808125157.1220511-1-xb@ultrarisc.com>
 <20260825070309.1086125-1-xb@ultrarisc.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260825070309.1086125-1-xb@ultrarisc.com>
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

On 8/25/26 10:03, Xie Bo wrote:
> Hi,
> 
> Now that this series is in master, could it also be considered for
> stable-11.1?
> 
> Both commits are needed together:
> 
> 7df9aa5 target/riscv/kvm: Synchronize privilege mode
> ddac7cf target/riscv/kvm: Preserve MP state across migration

Heh.  I remember that big riscv pull request.  I processed it before
11.1.1, so changes from it are included in 11.1.1.

However, these two changes didn't have neither Fixes: nor Resolves:
tags, -- this is the criteria for riscv fixes for stable - so I
skipped them :)

Picked these two up now, but it will be about a month before the
next stable release.

Yes, as Alistar noted, it is best to include Cc: qemu-stable@ when
submitting a patch which should be picked up for the stable series.
I understand sometimes it is not obvious, so yes, Cc'ing qemu-stable@
after the fact works too.

Thank you!

/mjt

