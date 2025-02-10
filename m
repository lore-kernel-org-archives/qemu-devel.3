Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FED6C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 11:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thS6v-0003y0-VX; Mon, 10 Feb 2025 06:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thS6r-0003uJ-JU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:37:54 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thS6n-0006Wm-MV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:37:53 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5b1c4b952dso3361314276.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739187460; x=1739792260; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pp2zLLlfLDN8WiIc1V0EgQjJieMnt5v1KRho29rsolU=;
 b=gBkLAd/XQOIqmizzEjrEx/8F6aNEzRsFgwL1XlmpTqkEmL+dpyLkM1MkMA+71aCj3v
 xGtiJyKZI3JBXrWDhwTE6AX6mdSLS/yV/zJlWWxpBBu0a5q/u/COu+U97G7Xb3EDdFdM
 SK7Hz7BqtoAQYYPh7ZcOM6xjZ8ZlrBN+QU2SBWOA7MvlQIXOXtA+Irtha/F6b6hUDINj
 brVlK+Q5sF4f2Cw8dv4Pv7bNph/BJAC6yoaJcmSF5l3VrpcmkkeIq+Oxxop4nAWCUxHZ
 inPkuPZIzkhmh0eW4nxUOxyGPVmPpkmhFwCFuAEBnL82nHeAuTqsE1cMJqBLVqTsYwxy
 mvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739187460; x=1739792260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pp2zLLlfLDN8WiIc1V0EgQjJieMnt5v1KRho29rsolU=;
 b=RBz4roIYHuy10f6mcBdDd/qnvDtAGALMAZ2AwNqQq5/G6Mfm+aLBq1UrACwYH2jTlx
 cLn28BcmZsoQI5d4bEdMz/vhsJTMvhHS4oiMVqebqzD97s9tQUtHFfS79oG5AMuDDmIl
 PNy66PsxrmZ2dfe0Kat2PKcw+8jjfjAwujaHhDjojrdEusHWMAIBih488Gy8IOwB+O+K
 LruYxtS94thc9bf3GAmnuA3NTXNxY2sv7tY0I/9bKXScQDjhaAcqRmpCAtYOsb8jlqPH
 IQ5TSy3uMnU4RdnfJRg1cxo4t9hwKgdWIL8wH8Pp/trNC/yuz19UEjzSjsmVvB2kgHQU
 Itmg==
X-Gm-Message-State: AOJu0YzvqMwp+xKkTSpxrtGnYKr3dCfbcX3JcOP6QTdtpxa5Z6scZLR3
 7XCx/CZMi51CdWma0XQy0XfxoKDrYtzc3Ny98+1ABQNDpn9tjIugIayXFHL1Zv8oaOyisIL0sAB
 TDEDtn0cqYSd65a5g4cztOSBhJCp7yVxB502HAA==
X-Gm-Gg: ASbGncv8X6nuCmSE1meJYQFIS4rvUvGaaiwP9soyUUeobFYFZkqaeQ8phW+8Q60Y1mA
 bHJ249R1DCE31zxVGMMkCneXXsna1u8Aal71tVUmCxKnSMW8HH/p7lU+LaeGkl4S/G84MfVt7dQ
 ==
X-Google-Smtp-Source: AGHT+IFEqJai7C5o6VQu3T1/+dJjyN7F6oShxIFkEV0LUavhATdw3PA9OHaTX+WKF8gqBONmJ6NS7Cvp76RN6dhvy3Q=
X-Received: by 2002:a05:6902:1025:b0:e5b:323b:a1a7 with SMTP id
 3f1490d57ef6-e5b4629256emr9460910276.42.1739187460438; Mon, 10 Feb 2025
 03:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20220606231450.448443-1-richard.henderson@linaro.org>
 <20220606231450.448443-28-richard.henderson@linaro.org>
 <CAFEAcA8ccgyLQPMykDQGjK5qc-etEBrsy0qGo+8mq-2_nCDDFg@mail.gmail.com>
 <CAFEAcA8mHTYoY8C-KJ0BFJ6JR3BgRA0ZPjZKDyPjOGVEJ+RFvQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8mHTYoY8C-KJ0BFJ6JR3BgRA0ZPjZKDyPjOGVEJ+RFvQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 11:37:28 +0000
X-Gm-Features: AWEUYZniYJCWCVvZgtmaQsXtvaT7vuZ0VE0VqOOwqEipOfK8qoIAIMyp_JhRbQA
Message-ID: <CAFEAcA-HOr1Bf_tknZcdyg20KbQeydQi33UKpYjtynV-09DHLg@mail.gmail.com>
Subject: Re: [PULL 27/43] target/loongarch: Add TLB instruction support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =gaosong@loongson.cn, yangxiaojuan@loongson.cn, 
 Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

Ping^2 -- could one of the loongarch maintainers have
a look at this problem with the TLB code where it
does an out-of-range shift, please? This is the only
sanitizer failure in 'make check-functional' for the
whole of QEMU, so it would be nice to get this to a
100% pass.

thanks
-- PMM

On Tue, 26 Nov 2024 at 13:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping regarding this UB due to an invalid shift --
> I think this is now the only remaining sanitizer error
> in a 'make check-functional', so it would be nice to get
> it fixed...
>
> thanks
> -- PMM
>
> On Thu, 7 Nov 2024 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 7 Jun 2022 at 00:31, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > >
> > > From: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> > >
> > > This includes:
> > > - TLBSRCH
> > > - TLBRD
> > > - TLBWR
> > > - TLBFILL
> > > - TLBCLR
> > > - TLBFLUSH
> > > - INVTLB
> >
> > Hi; running the loongarch functional tests on a build with
> > the clang undefined-behaviour sanitizer enabled reveals an
> > attempt to shift by an out-of-range amount in
> > helper_invtlb_page_asid_or_g():
> >
> > ../../target/loongarch/tcg/tlb_helper.c:470:31: runtime error: shift
> > exponent 244 is too large for 64-bit type 'uint64_t' (aka 'unsigned
> > long')
> > SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> > ../../target/loongarch/tcg/tlb_helper.c:470:31 in
> >
> > > +void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
> > > +                                  target_ulong info, target_ulong addr)
> > > +{
> > > +    uint16_t asid = info & 0x3ff;
> > > +
> > > +    for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
> > > +        LoongArchTLB *tlb = &env->tlb[i];
> > > +        uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> > > +        uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
> > > +        uint64_t vpn, tlb_vppn;
> > > +        uint8_t tlb_ps, compare_shift;
> > > +
> > > +        if (i >= LOONGARCH_STLB) {
> > > +            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> > > +        } else {
> > > +            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> > > +        }
> >
> > We read here a field from the guest, which can be 0.
> >
> > > +        tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
> > > +        vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
> > > +        compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
> >
> > If tlb_ps is 0, then "tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT"
> > is tlb_ps + 1 - 13 == tlb_ps - 12. When converted back to
> > uint8_t this is 244.
> >
> > > +
> > > +        if ((tlb_g || (tlb_asid == asid)) &&
> > > +            (vpn == (tlb_vppn >> compare_shift))) {
> >
> > Here we shift tlb_vppn by 244, which is undefined behaviour
> > and triggers the sanitizer.
> >
> > > +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
> > > +        }
> > > +    }
> > > +    tlb_flush(env_cpu(env));
> > > +}
> >
> > What's the intended behaviour here?
> >
> > This likely applies also to other similar functions; this
> > is just the one that I found.
> >
> > thanks
> > -- PMM

