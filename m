Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE33C83F1F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 09:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZo12-0000S9-BD; Thu, 10 Jul 2025 05:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uZnzF-0006o0-8M
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:54:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uZnzC-0007J7-1K
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:54:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso8065495ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752141274; x=1752746074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJg4WSYrQHjETrUf2KavmlU1YGq16aOu4ZszPF3KCj0=;
 b=oao8Qt0LROlvmJ8U/aw6GZNWoMPtTPflYt7Ar4EGszmwfJGtXVmLS4VIK2AelsuMvQ
 pakClfaPpkl/+fF0XCMjb0L4PdV6gUvdz2wN9Ibk5PRmMnbU+XlHlrvamiYVfa1uC7rw
 0x0KiHYEO7qXKB+Cjysczmm857HlSCGXjrSr2nbo9AeXdn71KId1UjGPG1ky+fb4gREz
 O3/HDmmF36JF5Ail4sWk5oaDJXsSDQOgDU6UPogsyA6ZtquRmV8jp7XtU1GwTYqMz2YG
 E7Rd+AMnVubkIKzH8M7mNCzf+PS5ZPyBRWZTuwQxWhGPZnEXs+8JyxE32KraeC5fhV5H
 wD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752141274; x=1752746074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJg4WSYrQHjETrUf2KavmlU1YGq16aOu4ZszPF3KCj0=;
 b=wvh3osBr/nGHC9RdeoJAIpcYS1RQnKoeOMd6j/Ly7yFeJFGRbW1FqermapdwC9w+8F
 iVPcGjVigqVK2vuz+S+x8gisIkJQqX73FlHhtrYgTPQNOc8d+/XRqXoRvX9j98vAOjLz
 j2y4hvQh6fdnRhTdDpKn/HEnf52xoBXyS3fOVPKwZh/vFX2uD5SWnmF5zDPZjxE3DM3h
 PYGjSHn6HzVYbEAiqD0DPAzi9osaqcr3AtMtlgsIT9ozn8fuTfCMhno0jI5WFkXOta+s
 Q/w8R3/c118xEzny02/k8oTiijScxL5gkwRmJG4X4zzmsFmQNoAcFbE6fWhdMQc4AvzX
 EH9A==
X-Gm-Message-State: AOJu0Yz8KaQgyd93kgmABDhjZ7u8jjno9omurGoW7hznwq+osriLHxBZ
 QA0MWKuxlO8p36qvOf4cVTAFmTVLwROielk9MORdn4PU/jZ5uGRX6P/KrkkjNJcz3Vc=
X-Gm-Gg: ASbGnctk0BmqGYwffbNMUZhYFaubt4JAwPVfmIUgtzpCCDjJFS8u1Bm2yv43mAjCIee
 aQHZSyhJMuQ8UGf3i0wgdpJ14k+C6G+5fFgZOkLOTOKN4DdJQL3DLDIpOQ7ZYflhoR1uk3sTsEf
 vSxP15IX4GCwZVet66EyjJZPnoGAa7EjSiwBLWvv+7ph10R2DV7jQXEt5IG+P6BzxUI/lc+J/UI
 TQ+Sl19/9SMS+WZbZHsSoRxXyBbY9ugyBgM3OuWTHqho9dfGhtNJBbTuEn/Tr136ro/Abgs25NY
 xGuk0c8Lcf396dI/+kq0IrX6h7tCGCLt3OSBrD85RQi12kq4LKBT7zShxT8nfSTZtDr04F2S7s7
 sPQ==
X-Google-Smtp-Source: AGHT+IHE8rbuYLVnXctw/+JjcVdPpGZVNVmo8fTxkb6m9ETANvIcdo9MBkCuioZpduuF1HYu0bQ1rA==
X-Received: by 2002:a17:903:198e:b0:234:9497:69e3 with SMTP id
 d9443c01a7336-23ddb2e62e7mr92367265ad.25.1752141274657; 
 Thu, 10 Jul 2025 02:54:34 -0700 (PDT)
Received: from [192.168.68.110] ([189.110.107.157])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4331900sm15404905ad.150.2025.07.10.02.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 02:54:33 -0700 (PDT)
Message-ID: <9ded37cf-cf57-4b6a-aeb7-6edf8ea1d7f2@ventanamicro.com>
Date: Thu, 10 Jul 2025 06:54:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 v2] [RISC-V/RVV] Generate strided vector loads/stores
 with tcg nodes.
To: Eric Biggers <ebiggers@kernel.org>,
 Paolo Savini <paolo.savini@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Jeremy Bennett
 <jeremy.bennett@embecosm.com>, Craig Blackmore
 <craig.blackmore@embecosm.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250312155547.289642-1-paolo.savini@embecosm.com>
 <20250312155547.289642-2-paolo.savini@embecosm.com>
 <20250710052824.GA608727@sol>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250710052824.GA608727@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Eric,


Thanks for the bug report and the simple reproducer.

Paolo, I'll send a revert since we don't want to keep Linux broken and to give
you more time to adequately fix the patch. You can then re-send it as a v3 in
the ML.


Thanks,

Daniel


On 7/10/25 2:28 AM, Eric Biggers wrote:
> Hi,
> 
> On Wed, Mar 12, 2025 at 03:55:47PM +0000, Paolo Savini wrote:
>> This commit improves the performance of QEMU when emulating strided vector
>> loads and stores by substituting the call for the helper function with the
>> generation of equivalent TCG operations.
>>
>> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++++++++++++++++++----
>>   1 file changed, 273 insertions(+), 50 deletions(-)
> 
> This recent QEMU patch broke the RISC-V vector optimized ChaCha20 code
> in the Linux kernel.  I simplified the reproducer to the following,
> which had its behavior changed:
> 
> rvv_test_func:
> 	vsetivli	zero, 1, e32, m1, ta, ma
> 	li		t0, 64
> 
> 	vlsseg8e32.v	v0, (a0), t0
> 	addi		a0, a0, 32
> 	vlsseg8e32.v	v8, (a0), t0
> 
> 	vssseg8e32.v	v0, (a1), t0
> 	addi		a1, a1, 32
> 	vssseg8e32.v	v8, (a1), t0
> 	ret
> 
> Before this patch, it copied 64 bytes from a0 to a1.  After this patch,
> the bytes at 32..47 also incorrectly get copied to 16..31.
> 
> Please fix this, or else revert the patch.
> 
> - Eric


