Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DD1C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM14w-0006r6-KL; Tue, 25 Jun 2024 03:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM14v-0006qU-OV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:59:01 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM14u-0007zK-3R
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:59:01 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c85f11143fso1715024a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719302338; x=1719907138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J5EWQDpYPjghYw2Z/VvVN0nVOQLNpy4Ko5kctFLpJcI=;
 b=lQLA+5luPkaLUOqDZ5uIEmJIJPWblub8/hGFIudGOfjnxXZy+c3Sg0ppsRKzdsERtF
 IbDcONhH5MVDwQrHWuB53QilwpYC6MLSzp7GxOdWhqx120rA9mfCteKGaH/9N4fg0cS8
 oLtW0VfOOoOIaAK1XquyJnVGTqSJWmUQt2ZDElG8w4m9qTU5uBdnaSkEis3+VBFCzZQL
 JFRCZkbGmIpX168N6gzcZc/Ucp4ediiN79pP4Ng6E0QtzicHNvMdcsizB8Ll8DBUUJj1
 04xJbRrZKqdUkQU+NJJtsCBnxe+lk60nIWdugwV2ynw1pu9nwsTeoo2SONMHw1ABLmzR
 zxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719302338; x=1719907138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5EWQDpYPjghYw2Z/VvVN0nVOQLNpy4Ko5kctFLpJcI=;
 b=CA0vc798HqLE6YPYYFWlXMesd7FxiqpxtuJnsVmTw5dhF4dMiEXSwx6wU7mZf0GQ/2
 KUSV9ybyfgAkY8GsWWNpAis3nJXVkIgJO5ogF8FZefeNMzajyYu76I9GxOEVDeaD+lIP
 Nl4W3R9RbFO9jOlaUa7ZbK4Bayx3ePfvf8VESdmQxi8C3DAuIk7Mfs0zjhIrYGisILjP
 a4VMhHX7PYDr/NSiujmy8p1xXilyWgKZT5rPUrfCjzafgvFvjZ9f1oRbbmWlBxQY41LA
 WlfyDyGoi8rdR1Y7ErQwmImnn9BOqzLvP4INj7wKaRT0sccdILJRZDMmEqqQCdLrve0y
 CbAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1P3GgPPdlCJ50MnHt+5Dz9lZ7LLlyFkzR3Ikt+DlFY3pXKB/Y9uANgHotFQTUVTH+wxpoVBj9Bf5BGWZ/8/Lslkh4Ukg=
X-Gm-Message-State: AOJu0YwDOM/2x1DtCvqUZszqFh7ypaacnVvpzy5u9DrKY8W375gqEV7Y
 R0rgXfKxHU0mvMiQtomjpl/XcZPH42JlLzJPO0OsCWoos32Dxt1m2d2AnSq460I=
X-Google-Smtp-Source: AGHT+IFNKSLOYYYzl98eLjVBqfDLfAJHUoxJ4Llvi+DWTGxBZPzbaBvHw1Jacvbbu2yKEOkaEa9ytQ==
X-Received: by 2002:a17:90a:b97:b0:2c4:e2a6:dcd3 with SMTP id
 98e67ed59e1d1-2c861297efbmr6351656a91.6.1719302337656; 
 Tue, 25 Jun 2024 00:58:57 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e4f03c4esm10248269a91.6.2024.06.25.00.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 00:58:57 -0700 (PDT)
Message-ID: <9831c088-f683-4483-9c40-84d7a80e8989@sifive.com>
Date: Tue, 25 Jun 2024 15:58:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/riscv: Remove obsolete sfence.vm instruction
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-2-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240619152708.135991-2-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x102b.google.com
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

Reviewed-by: Jason Chien <jason.chien@sifive.com>

On 2024/6/19 下午 11:27, Rajnesh Kanwal wrote:
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/insn32.decode                     | 1 -
>   target/riscv/insn_trans/trans_privileged.c.inc | 5 -----
>   2 files changed, 6 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..9cb1a1b4ec 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -112,7 +112,6 @@ sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
>   wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> -sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>   
>   # *** RV32I Base Instruction Set ***
>   lui      ....................       ..... 0110111 @u
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index bc5263a4e0..4eccdddeaa 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -127,8 +127,3 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>   #endif
>       return false;
>   }
> -
> -static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
> -{
> -    return false;
> -}

