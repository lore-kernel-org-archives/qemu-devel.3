Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6915C3ABA8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 19:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spvH3-00050s-0p; Sun, 15 Sep 2024 15:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1spvH1-0004wP-NK
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:51:07 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1spvGz-0004aL-QB
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:51:07 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso2024613a12.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726429864; x=1727034664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKDiH1YjanMHb+OjY8RgM94lnz6awsmkMUpDW3lwjGU=;
 b=lNMvd71LJ5yeBZBgM06qJcEunqI5YQbjh3uxrxPBjPdU3XTbfcqP1u1X5VUrQiy1vW
 02cQiy7hwQ13KTuoZ0TKHVFBdJl0dmvVLh3sL7TrDZTkobnAAKsKNtMdOCgR50YJAC6X
 us1HaoTj2us06T29dYNcUOx1UbaM5NKBPoVFbvCeItzagT3LRrvymZywZHqZvldBC6/+
 JvfHUxr8cq2KyeFRjBcvzpxEzR41Be/hJ7i/xZ+DwReqUsWzArl2dIxnxqud8MzLZl8p
 SLd9RgG62uR15Mgy1SskMKy8PmFS50trYsyX/efz+8NKCO36pM6adGoRW9qxP09bneS5
 1EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726429864; x=1727034664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKDiH1YjanMHb+OjY8RgM94lnz6awsmkMUpDW3lwjGU=;
 b=QINeXUhXIZZEY82OW3ZGnUabEp7mhyY+Ojox4rniyB2azALNoRlrgfnJHVduciTZPh
 Tq0e6QPDeuEeeY8ohRuxKm8aa/Nt2Res0AS8p40xyFlyKUMQVOApXjLeA8a+r89bzxLP
 Q+g+jLRdD/ZVu3TA4vrk7G28q1IGRL8BUXTjhVK5ckwiG4Hz4pF4mI+popbXZi6JY6D0
 CWXOerkPvZwiAJ7gMV2MeqGgeyw/SHSEfiei52dLi9vtPgie0Bg/XnryhW7jdP1cCKzb
 AmM2mVofn2xK9ZzoUJDEklGnlr5uJFROOpHerCtNuwHtMmNRIWWCFcY8RsKipSsaZ//s
 Iq0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvFUB3OtzTom0+qXuorgogagVBm23lYvy5nL8yVWWMz1HlCeOAd+/DYGCOZf7sw7keLPveW8uA+JJo@nongnu.org
X-Gm-Message-State: AOJu0YySBwR/hrkJO669hpqzP6LUBkbw2FEBBuPlsTUomS02xq0i/pVT
 8yA+r2FJi0Nw2v+WB+3FQYOASAQeZcQTIs+F7jRTuQY1+hKTPIxPtQoCBok+PNv7FTvmbh3CuUR
 G
X-Google-Smtp-Source: AGHT+IHdCefPTWU93izH6/83eJ0pjeGE7HwQ3Qk0qdy7J89xcN6CD6uU3uCpbCq48KRh7Bqmt7Suzw==
X-Received: by 2002:a05:6a21:78e:b0:1cf:41aa:f6a1 with SMTP id
 adf61e73a8af0-1d112bb2092mr14365500637.20.1726429864260; 
 Sun, 15 Sep 2024 12:51:04 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-33.dsl.telesp.net.br.
 [201.68.240.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc9ecesm2524515b3a.196.2024.09.15.12.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Sep 2024 12:51:03 -0700 (PDT)
Message-ID: <ccf73096-0fad-4bcb-bff4-e9e0ee6944dd@ventanamicro.com>
Date: Sun, 15 Sep 2024 16:51:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 32/47] bsd-user: Add RISC-V signal trampoline setup function
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
 <20240912052953.2552501-33-alistair.francis@wdc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240912052953.2552501-33-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52a.google.com
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



On 9/12/24 2:29 AM, Alistair Francis wrote:
> From: Mark Corbin <mark@dibsco.co.uk>
> 
> Implemented the 'setup_sigtramp' function for setting up the signal
> trampoline code in the RISC-V architecture.
> 
> Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240907031927.1908-8-itachis@FreeBSD.org>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   bsd-user/riscv/target_arch_sigtramp.h | 42 +++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
> 
> diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
> new file mode 100644
> index 0000000000..83345f3961
> --- /dev/null
> +++ b/bsd-user/riscv/target_arch_sigtramp.h
> @@ -0,0 +1,42 @@
> +/*
> + * RISC-V sigcode
> + *
> + * Copyright (c) 2019 Mark Corbin
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TARGET_ARCH_SIGTRAMP_H
> +#define TARGET_ARCH_SIGTRAMP_H
> +
> +/* Compare with sigcode() in riscv/riscv/locore.S */
> +static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
> +        unsigned sys_sigreturn)
> +{
> +    int i;

There's no 'i' var being used. This will throw an 'unused variable' warning when building.

> +    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
> +
> +    static const uint32_t sigtramp_code[] = {
> +    /*1*/ const_le32(0x00010513),                        /*mv a0, sp*/
> +    /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi a0,a0,sigf_uc*/
> +    /*3*/ const_le32(0x00000293 + (sys_sigreturn << 20)),/*li t0,sys_sigreturn*/
> +    /*4*/ const_le32(0x00000073),                        /*ecall*/
> +    /*5*/ const_le32(0x00000293 + (sys_exit << 20)),     /*li t0,sys_exit*/
> +    /*6*/ const_le32(0x00000073),                        /*ecall*/
> +    /*7*/ const_le32(0xFF1FF06F)                         /*b -16*/
> +    };


And this will throw the following error:

../bsd-user/riscv/target_arch_sigtramp.h:32:33: error: initializer element is not a compile-time constant
    32 |     /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi a0,a0,sigf_uc*/
                       ~~~~~~~~~~~^~~~~~~~~~~~~~~~~
/tmp/cirrus-ci-build/include/qemu/bswap.h:168:26: note: expanded from macro 'const_le32'
   168 | # define const_le32(_x) (_x)
       |                          ^~
1 error generated.


One solution is to remove the 'static const' qualifier from the array, like
bsd-user/arm/target_arch_sigtramp.h is doing.


This diff will fix the build:


diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
index 83345f3961..dfe5076739 100644
--- a/bsd-user/riscv/target_arch_sigtramp.h
+++ b/bsd-user/riscv/target_arch_sigtramp.h
@@ -24,10 +24,9 @@
  static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
          unsigned sys_sigreturn)
  {
-    int i;
      uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
  
-    static const uint32_t sigtramp_code[] = {
+    uint32_t sigtramp_code[] = {
      /*1*/ const_le32(0x00010513),                        /*mv a0, sp*/
      /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi a0,a0,sigf_uc*/
      /*3*/ const_le32(0x00000293 + (sys_sigreturn << 20)),/*li t0,sys_sigreturn*/




Thanks,

Daniel



> +
> +    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
> +}
> +#endif /* TARGET_ARCH_SIGTRAMP_H */

