Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8171AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBCy-0001ct-5v; Thu, 22 Aug 2024 13:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shBCx-0001br-AF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:02:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shBCv-0005Do-EE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:02:47 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-714262f1bb4so983048b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724346163; x=1724950963;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NZQTHQlNOXGofqG6G94jRhtGL2mFIdG4SVzRtdrRP+k=;
 b=1GUST0ArCSw2zTYKR98si4IBr9gnFoADZyaNXN2N38ft4Z/3hSOyORxq6TLrVjpnte
 JSJA7jt8Qdso0QmDpUhek1w6PUFYXt7s5BHHoNOp8O7BN44c+K0ltARhjCg63EyXwveH
 2UpTjbj8tETxCNRFp0UjWGdGRBA0ONPcv55JK5v2pvAsF00WEBr4bv0KOrtxQDehVOfm
 68cLx+fQ2h/E8zkOPvxU/vJAIn7zxvWGqGekMoRbOz0dFSBALaEYcodTPplw2k9M98sQ
 46D1XqncG57O3KkXZrJ1a4GrRIMyv5hr//Rvv1C/hOP3YclhXDPbjBHyNeCOozHvcSqP
 BUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724346163; x=1724950963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZQTHQlNOXGofqG6G94jRhtGL2mFIdG4SVzRtdrRP+k=;
 b=bwfHJ2y2d+vgXeqq7u20ASe1eqSflAjEpAcZzWFDWLCdZwfIXocykdPEXFVl01EfqV
 wS8pdT6UlnIGqb4ZOWbSCoemjQUE7RUr01cy4bhFsv4Wp+ZZd7FKWBVsDrbJ1KB2rSfU
 VoFglAi3VVVhPRu9LpBBveL05NL2KPobDtO59EX92R92qyRSR8o77OrMCk7xJW1zirl0
 cQU7+TKXa0iCMR9jfKrjgpUcKm5fe2Ks7T1L0C8TQeyLxAHn/K/UpIlfuJCE/8+FAn2x
 Ptu2/rdj5bLYLeQ4QilpyqlzixLWoG7RgG+SQ/zaVJN/ZPc90alT4sJWsurckbvjAiEh
 qEGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz7E3DDNeLEO+iZCzOMZV5b4MJ0P5uY35WTRqLWw1XydKyb44KE0e5xaMwKbdBiYP8yqBzEBY7EglY@nongnu.org
X-Gm-Message-State: AOJu0YxiZRappMwRvlch5LHObBhLYpQbhJ4Gw+UkRhfDS0AWDTqZcYSa
 XbVnQJV44fagKV3dacHSTJ3ydlsEV29SQbAG8T+ffaTGz26nJ85LCljRmtMG0OM=
X-Google-Smtp-Source: AGHT+IGZOLtbv4rDRhZMn0eFlyUDsLt5LTV/2dSMWNsE4IGDNk35mztpRRUp+jIeiVDAvQ+gyFHTqA==
X-Received: by 2002:a05:6a21:9210:b0:1c4:87f5:995d with SMTP id
 adf61e73a8af0-1caeb37afd8mr2614914637.54.1724346163265; 
 Thu, 22 Aug 2024 10:02:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430a260sm1606170b3a.157.2024.08.22.10.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 10:02:42 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:02:40 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v7 13/17] target/riscv: update `decode_save_opc` to store
 extra word2
Message-ID: <ZsdvMOyiox2pGmtg@debug.ba.rivosinc.com>
References: <20240822082504.3979610-1-debug@rivosinc.com>
 <20240822082504.3979610-14-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240822082504.3979610-14-debug@rivosinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 22, 2024 at 01:24:59AM -0700, Deepak Gupta wrote:
>Extra word 2 is stored during tcg compile and `decode_save_opc` needs
>additional argument in order to pass the value. This will be used during
>unwind to get extra information about instruction like how to massage
>exceptions. Updated all callsites as well.
>
>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>---
> target/riscv/insn_trans/trans_privileged.c.inc |  8 ++++----
> target/riscv/insn_trans/trans_rva.c.inc        |  4 ++--
> target/riscv/insn_trans/trans_rvd.c.inc        |  4 ++--
> target/riscv/insn_trans/trans_rvf.c.inc        |  4 ++--
> target/riscv/insn_trans/trans_rvh.c.inc        |  8 ++++----
> target/riscv/insn_trans/trans_rvi.c.inc        |  6 +++---
> target/riscv/insn_trans/trans_rvvk.c.inc       | 10 +++++-----
> target/riscv/insn_trans/trans_rvzacas.c.inc    |  4 ++--
> target/riscv/insn_trans/trans_rvzfh.c.inc      |  4 ++--
> target/riscv/insn_trans/trans_svinval.c.inc    |  6 +++---
> target/riscv/translate.c                       | 11 ++++++-----
> 11 files changed, 35 insertions(+), 34 deletions(-)
>
>
>@@ -1096,7 +1097,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>         mop |= MO_ALIGN;
>     }
>
>-    decode_save_opc(ctx);
>+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>     src1 = get_address(ctx, a->rs1, 0);
>     func(dest, src1, src2, ctx->mem_idx, mop);
>
>@@ -1110,7 +1111,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
>     TCGv src1 = get_address(ctx, a->rs1, 0);
>     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>
>-    decode_save_opc(ctx);
>+    decode_save_opc(ctx, 0);

Note for myself. I missed this one to set `RISCV_UW2_ALWAYS_STORE_AMO`
Will wait for other feedback and fix it in v8.

>     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
>
>     gen_set_gpr(ctx, a->rd, dest);
>-- 
>2.44.0
>

