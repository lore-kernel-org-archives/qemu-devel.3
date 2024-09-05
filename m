Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABC1CD4F4E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 01:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm1L0-0003jJ-8x; Wed, 04 Sep 2024 21:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm1Ky-0003ii-OV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 21:31:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm1Kv-000409-HS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 21:31:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2053f6b8201so2407845ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 18:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725499859; x=1726104659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=86C19QdJeGzMHvD4iddnzockjBYHiLvMDC8ihnlyunU=;
 b=KmGVRibIMQKjEM3i56pGmlwHcCrgfieGWS6JW6A8WSG7uByWitz4mP26QZEkTQyzfK
 YGTZ0FqimHSemCiop9ydGVuNLQ9CxytdceevUpIQfthk3gL2to4JzHev0vBV/ezJLjgQ
 +6d/z4OwxCRxj7/38sX9EyTw5cFhUaH28EwhXjR92qls9/pv2m1MtXwAKIb4zVKr3uyI
 pzLkEk0oJoRAIr7ORzmwqiIhDX0+qTzm4D4ua3McuL25k5lpgqziCvZM3nZKWLYLDynf
 eXsRXO+lIItSRI5yrntDuSBrPYNSguHjr8b5mBUF3YInw2DOkYAGNJ5pDlFHujp3X9VH
 zBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725499859; x=1726104659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=86C19QdJeGzMHvD4iddnzockjBYHiLvMDC8ihnlyunU=;
 b=fbboR3zKroD6RKHJwXdi6ohwxt3xIE9XXFtZxA9CvzK74dX+0mhkcthdg9LKvVRF7u
 c46HO6Xtm7citTnNCHyyBCqRdOMehiFt4k7VtZOGafeirtgZ3aErIw1O+EN2a7Ixr7Ue
 RdI/FYe7FRvxzJH3Cd2q9gSY0toOZSCi77p8bzSO1qvspSaA7Wf86LX1dr2nOu6DaKKU
 rdSILoNbtQHVQMkpZerfYWO9QpXKVHeeg3O2HiLnYkTVRI4gbQKgvJbdkndWwP3oHJ/a
 TxT1/p/WDwdlKWRl/4xoLB1cwRwvsFCAkxf1KKUZdTmEutUJwY0vjP2pQft53hCOQmpw
 S3/g==
X-Gm-Message-State: AOJu0Yy3hQleq2KjNqpVTeomLmSdIOHtSMRPyTsBeOUmMZYJoXwymnQy
 mlejicm469j3PiJxJ1pgLAdYsfmiU537OUDbB9xdnEfU3+3RsgaBA3RSc4AHxwb1ePmMpT6xoo0
 c
X-Google-Smtp-Source: AGHT+IERhVTvKp4LKcrtEaaQ34lbeJW7gl3KsCSZSzTQrn9AGXf1NXHTT2Frd5gGI4LJzbVd2S0Vrg==
X-Received: by 2002:a17:902:ea09:b0:206:d980:5933 with SMTP id
 d9443c01a7336-206d9805957mr1175915ad.45.1725499858611; 
 Wed, 04 Sep 2024 18:30:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206ae912674sm19151315ad.37.2024.09.04.18.30.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 18:30:58 -0700 (PDT)
Message-ID: <a88452bd-eb61-43a3-a557-0e552ab3bb27@linaro.org>
Date: Wed, 4 Sep 2024 18:30:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] disas: Remove CRIS disassembler
To: qemu-devel@nongnu.org
References: <20240904143603.52934-1-philmd@linaro.org>
 <20240904143603.52934-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240904143603.52934-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/4/24 07:36, Philippe Mathieu-Daudé wrote:
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -232,10 +232,6 @@ enum bfd_architecture
>   #define bfd_mach_avrxmega5  105
>   #define bfd_mach_avrxmega6  106
>   #define bfd_mach_avrxmega7  107
> -  bfd_arch_cris,       /* Axis CRIS */
> -#define bfd_mach_cris_v0_v10   255
> -#define bfd_mach_cris_v32      32
> -#define bfd_mach_cris_v10_v32  1032
>     bfd_arch_microblaze, /* Xilinx MicroBlaze.  */
>     bfd_arch_moxie,      /* The Moxie core.  */
>     bfd_arch_ia64,      /* HP/Intel ia64 */
> @@ -448,8 +444,6 @@ int print_insn_w65              (bfd_vma, disassemble_info*);
>  int print_insn_d10v             (bfd_vma, disassemble_info*);
>  int print_insn_v850             (bfd_vma, disassemble_info*);
>  int print_insn_tic30            (bfd_vma, disassemble_info*);
> -int print_insn_crisv32          (bfd_vma, disassemble_info*);
> -int print_insn_crisv10          (bfd_vma, disassemble_info*);
>  int print_insn_microblaze       (bfd_vma, disassemble_info*);
>  int print_insn_ia64             (bfd_vma, disassemble_info*);
>  int print_insn_xtensa           (bfd_vma, disassemble_info*);


This is probably worth leaving alone, since it's all imported.
There is lots of other stuff in there (even in these hunks)
that is not relevant to qemu.


r~

