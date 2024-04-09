Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A604C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5cK-0002IQ-Uv; Tue, 09 Apr 2024 03:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru5cI-0002I1-MM
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru5cA-0005G2-Kp
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712646593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5x1BvlVpqsGESa79/ms1EWX0uF6V5BqFXrekY2uLdi4=;
 b=JxjT3pchu66SHNwQJrP7aixTa2BHPI8lBdpMIZ32RKsH3oeqCSSHV+bpWMbNTDzqZBauX5
 8c1rECeIBknXtydxedRK8s/9zOuFYkhvhrKpUdxmQw+Uw42sFCBamPHvPEbHoe2ho4hIsM
 zIlMnf1bEBqkrMS8/NV+0LK7cDqLpRc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-FkFIf398Oxe50h4XZBW87A-1; Tue, 09 Apr 2024 03:09:51 -0400
X-MC-Unique: FkFIf398Oxe50h4XZBW87A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-515af96a73bso3420146e87.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712646590; x=1713251390;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5x1BvlVpqsGESa79/ms1EWX0uF6V5BqFXrekY2uLdi4=;
 b=wsjfefTBo9D66Ksr6tOgGW1RwYiB5oQRkRjAuDUOEhdnSkABtYatzznmfLAsOT1HNf
 z+UPsXTnjc2MuA1RI660kVB37SWk/E+2z5/YRaHtQEImkvcZCbYBFAl1Cfwb8ajK0Bnp
 FJziOy4jomxDC4O97asVlhlPdAqOl534Rnlwnle8E1zs74QOOTpLdbmF7jsc1Lzztpsl
 lZyIJ6NxUHdFf4Q/CkWDFvkGpu+ayFhvazsgcdQd5vXa75xbEiVWPcRiqVT0dTUg8Syh
 311FswyTXARM0WP+/taStsj4V3nLtjowLM2C8anPVwjUy7Mndd8Dii09IcOhtIufN6gh
 umQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1KpzvIebvKU0ElzFhzbqTLeZdrE3kG7Pc6uhdkZO9rC2b9wt0pLlu16NvZ8dE8Y+DKqhrpc3qWVGXAnWhK6Q7W7duf5I=
X-Gm-Message-State: AOJu0YwRcbw6Trvy8UEEoNZFFhdqZoiE+sK5MVqUq2jDUPzPD/mXI4Wk
 sYad0r/SLxMRF9wlXGPSIfz1Nl6OxM2uBs5DSd5PE6G9ViZETchF0N1qJ/xhw2G9el9nG5Prf+h
 dUCBl5JfdxQHba7D3euCKPS/Hmktm64G/qB0h5lgeW/Z7nkqp8UPq
X-Received: by 2002:ac2:4884:0:b0:515:c43e:19c6 with SMTP id
 x4-20020ac24884000000b00515c43e19c6mr7659835lfc.23.1712646590038; 
 Tue, 09 Apr 2024 00:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Kejpb8Ae4GIpLs2O6Ra9tlzppfzjIoyslhk88DZKGDlvtwvF2SDEYbciw5fGrLd1tN68kA==
X-Received: by 2002:ac2:4884:0:b0:515:c43e:19c6 with SMTP id
 x4-20020ac24884000000b00515c43e19c6mr7659820lfc.23.1712646589568; 
 Tue, 09 Apr 2024 00:09:49 -0700 (PDT)
Received: from [192.168.10.4] ([151.95.152.232])
 by smtp.googlemail.com with ESMTPSA id
 s11-20020a05600c45cb00b004162d06768bsm16862736wmo.21.2024.04.09.00.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 00:09:49 -0700 (PDT)
Message-ID: <c009e60a-1445-4064-943a-cd7eeb843132@redhat.com>
Date: Tue, 9 Apr 2024 09:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/28] target/i386: Add tcg/access.[ch]
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
 <20240409050302.1523277-2-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240409050302.1523277-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/9/24 07:02, Richard Henderson wrote:
