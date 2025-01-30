Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60436C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 08:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdPZ4-0006y4-Ls; Thu, 30 Jan 2025 03:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdPZ2-0006xa-U8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 03:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdPZ0-0003O8-Mj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 03:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738224372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vU+nrQM1U+RMZa/EGBANTdwIWta1F0ZMP6w54UmnOsQ=;
 b=fLSn2NoWUfhLbL+pEvQNoPfoMmciCN22ySFV5ji1PUfhFaOC/a05Fh1NRU4VsrWq27BT5r
 6IAPduuvcMKF9W4/skJp2mVcLf2fxgTNw1d5HahK47Cadp+Nd5PYfPbmIKb5bYUx1OhI6s
 AMga8og4NkT361PHwV4dGLowwgHv3uM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-dHhPt6PZMl6JkSrvqVZbRg-1; Thu, 30 Jan 2025 03:06:10 -0500
X-MC-Unique: dHhPt6PZMl6JkSrvqVZbRg-1
X-Mimecast-MFC-AGG-ID: dHhPt6PZMl6JkSrvqVZbRg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38bf4913659so317980f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 00:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738224367; x=1738829167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vU+nrQM1U+RMZa/EGBANTdwIWta1F0ZMP6w54UmnOsQ=;
 b=RYwQKxjWKOOFycd7DFME6JJq/+vXwtit24hboYAEBcCLbTSghhNifOTSbDvlkSUnJf
 WmiJLR3xrHb6T5bS4cCRLbj/yiC+RZX4wi8wo0ENwPzXRZ4lMAswQkpJoP2LxwRC9Zzh
 iVI/XmUd4d2M9+OVjAJCGHjsoIGBhK6pAdtD7BuIUA727O3MWOB3+V/siL9JiAR8ci4o
 2z39dMDUIKXerlgV2cJa2csXCScC37lvY/bnprnYyYDZt9CzNo7sUoDxmMO1YHJ/7c59
 a6IqxU4re6cXupEB+GYiU+Uc/WKKYlhlTOdv1W4tUJyL7L0MhbL8P0J9KVOceziS7ujw
 ok6g==
X-Gm-Message-State: AOJu0Yykuf+oRiYFBwHRRGfDQJtppBFe1R2BkNUo0UWQPqepGq1NeZr8
 n0MNGM6n+BI4tpA+Z6rdcuJI7poR5NWRJ5JJtjCV5bxZPwmb/GflEY/BdRWLhgqDAbEtfWi9pVm
 ZjbPk2t5ZUtkrOC62E3rblBWbWlIIqKRpVA3CctgW3zG7XmilDem9YYbnz5Ce
X-Gm-Gg: ASbGncvFrC+zk1ZWCQm1OQlfxp5cqXL3pGGUQsB4H0Hpu3oQGBP3IXUppIdEtZpNx9h
 s551buR8N4xik8p4BM/r7jtu8NP/C2w80XzRFTrl7VgMT0CSwwt+UD1YxD2aYq8mNaiUTxDlqcq
 +ZKY34GvNsvezBKZPSem8EXjpmiWG3m+GWGuI6ot5CODEyGpBoNAx3Cpeawmk9M785uvJ03BXnk
 OuhIWa7A+LPlos7BiRM63Qbj0sSSsqYrRoSOm6+77uXTtRlTrr5bq8M/CDGpp/vsmuhsCohgbuZ
 n/zUPMpzTWxqx8613DBMghzWa2R9Ay4EoVwDQ70vozr2v/oQQW/i
X-Received: by 2002:adf:fbca:0:b0:385:f6b9:e762 with SMTP id
 ffacd0b85a97d-38c5209716amr3151409f8f.36.1738224367235; 
 Thu, 30 Jan 2025 00:06:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUIFjKOPxh0M6aDbInSbYtLIhrQKdcTWdeIJjjvBOsG3kVZj0yANz0SPCDLIed/wYlqdMmew==
X-Received: by 2002:adf:fbca:0:b0:385:f6b9:e762 with SMTP id
 ffacd0b85a97d-38c5209716amr3151379f8f.36.1738224366773; 
 Thu, 30 Jan 2025 00:06:06 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6de7csm50132175e9.32.2025.01.30.00.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 00:06:06 -0800 (PST)
Date: Thu, 30 Jan 2025 09:06:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, imp@bsdimp.com,
 kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu,
 npiggin@gmail.com
Subject: Re: [PATCH 5/6] Revert "tcg/cputlb: remove other-cpu capability
 from TLB flushing"
