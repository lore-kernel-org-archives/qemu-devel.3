Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A02C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 13:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAq5Q-0007Yz-L9; Fri, 02 May 2025 09:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAq5M-0007XE-LV
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:05:48 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAq5K-000491-ST
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:05:48 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6fead015247so18438037b3.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746191145; x=1746795945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U/RoE23ApTjqbVe27klDcTmtWofCycnun26HGiKmoRk=;
 b=U0a5B3GU5bd5K8PExcg1wGZgvzd1jxyFkZPIBesK2MDDn9pXFiMpFWfRZriBGfE8/S
 WOdkY4t/nlG7WoKbafuU6gTrA6+d3Sl7BM496nbFdKvMi1oHXAcrtsnYCg58dz904BQx
 4ObHpVSaUH309JUmCwsmHKeaSuXYsMA1izpAbD0VGmB3bYkF2zmEDHSZWt9vbJN9VrX/
 a9xkwqztfjAWiftmlkA41niqwI35KteK87fqXCzZyxPA2HdulCoHqLyBnrOyRFFdHm44
 FA9dLGUTv7wXX07nAf0sDsIPYgnBZvF2RAZfqQik63sus9p6zk90asoB1KGfo4YxpKTt
 Y4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746191145; x=1746795945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U/RoE23ApTjqbVe27klDcTmtWofCycnun26HGiKmoRk=;
 b=gHpvFLb+BrTiKxgeWtnTFN2/ycTUZ//aZPZDAIU8g11WGFdiAhEDtG+Z6Oc953oAYi
 U5hr48QPCAaUB/e4IOGEhqXx6KKUal14hTcP0gJ0/0D3VepKVG8+2EcOb1/3d8BdHkqE
 byhHhXjNMaj3Vp3o/BzsX6wj/UpILEHhCE6k8McKtsR6jF1Hdhx+1kllZVrJ0VHPNkfF
 bicQDtsmXFXOlIWjuDCXSX+Aps4RtXfw/q7zh35ndeewddoCVv423iMQqXy70k92ObBV
 WJfrGXOkL9GfUxJE9e7AoJu79Bdhhs+nbyJSimc1RPMG0SOsIbNQiFLWdKWa+g68ICxc
 RF4w==
X-Gm-Message-State: AOJu0YxrT8m/1cq2nKcNsdUXqy5p4g2x2bcEnUl16MvJY9tT0psvIAIR
 sXq3XkEnPEzlc0F2wJCYlptNDcwlnPHE6/Vnq/GpzbXIrwhWBHIP3GaF04+KJLWwKAFrqCqOBYc
 cqgmDSGlRXmXvaSSAs4nyUdojh7Oj4FoE8aDqig==
X-Gm-Gg: ASbGncvQwP2V00MDRhGen8hW6Kvq/5DYnAftVA54vGXpfdtWxDgPqhUefxA8nYZJKvq
 3HLBJ/ehanv3Ig7b8fMU+iWQjKHpYxadrcHlVBAn9vjMEt3H1/BFt5n2CoymNFQeLZivJPAPOsb
 Ly1xnO6fjj9GpLC4GofIioXuE=
X-Google-Smtp-Source: AGHT+IFVwNbgupiVHh1lPAipK/kOSgiFPgV3qiGulbNifcJJZE7uAcsoiPvh6mBwG7oA0j7TKZ7Owz+PZjlaxz5fq7o=
X-Received: by 2002:a05:690c:6f8f:b0:708:c1a5:ca4e with SMTP id
 00721157ae682-708ced3b02bmr45645537b3.13.1746191145686; Fri, 02 May 2025
 06:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
 <21843e8d-cdbc-4f84-a652-01ee467f2dc7@linaro.org>
In-Reply-To: <21843e8d-cdbc-4f84-a652-01ee467f2dc7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 14:05:33 +0100
X-Gm-Features: ATxdqUE8L9NTXDwVmgb6blgawlDUc9oYjm_w9bucKQJWH0eLXK3MklHJ12F7AWE
Message-ID: <CAFEAcA8cBUc_iJCA_D6ZDsJad75Rmad6xDz34FPXWrnyEhk4tg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] target/arm: fix arm_cpu_get_phys_page_attrs_debug
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org, 
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 28 Apr 2025 at 20:34, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 4/14/25 8:30 AM, Pierrick Bouvier wrote:
> > It was reported that QEMU monitor command gva2gpa was reporting unmapped
> > memory for a valid access (qemu-system-aarch64), during a copy from
> > kernel to user space (__arch_copy_to_user symbol in Linux) [1].
> > This was affecting cpu_memory_rw_debug also, which
> > is used in numerous places in our codebase. After investigating, the
> > problem was specific to arm_cpu_get_phys_page_attrs_debug.
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-discuss/2025-04/msg00013.html
> >
> > When performing user access from a privileged space, we need to do a
> > second lookup for user mmu idx, following what get_a64_user_mem_index is
> > doing at translation time.
> >
> > This series first extract some functions, and then perform the second lookup
> > expected using extracted functions.
> >
> > Besides running all QEMU tests, it was explicitely checked that during a linux
> > boot sequence, accesses now report a valid physical address inconditionnally
> > using this (non sent) patch:
> >
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -997,9 +997,7 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
> >       if (enable) {
> >           address |= flags & TLB_FLAGS_MASK;
> >           flags &= TLB_SLOW_FLAGS_MASK;
> > -        if (flags) {
> >               address |= TLB_FORCE_SLOW;
> > -        }
> >       } else {
> >           address = -1;
> >           flags = 0;
> > @@ -1658,6 +1656,10 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
> >           tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
> >       }
> >
> > +    vaddr page = addr & TARGET_PAGE_MASK;
> > +    hwaddr physaddr = cpu_get_phys_page_debug(cpu, page);
> > +    g_assert(physaddr != -1);
> > +
> >       full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
> >       flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
> >       flags |= full->slow_flags[access_type];
> >
> > v2:
> > - fix style in first commit (philmd)
> >
> > Pierrick Bouvier (4):
> >    target/arm/ptw: extract arm_mmu_idx_to_security_space
> >    target/arm/ptw: get current security_space for current mmu_idx
> >    target/arm/ptw: extract arm_cpu_get_phys_page
> >    target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
> >
> >   target/arm/ptw.c | 65 +++++++++++++++++++++++++++++++++++-------------
> >   1 file changed, 48 insertions(+), 17 deletions(-)
> >
>
> Gentle ping on this series.
> Any plan to queue it to tcg-next @Richard?

I've queued this series to target-arm.next; thanks.

-- PMM

