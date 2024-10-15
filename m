Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF1CFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 09:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0deZ-0007a8-Lj; Tue, 15 Oct 2024 05:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1t0deJ-0007Yv-OF
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:15:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1t0deH-00036N-Sf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 05:15:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so43886945ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728983724; x=1729588524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F8opm7t057LzY4iRHO+GNp/RhhIn4PkZKv4QKwyNAwk=;
 b=QVtGxqS/Wq06B6ZAHI13Wm1vWlbAaZBzFCpLBwzyepz41wUu4R1m7rwvju7S3KCCAD
 eDWT1w/fdFeBMeOXKo1jfnWaip+zx3086tAGfLcjxcIrKcgp7dvcA7roA5ce3G8OpegX
 zBwWp4pXb7fIDCrGbynU7kNqKXQ1oH+l8qjx6dpxeHLpmlpDZz4ZdxdWhJqH8akiWmw9
 NVeWdy63wc9NLn/14shjTakIRnoLeF9galram+8vxHRWCZ+jnh+0dcquoAcm60MLWpiR
 t5HhFC1QYEydR/ICIi1BRqpRRf7OrZEjtoOOhkksvO1XnDavKeDGmtM1T6Cpj8s3Zx7j
 fbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728983724; x=1729588524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8opm7t057LzY4iRHO+GNp/RhhIn4PkZKv4QKwyNAwk=;
 b=DI9iuuCl103uVOsJeTzS5qUOm2d8M7sUK1oMz33t1w4gpspH+svwGCVX/17tRt2QHD
 yLU/p8Y1YTsD10AL3M0x3oIxHbtqm3ZRul7SJFDi5FNYyFO+vLrxio34ha1DpFSdehcr
 u6is2cq1fcuAapEcE3LCNm5YQU6lPDvr5yrLmEpBRf8GiOc7QU95pY69nmAkqOeps3PX
 7//6cZIMmbp/qq0LRJojCowWJCfdmtN+AY0O1JfJrF1CZAy55N9yqFiAx4KI7v+Jc9Mu
 hBbBZ06UMZYGifnyo1EuY6Gfc6h85a2TJUZvSvrC3h159lmfuZkfxSVSD6GSHpS6hD44
 9NHg==
X-Gm-Message-State: AOJu0Yy8rYyddZhSaCdcqhQrj/3K54zb1unZwn4LyijzQ7Nbpos7XhAw
 Tn+TfyquG1cy4wiG0uDmnbwdZwVJAntP1Opkcgvzf9w9Y2nHOp/qmxXCEaMOaYzSQODwzttQAe+
 KBwGNPGr9+Ct7hKmvYS9+jZf+FGSU1cx4iNqek6heUpf2IciTHu4Zz4jlmm1HJcppBtPHBekGCO
 S/ElSu4MPGjd3gwkUjrGPKE57JDaTyU0Yjq5JJAdp1
X-Google-Smtp-Source: AGHT+IFhTOlkKLMD/KLOHwOJ9k5Y0d+CRgGLRYLn12K3lxTz01em1LD5PfhK3hXyC3luzVe7HQWepQ==
X-Received: by 2002:a17:903:2c7:b0:20c:c880:c3b0 with SMTP id
 d9443c01a7336-20cc880c9c7mr131998985ad.21.1728983723560; 
 Tue, 15 Oct 2024 02:15:23 -0700 (PDT)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm7912125ad.189.2024.10.15.02.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 02:15:23 -0700 (PDT)
Message-ID: <e166436d-85e1-4651-a603-35f043c2d7d3@sifive.com>
Date: Tue, 15 Oct 2024 17:15:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Improve the performance of RISC-V vector
 unit-stride/whole register ld/st instructions
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 negge@google.com
References: <20240918171412.150107-1-max.chou@sifive.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20240918171412.150107-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62b.google.com
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

ping.

On 2024/9/19 1:14 AM, Max Chou wrote:
> Hi,
>
> This version fixes several issues in v5
> - The cross page bound checking issue
> - The mismatch vl comparison in the early exit checking of vext_ldst_us
> - The endian issue when host is big endian
>
> Thank for Richard Henderson's suggestions that this version unrolled the
> loop in helper functions of unmasked vector unit-stride load/store
> instructions, etc.
>
> And this version also extends the optimizations to the unmasked vector
> fault-only-first load instruction.
>
> Some performance result of this version
> 1. Test case provided in
>      https://gitlab.com/qemu-project/qemu/-/issues/2137#note_1757501369
>      - QEMU user mode (vlen=128):
>          - Original:   ~11.8 sec
>          - v5:          ~1.3 sec
>          - v6:          ~1.2 sec
>      - QEMU system mode (vlen=128):
>          - Original:   ~29.4 sec
>          - v5:          ~1.6 sec
>          - v6:          ~1.6 sec
> 2. SPEC CPU2006 INT (test input)
>      - QEMU user mode (vlen=128)
>          - Original:  ~459.1 sec
>          - v5:        ~300.0 sec
>          - v6:        ~280.6 sec
> 3. SPEC CPU2017 intspeed (test input)
>      - QEMU user mode (vlen=128)
>          - Original: ~2475.9 sec
>          - v5:       ~1702.6 sec
>          - v6:       ~1663.4 sec
>
>
> This version is based on the riscv-to-apply.next branch(commit 90d5d3c).
>
> Changes from v5:
> - patch 2
>      - Replace the VSTART_CHECK_EARLY_EXIT function by checking the
>        correct evl in vext_ldst_us.
> - patch 3
>      - Unroll the memory load/store loop
>      - Fix the bound checking issue in cross page elements
>      - Fix the endian issue in GEN_VEXT_LD_ELEM/GEN_VEXT_ST_ELEM
>      - Pass in mmu_index for vext_page_ldst_us
>      - Reduce the flag & host checking
> - patch 4
>      - Unroll the memory load/store loop
>      - Fix the bound checking issue in cross page elements
> - patch 5
>      - Extend optimizations to unmasked vector fault-only-first load
>        instruction
> - patch 6
>      - Switch to memcpy only when doing byte load/store
> - patch 7
>      - Inline the vext_page_ldst_us function
>
> Previous versions:
> - v1: https://lore.kernel.org/all/20240215192823.729209-1-max.chou@sifive.com/
> - v2: https://lore.kernel.org/all/20240531174504.281461-1-max.chou@sifive.com/
> - v3: https://lore.kernel.org/all/20240613141906.1276105-1-max.chou@sifive.com/
> - v4: https://lore.kernel.org/all/20240613175122.1299212-1-max.chou@sifive.com/
> - v5: https://lore.kernel.org/all/20240717133936.713642-1-max.chou@sifive.com/
>
> Max Chou (7):
>    target/riscv: Set vdata.vm field for vector load/store whole register
>      instructions
>    target/riscv: rvv: Replace VSTART_CHECK_EARLY_EXIT in vext_ldst_us
>    target/riscv: rvv: Provide a fast path using direct access to host ram
>      for unmasked unit-stride load/store
>    target/riscv: rvv: Provide a fast path using direct access to host ram
>      for unit-stride whole register load/store
>    target/riscv: rvv: Provide a fast path using direct access to host ram
>      for unit-stride load-only-first load instructions
>    target/riscv: rvv: Provide group continuous ld/st flow for unit-stride
>      ld/st instructions
>    target/riscv: Inline unit-stride ld/st and corresponding functions for
>      performance
>
>   target/riscv/insn_trans/trans_rvv.c.inc |   3 +
>   target/riscv/vector_helper.c            | 598 ++++++++++++++++--------
>   2 files changed, 400 insertions(+), 201 deletions(-)
>