> Provide a method to amortize page lookup across large blocks.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/access.h    |  40 +++++++++
>   target/i386/tcg/access.c    | 160 ++++++++++++++++++++++++++++++++++++
>   target/i386/tcg/meson.build |   1 +
>   3 files changed, 201 insertions(+)
>   create mode 100644 target/i386/tcg/access.h
>   create mode 100644 target/i386/tcg/access.c
> 
> diff --git a/target/i386/tcg/access.h b/target/i386/tcg/access.h
> new file mode 100644
> index 0000000000..d70808a3a3
> --- /dev/null
> +++ b/target/i386/tcg/access.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Access guest memory in blocks. */
> +
> +#ifndef X86_TCG_ACCESS_H
> +#define X86_TCG_ACCESS_H
> +
> +/* An access covers at most sizeof(X86XSaveArea), at most 2 pages. */
> +typedef struct X86Access {
> +    target_ulong vaddr;
> +    void *haddr1;
> +    void *haddr2;
> +    uint16_t size;
> +    uint16_t size1;
> +    /*
> +     * If we can't access the host page directly, we'll have to do I/O access
> +     * via ld/st helpers. These are internal details, so we store the rest
> +     * to do the access here instead of passing it around in the helpers.
> +     */
> +    int mmu_idx;
> +    CPUX86State *env;
> +    uintptr_t ra;
> +} X86Access;
> +
> +void access_prepare_mmu(X86Access *ret, CPUX86State *env,
> +                        vaddr vaddr, unsigned size,
> +                        MMUAccessType type, int mmu_idx, uintptr_t ra);
> +void access_prepare(X86Access *ret, CPUX86State *env, vaddr vaddr,
> +                    unsigned size, MMUAccessType type, uintptr_t ra);
> +
> +uint8_t  access_ldb(X86Access *ac, vaddr addr);
> +uint16_t access_ldw(X86Access *ac, vaddr addr);
> +uint32_t access_ldl(X86Access *ac, vaddr addr);
> +uint64_t access_ldq(X86Access *ac, vaddr addr);
> +
> +void access_stb(X86Access *ac, vaddr addr, uint8_t val);
> +void access_stw(X86Access *ac, vaddr addr, uint16_t val);
> +void access_stl(X86Access *ac, vaddr addr, uint32_t val);
> +void access_stq(X86Access *ac, vaddr addr, uint64_t val);
> +
> +#endif
> diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
> new file mode 100644
> index 0000000000..8b70f3244b
> --- /dev/null
> +++ b/target/i386/tcg/access.c
> @@ -0,0 +1,160 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Access guest memory in blocks. */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/exec-all.h"
> +#include "access.h"
> +
> +
> +void access_prepare_mmu(X86Access *ret, CPUX86State *env,
> +                        vaddr vaddr, unsigned size,
> +                        MMUAccessType type, int mmu_idx, uintptr_t ra)
> +{
> +    int size1, size2;
> +    void *haddr1, *haddr2;
> +
> +    assert(size > 0 && size <= TARGET_PAGE_SIZE);
> +
> +    size1 = MIN(size, -(vaddr | TARGET_PAGE_MASK)),
> +    size2 = size - size1;
> +
> +    memset(ret, 0, sizeof(*ret));
> +    ret->vaddr = vaddr;
> +    ret->size = size;
> +    ret->size1 = size1;
> +    ret->mmu_idx = mmu_idx;
> +    ret->env = env;
> +    ret->ra = ra;
> +
> +    haddr1 = probe_access(env, vaddr, size1, type, mmu_idx, ra);
> +    ret->haddr1 = haddr1;
> +
> +    if (unlikely(size2)) {
> +        haddr2 = probe_access(env, vaddr + size1, size2, type, mmu_idx, ra);
> +        if (haddr2 == haddr1 + size1) {
> +            ret->size1 = size;
> +        } else {
> +            ret->haddr2 = haddr2;
> +        }
> +    }

Should there be an assert(!ret->haddr2) here for the CONFIG_USER_ONLY 
case, or alternatively a g_assert_unreachable() in the "else" above?

> +}
> +
> +void access_prepare(X86Access *ret, CPUX86State *env, vaddr vaddr,
> +                    unsigned size, MMUAccessType type, uintptr_t ra)
> +{
> +    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +    access_prepare_mmu(ret, env, vaddr, size, type, mmu_idx, ra);
> +}
> +
> +static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
> +{
> +    vaddr offset = addr - ac->vaddr;
> +
> +    assert(addr >= ac->vaddr);
> +
> +#ifdef CONFIG_USER_ONLY
> +    assert(offset <= ac->size1 - len);
> +    return ac->haddr1 + offset;
> +#else
> +    if (likely(offset <= ac->size1 - len)) {
> +        return ac->haddr1;
> +    }
> +    assert(offset <= ac->size - len);
> +    if (likely(offset >= ac->size1)) {
> +        return ac->haddr2;
> +    }

I think the returns should be (respectively) ac->haddr1 + offset and 
ac->haddr2 + (offset - ac->size1)?

Also I would add a comment above the second "if", like

     /*
      * If the address is not naturally aligned, it might span
      * both pages.  Only return ac->haddr2 if the area is
      * entirely within the second page, otherwise fall back
      * to slow accesses.
      */

Paolo

> +uint8_t access_ldb(X86Access *ac, vaddr addr)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint8_t));
> +
> +    if (test_ptr(p)) {
> +        return ldub_p(p);
> +    }
> +    return cpu_ldub_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
> +}
> +
> +uint16_t access_ldw(X86Access *ac, vaddr addr)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint16_t));
> +
> +    if (test_ptr(p)) {
> +        return lduw_le_p(p);
> +    }
> +    return cpu_lduw_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
> +}
> +
> +uint32_t access_ldl(X86Access *ac, vaddr addr)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint32_t));
> +
> +    if (test_ptr(p)) {
> +        return ldl_le_p(p);
> +    }
> +    return cpu_ldl_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
> +}
> +
> +uint64_t access_ldq(X86Access *ac, vaddr addr)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint64_t));
> +
> +    if (test_ptr(p)) {
> +        return ldq_le_p(p);
> +    }
> +    return cpu_ldq_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
> +}
> +
> +void access_stb(X86Access *ac, vaddr addr, uint8_t val)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint8_t));
> +
> +    if (test_ptr(p)) {
> +        stb_p(p, val);
> +    } else {
> +        cpu_stb_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
> +    }
> +}
> +
> +void access_stw(X86Access *ac, vaddr addr, uint16_t val)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint16_t));
> +
> +    if (test_ptr(p)) {
> +        stw_le_p(p, val);
> +    } else {
> +        cpu_stw_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
> +    }
> +}
> +
> +void access_stl(X86Access *ac, vaddr addr, uint32_t val)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint32_t));
> +
> +    if (test_ptr(p)) {
> +        stl_le_p(p, val);
> +    } else {
> +        cpu_stl_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
> +    }
> +}
> +
> +void access_stq(X86Access *ac, vaddr addr, uint64_t val)
> +{
> +    void *p = access_ptr(ac, addr, sizeof(uint64_t));
> +
> +    if (test_ptr(p)) {
> +        stq_le_p(p, val);
> +    } else {
> +        cpu_stq_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
> +    }
> +}
> diff --git a/target/i386/tcg/meson.build b/target/i386/tcg/meson.build
> index f9110e890c..1105b35d92 100644
> --- a/target/i386/tcg/meson.build
> +++ b/target/i386/tcg/meson.build
> @@ -1,4 +1,5 @@
>   i386_ss.add(when: 'CONFIG_TCG', if_true: files(
> +  'access.c',
>     'bpt_helper.c',
>     'cc_helper.c',
>     'excp_helper.c',


