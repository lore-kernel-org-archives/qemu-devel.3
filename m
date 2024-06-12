Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E21AC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMQg-0007Jl-Jn; Wed, 12 Jun 2024 07:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHMQb-0007Ig-F8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:46:09 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHMQW-0002iE-AW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:46:08 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 80DB540755E8;
 Wed, 12 Jun 2024 11:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 80DB540755E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718192761;
 bh=2ei2FukXUx03ACW2sMrttv5mUoBKsFcD2oyeuoaDUJg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=kNfBfWRrIxMDHZdMHQ7Ure0CdUiJqueDt8UYa+1DB+gLMuHCG/eNsaDQ74abZp1To
 hfvCHm92i5P+BaYA7SwdCP28Zr1C1qHKJLnAVlCn+O3OhdaCMf8pBPoRpiD7qRQKRk
 UNIlRPiKVcGlYm7LruFKotfUG5d4zbv3k51Y0iJk=
Date: Wed, 12 Jun 2024 14:46:01 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
In-Reply-To: <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
Message-ID: <caa7d068-a2c6-28a4-51d5-93c61f004bc0@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
 <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-934418380-1718192761=:10393"
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-934418380-1718192761=:10393
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Wed, 12 Jun 2024, Paolo Bonzini wrote:

> On Wed, Jun 12, 2024 at 1:19 PM Alexander Monakov <amonakov@ispras.ru> wrote:
> > On Wed, 12 Jun 2024, Paolo Bonzini wrote:
> > > I didn't do this because of RHEL9, I did it because it's silly that
> > > QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
> > > compute the x86 parity flag (and POPCNT was introduced at the same
> > > time as SSE4.2).
> >
> > From looking at that POPCNT patch I understood that Qemu detects
> > presence of POPCNT at runtime and will only use the fallback when
> > POPCNT is unavailable. Did I misunderstand?
> 
> -mpopcnt allows GCC to generate the POPCNT instruction for helper
> code. Right now we have code like this in
> target/i386/tcg/cc_helper_template.h:
> 
>     pf = parity_table[(uint8_t)dst];
> 
> and it could be instead something like
> 
> #if defined __i386__ || defined __x86_64__ || defined __s390x__||
> defined __riscv_zbb

GCC also predefines __POPCNT__ when -mpopcnt is active, so that would be
available for ifdef testing like above, but...

> static inline unsigned int compute_pf(uint8_t x)
> {
>     return __builtin_parity(x) * CC_P;
> }
> #else
> extern const uint8_t parity_table[256];
> static inline unsigned int compute_pf(uint8_t x)
> {
>     return parity_table[x];
> }
> #endif
> 
> The code generated for __builtin_parity, if you don't have it
> available in hardware, is pretty bad.

On x86 parity _is_ available in baseline ISA, no? Here's what gcc-14 generates:

        xor     eax, eax
        test    dil, dil
        setnp   al
        sal     eax, 2

and with -mpopcnt:

        movsx   eax, dil
        popcnt  eax, eax
        and     eax, 1
        sal     eax, 2

Alexander
--8323328-934418380-1718192761=:10393--

