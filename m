Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223A6C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIYM-0005WT-H8; Wed, 26 Aug 2026 14:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wzIYL-0005WD-3T
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:40:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wzIYJ-0001uN-8l
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:40:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso9636185ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1787769645; x=1788374445; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2RwGYqKwDPFeCLcJXcwe93n5V0oqEi7xNMqQdcuMlfY=;
 b=B4X5ZMqyiOpsXK1qWJhixPdkc7eIQpSEuvBufQrybZ1MZyRIz9ZrIc0ftTkGCguCu8
 n81cE5QLdfy7GnInlR4HwEEjIIW4h3xQhOub5GGasQbokIMmWXKyVzuZW1lIIqJzKNBk
 cUxS8UZUz+MktYEwjJOIza13yAaOMsynGx0sgbL5KC3APUXOyw8c0oXtAaNv/P/Wemj4
 vsUncqsNsk8NtWasjmEXKnUZmmsVYGyT2IZUQHF4xqIaB7TqolIP5MxjY/7uwNY600zA
 phu0/HvJRL2reCcGkeDPJHVbU5x73gGcZHYfgwAL9gbhOxeuYK9GyUDqWW3ZY/DSQepI
 mlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769645; x=1788374445;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2RwGYqKwDPFeCLcJXcwe93n5V0oqEi7xNMqQdcuMlfY=;
 b=XsaSP5qS+3JnB4PXiT/tC6lSjZUhY0r3nBja0dobxcHAdZq8G/3cLixKNfMYtGvBVm
 z4FfAovpkfpPdJmz+cDTViPyfHwE0z7LRC9XkDb48US/IYUAXvo6HbDmXDpX9cerOduU
 NUCB7+KFn3n+gugkUtlgnRYIatMlh9bMYVupkHPptcbSclvwSb1UVE66lOpq9sq1wShW
 rMBJAO7CtCG0wGzkdVjDHsBRDiT54VBuPrbIj2rz/ZMZ/XUcZBXXK44hrQGwoN3amRoD
 HNwL3/ZQ6CwcV+s/pUxkcth1KoTRVip6/URTY/LqYQ+0nDqtBEN4BqfrP4n027pqPylT
 lW2w==
X-Gm-Message-State: AFuF++lfpimoSb4AqHlc2MFjUoy+Sp9vepASeuuZK83XjWPfy+77xKt8
 0vihmB4THDBKTW8+2y7ys2FtD3UrnLWXeqRi8bi9yygqoaOBkPGD/SDeFOspZzkALRg=
X-Gm-Gg: AR+sD11YC4Ve8E1g+/8JqDJPRzBW5Fro985gh8SdhDzPc1j/eJrabuPfgCWrXLsGjzL
 gkB5C6ddRASponJNm6imKAaZdChXva1DNWPCzv2ws7GAS7W09/PkPz1hNzUKILJnsAFZ71c5Mi1
 eHIYRxDsgvzTugBOeitxDUAAby17fYPfeWDxiiSweE9C5U4aqd4Ri8TcazQHA4NllgaItUiKLu9
 xL7+kU9at6xUXR8QThNdAaUjKPjqCeTjXbaR0c0kMkMVnAapEfclimbxBCaouk+Qii94bKBI/s5
 iX3SmsTfFgWx26rsDBYwGJZvjDvsU2tOPlU47Z4U9i8HceJ1b92QcIhD7ASkPXU2UBVUfYd1gnG
 Wf2hThyAjR/DgdcxdRJB3lsKzboSyVf4T063MlRfANXgX9cTkkMMxXtyMzOJsG8DwAkiul6y6RA
 4PxmbEdEriDIcQrJE5hyGNHKRLGiMlTddCsEwIgs92OLgX1RNhYk6O2cuxY0uT2/pVpl4YnOEGB
 m74voIrH7SVQ+kUb2mlMB0W/eEwqPMAYA==
X-Received: by 2002:a17:903:4b4b:b0:2d3:160b:c01f with SMTP id
 d9443c01a7336-2d707a8ebdfmr176203985ad.6.1787769645159; 
 Wed, 26 Aug 2026 11:40:45 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7049a18aesm10519175ad.32.2026.08.26.11.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:40:44 -0700 (PDT)
Date: Thu, 27 Aug 2026 02:40:41 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, frank.chang@sifive.com, qemu-riscv@nongnu.org
Subject: Re: [PATCH 11/23] target/riscv: Rewrite vext_ldff
Message-ID: <ao8wupCB3A-7-4-K@sifive.com>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-12-richard.henderson@linaro.org>
 <ao3JcPyrC7cZaCgp@sifive.com>
 <2db8ac0a-1b37-450d-8c11-2c5da46ca97a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2db8ac0a-1b37-450d-8c11-2c5da46ca97a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-08-25 13:15, Richard Henderson wrote:
