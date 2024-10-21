Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786EAD3E18D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 06:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mMm-0005lH-M9; Mon, 21 Oct 2024 02:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2mMg-0005kt-0e
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2mMe-0002of-4F
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729493881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/yPg2vrOMvIsDMWz3/Z3cTAVby2WLe/QDULH5ZMH7Ok=;
 b=ShZzz8eWG7NbjszlIvogmx2tId9a2Q+k+8AyA+dP0GMg9BMX5T4eS88X8rRb5phuZPnO2Y
 0t/PzI8JzQ4bXLAE4chZdqtYHYQlFPd/RrpXejCFl9wfb+JtnLFFB57vsnslwYnQoI2ctQ
 tLQ6XO8R5WhstVepttir4PedjD8ggUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-w7iKiDHtMTKwH50vXUNRmg-1; Mon, 21 Oct 2024 02:57:57 -0400
X-MC-Unique: w7iKiDHtMTKwH50vXUNRmg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4317391101aso4065345e9.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 23:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729493876; x=1730098676;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yPg2vrOMvIsDMWz3/Z3cTAVby2WLe/QDULH5ZMH7Ok=;
 b=wiUTmjkhKxzPQjr/wy1L9cMxSdollFeXvwUqVCgsplDBHG+niY3xDntX+stYSD/yAf
 sx1dnfZN5WUxV/hF7f1Y28hzy7bcfRfvriM6w1ZKawXj5GqgXMhF9RRw+qNB2gtgrrUN
 znxxoY/atfe3CzafKz0VZ8m5p8PK1bjRe8J7F1HETT5kGZTf69QdqOImnM2tcPnPsHO2
 p9pbASi+qEDxoOOaE+mTUmSL5RHYnMh4+WqJabhjZYe5IHnA4rfh/jRCVZkUw+abf7Ci
 4hrpYCA6YsuyHrA6ZCGV1pQc6OWhRFC20bAYFwSN+xvdPh3Q3bQDrtWejU26ZJ9gLemV
 QdRg==
X-Gm-Message-State: AOJu0Yyg/m53GNwxN++KbZ/2Owaxm0sioDTdTL/msI91FtQra/MCqkcQ
 gs2Cq5VSXJ0MjxazxupAsuDGpuqn3M1+CksQBayBg0U9qnPEKFSsWAwU5afkv1lBEZcFoPE4eiT
 8gxnrMRR/DdaVM/EnTITwQ6sPtXt4dmpNeIsa0nn4CObr6X9Mn8mO
X-Received: by 2002:a5d:6a89:0:b0:378:89d8:8242 with SMTP id
 ffacd0b85a97d-37ea21949d1mr6646987f8f.26.1729493875862; 
 Sun, 20 Oct 2024 23:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM4RDDiCTWytilBxLz4/EerQtRhz+fWFXf8NzbhstWh368b31aDcOk8MGm3BCEQ4MR02clQA==
X-Received: by 2002:a5d:6a89:0:b0:378:89d8:8242 with SMTP id
 ffacd0b85a97d-37ea21949d1mr6646962f8f.26.1729493875227; 
 Sun, 20 Oct 2024 23:57:55 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2b46sm45900745e9.36.2024.10.20.23.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 23:57:54 -0700 (PDT)
Message-ID: <3fbecfbc-5ba7-4bca-9948-ebf8bf0a1637@redhat.com>
Date: Mon, 21 Oct 2024 08:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] target/i386: finish converting 0F AE to the new
 decoder
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-11-pbonzini@redhat.com>
 <8076e922-1839-4e8e-9dbf-35c064a439fc@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <8076e922-1839-4e8e-9dbf-35c064a439fc@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On 10/21/24 03:49, Guenter Roeck wrote:
> Hi,
> 
> On Sat, Jun 08, 2024 at 10:40:58AM +0200, Paolo Bonzini wrote:
>> This is already partly implemented due to VLDMXCSR and VSTMXCSR; finish
>> the job.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> While testing qemu v9.1, I noticed the following crash when testing qemu-system-i386
> with pentium3 CPU.

Is this enough to fix it?

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ee2a508ae9a..cda32ee6784 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -345,9 +345,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
          [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
          [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
          [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
-        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
+        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
          [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
-        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
+        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
      };
  
      static const X86OpEntry group15_mem[8] = {

>    22:	39 c6                	cmp    %eax,%esi
>    24:	0f 82 6a ff ff ff    	jb     0xffffffffffffff94
>    2a:*	0f 09                	wbinvd 		<-- trapping instruction

This is a bit weird, as wbinvd is not affected by this patch.  However,
a checkout of Linux has

         asm volatile("sfence" : :: "memory");
         kernel_fpu_end();
}

at the end of lib/raid6/sse1.c and it would indeed be affected by this
patch.  SSE2 was not present in Pentium III, but SSE was.

Paolo

> Code starting with the faulting instruction
> ===========================================
>     0:	0f 09                	wbinvd
> EAX: 00001000 EBX: c1367008 ECX: c1368008 EDX: c119deb0
> ESI: 00001000 EDI: 00000ff8 EBP: c119de84 ESP: c119de68
> DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> CR0: 80050033 CR2: ffd39000 CR3: 06144000 CR4: 000006d0
> Call Trace:
> ? show_regs (arch/x86/kernel/dumpstack.c:479)
> ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
> ? do_trap (arch/x86/kernel/traps.c:156 arch/x86/kernel/traps.c:197)
> ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:218)
> ? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
> ? exc_overflow (arch/x86/kernel/traps.c:301)
> ? exc_invalid_op (arch/x86/kernel/traps.c:316)
> ? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
> ? handle_exception (arch/x86/entry/entry_32.S:1055)
> ? exc_overflow (arch/x86/kernel/traps.c:301)
> ? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
> ? exc_overflow (arch/x86/kernel/traps.c:301)
> ? raid6_sse12_gen_syndrome (lib/raid6/sse1.c:147)
> ? raid6_sse11_gen_syndrome (lib/raid6/sse1.c:100)
> raid6_select_algo (lib/raid6/algos.c:179 (discriminator 2) lib/raid6/algos.c:273 (discriminator 2))
> ? libcrc32c_mod_init (lib/raid6/algos.c:243)
> do_one_initcall (init/main.c:1269)
> ? rdinit_setup (init/main.c:1317)
> ? parse_args (kernel/params.c:153 kernel/params.c:186)
> kernel_init_freeable (init/main.c:1330 (discriminator 1) init/main.c:1347 (discriminator 1) init/main.c:1366 (discriminator 1) init/main.c:1580 (discrim
> ? rdinit_setup (init/main.c:1317)
> ? rest_init (init/main.c:1461)
> kernel_init (init/main.c:1471)
> ? schedule_tail (kernel/sched/core.c:5266)
> ret_from_fork (arch/x86/kernel/process.c:153)
> ? rest_init (init/main.c:1461)
> ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
> entry_INT80_32 (arch/x86/entry/entry_32.S:945)
> 
> 


