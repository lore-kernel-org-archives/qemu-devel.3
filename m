Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C3CF31B0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwf2-0005Gk-SR; Wed, 02 Oct 2024 06:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwf0-0005G1-Uq
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwey-0001K8-9e
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYNWL2OgBaC9xOww8LM3M9P2qa6NiLRgnOA9hqRYh40=;
 b=KosqzE7Al/18UR3GCyv2We4cRsGwq5hsmoJjy/9SM0a3UNqf+NilnBdewqIqIcCPRuNoOA
 qUpEFofT8tNtVWOZpBD32G5U9F3fuXcWyOBguUBLGCUMTrR2Kw2xcIp0E27sFFonPRkm71
 8DRElqr/7cfaGd1+lrU6SGur1624/1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-hNIW12ujNICYsiaB3Qfppg-1; Wed, 02 Oct 2024 06:32:40 -0400
X-MC-Unique: hNIW12ujNICYsiaB3Qfppg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso54440375e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865159; x=1728469959;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYNWL2OgBaC9xOww8LM3M9P2qa6NiLRgnOA9hqRYh40=;
 b=lsmIJ5EfBm6uhd+qKsUjM03YJQzqwOBi093NlpDjeeKC/ohETHgWbtLCMmPDkojbFC
 QwOF+slFQxtbUIXJv1PbJC+s7YiW+VnKq73QXmjUp7V9eM3fP4gJqyYACjdbXfeI1mEk
 Ii6jb4uAAqpYWbsohfIY76X8HahP/nilfH+CtpWzj8fX26g4p/Zr0oNoivK66H6tF39v
 4WJTKB1a+k1unAEajeIlyOesMJqod5eczgjlas2F35RaTOuYvjiapx5oZzFzNfivYRqX
 dyark/qagY3/bc5lUyhtHGmuH92ckenvAbIVK8XGrUvh/4bb2rzva0HbLfXv+rzWui7M
 bixA==
X-Gm-Message-State: AOJu0YylLlhYLATkm7jGHOd3NcayZtmne2ta02FbpH10e1btyy5zjj6A
 3EoY3dbdPgOMOzNqVwPRn2J90Y3ikQVS49zodP//fvVOEYCJ3MaoJ1p44+MsB0h+iWyYyJunGwK
 9TA+DUtUSrj0H+dcR0iSYZGqoeSBg/WL9Zz5LixVu71lhOCYCmuvd
X-Received: by 2002:a05:600c:3b8b:b0:42c:cdcf:2fef with SMTP id
 5b1f17b1804b1-42f777c09cdmr18688175e9.15.1727865158926; 
 Wed, 02 Oct 2024 03:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKWLgfL+tvOL+8uBWnrYX9XyDuA2vFR8WdLnDKFB7H6I6rShPd0h4NJfP409rIydX+PMj0xA==
X-Received: by 2002:a05:600c:3b8b:b0:42c:cdcf:2fef with SMTP id
 5b1f17b1804b1-42f777c09cdmr18688045e9.15.1727865158503; 
 Wed, 02 Oct 2024 03:32:38 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fbf6sm13649618f8f.74.2024.10.02.03.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:32:38 -0700 (PDT)
Message-ID: <24facf82-c3a2-47e0-98f8-e2b684a705f0@redhat.com>
Date: Wed, 2 Oct 2024 12:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Remove unused handle_vm86_fault
To: dave@treblig.org, richard.henderson@linaro.org, laurent@vivier.eu,
 QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel@nongnu.org
