Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D752606A884
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FDuWT/Yn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT2QI-00071c-EH; Mon, 16 Nov 2026 14:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xT2QH-00070y-10
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:31:25 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xT2QE-0004JO-2L
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:31:23 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67c24619b19so2726328d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 11:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794857480; cv=none;
 d=google.com; s=arc-20260327;
 b=ZBvglTh0pmcR97hxc6DUQ7l8aJ3jH7W+vnRZMyevRg8VpyiKSOQZW4t+9JIhWY5zRJ
 fjkgylehstNKAWbcRlmG0bACjhDW4oWG6U43K5kg7H25ig8h9avg0hCCknErVC/OIfY3
 5PBCEw/b18SusWsekxih7waT67uZx0hy3VDh4ZN2DdpbPNerU1So3URp9FqbCCep/mHq
 oMO5zFWGVuT4x+0rwLzWAEf7YuSOXAhqVnt43cUXmq1XvI24W9WMYVOteWjcKpq+CcDd
 C4prN5QXIZkKb3ZqELjjVSO/bWpefZZLwwY2LeI9H/Jc3L2Aah4dpi0WECTpIT5juZJ5
 FgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hvQ2sCg1HfdyVsyadHrWzZgE0Ls85Df2r0H9rHDaW50=;
 fh=v17iRpBNLiRbrIaZgyquSlid2DfiGtn9uXrbGUJrQ70=;
 b=OHUofFlufT+3mmUqe71knK2G8EI8D5d4dLa7aZkKFGmhDJZFmmfplpgC6f4PNp6+MN
 4QZaUz5oEFyHapdrFEHb1epWCMSIlAl6rV2xQrTyxxqN3eiUBjwnC++UC/eGRe+f3KaG
 xOOjcYISiNs3zsVRXKGEsKkHEYbtIsbH1VtODYs2DD5kgJn5a0F1UPWvwMfstzTN9Rw5
 dqn31pg1OIRkpv86AYf4gPAArXRlRJTEqOmIXSKchnmc6gGf+ZcVtployywQKx/SftFY
 pHmaRn2eDeBCeAP6xee5OTE+McFHGG1iQN/xgJ/D9iK6VfX94rcy3lOGAu5bzvZihBUe
 6Dog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794857480; x=1795462280; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hvQ2sCg1HfdyVsyadHrWzZgE0Ls85Df2r0H9rHDaW50=;
 b=FDuWT/Ynrr2xN7kLkwA0AK+DCixTe9kXdPidqLVnpQn5deUzZdZyqE3zJho6SSG5pL
 /iA5VYTXoMo+MyeKPygCqO4GBHTabzidAF0duzW9i7KXB/dAX5ycIZc01l2aVIgiXm4r
 VFeFSzxJTyGl4JYC56CZlU+BubkL1pecEo/V88HhGubwhxfs8SpN83W25m9nOC70ugoO
 XHctzaALxTMQvWpVMzQ5JRNRp1tPrajHLWhRzA0QRMCxgn3qBPmwym9ej3MT4vRTJO8N
 3vHTI7uTqeSjjQaB7LNA2dDw2xc3/9NxpiBqohwcwcvCo9sqCvW6Nl8YD66JV2b/oPvV
 TkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794857480; x=1795462280;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hvQ2sCg1HfdyVsyadHrWzZgE0Ls85Df2r0H9rHDaW50=;
 b=ETRr0TKBi2ORBmKfLelR4E1/h2xlfEiFYOC+NsnBXoCcdnwSAtpb/bq1lEPoz5sOED
 J2mgmq19YPORV2inmtsFz8bS/uPTr6v2SMsRgJBEZA/sHb5aYFzQOwoDfwH8aUdD/Kt7
 lacMI55YT+Y1syErVk1B4PnmKubVwIdAtbIH2h3Cye5/Yg5naR64Is1W6a4eXEOZJr/j
 Y56nvR0gjlyuqS73wlx+e51XQoql/H/KfJy4+bArpOMgw4gSDGkEUnnLVCqVKA9FblKe
 JKe5SaRmbQXguZE00w3J+z/anuzE41i8A3a8RqCe4BZv5nGjOerdRYn9wUaUuvMe+3AZ
 VaVg==
