Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1091606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nvQqRq+w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1Ux-0007H0-7k; Wed, 28 Oct 2026 07:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1Ur-0007Gc-AB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:07:11 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1Uo-0001Km-3Z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:07:08 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-84e513874f8so549171a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793185624; x=1793790424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HJejtr/3eRL/l22r9vqPt9cJkW1gl1rsWFtYSIu2rT0=;
 b=nvQqRq+wMkW/cjanDurdScA8zdJoWzkJqHVKxWmQ5yWmax1SAknncNe+RqVKK08WvO
 bk+UR2NlPSbD6WQsDhJ7PVIbCKUEHjlPfwwn9JERrRglxz+OyRoithSuYEgYysNLEKSi
 lmzq2QHPsuzpNt1VfmCdOH+Onnu9H8q+Ofbkw0sEq3EldWo8FJ5uH//rERRrLWQ8BqHG
 U2Np7pNBiSKfjXQeTR1YQ53kNZz3vvI7T6Dbec6MKQty+IdPbvRcKlKt/O194b5EhiSp
 mUU1t5NiZDYNYbWa6MueeX6S8yqNqIN0exSe61o++Sioy6mfmkdofqKQpRzvB67rVTk9
 JiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793185624; x=1793790424;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HJejtr/3eRL/l22r9vqPt9cJkW1gl1rsWFtYSIu2rT0=;
 b=OZHChT3+Rktpa0AVScxF09vhuNp2uKMdn33FtTT1sQgLdZIFp4caZ1FjbT8SeGujJL
 V9/kJchHlHL4bj4tpPhYB/jurb7KNvhVUCYCaty3yqjMRb1/H1iQSQoBeDnnbReNwQVO
 cJg+X92T9ul3hveAT2kDp2Bmr7wceS3nLfGqzJ1uKAjZnXfjTrJsBk01trkpQCENfgaZ
 M5o+wE6Ink49PW4Vnu6PGX5IsoHZ49yA/K6Ugk+5Ny+RoeyuOKhoGxTkUp0YU1AlqPYN
 PWyAbRELDf9zwtp7dzt/cGuLS2B+p+ZVnuaDjPFgysntKRDqZWJAg7n7+v26NiRMmvZn
 soCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRYg+4OjVfxIPW5H6eX/Fh0wmFucpV9oMQUccWV5+Sl46PAq4wR24zcilYHv58+5XMY4UpeOkAz6WL@nongnu.org
X-Gm-Message-State: AFq9FYLhjdgw/nUQ7WN54pwXHZ3vgopIFKYjUsVwkz5L9fIXlehee4UP
 OPqEhgoHQm054DtSOQy07xK4TfroYOsBOfCuFvXBoF5s49fDqFkWhsC6ydWydfdXo4g=
X-Gm-Gg: AYBFou2jXLYxpIQHncWVDUGv3ruvk8gxVu7bdywNQd+z1Iw1+pj/0OQ3cYM7QxTSfb9
 GdEbIw7MnzkqcSkPyCyMJUZC35LULByEGIfK4KXZ0EtxEa8w+sWaXS2id+ouoLg6Nz8Se/qOXOw
 YYB/fDrCAvBBGD2QZK70O7QZ9SywUEFmnFMdfU5XcuflQhBlsLh4DGiIVbjGdYvsDzpq6fustsk
 CMS+2hxy3a00mEHyACnmCDiptePfq7FMShVHkwlmlmKg/XHdSklt9M34NZ9Iew7JsSV93OWV20S
 bbmnDkEUb0/9Cw8JwZMm73yuCcCFh2x8CdUfSQ6VbZvXG/5d+b6K21XdSvyZcNsp4hnln7vy6PI
 +kTRxl1x5KyTapF4x1+JcbeUgch+eYJVv3s3dotIljS4PfynolZyBfI4KGjbBUPuSjY9wumzR68
 9ntI0Jm2NsbdTDD/mkNtrijyJCIOzj21RiiB9ZvyDJynNWJIEBtmknRF7zynJlq/XIZA3ntsCYz
 EXi07TJ+Dbqw/n+lW5FmehUN03eu/MouR1J1eKHhLI8AelZFyyTCFyCWs66fc0oq3EWTgfi4KY2
 zpb5/lNr6vKFQtWVMjqB3cb3qo4ou1JPt9epfP5q9QYg
X-Received: by 2002:a05:6808:14c5:b0:4c3:6c2:4f29 with SMTP id
 5614622812f47-563821820e6mr1125075b6e.16.1793185623724; 
 Wed, 28 Oct 2026 04:07:03 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b788a09csm2193636fac.10.2026.10.28.04.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 04:07:03 -0700 (PDT)
Message-ID: <36b2a947-c00b-4ea2-805b-d755303f0923@linaro.org>
Date: Wed, 28 Oct 2026 06:07:01 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: For linux-user, prioritize PC misalignment
 fault over insn abort
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261026140942.2768950-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026140942.2768950-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 09:09, Peter Maydell wrote:
> The Arm architecture requires that for PC alignment fault exceptions
> take precedence over Instruction Abort exceptions.  We get this wrong
> for linux-user mode, because QEMU detects the lack of any backing
> memory via probe_access_internal(), and calls
> arm_cpu_record_sigsegv(), which always reports either a Translation
> or Permission fault:
> 
> #3  0x0000649548976b94 in arm_deliver_fault (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, mmu_idx=0, fi=0x7fff87e4c940)
>      at ../../target/arm/tcg/tlb_helper.c:274
> #4  0x0000649548976d69 in arm_cpu_record_sigsegv (cs=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
>      at ../../target/arm/tcg/tlb_helper.c:421
> #5  0x0000649548c97650 in cpu_loop_exit_sigsegv (cpu=0x649555ce5920, addr=1, access_type=MMU_INST_FETCH, maperr=true, ra=0)
>      at ../../linux-user/signal.c:761
> #6  0x00006495488f8235 in probe_access_internal (env=0x649555ce99a0, addr=1, fault_size=1, access_type=MMU_INST_FETCH, nonfault=false, ra=0)
>      at ../../accel/tcg/user-exec.c:790
> #7  0x00006495488f850d in get_page_addr_code_hostp (env=0x649555ce99a0, addr=1, hostp=0x7fff87e4ca70) at ../../accel/tcg/user-exec.c:828
> #8  0x00006495488e5433 in get_page_addr_code (env=0x649555ce99a0, addr=1) at ../../accel/tcg/internal-common.h:116
> #9  0x00006495488e56bd in tb_htable_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:206
> #10 0x00006495488e58c8 in tb_lookup (cpu=0x649555ce5920, s=...) at ../../accel/tcg/cpu-exec.c:251
> #11 0x00006495488e5d2a in helper_lookup_tb_ptr (env=0x649555ce99a0) at ../../accel/tcg/cpu-exec.c:398
> #12 0x00007d973c000270 in code_gen_buffer ()
> 
> Make arm_cpu_record_sigsegv() report a PC alignment fault for
> MMU_INST_FETCH accesses to non-4-aligned addresses for A64 and A32,
> matching the logic used in arm_cpu_tlb_fill_align() for system
> emulation.  (Unaligned PC faults can't happen for Thumb.) This is
> then passed to the guest binary as SIGBUS rather than SIGSEGV.
> 
> (The Fixes tag is for the commit that introduced this function, but
> the bug was also present in the previous implementation.  It's an odd
> corner case so it's not worth the effort to try to backport the fix
> beyond that.)
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 9b12b6b44250c2 ("target/arm: Implement arm_cpu_record_sigsegv")
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4699
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/tlb_helper.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