Message-ID: <20250130090604.6251d084@imammedo.users.ipa.redhat.com>
In-Reply-To: <82142340-a80e-49f0-8e45-aa043932e026@eik.bme.hu>
References: <20250129134436.1240740-1-imammedo@redhat.com>
 <20250129134436.1240740-6-imammedo@redhat.com>
 <82142340-a80e-49f0-8e45-aa043932e026@eik.bme.hu>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 29 Jan 2025 19:33:30 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Wed, 29 Jan 2025, Igor Mammedov wrote:
> > 1)
> > This reverts commit 30933c4fb4f3df95ae44c4c3c86a5df049852c01.
> >  ("tcg/cputlb: remove other-cpu capability from TLB flushing")
> >
> > The commit caused a regression which went unnoticed due to
> > affected being disabled by default (DEBUG_TLB_GATE 0)
> > Previous patch moved switched to using tcg_debug_assert() so that  
> 
> The verb "moved" not needed and left from editing?
yep, I'll fix it up in case of respin


> 
> Regards,
> BALATON Zoltan
> 
> > at least on debug builds assert_cpu_is_self() path would be exercised.
> >
> > And that lead to exposing regression introduced by [1] with abort during tests.
> > to reproduce:
> >  $ configure  --target-list=x86_64-softmmu --enable-debug
> >  $ make && ./qemu-system-x86_64
> >
> >  accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx:
> >    Assertion `!(cpu)->created || qemu_cpu_is_self(cpu)' failed.
> >
> > which is triggered by usage outside of cpu thread:
> >    x86_cpu_new -> ... ->
> >      x86_cpu_realizefn -> cpu_reset -> ... ->
> >          tcg_cpu_reset_hold
> >
> > Drop offending commit for now, until a propper fix that doesn't break
> > 'make check' is available.
> >
> > PS:
> > fixup g_memdup() checkpatch error s/g_memdup/g_memdup2/
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > I'll leave it upto TCG folz to fix it up propperly.
> >
> > CC: npiggin@gmail.com
> > CC: richard.henderson@linaro.org
> > ---
> > accel/tcg/cputlb.c | 42 +++++++++++++++++++++++++++++++++---------
> > 1 file changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 71207d6dbf..db1713b3ca 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -416,9 +416,12 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
> > {
> >     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
> >
> > -    assert_cpu_is_self(cpu);
> > -
> > -    tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
> > +    if (cpu->created && !qemu_cpu_is_self(cpu)) {
> > +        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
> > +                         RUN_ON_CPU_HOST_INT(idxmap));
> > +    } else {
> > +        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
> > +    }
> > }
> >
> > void tlb_flush(CPUState *cpu)
> > @@ -607,12 +610,28 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
> > {
> >     tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
> >
> > -    assert_cpu_is_self(cpu);
> > -
> >     /* This should already be page aligned */
> >     addr &= TARGET_PAGE_MASK;
> >
> > -    tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
> > +    if (qemu_cpu_is_self(cpu)) {
> > +        tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
> > +    } else if (idxmap < TARGET_PAGE_SIZE) {
> > +        /*
> > +         * Most targets have only a few mmu_idx.  In the case where
> > +         * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
> > +         * allocating memory for this operation.
> > +         */
> > +        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
> > +                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
> > +    } else {
> > +        TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
> > +
> > +        /* Otherwise allocate a structure, freed by the worker.  */
> > +        d->addr = addr;
> > +        d->idxmap = idxmap;
> > +        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_2,
> > +                         RUN_ON_CPU_HOST_PTR(d));
> > +    }
> > }
> >
> > void tlb_flush_page(CPUState *cpu, vaddr addr)
> > @@ -775,8 +794,6 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
> > {
> >     TLBFlushRangeData d;
> >
> > -    assert_cpu_is_self(cpu);
> > -
> >     /*
> >      * If all bits are significant, and len is small,
> >      * this devolves to tlb_flush_page.
> > @@ -797,7 +814,14 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
> >     d.idxmap = idxmap;
> >     d.bits = bits;
> >
> > -    tlb_flush_range_by_mmuidx_async_0(cpu, d);
> > +    if (qemu_cpu_is_self(cpu)) {
> > +        tlb_flush_range_by_mmuidx_async_0(cpu, d);
> > +    } else {
> > +        /* Otherwise allocate a structure, freed by the worker.  */
> > +        TLBFlushRangeData *p = g_memdup2(&d, sizeof(d));
> > +        async_run_on_cpu(cpu, tlb_flush_range_by_mmuidx_async_1,
> > +                         RUN_ON_CPU_HOST_PTR(p));
> > +    }
> > }
> >
> > void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
> >  
> 


