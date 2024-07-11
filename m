Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6705CC3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 06:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRnIg-0005FH-8C; Thu, 11 Jul 2024 02:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRnIc-0005Ei-J6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRnIX-0001cd-60
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 02:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720679334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6mlejxvSYJ+PTQ8NKwrPhr95tJaVGK9XZuWbzHA//vo=;
 b=CtoT8O9pupdwXCvYa4w4ZwoEmj6h1dkEcN80ti2uCgluQZ/eFGR/LJD/yeWFP/bykBMLiM
 LHfvk32YonpWFId7c8QkBI6d5Ag7eYc9b6MdpHqiJ7OdvZMcAAM+NqEN8rBX8sHaY2MpPK
 OEXGUAlluOiHG9RA5q7F2007Gt8Uxcg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-Hrh-SNN3NU-l3jme-dGzJA-1; Thu, 11 Jul 2024 02:28:49 -0400
X-MC-Unique: Hrh-SNN3NU-l3jme-dGzJA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42725ec6d8dso4191465e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 23:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720679328; x=1721284128;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mlejxvSYJ+PTQ8NKwrPhr95tJaVGK9XZuWbzHA//vo=;
 b=p8Bt0ABwtlG5IcrSvZGEusx0IbkFFYI3QayBP0LbsbWydK06i/fRewAalueKm46AG7
 Bwe8lm5XD4ybBkQjsHkVy7v0Rz3jaLpi12ox1G9IpcObmEoJqjjW4y9mN4OTL0NOLBag
 Q6RCITqFQOWPnKpKxhERJ8ZwusRf+FZE3vEI+zMi6TjyY0ErSFLtLCS6lO+TS3+bHEdF
 qMeXWJqX/iNb3yiSggDESz1Y9zj7jIEkQ+EjDqB9aKFVWaJ4q+2oB7cBbRuBjqaKuWGC
 oiGp5BAgOmCtNJJZQ6G1Qq767rxxtH2N9toQIqdJBm6xBn5JxdEfmaubt2zpYvGZt4Rg
 pORA==
X-Gm-Message-State: AOJu0YzuJCahKXUduVKZy9tiu99ZPClqFxmKUwpaZ0dzxAFEjz9GcTU+
 8QwbIHpENsm8buKG84deBNEyuEqOKwgDriBBUpVVxzRR4sKyq93U7NGq8gR/FiitaZBSkyhy+z3
 JrnFNZEVvaUu6+6iAlYF010KrVaJddHLg/Nbmbq9h+ftySVlhGunK
X-Received: by 2002:a05:6000:1864:b0:367:9cd5:c608 with SMTP id
 ffacd0b85a97d-367cea962b4mr7447080f8f.36.1720679328697; 
 Wed, 10 Jul 2024 23:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOw2bY8E0r3CvvmisO7g7bCLUptVFxEmtlCPcJdcifIShotC4pQHukNmUl4+bb2mieDppklA==
X-Received: by 2002:a05:6000:1864:b0:367:9cd5:c608 with SMTP id
 ffacd0b85a97d-367cea962b4mr7447067f8f.36.1720679328363; 
 Wed, 10 Jul 2024 23:28:48 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f5a27sm103568415e9.23.2024.07.10.23.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 23:28:47 -0700 (PDT)
Message-ID: <e3e7f92c-94ef-4478-99e5-c162fd4b9136@redhat.com>
Date: Thu, 11 Jul 2024 08:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/i386/tcg: use X86Access for TSS access
From: Paolo Bonzini <pbonzini@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Robert Henry <rrh.henry@gmail.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-10-pbonzini@redhat.com>
 <293864db-8a3e-4585-abf1-da2b11990b43@linaro.org>
 <CABgObfbBz9Oq=L1XCUaXGwp-7Q5FWQFp4Ld=b8Twyi0ymSrYpQ@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CABgObfbBz9Oq=L1XCUaXGwp-7Q5FWQFp4Ld=b8Twyi0ymSrYpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/10/24 20:40, Paolo Bonzini wrote:
