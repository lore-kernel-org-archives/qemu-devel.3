Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A5CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERme-0006fA-1d; Thu, 30 Oct 2025 08:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vERmb-0006ej-TQ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:29:37 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vERmS-0006BC-55
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=thxOci1pyEB5X6IwzjhsmGxoYfCkD7yH5VtxeFN2yew=; b=Of70T1n+tXi/6O6
 5N3fpXrJK0YdsNW96iNW35QEuitowKkB09Sb4wFb2ICO1i3xGXiAycGoaRjXqLPL+CvusRG1mm/4j
 wT5Cxy3ojGxJEUWexGbt5JiTtadDVvXkjMx2RNO/m9E2xOB6VK/HeZ4Zmx7YTUKOBosX8xLqPNmJ7
 As=;
Date: Thu, 30 Oct 2025 13:32:09 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Subject: Re: [PATCH v2 2/3] hw/riscv: Replace target_ulong uses
Message-ID: <2y2ism54afg4ke5oeykqin5oy2kn4lb4gcd7fidgrmlwwbe6df@5h4wudvpyll4>
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
 <49e7ca69-3477-40c8-aad3-f799d848ce7a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49e7ca69-3477-40c8-aad3-f799d848ce7a@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/10/25, Philippe Mathieu-Daudé wrote:
> On 27/10/25 13:35, Anton Johansson wrote:
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   hw/riscv/riscv-iommu.c | 6 ++++--
> >   hw/riscv/riscv_hart.c  | 2 +-
> >   2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index b33c7fe325..f8656ec04b 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -26,6 +26,8 @@
> >   #include "migration/vmstate.h"
> >   #include "qapi/error.h"
> >   #include "qemu/timer.h"
> > +#include "qemu/target-info.h"
> > +#include "qemu/bitops.h"
> >   #include "cpu_bits.h"
> >   #include "riscv-iommu.h"
> > @@ -391,9 +393,9 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> >               const uint64_t va_mask = (1ULL << va_len) - 1;
> >               if (pass == S_STAGE && va_len > 32) {
> > -                target_ulong mask, masked_msbs;
> > +                uint64_t mask, masked_msbs;
> > -                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
> > +                mask = MAKE_64BIT_MASK(0, target_long_bits() - va_len + 1);
> >                   masked_msbs = (addr >> (va_len - 1)) & mask;
> >                   if (masked_msbs != 0 && masked_msbs != mask) {
> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> > index c7e98a4308..65d2c92018 100644
> > --- a/hw/riscv/riscv_hart.c
> > +++ b/hw/riscv/riscv_hart.c
> > @@ -93,7 +93,7 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
> >           g_assert(rc == 0);
> >           csr_call(words[1], cpu, csr, &val);
> > -        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
> > +        qtest_sendf(chr, "OK 0 %"PRIx64"\n", val);
> >           return true;
> >       }
> > 
> 
> What about csr_call()?

csr_call() is handled in the other series making cpu.h target agnostic,
there we expose 64 bit variants of reading/writing CSRs which are then
used by csr_call().