References: <20240918141553.149521-1-dave@treblig.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240918141553.149521-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2024 16.15, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> handle_vm86_fault has been unused since:
>    1ade5b2fed ("linux-user/i386: Split out maybe_handle_vm86_trap")
> 
> Remove it, and it's local macros.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   linux-user/user-internals.h |   1 -
>   linux-user/vm86.c           | 136 ------------------------------------
>   2 files changed, 137 deletions(-)
> 
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 5c7f173ceb..46ffc093f4 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -102,7 +102,6 @@ int host_to_target_waitstatus(int status);
>   /* vm86.c */
>   void save_v86_state(CPUX86State *env);
>   void handle_vm86_trap(CPUX86State *env, int trapno);
> -void handle_vm86_fault(CPUX86State *env);
>   int do_vm86(CPUX86State *env, long subfunction, abi_ulong v86_addr);
>   #elif defined(TARGET_SPARC64)
>   void sparc64_set_context(CPUSPARCState *env);
> diff --git a/linux-user/vm86.c b/linux-user/vm86.c
> index 9f512a2242..31a2d707cf 100644
> --- a/linux-user/vm86.c
> +++ b/linux-user/vm86.c
> @@ -255,142 +255,6 @@ void handle_vm86_trap(CPUX86State *env, int trapno)
>       }
>   }
>   
> -#define CHECK_IF_IN_TRAP() \
> -      if ((ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_active) && \
> -          (ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_TFpendig)) \
> -                newflags |= TF_MASK
> -
> -#define VM86_FAULT_RETURN \
> -        if ((ts->vm86plus.vm86plus.flags & TARGET_force_return_for_pic) && \
> -            (ts->v86flags & (IF_MASK | VIF_MASK))) \
> -            return_to_32bit(env, TARGET_VM86_PICRETURN); \
> -        return
> -
> -void handle_vm86_fault(CPUX86State *env)
> -{
> -    CPUState *cs = env_cpu(env);
> -    TaskState *ts = get_task_state(cs);
> -    uint32_t csp, ssp;
> -    unsigned int ip, sp, newflags, newip, newcs, opcode, intno;
> -    int data32, pref_done;
> -
> -    csp = env->segs[R_CS].selector << 4;
> -    ip = env->eip & 0xffff;
> -
> -    ssp = env->segs[R_SS].selector << 4;
> -    sp = env->regs[R_ESP] & 0xffff;
> -
> -    LOG_VM86("VM86 exception %04x:%08x\n",
> -             env->segs[R_CS].selector, env->eip);
> -
> -    data32 = 0;
> -    pref_done = 0;
> -    do {
> -        opcode = vm_getb(env, csp, ip);
> -        ADD16(ip, 1);
> -        switch (opcode) {
> -        case 0x66:      /* 32-bit data */     data32=1; break;
> -        case 0x67:      /* 32-bit address */  break;
> -        case 0x2e:      /* CS */              break;
> -        case 0x3e:      /* DS */              break;
> -        case 0x26:      /* ES */              break;
> -        case 0x36:      /* SS */              break;
> -        case 0x65:      /* GS */              break;
> -        case 0x64:      /* FS */              break;
> -        case 0xf2:      /* repnz */	      break;
> -        case 0xf3:      /* rep */             break;
> -        default: pref_done = 1;
> -        }
> -    } while (!pref_done);
> -
> -    /* VM86 mode */
> -    switch(opcode) {
> -    case 0x9c: /* pushf */
> -        if (data32) {
> -            vm_putl(env, ssp, sp - 4, get_vflags(env));
> -            ADD16(env->regs[R_ESP], -4);
> -        } else {
> -            vm_putw(env, ssp, sp - 2, get_vflags(env));
> -            ADD16(env->regs[R_ESP], -2);
> -        }
> -        env->eip = ip;
> -        VM86_FAULT_RETURN;
> -
> -    case 0x9d: /* popf */
> -        if (data32) {
> -            newflags = vm_getl(env, ssp, sp);
> -            ADD16(env->regs[R_ESP], 4);
> -        } else {
> -            newflags = vm_getw(env, ssp, sp);
> -            ADD16(env->regs[R_ESP], 2);
> -        }
> -        env->eip = ip;
> -        CHECK_IF_IN_TRAP();
> -        if (data32) {
> -            if (set_vflags_long(newflags, env))
> -                return;
> -        } else {
> -            if (set_vflags_short(newflags, env))
> -                return;
> -        }
> -        VM86_FAULT_RETURN;
> -
> -    case 0xcd: /* int */
> -        intno = vm_getb(env, csp, ip);
> -        ADD16(ip, 1);
> -        env->eip = ip;
> -        if (ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_active) {
> -            if ( (ts->vm86plus.vm86plus.vm86dbg_intxxtab[intno >> 3] >>
> -                  (intno &7)) & 1) {
> -                return_to_32bit(env, TARGET_VM86_INTx + (intno << 8));
> -                return;
> -            }
> -        }
> -        do_int(env, intno);
> -        break;
> -
> -    case 0xcf: /* iret */
> -        if (data32) {
> -            newip = vm_getl(env, ssp, sp) & 0xffff;
> -            newcs = vm_getl(env, ssp, sp + 4) & 0xffff;
> -            newflags = vm_getl(env, ssp, sp + 8);
> -            ADD16(env->regs[R_ESP], 12);
> -        } else {
> -            newip = vm_getw(env, ssp, sp);
> -            newcs = vm_getw(env, ssp, sp + 2);
> -            newflags = vm_getw(env, ssp, sp + 4);
> -            ADD16(env->regs[R_ESP], 6);
> -        }
> -        env->eip = newip;
> -        cpu_x86_load_seg(env, R_CS, newcs);
> -        CHECK_IF_IN_TRAP();
> -        if (data32) {
> -            if (set_vflags_long(newflags, env))
> -                return;
> -        } else {
> -            if (set_vflags_short(newflags, env))
> -                return;
> -        }
> -        VM86_FAULT_RETURN;
> -
> -    case 0xfa: /* cli */
> -        env->eip = ip;
> -        clear_IF(env);
> -        VM86_FAULT_RETURN;
> -
> -    case 0xfb: /* sti */
> -        env->eip = ip;
> -        if (set_IF(env))
> -            return;
> -        VM86_FAULT_RETURN;
> -
> -    default:
> -        /* real VM86 GPF exception */
> -        return_to_32bit(env, TARGET_VM86_UNKNOWN);
> -        break;
> -    }
> -}
> -
>   int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
>   {
>       CPUState *cs = env_cpu(env);

Reviewed-by: Thomas Huth <thuth@redhat.com>


