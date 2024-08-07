Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52396C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 21:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnm9-0002fa-4o; Wed, 07 Aug 2024 17:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbnm2-0002XF-LA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:00:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbnlz-000388-Hv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:00:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd640a6454so3397965ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723064441; x=1723669241;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EvqRipjIgOC3eyArK9VIFmfRbxP6HCCDqQ+gBYwbmBE=;
 b=0IkKzaptQ3B8S5VollC+iBKkugJ19eZnWSpfRabiZTpn8FDvANQc1ldGOQL7jPTUOf
 FYGmPqg/VhsZylIDyPkfuF/OIYnOQm2fbSqL3uOWuErXZ+BVemO3qxVJywlfAGMw7oG7
 +isOl10CNmPlBuFxe4JPqYOp8B6eqzNLdWQgNkrNULkcwU6U/EPKMLhyqVZWJF9iz5lu
 nCbE4MkANbW7xfx5015YYyCMT+IEwuZRm2WgpGqdnmUR/0ESs2RPllcogST5Rmn3XXe8
 k1NdM91swq+k3gDKZp8N6SqU6RQDXMFOyq7tJOCdNTa9CurTQ+QYeCEw6F2JK7QbqFRQ
 0U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723064441; x=1723669241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvqRipjIgOC3eyArK9VIFmfRbxP6HCCDqQ+gBYwbmBE=;
 b=YYYPMJFxvTr1iqpn5FifyD21edNnhzy+1J04MgxcNWbMi1pLn47vasYSociWKq0b5R
 Y+Wj4EQlMfdv5DtUeeXI8XuIsDiVm1xNCk4ZVMjZWUswImP5CvKm5NqZeQ+2WwcTZ6We
 xaPBphCE1ryS3y/JHbgVKChATv+X8K4TK8XLmhUIKjZpo+lysa+2d0TTIaLPPes/N9iB
 2XNRYMa1ZwQAQz91q2Whaiz0iDYT0zuxDPXfexxwNEpTS03YMGSDwQLWn6rfzB8MwKr4
 T4dolg+cJqNPCwGtBegpOb8GXg/yxqBw2+3BA4bAWRfCQ3+yejhoZX5IAc9sssss4qd+
 8ydQ==
X-Gm-Message-State: AOJu0YzIYd9GPkA1tPpuexxM02+/DQ9O4bLatX1K67fqes9y2FzXAd4f
 eXaE+dHXLOVHr10klEBTq3o5ge2+BDBPQcysfA8yDFvHW1x4vIfd06tpJ+bvQzI=
X-Google-Smtp-Source: AGHT+IH4dLfDxKq7xNwKJntIFaYhfFr6cvIvC+GG0LsMFwAcWrH23uueDXgG8jQ6eirtf9I+8F3WiQ==
X-Received: by 2002:a17:902:fd46:b0:1fa:1dd8:947a with SMTP id
 d9443c01a7336-1ff5748f35bmr149696005ad.46.1723064440660; 
 Wed, 07 Aug 2024 14:00:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200869c96f1sm18248695ad.298.2024.08.07.14.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 14:00:40 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:00:38 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>
Subject: Re: [PATCH v3 20/20] linux-user: Add RISC-V zicfilp support in VDSO
Message-ID: <ZrPgdqGH3hNFjeyx@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-21-debug@rivosinc.com>
 <e210c317-bad1-4d29-ab11-cd2e16246398@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e210c317-bad1-4d29-ab11-cd2e16246398@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 01:41:37PM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>Add zicfilp support in VDSO. VDSO functions need lpad instruction
>>so that userspace could call this function when landing pad extension is
>>enabled. This solution only works when toolchain always use landing pad
>>label 1.
>
>Well, no, the lpad insns *could* use imm=0.
>Why would the toolchain always use label 1?
>
>Much more explanation is required here.

Sorry this is amiss on my end. label=1 is kind of experimental, dev enabling
to ensure that label checkings are working. Eventually label scheme would be
hash (20bit truncates) based label scheme. Hash calculated over function
prototype.

This is again chicken and an egg problem. Things have to make it to upstream
in toolchain and libc for this scheme to be usable.

For now, I am thinking of doing `lpad 0` (as you also hinted) for vDSO.
I hope that's fine.

>
>>+/* GNU_PROPERTY_RISCV64_* macros from elf.h for use in asm code.  */
>>+#define FEATURE_1_AND 0xc0000000
>>+
>>+#define GNU_PROPERTY(type, value)	\
>>+  .section .note.gnu.property, "a";	\
>>+  .p2align 3;                       \
>>+  .word 4;                          \
>>+  .word 16;                         \
>>+  .word 5;                          \
>>+  .asciz "GNU";                     \
>>+  .word type;                       \
>>+  .word 4;                          \
>>+  .word value;                      \
>>+  .word 0;                          \
>>+  .text
>>+
>>+/* Add GNU property note with the supported features to all asm code
>>+   where sysdep.h is included.  */
>>+#undef __VALUE_FOR_FEATURE_1_AND
>>+#if defined (__riscv_zicfilp) || defined (__riscv_zicfiss)
>>+#  if defined (__riscv_zicfilp)
>>+#    if defined (__riscv_zicfiss)
>
>Why are you checking __riscv_* symbols, for when the toolchain
>has these features enabled on the command-line?
>

Yes, you're right.

>This is the kind of feature you want enabled always.

Yes, you're right here as well.
It should be compiled into vDSO unconditionally.

Will do that.

>
>>+#ifdef __riscv_zicfilp
>>+# define LPAD       lpad 1
>>+#else
>>+# define LPAD
>>+#endif
>
>Here, especially, you should be using ".insn", not omitting the lpad insn.
>
>
>r~
>