> 
> 
> Il mer 10 lug 2024, 18:47 Richard Henderson 
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> ha 
> scritto:
> 
>     On 7/9/24 23:29, Paolo Bonzini wrote:
>      > This takes care of probing the vaddr range in advance, and is
>     also faster
>      > because it avoids repeated TLB lookups.  It also matches the
>     Intel manual
>      > better, as it says "Checks that the current (old) TSS, new TSS,
>     and all
>      > segment descriptors used in the task switch are paged into system
>     memory";
>      > note however that it's not clear how the processor checks for segment
>      > descriptors, and this check is not included in the AMD manual.
>      >
>      > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
>      > ---
>      >   target/i386/tcg/seg_helper.c | 101
>     ++++++++++++++++++-----------------
>      >   1 file changed, 51 insertions(+), 50 deletions(-)
>      >
>      > diff --git a/target/i386/tcg/seg_helper.c
>     b/target/i386/tcg/seg_helper.c
>      > index 25af9d4a4ec..77f2c65c3cf 100644
>      > --- a/target/i386/tcg/seg_helper.c
>      > +++ b/target/i386/tcg/seg_helper.c
>      > @@ -311,35 +313,44 @@ static int switch_tss_ra(CPUX86State *env,
>     int tss_selector,
>      >           raise_exception_err_ra(env, EXCP0A_TSS, tss_selector &
>     0xfffc, retaddr);
>      >       }
>      >
>      > +    /* X86Access avoids memory exceptions during the task switch */
>      > +    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
>      > +                    MMU_DATA_STORE, cpu_mmu_index_kernel(env),
>     retaddr);
>      > +
>      > +    if (source == SWITCH_TSS_CALL) {
>      > +        /* Probe for future write of parent task */
>      > +        probe_access(env, tss_base, 2, MMU_DATA_STORE,
>      > +                  cpu_mmu_index_kernel(env), retaddr);
>      > +    }
>      > +    access_prepare_mmu(&new, env, tss_base, tss_limit,
>      > +                    MMU_DATA_LOAD, cpu_mmu_index_kernel(env),
>     retaddr);
> 
>     You're computing cpu_mmu_index_kernel 3 times.

Squashing this in (easier to review than the whole thing):

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 4123ff1245e..4edfd26135f 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -321,7 +321,7 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
      uint32_t new_eflags, new_eip, new_cr3, new_ldt, new_trap;
      uint32_t old_eflags, eflags_mask;
      SegmentCache *dt;
-    int index;
+    int mmu_index, index;
      target_ulong ptr;
      X86Access old, new;
  
@@ -378,16 +378,17 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
      }
  
      /* X86Access avoids memory exceptions during the task switch */
+    mmu_index = cpu_mmu_index_kernel(env);
      access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
-		       MMU_DATA_STORE, cpu_mmu_index_kernel(env), retaddr);
+		       MMU_DATA_STORE, mmu_index, retaddr);
  
      if (source == SWITCH_TSS_CALL) {
          /* Probe for future write of parent task */
          probe_access(env, tss_base, 2, MMU_DATA_STORE,
-		     cpu_mmu_index_kernel(env), retaddr);
+		     mmu_index, retaddr);
      }
      access_prepare_mmu(&new, env, tss_base, tss_limit,
-		       MMU_DATA_LOAD, cpu_mmu_index_kernel(env), retaddr);
+		       MMU_DATA_LOAD, mmu_index, retaddr);
  
      /* read all the registers from the new TSS */
      if (type & 8) {
@@ -468,7 +469,11 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
         context */
  
      if (source == SWITCH_TSS_CALL) {
-        cpu_stw_kernel_ra(env, tss_base, env->tr.selector, retaddr);
+        /*
+         * Thanks to the probe_access above, we know the first two
+         * bytes addressed by &new are writable too.
+         */
+        access_stw(&new, tss_base, env->tr.selector);
          new_eflags |= NT_MASK;
      }
  
Paolo


