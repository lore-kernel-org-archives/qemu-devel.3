Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E31C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1EL-0003XL-8s; Tue, 11 Mar 2025 11:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1EJ-0003QH-Iq
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:09:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1EH-0002ha-Lj
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:09:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so17197765ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741705752; x=1742310552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qBzq3gZ4RElKkwYhaj8ZNxHgJX2I6SVrzxCcg9CG9Dw=;
 b=wjlmlzKp5Lqfyz80oXj2VUyp/m+KGX9AeznsG6u8PirXZY37kqyBI+jK3/mhXOP7Zb
 SxZgY5UagtY1Vv6tlznCuNdD+qI9KU66/4S3JopNVotdznNka8f0j8ohdZh0x4+wo7rX
 /Ky33ZPlL3EcKJLLs+dP4krPfdf/Z4Pr/Nr4OV7NZUI+f+jLUR5j+gVpiAZpHvSujur5
 O/4n2n3DyjhvEE/SM11ACs2hnx+eO8g5ntOXnRwE2gXCWYKzCUbQhnSMzpZ32oBm/MBA
 8dvyB1MH5ez5xkdzC0KfVECx99w1R3248fcLIjV4hrnA8WJ1l7pdYjmzUWEMgs5Q0+/2
 LfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741705752; x=1742310552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qBzq3gZ4RElKkwYhaj8ZNxHgJX2I6SVrzxCcg9CG9Dw=;
 b=l7QL1N1poerL7bwHcr5XaxDP1ZrL1EgYbV/5X8fUXJEWLf9s8iz1v6HXLKaCqAHDI8
 5A56qwz+64g4mRwNCjFVAYasnf2yKNSxh7jR2IJz8zPf6+wKwEJGnpULarK25w15Xeel
 UHk7kT167RFeBTdjdFqUwpHhZ1njcO1hziK0b3GGabsBxO6n3ndYwB2HeEG8Ds7qwAxy
 zIqYvEFMuDfnw5+TheDZk9/Mw17COLMGih63e9lQLvd5Qi/Pfoqg4PBM4vxSr7295JDS
 QYjPV7kXYRxnjnMtU3XT0FZmL1sZJJ1QnEOnIqeXglUrPujFnQETYu18+5QkoKRr+v24
 zzkA==
X-Gm-Message-State: AOJu0YxHhQOA359BQhpSeJQ6+c5gcXrGZtCDF9zxJHwi+h2f2cq679CC
 y7QVFUoxs6NWtI8g177NU3OmiX0xGAgGOlpqj1IgAQzzLVAtQDV3KHk1fOK+OoFc/7pEinoRmTv
 FfIE=
X-Gm-Gg: ASbGncuHCrlVFCzpMze2lCnNadU9WeZjBTgvcqztBigwaNVHhFyLqPxiuCSLRuZP/4r
 dmwSpwyKGdknF0eO3qGYBphrzNknFHLWbsZaTyU2U92lO4jKBFMu2nQ9LS5l9vjan5Alyb1Wvwc
 YfpeBSU4cl8ET0ZQStAKds+Z4gi5zt0VrfnCue22bA1Gqd8c1ZrKY2drobcFIurvRqXVDt/7bBA
 54kpboew7xUljR0eKz76JXTNQPZSHJPyfpuESBmU2OcAzXvdeMF1WovxymQQUJ0lf8WF5tYp/dM
 1Yv7i1V4+HxFlclxFTz7V8ldzkwROTorE8oS4outLP7FIz08ZgysDFFgcQ==
X-Google-Smtp-Source: AGHT+IHdtXZCBvbhA4fnw5TeglBYyYnfR3rHysBoeOpLSs+t9AWpL5KS2rwpMgVJc9S6ANeeel2twg==
X-Received: by 2002:a05:6a00:2e17:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-736aa9e745amr29105632b3a.3.1741705752226; 
 Tue, 11 Mar 2025 08:09:12 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b3f2412csm8273161b3a.175.2025.03.11.08.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:09:11 -0700 (PDT)
Message-ID: <437c66f2-b2f5-42dd-a266-581997d90581@linaro.org>
Date: Tue, 11 Mar 2025 08:09:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] exec/memory_ldst: extract memory_ldst
 declarations from cpu-all.h
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-4-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250311040838.3937136-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/10/25 21:08, Pierrick Bouvier wrote:
> They are now accessible through exec/memory.h instead, and we make sure
> all variants are available for common or target dependent code.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h         | 12 ------------
>   include/exec/memory_ldst.h.inc |  4 ----
>   2 files changed, 16 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index e56c064d46f..0e8205818a4 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -44,18 +44,6 @@
>   
>   #include "exec/hwaddr.h"
>   
> -#define SUFFIX
> -#define ARG1         as
> -#define ARG1_DECL    AddressSpace *as
> -#define TARGET_ENDIANNESS
> -#include "exec/memory_ldst.h.inc"
> -
> -#define SUFFIX       _cached_slow
> -#define ARG1         cache
> -#define ARG1_DECL    MemoryRegionCache *cache
> -#define TARGET_ENDIANNESS
> -#include "exec/memory_ldst.h.inc"
> -
>   static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
>   {
>       address_space_stl_notdirty(as, addr, val,
> diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
> index 92ad74e9560..7270235c600 100644
> --- a/include/exec/memory_ldst.h.inc
> +++ b/include/exec/memory_ldst.h.inc
> @@ -19,7 +19,6 @@
>    * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#ifdef TARGET_ENDIANNESS
>   uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
>       hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
>   uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
> @@ -34,7 +33,6 @@ void glue(address_space_stl, SUFFIX)(ARG1_DECL,
>       hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
>   void glue(address_space_stq, SUFFIX)(ARG1_DECL,
>       hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
> -#else
>   uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>       hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
>   uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
> @@ -63,9 +61,7 @@ void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
>       hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
>   void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
>       hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
> -#endif
>   
>   #undef ARG1_DECL
>   #undef ARG1
>   #undef SUFFIX
> -#undef TARGET_ENDIANNESS

Just to track last Richard answer,
Posted on v1:

On 3/10/25 17:04, Pierrick Bouvier wrote:
 >  From what I understand, non endian versions are simply passing 
DEVICE_NATIVE_ENDIAN as a
 > parameter for address_space_ldl_internal, which will thus match the 
target endianness.
 >
 > So what is the risk for common code to call this?

You're right.  I failed to look at the current implementation
to see that it would already work.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