> On 8/25/26 10:58, Max Chou wrote:
> 
> > On 2026-08-15 12:45, Richard Henderson wrote:
> > > Do not call probe_pages for every active element.
> > > We can make do with no more than 2 such calls for
> > > the two pages the insn might reference.
> > > 
> > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > +    /*
> > > +     * Test whether the first page is accessible.
> > > +     * If the first element is active, it must succeed.
> > > +     */
> > > +    flags = probe_access_flags(env, adjust_addr(env, addr),
> > > +                               MIN(last, last_in_page) - addr + 1,
> > > +                               MMU_DATA_LOAD, mmu_index, !first_active,
> > > +                               &host, ra);
> > Hi Richard,
> > 
> > This probe traverses every byte from the initial active element to the
> > end of the page, not just the bytes of active elements. In the masked
> > case, the range may encompass a masked-off element, and masked-off body
> > elements do not perform memory accesses.
> > I think it may causes unexpected vl.
> > 
> > > +    /* Get number of complete elements in the first page. */
> > > +    elems = MIN(page_split / msize, vl - i);
> > > +
> > > +    /* Load complete elements from the first page. */
> > > +    if (likely(elems)) {
> > > +        uint32_t page_evl = i + elems;
> > > +
> > > +        if (flags == 0) {
> > ...
> > > +        } else {
> > > +            /*
> > > +             * If the first element is active, it must succeed.
> > > +             * This will load from MMIO or fault from INVALID.
> > > +             */
> > > +            if (first_active) {
> > > +                vext_ldst_nf_tlb(env, vd, addr, 0, nf, esz,
> > > +                                 max_elems, ldst_tlb, ra);
> > > +                i = 1;
> > > +                addr += msize;
> > > +            }
> > > +
> > > +            /* Stop if invalid (unmapped) or mmio (transaction may fail). */
> > > +            if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
> > > +                env->vl = i;
> > > +                goto tail;
> > > +            }
> > > +
> > For an example, assume
> > - vl = 3
> > - vstart = 0
> > - the mask be [1, 0, 1]
> > - assume element 0 and element 2 be readable, but deny the byte at element 1
> > - all three elements are in the same target page.
> > 
> > In theory, the element 1 is masked off and doesn’t perform any memory
> > access, so the value of vl remains 3.
> > 
> > But the previous probe covers element 1 to 2 and the flags will be non
> > zero due to the denied masked-off element 2. Then the vl will set to 1
> > here.
> > 
> > Maybe we could switch to per element prob when vm is 0 and flags is not 0?
> 
> How are you going to deny the byte at element 1 to be unreadable?  Are you
> expecting this to be some PMP thing, with a 1 byte range?
> 
> How I expect things to work is that:
> 
>  (1) We scan forward for the first active element, set vstart.
> 
>  (2) Probe the page for that element.  If that faults, vstart is visible to
> the trap handler.
> 
>  (3) Discounting MMIO, all following elements in the same page cannot fault,
> and we can process them immediately.  Obviously inactive elements get vma
> handling not loads.
> 
Hi Richard,

Sorry, my previous example was unclear. It does not need a 1-byte PMP
region: RISC-V PMP definition allows the minimum 4-byte PMP region,
which exactly matches one e32 element.

For example, with vl=3, vstart=0, e32, and v0.mask = [1, 0, 1],
configure locked PMP entries as follows:

  PMP0: NA4   [base + 4, base + 7], L, ---    # element 1, no read
  PMP1: NAPOT target page,          L, R      # lower-priority page allow

  bytes:       base       base + 4     base + 8
               +-----+    +-----+      +-----+
  element:       0          1            2
  mask:          1          0            1
  access:     active      inactive      active
  PMP:        PMP1 R      PMP0 ---      PMP1 R

The RISC-V spec defines that masked vector loads access memory and raise
exceptions only for active elements.
Therefore this situation has reads only for elements 0 and 2; PMP0 must
not create an access-fault condition for this instruction.

My concern is that the page probe may be unsafe in some situations
because PMP permissions can change at 4-byte granularity inside a
target page, while the probe includes bytes which are not part of
active vector memory operations.

Maybe we could use the page probe only when it returns flags == 0,
and otherwise fall back to checking only active elements or active
runs?

I'm trying to create masked fauly-only-first + PMP test for this.

Thanks,

rnax

> I'm not sure I'm understanding your question properly...
> 
> 
> r~
> 

