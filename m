Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0057D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvOA-0006PL-I9; Tue, 26 Nov 2024 08:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFvO8-0006P2-PN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:13:56 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFvO7-0002oN-1a
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:13:56 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so349541766b.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626833; x=1733231633; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7GcTrgrZgalcOcDPaQq+DD6nSKkFOgl+FWMy8ASgiWY=;
 b=YX/w4VRqwaAtnTs+BTjuG/eS5LZlU2Rx53aRE+EM8rvV4MG3Aq6+q11VMdTgDg6ri0
 lQ16Fuulsk64fEIFabWReM1xWXNrmDdlqYare2ZHKeYtE/4BbI/Q9zer12nS86mLHS7i
 CeQ6dQP09EqaZrG/NoYCwqRYTXaAj8F6S1lXFd73c4lvuH2tIurN1BhOmnSOMwEerimS
 L2vugJshs24khJ6hTR/eQIxiRzXTao3mi+Vi285A3aDk0uyUaAdPIbwOKesNfHwPwxRl
 3ZcfOcFCwWe6FcEPJd5iWtAnVNAVHV0zKNw/AG8wJ0R7ttCPux3iHPTgrE3brpgX2e07
 i8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626833; x=1733231633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GcTrgrZgalcOcDPaQq+DD6nSKkFOgl+FWMy8ASgiWY=;
 b=SQPMyle73fnR1XdtYMd2E2LR5Bt3GWrTr8h/ocwyi2oY8v5EgYo5C/4V5pQqyFDL8m
 dRKkaN9KCtLpsuXZjMBu5bIfdM+zQ3vxsM0E4gDNWxWwbpO/HYC+Z+psXbwWJUqWjbfg
 6SxfgEYXAAJiDmaytEZAB4DZ7N/wz/Ndg273/GumQXOsvCe7ZcAgQQUhDOsO1gr4IqFe
 Re7qfVvSDD4AQ6Igx2a96yHU8nvf6FwsESx8W4NolxYZmnLFd2ux8Kq/5pJc9LFgH9xT
 /ZW8wn0VzKOW5xPqhv0PYaCxRak1sXPFkGsf0RMoD2IC6pKNcz5iyV+pkxkfq9JOBpTZ
 b0iw==
X-Gm-Message-State: AOJu0YzcBUZrBWF7ERcjuuw7l95pf36yr9XIwVcUu9JK64co53ui3dkT
 5OCauSntwVtdtfa4kjF+2Tz3JgMi1HLjiZeQuDy9e815WuVWnw8LIIK8I4GAe6hWoEpzfXohMiU
 5xXdMS+wf18Jqb4p/kxNnekr1zjzwnYsz9fVSVQ==
X-Gm-Gg: ASbGncuGJLxi3GTaZgYRM7Cf64mNVavyPpjRua4L4qGqsuCWoKWG/w3B7m/b2YHKc7A
 PjoX8vrfSlQa9EX+GoD07v78c/zoOiplD
X-Google-Smtp-Source: AGHT+IGao98j5R5nNxTH2UK8/ct2x1iRYq/0xkkdFvJNzMAIQZc9bpg4SJX3OPeI1QTEcHylZQpCG363F/WUS43BmSI=
X-Received: by 2002:a05:6402:35c4:b0:5cf:abc9:2e59 with SMTP id
 4fb4d7f45d1cf-5d02060b02amr14603323a12.1.1732626832977; Tue, 26 Nov 2024
 05:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20220606231450.448443-1-richard.henderson@linaro.org>
 <20220606231450.448443-28-richard.henderson@linaro.org>
 <CAFEAcA8ccgyLQPMykDQGjK5qc-etEBrsy0qGo+8mq-2_nCDDFg@mail.gmail.com>
In-Reply-To: <CAFEAcA8ccgyLQPMykDQGjK5qc-etEBrsy0qGo+8mq-2_nCDDFg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 13:13:42 +0000
Message-ID: <CAFEAcA8mHTYoY8C-KJ0BFJ6JR3BgRA0ZPjZKDyPjOGVEJ+RFvQ@mail.gmail.com>
Subject: Re: [PULL 27/43] target/loongarch: Add TLB instruction support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =gaosong@loongson.cn, yangxiaojuan@loongson.cn, 
 Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

Ping regarding this UB due to an invalid shift --
I think this is now the only remaining sanitizer error
in a 'make check-functional', so it would be nice to get
it fixed...

thanks
-- PMM

On Thu, 7 Nov 2024 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 7 Jun 2022 at 00:31, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > From: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> >
> > This includes:
> > - TLBSRCH
> > - TLBRD
> > - TLBWR
> > - TLBFILL
> > - TLBCLR
> > - TLBFLUSH
> > - INVTLB
>
> Hi; running the loongarch functional tests on a build with
> the clang undefined-behaviour sanitizer enabled reveals an
> attempt to shift by an out-of-range amount in
> helper_invtlb_page_asid_or_g():
>
> ../../target/loongarch/tcg/tlb_helper.c:470:31: runtime error: shift
> exponent 244 is too large for 64-bit type 'uint64_t' (aka 'unsigned
> long')
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../target/loongarch/tcg/tlb_helper.c:470:31 in
>
> > +void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
> > +                                  target_ulong info, target_ulong addr)
> > +{
> > +    uint16_t asid = info & 0x3ff;
> > +
> > +    for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
> > +        LoongArchTLB *tlb = &env->tlb[i];
> > +        uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> > +        uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
> > +        uint64_t vpn, tlb_vppn;
> > +        uint8_t tlb_ps, compare_shift;
> > +
> > +        if (i >= LOONGARCH_STLB) {
> > +            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> > +        } else {
> > +            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> > +        }
>
> We read here a field from the guest, which can be 0.
>
> > +        tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
> > +        vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
> > +        compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
>
> If tlb_ps is 0, then "tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT"
> is tlb_ps + 1 - 13 == tlb_ps - 12. When converted back to
> uint8_t this is 244.
>
> > +
> > +        if ((tlb_g || (tlb_asid == asid)) &&
> > +            (vpn == (tlb_vppn >> compare_shift))) {
>
> Here we shift tlb_vppn by 244, which is undefined behaviour
> and triggers the sanitizer.
>
> > +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
> > +        }
> > +    }
> > +    tlb_flush(env_cpu(env));
> > +}
>
> What's the intended behaviour here?
>
> This likely applies also to other similar functions; this
> is just the one that I found.
>
> thanks
> -- PMM

