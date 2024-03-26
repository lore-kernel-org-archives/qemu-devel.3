Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B6FCD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3Uo-0005ZK-Pu; Tue, 26 Mar 2024 05:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rp3Um-0005Z3-9g; Tue, 26 Mar 2024 05:53:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rp3Uk-0006Om-Kl; Tue, 26 Mar 2024 05:53:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD14658F6B;
 Tue, 26 Mar 2024 12:54:52 +0300 (MSK)
Received: from [192.168.177.132] (mjt-x200la.wg.tls.msk.ru [192.168.177.132])
 by tsrv.corpit.ru (Postfix) with ESMTP id E928FA3210;
 Tue, 26 Mar 2024 12:53:22 +0300 (MSK)
Message-ID: <19d5ffb8-8cf1-4d88-b66a-2cf961621b93@tls.msk.ru>
Date: Tue, 26 Mar 2024 12:53:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
 <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
 <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
 <6d1ea7ad-0a81-4f5e-8210-80b5150bc521@tls.msk.ru>
 <6fb5ca42-8e86-4144-b9a9-9d98d30f8fb9@ventanamicro.com>
Content-Language: ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6fb5ca42-8e86-4144-b9a9-9d98d30f8fb9@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

On 24.03.2024 21:12, Daniel Henrique Barboza wrote:
> On 3/24/24 12:07, Michael Tokarev wrote:

>> Unfortunately this doesn't quite work, the following changes
>> fail to apply to 8.2:
>>
>> 929e521a47 target/riscv: always clear vstart for ldst_whole insns
>> b46631f122 target/riscv: remove 'over' brconds from vector trans
>> d57dfe4b37 trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>> bac802ada8 target/riscv: enable 'vstart_eq_zero' in the end of insns
>> 385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acceleration

> The amount of work can be non-trivial for this backport, so I'd say we should
> leave it aside for now. If someone has a good argument for this work then we
> can re-evaluate.

So, out of 15 patches in this series (minus the first one already
mentioned) - should I pick 9 remaining patches for stable (the ones
which applies) or none at all? :)

Thanks,

/mjt

