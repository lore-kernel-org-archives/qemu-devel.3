Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFDCC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LoS-0006zy-S3; Fri, 26 Apr 2024 09:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0LoN-0006wL-Ei
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:40:23 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0LoL-0008DA-Oe
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:40:23 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-572229f196bso2712409a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714138820; x=1714743620; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DOykx7IdjFdFhCA3vyTGz07t+aLJmozQMUwmFjGwqOU=;
 b=QIU2hCxwqDaHvQ50WNWtpBDKG9gEdUqxCMr6Phh0NdtjKKRK3dn1WJwc3ipH0pCDPG
 UqEIx9ObZe2U8kT/saoFAgdp7+wB6JHKXwBv9zd3j2Ek1IZn0eilLtanxXlZhe0CAQ7b
 oz60kAFPtL3NDYsSiRil735vWPPuF2svh4kcBL2CppRBA1KYZdfJE6adM48goDoEiTi7
 gOxDJrzn1leY3PKlOia5PDngTigPg3/k+5NVBCzYsfoAV7/PG/GqTmY0SKMvpsLnYBj0
 jytxVKBEUNS6wqH3KQWpcapluw2De7iJr5u159ey7rXtbayU7pT/EpuOMzK3TAsuA9UZ
 myfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714138820; x=1714743620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DOykx7IdjFdFhCA3vyTGz07t+aLJmozQMUwmFjGwqOU=;
 b=alAyFExPtLTwQ2fTcZq/3kkViQjzcTl4Tm40rPf8LMVn0I9y1Z53G/U5oDXpaH8bXD
 S2Q1dXD8HOge/aaAPCDScnXuGBYPwllFK6R0BXLEVTrd0l7fTA0BMsUoD7BiOStDBpdx
 Z1W3aUkRf3ivEgPInmkkPNZ1RlO79UaqhoplxRghsu2BnfHxlLtwKnPI5Rk0nw6JO/MJ
 m6GV2o7Qu5LSkSUlksu9Hu75R3IUux7sJH1sH1j+RN4aFX8lKfQttyz26JJbEfJXrO3e
 hOCihLXdSO4nDC8HNHEqJxmyjgFLxmuDIdn5x2jyn3P7STpx0gOZL2aR7nv5bNcpR6f6
 A7nA==
X-Gm-Message-State: AOJu0Yw+qOHT87hhfWUPx3Axajwg2/6svuLQvGWVOwAsjFmkUjz8Pu8S
 MALzk5ynFJzOeRCql80/ziiOjCD408kU7GscvAD+6gg2l9aEGvVeQuZpqod/4fp4+VfV1r4tACq
 gXpKjN2zn4cef8ji9Mxce/gS/AHer6oVV5JbzSQ==
X-Google-Smtp-Source: AGHT+IG5qpeUCBJgC3kjpyigzIPCU/Ergjo9zNUC2y57Ty3APbvTDPGUSz+dMyzXCK6PHKp+gQnJhPH1Lcwkqf6eDTY=
X-Received: by 2002:a05:6402:1bdd:b0:572:5fff:accd with SMTP id
 ch29-20020a0564021bdd00b005725fffaccdmr311727edb.6.1714138819802; Fri, 26 Apr
 2024 06:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-56-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-56-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2024 14:40:09 +0100
Message-ID: <CAFEAcA9SFtGDu2Xhna3tEqnWcGbfNW-uxhQqdxoTq=SN56eh=A@mail.gmail.com>
Subject: Re: [PULL 55/63] kvm: handle KVM_EXIT_MEMORY_FAULT
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 23 Apr 2024 at 16:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Upon an KVM_EXIT_MEMORY_FAULT exit, userspace needs to do the memory
> conversion on the RAMBlock to turn the memory into desired attribute,
> switching between private and shared.
>
> Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
> KVM_EXIT_MEMORY_FAULT happens.
>
> Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
> guest_memfd memory backend.
>
> Note, KVM_EXIT_MEMORY_FAULT returns with -EFAULT, so special handling is
> added.
>
> When page is converted from shared to private, the original shared
> memory can be discarded via ram_block_discard_range(). Note, shared
> memory can be discarded only when it's not back'ed by hugetlb because
> hugetlb is supposed to be pre-allocated and no need for discarding.
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>
> Message-ID: <20240320083945.991426-13-michael.roth@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity points out an issue with this code (CID 1544114):



> +int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +{
> +    MemoryRegionSection section;
> +    ram_addr_t offset;

offset here is not initialized...

> +    MemoryRegion *mr;
> +    RAMBlock *rb;
> +    void *addr;
> +    int ret = -1;
> +
> +    trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
> +
> +    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
> +        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
> +        return -1;
> +    }
> +
> +    if (!size) {
> +        return -1;
> +    }
> +
> +    section = memory_region_find(get_system_memory(), start, size);
> +    mr = section.mr;
> +    if (!mr) {
> +        return -1;
> +    }
> +
> +    if (!memory_region_has_guest_memfd(mr)) {
> +        error_report("Converting non guest_memfd backed memory region "
> +                     "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
> +                     start, size, to_private ? "private" : "shared");
> +        goto out_unref;
> +    }
> +
> +    if (to_private) {
> +        ret = kvm_set_memory_attributes_private(start, size);
> +    } else {
> +        ret = kvm_set_memory_attributes_shared(start, size);
> +    }
> +    if (ret) {
> +        goto out_unref;
> +    }
> +
> +    addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
> +    rb = qemu_ram_block_from_host(addr, false, &offset);

...and this call to qemu_ram_block_from_host() will only initialize
offset if it does not fail (i.e. doesn't return NULL)...

> +
> +    if (to_private) {
> +        if (rb->page_size != qemu_real_host_page_size()) {

...but here we assume rb is not NULL...

> +            /*
> +             * shared memory is backed by hugetlb, which is supposed to be
> +             * pre-allocated and doesn't need to be discarded
> +             */
> +            goto out_unref;
> +        }
> +        ret = ram_block_discard_range(rb, offset, size);
> +    } else {
> +        ret = ram_block_discard_guest_memfd_range(rb, offset, size);

...and here we use offset assuming it has been initialized.

I think this code should either handle the case where
qemu_ram_block_from_host() fails, or, if it is impossible
for it to fail in this situation, add an assert() and a
comment about why we know it can't fail.

> +    }
> +
> +out_unref:
> +    memory_region_unref(mr);
> +    return ret;
> +}

thanks
-- PMM

