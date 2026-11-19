Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113E606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=srf6GaVp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTz2O-0002sq-C6; Thu, 19 Nov 2026 05:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTz2L-0002sZ-Ny; Thu, 19 Nov 2026 05:06:37 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTz2J-0007Sq-7U; Thu, 19 Nov 2026 05:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795082788; bh=Qc0bvxyP+rbMY9tAfVyqbdiZSl/g+kN5/MIns9Y/wzI=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=srf6GaVpq1BYBHWNM6SkV8iLN9RvpMURezzv6EgJsbScrdTGZU9QVuRl50zmAgSD2
 0JKEyzipkYB3cIGU3bLWRmOQxUXZLlpTR5EXlWQf2aLtfSkiIsVS0ajJWVZ83igAuo
 5Z/1kBqe0BQWYevo9ZYeKZReWk7hdrQKGmXkTs1Xc5TGOHqH4wntQIWUB/Ej/6r214
 7jLyHm1inZlXofr0hJXKBWqb0gRRO3FfYiXcVWM4+ze83X7y87dx2mbyCIvPkPa6mm
 bOAqAbHRUcQUuGtv90+8USMgRrykRyjAPmPGBqOCGjH8aYH6ohtRYqBEBr/029KwbI
 8QFqrTVJnXubw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5979B1E7EA1;
 Thu, 19 Nov 2026 13:06:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 485BC461750;
 Thu, 19 Nov 2026 13:06:28 +0300 (MSK)
Message-ID: <b5f942b2-63d7-44e6-a86b-71f3e3980579@tls.msk.ru>
Date: Thu, 19 Nov 2026 13:06:28 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] i386, Rust for 2026-11-17
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261118171838.38195-1-pbonzini@redhat.com>
Content-Language: en-US, ru-RU
Cc: QEMU Stable <qemu-stable@nongnu.org>,
 NickSampanis <nicksampanis@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261118171838.38195-1-pbonzini@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 20:18, Paolo Bonzini wrote:

> * target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events()
> * target/i386/kvm: set VM ioctl KVM_SET_TSC_KHZ to maintain TSC synchronization
> * target/i386/tcg: fix CPUID checks for TZCNT and LZCNT
> * target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD
> * target/i386/tcg: fix SETCC(zu) optimization
> * target/i386/tcg: fix lea address calculation for CS register
> * target/i386/tcg: Fix 64-bit RSP truncation on far transfers
> * target/i386/tcg: all scalar instructions should be LIG
> * target/i386/tcg: treat ENTER's size operand as unsigned
> * target/i386/tcg: remove unused argument of decode_ops
> * target/i386/tcg: remove unused operand sizes
> * tests/tcg: fix load/restore for test-avx and test-mmx
> * rust: fix failure with nightly libstd

Hi!

 From this PullRequest I'm picking up 2 changes for the stable series --

   target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events()
   target/i386/tcg: treat ENTER's size operand as unsigned

But it feels like some other fixes should be picked up too.

For example, should I pick the 64-bit RP truncation fixes?

The "target/i386/tcg: fix lea address calculation for CS register" change feels
like a good candidate for 11.1.x.

Maybe some fixes by Paolo.

What do you think?

Thanks,

/mjt

> ----------------------------------------------------------------
> Denis V. Lunev (1):
>        target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events()
> 
> Dongli Zhang (1):
>        target/i386/kvm: set VM ioctl KVM_SET_TSC_KHZ to maintain TSC synchronization
> 
> John Snow (1):
>        build: Add "-d keeprsp" to Ninja flags
> 
> Mark Cave-Ayland (1):
>        target/i386/tcg: fix lea address calculation for CS register
> 
> NickSampanis (3):
>        target/i386/tcg: Fix 64-bit RSP truncation on retf in 64-bit mode
>        target/i386/tcg: Fix 64-bit RSP truncation on far call in 64-bit mode
>        target/i386/tcg: Fix 64-bit RSP truncation on far call through a call gate
> 
> Paolo Bonzini (7):
>        target/i386/tcg: fix CPUID checks for TZCNT and LZCNT
>        target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD
>        target/i386/tcg: fix SETCC(zu) optimization
>        tests/tcg: fix load/restore for test-avx and test-mmx
>        target/i386/tcg: all scalar instructions should be LIG
>        target/i386/tcg: remove unused argument of decode_ops
>        target/i386/tcg: remove unused operand sizes
> 
> Samuel Tardieu (1):
>        rust/common: rename IntegerExt::bit() to single_bit()
> 
> Zixin Wang (1):
>        target/i386/tcg: treat ENTER's size operand as unsigned

