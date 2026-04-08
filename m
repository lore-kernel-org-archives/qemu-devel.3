Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65810F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYWh-0008Vg-Kg; Wed, 08 Apr 2026 15:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1wAY77-0007YN-75
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:58 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1wAPHr-000258-L7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:33:29 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-8a151012558so74979186d6.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1775640805; x=1776245605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lrIuV9zA/JWyl+nsw0d1gC9u2JhKcFJIFMJFYwDVDIs=;
 b=h0FIw5sRYy7v8IPOL5fJmgfxr0vup7klZCSDeQCohh8wUgaNUJ2bUSJjsGBYr9ZlPe
 5BOTfelHea8bTJYzTu/2fgLe8LBoBQyBdkDlfNoKtwCF+r/Y8JkK1mVeBAFRSl3Ew/zJ
 185MvVeVZJaWK9oM7mdaUP/gPw1jmdtyrw2cnWzRk9ezTJ8+93OJgiCmY8iqR5yR+83I
 hSEZFsK9TPR8M7VCtnF9Hrx5CgKQ3b3ZSljGpW1OdajxpjZJSHkoGz+8vzU2ZqdLfXff
 4kdUjm0ABa/UgCNMEh5CGIGwGcclz3DgSqAEu7hNkgv0c8U53r+n3zyVu22uJaCVmXZL
 q7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775640805; x=1776245605;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lrIuV9zA/JWyl+nsw0d1gC9u2JhKcFJIFMJFYwDVDIs=;
 b=T2ZHLGJGTFiELc8cxJOGM3lpfSHzQnvy1X0DDHE4wi85WvDneupg07h99WQT+Jmt6G
 guyIAOkUjPwvGPkwDUZBdmNVLRKNkFK8CG6W//nLrceQR/nH3yNfqXEsDrVilJdJ/+ad
 TbQ3BjHy5z9jIf43x+v3wCiFg6rdjYplUDa8PDYZuSUCTzcF3nZg0Tfa4kFxcVAsvOau
 m0XjVbO9UonNRRhuNjR9EN+uP6T5omaOLlMubpOQ9TLx6/mYx4kC9jfr4Z7VQtv3U8A+
 IW0JSBKlhowAHVklLeaydfH7nMfi6PKubrV6LSVVxfD2xknuypFN7Iz4hR349UbVYnEh
 CJ/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdEYlTM9czhmXREL1Dr7c1TO0NQsZqD8dV8j9ErlsYxftp3NlXvefOsEWTK7EML/CzEiAgXFoo36Wz@nongnu.org
X-Gm-Message-State: AOJu0Yx8mUlC5a7EO8AApz5F2jYo4UmrfQDdzoBL54xPOfpU2gYwmlwW
 ITL8bMhOk5gSNhnMWMvQY0vU3dxxY1k5e5ybSLVh7Lv4oIbkD0ux6h66N8mWnSBHF+I=
X-Gm-Gg: AeBDietbb1j0WBckJAav3l+VNHbzbxN7MdybcXKRnffWDX5ttqJeG3PiRvtIfGDJ7NB
 Qrv1w1NBiX0DBUpCCmOuU6c4Nu/pxRUKvvyxsNjcX9xlkEEPhdhOCCKL6PS6iue5Ioy8du0MC4F
 FJ75h6Sn17k2QcyBNZqJ6hufQ/ICM5Z7SirnYPGLDtQ9oK5BISllds1yCavu3G7SDwiW4BhK4Nj
 pfdP7ZvIEAnrHsrO0N8pXs/N3I1eY1RqgBxZxoTa81p1ZVxArdZlGBeLYWh4e674jbpwRg0E2fY
 ikpKVFzjfYWW1EPEbbmZAfz3V+i8ZyUZDBgp5WfZuqEER72Sw32bqIKmS5LtnXO9+kCCZdsQDPb
 OMDEg9DtCC6YX79S6L729WJynZlYvUOXgyNyigDFEYo/iyk7ooqV/43jr5KrJFcLeZrQGQVuidE
 bJAk06Qj5ItIYqJ9TSXMoAUXYQXEGDqUjW+1NFUxe1yjGTjCON9hq3MCYOB9PK
X-Received: by 2002:ad4:5d41:0:b0:89c:c3ac:e5c1 with SMTP id
 6a1803df08f44-8a7020bcf0fmr339834336d6.4.1775640804644; 
 Wed, 08 Apr 2026 02:33:24 -0700 (PDT)
Received: from [192.168.68.100] ([177.18.66.130])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596a0a522sm165827786d6.32.2026.04.08.02.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 02:33:23 -0700 (PDT)
Message-ID: <ccad0832-a4e8-4f7e-9972-297872e53436@ventanamicro.com>
Date: Wed, 8 Apr 2026 06:33:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] target/riscv: Implement Smsdid and Smmpt extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com
References: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf2c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Gentlemen,


This is fully reviewed and good to go.  Maybe needs a rebase since it
was last posted back in November.

Zhiwei, if you could please send a rebase keeping all acks that would be
terrific.


Cheers,
Daniel

On 11/12/2025 3:49 AM, LIU Zhiwei wrote:
> This patch set introduces support for the RISC-V Smmpt (Supervisor
> Memory-tracking and Protection Table) extension. Smmpt provides a
> hardware mechanism for fine-grained memory protection, checked after
> address translation, which is particularly useful for supervisor-level
> sandboxing and security monitoring.
> 
> The rfc patch set:
> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
> 
> v3->v4:
>      1. Add missing review tags.
> v2->v3:
>      1. Fix build error in patch 2.
>      2. Rebase to master.
> 
> rfc->v2:
>      1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>         CSR zero.
>      2. Add patch 5 to fix smrnmi ISA string order.
>      3. Fix patch 6 smmpt and smsdid ISA string order.
>      4. Make smmpt and smsdid experiment extensions.
>      5. Add review tags.
> 
> 
> LIU Zhiwei (6):
>    target/riscv: Add basic definitions and CSRs for SMMPT
>    target/riscv: Implement core SMMPT lookup logic
>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>    target/riscv: Implement SMMPT fence instructions
>    target/riscv: Fix smrnmi isa alphabetical order
>    target/riscv: Enable SMMPT extension
> 
>   target/riscv/cpu.c                            |   6 +-
>   target/riscv/cpu.h                            |   9 +-
>   target/riscv/cpu_bits.h                       |  27 ++
>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>   target/riscv/cpu_helper.c                     |  81 +++++-
>   target/riscv/csr.c                            |  95 ++++++
>   target/riscv/insn32.decode                    |   2 +
>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>   target/riscv/meson.build                      |   1 +
>   target/riscv/pmp.h                            |   3 +
>   target/riscv/riscv_smmpt.c                    | 274 ++++++++++++++++++
>   target/riscv/riscv_smmpt.h                    |  36 +++
>   12 files changed, 560 insertions(+), 6 deletions(-)
>   create mode 100644 target/riscv/riscv_smmpt.c
>   create mode 100644 target/riscv/riscv_smmpt.h
> 


