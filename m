Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D58CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 18:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roSLg-00023F-4V; Sun, 24 Mar 2024 14:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roSLb-0001yT-V1
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 14:13:33 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roSLa-00027z-3X
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 14:13:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1def2a1aafaso21729795ad.3
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711304008; x=1711908808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VVqabZPZCi+tzyr4GuKxeDIoSAEDJACjTahwVERhdIY=;
 b=qCdDeLFmxpgJyPR2y3Lix+HECS4PIdMyal/30PE682yyC7VzJ6shRh0j1L0ZOogKR2
 2SC2dhdnCxlAAp865RLzuHcpflCo7T2Rol4hX0o+Fy6cH6DS5DIea/BXtzJvPRtJ9/Yg
 0z07/0WO/DtwIYkCfq2yh5dit33NQKRFsYU7P0x5EeIirydU16lqv4mxz9ih7nhiLYIf
 GGm/J199o4+zZSjTqIzxNMtzdyfzWI6lskFL75oCa8aAD4UYI2JspJmlJOegW7pquBH8
 MSMIajVnOTZSMXu7L6LfYFuvGaeTj20tQiAYEYHRNQ0G99+3PlXw5vDD4lbzJBy3Q3uH
 IaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711304008; x=1711908808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VVqabZPZCi+tzyr4GuKxeDIoSAEDJACjTahwVERhdIY=;
 b=RhOybu8HqvjDvJUCKrjOoTJx4QKheTZJsYIvq2sQcfpj3oiCsI5oQVorAHjNHwn9nm
 0wWrKp+NtPxpOWCGdl65VumEV2Y3MZ6a3Pbf0hfyX20pPDRU5HtybT2aSnHVAmRWfeR+
 nzSswbQClVH8Q4JlcPyKVmrDhNHH+3f52TME1G3y3CUwfXFnQ+MBhzs7vAkb9xsSTyWU
 ev03D0pEHzcPDT98GMbvmY+4zasXMXno4fetEMzJUXdbIj3zfv9SAxf3lv9eoQNPq+Bn
 H2uSIZhENWFBSjTCbn9lYozsr9p1z8d1ObjOeXSELMUrPhV6SR8LVn21IFBZFEN74A38
 zR8Q==
X-Gm-Message-State: AOJu0YySNjJRT+iwMqVlSi11VqB0/hXrAQOYKmaYocUog+xsfPsA/hN3
 UC6Wr2/XU+zhR4X6D0p4J/vH+EyeVuuboH3hdReHqbREaFcYnB/a6/EC2RSf2x8=
X-Google-Smtp-Source: AGHT+IH+jbsZYDQX4W2+mZUx80HBvuXlInXAxepZXXwODp6q9dj8uFcHVUWXBpuOZCZ8Z6f0DfofmQ==
X-Received: by 2002:a17:902:cf0d:b0:1e0:b62c:3ae2 with SMTP id
 i13-20020a170902cf0d00b001e0b62c3ae2mr2548534plg.10.1711304008384; 
 Sun, 24 Mar 2024 11:13:28 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p15-20020a170902e74f00b001e0afbaf49asm381459plf.278.2024.03.24.11.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 11:13:27 -0700 (PDT)
Message-ID: <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
Date: Sun, 24 Mar 2024 08:13:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240324080945.991100-3-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/23/24 22:09, Sven Schnelle wrote:
> The CPU seems to mask a few bits in the offset when running
> under HP-UX. ISR/IOR register contents for an address in
> the processor HPA (0xfffffffffffa0000) on my C8000 and J6750:
> 
> running on Linux: 000000003fffffff c0000000fffa0500
> running on HP-UX: 00000000301fffff c0000000fffa0500
> 
> I haven't found how this is switched (guess some diag in the
> firmware), but linux + seabios seems to handle that as well,
> so lets mask out the additional bits.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index a072d0bb63..9bc4d208fa 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -283,12 +283,13 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
>   
>   void hppa_translate_init(void);
>   
> +#define HPPA_GVA_OFFSET_MASK64 0x301fffffffffffff
>   #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
>   
>   static inline uint64_t gva_offset_mask(target_ulong psw)
>   {
>       return (psw & PSW_W
> -            ? MAKE_64BIT_MASK(0, 62)
> +            ? HPPA_GVA_OFFSET_MASK64
>               : MAKE_64BIT_MASK(0, 32));
>   }
>   

I'm not keen on this, because it contradicts the manual for forming an address.

Where I can imagine this sort of thing creeping in is the fact that you're getting a 
result from trap registers.  The cpu does not actually retain the original {space, offset} 
tuple that formed the GVA to fill the trap registers, but takes bits [62:32] and 
back-computes a space, and subtracts to re-form an offset.  See "Interruption Parameter 
Registers" in the pa20 manual.

In particular Figure 2-14 for "data translation disabled" may be instructive.  Suppose the 
cpu does not implement all of the physical address lines (true for all extant pa-risc 
cpus; qemu implements 40 bits to match pa-8500 iirc).  Suppose when reporting a trap with 
translation disabled, it is a truncated physical address that is used as input to Figure 2-14.

If that is so, then the fix might be in hppa_set_ior_and_isr.  Perhaps

-    env->cr[CR_ISR] &= 0x3fffffff;
+    env->cr[CR_ISR] &= 0x301fffff;

Though my argument would suggest the mask should be 0xff for the 40-bit physical address, 
which is not what you see at all, so perhaps the thing is moot.  I am at a loss to explain 
why or how HP-UX gets a 7-bit hole in the ISR result.

On the other hand, there are some not-well-documented shenanigans (aka implementation 
defined behaviour) between Figure H-8 and Figure H-11, where the 62-bit absolute address 
is expanded to a 64-bit logical physical address and then compacted to a 40-bit 
implementation physical address.

We've already got hacks in place for this in hppa_abs_to_phys_pa2_w1, which just truncates 
everything down to 40 bits.  But that's probably not what the processor is really doing.

Anyhow, will you please try the hppa_set_ior_and_isr change and see if that fixes your 
HP-UX problems?


r~