X-Gm-Message-State: APuU4Z/4caRYpbWFz90EtnR1JGXtmPiZ2g3XxCSE80oC2bwjk0PTLebO
 e76pvGG9nXJWf4rM6I9plrjnt0yoox/YxQJxQ83vE3L8AUYgKOlycX33LWIn1MvoddNb4zsayvr
 cHGi2PnXxSfpkWXfhlN07vayL1JNMmprGiH0cgQLVJg==
X-Gm-Gg: AZFdTZd/2jeynj0ke5qNlI46J+bQLEKsiXf5xMUiyxo/ODJ+gA+PkUmYvu9VBYKRSVh
 2n+SSiwIRLp+OxP4DFcGQfC7aQLXs5IyZmjmBeAqBGGoPHRp2e0YPcxO6XJMerd/LeNE27KWSGU
 L9kdfKP2uEzxZQ8wHTpe6F8fU2NwRujayO3keR6SmhE14JuGqyO4BpXY3Y6hpN/lbKrBhjn5Bs7
 zmSd2tqPZPZlxMMQTg4bnK0EuqLpVnqEIrTxlQnwjRrefKyhzvSpB3MuxSH6dyI4Sx7mG8YJTdi
 MirulE02C8uAfkfpq2QVv2QUoxfP819K/TVp/WflBAuYFhhlm2XdMnkac3KmijArGt1wjLekprM
 xrgfeDLC0bzHKKtNlnnRCEBIuzZJl9CAacRCMl+FM6Czp8TZLaSqqU9DTvwo212NCVpZX8YoGEq
 ER8gbwNq9VFQskPtj4/jhf
X-Received: by 2002:a05:690e:1688:b0:67d:babd:b80c with SMTP id
 956f58d0204a3-67dbabdc5aamr1889966d50.67.1794857479878; Mon, 16 Nov 2026
 11:31:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 19:31:08 +0000
X-Gm-Features: AclHuK86TOGoB8kRSwdXx4amVM7Dh5DygxvE65EO4LJUouj_so5MRTVNEi8304Q
Message-ID: <CAFEAcA8Nmt_Nsvfm77en_oaE4orcQ3BdCBQWNAXmi0iqLgV7fw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix RCsc store->load ordering of release stores
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 21 Aug 2026 at 07:40, LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>
> Several guest architectures give their store-release instructions RCsc
> semantics, which requires the store to be ordered not only after the
> memory operations that precede it, but also before any subsequent
> load-acquire with RCsc semantics.  The TCG translators, however, only
> emit the leading barrier before the store, so under MTTCG nothing
> prevents the host CPU from executing the load-acquire that follows a
> store-release before the store has left its store buffer.  On an x86
> host (TSO), store-load is the only reordering the hardware may
> perform, and it is exactly the ordering that is missing, so the
> architecturally forbidden [0,0] outcome of the Store Buffering litmus
> test is easy to observe:
>
>     CPU 0                      CPU 1
>     store-release X = 1        store-release Y = 1
>     load-acquire  r0 = Y       load-acquire  r1 = X
>
> The affected instructions are the RISC-V Zalasr store-release
> instructions and the Arm STLR, STLPUR and A32/T32 STL store-release
> instructions.  Neither architecture defines an RCpc store, so every
> store-release is RCsc (RVWMO preserved program order Rule 7; Arm
> Architecture Reference Manual DDI 0487, section B2.3.8 "Acquire and
> release semantics").
>
> Patch 1 fixes the RISC-V side and patch 2 the Arm side by emitting a
> full barrier after the store as well.  Patch 3 fixes an inverted
> barrier polarity found in the A32 LDA load-acquire translator while
> auditing the load-acquire side.

> LIU Zhiwei (3):
>   target/riscv: Fix RCsc ordering of Zalasr store-release
>   target/arm: Fix RCsc ordering of store-release instructions
>   target/arm: Fix barrier polarity of A32 LDA load-acquire

This series seems to have been accidentally missed, possibly
because it included both arm and riscv patches in the same
patchset. RTH tells me that the Arm patches are correct, and
Daniel has reviewed the riscv one.

riscv maintainers: are you OK with me queuing the whole set
including the riscv patch in target-arm.next, or would you
prefer to take the riscv patch yourself through your queue?

thanks
-- PMM

